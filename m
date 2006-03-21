Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWCUKCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWCUKCj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 05:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWCUKCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 05:02:38 -0500
Received: from fmr20.intel.com ([134.134.136.19]:32655 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751352AbWCUKCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 05:02:38 -0500
Message-ID: <441FCCF8.1060300@intel.com>
Date: Tue, 21 Mar 2006 17:52:56 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
Subject: [PATCH] kretprobe spinlock recursive remove
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In recent linux kernel version, kretprobe in IA32 is implemented in 
kretprobe_trampoline. And break trap code is removed from 
retprobe_trampoline, instead trampoline_handler is called directly. 
Currently if kretprobe hander hit one trap which causes another 
kretprobe, there will be SPINLOCK recursive bug. This patch fixes this, 
and will skip trap during kretprobe handler execution. This patch is 
based on 2.6.16-rc6-mm2.

--- arch/i386/kernel/kprobes.c.bak	2006-03-21 10:35:34.000000000 +0800
+++ arch/i386/kernel/kprobes.c	2006-03-21 10:37:44.000000000 +0800
@@ -390,8 +390,11 @@ fastcall void *__kprobes trampoline_hand
  			/* another task is sharing our hash bucket */
                          continue;

-		if (ri->rp && ri->rp->handler)
+		if (ri->rp && ri->rp->handler){
+			__get_cpu_var(current_kprobe) = &ri->rp->kp;
  			ri->rp->handler(ri, regs);
+			__get_cpu_var(current_kprobe) = NULL;
+		}

  		orig_ret_address = (unsigned long)ri->ret_addr;
  		recycle_rp_inst(ri);
