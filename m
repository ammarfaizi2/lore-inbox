Return-Path: <linux-kernel-owner+w=401wt.eu-S1750848AbXAKQrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbXAKQrU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 11:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbXAKQrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 11:47:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47343 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbXAKQrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 11:47:18 -0500
Message-ID: <45A669F1.2050602@poochiereds.net>
Date: Thu, 11 Jan 2007 11:46:41 -0500
From: Jeff Layton <jlayton@poochiereds.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Eric Sandeen <sandeen@redhat.com>
CC: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       esandeen@redhat.com, aviro@redhat.com
Subject: Re: [PATCH 2/3] change libfs sb creation routines to avoid collisions
 with their root inodes
References: <200701082047.l08KlDCa001921@dantu.rdu.redhat.com> <20070110212215.GB4425@infradead.org> <45A55FE5.80907@redhat.com>
In-Reply-To: <45A55FE5.80907@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen wrote:
 > Christoph Hellwig wrote:
 >
 >>>  		return -ENOMEM;
 >>> +	/* set to high value to try and avoid collisions with loop below */
 >>> +	inode->i_ino = 0xffffffff;
 >>> +	insert_inode_hash(inode);
 >> This is odd.  Can't we just add some constant base to the loop below?
 >>
 > I thought the same thing, but Jeff pointed out that
 > nfsctl_transaction_write does ops based on inode numbers, and they maybe
 > can't move around?
 >
 >         rv =  write_op[ino](file, data, size);
 >
 > However, nfsd's call to simple_fill_super already sends in a set of
 > files starting at inode 2:
 >
 > enum {
 >         NFSD_Root = 1,
 >         NFSD_Svc,
 > ...
 >
 >         static struct tree_descr nfsd_files[] = {
 >                 [NFSD_Svc] = {".svc", &transaction_ops, S_IWUSR},
 > ...
 >         return simple_fill_super(sb, 0x6e667364, nfsd_files);
 >
 > which does...
 >
 >       for (i = 0; !files->name || files->name[0]; i++, files++) {
 >                 if (!files->name)
 >                         continue;
 > ...
 >                 inode->i_ino = i;
 >
 > So I think it's already expecting the root inode at one, and the other
 > files starting at 2?
 >

Very interesting -- I saw that nfsctl depended on certain values for i_ino,
but I didn't notice that it had reserved the first slot for NFSD_Root. The
only other caller of simple_fill_super that seems to depend on the inode
numbers is selinuxfs, and that one has this:

enum sel_inos {
         SEL_ROOT_INO = 2,

...so it looks like we can probably use 1 for the root inode (though we might
want to fix selinuxfs to set SEL_ROOT_INO = 1). I'll have a closer look to be
sure that this is all correct and respin this patch since that seems like it
would be less magic-number-y.

Thanks,
Jeff
