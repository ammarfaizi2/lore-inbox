Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268120AbTBNXgZ>; Fri, 14 Feb 2003 18:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268168AbTBNXgZ>; Fri, 14 Feb 2003 18:36:25 -0500
Received: from air-2.osdl.org ([65.172.181.6]:19840 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S268120AbTBNXgN>;
	Fri, 14 Feb 2003 18:36:13 -0500
Date: Fri, 14 Feb 2003 15:45:57 -0800
From: Bob Miller <rem@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.60 2/9] Update parport class driver to new module loader API.
Message-ID: <20030214234557.GC13336@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes to the parport class driver to allow removal of depricated
check_region() and MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT methods.

Also fixed an allocate race in parport_register_port().  The old code would
lock the portlist to find the next parallel port device number to use.
After figuring this out, the list would be unlocked to do all the memory
allocations for the new device.  After the new parallel port device
data structures were all setup, parport_register_port() would re-lock
the portlist to insert the new device.  But, it would not check to make
sure that some other code didn't already install a device with the
same number.  I changed the code to, after all device setup, lock
the list, find the number, update the members that need the number
and then insert the device into the list all on same list lock round-trip.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


diff -Nru a/include/linux/parport.h b/include/linux/parport.h
--- a/include/linux/parport.h	Fri Feb 14 09:50:44 2003
+++ b/include/linux/parport.h	Fri Feb 14 09:50:44 2003
@@ -166,7 +166,7 @@
 	void (*save_state)(struct parport *, struct parport_state *);
 	void (*restore_state)(struct parport *, struct parport_state *);
 
-	void (*inc_use_count)(void);
+	int (*inc_use_count)(void);
 	void (*dec_use_count)(void);
 
 	/* Block read/write */
@@ -542,7 +542,7 @@
 extern int parport_default_proc_unregister(void);
 
 extern void dec_parport_count(void);
-extern void inc_parport_count(void);
+extern int inc_parport_count(void);
 
 /* If PC hardware is the only type supported, we can optimise a bit.  */
 #if (defined(CONFIG_PARPORT_PC) || defined(CONFIG_PARPORT_PC_MODULE)) && !(defined(CONFIG_PARPORT_ARC) || defined(CONFIG_PARPORT_ARC_MODULE)) && !(defined(CONFIG_PARPORT_AMIGA) || defined(CONFIG_PARPORT_AMIGA_MODULE)) && !(defined(CONFIG_PARPORT_MFC3) || defined(CONFIG_PARPORT_MFC3_MODULE)) && !(defined(CONFIG_PARPORT_ATARI) || defined(CONFIG_PARPORT_ATARI_MODULE)) && !(defined(CONFIG_USB_USS720) || defined(CONFIG_USB_USS720_MODULE)) && !(defined(CONFIG_PARPORT_SUNBPP) || defined(CONFIG_PARPORT_SUNBPP_MODULE)) && !defined(CONFIG_PARPORT_OTHER)
diff -Nru a/drivers/parport/init.c b/drivers/parport/init.c
--- a/drivers/parport/init.c	Fri Feb 14 09:50:44 2003
+++ b/drivers/parport/init.c	Fri Feb 14 09:50:44 2003
@@ -228,16 +228,12 @@
 EXPORT_SYMBOL(parport_find_class);
 #endif
 
-void inc_parport_count(void)
+int inc_parport_count(void)
 {
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
+	return try_module_get(THIS_MODULE);
 }
 
 void dec_parport_count(void)
 {
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
+	module_put(THIS_MODULE);
 }
diff -Nru a/drivers/parport/share.c b/drivers/parport/share.c
--- a/drivers/parport/share.c	Fri Feb 14 09:50:44 2003
+++ b/drivers/parport/share.c	Fri Feb 14 09:50:44 2003
@@ -56,6 +56,7 @@
 static void dead_initstate (struct pardevice *d, struct parport_state *s) { }
 static void dead_state (struct parport *p, struct parport_state *s) { }
 static void dead_noargs (void) { }
+static int  idead_noargs (void) { return 0; }
 static size_t dead_write (struct parport *p, const void *b, size_t l, int f)
 { return 0; }
 static size_t dead_read (struct parport *p, void *b, size_t l, int f)
@@ -74,7 +75,7 @@
 	dead_initstate,		/* init_state */
 	dead_state,
 	dead_state,
-	dead_noargs,		/* xxx_use_count */
+	idead_noargs,		/* xxx_use_count */
 	dead_noargs,
 	dead_write,		/* epp */
 	dead_read,
@@ -390,25 +391,6 @@
 		return NULL;
 	}
 
-	/* Search for the lowest free parport number. */
-
-	spin_lock_irq (&parportlist_lock);
-	for (portnum = 0; ; portnum++) {
-		struct parport *itr = portlist;
-		while (itr) {
-			if (itr->number == portnum)
-				/* No good, already used. */
-				break;
-			else
-				itr = itr->next;
-		}
-
-		if (itr == NULL)
-			/* Got to the end of the list. */
-			break;
-	}
-	spin_unlock_irq (&parportlist_lock);
-	
 	/* Init our structure */
  	memset(tmp, 0, sizeof(struct parport));
 	tmp->base = base;
@@ -420,7 +402,6 @@
 	tmp->devices = tmp->cad = NULL;
 	tmp->flags = 0;
 	tmp->ops = ops;
-	tmp->portnum = tmp->number = portnum;
 	tmp->physport = tmp;
 	memset (tmp->probe_info, 0, 5 * sizeof (struct parport_device_info));
 	tmp->cad_lock = RW_LOCK_UNLOCKED;
@@ -438,9 +419,32 @@
 		kfree(tmp);
 		return NULL;
 	}
+	/* Search for the lowest free parport number. */
+
+	spin_lock_irq (&parportlist_lock);
+	for (portnum = 0; ; portnum++) {
+		struct parport *itr = portlist;
+		while (itr) {
+			if (itr->number == portnum)
+				/* No good, already used. */
+				break;
+			else
+				itr = itr->next;
+		}
+
+		if (itr == NULL)
+			/* Got to the end of the list. */
+			break;
+	}
+
+	/*
+	 * Now that the portnum is known finish doing the Init.
+	 */
+	tmp->portnum = tmp->number = portnum;
 	sprintf(name, "parport%d", portnum);
 	tmp->name = name;
 
+	
 	/*
 	 * Chain the entry to our list.
 	 *
@@ -448,8 +452,6 @@
 	 * to clear irq on the local CPU. -arca
 	 */
 
-	spin_lock(&parportlist_lock);
-
 	/* We are locked against anyone else performing alterations, but
 	 * because of parport_enumerate people can still _read_ the list
 	 * while we are changing it; so be careful..
@@ -664,8 +666,13 @@
            kmalloc.  To be absolutely safe, we have to require that
            our caller doesn't sleep in between parport_enumerate and
            parport_register_device.. */
-	inc_parport_count();
-	port->ops->inc_use_count();
+	if (!inc_parport_count()) {
+		return NULL;
+	}
+	if (!port->ops->inc_use_count()) {
+		goto out_dec_port;
+	}
+		
 	parport_get_port (port);
 
 	tmp = kmalloc(sizeof(struct pardevice), GFP_KERNEL);
@@ -736,9 +743,10 @@
  out_free_pardevice:
 	kfree (tmp);
  out:
-	dec_parport_count();
-	port->ops->dec_use_count();
 	parport_put_port (port);
+	port->ops->dec_use_count();
+ out_dec_port:
+	dec_parport_count();
 	return NULL;
 }
