Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261859AbSJVB0Z>; Mon, 21 Oct 2002 21:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSJVB0Z>; Mon, 21 Oct 2002 21:26:25 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:56845 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S261859AbSJVB0T>;
	Mon, 21 Oct 2002 21:26:19 -0400
Message-ID: <3DB4AABF.9020400@mvista.com>
Date: Mon, 21 Oct 2002 20:32:47 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] NMI request/release
Content-Type: multipart/mixed;
 boundary="------------050502010600060506080207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050502010600060506080207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch implements a way to request to receive an NMI if it 
comes from an otherwise unknown source.  I needed this for handling NMIs 
with the IPMI watchdog.  This function was discussed a little a while 
back on the mailing list, but nothing was done about it, so I 
implemented a request/release for NMIs.  The code is in 
arch/i386/kernel/traps.c, but it's pretty generic and could possibly 
live in kernel.  I'm not sure, though.

This is relative to 2.5.44.  I have a 2.4 version of it, too.

-Corey


--------------050502010600060506080207
Content-Type: text/plain;
 name="linux-nmi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-nmi.diff"

diff -urN linux.orig/arch/i386/kernel/i386_ksyms.c linux/arch/i386/kernel/i386_ksyms.c
--- linux.orig/arch/i386/kernel/i386_ksyms.c	Mon Oct 21 13:25:58 2002
+++ linux/arch/i386/kernel/i386_ksyms.c	Mon Oct 21 20:04:35 2002
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/tty.h>
+#include <linux/nmi.h>
 #include <linux/highmem.h>
 
 #include <asm/semaphore.h>
@@ -89,6 +90,9 @@
 EXPORT_SYMBOL(get_cmos_time);
 EXPORT_SYMBOL(cpu_khz);
 EXPORT_SYMBOL(apm_info);
+
+EXPORT_SYMBOL(request_nmi);
+EXPORT_SYMBOL(release_nmi);
 
 #ifdef CONFIG_DEBUG_IOVIRT
 EXPORT_SYMBOL(__io_virt_debug);
diff -urN linux.orig/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- linux.orig/arch/i386/kernel/traps.c	Mon Oct 21 13:25:45 2002
+++ linux/arch/i386/kernel/traps.c	Mon Oct 21 20:06:43 2002
@@ -485,6 +485,95 @@
 	printk("Do you have a strange power saving mode enabled?\n");
 }
 
+/* A list of handlers for NMIs.  This list will be called in order
+   when an NMI from an otherwise unidentifiable source somes in.  If
+   one of these handles the NMI, it should return 1.  NMI handlers
+   cannot claim spinlocks, so we have to handle mutex in a different
+   manner.  A spinlock protects the list from multiple writers.  When
+   something is removed from the list, it will check to see that
+   calling_nmi_handlers is 0 before returning.  If it is not zero,
+   another processor is handling an NMI, and it should wait until it
+   goes to zero to return and allow the user to free that data. */
+static volatile struct nmi_handler *nmi_handler_list = NULL;
+static spinlock_t                  nmi_handler_lock = SPIN_LOCK_UNLOCKED;
+static atomic_t                    calling_nmi_handlers = ATOMIC_INIT(0);
+
+int request_nmi(struct nmi_handler *handler)
+{
+	volatile struct nmi_handler *curr;
+
+	spin_lock(&nmi_handler_lock);
+
+	/* Make sure the thing is not already in the list. */
+	curr = nmi_handler_list;
+	while (curr) {
+		if (curr == handler) {
+			break;
+		}
+		curr = curr->next;
+	}
+	if (curr)
+		return EBUSY;
+
+	handler->next = nmi_handler_list;
+	xchg(&nmi_handler_list, handler);
+
+	spin_unlock(&nmi_handler_lock);
+	return 0;
+}
+
+void release_nmi(struct nmi_handler *handler)
+{
+	volatile struct nmi_handler *curr, *prev;
+
+	spin_lock(&nmi_handler_lock);
+
+	/* Find it in the list. */
+	curr = nmi_handler_list;
+	prev = NULL;
+	while (curr) {
+		if (curr == handler) {
+			break;
+		}
+		prev = curr;
+		curr = curr->next;
+	}
+
+	if (curr) {
+		/* If it was found, remove it from the list.  We
+                   assume the write operation here is atomic. */
+		if (prev)
+			xchg(&(prev->next), curr->next);
+		else
+			xchg(&nmi_handler_list, curr->next);
+
+		/* If some other part of the kernel is handling an
+		   NMI, we make sure that we don't release the handler
+		   (or really, allow the user to release the handler)
+		   until it has finished handling the NMI. */
+		while (atomic_read(&calling_nmi_handlers))
+			;
+	}
+	spin_unlock(&nmi_handler_lock);
+}
+
+static int call_nmi_handlers(struct pt_regs * regs)
+{
+	volatile struct nmi_handler *curr;
+	int                         handled = 0;
+
+	atomic_inc(&calling_nmi_handlers);
+	smp_mb();
+	curr = nmi_handler_list;
+	while (curr) {
+		handled |= curr->handler(curr->dev_id, regs);
+		curr = curr->next;
+	}
+	smp_mb();
+	atomic_dec(&calling_nmi_handlers);
+	return handled;
+}
+
 static void default_do_nmi(struct pt_regs * regs)
 {
 	unsigned char reason = inb(0x61);
@@ -500,6 +589,12 @@
 			return;
 		}
 #endif
+
+		/* Check our handler list to see if anyone can handle this
+		   nmi. */
+		if (call_nmi_handlers(regs))
+			return;
+
 		unknown_nmi_error(reason, regs);
 		return;
 	}
diff -urN linux.orig/include/asm-i386/irq.h linux/include/asm-i386/irq.h
--- linux.orig/include/asm-i386/irq.h	Mon Oct 21 13:24:41 2002
+++ linux/include/asm-i386/irq.h	Mon Oct 21 20:03:52 2002
@@ -28,4 +28,16 @@
 #define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
 #endif
 
+
+/* Structure for handling NMIs */
+#define HAVE_NMI_HANDLER	1
+struct nmi_handler
+{
+	char *dev_name;
+	void *dev_id;
+	int  (*handler)(void *dev_id, struct pt_regs *regs);
+
+	volatile struct nmi_handler *next;
+};
+
 #endif /* _ASM_IRQ_H */
diff -urN linux.orig/include/linux/nmi.h linux/include/linux/nmi.h
--- linux.orig/include/linux/nmi.h	Thu Jun 20 17:53:40 2002
+++ linux/include/linux/nmi.h	Mon Oct 21 20:03:53 2002
@@ -19,4 +19,11 @@
 # define touch_nmi_watchdog() do { } while(0)
 #endif
 
+/**
+ * Register a handler to get called when an NMI occurs.  If the handler
+ * actually handles the NMI, it should return 1.
+ */
+int request_nmi(struct nmi_handler *handler);
+void release_nmi(struct nmi_handler *handler);
+
 #endif

--------------050502010600060506080207--

