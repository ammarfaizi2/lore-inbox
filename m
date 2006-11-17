Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752894AbWKQTfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbWKQTfs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752893AbWKQTfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:35:48 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:40326 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1752894AbWKQTfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:35:47 -0500
Date: Fri, 17 Nov 2006 14:35:46 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>
cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Jens Axboe <axboe@kernel.dk>, Christoph Lameter <clameter@sgi.com>,
       "David S. Miller" <davem@davemloft.net>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow NULL pointers in percpu_free
In-Reply-To: <1163787247.3097.14.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0611171428590.2627-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch (as824b) makes percpu_free() ignore NULL arguments, as one
would expect for a deallocation routine.  (Note that free_percpu is
#defined as percpu_free in include/linux/percpu.h.)  A few callers are
updated to remove now-unneeded tests for NULL.  A few other callers
already seem to assume that passing a NULL pointer to percpu_free() is
okay!

The patch also removes an unnecessary NULL check in percpu_depopulate().

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

On Fri, 17 Nov 2006, Daniel Walker wrote:

> > > Should be unlikely() right?
> > 
> > It certainly could be.  I tend not to put such annotations in my code, but
> > it wouldn't hurt.
> 
> It's actually a really good idea to add them .. I've noticed they tend
> to make my kernels smaller, although I wouldn't expect that to always be
> the case..

Smaller???!!!  How on earth do you think that could happen?  When you
don't use unlikely() there are fewer restrictions on the compiler; hence
it should be free to generate smaller code without the annotation than
with it.  Unless maybe you don't set CONFIG_CC_OPTIMIZE_FOR_SIZE, which 
ought to be a much better way of getting small kernels...

> Another reason is that in -mm we can track how often this
> condition is triggered with likely profiling. With kfree, for instance,
> there were a number of callers that frequently called kfree(NULL), which
> IMO isn't good.

Okay, here's the revised patch.

Alan Stern



Index: usb-2.6/arch/i386/kernel/acpi/cstate.c
===================================================================
--- usb-2.6.orig/arch/i386/kernel/acpi/cstate.c
+++ usb-2.6/arch/i386/kernel/acpi/cstate.c
@@ -155,10 +155,8 @@ static int __init ffh_cstate_init(void)
 
 static void __exit ffh_cstate_exit(void)
 {
-	if (cpu_cstate_entry) {
-		free_percpu(cpu_cstate_entry);
-		cpu_cstate_entry = NULL;
-	}
+	free_percpu(cpu_cstate_entry);
+	cpu_cstate_entry = NULL;
 }
 
 arch_initcall(ffh_cstate_init);
Index: usb-2.6/block/blktrace.c
===================================================================
--- usb-2.6.orig/block/blktrace.c
+++ usb-2.6/block/blktrace.c
@@ -366,8 +366,7 @@ err:
 	if (bt) {
 		if (bt->dropped_file)
 			debugfs_remove(bt->dropped_file);
-		if (bt->sequence)
-			free_percpu(bt->sequence);
+		free_percpu(bt->sequence);
 		if (bt->rchan)
 			relay_close(bt->rchan);
 		kfree(bt);
Index: usb-2.6/mm/allocpercpu.c
===================================================================
--- usb-2.6.orig/mm/allocpercpu.c
+++ usb-2.6/mm/allocpercpu.c
@@ -17,10 +17,9 @@
 void percpu_depopulate(void *__pdata, int cpu)
 {
 	struct percpu_data *pdata = __percpu_disguise(__pdata);
-	if (pdata->ptrs[cpu]) {
-		kfree(pdata->ptrs[cpu]);
-		pdata->ptrs[cpu] = NULL;
-	}
+
+	kfree(pdata->ptrs[cpu]);
+	pdata->ptrs[cpu] = NULL;
 }
 EXPORT_SYMBOL_GPL(percpu_depopulate);
 
@@ -123,6 +122,8 @@ EXPORT_SYMBOL_GPL(__percpu_alloc_mask);
  */
 void percpu_free(void *__pdata)
 {
+	if (unlikely(!__pdata))
+		return;
 	__percpu_depopulate_mask(__pdata, &cpu_possible_map);
 	kfree(__percpu_disguise(__pdata));
 }
Index: usb-2.6/net/ipv6/af_inet6.c
===================================================================
--- usb-2.6.orig/net/ipv6/af_inet6.c
+++ usb-2.6/net/ipv6/af_inet6.c
@@ -719,10 +719,8 @@ snmp6_mib_free(void *ptr[2])
 {
 	if (ptr == NULL)
 		return;
-	if (ptr[0])
-		free_percpu(ptr[0]);
-	if (ptr[1])
-		free_percpu(ptr[1]);
+	free_percpu(ptr[0]);
+	free_percpu(ptr[1]);
 	ptr[0] = ptr[1] = NULL;
 }
 

