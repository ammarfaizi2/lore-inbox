Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWBTIhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWBTIhZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 03:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWBTIhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 03:37:25 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:51520 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932385AbWBTIhY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 03:37:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uhWRZnew5F/avLAD5dmdcjlnLRuBOLDtbNKuXaMEqR6SPiL+qg7hi4XtYFKkplCXf3smK3AZQoAHCkJqO8Wjb9psRnhJ2Rcdl89KV61zsaq0+D7nueI8KH00gtUnXi1GJ7AcfeGI9Bb9W33Szo86y4a3/laDhSmeWjDRyAQN4nw=
Message-ID: <756b48450602200037l2e26c10k9853d6db5761ed4@mail.gmail.com>
Date: Mon, 20 Feb 2006 16:37:23 +0800
From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
To: "Yu, Luming" <luming.yu@intel.com>
Subject: Re: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840AFD43B9@pdsmsx403>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3ACA40606221794F80A5670F0AF15F840AFD43B9@pdsmsx403>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/06, Yu, Luming <luming.yu@intel.com> wrote:
> I found _BCM, _BCL ... which are reserved methods for
> ACPI video extension device. If the vendor follows
> ACPI video extension spec, this proposed driver is
> NOT needed. Because, we do have acpi video driver
> in kernel today.  Could you please show me acpidump
> output?
>
> Thanks,
> Luming

Hi Luming,

Thanks for your reply.

Note that aside from the ACPILCD00 HID, there's also the ASIM0000 HID
that I'm supporting in this driver. I've appended the DSDT info you
requested. Let me know what you feel needs to be done to either make
the current acpi video driver detect this extension device (Should I
just try adding the ACPILCD00 HID to the video driver?).

Thanks,
jayakumar

--- DSDT info ---
                Device (LCD)
                {
                    Name (_HID, "ACPILCD00")
                    Method (_ADR, 0, NotSerialized)
                    {
                        Return (0x0110)
                    }

                    Method (_INI, 0, NotSerialized)
                    {
                        And (GLIE, 0xFFFFDFBF, Local0)
                        Or (Local0, 0x20400000, GLIE)
                        And (GLII, 0xFFFFDFBF, Local0)
                        Or (Local0, 0x20400000, GLII)
                        And (GLEE, 0xFFFFDFBF, Local0)
                        Or (Local0, 0x20400000, GLEE)
                        And (GLOE, 0xDFBFFFFF, Local0)
                        Or (Local0, 0x2040, GLOE)
                        And (GLPU, 0xFFFFDFBF, Local0)
                        Or (Local0, 0x20400000, GLPU)
                        And (GLOV, 0xFFBFDFFF, Local0)
                        Or (Local0, 0x20000040, GLOV)
                        Sleep (0x0BB8)
                        And (GLOV, 0xDFBFFFFF, Local0)
                        Or (Local0, 0x2040, GLOV)
                        Store (VSA8 (0x16, 0x30), BRSV)
                        If (LNot (LLess (BRSV, 0x20)))
                        {
                            Store (0x1F, BRSV)
                        }

                        Store (One, Local0)
                        While (LNot (LGreater (Local0, BRSV)))
                        {
                            SBRL (One, One)
                            Increment (Local0)
                        }
                    }
                    Method (_BCL, 0, NotSerialized)
                    {
                        Return (Package (0x02)
                        {
                            0x1F,
                            0x1F
                        })
                    }

                    Method (_BCM, 1, NotSerialized)
                    {
                        Store (Arg0, Local0)
                        Store (RBRL (), Local1)
                        And (Local1, 0xFF, Local1)
                        If (LAnd (LNot (LLess (Local0, Zero)), LNot
(LGreater (Local0, Local1))))
                        {
                            Store (BRSV, Local1)
                            And (Local1, 0xFF, Local1)
                            While (LNot (LEqual (Arg0, BRSV)))
                            {
                                If (LGreater (Arg0, BRSV))
                                {
                                    SBRL (One, One)
                                    Increment (BRSV)
                                }
                                Else
                                {
                                    If (LEqual (Arg0, BRSV))
                                    {
                                        Break
                                    }
                                    Else
                                    {
                                        SBRL (Zero, One)
                                        Decrement (BRSV)
                                    }
                                }
                            }
                        }
                    }
                }
            }


>
> >Hi Len, ACPI, and kernel folk,
> >
> >Appended is my patch adding an ACPI driver for Atlas boards. I've
> >done this patch against 2.6.15.3.
> >
> >Please let me know if it looks okay so far and if you have any
> >feedback
> >or suggestions.
> >
> >Thanks,
> >Jaya Kumar
> >
> >Signed-off-by: Jaya Kumar <jayakumar.acpi@gmail.com>
> >
> >---
> >
> > MAINTAINERS               |    5
> > drivers/acpi/Kconfig      |   11 +
> > drivers/acpi/Makefile     |    1
> > drivers/acpi/atlas_acpi.c |  279
> >++++++++++++++++++++++++++++++++++++++++++++++
> > 4 files changed, 296 insertions(+)
> >
> >---
> >
> >diff -X linux-2.6.15.3/Documentation/dontdiff -uprN
> >linux-2.6.15.3-vanilla/drivers/acpi/atlas_acpi.c
> >linux-2.6.15.3/drivers/acpi/atlas_acpi.c
> >--- linux-2.6.15.3-vanilla/drivers/acpi/atlas_acpi.c
> >1970-01-01 07:30:00.000000000 +0730
> >+++ linux-2.6.15.3/drivers/acpi/atlas_acpi.c   2006-02-20
> >10:00:19.000000000 +0800
> >@@ -0,0 +1,279 @@
> >+/*
> >+ *  atlas_acpi.c - Atlas Wallmount Touchscreen ACPI Extras
> >+ *
> >+ *  Copyright (C) 2006 Jaya Kumar
> >+ *  Based on Toshiba ACPI by John Belmonte and ASUS ACPI
> >+ *  This work was sponsored by CIS(M) Sdn Bhd.
> >+ *
> >+ *  This program is free software; you can redistribute it
> >and/or modify
> >+ *  it under the terms of the GNU General Public License as
> >published by
> >+ *  the Free Software Foundation; either version 2 of the License, or
> >+ *  (at your option) any later version.
> >+ *
> >+ *  This program is distributed in the hope that it will be useful,
> >+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> >+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >+ *  GNU General Public License for more details.
> >+ *
> >+ *  You should have received a copy of the GNU General Public License
> >+ *  along with this program; if not, write to the Free Software
> >+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
> >02111-1307  USA
> >+ *
> >+ */
> >+
> >+#include <linux/kernel.h>
> >+#include <linux/module.h>
> >+#include <linux/init.h>
> >+#include <linux/types.h>
> >+#include <linux/proc_fs.h>
> >+#include <asm/uaccess.h>
> >+#include <acpi/acpi_drivers.h>
> >+
> >+#define PROC_ATLAS                            "atlas"
> >+#define ACPI_ATLAS_NAME                       "Atlas ACPI"
> >+#define ACPI_ATLAS_CLASS                      "Atlas"
> >+#define ACPI_ATLAS_BUTTON_HID                 "ASIM0000"
> >+#define ACPI_ATLAS_BRIGHTNESS_HID             "ACPILCD00"
> >+
> >+struct atlas_device {
> >+      struct acpi_device *dev;
> >+      u8 brightness;
> >+      u8 max_brightness;
> >+};
> >+
> >+static struct proc_dir_entry *atlas_proc_dir;
> >+static struct atlas_device *atlas_dev;
> >+
> >+/* based on acpi_memory_powerdown_device */
> >+static int atlas_set_brightness(struct acpi_device *device, u16 value)
> >+{
> >+      acpi_status status;
> >+      struct acpi_object_list arg_list;
> >+      union acpi_object arg;
> >+
> >+      arg_list.count = 1;
> >+      arg_list.pointer = &arg;
> >+      arg.type = ACPI_TYPE_INTEGER;
> >+      arg.integer.value = value;
> >+      status = acpi_evaluate_object(device->handle, "_BCM",
> >&arg_list, NULL);
> >+      if (ACPI_FAILURE(status)) {
> >+              printk(KERN_ERR "%s:  ACPI set failed\n", __FUNCTION__);
> >+              return -ENODEV;
> >+      }
> >+
> >+      return status ;
> >+}
> >+
> >+/* based on ibm_get_table_from_acpi */
> >+static int acpi_read_max_brightness(struct acpi_device *device)
> >+{
> >+      union acpi_object *package;
> >+      struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> >+      acpi_status status;
> >+      union acpi_object *obj = NULL;
> >+
> >+      status = acpi_evaluate_object(device->handle, "_BCL",
> >NULL, &buffer);
> >+      if (ACPI_FAILURE(status)) {
> >+              printk(KERN_ERR "%s:  ACPI evaluation
> >failed\n", __FUNCTION__);
> >+              return -ENODEV;
> >+      }
> >+
> >+      package = (union acpi_object *) buffer.pointer;
> >+      obj = &(package->package.elements[0]);
> >+      return obj->integer.value;
> >+}
> >+
> >+/* based on drivers/usb/media/vicam.c:vicam_write_proc_gain */
> >+static int atlas_write_proc_lcd(struct file *file, const char *buffer,
> >+                              unsigned long count, void *data)
> >+{
> >+      u16 gtmp;
> >+      char kbuf[8];
> >+      struct atlas_device *dev = (struct atlas_device *) data;
> >+
> >+      if (count > 4)
> >+              return -EINVAL;
> >+
> >+      if (copy_from_user(kbuf, buffer, count))
> >+              return -EFAULT;
> >+
> >+      gtmp = (u16) simple_strtoul(kbuf, NULL, 10);
> >+      if (gtmp > dev->max_brightness)
> >+              return -EINVAL;
> >+
> >+      atlas_set_brightness(dev->dev, gtmp);
> >+      dev->brightness = gtmp;
> >+
> >+      return count;
> >+}
> >+
> >+/* based on drivers/mca/mca-proc.c:get_mca_machine_info */
> >+static int atlas_read_proc_lcd(char* page, char **start, off_t off,
> >+                                      int count, int *eof, void *data)
> >+{
> >+      struct atlas_device *dev = (struct atlas_device *) data;
> >+      int len;
> >+
> >+      len = sprintf(page,     "brightness:              %d\n"
> >+                              "brightness_levels:     0,%d\n",
> >+                              dev->brightness,dev->max_brightness);
> >+
> >+      if (len <= off + count)
> >+              *eof = 1;
> >+      *start = page + off;
> >+      len -= off;
> >+      if (len > count)
> >+              len = count;
> >+      if (len < 0)
> >+              len = 0;
> >+      return len;
> >+}
> >+
> >+/* button handling code */
> >+static acpi_status acpi_atlas_button_setup(acpi_handle region_handle,
> >+                  u32 function, void *handler_context, void
> >**return_context)
> >+{
> >+      *return_context =
> >+              (function != ACPI_REGION_DEACTIVATE) ?
> >handler_context : NULL;
> >+
> >+      return AE_OK;
> >+}
> >+
> >+static acpi_status acpi_atlas_button_handler(u32 function,
> >+                    acpi_physical_address address,
> >+                    u32 bit_width, acpi_integer * value,
> >+                    void *handler_context, void *region_context)
> >+{
> >+      acpi_status status;
> >+      struct acpi_device *dev;
> >+
> >+      dev = (struct acpi_device *) handler_context;
> >+      if (function == ACPI_WRITE)
> >+              status = acpi_bus_generate_event(dev, 0x80, address);
> >+      else {
> >+              printk(KERN_WARNING "atlas: shrugged on
> >unexpected function"
> >+                      ":function=%x,address=%x,value=%x\n",
> >+                      function, (u32)address, (u32)*value);
> >+              status = -EINVAL;
> >+      }
> >+
> >+      return status ;
> >+}
> >+
> >+static int atlas_acpi_button_add(struct acpi_device *device)
> >+{
> >+
> >+      /* hookup button handler */
> >+      return acpi_install_address_space_handler(device->handle,
> >+                              0x81, &acpi_atlas_button_handler,
> >+                              &acpi_atlas_button_setup, device);
> >+}
> >+
> >+static int atlas_acpi_lcd_add(struct acpi_device *device)
> >+{
> >+      acpi_status status;
> >+      struct proc_dir_entry *proc;
> >+
> >+      atlas_dev = (struct atlas_device *)
> >+                      kmalloc(sizeof(struct atlas_device),
> >GFP_KERNEL);
> >+      if (!atlas_dev)
> >+              return -ENOMEM;
> >+
> >+      /* get max brightness for /proc read use */
> >+      atlas_dev->max_brightness = acpi_read_max_brightness(device);
> >+      atlas_dev->dev = device;
> >+      acpi_driver_data(device) = atlas_dev;
> >+
> >+      /* setup proc entry to set and get lcd brightness */
> >+      proc = create_proc_read_entry("lcd", S_IFREG | S_IRUGO
> >| S_IWUSR,
> >+                      atlas_proc_dir, atlas_read_proc_lcd, atlas_dev);
> >+      if (!proc) {
> >+              printk(KERN_ERR "atlas: couldn't alloc proc entry\n");
> >+              kfree(atlas_dev);
> >+              status = -ENOMEM;
> >+      } else {
> >+              proc->owner = THIS_MODULE;
> >+              proc->write_proc = atlas_write_proc_lcd;
> >+              status = AE_OK;
> >+      }
> >+      return status ;
> >+}
> >+
> >+static int atlas_acpi_add(struct acpi_device *device)
> >+{
> >+
> >+      if (!strcmp(acpi_device_hid(device), ACPI_ATLAS_BUTTON_HID))
> >+              return atlas_acpi_button_add(device);
> >+      else
> >+              return atlas_acpi_lcd_add(device);
> >+}
> >+
> >+static int atlas_acpi_remove(struct acpi_device *device, int type)
> >+{
> >+      acpi_status status;
> >+
> >+      if (!device || !acpi_driver_data(device))
> >+              return -EINVAL;
> >+
> >+      if (!strcmp(acpi_device_hid(device), ACPI_ATLAS_BUTTON_HID)) {
> >+              status =
> >acpi_remove_address_space_handler(device->handle,
> >+                              0x81, &acpi_atlas_button_handler);
> >+              if (ACPI_FAILURE(status))
> >+                      printk(KERN_ERR
> >+                              "Atlas: Error removing addr spc
> >handler\n");
> >+      } else {
> >+              if (atlas_proc_dir)
> >+                      remove_proc_entry("lcd", atlas_proc_dir);
> >+
> >+              kfree(atlas_dev);
> >+              status = AE_OK;
> >+      }
> >+
> >+      return status;
> >+}
> >+
> >+static struct acpi_driver atlas_acpi_driver = {
> >+      .name   = ACPI_ATLAS_NAME,
> >+      .class  = ACPI_ATLAS_CLASS,
> >+      .ids    = ACPI_ATLAS_BUTTON_HID "," ACPI_ATLAS_BRIGHTNESS_HID,
> >+      .ops = {
> >+              .add = atlas_acpi_add,
> >+              .remove = atlas_acpi_remove,
> >+              },
> >+};
> >+
> >+static int __init atlas_acpi_init(void)
> >+{
> >+      int result;
> >+
> >+      atlas_proc_dir = proc_mkdir(PROC_ATLAS, acpi_root_dir);
> >+      if (!atlas_proc_dir) {
> >+              printk(KERN_ERR "Atlas ACPI: Unable to create
> >/proc dir\n");
> >+              return -ENODEV;
> >+      }
> >+      atlas_proc_dir->owner = THIS_MODULE;
> >+
> >+      result = acpi_bus_register_driver(&atlas_acpi_driver);
> >+      if (result < 0) {
> >+              printk(KERN_ERR "Atlas ACPI: Unable to register
> >driver\n");
> >+              remove_proc_entry(PROC_ATLAS, acpi_root_dir);
> >+              return -ENODEV;
> >+      }
> >+
> >+      return 0;
> >+}
> >+
> >+static void __exit atlas_acpi_exit(void)
> >+{
> >+      acpi_bus_unregister_driver(&atlas_acpi_driver);
> >+      if (atlas_proc_dir)
> >+              remove_proc_entry(PROC_ATLAS, acpi_root_dir);
> >+}
> >+
> >+module_init(atlas_acpi_init);
> >+module_exit(atlas_acpi_exit);
> >+
> >+MODULE_AUTHOR("Jaya Kumar");
> >+MODULE_LICENSE("GPL");
> >+MODULE_DESCRIPTION("Atlas ACPI");
> >+MODULE_SUPPORTED_DEVICE("Atlas ACPI");
> >diff -X linux-2.6.15.3/Documentation/dontdiff -uprN
> >linux-2.6.15.3-vanilla/drivers/acpi/Kconfig
> >linux-2.6.15.3/drivers/acpi/Kconfig
> >--- linux-2.6.15.3-vanilla/drivers/acpi/Kconfig
> >2006-02-19 13:31:11.000000000 +0800
> >+++ linux-2.6.15.3/drivers/acpi/Kconfig        2006-02-19
> >19:29:04.000000000 +0800
> >@@ -194,6 +194,17 @@ config ACPI_ASUS
> >           something works not quite as expected, please use
> >the mailing list
> >           available on the above page
> >(acpi4asus-user@lists.sourceforge.net)
> >
> >+config ACPI_ATLAS
> >+        tristate "Atlas Wallmount Touchscreen Extras"
> >+      depends on X86
> >+      default n
> >+      ---help---
> >+        This driver is intended for Atlas wallmount touchscreens.
> >+        The button events will show up in /proc/acpi/events
> >and the lcd
> >+        brightness control is at /proc/acpi/atlas/lcd
> >+
> >+        If you have an Atlas wallmount touchscreen, say Y or M here.
> >+
> > config ACPI_IBM
> >       tristate "IBM ThinkPad Laptop Extras"
> >       depends on X86
> >diff -X linux-2.6.15.3/Documentation/dontdiff -uprN
> >linux-2.6.15.3-vanilla/drivers/acpi/Makefile
> >linux-2.6.15.3/drivers/acpi/Makefile
> >--- linux-2.6.15.3-vanilla/drivers/acpi/Makefile
> >2006-02-19 13:31:11.000000000 +0800
> >+++ linux-2.6.15.3/drivers/acpi/Makefile       2006-02-19
> >14:23:59.000000000 +0800
> >@@ -53,6 +53,7 @@ obj-$(CONFIG_ACPI_SYSTEM)    += system.o ev
> > obj-$(CONFIG_ACPI_DEBUG)      += debug.o
> > obj-$(CONFIG_ACPI_NUMA)               += numa.o
> > obj-$(CONFIG_ACPI_ASUS)               += asus_acpi.o
> >+obj-$(CONFIG_ACPI_ATLAS)      += atlas_acpi.o
> > obj-$(CONFIG_ACPI_IBM)                += ibm_acpi.o
> > obj-$(CONFIG_ACPI_TOSHIBA)    += toshiba_acpi.o
> > obj-y                         += scan.o motherboard.o
> >diff -X linux-2.6.15.3/Documentation/dontdiff -uprN
> >linux-2.6.15.3-vanilla/MAINTAINERS linux-2.6.15.3/MAINTAINERS
> >--- linux-2.6.15.3-vanilla/MAINTAINERS 2006-02-19
> >13:30:48.000000000 +0800
> >+++ linux-2.6.15.3/MAINTAINERS 2006-02-20 09:44:12.000000000 +0800
> >@@ -366,6 +366,11 @@ M:        ecashin@coraid.com
> > W:    http://www.coraid.com/support/linux
> > S:    Supported
> >
> >+ATLAS ACPI EXTRAS DRIVER
> >+P:    Jaya Kumar
> >+M:    jayakumar.acpi@gmail.com
> >+S:    Maintained
> >+
> > ATM
> > P:    Chas Williams
> > M:    chas@cmf.nrl.navy.mil
> >-
> >To unsubscribe from this list: send the line "unsubscribe
> >linux-acpi" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
