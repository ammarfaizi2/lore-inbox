Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbWIKX57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbWIKX57 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965179AbWIKX57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:57:59 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:62853 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965174AbWIKX55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:57:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fMJ1YNXb7RnoHhtY6u4bEoWzuNCSvYtmYIQQiUFCFaMKjaDoamcJVVuJYar73W2CJPjZ/Ld8V4yccNz39pp1xsNFK++z3I/p0KXQJCeMA0btJyvIcENxmL8PO1Eu3okJn0Wxo7ZxMIQWyiIF0csqqVFTsS9Pwgc6li6hhoGQfuc=
Message-ID: <653402b90609111657r1fa861e0gf4d71508df60a5ec@mail.gmail.com>
Date: Tue, 12 Sep 2006 01:57:23 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: akpm@osdl.org
Subject: [PATCH 2/2] display: Driver ks0108 and cfag12864b
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <653402b90609111627q661cded8l757129311fbe92d4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <653402b90609111627q661cded8l757129311fbe92d4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda Sandonis

Adds support for additional "display" devices, like small LCD screens.
Adds support for the ks0108 LCD Controller.
Adds support for the cfag12864b LCD.

Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff -uprN -X linux-2.6.17.13-vanilla/Documentation/dontdiff
linux-2.6.17.13-vanilla/drivers/display/cfag12864b.c
linux-2.6.17.13/drivers/display/cfag12864b.c
--- linux-2.6.17.13-vanilla/drivers/display/cfag12864b.c        1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.17.13/drivers/display/cfag12864b.c        2006-09-11
23:48:59.000000000 +0200
@@ -0,0 +1,585 @@
+/*
+ *    Filename: cfag12864b.c
+ *     Version: 0.1.0
+ * Description: cfag12864b LCD Display Driver
+ *     License: GPL
+ *     Depends: display ks0108
+ *
+ *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-09-10
+ */
+
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/display.h>
+#include <linux/ks0108.h>
+#include <linux/cfag12864b.h>
+#include <asm/uaccess.h>
+
+#define NAME "cfag12864b"
+#define PRINTK_PREFIX  KERN_INFO NAME ": "
+
+
+
+//
+// Device
+//
+
+static const unsigned int FirstMinor = 0;
+static const unsigned int nDevices = 1;
+static const char * Name = NAME;
+
+static int Major;
+static dev_t FirstDevice;
+
+struct cfag12864b
+{
+       int Minor;
+       dev_t Device;
+       struct cdev CharDevice;
+};
+
+static struct cfag12864b * Devices;
+
+
+
+//
+// cfag12864b Commands
+//
+
+#define Bit(n) ((unsigned char)(1<<(n)))
+#define NoBit(n) ((unsigned char)(~Bit(n)))
+static const unsigned int Bits = 8;
+
+static const unsigned int Width = CFAG12864B_WIDTH;
+static const unsigned int Height = CFAG12864B_HEIGHT;
+static const unsigned int MatrixSize = CFAG12864B_MATRIXSIZE;
+static const unsigned int Controllers = CFAG12864B_CONTROLLERS;
+static const unsigned int Pages = CFAG12864B_PAGES;
+static const unsigned int Addresses = CFAG12864B_ADDRESSES;
+static const unsigned int Size = CFAG12864B_SIZE;
+
+static unsigned char State = 0;
+
+void cfag12864b_Set(void)
+{
+       ks0108_WriteControl(State ^ (Bit(3) | Bit(1) | Bit(0)) );
+}
+
+void cfag12864b_E(unsigned char _State)
+{
+       if(_State)
+               State |= Bit(0);
+       else
+               State &= NoBit(0);
+       cfag12864b_Set();
+}
+
+void cfag12864b_CS1(unsigned char _State)
+{
+       if(_State)
+               State |= Bit(2);
+       else
+               State &= NoBit(2);
+       cfag12864b_Set();
+}
+
+void cfag12864b_CS2(unsigned char _State)
+{
+       if(_State)
+               State |= Bit(1);
+       else
+               State &= NoBit(1);
+       cfag12864b_Set();
+}
+
+void cfag12864b_DI(unsigned char _State)
+{
+       if(_State)
+               State |= Bit(3);
+       else
+               State &= NoBit(3);
+       cfag12864b_Set();
+}
+
+void cfag12864b_FirstController(unsigned char _State)
+{
+       if(_State)
+               cfag12864b_CS1(0);
+       else
+               cfag12864b_CS1(1);
+}
+
+void cfag12864b_SecondController(unsigned char _State)
+{
+       if(_State)
+               cfag12864b_CS2(0);
+       else
+               cfag12864b_CS2(1);
+}
+
+void cfag12864b_Controllers(unsigned char _First, unsigned char _Second)
+{
+       cfag12864b_FirstController(_First);
+       cfag12864b_SecondController(_Second);
+}
+
+void cfag12864b_Controller(unsigned char _Which)
+{
+       if(_Which==0)
+               cfag12864b_Controllers(1,0);
+       else if(_Which==1)
+               cfag12864b_Controllers(0,1);
+}
+
+void cfag12864b_DisplayState(unsigned char _State)
+{
+       cfag12864b_DI(0);
+       cfag12864b_E(1);
+       ks0108_DisplayState(_State);
+       cfag12864b_E(0);
+}
+
+void cfag12864b_Address(unsigned char _Address)
+{
+       cfag12864b_DI(0);
+       cfag12864b_E(1);
+       ks0108_Address(_Address);
+       cfag12864b_E(0);
+}
+
+void cfag12864b_Page(unsigned char _Page)
+{
+       cfag12864b_DI(0);
+       cfag12864b_E(1);
+       ks0108_Page(_Page);
+       cfag12864b_E(0);
+}
+
+void cfag12864b_StartLine(unsigned char _StartLine)
+{
+       cfag12864b_DI(0);
+       cfag12864b_E(1);
+       ks0108_StartLine(_StartLine);
+       cfag12864b_E(0);
+}
+
+void cfag12864b_WriteByte(unsigned char _Byte)
+{
+       cfag12864b_DI(1);
+       cfag12864b_E(1);
+       ks0108_WriteData(_Byte);
+       cfag12864b_E(0);
+}
+
+void cfag12864b_NOP(void)
+{
+       cfag12864b_StartLine(0);
+}
+
+
+
+//
+// Auxiliar
+//
+
+void NormalizeOffset(unsigned int * _Offset)
+{
+       if(*_Offset>=Pages*Addresses)
+               *_Offset-=Pages*Addresses;
+}
+
+unsigned char GetAddress(unsigned int _Offset)
+{
+       NormalizeOffset(&_Offset);
+       return _Offset%Addresses;
+}
+
+unsigned char GetController(unsigned int _Offset)
+{
+       if(_Offset<Pages*Addresses)
+               return 0;
+       return 1;
+}
+
+unsigned char GetPage(unsigned int _Offset)
+{
+       NormalizeOffset(&_Offset);
+       return _Offset/Addresses;
+}
+
+
+
+//
+// cfag12864b Exported Commands
+//
+
+void cfag12864b_On(void)
+{
+       cfag12864b_Controllers(1,1);
+       cfag12864b_DisplayState(1);
+}
+
+void cfag12864b_Off(void)
+{
+       cfag12864b_Controllers(1,1);
+       cfag12864b_DisplayState(0);
+}
+
+void cfag12864b_Clear(void)
+{
+       unsigned char Page,Address;
+
+       cfag12864b_Controllers(1,1);
+       for(Page=0; Page<Pages; ++Page) {
+               cfag12864b_Page(Page);
+               cfag12864b_Address(0);
+               for(Address=0; Address<Addresses; ++Address)
+                       cfag12864b_WriteByte(0x00);
+       }
+}
+
+void cfag12864b_Write(
+       unsigned short _Offset,
+       unsigned char * _Buffer,
+       unsigned short _Count)
+{
+       unsigned short i;
+
+       // Invalid values: They get updated at the first cycle
+       unsigned char Controller = 0xFF;
+       unsigned char Page = 0xFF;
+       unsigned char Address = 0xFF;
+
+       unsigned char tmpController, tmpPage, tmpAddress;
+
+       for(i=0; i<_Count; ++i, ++_Offset, ++Address) {
+               tmpController = GetController(_Offset);
+               tmpPage = GetPage(_Offset);
+               tmpAddress = GetAddress(_Offset);
+
+               if(Controller != tmpController) {
+                       Controller = tmpController;
+                       cfag12864b_Controller(Controller);
+                       cfag12864b_NOP();
+               }
+               if(Page != tmpPage) {
+                       Page = tmpPage;
+                       cfag12864b_Page(Page);
+                       cfag12864b_NOP();
+               }
+
+               /*if(Address != tmpAddress) {
+                       Address = tmpAddress;
+                       cfag12864b_Address(Address);
+                       cfag12864b_NOP();
+               }*/
+
+               /*if(tmpController == 0) {
+                       if(Address != tmpAddress) {
+                               Address = tmpAddress;
+                               cfag12864b_Address(Address);
+                       }
+               }
+               else {
+                       cfag12864b_Address(tmpAddress);
+                       cfag12864b_NOP();
+               }*/
+
+               // Safe method, still quick
+               cfag12864b_Address(tmpAddress);
+               cfag12864b_NOP();
+
+               // Dummy
+               cfag12864b_NOP();
+
+               cfag12864b_WriteByte(_Buffer[i]);
+       }
+}
+
+void cfag12864b_Format(unsigned char * _Src)
+{
+       unsigned short Controller,Page,Address,Bit;
+       unsigned char * Dest = kmalloc(sizeof(unsigned char)*Size,GFP_KERNEL);
+
+       if(Dest == NULL) {
+               printk(PRINTK_PREFIX "Format: ERROR: "
+                       "kmalloc\n");
+               return;
+       }
+
+       for(Controller=0; Controller<Controllers; ++Controller)
+       for(Page=0; Page<Pages; ++Page)
+       for(Address=0; Address<Addresses; ++Address) {
+               Dest[(Controller*Pages+Page)*Addresses+Address]=0;
+               for(Bit=0; Bit<Bits; ++Bit)
+
if(_Src[Controller*Addresses+Address+(Page*Bits+Bit)*Width])
+
Dest[(Controller*Pages+Page)*Addresses+Address]|=Bit(Bit);
+       }
+
+       cfag12864b_Write(0,Dest,Size);
+
+       kfree(Dest);
+}
+
+EXPORT_SYMBOL_GPL(cfag12864b_On);
+EXPORT_SYMBOL_GPL(cfag12864b_Off);
+EXPORT_SYMBOL_GPL(cfag12864b_Clear);
+EXPORT_SYMBOL_GPL(cfag12864b_Write);
+EXPORT_SYMBOL_GPL(cfag12864b_Format);
+
+
+//
+// Fops
+//
+
+int Open(
+       struct inode * _Inode,
+       struct file * _File)
+{
+       _File->private_data = container_of(_Inode->i_cdev, struct
cfag12864b, CharDevice);
+
+       return 0;
+}
+
+loff_t Seek(
+       struct file * _File,
+       loff_t _Offset,
+       int _Whence)
+{
+       loff_t New;
+
+       switch(_Whence) {
+       case 0: // SEEK_SET
+               New = _Offset;
+               break;
+       case 1: // SEEK_CUR
+               New = _File->f_pos + _Offset;
+               break;
+       case 2: // SEEK_END
+               New = Size + _Offset;
+               break;
+       default:
+               return -EINVAL;
+       }
+
+       if(New < 0)
+               return -EINVAL;
+       _File->f_pos = New;
+       return New;
+}
+
+
+ssize_t Write(
+       struct file * _File,
+       const char __user * _Buffer,
+       size_t _Count,
+       loff_t * _Offset)
+{
+       int Result;
+       char * Buffer;
+
+       if(*_Offset>Size)
+               return 0;
+       if(*_Offset+_Count>Size)
+               _Count=Size-*_Offset;
+
+       Buffer = kmalloc(_Count,GFP_KERNEL);
+       if(Buffer == NULL) {
+               printk(PRINTK_PREFIX "FOP Write: ERROR: "
+                       "kmalloc\n");
+               return -ENOMEM;
+       }
+
+       Result = copy_from_user(Buffer, _Buffer, _Count);
+       if(Result != 0) {
+               printk(PRINTK_PREFIX "FOP Write: ERROR: "
+                       "copy_from_user\n");
+               Result = -EFAULT;
+               goto out;
+       }
+
+       cfag12864b_Write(*_Offset, Buffer, _Count);
+
+       *_Offset += _Count;
+       Result = _Count;
+
+out:
+       kfree(Buffer);
+       return Result;
+}
+
+int IOCtl_Format(unsigned long _Arg)
+{
+       int Result,Return = -ENOTTY;
+
+       unsigned char * IOCFormatSrc;
+
+       // Alloc src buffer
+       IOCFormatSrc = kmalloc(sizeof(unsigned char)*Width*Height,GFP_KERNEL);
+       if(IOCFormatSrc == NULL) {
+               printk(PRINTK_PREFIX "FOP IOCtl: ERROR: "
+                       "IOC FormatWrite: "
+                       "kmalloc\n");
+               goto out;
+       }
+
+       // Copy src buffer from user
+       Result = copy_from_user(
+               IOCFormatSrc,
+               (void __user *)_Arg,
+               sizeof(unsigned char)*Width*Height);
+       if(Result != 0) {
+               printk(PRINTK_PREFIX "FOP IOCtl: ERROR: "
+                       "IOC FormatWrite: "
+                       "copy_from_user(IOCFormatSrc,...\n");
+               goto allocsrc;
+       }
+
+       cfag12864b_Format(IOCFormatSrc);
+
+       Return = 0;
+
+allocsrc:
+       kfree(IOCFormatSrc);
+out:
+       return Return;
+}
+
+int IOCtl(
+       struct inode * _Inode,
+       struct file * _File,
+       unsigned int _Cmd,
+       unsigned long _Arg)
+{
+       if(_IOC_TYPE(_Cmd) != CFAG12864B_IOC_MAGIC)
+               return -ENOTTY;
+       if(_IOC_NR(_Cmd) > CFAG12864B_IOC_MAXNR)
+               return -ENOTTY;
+
+       switch(_Cmd) {
+       case CFAG12864B_IOCON:
+               cfag12864b_On();
+               break;
+       case CFAG12864B_IOCOFF:
+               cfag12864b_Off();
+               break;
+       case CFAG12864B_IOCCLEAR:
+               cfag12864b_Clear();
+               break;
+       case CFAG12864B_IOCFORMAT:
+               return IOCtl_Format(_Arg);
+       default:
+               return -ENOTTY;
+       }
+
+       return 0;
+}
+
+
+
+struct file_operations Fops =
+{
+       .owner = THIS_MODULE,
+       .llseek = Seek,
+       .write = Write,
+       .ioctl = IOCtl,
+       .open = Open,
+};
+
+
+
+
+
+
+
+
+
+//
+// Module Init & Exit
+//
+
+int cfag12864b_init(void)
+{
+       unsigned int i;
+       int Result;
+
+       printk(PRINTK_PREFIX "Init... ");
+
+       Result = alloc_chrdev_region(&FirstDevice, FirstMinor, nDevices, Name);
+       if(Result < 0) {
+               printk("ERROR - alloc_chrdev_region\n");
+               return Result;
+       }
+       Major = MAJOR(FirstDevice);
+
+       Devices = kmalloc(nDevices * sizeof(struct cfag12864b), GFP_KERNEL);
+       if(Devices == NULL) {
+               printk("ERROR - kmalloc\n");
+               return -ENOMEM;
+       }
+       memset(Devices, 0, nDevices * sizeof(struct cfag12864b));
+
+       for(i=0; i<nDevices; ++i) {
+               Devices[i].Minor = FirstMinor+i;
+               Devices[i].Device = MKDEV(Major,Devices[i].Minor);
+
+               cdev_init(&(Devices[i].CharDevice), &Fops);
+               Devices[i].CharDevice.owner = THIS_MODULE;
+               Devices[i].CharDevice.ops = &Fops;
+               Result = cdev_add(&(Devices[i].CharDevice),
+                       Devices[i].Device, 1);
+               if(Result < 0) {
+                       printk("ERROR - cdev_add\n");
+                       kfree(Devices);
+                       return Result;
+               }
+
+               class_device_create(
+                       display_class,NULL,MKDEV(Major,Devices[i].Minor),
+                       NULL,"cfag12864b%d",Devices[i].Minor);
+       }
+
+
+       cfag12864b_Clear();
+       cfag12864b_On();
+
+       printk("Done\n");
+
+       return 0;
+}
+
+void cfag12864b_exit(void)
+{
+       unsigned int i;
+
+       printk(PRINTK_PREFIX "Exit... ");
+
+       cfag12864b_Off();
+
+       if(Devices != NULL) {
+               for(i=0; i<nDevices; ++i) {
+
class_device_destroy(display_class,MKDEV(Major,Devices[i].Minor));
+                       cdev_del(&(Devices[i].CharDevice));
+               }
+               kfree(Devices);
+       }
+
+       unregister_chrdev_region(FirstDevice, nDevices);
+
+       printk("Done\n");
+}
+
+module_init(cfag12864b_init);
+module_exit(cfag12864b_exit);
+
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
+MODULE_DESCRIPTION("cfag12864b");
+
diff -uprN -X linux-2.6.17.13-vanilla/Documentation/dontdiff
linux-2.6.17.13-vanilla/drivers/display/display.c
linux-2.6.17.13/drivers/display/display.c
--- linux-2.6.17.13-vanilla/drivers/display/display.c   1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.17.13/drivers/display/display.c   2006-09-11
23:53:22.000000000 +0200
@@ -0,0 +1,60 @@
+/*
+ *    Filename: display.c
+ *     Version: 0.1.0
+ * Description: Display Class
+ *     License: GPL
+ *     Depends: -
+ *
+ *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-09-10
+ */
+
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/display.h>
+
+#define NAME "display"
+#define PRINTK_PREFIX KERN_INFO NAME ": "
+
+static char * Name = NAME;
+
+//
+// Exported Display Data
+//
+
+struct class * display_class;
+EXPORT_SYMBOL_GPL(display_class);
+
+
+//
+// Module Init & Exit
+//
+
+int display_init(void)
+{
+       display_class = class_create(THIS_MODULE,Name);
+       if(IS_ERR(display_class)) {
+               printk(PRINTK_PREFIX "ERROR: class_simple_create\n");
+               return -EINVAL;
+       }
+
+       return 0;
+}
+
+void display_exit(void)
+{
+       class_destroy(display_class);
+}
+
+module_init(display_init);
+module_exit(display_exit);
+
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
+MODULE_DESCRIPTION("display");
+
diff -uprN -X linux-2.6.17.13-vanilla/Documentation/dontdiff
linux-2.6.17.13-vanilla/drivers/display/Kconfig
linux-2.6.17.13/drivers/display/Kconfig
--- linux-2.6.17.13-vanilla/drivers/display/Kconfig     1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.17.13/drivers/display/Kconfig     2006-09-12
00:04:14.000000000 +0200
@@ -0,0 +1,61 @@
+#
+# For a description of the syntax of this configuration file,
+# see Documentation/kbuild/kconfig-language.txt.
+#
+# Display drivers configuration.
+#
+
+menu "Display support"
+
+config DISPLAY
+       tristate "Display support"
+       default n
+       ---help---
+         If you have an extra display, like a small LCD screen, say Y.
+
+         To compile this as a module, choose M here:
+         module will be called display.
+
+         If unsure, say N.
+
+comment "Parallel port dependent:"
+
+config KS0108
+       tristate "KS0108 LCD Controller"
+       depends on DISPLAY && PARPORT
+       default n
+       ---help---
+         If you have a LCD display controlled by one or more KS0108
+         controllers, say Y. You will need also another more specific
+         driver for your LCD.
+
+         Depends on Parallel Port support. If you say Y at
+         parport, you will be able to compile this as a module (M)
+         and built-in as well (Y). If you said M at parport,
+         you will be able only to compile this as a module (M).
+
+         To compile this as a module, choose M here:
+         module will be called ks0108.
+
+         If unsure, say N.
+
+config CFAG12864B
+       tristate "CFAG12864B LCD Display"
+       depends on KS0108
+       default n
+       ---help---
+         If you have a Crystalfontz 128x64 2-color LCD display,
+         cfag12864b Series, say Y. You also need the ks0108 LCD
+         Controller driver.
+
+         For help about how to wire your LCD to the parallel port,
+         check this image: http://www.skippari.net/lcd/sekalaista
+                           /crystalfontz_cfag12864B-TMI-V.png
+
+         To compile this as a module, choose M here:
+         module will be called cfag12864b.
+
+         If unsure, say N.
+
+endmenu
+
diff -uprN -X linux-2.6.17.13-vanilla/Documentation/dontdiff
linux-2.6.17.13-vanilla/drivers/display/ks0108.c
linux-2.6.17.13/drivers/display/ks0108.c
--- linux-2.6.17.13-vanilla/drivers/display/ks0108.c    1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.17.13/drivers/display/ks0108.c    2006-09-11
23:49:15.000000000 +0200
@@ -0,0 +1,177 @@
+/*
+ *    Filename: ks0108.c
+ *     Version: 0.1.0
+ * Description: ks0108 LCD Display Controller Driver
+ *     License: GPL
+ *     Depends: parport
+ *
+ *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-09-10
+ */
+
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/delay.h>
+#include <linux/parport.h>
+#include <linux/ks0108.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+
+#define NAME "ks0108"
+#define PRINTK_PREFIX  KERN_INFO NAME ": "
+
+
+
+//
+// Module
+//
+
+static unsigned int Port = 0x378;
+module_param(Port,uint,S_IRUGO);
+
+
+
+//
+// Device
+//
+
+static const char * Name = NAME;
+
+static struct parport * Parport;
+static struct pardevice * Pardevice;
+
+
+
+//
+// ks0108 Exported Commands
+//
+
+#define Bit(n)   ((unsigned char)(1<<(n)))
+
+void ks0108_WriteData(unsigned char _Byte)
+{
+       parport_write_data(Parport,_Byte);
+}
+
+void ks0108_WriteControl(unsigned char _Byte)
+{
+       const unsigned int ECycleDelay = 1;
+       udelay(ECycleDelay);
+       parport_write_control(Parport,_Byte);
+}
+
+void ks0108_DisplayState(unsigned char _State)
+{
+       unsigned char Command = Bit(1) | Bit(2) | Bit(3) | Bit(4) | Bit(5);
+       if(_State)
+               Command |= Bit(0);
+       ks0108_WriteData(Command);
+}
+
+void ks0108_StartLine(unsigned char _StartLine)
+{
+       const unsigned char MaxStartLine = 63;
+       unsigned char Command = Bit(6) | Bit(7);
+       if(_StartLine>MaxStartLine)
+               _StartLine=MaxStartLine;
+       Command |= _StartLine;
+       ks0108_WriteData(Command);
+}
+
+void ks0108_Address(unsigned char _Address)
+{
+       const unsigned char MaxAddress = 63;
+       unsigned char Command = Bit(6);
+       if(_Address>MaxAddress)
+               _Address=MaxAddress;
+       Command |= _Address;
+       ks0108_WriteData(Command);
+}
+
+void ks0108_Page(unsigned char _Page)
+{
+       const unsigned char MaxPage = 7;
+       unsigned char Command = Bit(3) | Bit(4) | Bit(5) | Bit(7);
+       if(_Page>MaxPage)
+               _Page=MaxPage;
+       Command |= _Page;
+       ks0108_WriteData(Command);
+}
+
+
+EXPORT_SYMBOL_GPL(ks0108_WriteData);
+EXPORT_SYMBOL_GPL(ks0108_WriteControl);
+EXPORT_SYMBOL_GPL(ks0108_DisplayState);
+EXPORT_SYMBOL_GPL(ks0108_StartLine);
+EXPORT_SYMBOL_GPL(ks0108_Address);
+EXPORT_SYMBOL_GPL(ks0108_Page);
+
+
+
+
+//
+// Module Init & Exit
+//
+
+int ks0108_init(void)
+{
+       int Return = -EINVAL;
+
+       printk(PRINTK_PREFIX "Init... ");
+
+       Parport = parport_find_base(Port);
+       if(Parport == NULL) {
+               printk("ERROR - parport_find_base\n");
+               Return = -EFAULT;
+               goto none;
+       }
+
+       Pardevice = parport_register_device(
+               Parport,Name,
+               NULL,NULL,NULL,
+               PARPORT_DEV_EXCL,NULL);
+       if(Pardevice == NULL) {
+               printk("ERROR: parport_register_device\n");
+               Return = -EFAULT;
+               goto none;
+       }
+
+       if(parport_claim(Pardevice) != 0) {
+               printk("ERROR: parport_claim\n");
+               Return = -EFAULT;
+               goto registered;
+       }
+
+       printk("Done\n");
+       return 0;
+
+registered:
+       parport_unregister_device(Pardevice);
+
+none:
+       return Return;
+}
+
+void ks0108_exit(void)
+{
+       printk(PRINTK_PREFIX "Exit... ");
+
+       parport_release(Pardevice);
+
+       parport_unregister_device(Pardevice);
+
+       printk("Done\n");
+}
+
+module_init(ks0108_init);
+module_exit(ks0108_exit);
+
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Miguel Ojeda Sandonis <maxextreme@gmail.com>");
+MODULE_DESCRIPTION("ks0108");
+
diff -uprN -X linux-2.6.17.13-vanilla/Documentation/dontdiff
linux-2.6.17.13-vanilla/drivers/display/Makefile
linux-2.6.17.13/drivers/display/Makefile
--- linux-2.6.17.13-vanilla/drivers/display/Makefile    1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.17.13/drivers/display/Makefile    2006-09-11
18:00:05.000000000 +0200
@@ -0,0 +1,7 @@
+#
+# Makefile for the kernel Display device drivers.
+#
+
+obj-$(CONFIG_DISPLAY)          += display.o
+obj-$(CONFIG_KS0108)           += ks0108.o
+obj-$(CONFIG_CFAG12864B)       += cfag12864b.o
diff -uprN -X linux-2.6.17.13-vanilla/Documentation/dontdiff
linux-2.6.17.13-vanilla/drivers/Kconfig
linux-2.6.17.13/drivers/Kconfig
--- linux-2.6.17.13-vanilla/drivers/Kconfig     2006-09-09
05:23:25.000000000 +0200
+++ linux-2.6.17.13/drivers/Kconfig     2006-09-11 19:04:53.000000000 +0200
@@ -72,4 +72,8 @@ source "drivers/edac/Kconfig"

 source "drivers/rtc/Kconfig"

+# parport before display - some displays depend on it.
+
+source "drivers/display/Kconfig"
+
 endmenu
diff -uprN -X linux-2.6.17.13-vanilla/Documentation/dontdiff
linux-2.6.17.13-vanilla/drivers/Makefile
linux-2.6.17.13/drivers/Makefile
--- linux-2.6.17.13-vanilla/drivers/Makefile    2006-09-09
05:23:25.000000000 +0200
+++ linux-2.6.17.13/drivers/Makefile    2006-09-11 19:15:50.000000000 +0200
@@ -74,3 +74,4 @@ obj-$(CONFIG_SGI_SN)          += sn/
 obj-y                          += firmware/
 obj-$(CONFIG_CRYPTO)           += crypto/
 obj-$(CONFIG_SUPERH)           += sh/
+obj-$(CONFIG_DISPLAY)          += display/
diff -uprN -X linux-2.6.17.13-vanilla/Documentation/dontdiff
linux-2.6.17.13-vanilla/include/linux/cfag12864b.h
linux-2.6.17.13/include/linux/cfag12864b.h
--- linux-2.6.17.13-vanilla/include/linux/cfag12864b.h  1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.17.13/include/linux/cfag12864b.h  2006-09-11
17:32:19.000000000 +0200
@@ -0,0 +1,45 @@
+/*
+ *    Filename: cfag12864b.h
+ *     Version: 0.1.0
+ * Description: cfag12864b LCD Display Driver Header
+ *     License: GPL
+ *
+ *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-09-10
+ */
+
+#ifndef _CFAG12864B_H_
+#define _CFAG12864B_H_
+
+#include <linux/ioctl.h>
+
+#define CFAG12864B_WIDTH       128
+#define CFAG12864B_HEIGHT      64
+#define CFAG12864B_MATRIXSIZE  CFAG12864B_WIDTH*CFAG12864B_HEIGHT
+
+#define CFAG12864B_CONTROLLERS 2
+#define CFAG12864B_PAGES       8
+#define CFAG12864B_ADDRESSES   64
+#define CFAG12864B_SIZE                CFAG12864B_CONTROLLERS * \
+                               CFAG12864B_PAGES * \
+                               CFAG12864B_ADDRESSES
+
+#define CFAG12864B_IOC_MAGIC   0xFF
+#define CFAG12864B_IOC_MAXNR   0x03
+
+#define CFAG12864B_IOCOFF      _IO(CFAG12864B_IOC_MAGIC,0)
+#define CFAG12864B_IOCON       _IO(CFAG12864B_IOC_MAGIC,1)
+#define CFAG12864B_IOCCLEAR    _IO(CFAG12864B_IOC_MAGIC,2)
+#define CFAG12864B_IOCFORMAT   _IOW(CFAG12864B_IOC_MAGIC,3,void *)
+
+extern void cfag12864b_On(void);
+extern void cfag12864b_Off(void);
+extern void cfag12864b_Clear(void);
+extern void cfag12864b_Write(
+       unsigned short Offset,
+       unsigned char * Buffer,
+       unsigned short Count);
+extern void cfag12864b_Format(unsigned char * Src);
+
+#endif // _CFAG12864B_H_
+
diff -uprN -X linux-2.6.17.13-vanilla/Documentation/dontdiff
linux-2.6.17.13-vanilla/include/linux/display.h
linux-2.6.17.13/include/linux/display.h
--- linux-2.6.17.13-vanilla/include/linux/display.h     1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.17.13/include/linux/display.h     2006-09-11
19:25:44.000000000 +0200
@@ -0,0 +1,19 @@
+/*
+ *    Filename: display.h
+ *     Version: 0.1.0
+ * Description: Display Class Header
+ *     License: GPL
+ *
+ *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-09-10
+ */
+
+#ifndef _DISPLAY_H_
+#define _DISPLAY_H_
+
+#include <linux/device.h>
+
+extern struct class * display_class;
+
+#endif // _DISPLAY_H_
+
diff -uprN -X linux-2.6.17.13-vanilla/Documentation/dontdiff
linux-2.6.17.13-vanilla/include/linux/ks0108.h
linux-2.6.17.13/include/linux/ks0108.h
--- linux-2.6.17.13-vanilla/include/linux/ks0108.h      1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.17.13/include/linux/ks0108.h      2006-09-11
23:27:26.000000000 +0200
@@ -0,0 +1,22 @@
+/*
+ *    Filename: ks0108.h
+ *     Version: 0.1.0
+ * Description: ks0108 LCD Display Controller Driver Header
+ *     License: GPL
+ *
+ *      Author: Miguel Ojeda Sandonis <maxextreme@gmail.com>
+ *        Date: 2006-09-10
+ */
+
+#ifndef _KS0108_H_
+#define _KS0108_H_
+
+extern void ks0108_WriteData(unsigned char Byte);
+extern void ks0108_WriteControl(unsigned char Byte);
+extern void ks0108_DisplayState(unsigned char State);
+extern void ks0108_StartLine(unsigned char StartLine);
+extern void ks0108_Address(unsigned char Address);
+extern void ks0108_Page(unsigned char Page);
+
+#endif // _KS0108_H_
+
diff -uprN -X linux-2.6.17.13-vanilla/Documentation/dontdiff
linux-2.6.17.13-vanilla/MAINTAINERS linux-2.6.17.13/MAINTAINERS
--- linux-2.6.17.13-vanilla/MAINTAINERS 2006-09-09 05:23:25.000000000 +0200
+++ linux-2.6.17.13/MAINTAINERS 2006-09-12 00:17:51.000000000 +0200
@@ -1640,6 +1640,11 @@ M:       James.Bottomley@HansenPartnership.com
 L:     linux-scsi@vger.kernel.org
 S:     Maintained

+DISPLAY DRIVERS
+P:     Miguel Ojeda Sandonis
+M:     maxextreme@gmail.com
+S:     Maintained
+
 LED SUBSYSTEM
 P:     Richard Purdie
 M:     rpurdie@rpsys.net
