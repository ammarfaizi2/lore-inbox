Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932658AbVJ0WD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbVJ0WD4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbVJ0WD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:03:56 -0400
Received: from pop-canoe.atl.sa.earthlink.net ([207.69.195.66]:64985 "EHLO
	pop-canoe.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S932658AbVJ0WDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:03:54 -0400
From: Eric Bambach <eric@cisu.net>
Reply-To: eric@cisu.net
To: prw@ceiriog1.demon.co.uk
Subject: Re: HFSPlus ate my free space!
Date: Thu, 27 Oct 2005 17:04:04 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <1130151525.16253.2.camel@desdemona.pd.rpd.hpa.org.uk>
In-Reply-To: <1130151525.16253.2.camel@desdemona.pd.rpd.hpa.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510271704.04941.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 October 2005 05:58 am, Peter Wainwright wrote:
> >Hi Roman,
> >
> >I am using hfsplus (journalled) to mount a 10Gb partition on an usb
> >attached disk.  I then copy a 3.5Gb file to the partition, then umount,
> >and mount again, and then delete it, but the space occupied by the file
> >is not freed, and doing that two times in a row ends up filling up the
> >space and I get an error that there is no space left.  Here are steps
>
> to
>
> >reproduce:
>
> I have had a similar experience with my (Mac) IPOD.
> I am using kernel-2.6.12 from Fedora Core 4 on x86, but it is
> just possible that this bug is still around in the latest
> development kernels.
> fsck_hfs reveals lots of temporary files accumulating in
> the hidden directory "\000\000\000HFS+ Private Data".
> According to the HFS+ documentation these are files which
> are unlinked while in use.  However, there may be a bug in
> the Linux hfsplus implementation which causes this to happen
> even when the files are not in use. It looks like the
> "opencnt" field is never initialized as (I think) it should
> be in hfsplus_read_inode.  This means that a file can appear
> to be still in use when in fact it has been closed. This patch
> seems to fix it for me:
>
> diff -U3 -r linux-2.6.12-old/fs/hfsplus/super.c
> linux-2.6.12/fs/hfsplus/super.c
> --- linux-2.6.12-old/fs/hfsplus/super.c 2005-06-17 20:48:29.000000000
> +0100
> +++ linux-2.6.12/fs/hfsplus/super.c     2005-10-23 21:15:24.000000000
> +0100
> @@ -50,6 +50,7 @@
>         init_MUTEX(&HFSPLUS_I(inode).extents_lock);
> HFSPLUS_I(inode).flags = 0;
>         HFSPLUS_I(inode).flags = 0;        HFSPLUS_I(inode).rsrc_inode =
> NULL;
>         HFSPLUS_I(inode).rsrc_inode = NULL;+
> atomic_set(&HFSPLUS_I(inode).opencnt, 0);
> +       atomic_set(&HFSPLUS_I(inode).opencnt, 0);
>         if (inode->i_ino >= HFSPLUS_FIRSTUSER_CNID) {
>         read_inode:
>
> Caveat: I'm no expert on filesystems (I thought a bit of bug-squishing
> would be a learning experience), and this is my first post
> to the kernel list, so feel free to flame me gently if this is wrong...
> Peter Wainwright
>
Hi,

 One, your mailer ate the patch. Please attach or make sure your mailer isn't 
wrapping lines. Two, try to CC the appropriate maintainer or else this patch 
will probably get lost in the noise.

 Consider yourself lightly flamed :)

--
Eric
