Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261316AbTDCQMr>; Thu, 3 Apr 2003 11:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261320AbTDCQMr>; Thu, 3 Apr 2003 11:12:47 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:3950 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S261316AbTDCQMi>;
	Thu, 3 Apr 2003 11:12:38 -0500
Message-ID: <3E8C6022.6060304@mvista.com>
Date: Thu, 03 Apr 2003 10:24:02 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@redhat.com>
Subject: IPMI driver version 19 release
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8A8DBE5766A3830046A606A6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8A8DBE5766A3830046A606A6
Content-Type: multipart/mixed;
 boundary="------------000500000807000301070708"

This is a multi-part message in MIME format.
--------------000500000807000301070708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This is a new release of the IPMI driver that fixes some
performance problems.  Some vendors implement firmware
updates over IPMI, and this speeds up that process quite
a bit.

Linus, please apply.

Alan, I will send you the 2.4 patch, so you don't have to fetch
it from SF.

This release:

 * Improves the "send - wait for response - send -wait for
response - etc" performance when using high-res timers.
Before, an ~10ms delay would be added to each message,
because it didn't restart the timer if nothing was happing
when a new message was started.

* Adds some checking for leaked messages.

The patch is a 2.5 version against what is current in Bitkeeper (well,
what is current in bk-CVS, thanks for the tool, Larry).  The 2.5.66
and 2.4.20 versions are at:
http://sourceforge.net/projects/openipmi/

-Corey

--------------000500000807000301070708
Content-Type: text/plain;
 name="linux-2.5.67-pre-ipmi-diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.5.67-pre-ipmi-diff"

Only in linux-2.5/drivers/char/ipmi: CVS
diff -ur linux-2.5/drivers/char/ipmi/ipmi_kcs_intf.c /home/minyard/2.5.66/linux-main/drivers/char/ipmi/ipmi_kcs_intf.c
--- linux-2.5/drivers/char/ipmi/ipmi_kcs_intf.c	Thu Mar 27 23:14:18 2003
+++ /home/minyard/2.5.66/linux-main/drivers/char/ipmi/ipmi_kcs_intf.c	Thu Apr  3 08:46:26 2003
@@ -61,6 +61,14 @@
 /* Measure times between events in the driver. */
 #undef DEBUG_TIMING
 
+/* Timing parameters.  Call every 10 ms when not doing anything,
+   otherwise call every KCS_SHORT_TIMEOUT_USEC microseconds. */
+#define KCS_TIMEOUT_TIME_USEC	10000
+#define KCS_USEC_PER_JIFFY	(1000000/HZ)
+#define KCS_TIMEOUT_JIFFIES	(KCS_TIMEOUT_TIME_USEC/KCS_USEC_PER_JIFFY)
+#define KCS_SHORT_TIMEOUT_USEC  250 /* .25ms when the SM request a
+                                       short timeout */
+
 #ifdef CONFIG_IPMI_KCS
 /* This forces a dependency to the config file for this option. */
 #endif
@@ -132,6 +140,8 @@
 	int                 interrupt_disabled;
 };
 
+static void kcs_restart_short_timer(struct kcs_info *kcs_info);
+
 static void deliver_recv_msg(struct kcs_info *kcs_info, struct ipmi_smi_msg *msg)
 {
 	/* Deliver the message to the upper layer with the lock
@@ -309,6 +319,9 @@
 #endif
 	switch (kcs_info->kcs_state) {
 	case KCS_NORMAL:
+		if (!kcs_info->curr_msg)
+			break;
+			
 		kcs_info->curr_msg->rsp_size
 			= kcs_get_result(kcs_info->kcs_sm,
 					 kcs_info->curr_msg->rsp,
@@ -563,8 +576,9 @@
 		spin_lock_irqsave(&(kcs_info->kcs_lock), flags);
 		result = kcs_event_handler(kcs_info, 0);
 		while (result != KCS_SM_IDLE) {
-			udelay(500);
-			result = kcs_event_handler(kcs_info, 500);
+			udelay(KCS_SHORT_TIMEOUT_USEC);
+			result = kcs_event_handler(kcs_info,
+						   KCS_SHORT_TIMEOUT_USEC);
 		}
 		spin_unlock_irqrestore(&(kcs_info->kcs_lock), flags);
 		return;
@@ -582,6 +596,7 @@
 	    && (kcs_info->curr_msg == NULL))
 	{
 		start_next_msg(kcs_info);
+		kcs_restart_short_timer(kcs_info);
 	}
 	spin_unlock_irqrestore(&(kcs_info->kcs_lock), flags);
 }
@@ -598,8 +613,9 @@
 	if (i_run_to_completion) {
 		result = kcs_event_handler(kcs_info, 0);
 		while (result != KCS_SM_IDLE) {
-			udelay(500);
-			result = kcs_event_handler(kcs_info, 500);
+			udelay(KCS_SHORT_TIMEOUT_USEC);
+			result = kcs_event_handler(kcs_info,
+						   KCS_SHORT_TIMEOUT_USEC);
 		}
 	}
 
@@ -613,14 +629,42 @@
 	atomic_set(&kcs_info->req_events, 1);
 }
 
-/* Call every 10 ms. */
-#define KCS_TIMEOUT_TIME_USEC	10000
-#define KCS_USEC_PER_JIFFY	(1000000/HZ)
-#define KCS_TIMEOUT_JIFFIES	(KCS_TIMEOUT_TIME_USEC/KCS_USEC_PER_JIFFY)
-#define KCS_SHORT_TIMEOUT_USEC  500 /* .5ms when the SM request a
-                                       short timeout */
 static int initialized = 0;
 
+/* Must be called with interrupts off and with the kcs_lock held. */
+static void kcs_restart_short_timer(struct kcs_info *kcs_info)
+{
+	if (del_timer(&(kcs_info->kcs_timer))) {
+#ifdef CONFIG_HIGH_RES_TIMERS
+		unsigned long jiffies_now;
+
+		/* If we don't delete the timer, then it will go off
+		   immediately, anyway.  So we only process if we
+		   actually delete the timer. */
+
+		/* We already have irqsave on, so no need for it
+                   here. */
+		read_lock(&xtime_lock);
+		jiffies_now = jiffies;
+		kcs_info->kcs_timer.expires = jiffies_now;
+
+		kcs_info->kcs_timer.sub_expires
+			= quick_update_jiffies_sub(jiffies_now);
+		read_unlock(&xtime_lock);
+
+		kcs_info->kcs_timer.sub_expires
+			+= usec_to_arch_cycles(KCS_SHORT_TIMEOUT_USEC);
+		while (kcs_info->kcs_timer.sub_expires >= cycles_per_jiffies) {
+			kcs_info->kcs_timer.expires++;
+			kcs_info->kcs_timer.sub_expires -= cycles_per_jiffies;
+		}
+#else
+		kcs_info->kcs_timer.expires = jiffies + 1;
+#endif
+		add_timer(&(kcs_info->kcs_timer));
+	}
+}
+
 static void kcs_timeout(unsigned long data)
 {
 	struct kcs_info *kcs_info = (struct kcs_info *) data;
@@ -643,12 +687,11 @@
 	printk("**Timer: %d.%9.9d\n", t.tv_sec, t.tv_usec);
 #endif
 	jiffies_now = jiffies;
+
 	time_diff = ((jiffies_now - kcs_info->last_timeout_jiffies)
 		     * KCS_USEC_PER_JIFFY);
 	kcs_result = kcs_event_handler(kcs_info, time_diff);
 
-	spin_unlock_irqrestore(&(kcs_info->kcs_lock), flags);
-
 	kcs_info->last_timeout_jiffies = jiffies_now;
 
 	if ((kcs_info->irq) && (! kcs_info->interrupt_disabled)) {
@@ -669,6 +712,7 @@
 		}
 	} else {
 		kcs_info->kcs_timer.expires = jiffies + KCS_TIMEOUT_JIFFIES;
+		kcs_info->kcs_timer.sub_expires = 0;
 	}
 #else
 	/* If requested, take the shortest delay possible */
@@ -681,6 +725,7 @@
 
  do_add_timer:
 	add_timer(&(kcs_info->kcs_timer));
+	spin_unlock_irqrestore(&(kcs_info->kcs_lock), flags);
 }
 
 static void kcs_irq_handler(int irq, void *data, struct pt_regs *regs)
diff -ur linux-2.5/drivers/char/ipmi/ipmi_msghandler.c /home/minyard/2.5.66/linux-main/drivers/char/ipmi/ipmi_msghandler.c
--- linux-2.5/drivers/char/ipmi/ipmi_msghandler.c	Fri Feb 21 15:44:13 2003
+++ /home/minyard/2.5.66/linux-main/drivers/char/ipmi/ipmi_msghandler.c	Thu Apr  3 07:58:06 2003
@@ -1765,9 +1765,13 @@
 }
 
 
+static atomic_t smi_msg_inuse_count = ATOMIC_INIT(0);
+static atomic_t recv_msg_inuse_count = ATOMIC_INIT(0);
+
 /* FIXME - convert these to slabs. */
 static void free_smi_msg(struct ipmi_smi_msg *msg)
 {
+	atomic_dec(&smi_msg_inuse_count);
 	kfree(msg);
 }
 
@@ -1775,13 +1779,16 @@
 {
 	struct ipmi_smi_msg *rv;
 	rv = kmalloc(sizeof(struct ipmi_smi_msg), GFP_ATOMIC);
-	if (rv)
+	if (rv) {
 		rv->done = free_smi_msg;
+		atomic_inc(&smi_msg_inuse_count);
+	}
 	return rv;
 }
 
 static void free_recv_msg(struct ipmi_recv_msg *msg)
 {
+	atomic_dec(&recv_msg_inuse_count);
 	kfree(msg);
 }
 
@@ -1790,8 +1797,10 @@
 	struct ipmi_recv_msg *rv;
 
 	rv = kmalloc(sizeof(struct ipmi_recv_msg), GFP_ATOMIC);
-	if (rv)
+	if (rv) {
 		rv->done = free_recv_msg;
+		atomic_inc(&recv_msg_inuse_count);
+	}
 	return rv;
 }
 
@@ -1924,6 +1933,8 @@
 
 static __exit void cleanup_ipmi(void)
 {
+	int count;
+
 	if (!initialized)
 		return;
 
@@ -1940,6 +1951,16 @@
 	}
 
 	initialized = 0;
+
+	/* Check for buffer leaks. */
+	count = atomic_read(&smi_msg_inuse_count);
+	if (count != 0)
+		printk("ipmi_msghandler: SMI message count %d at exit\n",
+		       count);
+	count = atomic_read(&recv_msg_inuse_count);
+	if (count != 0)
+		printk("ipmi_msghandler: recv message count %d at exit\n",
+		       count);
 }
 module_exit(cleanup_ipmi);
 

--------------000500000807000301070708--

--------------enig8A8DBE5766A3830046A606A6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+jGAlmUvlb4BhfF4RAmz8AJ9E7fEaxVQYdpdtymxGiycnquOxlQCfe5Nu
JpkDmplNaJTr0RxjQ0iyd64=
=k02J
-----END PGP SIGNATURE-----

--------------enig8A8DBE5766A3830046A606A6--

