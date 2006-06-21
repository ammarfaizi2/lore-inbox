Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751981AbWFUEWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbWFUEWr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 00:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbWFUEWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 00:22:47 -0400
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:45994 "EHLO
	ausmtp06.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751981AbWFUEWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 00:22:46 -0400
Message-ID: <4498CAEB.5010105@in.ibm.com>
Date: Wed, 21 Jun 2006 09:58:27 +0530
From: srinivasa <srinivasa@in.ibm.com>
Reply-To: srinivasa@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] for "BUG: using smp_processor_id() in preemptible" in 2.6.17.rc6.mm2
Content-Type: multipart/mixed;
 boundary="------------070202080101080509020805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070202080101080509020805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all
I saw a stack trace while booting the 2.6.17-rc6-mm2 kernel. Which looks 
  like this

BUG: using smp_processor_id() in preemptible [00000001] code: init/1
caller is __handle_mm_fault+0x22/0x248
  [<c010334c>] show_trace+0x27/0x29
  [<c0103486>] dump_stack+0x26/0x28
  [<c02e4d6f>] debug_smp_processor_id+0x9f/0xb0
  [<c0157a98>] __handle_mm_fault+0x22/0x248
  [<c01140b2>] do_page_fault+0x17e/0x605
  [<c01030b9>] error_code+0x39/0x40
  [<c0198eef>] padzero+0x2c/0x37
  [<c0199ff5>] load_elf_binary+0x6e2/0xcfc
  [<c0174e14>] search_binary_handler+0x96/0x201
  [<c017510e>] do_execve+0x18f/0x243
  [<c010152b>] sys_execve+0x3c/0x81
  [<c04a9c93>] syscall_call+0x7/0xb

    Cause for the bug is a set of functions count_vm_event(),
     count_vm_events() and get_cpu_vm_events() calling smp_processor_id()
     in preemptible context without disabling irq's

So I developed patch for this problem,attaching the patch here



--------------070202080101080509020805
Content-Type: text/plain;
 name="mm.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm.fix"

diff -Naurp linux-orig/include/linux/page-flags.h linux-mod/include/linux/page-flags.h
--- linux-orig/include/linux/page-flags.h	2006-06-20 20:49:59.000000000 -0700
+++ linux-mod/include/linux/page-flags.h	2006-06-20 20:47:50.000000000 -0700
@@ -141,17 +141,27 @@ DECLARE_PER_CPU(struct vm_event_state, v
 
 static inline unsigned long get_cpu_vm_events(enum vm_event_item item)
 {
-	return __get_cpu_var(vm_event_states).event[item];
+	unsigned long flags, res;
+	local_irq_save(flags); 
+	res = __get_cpu_var(vm_event_states).event[item];
+	local_irq_restore(flags);
+	return res;
 }
 
 static inline void count_vm_event(enum vm_event_item item)
 {
+	unsigned long flags;
+	local_irq_save(flags);
 	__get_cpu_var(vm_event_states).event[item]++;
+	local_irq_restore(flags);
 }
 
 static inline void count_vm_events(enum vm_event_item item, long delta)
 {
+	unsigned long flags;
+	local_irq_save(flags);
 	__get_cpu_var(vm_event_states).event[item] += delta;
+	local_irq_restore(flags);
 }
 
 extern void all_vm_events(unsigned long *);

--------------070202080101080509020805--
