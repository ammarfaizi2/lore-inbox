Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286230AbRL0Jg3>; Thu, 27 Dec 2001 04:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286229AbRL0JgT>; Thu, 27 Dec 2001 04:36:19 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:26127 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S286227AbRL0JgC>; Thu, 27 Dec 2001 04:36:02 -0500
Message-ID: <3C2AEADB.24BEFE94@zip.com.au>
Date: Thu, 27 Dec 2001 01:33:15 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andersg@0x63.nu
CC: linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Subject: Re: lvm in 2.5.1
In-Reply-To: <20011227084304.GA26255@h55p111.delphi.afb.lu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andersg@0x63.nu wrote:
> 
> Hi Jens and other kernelhackers,
> 
> I'm now running 2.5.1 with lvm. The following patch makes some minor changes
> for bio-support and removes allocation of a lv_t on the stack, which made
> the stack overflow and gave me something to spend my last 24 hours
> debugging.

That's a worry, because an lv_t is only 420 bytes.  If that's triggering
a stack overflow then we're way too close.  Think interrupts....

There must be other sources of stack bloat.

lvm_chr_ioctl() calls lvm_do_vg_create(), and it has has another lv_t
on the stack.  That's 840 bytes - still not enough.  Maybe lvm_do_vg_create()
is calling something which uses lots of stack?  Can't see it.  Odd.

> ...
>         /* get the logical volume structures */
>         vg_ptr->lv_cur = 0;
>         for (l = 0; l < vg_ptr->lv_max; l++) {
>                 lv_t *lvp;
> +
>                 /* user space address */
>                 if ((lvp = vg_ptr->lv[l]) != NULL) {
> -                       if (copy_from_user(&lv, lvp, sizeof(lv_t)) != 0) {
> +                       if (copy_from_user(tmplv, lvp, sizeof(lv_t)) != 0) {
>                                 P_IOCTL("ERROR: copying LV ptr %p (%d bytes)\n",
>                                         lvp, sizeof(lv_t));
>                                 lvm_do_vg_remove(minor);
>                                 return -EFAULT;

Seems that in various places here you've forgotten to free the lv_t storage
on error paths?

Which means you must painfully go through and put a kfree() in front
of each and every `return' statement, hope you don't miss any, hope
you don't break anything, and hope that people don't forget to do this
next time they change the code.  Or you need to go through and restructure
the code so you need only one kfree.

Which is a fine and shining example of why one should never, ever, ever,
ever put more than one `return' statement in a C function.  Dammit.  It
is the single worst feature of C and should not be used.

BTW, it appears that lvm_do_vg_create() leaks the vmalloced snap_lv_ptr
on an error path...

-
