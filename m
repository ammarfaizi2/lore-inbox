Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbVIAXM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbVIAXM3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 19:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbVIAXM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 19:12:29 -0400
Received: from fmr22.intel.com ([143.183.121.14]:55460 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030300AbVIAXM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 19:12:28 -0400
Date: Thu, 1 Sep 2005 16:12:18 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       ananth@in.ibm.com, prasanna@in.ibm.com
Subject: [PATCH]kprobes comment patch around kprobes lock functions
Message-ID: <20050901161216.A31007@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20050901134937.A29041@unix-os.sc.intel.com> <20050901140938.69909683.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050901140938.69909683.akpm@osdl.org>; from akpm@osdl.org on Thu, Sep 01, 2005 at 02:09:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 02:09:38PM -0700, Andrew Morton wrote:
> Now, probably there's deep magic happening here and I'm wrong.  If so then
> please explain the code's magic via a comment patch so the question doesn't
> arise again, thanks.
> 

This is a comment patch around lock_kprobes() and unlock_kprobes() functions.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

===================================================================
 kernel/kprobes.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

Index: linux-2.6.13-mm1/kernel/kprobes.c
===================================================================
--- linux-2.6.13-mm1.orig/kernel/kprobes.c
+++ linux-2.6.13-mm1/kernel/kprobes.c
@@ -157,9 +157,16 @@ void __kprobes lock_kprobes(void)
 {
 	unsigned long flags = 0;
 
+	/* Avoiding local interrupts to happen right after we take the kprobe_lock
+	 * and before we get a chance to update kprobe_cpu, this to prevent
+	 * deadlock when we have a kprobe on ISR routine and a kprobe on task
+	 * routine
+	 */
 	local_irq_save(flags);
+
 	spin_lock(&kprobe_lock);
 	kprobe_cpu = smp_processor_id();
+
  	local_irq_restore(flags);
 }
 
@@ -167,9 +174,16 @@ void __kprobes unlock_kprobes(void)
 {
 	unsigned long flags = 0;
 
+	/* Avoiding local interrupts to happen right after we update
+	 * kprobe_cpu and before we get a a chance to release kprobe_lock,
+	 * this to prevent deadlock when we have a kprobe on ISR routine and
+	 * a kprobe on task routine
+	 */
 	local_irq_save(flags);
+
 	kprobe_cpu = NR_CPUS;
 	spin_unlock(&kprobe_lock);
+
  	local_irq_restore(flags);
 }
 
