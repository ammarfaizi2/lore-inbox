Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbSLXHp2>; Tue, 24 Dec 2002 02:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267052AbSLXHp2>; Tue, 24 Dec 2002 02:45:28 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:46607 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267049AbSLXHpX>;
	Tue, 24 Dec 2002 02:45:23 -0500
Date: Mon, 23 Dec 2002 23:49:52 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] rename and cleanup tty_register_devfs() for 2.5.53
Message-ID: <20021224074952.GF412@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Since no one wants to admit to being the tty layer maintainer, I'll just
send this patch here :)

Here's a patch against 2.5.53 that renames tty_register_devfs() and
tty_unregister_devfs() to tty_register_device() and
tty_unregister_device(), as that makes a bit more sense.  I also got rid
of the flags option to tty_register_devfs() as the only user of this was
the pty driver, so I did a special case hack for that right now (don't
worry, it's just a first cut, I'll clean that up tomorrow.)

The main reason for renaming this, is due to upcoming driver core
changes for the tty layer, and changing these function names to
something that makes more sense is just the start.  And no, I'm not
going to overhaul the tty code, I don't have the will for that right
now...

And is there any _really_ good reason why the pty driver wants to set
DEVFS_FL_WAIT to create it's nodes?  Is there syncing problem that this
solves?

Anyway, any comments or objections?

thanks,

greg k-h


# tty: change tty_*register_devfs() to tty_*register_device() and get rid of the flag paramater.

diff -Nru a/arch/mips/au1000/common/serial.c b/arch/mips/au1000/common/serial.c
--- a/arch/mips/au1000/common/serial.c	Mon Dec 23 23:00:16 2002
+++ b/arch/mips/au1000/common/serial.c	Mon Dec 23 23:00:16 2002
@@ -2682,9 +2682,9 @@
 		       (state->flags & ASYNC_FOURPORT) ? " FourPort" : "",
 		       state->port, state->irq,
 		       uart_config[state->type].name);
-		tty_register_devfs(&serial_driver, 0,
+		tty_register_device(&serial_driver,
 				   serial_driver.minor_start + state->line);
-		tty_register_devfs(&callout_driver, 0,
+		tty_register_device(&callout_driver,
 				   callout_driver.minor_start + state->line);
 	}
 	return 0;
@@ -2772,9 +2772,9 @@
 	      state->iomem_base ? "iomem" : "port",
 	      state->iomem_base ? (unsigned long)state->iomem_base :
 	      state->port, state->irq, uart_config[state->type].name);
-	tty_register_devfs(&serial_driver, 0,
+	tty_register_device(&serial_driver,
 			   serial_driver.minor_start + state->line); 
-	tty_register_devfs(&callout_driver, 0,
+	tty_register_device(&callout_driver,
 			   callout_driver.minor_start + state->line);
 	return state->line + SERIAL_DEV_OFFSET;
 }
@@ -2801,9 +2801,9 @@
 	/* These will be hidden, because they are devices that will no longer
 	 * be available to the system. (ie, PCMCIA modems, once ejected)
 	 */
-	tty_unregister_devfs(&serial_driver,
+	tty_unregister_device(&serial_driver,
 			     serial_driver.minor_start + state->line);
-	tty_unregister_devfs(&callout_driver,
+	tty_unregister_device(&callout_driver,
 			     callout_driver.minor_start + state->line);
 	restore_flags(flags);
 }
diff -Nru a/drivers/char/dz.c b/drivers/char/dz.c
--- a/drivers/char/dz.c	Mon Dec 23 23:00:16 2002
+++ b/drivers/char/dz.c	Mon Dec 23 23:00:16 2002
@@ -1425,9 +1425,9 @@
 		printk("ttyS%02d at 0x%08x (irq = %d)\n", info->line,
 		       info->port, SERIAL);
 
-		tty_register_devfs(&serial_driver, 0,
+		tty_register_device(&serial_driver,
 		                   serial_driver.minor_start + info->line);
-		tty_register_devfs(&callout_driver, 0,
+		tty_register_device(&callout_driver,
 		                   callout_driver.minor_start + info->line);
 	}
 
diff -Nru a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
--- a/drivers/char/hvc_console.c	Mon Dec 23 23:00:16 2002
+++ b/drivers/char/hvc_console.c	Mon Dec 23 23:00:16 2002
@@ -279,7 +279,7 @@
 	for (i = 0; i < hvc_driver.num; i++) {
 		hvc_struct[i].lock = SPIN_LOCK_UNLOCKED;
 		hvc_struct[i].index = i;
-		tty_register_devfs(&hvc_driver, 0, hvc_driver.minor_start + i);
+		tty_register_device(&hvc_driver, hvc_driver.minor_start + i);
 	}
 
 	if (tty_register_driver(&hvc_driver))
diff -Nru a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c	Mon Dec 23 23:00:16 2002
+++ b/drivers/char/ip2main.c	Mon Dec 23 23:00:16 2002
@@ -899,11 +899,11 @@
 			        {
 				    if ( pB->i2eChannelMap[box] & (1 << j) )
 				    {
-				        tty_register_devfs(&ip2_tty_driver,
-					    0, j + ABS_BIGGEST_BOX *
+				        tty_register_device(&ip2_tty_driver,
+					    j + ABS_BIGGEST_BOX *
 						    (box+i*ABS_MAX_BOXES));
-				            tty_register_devfs(&ip2_callout_driver,
-					    0, j + ABS_BIGGEST_BOX *
+				            tty_register_device(&ip2_callout_driver,
+					    j + ABS_BIGGEST_BOX *
 						    (box+i*ABS_MAX_BOXES));
 			    	    }
 			        }
diff -Nru a/drivers/char/pty.c b/drivers/char/pty.c
--- a/drivers/char/pty.c	Mon Dec 23 23:00:16 2002
+++ b/drivers/char/pty.c	Mon Dec 23 23:00:16 2002
@@ -97,7 +97,7 @@
 			}
 		}
 #endif
-		tty_unregister_devfs (&tty->link->driver, minor(tty->device));
+		tty_unregister_device (&tty->link->driver, minor(tty->device));
 		tty_vhangup(tty->link);
 	}
 }
@@ -307,6 +307,45 @@
 	}
 }
 
+/*
+ * FIXME: this does not call tty_register_device() which as the driver model
+ *	  changes, will need to be done.
+ *	  This function can also probably be simplified a lot...
+ */
+static void pty_register_slave (struct tty_struct *tty)
+{
+#ifdef CONFIG_DEVFS_FS
+	struct tty_driver *driver = &tty->link->driver;
+	unsigned minor = tty->link->driver.minor_start + minor(tty->device)-tty->driver.minor_start;
+	umode_t mode = S_IFCHR | S_IRUSR | S_IWUSR;
+	kdev_t device = mk_kdev(driver->major, minor);
+	int idx = minor - driver->minor_start;
+	char buf[32];
+	int flags = DEVFS_FL_CURRENT_OWNER | DEVFS_FL_WAIT,
+
+	if (IS_TTY_DEV(device) || IS_PTMX_DEV(device)) 
+		mode |= S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
+	else {
+		if (driver->major == PTY_MASTER_MAJOR)
+			mode |= S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
+	}
+	if ( (minor <  driver->minor_start) || 
+	     (minor >= driver->minor_start + driver->num) ) {
+		printk(KERN_ERR "Attempt to register invalid minor number "
+		       "with devfs (%d:%d).\n", (int)driver->major,(int)minor);
+		return;
+	}
+#  ifdef CONFIG_UNIX98_PTYS
+	if ( (driver->major >= UNIX98_PTY_SLAVE_MAJOR) &&
+	     (driver->major < UNIX98_PTY_SLAVE_MAJOR + UNIX98_NR_MAJORS) )
+		flags |= DEVFS_FL_CURRENT_OWNER;
+#  endif
+	sprintf(buf, driver->name, idx + driver->name_base);
+	devfs_register (NULL, buf, flags | DEVFS_FL_DEFAULT,
+			driver->major, minor, mode, &tty_fops, NULL);
+#endif /* CONFIG_DEVFS_FS */
+}
+
 static int pty_open(struct tty_struct *tty, struct file * filp)
 {
 	int	retval;
@@ -337,10 +376,8 @@
 
 	/*  Register a slave for the master  */
 	if (tty->driver.major == PTY_MASTER_MAJOR)
-		tty_register_devfs(&tty->link->driver,
-				   DEVFS_FL_CURRENT_OWNER | DEVFS_FL_WAIT,
-				   tty->link->driver.minor_start +
-				   minor(tty->device)-tty->driver.minor_start);
+		pty_register_slave(tty);
+
 	retval = 0;
 out:
 	return retval;
diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Mon Dec 23 23:00:16 2002
+++ b/drivers/char/tty_io.c	Mon Dec 23 23:00:16 2002
@@ -1352,7 +1352,7 @@
 		set_bit(TTY_PTY_LOCK, &tty->flags); /* LOCK THE SLAVE */
 		minor -= driver->minor_start;
 		devpts_pty_new(driver->other->name_base + minor, MKDEV(driver->other->major, minor + driver->other->minor_start));
-		tty_register_devfs(&pts_driver[major], DEVFS_FL_DEFAULT,
+		tty_register_device(&pts_driver[major],
 				   pts_driver[major].minor_start + minor);
 		noctty = 1;
 		goto init_dev_done;
@@ -2042,7 +2042,7 @@
 /*
  * Register a tty device described by <driver>, with minor number <minor>.
  */
-void tty_register_devfs (struct tty_driver *driver, unsigned int flags, unsigned minor)
+void tty_register_device (struct tty_driver *driver, unsigned minor)
 {
 #ifdef CONFIG_DEVFS_FS
 	umode_t mode = S_IFCHR | S_IRUSR | S_IWUSR;
@@ -2073,13 +2073,13 @@
 #endif /* CONFIG_DEVFS_FS */
 }
 
-void tty_unregister_devfs (struct tty_driver *driver, unsigned minor)
+void tty_unregister_device (struct tty_driver *driver, unsigned minor)
 {
 	devfs_remove(driver->name, minor-driver->minor_start+driver->name_base);
 }
 
-EXPORT_SYMBOL(tty_register_devfs);
-EXPORT_SYMBOL(tty_unregister_devfs);
+EXPORT_SYMBOL(tty_register_device);
+EXPORT_SYMBOL(tty_unregister_device);
 
 /*
  * Called by a tty driver to register itself.
@@ -2105,7 +2105,7 @@
 	
 	if ( !(driver->flags & TTY_DRIVER_NO_DEVFS) ) {
 		for(i = 0; i < driver->num; i++)
-		    tty_register_devfs(driver, 0, driver->minor_start + i);
+		    tty_register_device(driver, driver->minor_start + i);
 	}
 	proc_tty_register_driver(driver);
 	return error;
@@ -2160,7 +2160,7 @@
 			driver->termios_locked[i] = NULL;
 			kfree(tp);
 		}
-		tty_unregister_devfs(driver, driver->minor_start + i);
+		tty_unregister_device(driver, driver->minor_start + i);
 	}
 	proc_tty_unregister_driver(driver);
 	return 0;
diff -Nru a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c	Mon Dec 23 23:00:16 2002
+++ b/drivers/char/vt.c	Mon Dec 23 23:00:16 2002
@@ -2646,7 +2646,7 @@
 	int i;
 
 	for (i = 0; i < console_driver.num; i++)
-		tty_register_devfs (&console_driver, DEVFS_FL_DEFAULT,
+		tty_register_device (&console_driver,
 				    console_driver.minor_start + i);
 }
 
diff -Nru a/drivers/serial/core.c b/drivers/serial/core.c
--- a/drivers/serial/core.c	Mon Dec 23 23:00:16 2002
+++ b/drivers/serial/core.c	Mon Dec 23 23:00:16 2002
@@ -2098,7 +2098,7 @@
 	 * Register the port whether it's detected or not.  This allows
 	 * setserial to be used to alter this ports parameters.
 	 */
-	tty_register_devfs(drv->tty_driver, 0, drv->minor + port->line);
+	tty_register_device(drv->tty_driver, drv->minor + port->line);
 
 	if (port->type != PORT_UNKNOWN) {
 		unsigned long flags;
@@ -2155,7 +2155,7 @@
 	/*
 	 * Remove the devices from devfs
 	 */
-	tty_unregister_devfs(drv->tty_driver, drv->minor + port->line);
+	tty_unregister_device(drv->tty_driver, drv->minor + port->line);
 
 	/*
 	 * Free the port IO and memory resources, if any.
diff -Nru a/drivers/tc/zs.c b/drivers/tc/zs.c
--- a/drivers/tc/zs.c	Mon Dec 23 23:00:16 2002
+++ b/drivers/tc/zs.c	Mon Dec 23 23:00:16 2002
@@ -1971,9 +1971,9 @@
 		printk("ttyS%02d at 0x%08x (irq = %d)", info->line, 
 		       info->port, info->irq);
 		printk(" is a Z85C30 SCC\n");
-		tty_register_devfs(&serial_driver, 0,
+		tty_register_device(&serial_driver,
 				   serial_driver.minor_start + info->line);
-		tty_register_devfs(&callout_driver, 0,
+		tty_register_device(&callout_driver,
 				   callout_driver.minor_start + info->line);
 
 	}
diff -Nru a/drivers/usb/class/bluetty.c b/drivers/usb/class/bluetty.c
--- a/drivers/usb/class/bluetty.c	Mon Dec 23 23:00:16 2002
+++ b/drivers/usb/class/bluetty.c	Mon Dec 23 23:00:16 2002
@@ -1201,7 +1201,7 @@
 		     bluetooth, endpoint->bInterval);
 
 	/* initialize the devfs nodes for this device and let the user know what bluetooths we are bound to */
-	tty_register_devfs (&bluetooth_tty_driver, 0, minor);
+	tty_register_device (&bluetooth_tty_driver, minor);
 	info("Bluetooth converter now attached to ttyUB%d (or usb/ttub/%d for devfs)", minor, minor);
 
 	bluetooth_table[minor] = bluetooth;
@@ -1267,7 +1267,7 @@
 		if (bluetooth->interrupt_in_buffer)
 			kfree (bluetooth->interrupt_in_buffer);
 
-		tty_unregister_devfs (&bluetooth_tty_driver, bluetooth->minor);
+		tty_unregister_device (&bluetooth_tty_driver, bluetooth->minor);
 
 		for (i = 0; i < NUM_BULK_URBS; ++i) {
 			if (bluetooth->write_urb_pool[i]) {
diff -Nru a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
--- a/drivers/usb/class/cdc-acm.c	Mon Dec 23 23:00:16 2002
+++ b/drivers/usb/class/cdc-acm.c	Mon Dec 23 23:00:16 2002
@@ -361,7 +361,7 @@
 			usb_unlink_urb(acm->writeurb);
 			usb_unlink_urb(acm->readurb);
 		} else {
-			tty_unregister_devfs(&acm_tty_driver, acm->minor);
+			tty_unregister_device(&acm_tty_driver, acm->minor);
 			acm_table[acm->minor] = NULL;
 			usb_free_urb(acm->ctrlurb);
 			usb_free_urb(acm->readurb);
@@ -649,7 +649,7 @@
 		usb_driver_claim_interface(&acm_driver, acm->iface + 0, acm);
 		usb_driver_claim_interface(&acm_driver, acm->iface + 1, acm);
 
-		tty_register_devfs(&acm_tty_driver, 0, minor);
+		tty_register_device(&acm_tty_driver, minor);
 
 		acm_table[minor] = acm;
 		dev_set_drvdata (&intf->dev, acm);
@@ -681,7 +681,7 @@
 	usb_driver_release_interface(&acm_driver, acm->iface + 1);
 
 	if (!acm->used) {
-		tty_unregister_devfs(&acm_tty_driver, acm->minor);
+		tty_unregister_device(&acm_tty_driver, acm->minor);
 		acm_table[acm->minor] = NULL;
 		usb_free_urb(acm->ctrlurb);
 		usb_free_urb(acm->readurb);
diff -Nru a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
--- a/drivers/usb/serial/bus.c	Mon Dec 23 23:00:16 2002
+++ b/drivers/usb/serial/bus.c	Mon Dec 23 23:00:16 2002
@@ -78,7 +78,7 @@
 
 	minor = port->number;
 
-	tty_register_devfs (&usb_serial_tty_driver, 0, minor);
+	tty_register_device (&usb_serial_tty_driver, minor);
 	info("%s converter now attached to ttyUSB%d (or usb/tts/%d for devfs)",
 	     driver->name, minor, minor);
 
@@ -110,7 +110,7 @@
 	}
 exit:
 	minor = port->number;
-	tty_unregister_devfs (&usb_serial_tty_driver, minor);
+	tty_unregister_device (&usb_serial_tty_driver, minor);
 	info("%s converter now disconnected from ttyUSB%d",
 	     driver->name, minor);
 
diff -Nru a/include/linux/tty.h b/include/linux/tty.h
--- a/include/linux/tty.h	Mon Dec 23 23:00:16 2002
+++ b/include/linux/tty.h	Mon Dec 23 23:00:16 2002
@@ -379,9 +379,8 @@
 extern int tty_register_ldisc(int disc, struct tty_ldisc *new_ldisc);
 extern int tty_register_driver(struct tty_driver *driver);
 extern int tty_unregister_driver(struct tty_driver *driver);
-extern void tty_register_devfs (struct tty_driver *driver, unsigned int flags,
-				unsigned minor);
-extern void tty_unregister_devfs (struct tty_driver *driver, unsigned minor);
+extern void tty_register_device(struct tty_driver *driver, unsigned minor);
+extern void tty_unregister_device(struct tty_driver *driver, unsigned minor);
 extern int tty_read_raw_data(struct tty_struct *tty, unsigned char *bufp,
 			     int buflen);
 extern void tty_write_message(struct tty_struct *tty, char *msg);
