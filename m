Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbULIOWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbULIOWD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbULIOWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:22:03 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:59639 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S261418AbULIOVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:21:47 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Greg Banks <gnb@sgi.com>, John Levon <levon@movementarian.org>
Subject: Re: [mm patch] oprofile: backtrace operation does not initialized
Date: Thu, 9 Dec 2004 23:22:27 +0900
User-Agent: KMail/1.5.4
Cc: Greg Banks <gnb@sgi.com>, Philippe Elie <phil.el@wanadoo.fr>,
       linux-kernel@vger.kernel.org
References: <200412081830.51607.amgta@yacht.ocn.ne.jp> <20041209014622.GB48804@compsoc.man.ac.uk> <20041209015024.GG4239@sgi.com>
In-Reply-To: <20041209015024.GG4239@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412092322.27096.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 December 2004 10:50, Greg Banks wrote:
> On Thu, Dec 09, 2004 at 01:46:22AM +0000, John Levon wrote:
> > On Thu, Dec 09, 2004 at 11:39:06AM +1100, Greg Banks wrote:
> > > But for now I don't see any drama with leaving in the ->setup() and
> > > ->shutdown() methods when rewriting the ops structure.  Ditto for
> > > the ->create_files() methods.
> >
> > Wouldn't this mean that we try to set up the NMI stuff regardless of
> > forcing the timer ? I can imagine a flaky system where somebody needs to
> > avoid going near that stuff.
> >
> > timer_init() making sure to set all fields seems reasonable to me.  Or
> > oprofile_init() could grab ->backtrace, memset the structure, then
> > replace ->backtrace...
>
> Ok, how about this patch?

Thanks, but..

This patch is broken on several architectures (sparc64, sh, parisc, s390).
Even though i386 without CONFIG_X86_LOCAL_APIC and CONFIG_X86_IO_APIC.

Since the timer interrupt is the only way of getting sampling for oprofile
on such environments. if no module parameters specified (i.e. timer == 0),
then oprofile_timer_init() is never called. and I have got this error:


Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
e81a97b0
*pde = 0b690001
Oops: 0000 [#1]
PREEMPT DEBUG_PAGEALLOC
Modules linked in: oprofile 3c59x microcode ntfs video
CPU:    0
EIP:    0060:[<e81a97b0>]    Not tainted VLI
EFLAGS: 00010246   (2.6.10-rc2-mm4) 
EIP is at oprofilefs_str_to_user+0x10/0x2c [oprofile]
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: 00000000
esi: c7169f54   edi: 00000000   ebp: c7616f6c   esp: c7616f68
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 3366, threadinfo=c7616000 task=c716da60)
Stack: c7616fa8 c7616f90 c0171a80 00000000 0804d888 00001000 c7616fa8 c7169f54 
       fffffff7 0804d888 c7616fbc c0171cfe c7169f54 0804d888 00001000 c7616fa8 
       00000000 00000000 00000000 00000003 00001000 c7616000 c0103d41 00000003 
Call Trace:
 [<c0104397>] show_stack+0x6f/0x88
 [<c01044c6>] show_registers+0xfe/0x160
 [<c01046f1>] die+0x13d/0x288
 [<c0112c74>] do_page_fault+0x324/0x6a1
 [<c0103f3b>] error_code+0x2b/0x30
 [<c0171a80>] vfs_read+0x88/0x104
 [<c0171cfe>] sys_read+0x3a/0x64
 [<c0103d41>] sysenter_past_esp+0x52/0x71
Code: 53 58 89 43 54 89 43 4c 89 53 50 89 43 44 89 53 48 89 d8 8b 5d fc c9 c3 8d 76 00 55 89 e5 8b 55 08 57 31 c0 b9 ff ff ff ff 89 d7 <f2> ae f7 d1 49 51 52 ff 75 14 ff 75 10 ff 75 0c e8 97 70 ff d7 




