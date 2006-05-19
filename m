Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWESI3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWESI3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 04:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWESI3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 04:29:09 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:58761 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932130AbWESI3I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 04:29:08 -0400
In-Reply-To: <446CE7E2.8050302@redhat.com>
Subject: Re: [PATCH] kprobes: bad manipulation of 2 byte opcode on x86_64
Sensitivity: 
To: Satoshi Oshima <soshima@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       "Hideo AOKI@redhat" <haoki@redhat.com>,
       Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>,
       Jim Keniston <jkenisto@us.ibm.com>, linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <mananth@in.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       sugita <sugita@sdl.hitachi.co.jp>, systemtap@sources.redhat.com,
       systemtap-owner@sourceware.org
X-Mailer: Lotus Notes Release 6.5.1IBM February 19, 2004
Message-ID: <OFAED3DE10.BAEAFDF2-ON41257173.002E89ED-41257173.002E9AB6@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Fri, 19 May 2006 09:29:02 +0100
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.53HF247 | January 6, 2005) at
 19/05/2006 09:30:04
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Is there any possibility of a inducing a page fault when checking the
second byte?
- -
Richard J Moore
IBM Advanced Linux Response Team - Linux Technology Centre
MOBEX: 264807; Mobile (+44) (0)7739-875237
Office: (+44) (0)1962-817072


                                                                           
             Satoshi Oshima                                                
             <soshima@redhat                                               
             .com>                                                      To 
             Sent by:                  Andi Kleen <ak@suse.de>, Andrew     
             systemtap-owner           Morton <akpm@osdl.org>              
             @sourceware.org                                            cc 
                                       linux-kernel@vger.kernel.org,       
                                       systemtap@sources.redhat.com,       
             18/05/2006                "Keshavamurthy, Anil S"             
             22:32                     <anil.s.keshavamurthy@intel.com>,   
                                       Ananth N Mavinakayanahalli          
                                       <mananth@in.ibm.com>, Jim Keniston  
                                       <jkenisto@us.ibm.com>, Prasanna S   
                                       Panchamukhi <prasanna@in.ibm.com>,  
                                       "Hideo AOKI@redhat"                 
                                       <haoki@redhat.com>, Masami          
                                       Hiramatsu                           
                                       <hiramatu@sdl.hitachi.co.jp>,       
                                       sugita <sugita@sdl.hitachi.co.jp>   
                                                                       bcc 
                                                                           
                                                                   Subject 
                                       [PATCH] kprobes: bad manupilation   
                                       of 2 byte opcode on x86_64          
                                                                           
                                                                           




Hi Andi and Andrew,

I found a bug of kprobes on x86_64.
I attached the fix of this bug.


Problem:

If we put a probe onto a callq instruction and the probe
is executed, kernel panic of Bad RIP value occurs.

Root cause:

If resume_execution() found 0xff at first byte of
p->ainsn.insn, it must check the _second_ byte.
But current resume_execution check _first_ byte again.


I changed it checks second byte of p->ainsn.insn.

Kprobes on i386 don't have this problem, because
the implementation is a little bit different from
x86_64.


Regards,

Satoshi Oshima
Hitachi Computer Product (America) Inc.

----------------------------------------------

diff -Narup linux-2.6.17-rc3-mm1.orig/arch/x86_64/kernel/kprobes.c
x86_64_bugifx/arch/x86_64/kernel/kprobes.c
--- linux-2.6.17-rc3-mm1.orig/arch/x86_64/kernel/kprobes.c
2006-05-04 12:34:44.000000000 -0400
+++ x86_64_bugifx/arch/x86_64/kernel/kprobes.c         2006-05-12
16:02:35.000000000 -0400
@@ -514,13 +514,13 @@ static void __kprobes resume_execution(s
                         *tos = orig_rip + (*tos - copy_rip);
                         break;
             case 0xff:
-                        if ((*insn & 0x30) == 0x10) {
+                        if ((insn[1] & 0x30) == 0x10) {
                                     /* call absolute, indirect */
                                     /* Fix return addr; rip is correct. */
                                     next_rip = regs->rip;
                                     *tos = orig_rip + (*tos - copy_rip);
-                        } else if (((*insn & 0x31) == 0x20) ||          /*
jmp near, absolute indirect */
-                                       ((*insn & 0x31) == 0x21)) {
 /* jmp far, absolute indirect */
+                        } else if (((insn[1] & 0x31) == 0x20) ||        /*
jmp near, absolute indirect */
+                                       ((insn[1] & 0x31) == 0x21)) {
 /* jmp far, absolute indirect */
                                     /* rip is correct. */
                                     next_rip = regs->rip;
                         }



