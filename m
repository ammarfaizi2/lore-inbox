Return-Path: <linux-kernel-owner+w=401wt.eu-S1752288AbWL2OLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbWL2OLG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 09:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752357AbWL2OLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 09:11:06 -0500
Received: from smtp0.telegraaf.nl ([217.196.45.192]:55266 "EHLO
	smtp0.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbWL2OLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 09:11:05 -0500
Date: Fri, 29 Dec 2006 15:10:58 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-ID: <20061229141058.GM912@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com> <20061222082248.GY31882@telegraafnet.nl> <20061222003029.4394bd9a.akpm@osdl.org> <20061222144134.GH31882@telegraafnet.nl> <20061222154234.GI31882@telegraafnet.nl> <20061228155148.f5469729.akpm@osdl.org> <20061229125108.GK912@telegraafnet.nl> <20061229132759.GL912@telegraafnet.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <20061229132759.GL912@telegraafnet.nl>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 29, 2006 at 02:27:59PM +0100, Ard -kwaak- van Breemen wrote:
> I will clean up the patches found on this list to fix and detect this.

Preliminary patches:
- pci fix of Andrews patches
- parse-one detection of Yanmin
- start_kernel detection and workaround (disable them again)

These are the patches that I am about to test in the next 2
hours... :-)
Anyway: I think it is possible that other drivers are also
potential irq enablers as soon as they are called from parse_one.
Usually I compile network drivers as modules, but in diskless
setups this might not be the case :-).
-- 
program signature;
begin  { telegraaf.com
} writeln("<ard@telegraafnet.nl> TEM2");
end
.

--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pci-prevent-downread.patch"

--- linux-2.6.19.vanilla/drivers/pci/search.c	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19/drivers/pci/search.c	2006-12-29 13:58:51.000000000 +0000
@@ -193,6 +193,17 @@
 	struct pci_dev *dev;
 
 	WARN_ON(in_interrupt());
+
+	/*
+	 * pci_find_subsys() can be called on the ide_setup() path, super-early
+	 * in boot.  But the down_read() will enable local interrupts, which
+	 * can cause some machines to crash.  So here we detect and flag that
+	 * situation and bail out early.
+	 */
+	if(unlikely(list_empty(&pci_devices))) {
+		printk(KERN_INFO "pci_find_subsys() called while pci_devices is still empty\n");
+		return NULL;
+	}
 	down_read(&pci_bus_sem);
 	n = from ? from->global_list.next : pci_devices.next;
 
@@ -259,6 +270,16 @@
 	struct pci_dev *dev;
 
 	WARN_ON(in_interrupt());
+	/*
+	 * pci_get_subsys() can potentially be called by drivers super-early
+	 * in boot.  But the down_read() will enable local interrupts, which
+	 * can cause some machines to crash.  So here we detect and flag that
+	 * situation and bail out early.
+	 */
+	if(unlikely(list_empty(&pci_devices))) {
+		printk(KERN_NOTICE "pci_get_subsys() called while pci_devices is still empty\n");
+		return NULL;
+	}
 	down_read(&pci_bus_sem);
 	n = from ? from->global_list.next : pci_devices.next;
 

--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="param-parse-irq-enable-detection.patch"

--- linux-2.6.19.vanilla/kernel/params.c	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19/kernel/params.c	2006-12-29 14:02:48.000000000 +0000
@@ -53,13 +53,20 @@
 		     int (*handle_unknown)(char *param, char *val))
 {
 	unsigned int i;
+	int result;
+	int irq_was_disabled;
 
 	/* Find parameter */
 	for (i = 0; i < num_params; i++) {
 		if (parameq(param, params[i].name)) {
 			DEBUGP("They are equal!  Calling %p\n",
 			       params[i].set);
-			return params[i].set(val, &params[i]);
+			irq_was_disabled = irqs_disabled();
+			result=params[i].set(val, &params[i]);
+			if (irq_was_disabled && !irqs_disabled()) {
+				printk(KERN_WARNING "[BUG] parse_one: kerneloption '%s' enabled irq!\n",param);
+			}
+			return result;
 		}
 	}
 

--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="main-irq-enable-detection-and-disable-again.patch"

--- linux-2.6.19.vanilla/init/main.c	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19/init/main.c	2006-12-29 13:58:37.000000000 +0000
@@ -525,6 +525,10 @@
 	parse_args("Booting kernel", command_line, __start___param,
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
+	if (!irqs_disabled()) {
+		printk(KERN_WARNING "start_kernel(): bug: interrupts were enabled *very* early, fixing it\n");
+		local_irq_disable();
+	}
 	sort_main_extable();
 	trap_init();
 	rcu_init();

--KdquIMZPjGJQvRdI--
