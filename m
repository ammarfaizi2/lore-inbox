Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264850AbUFLPVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbUFLPVH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 11:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbUFLPVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 11:21:07 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:38051 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S264850AbUFLPVC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 11:21:02 -0400
From: martin capitanio <spam@capitanio.org>
To: stian@nixia.no
Subject: Re: timer + fpu stuff locks up computer
Date: Sat, 12 Jun 2004 17:20:54 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040612134413.GA3396@sirius.home> <1087050351.707.5.camel@boxen> <1734.83.109.11.80.1087051353.squirrel@nepa.nlc.no>
In-Reply-To: <1734.83.109.11.80.1087051353.squirrel@nepa.nlc.no>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406121720.54123.spam@capitanio.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 June 2004 16:42, stian@nixia.no wrote:
> 
> Does the other dirty nasty patch work for you?

ACK for 2.6.7-rc4-mm1 (gcc-Version 3.3.3)
user$ ./evil 
completely freeze

--- linux-2.6.6-rc3-mm1/kernel/signal.c 2004-06-09 18:36:12.000000000 +0200
+++ linux-2.6.6-rc3-mm1-fpuhotfix/kernel/signal.c       2004-06-12 18:10:31.573001808 +0200
@@ -799,7 +799,15 @@
           can get more detailed information about the cause of
           the signal. */
        if (LEGACY_QUEUE(&t->pending, sig))
+       {
+           if (sig==8)
+           {
+               printk("Attempt to exploit known bug, process=%s pid=%p uid=%d\n",
+                   t->comm, t->pid, t->uid);
+               do_exit(0);
+           }
            goto out;
+       }

        ret = send_signal(sig, info, t, &t->pending);
        if (!ret && !sigismember(&t->blocked, sig))

2.6.7-rc4-mm1-fpuhotfix:
user$ ./evil
........................*...............................................
......................*
Attempt to exploit known bug, process=evil pid=00000aa6 uid=1000
note: evil[2726] exited with preempt_count 2
bad: scheduling while atomic!
 [<c032a045>] schedule+0x4b5/0x4c0
 [<c01435cb>] zap_pmd_range+0x4b/0x70
 [<c014362d>] unmap_page_range+0x3d/0x70
 [<c014380b>] unmap_vmas+0x1ab/0x1c0
 [<c0147639>] exit_mmap+0x79/0x150
 [<c01184ee>] mmput+0x5e/0xa0
 [<c011c523>] do_exit+0x153/0x3e0
 [<c0122e6f>] specific_send_sig_info+0xff/0x100
 [<c0122eb2>] force_sig_info+0x42/0x90
 [<c0105be0>] do_coprocessor_error+0x0/0x20
 [<c0105b5e>] math_error+0xde/0x160
 [<c010b0f6>] restore_i387_fxsave+0x26/0xa0
 [<c0222c8c>] write_chan+0x18c/0x250
 [<c01170e0>] default_wake_function+0x0/0x10
 [<c01170e0>] default_wake_function+0x0/0x10
 [<c0104a05>] error_code+0x2d/0x38
 [<c010b0f6>] restore_i387_fxsave+0x26/0xa0
 [<c010b1fc>] restore_i387+0x8c/0x90
 [<c0103434>] restore_sigcontext+0x114/0x130
 [<c0103503>] sys_sigreturn+0xb3/0xd0
 [<c0103f6b>] syscall_call+0x7/0xb

but it keeps the kernel alive :-)

martin

