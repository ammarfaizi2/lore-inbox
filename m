Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKKVkS>; Sat, 11 Nov 2000 16:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129092AbQKKVkI>; Sat, 11 Nov 2000 16:40:08 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:61961 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S129178AbQKKVj7>; Sat, 11 Nov 2000 16:39:59 -0500
Date: Sat, 11 Nov 2000 21:40:55 GMT
Message-Id: <200011112140.VAA32829@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda22 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda22 (was: Re: The IrDA patches)
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

The name of this patch is irda22.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda22.diff :
-----------------
	o [FEATURE] Cleaner module init
	o [FEATURE] Remove dependancy on irmanager
	o [FEATURE] Move remaining irmod.c content to irsyms.c
	o [FEATURE] Cleaner use of MOD_INC_USE_COUNT

diff -urpN old-linux/net/irda/Makefile linux/net/irda/Makefile
--- old-linux/net/irda/Makefile	Sun Aug  6 11:23:41 2000
+++ linux/net/irda/Makefile	Thu Nov  9 18:02:46 2000
@@ -17,7 +17,7 @@ O_OBJS	 := iriap.o iriap_event.o irlmp.o
             irlap.o irlap_event.o irlap_frame.o timer.o qos.o irqueue.o \
             irttp.o irda_device.o irias_object.o crc.o wrapper.o af_irda.o \
 	    discovery.o parameters.o
-OX_OBJS := irmod.o
+OX_OBJS := irsyms.o
 
 ifeq ($(CONFIG_IRDA),m)
 M_OBJS   := $(O_TARGET)
diff -urpN old-linux/net/irda/af_irda.c linux/net/irda/af_irda.c
--- old-linux/net/irda/af_irda.c	Thu Nov  9 17:57:45 2000
+++ linux/net/irda/af_irda.c	Thu Nov  9 17:59:48 2000
@@ -7,7 +7,7 @@
  * Author:        Dag Brattli <dagb@cs.uit.no>
  * Created at:    Sun May 31 10:12:43 1998
  * Modified at:   Sat Dec 25 21:10:23 1999
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * Modified by:   Dag Brattli <dag@brattli.net>
  * Sources:       af_netroom.c, af_ax25.c, af_rose.c, af_x25.c etc.
  * 
  *     Copyright (c) 1999 Dag Brattli <dagb@cs.uit.no>
@@ -43,10 +43,11 @@
  ********************************************************************/
 
 #include <linux/config.h>
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/socket.h>
 #include <linux/sockios.h>
+#include <linux/init.h>
 #include <linux/if_arp.h>
 #include <linux/net.h>
 #include <linux/irda.h>
@@ -81,6 +82,10 @@ static struct proto_ops irda_ultra_ops;
 
 #define IRDA_MAX_HEADER (TTP_MAX_HEADER)
 
+#ifdef CONFIG_IRDA_DEBUG
+__u32 irda_debug = IRDA_DEBUG_LEVEL;
+#endif
+
 /*
  * Function irda_data_indication (instance, sap, skb)
  *
@@ -1124,8 +1129,7 @@ static int irda_create(struct socket *so
 	self->daddr = DEV_ADDR_ANY;	/* Until we get connected */
 	self->saddr = 0x0;		/* so IrLMP assign us any link */
 
-	/* Notify that we are using the irda module, so nobody removes it */
-	irda_mod_inc_use_count();
+	MOD_INC_USE_COUNT;
 
 	return 0;
 }
@@ -1169,10 +1173,8 @@ void irda_destroy_socket(struct irda_soc
 	}
 #endif /* CONFIG_IRDA_ULTRA */
 	kfree(self);
-
-	/* Notify that we are not using the irda module anymore */
-	irda_mod_dec_use_count();
-
+	MOD_DEC_USE_COUNT;
+	
 	return;
 }
 
@@ -2369,25 +2371,44 @@ static struct notifier_block irda_dev_no
 };
 
 /*
+ * Function irda_proc_modcount (inode, fill)
+ *
+ *    Use by the proc file system functions to prevent the irda module
+ *    being removed while the use is standing in the net/irda directory
+ */
+void irda_proc_modcount(struct inode *inode, int fill)
+{
+#ifdef MODULE
+#ifdef CONFIG_PROC_FS
+	if (fill)
+		MOD_INC_USE_COUNT;
+	else
+		MOD_DEC_USE_COUNT;
+#endif /* CONFIG_PROC_FS */
+#endif /* MODULE */
+}
+
+/*
  * Function irda_proto_init (pro)
  *
  *    Initialize IrDA protocol layer
  *
  */
-static int __init irda_proto_init(void)
+int __init irda_proto_init(void)
 {
-	MESSAGE("IrDA (tm) Protocols for Linux-2.4 (Dag Brattli)\n");
+	sock_register(&irda_family_ops);
 
-        sock_register(&irda_family_ops);
-	
-        irda_packet_type.type = htons(ETH_P_IRDA);
-	dev_add_pack(&irda_packet_type);
-	
-        register_netdevice_notifier(&irda_dev_notifier);
-	
+	irda_packet_type.type = htons(ETH_P_IRDA);
+        dev_add_pack(&irda_packet_type);
+
+	register_netdevice_notifier(&irda_dev_notifier);
+
+	irda_init();
+#ifdef MODULE
+ 	irda_device_init();  /* Called by init/main.c when non-modular */
+#endif
 	return 0;
 }
-module_init(irda_proto_init);
 
 /*
  * Function irda_proto_cleanup (void)
@@ -2395,13 +2416,24 @@ module_init(irda_proto_init);
  *    Remove IrDA protocol layer
  *
  */
-void __exit irda_proto_cleanup(void)
+#ifdef MODULE
+void irda_proto_cleanup(void)
 {
 	irda_packet_type.type = htons(ETH_P_IRDA);
-	dev_remove_pack(&irda_packet_type);
+        dev_remove_pack(&irda_packet_type);
 
-	unregister_netdevice_notifier(&irda_dev_notifier);
+        unregister_netdevice_notifier(&irda_dev_notifier);
 	
 	sock_unregister(PF_IRDA);
+	irda_cleanup();
+	
+        return;
 }
+module_init(irda_proto_init);
 module_exit(irda_proto_cleanup);
+ 
+MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_DESCRIPTION("The Linux IrDA Protocol Subsystem"); 
+MODULE_PARM(irda_debug, "1l");
+#endif /* MODULE */
+
diff -urpN old-linux/net/irda/irlmp.c linux/net/irda/irlmp.c
--- old-linux/net/irda/irlmp.c	Thu Nov  9 17:57:45 2000
+++ linux/net/irda/irlmp.c	Thu Nov  9 17:59:48 2000
@@ -74,6 +74,7 @@ int irlmp_proc_read(char *buf, char **st
  */
 int __init irlmp_init(void)
 {
+	IRDA_DEBUG(0, __FUNCTION__ "()\n");
 	/* Initialize the irlmp structure. */
 	irlmp = kmalloc( sizeof(struct irlmp_cb), GFP_KERNEL);
 	if (irlmp == NULL)
@@ -787,7 +788,6 @@ struct irda_device_info *irlmp_get_disco
 void irlmp_check_services(discovery_t *discovery)
 {
 	struct irlmp_client *client;
-	struct irmanager_event event;
 	__u8 *service_log;
 	__u8 service;
 	int i = 0;
@@ -815,14 +815,7 @@ void irlmp_check_services(discovery_t *d
 				continue;
 			/*  
 			 * Found no clients for dealing with this service,
-			 * so ask the user space irmanager to try to load
-			 * the right module for us 
 			 */
-			event.event = EVENT_DEVICE_DISCOVERED;
-			event.service = service;
-			event.daddr = discovery->daddr;
-			sprintf(event.info, "%s", discovery->info);
-			irmanager_notify(&event);
 		}
 	}
 	kfree(service_log);
@@ -1357,6 +1350,9 @@ __u32 irlmp_register_client(__u16 hint_m
 	irlmp_client_t *client;
 	__u32 handle;
 
+	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	ASSERT(irlmp != NULL, return 0;);
+	
 	/* Get a unique handle for this client */
 	get_random_bytes(&handle, sizeof(handle));
 	while (hashbin_find(irlmp->clients, handle, NULL) || !handle)
@@ -1366,7 +1362,6 @@ __u32 irlmp_register_client(__u16 hint_m
  	client = kmalloc(sizeof(irlmp_client_t), GFP_ATOMIC);
 	if (!client) {
 		IRDA_DEBUG( 1, __FUNCTION__ "(), Unable to kmalloc!\n");
-
 		return 0;
 	}
 
diff -urpN old-linux/net/irda/irmod.c linux/net/irda/irmod.c
--- old-linux/net/irda/irmod.c	Thu Nov  9 17:52:56 2000
+++ linux/net/irda/irmod.c	Wed Dec 31 16:00:00 1969
@@ -1,557 +0,0 @@
-/*********************************************************************
- *                
- * Filename:      irmod.c
- * Version:       0.8
- * Description:   IrDA module code and some other stuff
- * Status:        Experimental.
- * Author:        Dag Brattli <dagb@cs.uit.no>
- * Created at:    Mon Dec 15 13:55:39 1997
- * Modified at:   Wed Jan  5 15:12:41 2000
- * Modified by:   Dag Brattli <dagb@cs.uit.no>
- * 
- *     Copyright (c) 1997, 1999-2000 Dag Brattli, All Rights Reserved.
- *      
- *     This program is free software; you can redistribute it and/or 
- *     modify it under the terms of the GNU General Public License as 
- *     published by the Free Software Foundation; either version 2 of 
- *     the License, or (at your option) any later version.
- *  
- *     Neither Dag Brattli nor University of Tromsø admit liability nor
- *     provide warranty for any of this software. This material is 
- *     provided "AS-IS" and at no charge.
- *     
- ********************************************************************/
-
-#include <linux/config.h>
-#include <linux/module.h> 
-
-#include <linux/init.h>
-#include <linux/poll.h>
-#include <linux/proc_fs.h>
-#include <linux/smp_lock.h>
-
-#include <asm/segment.h>
-
-#include <net/irda/irda.h>
-#include <net/irda/irmod.h>
-#include <net/irda/irlap.h>
-#ifdef CONFIG_IRDA_COMPRESSION
-#include <net/irda/irlap_comp.h>
-#endif /* CONFIG_IRDA_COMPRESSION */
-#include <net/irda/irlmp.h>
-#include <net/irda/iriap.h>
-#include <net/irda/irias_object.h>
-#include <net/irda/irttp.h>
-#include <net/irda/irda_device.h>
-#include <net/irda/wrapper.h>
-#include <net/irda/timer.h>
-#include <net/irda/parameters.h>
-
-extern struct proc_dir_entry *proc_irda;
-
-struct irda_cb irda; /* One global instance */
-
-#ifdef CONFIG_IRDA_DEBUG
-__u32 irda_debug = IRDA_DEBUG_LEVEL;
-#endif
-
-extern void irda_proc_register(void);
-extern void irda_proc_unregister(void);
-extern int  irda_sysctl_register(void);
-extern void irda_sysctl_unregister(void);
-
-extern void irda_proto_init(struct net_proto *pro);
-extern void irda_proto_cleanup(void);
-
-extern int irda_device_init(void);
-extern int irlan_init(void);
-extern int irlan_client_init(void);
-extern int irlan_server_init(void);
-extern int ircomm_init(void);
-extern int ircomm_tty_init(void);
-extern int irlpt_client_init(void);
-extern int irlpt_server_init(void);
-
-#ifdef CONFIG_IRDA_COMPRESSION
-#ifdef CONFIG_IRDA_DEFLATE
-extern irda_deflate_init();
-#endif /* CONFIG_IRDA_DEFLATE */
-#endif /* CONFIG_IRDA_COMPRESSION */
-
-static int irda_open(struct inode * inode, struct file *file);
-static int irda_ioctl(struct inode *inode, struct file *filp, 
-		      unsigned int cmd, unsigned long arg);
-static int irda_close(struct inode *inode, struct file *file);
-static ssize_t irda_read(struct file *file, char *buffer, size_t count, 
-			 loff_t *noidea);
-static ssize_t irda_write(struct file *file, const char *buffer,
-			  size_t count, loff_t *noidea);
-static u_int irda_poll(struct file *file, poll_table *wait);
-
-static struct file_operations irda_fops = {
-	owner:		THIS_MODULE,
-	read:		irda_read,
-	write:		irda_write,
-	poll:		irda_poll,
-	ioctl:		irda_ioctl,
-	open:		irda_open,
-	release:	irda_close,
-};
-
-/* IrTTP */
-EXPORT_SYMBOL(irttp_open_tsap);
-EXPORT_SYMBOL(irttp_close_tsap);
-EXPORT_SYMBOL(irttp_connect_response);
-EXPORT_SYMBOL(irttp_data_request);
-EXPORT_SYMBOL(irttp_disconnect_request);
-EXPORT_SYMBOL(irttp_flow_request);
-EXPORT_SYMBOL(irttp_connect_request);
-EXPORT_SYMBOL(irttp_udata_request);
-EXPORT_SYMBOL(irttp_dup);
-
-/* Main IrDA module */
-#ifdef CONFIG_IRDA_DEBUG
-EXPORT_SYMBOL(irda_debug);
-#endif
-EXPORT_SYMBOL(irda_notify_init);
-EXPORT_SYMBOL(irmanager_notify);
-EXPORT_SYMBOL(irda_lock);
-#ifdef CONFIG_PROC_FS
-EXPORT_SYMBOL(proc_irda);
-#endif
-EXPORT_SYMBOL(irda_param_insert);
-EXPORT_SYMBOL(irda_param_extract);
-EXPORT_SYMBOL(irda_param_extract_all);
-EXPORT_SYMBOL(irda_param_pack);
-EXPORT_SYMBOL(irda_param_unpack);
-
-/* IrIAP/IrIAS */
-EXPORT_SYMBOL(iriap_open);
-EXPORT_SYMBOL(iriap_close);
-EXPORT_SYMBOL(iriap_getvaluebyclass_request);
-EXPORT_SYMBOL(irias_object_change_attribute);
-EXPORT_SYMBOL(irias_add_integer_attrib);
-EXPORT_SYMBOL(irias_add_octseq_attrib);
-EXPORT_SYMBOL(irias_add_string_attrib);
-EXPORT_SYMBOL(irias_insert_object);
-EXPORT_SYMBOL(irias_new_object);
-EXPORT_SYMBOL(irias_delete_object);
-EXPORT_SYMBOL(irias_delete_value);
-EXPORT_SYMBOL(irias_find_object);
-EXPORT_SYMBOL(irias_find_attrib);
-EXPORT_SYMBOL(irias_new_integer_value);
-EXPORT_SYMBOL(irias_new_string_value);
-EXPORT_SYMBOL(irias_new_octseq_value);
-
-/* IrLMP */
-EXPORT_SYMBOL(irlmp_discovery_request);
-EXPORT_SYMBOL(irlmp_get_discoveries);
-EXPORT_SYMBOL(sysctl_discovery_timeout);
-EXPORT_SYMBOL(irlmp_register_client);
-EXPORT_SYMBOL(irlmp_unregister_client);
-EXPORT_SYMBOL(irlmp_update_client);
-EXPORT_SYMBOL(irlmp_register_service);
-EXPORT_SYMBOL(irlmp_unregister_service);
-EXPORT_SYMBOL(irlmp_service_to_hint);
-EXPORT_SYMBOL(irlmp_data_request);
-EXPORT_SYMBOL(irlmp_open_lsap);
-EXPORT_SYMBOL(irlmp_close_lsap);
-EXPORT_SYMBOL(irlmp_connect_request);
-EXPORT_SYMBOL(irlmp_connect_response);
-EXPORT_SYMBOL(irlmp_disconnect_request);
-EXPORT_SYMBOL(irlmp_get_daddr);
-EXPORT_SYMBOL(irlmp_get_saddr);
-EXPORT_SYMBOL(irlmp_dup);
-EXPORT_SYMBOL(lmp_reasons);
-
-/* Queue */
-EXPORT_SYMBOL(hashbin_find);
-EXPORT_SYMBOL(hashbin_new);
-EXPORT_SYMBOL(hashbin_insert);
-EXPORT_SYMBOL(hashbin_delete);
-EXPORT_SYMBOL(hashbin_remove);
-EXPORT_SYMBOL(hashbin_remove_this);
-EXPORT_SYMBOL(hashbin_get_next);
-EXPORT_SYMBOL(hashbin_get_first);
-
-/* IrLAP */
-EXPORT_SYMBOL(irlap_open);
-EXPORT_SYMBOL(irlap_close);
-#ifdef CONFIG_IRDA_COMPRESSION
-EXPORT_SYMBOL(irda_unregister_compressor);
-EXPORT_SYMBOL(irda_register_compressor);
-#endif /* CONFIG_IRDA_COMPRESSION */
-EXPORT_SYMBOL(irda_init_max_qos_capabilies);
-EXPORT_SYMBOL(irda_qos_bits_to_value);
-EXPORT_SYMBOL(irda_device_setup);
-EXPORT_SYMBOL(irda_device_set_media_busy);
-EXPORT_SYMBOL(irda_device_txqueue_empty);
-
-EXPORT_SYMBOL(irda_device_dongle_init);
-EXPORT_SYMBOL(irda_device_dongle_cleanup);
-EXPORT_SYMBOL(irda_device_register_dongle);
-EXPORT_SYMBOL(irda_device_unregister_dongle);
-EXPORT_SYMBOL(irda_task_execute);
-EXPORT_SYMBOL(irda_task_kick);
-EXPORT_SYMBOL(irda_task_next_state);
-EXPORT_SYMBOL(irda_task_delete);
-
-EXPORT_SYMBOL(async_wrap_skb);
-EXPORT_SYMBOL(async_unwrap_char);
-EXPORT_SYMBOL(irda_start_timer);
-EXPORT_SYMBOL(setup_dma);
-EXPORT_SYMBOL(infrared_mode);
-
-#ifdef CONFIG_IRTTY
-EXPORT_SYMBOL(irtty_set_dtr_rts);
-EXPORT_SYMBOL(irtty_register_dongle);
-EXPORT_SYMBOL(irtty_unregister_dongle);
-EXPORT_SYMBOL(irtty_set_packet_mode);
-#endif
-
-static int __init irda_init(void)
-{
-#ifdef MODULE
-	irda_proto_init(NULL);	/* Called by net/socket.c when non-modular */
-#endif
- 	irlmp_init();
-	irlap_init();
-	
-#ifdef MODULE
-	irda_device_init();	/* Called by init/main.c when non-modular */
-#endif
-	iriap_init();
- 	irttp_init();
-	
-#ifdef CONFIG_PROC_FS
-	irda_proc_register();
-#endif
-#ifdef CONFIG_SYSCTL
-	irda_sysctl_register();
-#endif
-	init_waitqueue_head(&irda.wait_queue);
-	irda.dev.minor = MISC_DYNAMIC_MINOR;
-	irda.dev.name = "irda";
-	irda.dev.fops = &irda_fops;
-	
-	misc_register(&irda.dev);
-
-	irda.in_use = FALSE;
-	
-	init_waitqueue_head(&irda.wait_queue);
-
-	/* 
-	 * Initialize modules that got compiled into the kernel 
-	 */
-#ifdef CONFIG_IRLAN
-	irlan_init();
-#endif
-#ifdef CONFIG_IRCOMM
-	ircomm_init();
-	ircomm_tty_init();
-#endif
-
-#ifdef CONFIG_IRDA_COMPRESSION
-#ifdef CONFIG_IRDA_DEFLATE
-	irda_deflate_init();
-#endif /* CONFIG_IRDA_DEFLATE */
-#endif /* CONFIG_IRDA_COMPRESSION */
-
-	return 0;
-}
-
-static void __exit irda_cleanup(void)
-{
-	irda_proto_cleanup();
-
-	misc_deregister(&irda.dev);
-
-#ifdef CONFIG_SYSCTL
-	irda_sysctl_unregister();
-#endif	
-
-#ifdef CONFIG_PROC_FS
-	irda_proc_unregister();
-#endif
-	/* Remove higher layers */
-	irttp_cleanup();
-	iriap_cleanup();
-
-	/* Remove lower layers */
-	irda_device_cleanup();
-	irlap_cleanup(); /* Must be done before irlmp_cleanup()! DB */
-
-	/* Remove middle layer */
-	irlmp_cleanup();
-}
-
-/*
- * Function irda_unlock (lock)
- *
- *    Unlock variable. Returns false if lock is already unlocked
- *
- */
-inline int irda_unlock(int *lock) 
-{
-	if (!test_and_clear_bit(0, (void *) lock))  {
-		printk("Trying to unlock already unlocked variable!\n");
-		return FALSE;
-        }
-	return TRUE;
-}
-
-/*
- * Function irda_notify_init (notify)
- *
- *    Used for initializing the notify structure
- *
- */
-void irda_notify_init(notify_t *notify)
-{
-	notify->data_indication = NULL;
-	notify->udata_indication = NULL;
-	notify->connect_confirm = NULL;
-	notify->connect_indication = NULL;
-	notify->disconnect_indication = NULL;
-	notify->flow_indication = NULL;
-	notify->status_indication = NULL;
-	notify->instance = NULL;
-	strncpy(notify->name, "Unknown", NOTIFY_MAX_NAME);
-}
-
-/*
- * Function irda_execute_as_process (self, callback, param)
- *
- *    If a layer needs to have a function executed with a process context,
- *    then it can register the function here, and the function will then 
- *    be executed as fast as possible.
- *
- */
-void irda_execute_as_process( void *self, TODO_CALLBACK callback, __u32 param)
-{
-	struct irda_todo *new;
-	struct irmanager_event event;
-
-	/* Make sure irmanager is running */
-	if (!irda.in_use) {
-		return;
-	}
-
-	/* Make new todo event */
-	new = (struct irda_todo *) kmalloc( sizeof(struct irda_todo),
-					    GFP_ATOMIC);
-	if ( new == NULL) {
-		return;
-	}
-	memset( new, 0, sizeof( struct irda_todo));
-
-	new->self = self;
-	new->callback = callback;
-	new->param = param;
-	
-	/* Queue todo */
-	enqueue_last(&irda.todo_queue, (irda_queue_t *) new);
-
-	event.event = EVENT_NEED_PROCESS_CONTEXT;
-
-	/* Notify the user space manager */
-	irmanager_notify(&event);
-}
-
-/*
- * Function irmanger_notify (event)
- *
- *    Send an event to the user space manager
- *
- */
-void irmanager_notify( struct irmanager_event *event)
-{
-	struct irda_event *new;
-	
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-	
-	/* Make sure irmanager is running */
-	if (!irda.in_use) {
-		return;
-	}
-
-	/* Make new IrDA Event */
-	new = (struct irda_event *) kmalloc( sizeof(struct irda_event),
-					     GFP_ATOMIC);
-	if ( new == NULL) {
-		return;	
-	}
-	memset(new, 0, sizeof( struct irda_event));
-	new->event = *event;
-	
-	/* Queue event */
-	enqueue_last(&irda.event_queue, (irda_queue_t *) new);
-	
-	/* Wake up irmanager sleeping on read */
-	wake_up_interruptible(&irda.wait_queue);
-}
-
-static int irda_open( struct inode * inode, struct file *file)
-{
-	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
-
-	lock_kernel();
-	if (irda.in_use) {
-		unlock_kernel();
-		IRDA_DEBUG(0, __FUNCTION__ 
-			   "(), irmanager is already running!\n");
-		return -1;
-	}
-	irda.in_use = TRUE;
-	unlock_kernel();
-	
-	return 0;
-}
-
-/*
- * Function irda_ioctl (inode, filp, cmd, arg)
- *
- *    Ioctl, used by irmanager to ...
- *
- */
-static int irda_ioctl(struct inode *inode, struct file *filp, 
-		      unsigned int cmd, unsigned long arg)
-{
-	struct irda_todo *todo;
-	int err = 0;
-	int size = _IOC_SIZE(cmd);
-	
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-	
-	if (_IOC_DIR(cmd) & _IOC_READ)
-		err = verify_area( VERIFY_WRITE, (void *) arg, size);
-	else if (_IOC_DIR(cmd) & _IOC_WRITE)
-		err = verify_area( VERIFY_READ, (void *) arg, size);
-	if (err)
-		return err;
-	
-	switch (cmd) {
-	case IRMGR_IOCTNPC:
-		/* Got process context! */
-		IRDA_DEBUG(4, __FUNCTION__ "(), got process context!\n");
-		
-		while ((todo = (struct irda_todo *) dequeue_first( 
-			&irda.todo_queue)) != NULL)
-		{
-			todo->callback(todo->self, todo->param);
-
-			kfree(todo);
-		}
-		break;
-
-	default:
-		return -ENOIOCTLCMD;
-	}
-	
-	return 0;
-}
-
-static int irda_close(struct inode *inode, struct file *file)
-{
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-	
-	lock_kernel();
-	irda.in_use = FALSE;
-	unlock_kernel();
-
-	return 0;
-}
-
-static ssize_t irda_read(struct file *file, char *buffer, size_t count, 
-			 loff_t *noidea)
-{
-	struct irda_event *event;
-	unsigned long flags;
-	int len;
-
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-
-	/* * Go to sleep and wait for event if there is no event to be read! */
-	save_flags( flags);
-	cli();
-	if ( !irda.event_queue)
-		interruptible_sleep_on( &irda.wait_queue);
-	restore_flags(flags);
-	
-	/*
-	 *  Ensure proper reaction to signals, and screen out 
-	 *  blocked signals (page 112. linux device drivers)
-	 */
-	if (signal_pending( current))
-		return -ERESTARTSYS;
-
-	event = (struct irda_event *) dequeue_first( &irda.event_queue);
-	if (!event)
-		return 0;
-
-	len = sizeof(struct irmanager_event);
-	copy_to_user(buffer, &event->event, len);
-
-	/* Finished with event */
-	kfree(event);
-
-	return len;
-}
-
-static ssize_t irda_write(struct file *file, const char *buffer,
-			  size_t count, loff_t *noidea)
-{
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
-	
-	return 0;
-}
-
-static u_int irda_poll(struct file *file, poll_table *wait)
-{
-	IRDA_DEBUG(0, __FUNCTION__ "(), Sorry not implemented yet!\n");
-
-	return 0;
-}
-
-void irda_mod_inc_use_count(void)
-{
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-}
-
-void irda_mod_dec_use_count(void)
-{
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-}
-
-/*
- * Function irda_proc_modcount (inode, fill)
- *
- *    Use by the proc file system functions to prevent the irda module
- *    being removed while the use is standing in the net/irda directory
- */
-void irda_proc_modcount(struct inode *inode, int fill)
-{
-#ifdef MODULE
-#ifdef CONFIG_PROC_FS
-	if (fill)
-		MOD_INC_USE_COUNT;
-	else
-		MOD_DEC_USE_COUNT;
-#endif /* CONFIG_PROC_FS */
-#endif /* MODULE */
-}
-
-
-MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
-MODULE_DESCRIPTION("The Linux IrDA Protocol Subsystem"); 
-#ifdef CONFIG_IRDA_DEBUG
-MODULE_PARM(irda_debug, "1l");
-MODULE_PARM_DESC(irda_debug, "IrDA debug level");
-#endif
-
-module_init(irda_init);
-module_exit(irda_cleanup);
diff -urpN old-linux/net/irda/irsyms.c linux/net/irda/irsyms.c
--- old-linux/net/irda/irsyms.c	Wed Dec 31 16:00:00 1969
+++ linux/net/irda/irsyms.c	Thu Nov  9 17:59:48 2000
@@ -0,0 +1,275 @@
+/*********************************************************************
+ *                
+ * Filename:      irsyms.c
+ * Version:       0.9
+ * Description:   IrDA module symbols
+ * Status:        Experimental.
+ * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Created at:    Mon Dec 15 13:55:39 1997
+ * Modified at:   Wed Jan  5 15:12:41 2000
+ * Modified by:   Dag Brattli <dagb@cs.uit.no>
+ * 
+ *     Copyright (c) 1997, 1999-2000 Dag Brattli, All Rights Reserved.
+ *      
+ *     This program is free software; you can redistribute it and/or 
+ *     modify it under the terms of the GNU General Public License as 
+ *     published by the Free Software Foundation; either version 2 of 
+ *     the License, or (at your option) any later version.
+ *  
+ *     Neither Dag Brattli nor University of Tromsø admit liability nor
+ *     provide warranty for any of this software. This material is 
+ *     provided "AS-IS" and at no charge.
+ *     
+ ********************************************************************/
+
+#include <linux/config.h>
+#include <linux/module.h>
+
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/proc_fs.h>
+#include <linux/smp_lock.h>
+
+#include <asm/segment.h>
+
+#include <net/irda/irda.h>
+#include <net/irda/irmod.h>
+#include <net/irda/irlap.h>
+#ifdef CONFIG_IRDA_COMPRESSION
+#include <net/irda/irlap_comp.h>
+#endif /* CONFIG_IRDA_COMPRESSION */
+#include <net/irda/irlmp.h>
+#include <net/irda/iriap.h>
+#include <net/irda/irias_object.h>
+#include <net/irda/irttp.h>
+#include <net/irda/irda_device.h>
+#include <net/irda/wrapper.h>
+#include <net/irda/timer.h>
+#include <net/irda/parameters.h>
+
+extern struct proc_dir_entry *proc_irda;
+
+extern void irda_proc_register(void);
+extern void irda_proc_unregister(void);
+extern int  irda_sysctl_register(void);
+extern void irda_sysctl_unregister(void);
+
+extern int irda_proto_init(void);
+extern void irda_proto_cleanup(void);
+
+extern int irda_device_init(void);
+extern int irlan_init(void);
+extern int irlan_client_init(void);
+extern int irlan_server_init(void);
+extern int ircomm_init(void);
+extern int ircomm_tty_init(void);
+extern int irlpt_client_init(void);
+extern int irlpt_server_init(void);
+
+#ifdef CONFIG_IRDA_COMPRESSION
+#ifdef CONFIG_IRDA_DEFLATE
+extern irda_deflate_init();
+#endif /* CONFIG_IRDA_DEFLATE */
+#endif /* CONFIG_IRDA_COMPRESSION */
+
+/* IrTTP */
+EXPORT_SYMBOL(irttp_open_tsap);
+EXPORT_SYMBOL(irttp_close_tsap);
+EXPORT_SYMBOL(irttp_connect_response);
+EXPORT_SYMBOL(irttp_data_request);
+EXPORT_SYMBOL(irttp_disconnect_request);
+EXPORT_SYMBOL(irttp_flow_request);
+EXPORT_SYMBOL(irttp_connect_request);
+EXPORT_SYMBOL(irttp_udata_request);
+EXPORT_SYMBOL(irttp_dup);
+
+/* Main IrDA module */
+#ifdef CONFIG_IRDA_DEBUG
+EXPORT_SYMBOL(irda_debug);
+#endif
+EXPORT_SYMBOL(irda_notify_init);
+EXPORT_SYMBOL(irda_lock);
+#ifdef CONFIG_PROC_FS
+EXPORT_SYMBOL(proc_irda);
+#endif
+EXPORT_SYMBOL(irda_param_insert);
+EXPORT_SYMBOL(irda_param_extract);
+EXPORT_SYMBOL(irda_param_extract_all);
+EXPORT_SYMBOL(irda_param_pack);
+EXPORT_SYMBOL(irda_param_unpack);
+
+/* IrIAP/IrIAS */
+EXPORT_SYMBOL(iriap_open);
+EXPORT_SYMBOL(iriap_close);
+EXPORT_SYMBOL(iriap_getvaluebyclass_request);
+EXPORT_SYMBOL(irias_object_change_attribute);
+EXPORT_SYMBOL(irias_add_integer_attrib);
+EXPORT_SYMBOL(irias_add_octseq_attrib);
+EXPORT_SYMBOL(irias_add_string_attrib);
+EXPORT_SYMBOL(irias_insert_object);
+EXPORT_SYMBOL(irias_new_object);
+EXPORT_SYMBOL(irias_delete_object);
+EXPORT_SYMBOL(irias_delete_value);
+EXPORT_SYMBOL(irias_find_object);
+EXPORT_SYMBOL(irias_find_attrib);
+EXPORT_SYMBOL(irias_new_integer_value);
+EXPORT_SYMBOL(irias_new_string_value);
+EXPORT_SYMBOL(irias_new_octseq_value);
+
+/* IrLMP */
+EXPORT_SYMBOL(irlmp_discovery_request);
+EXPORT_SYMBOL(irlmp_get_discoveries);
+EXPORT_SYMBOL(sysctl_discovery_timeout);
+EXPORT_SYMBOL(irlmp_register_client);
+EXPORT_SYMBOL(irlmp_unregister_client);
+EXPORT_SYMBOL(irlmp_update_client);
+EXPORT_SYMBOL(irlmp_register_service);
+EXPORT_SYMBOL(irlmp_unregister_service);
+EXPORT_SYMBOL(irlmp_service_to_hint);
+EXPORT_SYMBOL(irlmp_data_request);
+EXPORT_SYMBOL(irlmp_open_lsap);
+EXPORT_SYMBOL(irlmp_close_lsap);
+EXPORT_SYMBOL(irlmp_connect_request);
+EXPORT_SYMBOL(irlmp_connect_response);
+EXPORT_SYMBOL(irlmp_disconnect_request);
+EXPORT_SYMBOL(irlmp_get_daddr);
+EXPORT_SYMBOL(irlmp_get_saddr);
+EXPORT_SYMBOL(irlmp_dup);
+EXPORT_SYMBOL(lmp_reasons);
+
+/* Queue */
+EXPORT_SYMBOL(hashbin_find);
+EXPORT_SYMBOL(hashbin_new);
+EXPORT_SYMBOL(hashbin_insert);
+EXPORT_SYMBOL(hashbin_delete);
+EXPORT_SYMBOL(hashbin_remove);
+EXPORT_SYMBOL(hashbin_remove_this);
+EXPORT_SYMBOL(hashbin_get_next);
+EXPORT_SYMBOL(hashbin_get_first);
+
+/* IrLAP */
+EXPORT_SYMBOL(irlap_open);
+EXPORT_SYMBOL(irlap_close);
+#ifdef CONFIG_IRDA_COMPRESSION
+EXPORT_SYMBOL(irda_unregister_compressor);
+EXPORT_SYMBOL(irda_register_compressor);
+#endif /* CONFIG_IRDA_COMPRESSION */
+EXPORT_SYMBOL(irda_init_max_qos_capabilies);
+EXPORT_SYMBOL(irda_qos_bits_to_value);
+EXPORT_SYMBOL(irda_device_setup);
+EXPORT_SYMBOL(irda_device_set_media_busy);
+EXPORT_SYMBOL(irda_device_txqueue_empty);
+
+EXPORT_SYMBOL(irda_device_dongle_init);
+EXPORT_SYMBOL(irda_device_dongle_cleanup);
+EXPORT_SYMBOL(irda_device_register_dongle);
+EXPORT_SYMBOL(irda_device_unregister_dongle);
+EXPORT_SYMBOL(irda_task_execute);
+EXPORT_SYMBOL(irda_task_kick);
+EXPORT_SYMBOL(irda_task_next_state);
+EXPORT_SYMBOL(irda_task_delete);
+
+EXPORT_SYMBOL(async_wrap_skb);
+EXPORT_SYMBOL(async_unwrap_char);
+EXPORT_SYMBOL(irda_start_timer);
+EXPORT_SYMBOL(setup_dma);
+EXPORT_SYMBOL(infrared_mode);
+
+#ifdef CONFIG_IRTTY
+EXPORT_SYMBOL(irtty_set_dtr_rts);
+EXPORT_SYMBOL(irtty_register_dongle);
+EXPORT_SYMBOL(irtty_unregister_dongle);
+EXPORT_SYMBOL(irtty_set_packet_mode);
+#endif
+
+static int __init irda_init(void)
+{
+	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+
+ 	irlmp_init();
+	irlap_init();
+	
+	iriap_init();
+ 	irttp_init();
+	
+#ifdef CONFIG_PROC_FS
+	irda_proc_register();
+#endif
+#ifdef CONFIG_SYSCTL
+	irda_sysctl_register();
+#endif
+	/* 
+	 * Initialize modules that got compiled into the kernel 
+	 */
+#ifdef CONFIG_IRLAN
+	irlan_init();
+#endif
+#ifdef CONFIG_IRCOMM
+	ircomm_init();
+	ircomm_tty_init();
+#endif
+
+#ifdef CONFIG_IRDA_COMPRESSION
+#ifdef CONFIG_IRDA_DEFLATE
+	irda_deflate_init();
+#endif /* CONFIG_IRDA_DEFLATE */
+#endif /* CONFIG_IRDA_COMPRESSION */
+
+	return 0;
+}
+
+static void __exit irda_cleanup(void)
+{
+#ifdef CONFIG_SYSCTL
+	irda_sysctl_unregister();
+#endif	
+
+#ifdef CONFIG_PROC_FS
+	irda_proc_unregister();
+#endif
+	/* Remove higher layers */
+	irttp_cleanup();
+	iriap_cleanup();
+
+	/* Remove lower layers */
+	irda_device_cleanup();
+	irlap_cleanup(); /* Must be done before irlmp_cleanup()! DB */
+
+	/* Remove middle layer */
+	irlmp_cleanup();
+}
+
+/*
+ * Function irda_unlock (lock)
+ *
+ *    Unlock variable. Returns false if lock is already unlocked
+ *
+ */
+inline int irda_unlock(int *lock) 
+{
+	if (!test_and_clear_bit(0, (void *) lock))  {
+		printk("Trying to unlock already unlocked variable!\n");
+		return FALSE;
+        }
+	return TRUE;
+}
+
+/*
+ * Function irda_notify_init (notify)
+ *
+ *    Used for initializing the notify structure
+ *
+ */
+void irda_notify_init(notify_t *notify)
+{
+	notify->data_indication = NULL;
+	notify->udata_indication = NULL;
+	notify->connect_confirm = NULL;
+	notify->connect_indication = NULL;
+	notify->disconnect_indication = NULL;
+	notify->flow_indication = NULL;
+	notify->status_indication = NULL;
+	notify->instance = NULL;
+	strncpy(notify->name, "Unknown", NOTIFY_MAX_NAME);
+}
+


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
