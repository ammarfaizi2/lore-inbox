Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbTIPGkd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 02:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbTIPGkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 02:40:33 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:61650 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261170AbTIPGkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 02:40:31 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Yu Chen <dychen@stanford.edu>
Date: Tue, 16 Sep 2003 16:40:12 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16230.45132.727984.324258@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
In-Reply-To: message from David Yu Chen on Monday September 15
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday September 15, dychen@stanford.edu wrote:
> Hi All,
> 
> I'm with the Stanford Meta-level Compilation research group, and I
> have a set of memory leaks on error paths for the 2.6.0-test5 kernel.
> (I also have error reports for 2.4.18 and a couple other kernels if
> anyone is interested).
> 
> There may be one or more "GOTO -->" markers showing the different
> paths of execution that can occur between where the memory is
> allocated and where the function returns.
> 
> My checker identifies error paths with a learning algorithm on
> features surrounding goto and return statements.  I'd greatly
> appreciate any comments or confirmation on these bugs.
> 
> Thanks!

The nfsd/nfsctl.c one isn't actually a bug (though I had to think
about it a bit to be sure).

One of the "... DETELED 4 lines ..." is

		file->private_data = ar;

which takes a copy of "ar" into a structure that has a lifetime
greater than the function.
So when the "return -EFAULT" happends (at END -->), at is stored in
file->private_data, and a subsequent call to TA_release will free that
memory.

NeilBrown


> 
> [FILE:  2.6.0-test5/fs/nfsd/nfsctl.c]
> [FUNC:  TA_write]
> [LINES: 105-120]
> [VAR:   ar]
>  100:	if (file->private_data) 
>  101:		return -EINVAL; /* only one write allowed per open */
>  102:	if (size > PAGE_SIZE - sizeof(struct argresp))
>  103:		return -EFBIG;
>  104:
> START -->
>  105:	ar = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  106:	if (!ar)
>  107:		return -ENOMEM;
>  108:	ar->size = 0;
>  109:	down(&file->f_dentry->d_inode->i_sem);
>  110:	if (file->private_data)
>         ... DELETED 4 lines ...
>  115:	if (rv) {
>  116:		kfree(ar);
>  117:		return rv;
>  118:	}
>  119:	if (copy_from_user(ar->data, buf, size))
> END -->
>  120:		return -EFAULT;
>  121:	
>  122:	rv =  write_op[ino](file, ar->data, size);
>  123:	if (rv>0) {
>  124:		ar->size = rv;
>  125:		rv = size;
