Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132527AbQKKVM4>; Sat, 11 Nov 2000 16:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132570AbQKKVMg>; Sat, 11 Nov 2000 16:12:36 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:38665 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S132560AbQKKVMY>; Sat, 11 Nov 2000 16:12:24 -0500
Date: Sat, 11 Nov 2000 21:13:24 GMT
Message-Id: <200011112113.VAA32062@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda11 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda11 (was: Re: The IrDA patches)
Cc: linux-kernel@vger.kernel.org
From: Dag Brattli <dagb@fast.no>
To: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here are the new IrDA patches for Linux-2.4.0-test10. Please apply them to
your latest 2.4 code. If you decide to apply them, then I suggest you start
with the first one (irda1.diff) and work your way to the last one 
(irda24.diff) since most of them are not commutative. 

The name of this patch is irda11.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda11.diff :
-----------------
	o [CRITICA] Correct use of random number generator
        o [CRITICA] Fixed parameter parsing bug
        o [CRITICA] Fix packet lenght test in SMC driver
	o [CORRECT] Fix module initialisation code [not sure about this one]
	o [FEATURE] Setting device name update IAS

diff -urpN old-linux/drivers/net/irda/smc-ircc.c linux/drivers/net/irda/smc-ircc.c
--- old-linux/drivers/net/irda/smc-ircc.c	Wed Jul  5 10:56:13 2000
+++ linux/drivers/net/irda/smc-ircc.c	Thu Nov  9 14:52:26 2000
@@ -814,7 +814,7 @@ static void ircc_dma_receive_complete(st
 	else
 		len -= 4;
 
-	if ((len < 2) && (len > 2050)) {
+	if ((len < 2) || (len > 2050)) {
 		WARNING(__FUNCTION__ "(), bogus len=%d\n", len);
 		return;
 	}
diff -urpN old-linux/net/irda/af_irda.c linux/net/irda/af_irda.c
--- old-linux/net/irda/af_irda.c	Thu Nov  9 13:48:34 2000
+++ linux/net/irda/af_irda.c	Thu Nov  9 16:03:21 2000
@@ -2376,14 +2376,15 @@ static struct notifier_block irda_dev_no
  */
 static int __init irda_proto_init(void)
 {
+	MESSAGE("IrDA (tm) Protocols for Linux-2.3 (Dag Brattli)\n");
+
         sock_register(&irda_family_ops);
 	
         irda_packet_type.type = htons(ETH_P_IRDA);
-        dev_add_pack(&irda_packet_type);
+	dev_add_pack(&irda_packet_type);
 	
         register_netdevice_notifier(&irda_dev_notifier);
 	
-        irda_init();
 	return 0;
 }
 module_init(irda_proto_init);
@@ -2394,18 +2395,13 @@ module_init(irda_proto_init);
  *    Remove IrDA protocol layer
  *
  */
-#ifdef MODULE
 void irda_proto_cleanup(void)
 {
 	irda_packet_type.type = htons(ETH_P_IRDA);
-        dev_remove_pack(&irda_packet_type);
+	dev_remove_pack(&irda_packet_type);
 
-        unregister_netdevice_notifier(&irda_dev_notifier);
+	unregister_netdevice_notifier(&irda_dev_notifier);
 	
 	sock_unregister(PF_IRDA);
-	irda_cleanup();
-	
-        return;
 }
 module_exit(irda_proto_cleanup);
-#endif /* MODULE */
diff -urpN old-linux/net/irda/irlap.c linux/net/irda/irlap.c
--- old-linux/net/irda/irlap.c	Thu Nov  9 14:51:15 2000
+++ linux/net/irda/irlap.c	Thu Nov  9 14:52:26 2000
@@ -671,11 +671,16 @@ void irlap_reset_confirm(void)
  */
 int irlap_generate_rand_time_slot(int S, int s) 
 {
+	static int rand;
 	int slot;
 	
 	ASSERT((S - s) > 0, return 0;);
 
-	slot = s + jiffies % (S-s);
+	rand += jiffies;
+	rand ^= (rand << 12);
+	rand ^= (rand >> 20);
+
+	slot = s + rand % (S-s);
 	
 	ASSERT((slot >= s) || (slot < S), return 0;);
 	
diff -urpN old-linux/net/irda/irmod.c linux/net/irda/irmod.c
--- old-linux/net/irda/irmod.c	Thu Nov  9 14:47:22 2000
+++ linux/net/irda/irmod.c	Thu Nov  9 16:05:08 2000
@@ -208,10 +208,11 @@ EXPORT_SYMBOL(irtty_unregister_dongle);
 EXPORT_SYMBOL(irtty_set_packet_mode);
 #endif
 
-int __init irda_init(void)
+static int __init irda_init(void)
 {
-	MESSAGE("IrDA (tm) Protocols for Linux-2.3 (Dag Brattli)\n");
-	
+#ifdef MODULE
+	irda_proto_init(NULL);	/* Called by net/socket.c when non-modular */
+#endif
  	irlmp_init();
 	irlap_init();
 	
@@ -258,9 +259,10 @@ int __init irda_init(void)
 	return 0;
 }
 
-#ifdef MODULE
-void irda_cleanup(void)
+static void __exit irda_cleanup(void)
 {
+	irda_proto_cleanup();
+
 	misc_deregister(&irda.dev);
 
 #ifdef CONFIG_SYSCTL
@@ -281,7 +283,6 @@ void irda_cleanup(void)
 	/* Remove middle layer */
 	irlmp_cleanup();
 }
-#endif /* MODULE */
 
 /*
  * Function irda_unlock (lock)
@@ -542,11 +543,10 @@ void irda_proc_modcount(struct inode *in
 #endif /* MODULE */
 }
 
-#ifdef MODULE
 
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
 MODULE_DESCRIPTION("The Linux IrDA Protocol Subsystem"); 
 MODULE_PARM(irda_debug, "1l");
-module_exit(irda_proto_cleanup);
-#endif /* MODULE */
 
+module_init(irda_init);
+module_exit(irda_cleanup);
diff -urpN old-linux/net/irda/irsysctl.c linux/net/irda/irsysctl.c
--- old-linux/net/irda/irsysctl.c	Mon Aug 30 10:26:28 1999
+++ linux/net/irda/irsysctl.c	Thu Nov  9 14:52:26 2000
@@ -29,6 +29,7 @@
 #include <asm/segment.h>
 
 #include <net/irda/irda.h>
+#include <net/irda/irias_object.h>
 
 #define NET_IRDA 412 /* Random number */
 enum { DISCOVERY=1, DEVNAME, COMPRESSION, DEBUG, SLOTS, DISCOVERY_TIMEOUT, 
@@ -46,12 +47,28 @@ extern char sysctl_devname[];
 extern unsigned int irda_debug;
 #endif
 
+static int do_devname(ctl_table *table, int write, struct file *filp,
+		      void *buffer, size_t *lenp)
+{
+	int ret;
+
+	ret = proc_dostring(table, write, filp, buffer, lenp);
+	if (ret == 0 && write) {
+		struct ias_value *val;
+
+		val = irias_new_string_value(sysctl_devname);
+		if (val)
+			irias_object_change_attribute("Device", "DeviceName", val);
+	}
+	return ret;
+}
+
 /* One file */
 static ctl_table irda_table[] = {
 	{ DISCOVERY, "discovery", &sysctl_discovery,
 	  sizeof(int), 0644, NULL, &proc_dointvec },
 	{ DEVNAME, "devname", sysctl_devname,
-	  65, 0644, NULL, &proc_dostring, &sysctl_string},
+	  65, 0644, NULL, &do_devname, &sysctl_string},
 	{ COMPRESSION, "compression", &sysctl_compression,
 	  sizeof(int), 0644, NULL, &proc_dointvec },
 #ifdef CONFIG_IRDA_DEBUG
diff -urpN old-linux/net/irda/parameters.c linux/net/irda/parameters.c
--- old-linux/net/irda/parameters.c	Tue Mar 21 11:17:28 2000
+++ linux/net/irda/parameters.c	Thu Nov  9 14:52:26 2000
@@ -513,10 +513,7 @@ int irda_param_extract(void *self, __u8 
 		      buf[0]);
 		
 		/* Skip this parameter */
-		n += (2 + buf[n+1]);
-		len -= (2 + buf[n+1]);
-
-		return 0;  /* Continue */
+		return 2 + buf[n + 1];  /* Continue */
 	}
 
 	/* Lookup the info on how to parse this parameter */
@@ -532,10 +529,7 @@ int irda_param_extract(void *self, __u8 
 	if (!pi_minor_info->func) {
 		MESSAGE(__FUNCTION__"(), no handler for pi=%#x\n", buf[n]);
 		/* Skip this parameter */
-		n += (2 + buf[n+1]);
-		len -= (2 + buf[n+1]);
-
-		return 0; /* Continue */
+		return 2 + buf[n + 1]; /* Continue */
 	}
 
 	/* Parse parameter value */


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
