Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264173AbTDWSDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbTDWSDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:03:33 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:14228 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S264173AbTDWSDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:03:30 -0400
Date: Wed, 23 Apr 2003 14:15:30 -0400
To: Yours Lovingly <ylovingly@yahoo.co.in>
Cc: Bryan Henderson <hbryan@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Qn: Queer "Unable to handle kernel NULL pointer dereference at ..." error in kernel
Message-ID: <20030423181530.GA8584@delft.aura.cs.cmu.edu>
Mail-Followup-To: Yours Lovingly <ylovingly@yahoo.co.in>,
	Bryan Henderson <hbryan@us.ibm.com>, linux-kernel@vger.kernel.org
References: <OFAFB946CE.4BD085AE-ON87256D10.006801CE-88256D10.00683E0D@us.ibm.com> <20030423175333.7272.qmail@web8005.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423175333.7272.qmail@web8005.mail.in.yahoo.com>
User-Agent: Mutt/1.5.3i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 06:53:33PM +0100, Yours Lovingly wrote:
> i am sorry for that useless information. i am
> attaching  a ksymoops output of that problem (focus on
> the register operation (that ksymoops identifies as
> the fault triggering instruction) in the "code"
> section at the end of the ksymoops output)
...
> 		inode_parent = parent->d_inode;
> 		inode = d->d_inode;
> 		p = (void *)inode_parent;
> 		me = (void *)inode;
> // Till here things work just fine. I am DEAD SURE of that as i put printk()
> // followed by return here and there and checked.
> 
> 		if( p - me != 0 ) {
> 			//nfs_print_path(parent);
> 			printk("return 3\n");
> 			return;
> 		}

What I typically do in these cases is,

- remove the object file where the oops occurs
- rerun make
- copy the gcc line that is responsible for compiling the object
- run the same gcc line again, but add a '-g' flag

Now we have an object with debugging symbols, and can use 'objdump
--source <file>.o | less' and get something that has both the source
lines and the related assembly code. In this case the faulting
instruction is about 0x2e bytes past the beginning of nfs_print_path.

But I can get pretty far just from reading the oops and it is probably
the test you added. Ok, it looks like -O2 is actually optimizing away
some of those intermediate variables for you.

> Code;  c88b6956 <[nfs]nfs_print_path+2e/58> <=====
>    0:   39 42 08                  cmp   %eax,0x8(%edx)   <=====
>    3:   74 0d                     je     12 <_EIP+0x12>

Ok, so we're comparing the contents of %eax to something that is 8 bytes
offset from the address stored in %edx. and then jump out if they are
equal.

So this is something like and if (eax != edx->bar) { } construct. And in
fact the test you added was

    if ( p - me != 0 )
    if ( p != me )
    if ( inode_parent != inode )
    if ( parent->d_inode != d->d_inode )

So the contents of either parent->d_inode or d->d_inode was stored in
register eax, and we're dereferencing the other pointer during the test
operation.

Why does it crash, because the pointer we are dereferencing is 0x7, not
really a valid address, in fact it already looks like an inode number.

> eax: 00000006   ebx: c6675024   ecx: 00000001   edx: 00000007

And eax looks pretty suspicious as well. These are not pointers to inode
structures, but possibly the i_ino numbers.

Jan

