Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318944AbSHMFqz>; Tue, 13 Aug 2002 01:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318942AbSHMFqF>; Tue, 13 Aug 2002 01:46:05 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:52122 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318938AbSHMFpg>; Tue, 13 Aug 2002 01:45:36 -0400
Message-ID: <3D589DDF.CF2BBA6D@attbi.com>
Date: Tue, 13 Aug 2002 01:49:19 -0400
From: Albert Cranford <ac9410@attbi.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 2/4] 2.4.20-pre2 i2c updates
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo,
Please apply the following four tested patches that update
2.4.20-pre2 with these I2C changes:
o Support for SMBus 2.0 PEC Packet Error Checking
o New adapter-i2c-frodo for SA 1110 board
o New adapter-i2c-rpx for embeded MPC8XX
o Remove compat code for < 2.4
o Replace cli()&sti() with spin_{un}lock_irq()
o Updated documentation
Thanks,
Albert
--- linux/drivers/i2c/i2c-core.c.orig   2002-07-23 01:43:58.000000000 -0400
+++ linux/drivers/i2c/i2c-core.c        2002-07-23 08:56:54.000000000 -0400
@@ -18,9 +18,10 @@
 /* ------------------------------------------------------------------------- */
 
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi>.
-   All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl> */
+   All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl>
+   SMBus 2.0 support by Mark Studebaker <mdsxyz123@yahoo.com>                */
 
-/* $Id: i2c-core.c,v 1.64 2001/08/13 01:35:56 mds Exp $ */
+/* $Id: i2c-core.c,v 1.83 2002/07/08 01:37:15 mds Exp $ */
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -28,7 +29,6 @@
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/config.h>
-
 #include <linux/i2c.h>
 
 /* ----- compatibility stuff ----------------------------------------------- */
@@ -36,10 +36,6 @@
 #include <linux/version.h>
 #include <linux/init.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-#define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
-#endif
-
 #include <asm/uaccess.h>
 
 /* ----- global defines ---------------------------------------------------- */
@@ -84,10 +80,6 @@
 static int i2cproc_init(void);
 static int i2cproc_cleanup(void);
 
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,3,27))
-static void monitor_bus_i2c(struct inode *inode, int fill);
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,58)) */
-
 static ssize_t i2cproc_bus_read(struct file * file, char * buf,size_t count, 
                                 loff_t *ppos);
 static int read_bus_i2c(char *buf, char **start, off_t offset, int len,
@@ -99,12 +91,6 @@
        read:           i2cproc_bus_read,
 };
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,48))
-static struct inode_operations i2cproc_inode_operations = {
-       &i2cproc_operations
-};
-#endif
-
 static int i2cproc_initialized = 0;
 
 #else /* undef CONFIG_PROC_FS */
@@ -158,22 +144,14 @@
 
                proc_entry = create_proc_entry(name,0,proc_bus);
                if (! proc_entry) {
-                       printk("i2c-core.o: Could not create /proc/bus/%s\n",
+                       printk(KERN_ERR "i2c-core.o: Could not create /proc/bus/%s\n",
                               name);
                        res = -ENOENT;
                        goto ERROR1;
                }
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,48))
                proc_entry->proc_fops = &i2cproc_operations;
-#else
-               proc_entry->ops = &i2cproc_inode_operations;
-#endif
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27))
                proc_entry->owner = THIS_MODULE;
-#else
-               proc_entry->fill_inode = &monitor_bus_i2c;
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,58)) */
                adap->inode = proc_entry->low_ino;
        }
 
@@ -188,7 +166,7 @@
                        drivers[j]->attach_adapter(adap);
        DRV_UNLOCK();
        
-       DEB(printk("i2c-core.o: adapter %s registered as adapter %d.\n",
+       DEB(printk(KERN_DEBUG "i2c-core.o: adapter %s registered as adapter %d.\n",
                   adap->name,i));
 
        return 0;       
@@ -214,7 +192,7 @@
                if (adap == adapters[i])
                        break;
        if (I2C_ADAP_MAX == i) {
-               printk( "i2c-core.o: unregister_adapter adap [%s] not found.\n",
+               printk( KERN_WARNING "i2c-core.o: unregister_adapter adap [%s] not found.\n",
                        adap->name);
                res = -ENODEV;
                goto ERROR0;
@@ -229,7 +207,7 @@
        for (j = 0; j < I2C_DRIVER_MAX; j++) 
                if (drivers[j] && (drivers[j]->flags & I2C_DF_DUMMY))
                        if ((res = drivers[j]->attach_adapter(adap))) {
-                               printk("i2c-core.o: can't detach adapter %s "
+                               printk(KERN_WARNING "i2c-core.o: can't detach adapter %s "
                                       "while detaching driver %s: driver not "
                                       "detached!",adap->name,drivers[j]->name);
                                goto ERROR1;    
@@ -247,7 +225,7 @@
                     * must be deleted, as this would cause invalid states.
                     */
                        if ((res=client->driver->detach_client(client))) {
-                               printk("i2c-core.o: adapter %s not "
+                               printk(KERN_ERR "i2c-core.o: adapter %s not "
                                        "unregistered, because client at "
                                        "address %02x can't be detached. ",
                                        adap->name, client->addr);
@@ -266,7 +244,7 @@
        adap_count--;
        
        ADAP_UNLOCK();  
-       DEB(printk("i2c-core.o: adapter unregistered: %s\n",adap->name));
+       DEB(printk(KERN_DEBUG "i2c-core.o: adapter unregistered: %s\n",adap->name));
        return 0;
 
 ERROR0:
@@ -305,7 +283,7 @@
        
        DRV_UNLOCK();   /* driver was successfully added */
        
-       DEB(printk("i2c-core.o: driver %s registered.\n",driver->name));
+       DEB(printk(KERN_DEBUG "i2c-core.o: driver %s registered.\n",driver->name));
        
        ADAP_LOCK();
 
@@ -340,7 +318,7 @@
         * attached. If so, detach them to be able to kill the driver 
         * afterwards.
         */
-       DEB2(printk("i2c-core.o: unregister_driver - looking for clients.\n"));
+       DEB2(printk(KERN_DEBUG "i2c-core.o: unregister_driver - looking for clients.\n"));
        /* removing clients does not depend on the notify flag, else 
         * invalid operation might (will!) result, when using stale client
         * pointers.
@@ -350,7 +328,7 @@
                struct i2c_adapter *adap = adapters[k];
                if (adap == NULL) /* skip empty entries. */
                        continue;
-               DEB2(printk("i2c-core.o: examining adapter %s:\n",
+               DEB2(printk(KERN_DEBUG "i2c-core.o: examining adapter %s:\n",
                            adap->name));
                if (driver->flags & I2C_DF_DUMMY) {
                /* DUMMY drivers do not register their clients, so we have to
@@ -359,7 +337,7 @@
                 * this or hell will break loose...  
                 */
                        if ((res = driver->attach_adapter(adap))) {
-                               printk("i2c-core.o: while unregistering "
+                               printk(KERN_WARNING "i2c-core.o: while unregistering "
                                       "dummy driver %s, adapter %s could "
                                       "not be detached properly; driver "
                                       "not unloaded!",driver->name,
@@ -372,19 +350,17 @@
                                struct i2c_client *client = adap->clients[j];
                                if (client != NULL && 
                                    client->driver == driver) {
-                                       DEB2(printk("i2c-core.o: "
+                                       DEB2(printk(KERN_DEBUG "i2c-core.o: "
                                                    "detaching client %s:\n",
                                                    client->name));
                                        if ((res = driver->
                                                        detach_client(client)))
                                        {
-                                               printk("i2c-core.o: while "
+                                               printk(KERN_ERR "i2c-core.o: while "
                                                       "unregistering driver "
                                                       "`%s', the client at "
-                                                      "address %02x of "
-                                                      "adapter `%s' could not"
-                                                      "be detached; driver"
-                                                      "not unloaded!",
+                                                      "address %02x of adapter `%s' could not be "
+                                                      "detached; driver not unloaded!",
                                                       driver->name,
                                                       client->addr,
                                                       adap->name);
@@ -400,7 +376,7 @@
        driver_count--;
        DRV_UNLOCK();
        
-       DEB(printk("i2c-core.o: driver unregistered: %s\n",driver->name));
+       DEB(printk(KERN_DEBUG "i2c-core.o: driver unregistered: %s\n",driver->name));
        return 0;
 }
 
@@ -436,10 +412,10 @@
        
        if (adapter->client_register) 
                if (adapter->client_register(client)) 
-                       printk("i2c-core.o: warning: client_register seems "
+                       printk(KERN_DEBUG "i2c-core.o: warning: client_register seems "
                               "to have failed for client %02x at adapter %s\n",
                               client->addr,adapter->name);
-       DEB(printk("i2c-core.o: client [%s] registered to adapter [%s](pos. %d).\n",
+       DEB(printk(KERN_DEBUG "i2c-core.o: client [%s] registered to adapter [%s](pos. %d).\n",
                client->name, adapter->name,i));
 
        if(client->flags & I2C_CLIENT_ALLOW_USE)
@@ -470,7 +446,7 @@
        
        if (adapter->client_unregister != NULL) 
                if ((res = adapter->client_unregister(client))) {
-                       printk("i2c-core.o: client_unregister [%s] failed, "
+                       printk(KERN_ERR "i2c-core.o: client_unregister [%s] failed, "
                               "client not detached",client->name);
                        return res;
                }
@@ -478,7 +454,7 @@
        adapter->clients[i] = NULL;
        adapter->client_count--;
 
-       DEB(printk("i2c-core.o: client [%s] unregistered.\n",client->name));
+       DEB(printk(KERN_DEBUG "i2c-core.o: client [%s] unregistered.\n",client->name));
        return 0;
 }
 
@@ -611,18 +587,6 @@
 
 #ifdef CONFIG_PROC_FS
 
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,3,27))
-/* Monitor access to /proc/bus/i2c*; make unloading i2c-proc impossible
-   if some process still uses it or some file in it */
-void monitor_bus_i2c(struct inode *inode, int fill)
-{
-       if (fill)
-               MOD_INC_USE_COUNT;
-       else
-               MOD_DEC_USE_COUNT;
-}
-#endif /* (LINUX_VERSION_CODE <= KERNEL_VERSION(2,3,37)) */
-
 /* This function generates the output for /proc/bus/i2c */
 int read_bus_i2c(char *buf, char **start, off_t offset, int len, int *eof, 
                  void *private)
@@ -659,12 +623,12 @@
        int i,j,k,order_nr,len=0,len_total;
        int order[I2C_CLIENT_MAX];
 
-       if (count > 4000)
+       if (count > 4096)
                return -EINVAL; 
        len_total = file->f_pos + count;
        /* Too bad if this gets longer (unlikely) */
-       if (len_total > 4000)
-               len_total = 4000;
+       if (len_total > 4096)
+               len_total = 4096;
        for (i = 0; i < I2C_ADAP_MAX; i++)
                if (adapters[i]->inode == inode->i_ino) {
                /* We need a bit of slack in the kernel buffer; this makes the
@@ -720,22 +684,18 @@
        i2cproc_initialized = 0;
 
        if (! proc_bus) {
-               printk("i2c-core.o: /proc/bus/ does not exist");
+               printk(KERN_ERR "i2c-core.o: /proc/bus/ does not exist");
                i2cproc_cleanup();
                return -ENOENT;
        } 
        proc_bus_i2c = create_proc_entry("i2c",0,proc_bus);
        if (!proc_bus_i2c) {
-               printk("i2c-core.o: Could not create /proc/bus/i2c");
+               printk(KERN_ERR "i2c-core.o: Could not create /proc/bus/i2c");
                i2cproc_cleanup();
                return -ENOENT;
        }
        proc_bus_i2c->read_proc = &read_bus_i2c;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27))
        proc_bus_i2c->owner = THIS_MODULE;
-#else
-       proc_bus_i2c->fill_inode = &monitor_bus_i2c;
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27)) */
        i2cproc_initialized += 2;
        return 0;
 }
@@ -763,7 +723,7 @@
        int ret;
 
        if (adap->algo->master_xfer) {
-               DEB2(printk("i2c-core.o: master_xfer: %s with %d msgs.\n",
+               DEB2(printk(KERN_DEBUG "i2c-core.o: master_xfer: %s with %d msgs.\n",
                            adap->name,num));
 
                I2C_LOCK(adap);
@@ -772,7 +732,7 @@
 
                return ret;
        } else {
-               printk("i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
+               printk(KERN_ERR "i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
                       adap->id);
                return -ENOSYS;
        }
@@ -790,7 +750,7 @@
                msg.len = count;
                (const char *)msg.buf = buf;
        
-               DEB2(printk("i2c-core.o: master_send: writing %d bytes on %s.\n",
+               DEB2(printk(KERN_DEBUG "i2c-core.o: master_send: writing %d bytes on %s.\n",
                        count,client->adapter->name));
        
                I2C_LOCK(adap);
@@ -802,7 +762,7 @@
                 */
                return (ret == 1 )? count : ret;
        } else {
-               printk("i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
+               printk(KERN_ERR "i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
                       client->adapter->id);
                return -ENOSYS;
        }
@@ -820,14 +780,14 @@
                msg.len = count;
                msg.buf = buf;
 
-               DEB2(printk("i2c-core.o: master_recv: reading %d bytes on %s.\n",
+               DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: reading %d bytes on %s.\n",
                        count,client->adapter->name));
        
                I2C_LOCK(adap);
                ret = adap->algo->master_xfer(adap,&msg,1);
                I2C_UNLOCK(adap);
        
-               DEB2(printk("i2c-core.o: master_recv: return:%d (count:%d, addr:0x%02x)\n",
+               DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: return:%d (count:%d, addr:0x%02x)\n",
                        ret, count, client->addr));
        
                /* if everything went ok (i.e. 1 msg transmitted), return #bytes
@@ -835,7 +795,7 @@
                */
                return (ret == 1 )? count : ret;
        } else {
-               printk("i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
+               printk(KERN_DEBUG "i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
                       client->adapter->id);
                return -ENOSYS;
        }
@@ -848,7 +808,7 @@
        int ret = 0;
        struct i2c_adapter *adap = client->adapter;
 
-       DEB2(printk("i2c-core.o: i2c ioctl, cmd: 0x%x, arg: %#lx\n", cmd, arg));
+       DEB2(printk(KERN_DEBUG "i2c-core.o: i2c ioctl, cmd: 0x%x, arg: %#lx\n", cmd, arg));
        switch ( cmd ) {
                case I2C_RETRIES:
                        adap->retries = arg;
@@ -893,7 +853,7 @@
                        if (((adap_id == address_data->force[i]) || 
                             (address_data->force[i] == ANY_I2C_BUS)) &&
                             (addr == address_data->force[i+1])) {
-                               DEB2(printk("i2c-core.o: found force parameter for adapter %d, addr %04x\n",
+                               DEB2(printk(KERN_DEBUG "i2c-core.o: found force parameter for adapter %d, addr %04x\n",
                                            adap_id,addr));
                                if ((err = found_proc(adapter,addr,0,0)))
                                        return err;
@@ -911,7 +871,7 @@
                        if (((adap_id == address_data->ignore[i]) || 
                            ((address_data->ignore[i] == ANY_I2C_BUS))) &&
                            (addr == address_data->ignore[i+1])) {
-                               DEB2(printk("i2c-core.o: found ignore parameter for adapter %d, "
+                               DEB2(printk(KERN_DEBUG "i2c-core.o: found ignore parameter for adapter %d, "
                                     "addr %04x\n", adap_id ,addr));
                                found = 1;
                        }
@@ -923,7 +883,7 @@
                            ((address_data->ignore_range[i]==ANY_I2C_BUS))) &&
                            (addr >= address_data->ignore_range[i+1]) &&
                            (addr <= address_data->ignore_range[i+2])) {
-                               DEB2(printk("i2c-core.o: found ignore_range parameter for adapter %d, "
+                               DEB2(printk(KERN_DEBUG "i2c-core.o: found ignore_range parameter for adapter %d, "
                                            "addr %04x\n", adap_id,addr));
                                found = 1;
                        }
@@ -938,7 +898,7 @@
                     i += 1) {
                        if (addr == address_data->normal_i2c[i]) {
                                found = 1;
-                               DEB2(printk("i2c-core.o: found normal i2c entry for adapter %d, "
+                               DEB2(printk(KERN_DEBUG "i2c-core.o: found normal i2c entry for adapter %d, "
                                            "addr %02x", adap_id,addr));
                        }
                }
@@ -949,7 +909,7 @@
                        if ((addr >= address_data->normal_i2c_range[i]) &&
                            (addr <= address_data->normal_i2c_range[i+1])) {
                                found = 1;
-                               DEB2(printk("i2c-core.o: found normal i2c_range entry for adapter %d, "
+                               DEB2(printk(KERN_DEBUG "i2c-core.o: found normal i2c_range entry for adapter %d, "
                                            "addr %04x\n", adap_id,addr));
                        }
                }
@@ -961,7 +921,7 @@
                            ((address_data->probe[i] == ANY_I2C_BUS))) &&
                            (addr == address_data->probe[i+1])) {
                                found = 1;
-                               DEB2(printk("i2c-core.o: found probe parameter for adapter %d, "
+                               DEB2(printk(KERN_DEBUG "i2c-core.o: found probe parameter for adapter %d, "
                                            "addr %04x\n", adap_id,addr));
                        }
                }
@@ -973,7 +933,7 @@
                           (addr >= address_data->probe_range[i+1]) &&
                           (addr <= address_data->probe_range[i+2])) {
                                found = 1;
-                               DEB2(printk("i2c-core.o: found probe_range parameter for adapter %d, "
+                               DEB2(printk(KERN_DEBUG "i2c-core.o: found probe_range parameter for adapter %d, "
                                            "addr %04x\n", adap_id,addr));
                        }
                }
@@ -1003,6 +963,123 @@
 
 /* The SMBus parts */
 
+#define POLY    (0x1070U << 3) 
+static u8
+crc8(u16 data)
+{
+       int i;
+  
+       for(i = 0; i < 8; i++) {
+               if (data & 0x8000) 
+                       data = data ^ POLY;
+               data = data << 1;
+       }
+       return (u8)(data >> 8);
+}
+
+/* CRC over count bytes in the first array plus the bytes in the rest
+   array if it is non-null. rest[0] is the (length of rest) - 1
+   and is included. */
+u8 i2c_smbus_partial_pec(u8 crc, int count, u8 *first, u8 *rest)
+{
+       int i;
+
+       for(i = 0; i < count; i++)
+               crc = crc8((crc ^ first[i]) << 8);
+       if(rest != NULL)
+               for(i = 0; i <= rest[0]; i++)
+                       crc = crc8((crc ^ rest[i]) << 8);
+       return crc;
+}
+
+u8 i2c_smbus_pec(int count, u8 *first, u8 *rest)
+{
+       return i2c_smbus_partial_pec(0, count, first, rest);
+}
+
+/* Returns new "size" (transaction type)
+   Note that we convert byte to byte_data and byte_data to word_data
+   rather than invent new xxx_PEC transactions. */
+int i2c_smbus_add_pec(u16 addr, u8 command, int size,
+                      union i2c_smbus_data *data)
+{
+       u8 buf[3];
+
+       buf[0] = addr << 1;
+       buf[1] = command;
+       switch(size) {
+               case I2C_SMBUS_BYTE:
+                       data->byte = i2c_smbus_pec(2, buf, NULL);
+                       size = I2C_SMBUS_BYTE_DATA;
+                       break;
+               case I2C_SMBUS_BYTE_DATA:
+                       buf[2] = data->byte;
+                       data->word = buf[2] ||
+                                   (i2c_smbus_pec(3, buf, NULL) << 8);
+                       size = I2C_SMBUS_WORD_DATA;
+                       break;
+               case I2C_SMBUS_WORD_DATA:
+                       /* unsupported */
+                       break;
+               case I2C_SMBUS_BLOCK_DATA:
+                       data->block[data->block[0] + 1] =
+                                    i2c_smbus_pec(2, buf, data->block);
+                       size = I2C_SMBUS_BLOCK_DATA_PEC;
+                       break;
+       }
+       return size;    
+}
+
+int i2c_smbus_check_pec(u16 addr, u8 command, int size, u8 partial,
+                        union i2c_smbus_data *data)
+{
+       u8 buf[3], rpec, cpec;
+
+       buf[1] = command;
+       switch(size) {
+               case I2C_SMBUS_BYTE_DATA:
+                       buf[0] = (addr << 1) | 1;
+                       cpec = i2c_smbus_pec(2, buf, NULL);
+                       rpec = data->byte;
+                       break;
+               case I2C_SMBUS_WORD_DATA:
+                       buf[0] = (addr << 1) | 1;
+                       buf[2] = data->word & 0xff;
+                       cpec = i2c_smbus_pec(3, buf, NULL);
+                       rpec = data->word >> 8;
+                       break;
+               case I2C_SMBUS_WORD_DATA_PEC:
+                       /* unsupported */
+                       cpec = rpec = 0;
+                       break;
+               case I2C_SMBUS_PROC_CALL_PEC:
+                       /* unsupported */
+                       cpec = rpec = 0;
+                       break;
+               case I2C_SMBUS_BLOCK_DATA_PEC:
+                       buf[0] = (addr << 1);
+                       buf[2] = (addr << 1) | 1;
+                       cpec = i2c_smbus_pec(3, buf, data->block);
+                       rpec = data->block[data->block[0] + 1];
+                       break;
+               case I2C_SMBUS_BLOCK_PROC_CALL_PEC:
+                       buf[0] = (addr << 1) | 1;
+                       rpec = i2c_smbus_partial_pec(partial, 1,
+                                                    buf, data->block);
+                       cpec = data->block[data->block[0] + 1];
+                       break;
+               default:
+                       cpec = rpec = 0;
+                       break;
+       }
+       if(rpec != cpec) {
+               DEB(printk(KERN_DEBUG "i2c-core.o: Bad PEC 0x%02x vs. 0x%02x\n",
+                          rpec, cpec));
+               return -1;
+       }
+       return 0;       
+}
+
 extern s32 i2c_smbus_write_quick(struct i2c_client * client, u8 value)
 {
        return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
@@ -1021,8 +1098,9 @@
 
 extern s32 i2c_smbus_write_byte(struct i2c_client * client, u8 value)
 {
+       union i2c_smbus_data data;      /* only for PEC */
        return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-                             I2C_SMBUS_WRITE,value, I2C_SMBUS_BYTE,NULL);
+                             I2C_SMBUS_WRITE,value, I2C_SMBUS_BYTE,&data);
 }
 
 extern s32 i2c_smbus_read_byte_data(struct i2c_client * client, u8 command)
@@ -1100,8 +1178,8 @@
 {
        union i2c_smbus_data data;
        int i;
-       if (length > 32)
-               length = 32;
+       if (length > I2C_SMBUS_BLOCK_MAX)
+               length = I2C_SMBUS_BLOCK_MAX;
        for (i = 1; i <= length; i++)
                data.block[i] = values[i-1];
        data.block[0] = length;
@@ -1110,13 +1188,50 @@
                              I2C_SMBUS_BLOCK_DATA,&data);
 }
 
+/* Returns the number of read bytes */
+extern s32 i2c_smbus_block_process_call(struct i2c_client * client,
+                                        u8 command, u8 length, u8 *values)
+{
+       union i2c_smbus_data data;
+       int i;
+       if (length > I2C_SMBUS_BLOCK_MAX - 1)
+               return -1;
+       data.block[0] = length;
+       for (i = 1; i <= length; i++)
+               data.block[i] = values[i-1];
+       if(i2c_smbus_xfer(client->adapter,client->addr,client->flags,
+                         I2C_SMBUS_WRITE, command,
+                         I2C_SMBUS_BLOCK_PROC_CALL, &data))
+               return -1;
+       for (i = 1; i <= data.block[0]; i++)
+               values[i-1] = data.block[i];
+       return data.block[0];
+}
+
+/* Returns the number of read bytes */
+extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
+                                         u8 command, u8 *values)
+{
+       union i2c_smbus_data data;
+       int i;
+       if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
+                             I2C_SMBUS_READ,command,
+                             I2C_SMBUS_I2C_BLOCK_DATA,&data))
+               return -1;
+       else {
+               for (i = 1; i <= data.block[0]; i++)
+                       values[i-1] = data.block[i];
+               return data.block[0];
+       }
+}
+
 extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
                                           u8 command, u8 length, u8 *values)
 {
        union i2c_smbus_data data;
        int i;
-       if (length > 32)
-               length = 32;
+       if (length > I2C_SMBUS_I2C_BLOCK_MAX)
+               length = I2C_SMBUS_I2C_BLOCK_MAX;
        for (i = 1; i <= length; i++)
                data.block[i] = values[i-1];
        data.block[0] = length;
@@ -1178,30 +1293,54 @@
                break;
        case I2C_SMBUS_PROC_CALL:
                num = 2; /* Special case */
+               read_write = I2C_SMBUS_READ;
                msg[0].len = 3;
                msg[1].len = 2;
                msgbuf0[1] = data->word & 0xff;
                msgbuf0[2] = (data->word >> 8) & 0xff;
                break;
        case I2C_SMBUS_BLOCK_DATA:
+       case I2C_SMBUS_BLOCK_DATA_PEC:
                if (read_write == I2C_SMBUS_READ) {
-                       printk("i2c-core.o: Block read not supported under "
-                              "I2C emulation!\n");
-               return -1;
+                       printk(KERN_ERR "i2c-core.o: Block read not supported "
+                              "under I2C emulation!\n");
+                       return -1;
                } else {
                        msg[0].len = data->block[0] + 2;
-                       if (msg[0].len > 34) {
-                               printk("i2c-core.o: smbus_access called with "
+                       if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 2) {
+                               printk(KERN_ERR "i2c-core.o: smbus_access called with "
                                       "invalid block write size (%d)\n",
-                                      msg[0].len);
+                                      data->block[0]);
                                return -1;
                        }
+                       if(size == I2C_SMBUS_BLOCK_DATA_PEC)
+                               (msg[0].len)++;
                        for (i = 1; i <= msg[0].len; i++)
                                msgbuf0[i] = data->block[i-1];
                }
                break;
+       case I2C_SMBUS_BLOCK_PROC_CALL:
+       case I2C_SMBUS_BLOCK_PROC_CALL_PEC:
+               printk(KERN_ERR "i2c-core.o: Block process call not supported "
+                      "under I2C emulation!\n");
+               return -1;
+       case I2C_SMBUS_I2C_BLOCK_DATA:
+               if (read_write == I2C_SMBUS_READ) {
+                       msg[1].len = I2C_SMBUS_I2C_BLOCK_MAX;
+               } else {
+                       msg[0].len = data->block[0] + 2;
+                       if (msg[0].len > I2C_SMBUS_I2C_BLOCK_MAX + 2) {
+                               printk("i2c-core.o: i2c_smbus_xfer_emulated called with "
+                                      "invalid block write size (%d)\n",
+                                      data->block[0]);
+                               return -1;
+                       }
+                       for (i = 0; i < data->block[0]; i++)
+                               msgbuf0[i] = data->block[i+1];
+               }
+               break;
        default:
-               printk("i2c-core.o: smbus_access called with invalid size (%d)\n",
+               printk(KERN_ERR "i2c-core.o: smbus_access called with invalid size (%d)\n",
                       size);
                return -1;
        }
@@ -1221,6 +1360,12 @@
                        case I2C_SMBUS_PROC_CALL:
                                data->word = msgbuf1[0] | (msgbuf1[1] << 8);
                                break;
+                       case I2C_SMBUS_I2C_BLOCK_DATA:
+                               /* fixed at 32 for now */
+                               data->block[0] = I2C_SMBUS_I2C_BLOCK_MAX;
+                               for (i = 0; i < I2C_SMBUS_I2C_BLOCK_MAX; i++)
+                                       data->block[i+1] = msgbuf1[i];
+                               break;
                }
        return 0;
 }
@@ -1231,7 +1376,29 @@
                    union i2c_smbus_data * data)
 {
        s32 res;
-       flags = flags & I2C_M_TEN;
+       int swpec = 0;
+       u8 partial = 0;
+
+       flags &= I2C_M_TEN | I2C_CLIENT_PEC;
+       if((flags & I2C_CLIENT_PEC) &&
+          !(i2c_check_functionality(adapter, I2C_FUNC_SMBUS_HWPEC_CALC))) {
+               swpec = 1;
+               if(read_write == I2C_SMBUS_READ &&
+                  size == I2C_SMBUS_BLOCK_DATA)
+                       size = I2C_SMBUS_BLOCK_DATA_PEC;
+               else if(size == I2C_SMBUS_PROC_CALL)
+                       size = I2C_SMBUS_PROC_CALL_PEC;
+               else if(size == I2C_SMBUS_BLOCK_PROC_CALL) {
+                       i2c_smbus_add_pec(addr, command,
+                                         I2C_SMBUS_BLOCK_DATA, data);
+                       partial = data->block[data->block[0] + 1];
+                       size = I2C_SMBUS_BLOCK_PROC_CALL_PEC;
+               } else if(read_write == I2C_SMBUS_WRITE &&
+                         size != I2C_SMBUS_QUICK &&
+                         size != I2C_SMBUS_I2C_BLOCK_DATA)
+                       size = i2c_smbus_add_pec(addr, command, size, data);
+       }
+
        if (adapter->algo->smbus_xfer) {
                I2C_LOCK(adapter);
                res = adapter->algo->smbus_xfer(adapter,addr,flags,read_write,
@@ -1240,6 +1407,14 @@
        } else
                res = i2c_smbus_xfer_emulated(adapter,addr,flags,read_write,
                                              command,size,data);
+
+       if(res >= 0 && swpec &&
+          size != I2C_SMBUS_QUICK && size != I2C_SMBUS_I2C_BLOCK_DATA &&
+          (read_write == I2C_SMBUS_READ || size == I2C_SMBUS_PROC_CALL_PEC ||
+           size == I2C_SMBUS_BLOCK_PROC_CALL_PEC)) {
+               if(i2c_smbus_check_pec(addr, command, size, partial, data))
+                       return -1;
+       }
        return res;
 }
 
@@ -1263,7 +1438,7 @@
 
 static int __init i2c_init(void)
 {
-       printk("i2c-core.o: i2c core module\n");
+       printk(KERN_INFO "i2c-core.o: i2c core module version %s (%s)\n", I2C_VERSION, I2C_DATE);
        memset(adapters,0,sizeof(adapters));
        memset(drivers,0,sizeof(drivers));
        adap_count=0;
@@ -1401,6 +1576,8 @@
 EXPORT_SYMBOL(i2c_smbus_process_call);
 EXPORT_SYMBOL(i2c_smbus_read_block_data);
 EXPORT_SYMBOL(i2c_smbus_write_block_data);
+EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
+EXPORT_SYMBOL(i2c_smbus_write_i2c_block_data);
 
 EXPORT_SYMBOL(i2c_get_functionality);
 EXPORT_SYMBOL(i2c_check_functionality);
--- linux/drivers/i2c/i2c-dev.c.orig    2001-10-11 11:05:47.000000000 -0400
+++ linux/drivers/i2c/i2c-dev.c 2002-07-23 09:01:28.000000000 -0400
@@ -28,7 +28,7 @@
 /* The devfs code is contributed by Philipp Matthias Hahn 
    <pmhahn@titan.lahn.de> */
 
-/* $Id: i2c-dev.c,v 1.40 2001/08/25 01:28:01 mds Exp $ */
+/* $Id: i2c-dev.c,v 1.46 2002/07/06 02:07:39 mds Exp $ */
 
 #include <linux/config.h>
 #include <linux/kernel.h>
@@ -36,9 +36,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/version.h>
-#if LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0)
 #include <linux/smp_lock.h>
-#endif /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
 #ifdef CONFIG_DEVFS_FS
 #include <linux/devfs_fs_kernel.h>
 #endif
@@ -49,7 +47,6 @@
 
 #include <linux/init.h>
 #include <asm/uaccess.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 
@@ -60,9 +57,6 @@
 
 /* struct file_operations changed too often in the 2.1 series for nice code */
 
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,9)
-static loff_t i2cdev_lseek (struct file *file, loff_t offset, int origin);
-#endif
 static ssize_t i2cdev_read (struct file *file, char *buf, size_t count, 
                             loff_t *offset);
 static ssize_t i2cdev_write (struct file *file, const char *buf, size_t count, 
@@ -88,14 +82,8 @@
 static int i2cdev_cleanup(void);
 
 static struct file_operations i2cdev_fops = {
-#if LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0)
        owner:          THIS_MODULE,
-#endif /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,9)
-       llseek:         i2cdev_lseek,
-#else
        llseek:         no_llseek,
-#endif
        read:           i2cdev_read,
        write:          i2cdev_write,
        ioctl:          i2cdev_ioctl,
@@ -133,20 +121,6 @@
 
 static int i2cdev_initialized;
 
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,9)
-/* Note that the lseek function is called llseek in 2.1 kernels. But things
-   are complicated enough as is. */
-loff_t i2cdev_lseek (struct file *file, loff_t offset, int origin)
-{
-#ifdef DEBUG
-       struct inode *inode = file->f_dentry->d_inode;
-       printk("i2c-dev.o: i2c-%d lseek to %ld bytes relative to %d.\n",
-              MINOR(inode->i_rdev),(long) offset,origin);
-#endif /* DEBUG */
-       return -ESPIPE;
-}
-#endif
-
 static ssize_t i2cdev_read (struct file *file, char *buf, size_t count,
                             loff_t *offset)
 {
@@ -165,7 +139,7 @@
                return -ENOMEM;
 
 #ifdef DEBUG
-       printk("i2c-dev.o: i2c-%d reading %d bytes.\n",MINOR(inode->i_rdev),
+       printk(KERN_DEBUG "i2c-dev.o: i2c-%d reading %d bytes.\n",MINOR(inode->i_rdev),
               count);
 #endif
 
@@ -197,7 +171,7 @@
        }
 
 #ifdef DEBUG
-       printk("i2c-dev.o: i2c-%d writing %d bytes.\n",MINOR(inode->i_rdev),
+       printk(KERN_DEBUG "i2c-dev.o: i2c-%d writing %d bytes.\n",MINOR(inode->i_rdev),
               count);
 #endif
        ret = i2c_master_send(client,tmp,count);
@@ -217,7 +191,7 @@
        unsigned long funcs;
 
 #ifdef DEBUG
-       printk("i2c-dev.o: i2c-%d ioctl, cmd: 0x%x, arg: %lx.\n", 
+       printk(KERN_DEBUG "i2c-dev.o: i2c-%d ioctl, cmd: 0x%x, arg: %lx.\n", 
               MINOR(inode->i_rdev),cmd, arg);
 #endif /* DEBUG */
 
@@ -237,6 +211,12 @@
                else
                        client->flags &= ~I2C_M_TEN;
                return 0;
+       case I2C_PEC:
+               if (arg)
+                       client->flags |= I2C_CLIENT_PEC;
+               else
+                       client->flags &= ~I2C_CLIENT_PEC;
+               return 0;
        case I2C_FUNCS:
                funcs = i2c_get_functionality(client->adapter);
                return (copy_to_user((unsigned long *)arg,&funcs,
@@ -313,9 +293,10 @@
                    (data_arg.size != I2C_SMBUS_WORD_DATA) &&
                    (data_arg.size != I2C_SMBUS_PROC_CALL) &&
                    (data_arg.size != I2C_SMBUS_BLOCK_DATA) &&
-                   (data_arg.size != I2C_SMBUS_I2C_BLOCK_DATA)) {
+                   (data_arg.size != I2C_SMBUS_I2C_BLOCK_DATA) &&
+                   (data_arg.size != I2C_SMBUS_BLOCK_PROC_CALL)) {
 #ifdef DEBUG
-                       printk("i2c-dev.o: size out of range (%x) in ioctl I2C_SMBUS.\n",
+                       printk(KERN_DEBUG "i2c-dev.o: size out of range (%x) in ioctl I2C_SMBUS.\n",
                               data_arg.size);
 #endif
                        return -EINVAL;
@@ -325,7 +306,7 @@
                if ((data_arg.read_write != I2C_SMBUS_READ) && 
                    (data_arg.read_write != I2C_SMBUS_WRITE)) {
 #ifdef DEBUG
-                       printk("i2c-dev.o: read_write out of range (%x) in ioctl I2C_SMBUS.\n",
+                       printk(KERN_DEBUG "i2c-dev.o: read_write out of range (%x) in ioctl I2C_SMBUS.\n",
                               data_arg.read_write);
 #endif
                        return -EINVAL;
@@ -345,7 +326,7 @@
 
                if (data_arg.data == NULL) {
 #ifdef DEBUG
-                       printk("i2c-dev.o: data is NULL pointer in ioctl I2C_SMBUS.\n");
+                       printk(KERN_DEBUG "i2c-dev.o: data is NULL pointer in ioctl I2C_SMBUS.\n");
 #endif
                        return -EINVAL;
                }
@@ -356,10 +337,11 @@
                else if ((data_arg.size == I2C_SMBUS_WORD_DATA) || 
                         (data_arg.size == I2C_SMBUS_PROC_CALL))
                        datasize = sizeof(data_arg.data->word);
-               else /* size == I2C_SMBUS_BLOCK_DATA */
+               else /* size == smbus block, i2c block, or block proc. call */
                        datasize = sizeof(data_arg.data->block);
 
                if ((data_arg.size == I2C_SMBUS_PROC_CALL) || 
+                   (data_arg.size == I2C_SMBUS_BLOCK_PROC_CALL) || 
                    (data_arg.read_write == I2C_SMBUS_WRITE)) {
                        if (copy_from_user(&temp, data_arg.data, datasize))
                                return -EFAULT;
@@ -368,6 +350,7 @@
                      data_arg.read_write,
                      data_arg.command,data_arg.size,&temp);
                if (! res && ((data_arg.size == I2C_SMBUS_PROC_CALL) || 
+                             (data_arg.size == I2C_SMBUS_BLOCK_PROC_CALL) || 
                              (data_arg.read_write == I2C_SMBUS_READ))) {
                        if (copy_to_user(data_arg.data, &temp, datasize))
                                return -EFAULT;
@@ -387,7 +370,7 @@
 
        if ((minor >= I2CDEV_ADAPS_MAX) || ! (i2cdev_adaps[minor])) {
 #ifdef DEBUG
-               printk("i2c-dev.o: Trying to open unattached adapter i2c-%d\n",
+               printk(KERN_DEBUG "i2c-dev.o: Trying to open unattached adapter i2c-%d\n",
                       minor);
 #endif
                return -ENODEV;
@@ -403,12 +386,8 @@
 
        if (i2cdev_adaps[minor]->inc_use)
                i2cdev_adaps[minor]->inc_use(i2cdev_adaps[minor]);
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0)
-       MOD_INC_USE_COUNT;
-#endif /* LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0) */
-
 #ifdef DEBUG
-       printk("i2c-dev.o: opened i2c-%d\n",minor);
+       printk(KERN_DEBUG "i2c-dev.o: opened i2c-%d\n",minor);
 #endif
        return 0;
 }
@@ -419,18 +398,12 @@
        kfree(file->private_data);
        file->private_data=NULL;
 #ifdef DEBUG
-       printk("i2c-dev.o: Closed: i2c-%d\n", minor);
+       printk(KERN_DEBUG "i2c-dev.o: Closed: i2c-%d\n", minor);
 #endif
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0)
-       MOD_DEC_USE_COUNT;
-#else /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
        lock_kernel();
-#endif /* LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0) */
        if (i2cdev_adaps[minor]->dec_use)
                i2cdev_adaps[minor]->dec_use(i2cdev_adaps[minor]);
-#if LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0)
        unlock_kernel();
-#endif /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
        return 0;
 }
 
@@ -440,11 +413,11 @@
        char name[8];
 
        if ((i = i2c_adapter_id(adap)) < 0) {
-               printk("i2c-dev.o: Unknown adapter ?!?\n");
+               printk(KERN_DEBUG "i2c-dev.o: Unknown adapter ?!?\n");
                return -ENODEV;
        }
        if (i >= I2CDEV_ADAPS_MAX) {
-               printk("i2c-dev.o: Adapter number too large?!? (%d)\n",i);
+               printk(KERN_DEBUG "i2c-dev.o: Adapter number too large?!? (%d)\n",i);
                return -ENODEV;
        }
 
@@ -457,7 +430,7 @@
                        S_IFCHR | S_IRUSR | S_IWUSR,
                        &i2cdev_fops, NULL);
 #endif
-               printk("i2c-dev.o: Registered '%s' as minor %d\n",adap->name,i);
+               printk(KERN_DEBUG "i2c-dev.o: Registered '%s' as minor %d\n",adap->name,i);
        } else {
                /* This is actually a detach_adapter call! */
 #ifdef CONFIG_DEVFS_FS
@@ -465,7 +438,7 @@
 #endif
                i2cdev_adaps[i] = NULL;
 #ifdef DEBUG
-               printk("i2c-dev.o: Adapter unregistered: %s\n",adap->name);
+               printk(KERN_DEBUG "i2c-dev.o: Adapter unregistered: %s\n",adap->name);
 #endif
        }
 
@@ -487,7 +460,7 @@
 {
        int res;
 
-       printk("i2c-dev.o: i2c /dev entries driver module\n");
+       printk(KERN_INFO "i2c-dev.o: i2c /dev entries driver module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
        i2cdev_initialized = 0;
 #ifdef CONFIG_DEVFS_FS
@@ -495,7 +468,7 @@
 #else
        if (register_chrdev(I2C_MAJOR,"i2c",&i2cdev_fops)) {
 #endif
-               printk("i2c-dev.o: unable to get major %d for i2c bus\n",
+               printk(KERN_ERR "i2c-dev.o: unable to get major %d for i2c bus\n",
                       I2C_MAJOR);
                return -EIO;
        }
@@ -505,7 +478,7 @@
        i2cdev_initialized ++;
 
        if ((res = i2c_add_driver(&i2cdev_driver))) {
-               printk("i2c-dev.o: Driver registration failed, module not inserted.\n");
+               printk(KERN_ERR "i2c-dev.o: Driver registration failed, module not inserted.\n");
                i2cdev_cleanup();
                return res;
        }
@@ -519,7 +492,7 @@
 
        if (i2cdev_initialized >= 2) {
                if ((res = i2c_del_driver(&i2cdev_driver))) {
-                       printk("i2c-dev.o: Driver deregistration failed, "
+                       printk(KERN_ERR "i2c-dev.o: Driver deregistration failed, "
                               "module not removed.\n");
                        return res;
                }
@@ -533,7 +506,7 @@
 #else
                if ((res = unregister_chrdev(I2C_MAJOR,"i2c"))) {
 #endif
-                       printk("i2c-dev.o: unable to release major %d for i2c bus\n",
+                       printk(KERN_ERR "i2c-dev.o: unable to release major %d for i2c bus\n",
                               I2C_MAJOR);
                        return res;
                }
--- linux/include/linux/i2c-dev.h.orig  2001-10-11 11:05:47.000000000 -0400
+++ linux/include/linux/i2c-dev.h       2002-07-23 01:54:44.000000000 -0400
@@ -19,7 +19,7 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-/* $Id: i2c-dev.h,v 1.9 2001/08/15 03:04:58 mds Exp $ */
+/* $Id: i2c-dev.h,v 1.11 2002/07/07 15:42:47 mds Exp $ */
 
 #ifndef I2C_DEV_H
 #define I2C_DEV_H
@@ -144,7 +144,7 @@
        else {
                for (i = 1; i <= data.block[0]; i++)
                        values[i-1] = data.block[i];
-                       return data.block[0];
+               return data.block[0];
        }
 }
 
@@ -162,6 +162,22 @@
                                I2C_SMBUS_BLOCK_DATA, &data);
 }
 
+/* Returns the number of read bytes */
+static inline __s32 i2c_smbus_read_i2c_block_data(int file, __u8 command,
+                                                  __u8 *values)
+{
+       union i2c_smbus_data data;
+       int i;
+       if (i2c_smbus_access(file,I2C_SMBUS_READ,command,
+                             I2C_SMBUS_I2C_BLOCK_DATA,&data))
+               return -1;
+       else {
+               for (i = 1; i <= data.block[0]; i++)
+                       values[i-1] = data.block[i];
+               return data.block[0];
+       }
+}
+
 static inline __s32 i2c_smbus_write_i2c_block_data(int file, __u8 command,
                                                __u8 length, __u8 *values)
 {
@@ -176,6 +192,27 @@
                                I2C_SMBUS_I2C_BLOCK_DATA, &data);
 }
 
+/* Returns the number of read bytes */
+static inline __s32 i2c_smbus_block_process_call(int file, __u8 command,
+                                                 __u8 length, __u8 *values)
+{
+       union i2c_smbus_data data;
+       int i;
+       if (length > 32)
+               length = 32;
+       for (i = 1; i <= length; i++)
+               data.block[i] = values[i-1];
+       data.block[0] = length;
+       if (i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
+                            I2C_SMBUS_BLOCK_PROC_CALL,&data))
+               return -1;
+       else {
+               for (i = 1; i <= data.block[0]; i++)
+                       values[i-1] = data.block[i];
+               return data.block[0];
+       }
+}
+
 #endif /* ndef __KERNEL__ */
 
 #endif
--- linux/include/linux/i2c-id.h.orig   2001-10-11 11:05:47.000000000 -0400
+++ linux/include/linux/i2c-id.h        2002-07-23 01:45:21.000000000 -0400
@@ -20,7 +20,7 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.               */
 /* ------------------------------------------------------------------------- */
 
-/* $Id: i2c-id.h,v 1.35 2001/08/12 17:22:20 mds Exp $ */
+/* $Id: i2c-id.h,v 1.52 2002/07/10 13:28:44 abz Exp $ */
 
 #ifndef I2C_ID_H
 #define I2C_ID_H
@@ -90,6 +90,14 @@
 #define I2C_DRIVERID_DRP3510   43     /* ADR decoder (Astra Radio)     */
 #define I2C_DRIVERID_SP5055    44     /* Satellite tuner               */
 #define I2C_DRIVERID_STV0030   45     /* Multipurpose switch           */
+#define I2C_DRIVERID_SAA7108   46     /* video decoder, image scaler   */
+#define I2C_DRIVERID_DS1307    47     /* DS1307 real time clock        */
+#define I2C_DRIVERID_ADV717x   48     /* ADV 7175/7176 video encoder   */
+#define I2C_DRIVERID_ZR36067   49     /* Zoran 36067 video encoder     */
+#define I2C_DRIVERID_ZR36120   50     /* Zoran 36120 video encoder     */
+#define I2C_DRIVERID_24LC32A   51              /* Microchip 24LC32A 32k EEPROM */
+
+
 
 #define I2C_DRIVERID_EXP0      0xF0    /* experimental use id's        */
 #define I2C_DRIVERID_EXP1      0xF1
@@ -98,6 +106,8 @@
 
 #define I2C_DRIVERID_I2CDEV    900
 #define I2C_DRIVERID_I2CPROC   901
+#define I2C_DRIVERID_ARP        902    /* SMBus ARP Client              */
+#define I2C_DRIVERID_ALERT      903    /* SMBus Alert Responder Client  */
 
 /* IDs --   Use DRIVERIDs 1000-1999 for sensors. 
    These were originally in sensors.h in the lm_sensors package */
@@ -127,6 +137,12 @@
 #define I2C_DRIVERID_ADM1024 1025
 #define I2C_DRIVERID_IT87 1026
 #define I2C_DRIVERID_CH700X 1027 /* single driver for CH7003-7009 digital pc to tv encoders */
+#define I2C_DRIVERID_FSCPOS 1028
+#define I2C_DRIVERID_FSCSCY 1029
+#define I2C_DRIVERID_PCF8591 1030
+#define I2C_DRIVERID_SMSC47M1 1031
+#define I2C_DRIVERID_VT1211 1032
+#define I2C_DRIVERID_LM92 1033
 
 /*
  * ---- Adapter types ----------------------------------------------------
@@ -143,10 +159,12 @@
 #define I2C_ALGO_ISA   0x050000        /* lm_sensors ISA pseudo-adapter */
 #define I2C_ALGO_SAA7146 0x060000      /* SAA 7146 video decoder bus   */
 #define I2C_ALGO_ACB   0x070000        /* ACCESS.bus algorithm         */
-
+#define I2C_ALGO_IIC    0x080000       /* ITE IIC bus */
+#define I2C_ALGO_SAA7134 0x090000
 #define I2C_ALGO_EC     0x100000        /* ACPI embedded controller     */
 
 #define I2C_ALGO_MPC8XX 0x110000       /* MPC8xx PowerPC I2C algorithm */
+#define I2C_ALGO_OCP    0x120000       /* IBM or otherwise On-chip I2C algorithm */
 
 #define I2C_ALGO_EXP   0x800000        /* experimental                 */
 
@@ -174,9 +192,11 @@
 #define I2C_HW_B_I810  0x0a    /* Intel I810                           */
 #define I2C_HW_B_VOO   0x0b    /* 3dfx Voodoo 3 / Banshee              */
 #define I2C_HW_B_PPORT  0x0c   /* Primitive parallel port adapter      */
+#define I2C_HW_B_SAVG  0x0d    /* Savage 4                             */
 #define I2C_HW_B_RIVA  0x10    /* Riva based graphics cards            */
 #define I2C_HW_B_IOC   0x11    /* IOC bit-wiggling                     */
 #define I2C_HW_B_TSUNA  0x12   /* DEC Tsunami chipset                  */
+#define I2C_HW_B_FRODO  0x13    /* 2d3D, Inc. SA-1110 Development Board */
 
 /* --- PCF 8584 based algorithms                                       */
 #define I2C_HW_P_LP    0x00    /* Parallel port interface              */
@@ -189,6 +209,13 @@
 /* --- MPC8xx PowerPC adapters                                         */
 #define I2C_HW_MPC8XX_EPON 0x00        /* Eponymous MPC8xx I2C adapter         */
 
+/* --- ITE based algorithms                                            */
+#define I2C_HW_I_IIC   0x00    /* controller on the ITE */
+
+/* --- PowerPC on-chip adapters                                                */
+#define I2C_HW_OCP 0x00        /* IBM on-chip I2C adapter      */
+
+
 /* --- SMBus only adapters                                             */
 #define I2C_HW_SMBUS_PIIX4     0x00
 #define I2C_HW_SMBUS_ALI15X3   0x01
--- linux/drivers/i2c/i2c-proc.c.orig   2002-02-25 14:37:57.000000000 -0500
+++ linux/drivers/i2c/i2c-proc.c        2002-07-23 09:14:57.000000000 -0400
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
@@ -67,10 +61,6 @@
 
 static struct i2c_client *i2c_clients[SENSORS_ENTRY_MAX];
 static unsigned short i2c_inodes[SENSORS_ENTRY_MAX];
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-static void i2c_fill_inode(struct inode *inode, int fill);
-static void i2c_dir_fill_inode(struct inode *inode, int fill);
-#endif                 /* LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1) */
 
 static ctl_table sysctl_table[] = {
        {CTL_DEV, "dev", NULL, 0, 0555},
@@ -180,9 +170,10 @@
                new_table[i].extra2 = client;
 
        if (!(new_header = register_sysctl_table(new_table, 0))) {
+               printk(KERN_ERR "i2c-proc.o: error: sysctl interface not supported by kernel!\n");
                kfree(new_table);
                kfree(name);
-               return -ENOMEM;
+               return -EPERM;
        }
 
        i2c_entries[id - 256] = new_header;
@@ -194,18 +185,13 @@
            !new_header->ctl_table->child->child ||
            !new_header->ctl_table->child->child->de) {
                printk
-                   ("i2c-proc.o: NULL pointer when trying to install fill_inode fix!\n");
+                   (KERN_ERR "i2c-proc.o: NULL pointer when trying to install fill_inode fix!\n");
                return id;
        }
 #endif                         /* DEBUG */
        i2c_inodes[id - 256] =
            new_header->ctl_table->child->child->de->low_ino;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27))
        new_header->ctl_table->child->child->de->owner = controlling_mod;
-#else
-       new_header->ctl_table->child->child->de->fill_inode =
-           &i2c_dir_fill_inode;
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27)) */
 
        return id;
 }
@@ -247,7 +233,7 @@
 
 #ifdef DEBUG
        if (!inode) {
-               printk("i2c-proc.o: Warning: inode NULL in fill_inode()\n");
+               printk(KERN_ERR "i2c-proc.o: Warning: inode NULL in fill_inode()\n");
                return;
        }
 #endif                         /* def DEBUG */
@@ -258,7 +244,7 @@
 #ifdef DEBUG
        if (i == SENSORS_ENTRY_MAX) {
                printk
-                   ("i2c-proc.o: Warning: inode (%ld) not found in fill_inode()\n",
+                   (KERN_ERR "i2c-proc.o: Warning: inode (%ld) not found in fill_inode()\n",
                     inode->i_ino);
                return;
        }
@@ -684,7 +670,7 @@
                                    && (addr == this_force->force[j + 1])) {
 #ifdef DEBUG
                                        printk
-                                           ("i2c-proc.o: found force parameter for adapter %d, addr %04x\n",
+                                           (KERN_DEBUG "i2c-proc.o: found force parameter for adapter %d, addr %04x\n",
                                             adapter_id, addr);
 #endif
                                        if (
@@ -714,7 +700,7 @@
                            && (addr == address_data->ignore[i + 1])) {
 #ifdef DEBUG
                                printk
-                                   ("i2c-proc.o: found ignore parameter for adapter %d, "
+                                   (KERN_DEBUG "i2c-proc.o: found ignore parameter for adapter %d, "
                                     "addr %04x\n", adapter_id, addr);
 #endif
                                found = 1;
@@ -734,7 +720,7 @@
                            && (addr <= address_data->ignore_range[i + 2])) {
 #ifdef DEBUG
                                printk
-                                   ("i2c-proc.o: found ignore_range parameter for adapter %d, "
+                                   (KERN_DEBUG "i2c-proc.o: found ignore_range parameter for adapter %d, "
                                     "addr %04x\n", adapter_id, addr);
 #endif
                                found = 1;
@@ -753,7 +739,7 @@
                                if (addr == address_data->normal_isa[i]) {
 #ifdef DEBUG
                                        printk
-                                           ("i2c-proc.o: found normal isa entry for adapter %d, "
+                                           (KERN_DEBUG "i2c-proc.o: found normal isa entry for adapter %d, "
                                             "addr %04x\n", adapter_id,
                                             addr);
 #endif
@@ -775,7 +761,7 @@
                                     0)) {
 #ifdef DEBUG
                                        printk
-                                           ("i2c-proc.o: found normal isa_range entry for adapter %d, "
+                                           (KERN_DEBUG "i2c-proc.o: found normal isa_range entry for adapter %d, "
                                             "addr %04x", adapter_id, addr);
 #endif
                                        found = 1;
@@ -789,7 +775,7 @@
                                        found = 1;
 #ifdef DEBUG
                                        printk
-                                           ("i2c-proc.o: found normal i2c entry for adapter %d, "
+                                           (KERN_DEBUG "i2c-proc.o: found normal i2c entry for adapter %d, "
                                             "addr %02x", adapter_id, addr);
 #endif
                                }
@@ -805,7 +791,7 @@
                                {
 #ifdef DEBUG
                                        printk
-                                           ("i2c-proc.o: found normal i2c_range entry for adapter %d, "
+                                           (KERN_DEBUG "i2c-proc.o: found normal i2c_range entry for adapter %d, "
                                             "addr %04x\n", adapter_id, addr);
 #endif
                                        found = 1;
@@ -822,7 +808,7 @@
                            && (addr == address_data->probe[i + 1])) {
 #ifdef DEBUG
                                printk
-                                   ("i2c-proc.o: found probe parameter for adapter %d, "
+                                   (KERN_DEBUG "i2c-proc.o: found probe parameter for adapter %d, "
                                     "addr %04x\n", adapter_id, addr);
 #endif
                                found = 1;
@@ -841,7 +827,7 @@
                                found = 1;
 #ifdef DEBUG
                                printk
-                                   ("i2c-proc.o: found probe_range parameter for adapter %d, "
+                                   (KERN_DEBUG "i2c-proc.o: found probe_range parameter for adapter %d, "
                                     "addr %04x\n", adapter_id, addr);
 #endif
                        }
@@ -862,17 +848,15 @@
 
 int __init sensors_init(void)
 {
-       printk("i2c-proc.o version %s (%s)\n", LM_VERSION, LM_DATE);
+       printk(KERN_INFO "i2c-proc.o version %s (%s)\n", I2C_VERSION, I2C_DATE);
        i2c_initialized = 0;
        if (!
            (i2c_proc_header =
-            register_sysctl_table(i2c_proc, 0))) return -ENOMEM;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,1))
+            register_sysctl_table(i2c_proc, 0))) {
+               printk(KERN_ERR "i2c-proc.o: error: sysctl interface not supported by kernel!\n");
+               return -EPERM;
+       }
        i2c_proc_header->ctl_table->child->de->owner = THIS_MODULE;
-#else
-       i2c_proc_header->ctl_table->child->de->fill_inode =
-           &i2c_fill_inode;
-#endif                 /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,1)) */
        i2c_initialized++;
        return 0;
 }
@@ -907,4 +891,5 @@
 {
        return i2c_cleanup();
 }
+
 #endif                         /* MODULE */
--- linux/include/linux/i2c-proc.h.orig 2001-10-11 11:05:47.000000000 -0400
+++ linux/include/linux/i2c-proc.h      2002-07-23 01:45:21.000000000 -0400
@@ -1,6 +1,7 @@
 /*
-    sensors.h - Part of lm_sensors, Linux kernel modules for hardware
-                monitoring
+    i2c-proc.h - Part of the i2c package
+    was originally sensors.h - Part of lm_sensors, Linux kernel modules
+                               for hardware monitoring
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
 
     This program is free software; you can redistribute it and/or modify
--- linux/include/linux/i2c.h.orig      2001-10-11 11:05:47.000000000 -0400
+++ linux/include/linux/i2c.h   2002-08-13 00:21:05.000000000 -0400
@@ -23,13 +23,13 @@
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c.h,v 1.46 2001/08/31 00:04:07 phil Exp $ */
+/* $Id: i2c.h,v 1.59 2002/07/19 20:53:45 phil Exp $ */
 
 #ifndef I2C_H
 #define I2C_H
 
-#define I2C_DATE "20010830"
-#define I2C_VERSION "2.6.1"
+#define I2C_DATE "20020719"
+#define I2C_VERSION "2.6.4"
 
 #include <linux/i2c-id.h>      /* id values of adapters et. al.        */
 #include <linux/types.h>
@@ -48,11 +48,8 @@
 #endif
 
 #include <asm/page.h>                  /* for 2.2.xx                   */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,0,25)
 #include <linux/sched.h>
-#else
 #include <asm/semaphore.h>
-#endif
 #include <linux/config.h>
 
 /* --- General options ------------------------------------------------        */
@@ -123,6 +120,8 @@
 extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
                                       u8 command, u8 length,
                                       u8 *values);
+extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
+                                         u8 command, u8 *values);
 extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
                                           u8 command, u8 length,
                                           u8 *values);
@@ -226,10 +225,6 @@
        u32 (*functionality) (struct i2c_adapter *);
 };
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,29)
-struct proc_dir_entry;
-#endif
-
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
@@ -267,9 +262,6 @@
 #ifdef CONFIG_PROC_FS 
        /* No need to set this when you initialize the adapter          */
        int inode;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,29)
-       struct proc_dir_entry *proc_entry;
-#endif
 #endif /* def CONFIG_PROC_FS */
 };
 
@@ -281,6 +273,9 @@
 #define I2C_CLIENT_ALLOW_USE           0x01    /* Client allows access */
 #define I2C_CLIENT_ALLOW_MULTIPLE_USE  0x02    /* Allow multiple access-locks */
                                                /* on an i2c_client */
+#define I2C_CLIENT_PEC  0x04                   /* Use Packet Error Checking */
+#define I2C_CLIENT_TEN 0x10                    /* we have a ten bit chip address       */
+                                               /* Must equal I2C_M_TEN below */
 
 /* i2c_client_address_data is the struct for holding default client
  * addresses for a driver and for the parameters supplied on the
@@ -396,6 +391,12 @@
 #define I2C_FUNC_I2C                   0x00000001
 #define I2C_FUNC_10BIT_ADDR            0x00000002
 #define I2C_FUNC_PROTOCOL_MANGLING     0x00000004 /* I2C_M_{REV_DIR_ADDR,NOSTART} */
+#define I2C_FUNC_SMBUS_HWPEC_CALC      0x00000008 /* SMBus 2.0 */
+#define I2C_FUNC_SMBUS_READ_WORD_DATA_PEC  0x00000800 /* SMBus 2.0 */ 
+#define I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC 0x00001000 /* SMBus 2.0 */ 
+#define I2C_FUNC_SMBUS_PROC_CALL_PEC   0x00002000 /* SMBus 2.0 */
+#define I2C_FUNC_SMBUS_BLOCK_PROC_CALL_PEC 0x00004000 /* SMBus 2.0 */
+#define I2C_FUNC_SMBUS_BLOCK_PROC_CALL 0x00008000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_QUICK           0x00010000 
 #define I2C_FUNC_SMBUS_READ_BYTE       0x00020000 
 #define I2C_FUNC_SMBUS_WRITE_BYTE      0x00040000 
@@ -406,8 +407,12 @@
 #define I2C_FUNC_SMBUS_PROC_CALL       0x00800000 
 #define I2C_FUNC_SMBUS_READ_BLOCK_DATA 0x01000000 
 #define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA 0x02000000 
-#define I2C_FUNC_SMBUS_READ_I2C_BLOCK  0x04000000 /* New I2C-like block */
-#define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK 0x08000000 /* transfer */
+#define I2C_FUNC_SMBUS_READ_I2C_BLOCK  0x04000000 /* I2C-like block xfer  */
+#define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK 0x08000000 /* w/ 1-byte reg. addr. */
+#define I2C_FUNC_SMBUS_READ_I2C_BLOCK_2         0x10000000 /* I2C-like block xfer  */
+#define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2 0x20000000 /* w/ 2-byte reg. addr. */
+#define I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC  0x40000000 /* SMBus 2.0 */
+#define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC 0x80000000 /* SMBus 2.0 */
 
 #define I2C_FUNC_SMBUS_BYTE I2C_FUNC_SMBUS_READ_BYTE | \
                             I2C_FUNC_SMBUS_WRITE_BYTE
@@ -419,21 +424,40 @@
                                   I2C_FUNC_SMBUS_WRITE_BLOCK_DATA
 #define I2C_FUNC_SMBUS_I2C_BLOCK I2C_FUNC_SMBUS_READ_I2C_BLOCK | \
                                   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
+#define I2C_FUNC_SMBUS_I2C_BLOCK_2 I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 | \
+                                   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2
+#define I2C_FUNC_SMBUS_BLOCK_DATA_PEC I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC | \
+                                      I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC
+#define I2C_FUNC_SMBUS_WORD_DATA_PEC  I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
+                                      I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC
+
+#define I2C_FUNC_SMBUS_READ_BYTE_PEC           I2C_FUNC_SMBUS_READ_BYTE_DATA
+#define I2C_FUNC_SMBUS_WRITE_BYTE_PEC          I2C_FUNC_SMBUS_WRITE_BYTE_DATA
+#define I2C_FUNC_SMBUS_READ_BYTE_DATA_PEC      I2C_FUNC_SMBUS_READ_WORD_DATA
+#define I2C_FUNC_SMBUS_WRITE_BYTE_DATA_PEC     I2C_FUNC_SMBUS_WRITE_WORD_DATA
+#define I2C_FUNC_SMBUS_BYTE_PEC                        I2C_FUNC_SMBUS_BYTE_DATA
+#define I2C_FUNC_SMBUS_BYTE_DATA_PEC           I2C_FUNC_SMBUS_WORD_DATA
 
 #define I2C_FUNC_SMBUS_EMUL I2C_FUNC_SMBUS_QUICK | \
                             I2C_FUNC_SMBUS_BYTE | \
                             I2C_FUNC_SMBUS_BYTE_DATA | \
                             I2C_FUNC_SMBUS_WORD_DATA | \
                             I2C_FUNC_SMBUS_PROC_CALL | \
-                            I2C_FUNC_SMBUS_WRITE_BLOCK_DATA
+                            I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
+                            I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC | \
+                            I2C_FUNC_SMBUS_I2C_BLOCK
 
 /* 
  * Data for SMBus Messages 
  */
+#define I2C_SMBUS_BLOCK_MAX    32      /* As specified in SMBus standard */    
+#define I2C_SMBUS_I2C_BLOCK_MAX        32      /* Not specified but we use same structure */
 union i2c_smbus_data {
        __u8 byte;
        __u16 word;
-       __u8 block[33]; /* block[0] is used for length */
+       __u8 block[I2C_SMBUS_BLOCK_MAX + 3]; /* block[0] is used for length */
+                          /* one more for read length in block process call */
+                                                   /* and one more for PEC */
 };
 
 /* smbus_access read or write markers */
@@ -449,6 +473,11 @@
 #define I2C_SMBUS_PROC_CALL        4
 #define I2C_SMBUS_BLOCK_DATA       5
 #define I2C_SMBUS_I2C_BLOCK_DATA    6
+#define I2C_SMBUS_BLOCK_PROC_CALL   7          /* SMBus 2.0 */
+#define I2C_SMBUS_BLOCK_DATA_PEC    8          /* SMBus 2.0 */
+#define I2C_SMBUS_PROC_CALL_PEC     9          /* SMBus 2.0 */
+#define I2C_SMBUS_BLOCK_PROC_CALL_PEC  10      /* SMBus 2.0 */
+#define I2C_SMBUS_WORD_DATA_PEC           11           /* SMBus 2.0 */
 
 
 /* ----- commands for the ioctl like i2c_command call:
@@ -474,6 +503,7 @@
 
 #define I2C_FUNCS      0x0705  /* Get the adapter functionality */
 #define I2C_RDWR       0x0707  /* Combined R/W transfer (one stop only)*/
+#define I2C_PEC                0x0708  /* != 0 for SMBus PEC                   */
 #if 0
 #define I2C_ACK_TEST   0x0710  /* See if a slave is at a specific address */
 #endif

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
