Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315300AbSFTTcc>; Thu, 20 Jun 2002 15:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSFTTcb>; Thu, 20 Jun 2002 15:32:31 -0400
Received: from mail201.mail.bellsouth.net ([205.152.58.141]:8389 "EHLO
	imf01bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S315300AbSFTTcO>; Thu, 20 Jun 2002 15:32:14 -0400
Message-ID: <3D122DAB.5BE5DF34@bellsouth.net>
Date: Thu, 20 Jun 2002 15:31:55 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.23 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] 2.5.23 i2c updates 2/4
Content-Type: multipart/mixed;
 boundary="------------F44A8E91E4982DC21A1C752B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F44A8E91E4982DC21A1C752B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Linus,
Please apply patch 2/4 for i2c updates against 2.5.23
Thanks,
Albert
http://personal.atl.bellsouth.net/mia/a/c/ac9410/albert/albert.html
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
--------------F44A8E91E4982DC21A1C752B
Content-Type: text/plain; charset=iso-8859-1;
 name="2.5.23-i2c-2-patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="2.5.23-i2c-2-patch"

# i2c-core.c:Leave LINUX_VERSION in kernel.  Leave i2c_debug=1.  Leave
#   CONFIG names as in the kernel.  Remove #ifdef MODULE_LICENSE around 
#   MODULE_LICENSE.
# i2c-dev.c:Remove #ifdef MODULE_LICENSE around MODULE_LICENSE.
#   Remove compatibality code for < 2.4.0
# i2c-proc.c: Print message on kmalloc failure.  Leave ENOMEM as in kernel.
#   Remove #ifdef MODULE_LICENSE around MODULE_LICENSE.  Remove 2.2.19 compat
#   code.
#
--- linux/drivers/i2c/i2c-core.c.orig	2002-05-09 18:22:06.000000000 -0400
+++ linux/drivers/i2c/i2c-core.c	2002-06-17 01:00:21.000000000 -0400
@@ -20,7 +20,7 @@
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi>.
    All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-core.c,v 1.64 2001/08/13 01:35:56 mds Exp $ */
+/* $Id: i2c-core.c,v 1.73 2002/03/03 17:37:44 mds Exp $ */
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -28,7 +28,6 @@
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/config.h>
-
 #include <linux/i2c.h>
 
 /* ----- compatibility stuff ----------------------------------------------- */
@@ -158,7 +157,7 @@
 
 		proc_entry = create_proc_entry(name,0,proc_bus);
 		if (! proc_entry) {
-			printk("i2c-core.o: Could not create /proc/bus/%s\n",
+			printk(KERN_ERR "i2c-core.o: Could not create /proc/bus/%s\n",
 			       name);
 			res = -ENOENT;
 			goto ERROR1;
@@ -188,7 +187,7 @@
 			drivers[j]->attach_adapter(adap);
 	DRV_UNLOCK();
 	
-	DEB(printk("i2c-core.o: adapter %s registered as adapter %d.\n",
+	DEB(printk(KERN_DEBUG "i2c-core.o: adapter %s registered as adapter %d.\n",
 	           adap->name,i));
 
 	return 0;	
@@ -214,7 +213,7 @@
 		if (adap == adapters[i])
 			break;
 	if (I2C_ADAP_MAX == i) {
-		printk( "i2c-core.o: unregister_adapter adap [%s] not found.\n",
+		printk( KERN_WARNING "i2c-core.o: unregister_adapter adap [%s] not found.\n",
 			adap->name);
 		res = -ENODEV;
 		goto ERROR0;
@@ -229,7 +228,7 @@
 	for (j = 0; j < I2C_DRIVER_MAX; j++) 
 		if (drivers[j] && (drivers[j]->flags & I2C_DF_DUMMY))
 			if ((res = drivers[j]->attach_adapter(adap))) {
-				printk("i2c-core.o: can't detach adapter %s "
+				printk(KERN_WARNING "i2c-core.o: can't detach adapter %s "
 				       "while detaching driver %s: driver not "
 				       "detached!",adap->name,drivers[j]->name);
 				goto ERROR1;	
@@ -247,7 +246,7 @@
 		     * must be deleted, as this would cause invalid states.
 		     */
 			if ((res=client->driver->detach_client(client))) {
-				printk("i2c-core.o: adapter %s not "
+				printk(KERN_ERR "i2c-core.o: adapter %s not "
 					"unregistered, because client at "
 					"address %02x can't be detached. ",
 					adap->name, client->addr);
@@ -266,7 +265,7 @@
 	adap_count--;
 	
 	ADAP_UNLOCK();	
-	DEB(printk("i2c-core.o: adapter unregistered: %s\n",adap->name));
+	DEB(printk(KERN_DEBUG "i2c-core.o: adapter unregistered: %s\n",adap->name));
 	return 0;
 
 ERROR0:
@@ -305,7 +304,7 @@
 	
 	DRV_UNLOCK();	/* driver was successfully added */
 	
-	DEB(printk("i2c-core.o: driver %s registered.\n",driver->name));
+	DEB(printk(KERN_DEBUG "i2c-core.o: driver %s registered.\n",driver->name));
 	
 	ADAP_LOCK();
 
@@ -340,7 +339,7 @@
 	 * attached. If so, detach them to be able to kill the driver 
 	 * afterwards.
 	 */
-	DEB2(printk("i2c-core.o: unregister_driver - looking for clients.\n"));
+	DEB2(printk(KERN_DEBUG "i2c-core.o: unregister_driver - looking for clients.\n"));
 	/* removing clients does not depend on the notify flag, else 
 	 * invalid operation might (will!) result, when using stale client
 	 * pointers.
@@ -350,7 +349,7 @@
 		struct i2c_adapter *adap = adapters[k];
 		if (adap == NULL) /* skip empty entries. */
 			continue;
-		DEB2(printk("i2c-core.o: examining adapter %s:\n",
+		DEB2(printk(KERN_DEBUG "i2c-core.o: examining adapter %s:\n",
 			    adap->name));
 		if (driver->flags & I2C_DF_DUMMY) {
 		/* DUMMY drivers do not register their clients, so we have to
@@ -359,7 +358,7 @@
 		 * this or hell will break loose...  
 		 */
 			if ((res = driver->attach_adapter(adap))) {
-				printk("i2c-core.o: while unregistering "
+				printk(KERN_WARNING "i2c-core.o: while unregistering "
 				       "dummy driver %s, adapter %s could "
 				       "not be detached properly; driver "
 				       "not unloaded!",driver->name,
@@ -378,7 +377,7 @@
 					if ((res = driver->
 							detach_client(client)))
 					{
-						printk("i2c-core.o: while "
+						printk(KERN_ERR "i2c-core.o: while "
 						       "unregistering driver "
 						       "`%s', the client at "
 						       "address %02x of "
@@ -400,7 +399,7 @@
 	driver_count--;
 	DRV_UNLOCK();
 	
-	DEB(printk("i2c-core.o: driver unregistered: %s\n",driver->name));
+	DEB(printk(KERN_DEBUG "i2c-core.o: driver unregistered: %s\n",driver->name));
 	return 0;
 }
 
@@ -436,10 +435,10 @@
 	
 	if (adapter->client_register) 
 		if (adapter->client_register(client)) 
-			printk("i2c-core.o: warning: client_register seems "
+			printk(KERN_DEBUG "i2c-core.o: warning: client_register seems "
 			       "to have failed for client %02x at adapter %s\n",
 			       client->addr,adapter->name);
-	DEB(printk("i2c-core.o: client [%s] registered to adapter [%s](pos. %d).\n",
+	DEB(printk(KERN_DEBUG "i2c-core.o: client [%s] registered to adapter [%s](pos. %d).\n",
 		client->name, adapter->name,i));
 
 	if(client->flags & I2C_CLIENT_ALLOW_USE)
@@ -470,7 +469,7 @@
 	
 	if (adapter->client_unregister != NULL) 
 		if ((res = adapter->client_unregister(client))) {
-			printk("i2c-core.o: client_unregister [%s] failed, "
+			printk(KERN_ERR "i2c-core.o: client_unregister [%s] failed, "
 			       "client not detached",client->name);
 			return res;
 		}
@@ -478,7 +477,7 @@
 	adapter->clients[i] = NULL;
 	adapter->client_count--;
 
-	DEB(printk("i2c-core.o: client [%s] unregistered.\n",client->name));
+	DEB(printk(KERN_DEBUG "i2c-core.o: client [%s] unregistered.\n",client->name));
 	return 0;
 }
 
@@ -659,12 +658,12 @@
 	int i,j,k,order_nr,len=0,len_total;
 	int order[I2C_CLIENT_MAX];
 
-	if (count > 4000)
+	if (count > 4096)
 		return -EINVAL; 
 	len_total = file->f_pos + count;
 	/* Too bad if this gets longer (unlikely) */
-	if (len_total > 4000)
-		len_total = 4000;
+	if (len_total > 4096)
+		len_total = 4096;
 	for (i = 0; i < I2C_ADAP_MAX; i++)
 		if (adapters[i]->inode == inode->i_ino) {
 		/* We need a bit of slack in the kernel buffer; this makes the
@@ -720,13 +719,13 @@
 	i2cproc_initialized = 0;
 
 	if (! proc_bus) {
-		printk("i2c-core.o: /proc/bus/ does not exist");
+		printk(KERN_ERR "i2c-core.o: /proc/bus/ does not exist");
 		i2cproc_cleanup();
 		return -ENOENT;
  	} 
 	proc_bus_i2c = create_proc_entry("i2c",0,proc_bus);
 	if (!proc_bus_i2c) {
-		printk("i2c-core.o: Could not create /proc/bus/i2c");
+		printk(KERN_ERR "i2c-core.o: Could not create /proc/bus/i2c");
 		i2cproc_cleanup();
 		return -ENOENT;
  	}
@@ -763,7 +762,7 @@
 	int ret;
 
 	if (adap->algo->master_xfer) {
- 	 	DEB2(printk("i2c-core.o: master_xfer: %s with %d msgs.\n",
+ 	 	DEB2(printk(KERN_DEBUG "i2c-core.o: master_xfer: %s with %d msgs.\n",
 		            adap->name,num));
 
 		I2C_LOCK(adap);
@@ -772,7 +771,7 @@
 
 		return ret;
 	} else {
-		printk("i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
+		printk(KERN_ERR "i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
 		       adap->id);
 		return -ENOSYS;
 	}
@@ -790,7 +789,7 @@
 		msg.len = count;
 		(const char *)msg.buf = buf;
 	
-		DEB2(printk("i2c-core.o: master_send: writing %d bytes on %s.\n",
+		DEB2(printk(KERN_DEBUG "i2c-core.o: master_send: writing %d bytes on %s.\n",
 			count,client->adapter->name));
 	
 		I2C_LOCK(adap);
@@ -802,7 +801,7 @@
 		 */
 		return (ret == 1 )? count : ret;
 	} else {
-		printk("i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
+		printk(KERN_ERR "i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
 		       client->adapter->id);
 		return -ENOSYS;
 	}
@@ -820,14 +819,14 @@
 		msg.len = count;
 		msg.buf = buf;
 
-		DEB2(printk("i2c-core.o: master_recv: reading %d bytes on %s.\n",
+		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: reading %d bytes on %s.\n",
 			count,client->adapter->name));
 	
 		I2C_LOCK(adap);
 		ret = adap->algo->master_xfer(adap,&msg,1);
 		I2C_UNLOCK(adap);
 	
-		DEB2(printk("i2c-core.o: master_recv: return:%d (count:%d, addr:0x%02x)\n",
+		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: return:%d (count:%d, addr:0x%02x)\n",
 			ret, count, client->addr));
 	
 		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
@@ -835,7 +834,7 @@
 	 	*/
 		return (ret == 1 )? count : ret;
 	} else {
-		printk("i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
+		printk(KERN_DEBUG "i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
 		       client->adapter->id);
 		return -ENOSYS;
 	}
@@ -848,7 +847,7 @@
 	int ret = 0;
 	struct i2c_adapter *adap = client->adapter;
 
-	DEB2(printk("i2c-core.o: i2c ioctl, cmd: 0x%x, arg: %#lx\n", cmd, arg));
+	DEB2(printk(KERN_DEBUG "i2c-core.o: i2c ioctl, cmd: 0x%x, arg: %#lx\n", cmd, arg));
 	switch ( cmd ) {
 		case I2C_RETRIES:
 			adap->retries = arg;
@@ -893,7 +892,7 @@
 			if (((adap_id == address_data->force[i]) || 
 			     (address_data->force[i] == ANY_I2C_BUS)) &&
 			     (addr == address_data->force[i+1])) {
-				DEB2(printk("i2c-core.o: found force parameter for adapter %d, addr %04x\n",
+				DEB2(printk(KERN_DEBUG "i2c-core.o: found force parameter for adapter %d, addr %04x\n",
 				            adap_id,addr));
 				if ((err = found_proc(adapter,addr,0,0)))
 					return err;
@@ -911,7 +910,7 @@
 			if (((adap_id == address_data->ignore[i]) || 
 			    ((address_data->ignore[i] == ANY_I2C_BUS))) &&
 			    (addr == address_data->ignore[i+1])) {
-				DEB2(printk("i2c-core.o: found ignore parameter for adapter %d, "
+				DEB2(printk(KERN_DEBUG "i2c-core.o: found ignore parameter for adapter %d, "
 				     "addr %04x\n", adap_id ,addr));
 				found = 1;
 			}
@@ -923,7 +922,7 @@
 			    ((address_data->ignore_range[i]==ANY_I2C_BUS))) &&
 			    (addr >= address_data->ignore_range[i+1]) &&
 			    (addr <= address_data->ignore_range[i+2])) {
-				DEB2(printk("i2c-core.o: found ignore_range parameter for adapter %d, "
+				DEB2(printk(KERN_DEBUG "i2c-core.o: found ignore_range parameter for adapter %d, "
 				            "addr %04x\n", adap_id,addr));
 				found = 1;
 			}
@@ -938,7 +937,7 @@
 		     i += 1) {
 			if (addr == address_data->normal_i2c[i]) {
 				found = 1;
-				DEB2(printk("i2c-core.o: found normal i2c entry for adapter %d, "
+				DEB2(printk(KERN_DEBUG "i2c-core.o: found normal i2c entry for adapter %d, "
 				            "addr %02x", adap_id,addr));
 			}
 		}
@@ -949,7 +948,7 @@
 			if ((addr >= address_data->normal_i2c_range[i]) &&
 			    (addr <= address_data->normal_i2c_range[i+1])) {
 				found = 1;
-				DEB2(printk("i2c-core.o: found normal i2c_range entry for adapter %d, "
+				DEB2(printk(KERN_DEBUG "i2c-core.o: found normal i2c_range entry for adapter %d, "
 				            "addr %04x\n", adap_id,addr));
 			}
 		}
@@ -961,7 +960,7 @@
 			    ((address_data->probe[i] == ANY_I2C_BUS))) &&
 			    (addr == address_data->probe[i+1])) {
 				found = 1;
-				DEB2(printk("i2c-core.o: found probe parameter for adapter %d, "
+				DEB2(printk(KERN_DEBUG "i2c-core.o: found probe parameter for adapter %d, "
 				            "addr %04x\n", adap_id,addr));
 			}
 		}
@@ -973,7 +972,7 @@
 			   (addr >= address_data->probe_range[i+1]) &&
 			   (addr <= address_data->probe_range[i+2])) {
 				found = 1;
-				DEB2(printk("i2c-core.o: found probe_range parameter for adapter %d, "
+				DEB2(printk(KERN_DEBUG "i2c-core.o: found probe_range parameter for adapter %d, "
 				            "addr %04x\n", adap_id,addr));
 			}
 		}
@@ -1110,6 +1109,23 @@
 	                      I2C_SMBUS_BLOCK_DATA,&data);
 }
 
+/* Returns the number of read bytes */
+extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
+                                         u8 command, u8 *values)
+{
+	union i2c_smbus_data data;
+	int i;
+	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
+	                      I2C_SMBUS_READ,command,
+	                      I2C_SMBUS_I2C_BLOCK_DATA,&data))
+		return -1;
+	else {
+		for (i = 1; i <= data.block[0]; i++)
+			values[i-1] = data.block[i];
+		return data.block[0];
+	}
+}
+
 extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
                                           u8 command, u8 length, u8 *values)
 {
@@ -1185,23 +1201,38 @@
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
 		if (read_write == I2C_SMBUS_READ) {
-			printk("i2c-core.o: Block read not supported under "
+			printk(KERN_ERR "i2c-core.o: Block read not supported under "
 			       "I2C emulation!\n");
 		return -1;
 		} else {
 			msg[0].len = data->block[0] + 2;
 			if (msg[0].len > 34) {
-				printk("i2c-core.o: smbus_access called with "
+				printk(KERN_ERR "i2c-core.o: smbus_access called with "
 				       "invalid block write size (%d)\n",
-				       msg[0].len);
+				       data->block[0]);
 				return -1;
 			}
 			for (i = 1; i <= msg[0].len; i++)
 				msgbuf0[i] = data->block[i-1];
 		}
 		break;
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		if (read_write == I2C_SMBUS_READ) {
+			msg[1].len = 32;
+		} else {
+			msg[0].len = data->block[0] + 2;
+			if (msg[0].len > 34) {
+				printk("i2c-core.o: i2c_smbus_xfer_emulated called with "
+				       "invalid block write size (%d)\n",
+				       data->block[0]);
+				return -1;
+			}
+			for (i = 0; i < data->block[0]; i++)
+				msgbuf0[i] = data->block[i+1];
+		}
+		break;
 	default:
-		printk("i2c-core.o: smbus_access called with invalid size (%d)\n",
+		printk(KERN_ERR "i2c-core.o: smbus_access called with invalid size (%d)\n",
 		       size);
 		return -1;
 	}
@@ -1221,6 +1252,12 @@
 			case I2C_SMBUS_PROC_CALL:
 				data->word = msgbuf1[0] | (msgbuf1[1] << 8);
 				break;
+			case I2C_SMBUS_I2C_BLOCK_DATA:
+				/* fixed at 32 for now */
+				data->block[0] = 32;
+				for (i = 0; i < 32; i++)
+					data->block[i+1] = msgbuf1[i];
+				break;
 		}
 	return 0;
 }
@@ -1263,7 +1300,7 @@
 
 static int __init i2c_init(void)
 {
-	printk("i2c-core.o: i2c core module\n");
+	printk(KERN_INFO "i2c-core.o: i2c core module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	memset(adapters,0,sizeof(adapters));
 	memset(drivers,0,sizeof(drivers));
 	adap_count=0;
@@ -1401,6 +1438,8 @@
 EXPORT_SYMBOL(i2c_smbus_process_call);
 EXPORT_SYMBOL(i2c_smbus_read_block_data);
 EXPORT_SYMBOL(i2c_smbus_write_block_data);
+EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
+EXPORT_SYMBOL(i2c_smbus_write_i2c_block_data);
 
 EXPORT_SYMBOL(i2c_get_functionality);
 EXPORT_SYMBOL(i2c_check_functionality);
--- linux/drivers/i2c/i2c-dev.c.orig	2002-05-09 18:25:27.000000000 -0400
+++ linux/drivers/i2c/i2c-dev.c	2002-05-14 17:59:52.000000000 -0400
@@ -28,7 +28,7 @@
 /* The devfs code is contributed by Philipp Matthias Hahn 
    <pmhahn@titan.lahn.de> */
 
-/* $Id: i2c-dev.c,v 1.40 2001/08/25 01:28:01 mds Exp $ */
+/* $Id: i2c-dev.c,v 1.44 2001/11/19 18:45:02 mds Exp $ */
 
 #include <linux/config.h>
 #include <linux/kernel.h>
@@ -49,7 +49,6 @@
 
 #include <linux/init.h>
 #include <asm/uaccess.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 
@@ -140,7 +139,7 @@
 {
 #ifdef DEBUG
 	struct inode *inode = file->f_dentry->d_inode;
-	printk("i2c-dev.o: i2c-%d lseek to %ld bytes relative to %d.\n",
+	printk(KERN_DEBUG "i2c-dev.o: i2c-%d lseek to %ld bytes relative to %d.\n",
 	       minor(inode->i_rdev),(long) offset,origin);
 #endif /* DEBUG */
 	return -ESPIPE;
@@ -165,7 +164,7 @@
 		return -ENOMEM;
 
 #ifdef DEBUG
-	printk("i2c-dev.o: i2c-%d reading %d bytes.\n",minor(inode->i_rdev),
+	printk(KERN_DEBUG "i2c-dev.o: i2c-%d reading %d bytes.\n",minor(inode->i_rdev),
 	       count);
 #endif
 
@@ -197,7 +196,7 @@
 	}
 
 #ifdef DEBUG
-	printk("i2c-dev.o: i2c-%d writing %d bytes.\n",minor(inode->i_rdev),
+	printk(KERN_DEBUG "i2c-dev.o: i2c-%d writing %d bytes.\n",minor(inode->i_rdev),
 	       count);
 #endif
 	ret = i2c_master_send(client,tmp,count);
@@ -217,7 +216,7 @@
 	unsigned long funcs;
 
 #ifdef DEBUG
-	printk("i2c-dev.o: i2c-%d ioctl, cmd: 0x%x, arg: %lx.\n", 
+	printk(KERN_DEBUG "i2c-dev.o: i2c-%d ioctl, cmd: 0x%x, arg: %lx.\n", 
 	       minor(inode->i_rdev),cmd, arg);
 #endif /* DEBUG */
 
@@ -315,7 +314,7 @@
 		    (data_arg.size != I2C_SMBUS_BLOCK_DATA) &&
 		    (data_arg.size != I2C_SMBUS_I2C_BLOCK_DATA)) {
 #ifdef DEBUG
-			printk("i2c-dev.o: size out of range (%x) in ioctl I2C_SMBUS.\n",
+			printk(KERN_DEBUG "i2c-dev.o: size out of range (%x) in ioctl I2C_SMBUS.\n",
 			       data_arg.size);
 #endif
 			return -EINVAL;
@@ -325,7 +324,7 @@
 		if ((data_arg.read_write != I2C_SMBUS_READ) && 
 		    (data_arg.read_write != I2C_SMBUS_WRITE)) {
 #ifdef DEBUG
-			printk("i2c-dev.o: read_write out of range (%x) in ioctl I2C_SMBUS.\n",
+			printk(KERN_DEBUG "i2c-dev.o: read_write out of range (%x) in ioctl I2C_SMBUS.\n",
 			       data_arg.read_write);
 #endif
 			return -EINVAL;
@@ -345,7 +344,7 @@
 
 		if (data_arg.data == NULL) {
 #ifdef DEBUG
-			printk("i2c-dev.o: data is NULL pointer in ioctl I2C_SMBUS.\n");
+			printk(KERN_DEBUG "i2c-dev.o: data is NULL pointer in ioctl I2C_SMBUS.\n");
 #endif
 			return -EINVAL;
 		}
@@ -387,7 +386,7 @@
 
 	if ((minor >= I2CDEV_ADAPS_MAX) || ! (i2cdev_adaps[minor])) {
 #ifdef DEBUG
-		printk("i2c-dev.o: Trying to open unattached adapter i2c-%d\n",
+		printk(KERN_DEBUG "i2c-dev.o: Trying to open unattached adapter i2c-%d\n",
 		       minor);
 #endif
 		return -ENODEV;
@@ -408,7 +407,7 @@
 #endif /* LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0) */
 
 #ifdef DEBUG
-	printk("i2c-dev.o: opened i2c-%d\n",minor);
+	printk(KERN_DEBUG "i2c-dev.o: opened i2c-%d\n",minor);
 #endif
 	return 0;
 }
@@ -419,13 +418,18 @@
 	kfree(file->private_data);
 	file->private_data=NULL;
 #ifdef DEBUG
-	printk("i2c-dev.o: Closed: i2c-%d\n", minor);
+	printk(KERN_DEBUG "i2c-dev.o: Closed: i2c-%d\n", minor);
 #endif
 #if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0)
 	MOD_DEC_USE_COUNT;
+#else /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
+	lock_kernel();
 #endif /* LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0) */
 	if (i2cdev_adaps[minor]->dec_use)
 		i2cdev_adaps[minor]->dec_use(i2cdev_adaps[minor]);
+#if LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0)
+	unlock_kernel();
+#endif /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
 	return 0;
 }
 
@@ -435,11 +439,11 @@
 	char name[8];
 
 	if ((i = i2c_adapter_id(adap)) < 0) {
-		printk("i2c-dev.o: Unknown adapter ?!?\n");
+		printk(KERN_DEBUG "i2c-dev.o: Unknown adapter ?!?\n");
 		return -ENODEV;
 	}
 	if (i >= I2CDEV_ADAPS_MAX) {
-		printk("i2c-dev.o: Adapter number too large?!? (%d)\n",i);
+		printk(KERN_DEBUG "i2c-dev.o: Adapter number too large?!? (%d)\n",i);
 		return -ENODEV;
 	}
 
@@ -452,7 +456,7 @@
 			S_IFCHR | S_IRUSR | S_IWUSR,
 			&i2cdev_fops, NULL);
 #endif
-		printk("i2c-dev.o: Registered '%s' as minor %d\n",adap->name,i);
+		printk(KERN_DEBUG "i2c-dev.o: Registered '%s' as minor %d\n",adap->name,i);
 	} else {
 		/* This is actually a detach_adapter call! */
 #ifdef CONFIG_DEVFS_FS
@@ -460,7 +464,7 @@
 #endif
 		i2cdev_adaps[i] = NULL;
 #ifdef DEBUG
-		printk("i2c-dev.o: Adapter unregistered: %s\n",adap->name);
+		printk(KERN_DEBUG "i2c-dev.o: Adapter unregistered: %s\n",adap->name);
 #endif
 	}
 
@@ -482,7 +486,7 @@
 {
 	int res;
 
-	printk("i2c-dev.o: i2c /dev entries driver module\n");
+	printk(KERN_INFO "i2c-dev.o: i2c /dev entries driver module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
 	i2cdev_initialized = 0;
 #ifdef CONFIG_DEVFS_FS
@@ -490,7 +494,7 @@
 #else
 	if (register_chrdev(I2C_MAJOR,"i2c",&i2cdev_fops)) {
 #endif
-		printk("i2c-dev.o: unable to get major %d for i2c bus\n",
+		printk(KERN_ERR "i2c-dev.o: unable to get major %d for i2c bus\n",
 		       I2C_MAJOR);
 		return -EIO;
 	}
@@ -500,7 +504,7 @@
 	i2cdev_initialized ++;
 
 	if ((res = i2c_add_driver(&i2cdev_driver))) {
-		printk("i2c-dev.o: Driver registration failed, module not inserted.\n");
+		printk(KERN_ERR "i2c-dev.o: Driver registration failed, module not inserted.\n");
 		i2cdev_cleanup();
 		return res;
 	}
@@ -514,7 +518,7 @@
 
 	if (i2cdev_initialized >= 2) {
 		if ((res = i2c_del_driver(&i2cdev_driver))) {
-			printk("i2c-dev.o: Driver deregistration failed, "
+			printk(KERN_ERR "i2c-dev.o: Driver deregistration failed, "
 			       "module not removed.\n");
 			return res;
 		}
@@ -528,7 +532,7 @@
 #else
 		if ((res = unregister_chrdev(I2C_MAJOR,"i2c"))) {
 #endif
-			printk("i2c-dev.o: unable to release major %d for i2c bus\n",
+			printk(KERN_ERR "i2c-dev.o: unable to release major %d for i2c bus\n",
 			       I2C_MAJOR);
 			return res;
 		}
--- linux/include/linux/i2c-dev.h.orig	2002-05-09 18:22:54.000000000 -0400
+++ linux/include/linux/i2c-dev.h	2002-05-14 17:57:11.000000000 -0400
@@ -19,7 +19,7 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-/* $Id: i2c-dev.h,v 1.9 2001/08/15 03:04:58 mds Exp $ */
+/* $Id: i2c-dev.h,v 1.10 2001/11/19 19:01:46 mds Exp $ */
 
 #ifndef I2C_DEV_H
 #define I2C_DEV_H
@@ -162,6 +162,22 @@
 	                        I2C_SMBUS_BLOCK_DATA, &data);
 }
 
+/* Returns the number of read bytes */
+static inline __s32 i2c_smbus_read_i2c_block_data(int file, __u8 command,
+                                                  __u8 *values)
+{
+	union i2c_smbus_data data;
+	int i;
+	if (i2c_smbus_access(file,I2C_SMBUS_READ,command,
+	                      I2C_SMBUS_I2C_BLOCK_DATA,&data))
+		return -1;
+	else {
+		for (i = 1; i <= data.block[0]; i++)
+			values[i-1] = data.block[i];
+		return data.block[0];
+	}
+}
+
 static inline __s32 i2c_smbus_write_i2c_block_data(int file, __u8 command,
                                                __u8 length, __u8 *values)
 {
--- linux/include/linux/i2c-id.h.orig	2002-05-09 18:21:45.000000000 -0400
+++ linux/include/linux/i2c-id.h	2002-03-11 02:18:55.000000000 -0500
@@ -20,7 +20,7 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
 /* ------------------------------------------------------------------------- */
 
-/* $Id: i2c-id.h,v 1.35 2001/08/12 17:22:20 mds Exp $ */
+/* $Id: i2c-id.h,v 1.41 2002/03/11 07:18:55 simon Exp $ */
 
 #ifndef I2C_ID_H
 #define I2C_ID_H
@@ -90,6 +90,10 @@
 #define I2C_DRIVERID_DRP3510	43     /* ADR decoder (Astra Radio)	*/
 #define I2C_DRIVERID_SP5055	44     /* Satellite tuner		*/
 #define I2C_DRIVERID_STV0030	45     /* Multipurpose switch		*/
+#define I2C_DRIVERID_SAA7108    46     /* video decoder, image scaler   */
+
+
+
 
 #define I2C_DRIVERID_EXP0	0xF0	/* experimental use id's	*/
 #define I2C_DRIVERID_EXP1	0xF1
@@ -127,6 +131,9 @@
 #define I2C_DRIVERID_ADM1024 1025
 #define I2C_DRIVERID_IT87 1026
 #define I2C_DRIVERID_CH700X 1027 /* single driver for CH7003-7009 digital pc to tv encoders */
+#define I2C_DRIVERID_FSCPOS 1028
+#define I2C_DRIVERID_FSCSCY 1029
+#define I2C_DRIVERID_PCF8591 1030
 
 /*
  * ---- Adapter types ----------------------------------------------------
@@ -143,7 +150,8 @@
 #define I2C_ALGO_ISA 	0x050000	/* lm_sensors ISA pseudo-adapter */
 #define I2C_ALGO_SAA7146 0x060000	/* SAA 7146 video decoder bus	*/
 #define I2C_ALGO_ACB 	0x070000	/* ACCESS.bus algorithm         */
-
+#define I2C_ALGO_IIC    0x080000 	/* ITE IIC bus */
+#define I2C_ALGO_SAA7134 0x090000
 #define I2C_ALGO_EC     0x100000        /* ACPI embedded controller     */
 
 #define I2C_ALGO_MPC8XX 0x110000	/* MPC8xx PowerPC I2C algorithm */
@@ -189,6 +197,9 @@
 /* --- MPC8xx PowerPC adapters						*/
 #define I2C_HW_MPC8XX_EPON 0x00	/* Eponymous MPC8xx I2C adapter 	*/
 
+/* --- ITE based algorithms						*/
+#define I2C_HW_I_IIC	0x00	/* controller on the ITE */
+
 /* --- SMBus only adapters						*/
 #define I2C_HW_SMBUS_PIIX4	0x00
 #define I2C_HW_SMBUS_ALI15X3	0x01
--- linux/drivers/i2c/i2c-proc.c.orig	2002-05-09 18:24:47.000000000 -0400
+++ linux/drivers/i2c/i2c-proc.c	2002-05-24 20:30:37.000000000 -0400
@@ -32,16 +32,10 @@
 #include <linux/proc_fs.h>
 #include <linux/ioport.h>
 #include <asm/uaccess.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-proc.h>
-
 #include <linux/init.h>
 
-/* FIXME need i2c versioning */
-#define LM_DATE "20010825"
-#define LM_VERSION "2.6.1"
-
 #ifndef THIS_MODULE
 #define THIS_MODULE NULL
 #endif
@@ -175,6 +169,7 @@
 		new_table[i].extra2 = client;
 
 	if (!(new_header = register_sysctl_table(new_table, 0))) {
+		printk(KERN_ERR "i2c-proc.o: error: sysctl interface not supported by kernel!\n");
 		kfree(new_table);
 		kfree(name);
 		return -ENOMEM;
@@ -189,7 +184,7 @@
 	    !new_header->ctl_table->child->child ||
 	    !new_header->ctl_table->child->child->de) {
 		printk
-		    ("i2c-proc.o: NULL pointer when trying to install fill_inode fix!\n");
+		    (KERN_ERR "i2c-proc.o: NULL pointer when trying to install fill_inode fix!\n");
 		return id;
 	}
 #endif				/* DEBUG */
@@ -629,7 +624,7 @@
 				    && (addr == this_force->force[j + 1])) {
 #ifdef DEBUG
 					printk
-					    ("i2c-proc.o: found force parameter for adapter %d, addr %04x\n",
+					    (KERN_DEBUG "i2c-proc.o: found force parameter for adapter %d, addr %04x\n",
 					     adapter_id, addr);
 #endif
 					if (
@@ -659,7 +654,7 @@
 			    && (addr == address_data->ignore[i + 1])) {
 #ifdef DEBUG
 				printk
-				    ("i2c-proc.o: found ignore parameter for adapter %d, "
+				    (KERN_DEBUG "i2c-proc.o: found ignore parameter for adapter %d, "
 				     "addr %04x\n", adapter_id, addr);
 #endif
 				found = 1;
@@ -679,7 +674,7 @@
 			    && (addr <= address_data->ignore_range[i + 2])) {
 #ifdef DEBUG
 				printk
-				    ("i2c-proc.o: found ignore_range parameter for adapter %d, "
+				    (KERN_DEBUG "i2c-proc.o: found ignore_range parameter for adapter %d, "
 				     "addr %04x\n", adapter_id, addr);
 #endif
 				found = 1;
@@ -698,7 +693,7 @@
 				if (addr == address_data->normal_isa[i]) {
 #ifdef DEBUG
 					printk
-					    ("i2c-proc.o: found normal isa entry for adapter %d, "
+					    (KERN_DEBUG "i2c-proc.o: found normal isa entry for adapter %d, "
 					     "addr %04x\n", adapter_id,
 					     addr);
 #endif
@@ -720,7 +715,7 @@
 				     0)) {
 #ifdef DEBUG
 					printk
-					    ("i2c-proc.o: found normal isa_range entry for adapter %d, "
+					    (KERN_DEBUG "i2c-proc.o: found normal isa_range entry for adapter %d, "
 					     "addr %04x", adapter_id, addr);
 #endif
 					found = 1;
@@ -734,7 +729,7 @@
 					found = 1;
 #ifdef DEBUG
 					printk
-					    ("i2c-proc.o: found normal i2c entry for adapter %d, "
+					    (KERN_DEBUG "i2c-proc.o: found normal i2c entry for adapter %d, "
 					     "addr %02x", adapter_id, addr);
 #endif
 				}
@@ -750,7 +745,7 @@
 				{
 #ifdef DEBUG
 					printk
-					    ("i2c-proc.o: found normal i2c_range entry for adapter %d, "
+					    (KERN_DEBUG "i2c-proc.o: found normal i2c_range entry for adapter %d, "
 					     "addr %04x\n", adapter_id, addr);
 #endif
 					found = 1;
@@ -767,7 +762,7 @@
 			    && (addr == address_data->probe[i + 1])) {
 #ifdef DEBUG
 				printk
-				    ("i2c-proc.o: found probe parameter for adapter %d, "
+				    (KERN_DEBUG "i2c-proc.o: found probe parameter for adapter %d, "
 				     "addr %04x\n", adapter_id, addr);
 #endif
 				found = 1;
@@ -786,7 +781,7 @@
 				found = 1;
 #ifdef DEBUG
 				printk
-				    ("i2c-proc.o: found probe_range parameter for adapter %d, "
+				    (KERN_DEBUG "i2c-proc.o: found probe_range parameter for adapter %d, "
 				     "addr %04x\n", adapter_id, addr);
 #endif
 			}
@@ -807,11 +802,14 @@
 
 int __init sensors_init(void)
 {
-	printk("i2c-proc.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	printk(KERN_INFO "i2c-proc.o version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	i2c_initialized = 0;
 	if (!
 	    (i2c_proc_header =
-	     register_sysctl_table(i2c_proc, 0))) return -ENOMEM;
+	     register_sysctl_table(i2c_proc, 0))) {
+		printk(KERN_ERR "i2c-proc.o: error: sysctl interface not supported by kernel!\n");
+		return -EPERM;
+	}
 	i2c_proc_header->ctl_table->child->de->owner = THIS_MODULE;
 	i2c_initialized++;
 	return 0;
@@ -847,4 +845,5 @@
 {
 	return i2c_cleanup();
 }
+
 #endif				/* MODULE */
--- linux/include/linux/i2c-proc.h.orig	2002-05-09 18:24:59.000000000 -0400
+++ linux/include/linux/i2c-proc.h	2002-02-09 17:50:06.000000000 -0500
@@ -1,6 +1,7 @@
 /*
-    sensors.h - Part of lm_sensors, Linux kernel modules for hardware
-                monitoring
+    i2c-proc.h - Part of the i2c package
+    was originally sensors.h - Part of lm_sensors, Linux kernel modules
+                               for hardware monitoring
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
 
     This program is free software; you can redistribute it and/or modify
--- linux/include/linux/i2c.h.orig	2002-05-09 18:22:37.000000000 -0400
+++ linux/include/linux/i2c.h	2002-05-23 09:55:09.000000000 -0400
@@ -23,13 +23,13 @@
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c.h,v 1.46 2001/08/31 00:04:07 phil Exp $ */
+/* $Id: i2c.h,v 1.50 2002/03/23 00:53:38 phil Exp $ */
 
 #ifndef I2C_H
 #define I2C_H
 
-#define I2C_DATE "20010830"
-#define I2C_VERSION "2.6.1"
+#define I2C_DATE "20020322"
+#define I2C_VERSION "2.6.3"
 
 #include <linux/i2c-id.h>	/* id values of adapters et. al. 	*/
 #include <linux/types.h>
@@ -48,11 +48,8 @@
 #endif
 
 #include <asm/page.h>			/* for 2.2.xx 			*/
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,0,25)
 #include <linux/sched.h>
-#else
 #include <asm/semaphore.h>
-#endif
 #include <linux/config.h>
 
 /* --- General options ------------------------------------------------	*/
@@ -123,6 +120,8 @@
 extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
                                       u8 command, u8 length,
                                       u8 *values);
+extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
+                                         u8 command, u8 *values);
 extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
                                           u8 command, u8 length,
                                           u8 *values);
@@ -406,8 +405,10 @@
 #define I2C_FUNC_SMBUS_PROC_CALL	0x00800000 
 #define I2C_FUNC_SMBUS_READ_BLOCK_DATA	0x01000000 
 #define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA 0x02000000 
-#define I2C_FUNC_SMBUS_READ_I2C_BLOCK	0x04000000 /* New I2C-like block */
-#define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* transfer */
+#define I2C_FUNC_SMBUS_READ_I2C_BLOCK	0x04000000 /* I2C-like block xfer  */
+#define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* w/ 1-byte reg. addr. */
+#define I2C_FUNC_SMBUS_READ_I2C_BLOCK_2	 0x10000000 /* I2C-like block xfer  */
+#define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2 0x20000000 /* w/ 2-byte reg. addr. */
 
 #define I2C_FUNC_SMBUS_BYTE I2C_FUNC_SMBUS_READ_BYTE | \
                             I2C_FUNC_SMBUS_WRITE_BYTE
@@ -419,13 +420,17 @@
                                   I2C_FUNC_SMBUS_WRITE_BLOCK_DATA
 #define I2C_FUNC_SMBUS_I2C_BLOCK I2C_FUNC_SMBUS_READ_I2C_BLOCK | \
                                   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
+#define I2C_FUNC_SMBUS_I2C_BLOCK_2 I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 | \
+                                   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2
 
 #define I2C_FUNC_SMBUS_EMUL I2C_FUNC_SMBUS_QUICK | \
                             I2C_FUNC_SMBUS_BYTE | \
                             I2C_FUNC_SMBUS_BYTE_DATA | \
                             I2C_FUNC_SMBUS_WORD_DATA | \
                             I2C_FUNC_SMBUS_PROC_CALL | \
-                            I2C_FUNC_SMBUS_WRITE_BLOCK_DATA
+                            I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
+                            I2C_FUNC_SMBUS_I2C_BLOCK | \
+                            I2C_FUNC_SMBUS_I2C_BLOCK_2
 
 /* 
  * Data for SMBus Messages 

--------------F44A8E91E4982DC21A1C752B--

