Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264048AbUDWLEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbUDWLEo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 07:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264780AbUDWLEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 07:04:43 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:9883 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264048AbUDWLEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 07:04:41 -0400
Date: Fri, 23 Apr 2004 12:04:37 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Szakacsits Szabolcs <szaka@sienet.hu>
cc: Dave Jones <davej@redhat.com>, linux-ntfs-dev@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: NTFS null dereference x2
In-Reply-To: <Pine.LNX.4.21.0404171505580.30107-100000@mlf.linux.rulez.org>
Message-ID: <Pine.SOL.4.58.0404231202310.3112@yellow.csi.cam.ac.uk>
References: <Pine.LNX.4.21.0404171505580.30107-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Apr 2004, Szakacsits Szabolcs wrote:
> Dave Jones <davej@redhat.com> wrote:
> > if vol is NULL, everything falls apart..
>
> AFAIS, neither vol nor vol->sb can be NULL below. The !vol check, that
> fooled you or an automatic checker, is bogus and probably it slipped
> through the user space library, thanks.
>
> Please note, by the patch you would introduce a real bug when you
> dereference the now uninitialized sb to assign a value to block_size.

Thanks.  While at present vol nor vol->sb can be NULL, I have changed the
code in my tree to do the assignments after the checks for completeness
sake.  I of course also moved the assignment that the patch ignored as
well, otherwise as Szaka said, it would all go horribly wrong...

Best regards,

	Anton

> > --- linux-2.6.5/fs/ntfs/attrib.c~     2004-04-16 22:45:53.000000000 +0100
> > +++ linux-2.6.5/fs/ntfs/attrib.c      2004-04-16 22:46:47.000000000 +0100
> > @@ -1235,16 +1235,19 @@
> >       u8 *al_end = al + initialized_size;
> >       run_list_element *rl;
> >       struct buffer_head *bh;
> > -     struct super_block *sb = vol->sb;
> > +     struct super_block *sb;
> >       unsigned long block_size = sb->s_blocksize;
> >       unsigned long block, max_block;
> >       int err = 0;
> > -     unsigned char block_size_bits = sb->s_blocksize_bits;
> > +     unsigned char block_size_bits;
> >
> >       ntfs_debug("Entering.");
> >       if (!vol || !run_list || !al || size <= 0 || initialized_size < 0 ||
> >                       initialized_size > size)
> >               return -EINVAL;
> > +     sb = vol->sb;
> > +     block_size_bits = sb->s_blocksize_bits;
> > +
> >       if (!initialized_size) {
> >               memset(al, 0, size);
> >               return 0;

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
