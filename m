Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318132AbSHIDTR>; Thu, 8 Aug 2002 23:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318133AbSHIDTR>; Thu, 8 Aug 2002 23:19:17 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:64751 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318132AbSHIDTE>; Thu, 8 Aug 2002 23:19:04 -0400
Message-ID: <3D533580.887FE43F@attbi.com>
Date: Thu, 08 Aug 2002 23:22:40 -0400
From: Albert Cranford <ac9410@attbi.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 2/4] 2.5.30 i2c updates
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Please apply the following four patches that update
2.5.30 with these I2C changes:
o Support for SMBus 2.0 PEC Packet Error Checking
o New adapter-i2c-frodo for SA 1110 board
o New adapter-i2c-rpx for embeded MPC8XX
o Replace depreciated cli()&sti() with spin_{un}lock_irq()
o Updated documentation
Thanks,
Albert

--- linux/drivers/i2c/i2c-core.c.orig   2002-07-05 19:42:07.000000000 -0400
+++ linux/drivers/i2c/i2c-core.c        2002-07-07 21:37:15.000000000 -0400
@@ -18,9 +18,10 @@
 /* ------------------------------------------------------------------------- */
 
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi>.
-   All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl> */
+   All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl>
+   SMBus 2.0 support by Mark Studebaker <mdsxyz123@yahoo.com>                */
 
-/* $Id: i2c-core.c,v 1.73 2002/03/03 17:37:44 mds Exp $ */
+/* $Id: i2c-core.c,v 1.83 2002/07/08 01:37:15 mds Exp $ */
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -71,7 +72,7 @@
 static int driver_count;
 
 /**** debug level */
-static int i2c_debug=1;
+static int i2c_debug=1;
 
 /* ---------------------------------------------------
  * /proc entry declarations
@@ -371,7 +372,7 @@
                                struct i2c_client *client = adap->clients[j];
                                if (client != NULL && 
                                    client->driver == driver) {
-                                       DEB2(printk("i2c-core.o: "
+                                       DEB2(printk(KERN_DEBUG "i2c-core.o: "
                                                    "detaching client %s:\n",
                                                    client->name));
                                        if ((res = driver->
@@ -1002,6 +1001,123 @@
 
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
@@ -1020,8 +1136,9 @@
 
 extern s32 i2c_smbus_write_byte(struct i2c_client * client, u8 value)
 {
+       union i2c_smbus_data data;      /* only for PEC */
        return i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-                             I2C_SMBUS_WRITE,value, I2C_SMBUS_BYTE,NULL);
+                             I2C_SMBUS_WRITE,value, I2C_SMBUS_BYTE,&data);
 }
 
 extern s32 i2c_smbus_read_byte_data(struct i2c_client * client, u8 command)
@@ -1099,8 +1216,8 @@
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
@@ -1110,6 +1227,26 @@
 }
 
 /* Returns the number of read bytes */
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
 extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
                                          u8 command, u8 *values)
 {
@@ -1131,8 +1268,8 @@
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
@@ -1194,34 +1331,43 @@
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
-                       printk(KERN_ERR "i2c-core.o: Block read not supported under "
-                              "I2C emulation!\n");
-               return -1;
+                       printk(KERN_ERR "i2c-core.o: Block read not supported "
+                              "under I2C emulation!\n");
+                       return -1;
                } else {
                        msg[0].len = data->block[0] + 2;
-                       if (msg[0].len > 34) {
+                       if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 2) {
                                printk(KERN_ERR "i2c-core.o: smbus_access called with "
                                       "invalid block write size (%d)\n",
                                       data->block[0]);
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
        case I2C_SMBUS_I2C_BLOCK_DATA:
                if (read_write == I2C_SMBUS_READ) {
-                       msg[1].len = 32;
+                       msg[1].len = I2C_SMBUS_I2C_BLOCK_MAX;
                } else {
                        msg[0].len = data->block[0] + 2;
-                       if (msg[0].len > 34) {
+                       if (msg[0].len > I2C_SMBUS_I2C_BLOCK_MAX + 2) {
                                printk("i2c-core.o: i2c_smbus_xfer_emulated called with "
                                       "invalid block write size (%d)\n",
                                       data->block[0]);
@@ -1254,8 +1400,8 @@
                                break;
                        case I2C_SMBUS_I2C_BLOCK_DATA:
                                /* fixed at 32 for now */
-                               data->block[0] = 32;
-                               for (i = 0; i < 32; i++)
+                               data->block[0] = I2C_SMBUS_I2C_BLOCK_MAX;
+                               for (i = 0; i < I2C_SMBUS_I2C_BLOCK_MAX; i++)
                                        data->block[i+1] = msgbuf1[i];
                                break;
                }
@@ -1268,7 +1414,29 @@
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
@@ -1277,6 +1445,14 @@
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
 
--- linux/drivers/i2c/i2c-dev.c.orig    2002-07-05 19:42:33.000000000 -0400
+++ linux/drivers/i2c/i2c-dev.c 2002-07-05 22:07:39.000000000 -0400
@@ -28,7 +28,7 @@
 /* The devfs code is contributed by Philipp Matthias Hahn 
    <pmhahn@titan.lahn.de> */
 
-/* $Id: i2c-dev.c,v 1.44 2001/11/19 18:45:02 mds Exp $ */
+/* $Id: i2c-dev.c,v 1.46 2002/07/06 02:07:39 mds Exp $ */
 
 #include <linux/config.h>
 #include <linux/kernel.h>
@@ -236,6 +236,12 @@
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
@@ -312,7 +318,8 @@
                    (data_arg.size != I2C_SMBUS_WORD_DATA) &&
                    (data_arg.size != I2C_SMBUS_PROC_CALL) &&
                    (data_arg.size != I2C_SMBUS_BLOCK_DATA) &&
-                   (data_arg.size != I2C_SMBUS_I2C_BLOCK_DATA)) {
+                   (data_arg.size != I2C_SMBUS_I2C_BLOCK_DATA) &&
+                   (data_arg.size != I2C_SMBUS_BLOCK_PROC_CALL)) {
 #ifdef DEBUG
                        printk(KERN_DEBUG "i2c-dev.o: size out of range (%x) in ioctl I2C_SMBUS.\n",
                               data_arg.size);
@@ -355,10 +362,11 @@
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
@@ -367,6 +375,7 @@
                      data_arg.read_write,
                      data_arg.command,data_arg.size,&temp);
                if (! res && ((data_arg.size == I2C_SMBUS_PROC_CALL) || 
+                             (data_arg.size == I2C_SMBUS_BLOCK_PROC_CALL) || 
                              (data_arg.read_write == I2C_SMBUS_READ))) {
                        if (copy_to_user(data_arg.data, &temp, datasize))
                                return -EFAULT;
@@ -535,6 +544,8 @@
        return 0;
 }
 
+EXPORT_NO_SYMBOLS;
+
 #ifdef MODULE
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and Simon G. Vogl <simon@tk.uni-linz.ac.at>");
--- linux/include/linux/i2c-dev.h.orig  2002-07-05 19:42:19.000000000 -0400
+++ linux/include/linux/i2c-dev.h       2002-07-07 11:42:47.000000000 -0400
@@ -19,7 +19,7 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-/* $Id: i2c-dev.h,v 1.10 2001/11/19 19:01:46 mds Exp $ */
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
 
@@ -192,6 +192,27 @@
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
--- linux/include/linux/i2c-id.h.orig   2002-07-05 19:42:03.000000000 -0400
+++ linux/include/linux/i2c-id.h        2002-07-10 09:28:44.000000000 -0400
@@ -20,7 +20,7 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.               */
 /* ------------------------------------------------------------------------- */
 
-/* $Id: i2c-id.h,v 1.41 2002/03/11 07:18:55 simon Exp $ */
+/* $Id: i2c-id.h,v 1.52 2002/07/10 13:28:44 abz Exp $ */
 
 #ifndef I2C_ID_H
 #define I2C_ID_H
@@ -90,8 +90,12 @@
 #define I2C_DRIVERID_DRP3510   43     /* ADR decoder (Astra Radio)     */
 #define I2C_DRIVERID_SP5055    44     /* Satellite tuner               */
 #define I2C_DRIVERID_STV0030   45     /* Multipurpose switch           */
-#define I2C_DRIVERID_SAA7108    46     /* video decoder, image scaler   */
-
+#define I2C_DRIVERID_SAA7108   46     /* video decoder, image scaler   */
+#define I2C_DRIVERID_DS1307    47     /* DS1307 real time clock        */
+#define I2C_DRIVERID_ADV717x   48     /* ADV 7175/7176 video encoder   */
+#define I2C_DRIVERID_ZR36067   49     /* Zoran 36067 video encoder     */
+#define I2C_DRIVERID_ZR36120   50     /* Zoran 36120 video encoder     */
+#define I2C_DRIVERID_24LC32A   51              /* Microchip 24LC32A 32k EEPROM */
 
 
 
@@ -102,6 +106,8 @@
 
 #define I2C_DRIVERID_I2CDEV    900
 #define I2C_DRIVERID_I2CPROC   901
+#define I2C_DRIVERID_ARP        902    /* SMBus ARP Client              */
+#define I2C_DRIVERID_ALERT      903    /* SMBus Alert Responder Client  */
 
 /* IDs --   Use DRIVERIDs 1000-1999 for sensors. 
    These were originally in sensors.h in the lm_sensors package */
@@ -134,6 +140,9 @@
 #define I2C_DRIVERID_FSCPOS 1028
 #define I2C_DRIVERID_FSCSCY 1029
 #define I2C_DRIVERID_PCF8591 1030
+#define I2C_DRIVERID_SMSC47M1 1031
+#define I2C_DRIVERID_VT1211 1032
+#define I2C_DRIVERID_LM92 1033
 
 /*
  * ---- Adapter types ----------------------------------------------------
@@ -155,6 +164,7 @@
 #define I2C_ALGO_EC     0x100000        /* ACPI embedded controller     */
 
 #define I2C_ALGO_MPC8XX 0x110000       /* MPC8xx PowerPC I2C algorithm */
+#define I2C_ALGO_OCP    0x120000       /* IBM or otherwise On-chip I2C algorithm */
 
 #define I2C_ALGO_EXP   0x800000        /* experimental                 */
 
@@ -182,9 +192,11 @@
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
@@ -200,6 +212,10 @@
 /* --- ITE based algorithms                                            */
 #define I2C_HW_I_IIC   0x00    /* controller on the ITE */
 
+/* --- PowerPC on-chip adapters                                                */
+#define I2C_HW_OCP 0x00        /* IBM on-chip I2C adapter      */
+
+
 /* --- SMBus only adapters                                             */
 #define I2C_HW_SMBUS_PIIX4     0x00
 #define I2C_HW_SMBUS_ALI15X3   0x01
--- linux/drivers/i2c/i2c-proc.c.orig   2002-07-05 19:42:28.000000000 -0400
+++ linux/drivers/i2c/i2c-proc.c        2002-04-22 19:21:49.000000000 -0400
@@ -60,6 +68,7 @@
 static struct ctl_table_header *i2c_entries[SENSORS_ENTRY_MAX];
 
 static struct i2c_client *i2c_clients[SENSORS_ENTRY_MAX];
+static unsigned short i2c_inodes[SENSORS_ENTRY_MAX];
 
 static ctl_table sysctl_table[] = {
        {CTL_DEV, "dev", NULL, 0, 0555},
@@ -172,7 +185,7 @@
                printk(KERN_ERR "i2c-proc.o: error: sysctl interface not supported by kernel!\n");
                kfree(new_table);
                kfree(name);
-               return -ENOMEM;
+               return -EPERM;
        }
 
        i2c_entries[id - 256] = new_header;
@@ -188,6 +201,8 @@
                return id;
        }
 #endif                         /* DEBUG */
+       i2c_inodes[id - 256] =
+           new_header->ctl_table->child->child->de->low_ino;
        new_header->ctl_table->child->child->de->owner = controlling_mod;
 
        return id;
@@ -210,6 +230,49 @@
        }
 }
 
+/* Monitor access for /proc/sys/dev/sensors; make unloading i2c-proc.o 
+   impossible if some process still uses it or some file in it */
+void i2c_fill_inode(struct inode *inode, int fill)
+{
+       if (fill)
+               MOD_INC_USE_COUNT;
+       else
+               MOD_DEC_USE_COUNT;
+}
+
+/* Monitor access for /proc/sys/dev/sensors/ directories; make unloading
+   the corresponding module impossible if some process still uses it or
+   some file in it */
+void i2c_dir_fill_inode(struct inode *inode, int fill)
+{
+       int i;
+       struct i2c_client *client;
+
+#ifdef DEBUG
+       if (!inode) {
+               printk(KERN_ERR "i2c-proc.o: Warning: inode NULL in fill_inode()\n");
+               return;
+       }
+#endif                         /* def DEBUG */
+
+       for (i = 0; i < SENSORS_ENTRY_MAX; i++)
+               if (i2c_clients[i]
+                   && (i2c_inodes[i] == inode->i_ino)) break;
+#ifdef DEBUG
+       if (i == SENSORS_ENTRY_MAX) {
+               printk
+                   (KERN_ERR "i2c-proc.o: Warning: inode (%ld) not found in fill_inode()\n",
+                    inode->i_ino);
+               return;
+       }
+#endif                         /* def DEBUG */
+       client = i2c_clients[i];
+       if (fill)
+               client->driver->inc_use(client);
+       else
+               client->driver->dec_use(client);
+}
+
 int i2c_proc_chips(ctl_table * ctl, int write, struct file *filp,
                       void *buffer, size_t * lenp)
 {
--- linux/include/linux/i2c.h.orig      2002-07-05 19:42:14.000000000 -0400
+++ linux/include/linux/i2c.h   2002-07-19 16:53:45.000000000 -0400
@@ -23,15 +23,15 @@
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c.h,v 1.50 2002/03/23 00:53:38 phil Exp $ */
+/* $Id: i2c.h,v 1.59 2002/07/19 20:53:45 phil Exp $ */
 
 #ifndef I2C_H
 #define I2C_H
 
-#define I2C_DATE "20020322"
-#define I2C_VERSION "2.6.3"
+#define I2C_DATE "20020719"
+#define I2C_VERSION "2.6.4"
 
-#include <linux/i2c-id.h>      /* id values of adapters et. al.        */
+#include <linux/i2c-id.h>      /* id values of adapters et. al.        */
 #include <linux/types.h>
 
 
@@ -280,6 +283,9 @@
 #define I2C_CLIENT_ALLOW_USE           0x01    /* Client allows access */
 #define I2C_CLIENT_ALLOW_MULTIPLE_USE  0x02    /* Allow multiple access-locks */
                                                /* on an i2c_client */
+#define I2C_CLIENT_PEC  0x04                   /* Use Packet Error Checking */
+#define I2C_CLIENT_TEN 0x10                    /* we have a ten bit chip address       */
+                                               /* Must equal I2C_M_TEN below */
 
 /* i2c_client_address_data is the struct for holding default client
  * addresses for a driver and for the parameters supplied on the
@@ -395,6 +401,12 @@
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
@@ -409,6 +421,8 @@
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK 0x08000000 /* w/ 1-byte reg. addr. */
 #define I2C_FUNC_SMBUS_READ_I2C_BLOCK_2         0x10000000 /* I2C-like block xfer  */
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2 0x20000000 /* w/ 2-byte reg. addr. */
+#define I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC  0x40000000 /* SMBus 2.0 */
+#define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC 0x80000000 /* SMBus 2.0 */
 
 #define I2C_FUNC_SMBUS_BYTE I2C_FUNC_SMBUS_READ_BYTE | \
                             I2C_FUNC_SMBUS_WRITE_BYTE
@@ -422,6 +436,17 @@
                                   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
 #define I2C_FUNC_SMBUS_I2C_BLOCK_2 I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 | \
                                    I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2
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
@@ -429,16 +454,20 @@
                             I2C_FUNC_SMBUS_WORD_DATA | \
                             I2C_FUNC_SMBUS_PROC_CALL | \
                             I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
-                            I2C_FUNC_SMBUS_I2C_BLOCK | \
-                            I2C_FUNC_SMBUS_I2C_BLOCK_2
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
@@ -454,6 +483,11 @@
 #define I2C_SMBUS_PROC_CALL        4
 #define I2C_SMBUS_BLOCK_DATA       5
 #define I2C_SMBUS_I2C_BLOCK_DATA    6
+#define I2C_SMBUS_BLOCK_PROC_CALL   7          /* SMBus 2.0 */
+#define I2C_SMBUS_BLOCK_DATA_PEC    8          /* SMBus 2.0 */
+#define I2C_SMBUS_PROC_CALL_PEC     9          /* SMBus 2.0 */
+#define I2C_SMBUS_BLOCK_PROC_CALL_PEC  10      /* SMBus 2.0 */
+#define I2C_SMBUS_WORD_DATA_PEC           11           /* SMBus 2.0 */
 
 
 /* ----- commands for the ioctl like i2c_command call:
@@ -479,6 +513,7 @@
 
 #define I2C_FUNCS      0x0705  /* Get the adapter functionality */
 #define I2C_RDWR       0x0707  /* Combined R/W transfer (one stop only)*/
+#define I2C_PEC                0x0708  /* != 0 for SMBus PEC                   */
 #if 0
 #define I2C_ACK_TEST   0x0710  /* See if a slave is at a specific address */
 #endif

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
