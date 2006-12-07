Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032269AbWLGPFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032269AbWLGPFl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032292AbWLGPFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:05:41 -0500
Received: from c2bthomr10.btconnect.com ([194.73.73.226]:6194 "EHLO
	c2bthomr10.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032269AbWLGPFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:05:39 -0500
Message-Id: <200612071504.kB7F4C5D026327@imap.elan.private>
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       USB Development List <linux-usb-devel@lists.sourceforge.net>,
       Kernel Development List <linux-kernel@vger.kernel.org>
From: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Bart Prescott <bart.prescott@elandigitalsystems.com>
Subject: [PATCH] USB: u132-hcd/ftdi-elan: add support for Option GT 3G Quad card
Date: Wed, 06 Dec 2006 13:16:22 +0000
X-Mailer: By Hand using VIM
Elan-checked-message-originator: tony.olech@elandigitalsystems.com == tony-olech
Elan-message-recipient: siraj.waghu@gmail.com
Elan-message-recipient: greg@kroah.com
Elan-message-recipient: linux-usb-devel@lists.sourceforge.net
Elan-message-recipient: akpm@osdl.org
Elan-message-recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Olech <tony.olech@elandigitalsystems.com>

ELAN's U132 is a USB to CardBus OHCI controller adapter,
    designed specifically for CardBus 3G data cards to
    function in machines without a CardBus slot.
The "ftdi-elan" module is a USB client driver, that detects
    a supported CardBus OHCI controller plugged into the
    U132 adapter and thereafter provides the conduit for
    for access by the "u132-hcd" module.
The "u132-hcd" module is a (cut-down OHCI) host controller
    that supports a single OHCI function of the CardBus 
    card inserted into the U132 adapter.

The problem with the initial implementation is that when
the CardBus card inserted into the U132 adapter has multiple
functions (and a CardBus card can support up to 4 functions),
it was the first function that was arbitrarily choosen.

The first batch of 3G cards tested, like the Merlin Qualcomm
V620, have two functions each supporting a seperate USB OHCI
host controller, of which it was that first function that is
wired up to the 3G modem.

Then along comes the Vodafone Mobile Connect 3G/GPRS data card,
aka "Option GT 3G Quad" as printed on it's rear or "Option N.V.
GlobeTrotter Fusion Quad Lite" as read with "lspci -v". And it
has the meaningful functionality in the second CardBus function.

That presents a problem because it was the "ftdi-elan" module
alone that knows how to communicate to the embedded CardBus slot
and the "u132-hcd" module alone that knows how to access the
pcmcia configuration and CardBus accessible memory space. And
of course, the information about attached (internally hardwired)
devices is contained within USB configuration embedded somewhere
within the CardBus card.

If only the "u132-hcd" module probe() interface could return a
result code that propagated back to the instigating function
platform_device_register() then the "ftdi-elan" module could
try an alternative CardBus function.     However in spite of
the recent changes to the drivers/base/ routines that moved 
device_attach() from bus_add_device() to bus_attach_device()
both of those routines lose the "failed to attach" 0 result
code and thus the calling routine, namely device_add() is
incapable of propaging the "failed to attach" condition back
to platform_device_add() and consequently back to the caller
of platform_device_register()

Experiments show that patching bus_attach_device() to return
ENODEV fails with the kernel locking up very early during
boot. But, however, if the patch is restricted to calls from
platform_device_add() then it does seem to work.

Unfortunately, until the kernel's drivers/base is properly
modified to propagate -ENODEV back to the caller of
platform_device_register(), it is necessary to "fix" the
"ftdi-elan" module by importing knowledge from the 
"u132-hcd" module. This is the reason for the duplicated
functionality introduced in this patch.

Signed-off-by: Tony Olech <tony.olech@elandigitalsystems.com>

--- linux-2.6.19/drivers/usb/host/u132-hcd.c.original	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19/drivers/usb/host/u132-hcd.c	2006-12-06 09:06:11.000000000 +0000
@@ -40,6 +40,7 @@
 #include <linux/moduleparam.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
+#include <linux/pci_ids.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
@@ -214,15 +215,16 @@ int usb_ftdi_elan_write_pcimem(struct pl
 * these can not be inlines because we need the structure offset!!
 * Does anyone have a better way?????
 */
+#define ftdi_read_pcimem(pdev, member, data) usb_ftdi_elan_read_pcimem(pdev, \
+        offsetof(struct ohci_regs, member), 0, data);
+#define ftdi_write_pcimem(pdev, member, data) usb_ftdi_elan_write_pcimem(pdev, \
+        offsetof(struct ohci_regs, member), 0, data);
 #define u132_read_pcimem(u132, member, data) \
         usb_ftdi_elan_read_pcimem(u132->platform_dev, offsetof(struct \
         ohci_regs, member), 0, data);
 #define u132_write_pcimem(u132, member, data) \
         usb_ftdi_elan_write_pcimem(u132->platform_dev, offsetof(struct \
         ohci_regs, member), 0, data);
-#define u132_write_pcimem_byte(u132, member, data) \
-        usb_ftdi_elan_write_pcimem(u132->platform_dev, offsetof(struct \
-        ohci_regs, member), 0x0e, data);
 static inline struct u132 *udev_to_u132(struct u132_udev *udev)
 {
         u8 udev_number = udev->udev_number;
@@ -1592,59 +1594,12 @@ static char *hcfs2string(int state)
         return "?";
 }
 
-static int u132_usb_reset(struct u132 *u132)
-{
-        int retval;
-        retval = u132_read_pcimem(u132, control, &u132->hc_control);
-        if (retval)
-                return retval;
-        u132->hc_control &= OHCI_CTRL_RWC;
-        retval = u132_write_pcimem(u132, control, u132->hc_control);
-        if (retval)
-                return retval;
-        return 0;
-}
-
 static int u132_init(struct u132 *u132)
 {
         int retval;
         u32 control;
         u132_disable(u132);
-        u132->next_statechange =
-                jiffies; /* SMM owns the HC? not for long! */  {
-                u32 control;
-                retval = u132_read_pcimem(u132, control, &control);
-                if (retval)
-                        return retval;
-                if (control & OHCI_CTRL_IR) {
-                        u32 temp = 50;
-                        retval = u132_write_pcimem(u132, intrenable,
-                                OHCI_INTR_OC);
-                        if (retval)
-                                return retval;
-                        retval = u132_write_pcimem_byte(u132, cmdstatus,
-                                OHCI_OCR);
-                        if (retval)
-                                return retval;
-                      check:{
-                                retval = u132_read_pcimem(u132, control,
-                                        &control);
-                                if (retval)
-                                        return retval;
-                        }
-                        if (control & OHCI_CTRL_IR) {
-                                msleep(10);
-                                if (--temp == 0) {
-                                        dev_err(&u132->platform_dev->dev, "USB "
-                                                "HC takeover failed!(BIOS/SMM b"
-                                                "ug) control=%08X\n", control);
-                                        return -EBUSY;
-                                }
-                                goto check;
-                        }
-                        u132_usb_reset(u132);
-                }
-        }
+        u132->next_statechange = jiffies;
         retval = u132_write_pcimem(u132, intrdisable, OHCI_INTR_MIE);
         if (retval)
                 return retval;
@@ -1743,7 +1698,7 @@ static int u132_run(struct u132 *u132)
       retry:retval = u132_read_pcimem(u132, cmdstatus, &status);
         if (retval)
                 return retval;
-        retval = u132_write_pcimem_byte(u132, cmdstatus, OHCI_HCR);
+        retval = u132_write_pcimem(u132, cmdstatus, OHCI_HCR);
         if (retval)
                 return retval;
       extra:{
@@ -1800,7 +1755,7 @@ static int u132_run(struct u132 *u132)
         retval = u132_write_pcimem(u132, control, u132->hc_control);
         if (retval)
                 return retval;
-        retval = u132_write_pcimem_byte(u132, cmdstatus, OHCI_BLF);
+        retval = u132_write_pcimem(u132, cmdstatus, OHCI_BLF);
         if (retval)
                 return retval;
         retval = u132_read_pcimem(u132, cmdstatus, &cmdstatus);
@@ -1857,8 +1812,8 @@ static void u132_hcd_stop(struct usb_hcd
 {
         struct u132 *u132 = hcd_to_u132(hcd);
         if (u132->going > 1) {
-                dev_err(&u132->platform_dev->dev, "device has been removed %d\n"
-                        , u132->going);
+                dev_err(&u132->platform_dev->dev, "u132 device %p(hcd=%p) has b"
+                        "een removed %d\n", u132, hcd, u132->going);
         } else if (u132->going > 0) {
                 dev_err(&u132->platform_dev->dev, "device hcd=%p is being remov"
                         "ed\n", hcd);
@@ -2563,8 +2518,9 @@ static void u132_endpoint_disable(struct
 {
         struct u132 *u132 = hcd_to_u132(hcd);
         if (u132->going > 2) {
-                dev_err(&u132->platform_dev->dev, "device has been removed %d\n"
-                        , u132->going);
+                dev_err(&u132->platform_dev->dev, "u132 device %p(hcd=%p hep=%p"
+                        ") has been removed %d\n", u132, hcd, hep,
+                        u132->going);
         } else {
                 struct u132_endp *endp = hep->hcpriv;
                 if (endp)
@@ -2808,7 +2764,6 @@ static int u132_hub_status_data(struct u
         } else if (u132->going > 0) {
                 dev_err(&u132->platform_dev->dev, "device hcd=%p is being remov"
                         "ed\n", hcd);
-                dump_stack();
                 return -ESHUTDOWN;
         } else {
                 int i, changed = 0, length = 1;
@@ -3052,12 +3007,15 @@ static int __devexit u132_remove(struct 
         struct usb_hcd *hcd = platform_get_drvdata(pdev);
         if (hcd) {
                 struct u132 *u132 = hcd_to_u132(hcd);
-                dump_stack();
                 if (u132->going++ > 1) {
+                        dev_err(&u132->platform_dev->dev, "already being remove"
+				"d\n");
                         return -ENODEV;
                 } else {
                         int rings = MAX_U132_RINGS;
                         int endps = MAX_U132_ENDPS;
+                        dev_err(&u132->platform_dev->dev, "removing device u132"
+				".%d\n", u132->sequence_num);
                         msleep(100);
                         down(&u132->sw_lock);
                         u132_monitor_cancel_work(u132);
@@ -3139,10 +3097,24 @@ static void u132_initialise(struct u132 
 static int __devinit u132_probe(struct platform_device *pdev)
 {
         struct usb_hcd *hcd;
+        int retval;
+        u32 control;
+        u32 rh_a = -1;
+        u32 num_ports;
         msleep(100);
         if (u132_exiting > 0) {
                 return -ENODEV;
-        }                        /* refuse to confuse usbcore */
+        }
+        retval = ftdi_write_pcimem(pdev, intrdisable, OHCI_INTR_MIE);
+        if (retval)
+                return retval;
+        retval = ftdi_read_pcimem(pdev, control, &control);
+        if (retval)
+                return retval;
+        retval = ftdi_read_pcimem(pdev, roothub.a, &rh_a);
+        if (retval)
+                return retval;
+        num_ports = rh_a & RH_A_NDP;        /* refuse to confuse usbcore */
         if (pdev->dev.dma_mask) {
                 return -EINVAL;
         }
--- linux-2.6.19/drivers/usb/misc/ftdi-elan.c.original	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19/drivers/usb/misc/ftdi-elan.c	2006-12-05 13:49:17.000000000 +0000
@@ -40,6 +40,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/ioctl.h>
+#include <linux/pci_ids.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/kref.h>
@@ -51,6 +52,10 @@ MODULE_AUTHOR("Tony Olech");
 MODULE_DESCRIPTION("FTDI ELAN driver");
 MODULE_LICENSE("GPL");
 #define INT_MODULE_PARM(n, v) static int n = v;module_param(n, int, 0444)
+static int distrust_firmware = 1;
+module_param(distrust_firmware, bool, 0);
+MODULE_PARM_DESC(distrust_firmware, "true to distrust firmware power/overcurren"
+        "t setup");
 extern struct platform_driver u132_platform_driver;
 static struct workqueue_struct *status_queue;
 static struct workqueue_struct *command_queue;
@@ -66,7 +71,9 @@ static struct list_head ftdi_static_list
 * end of the global variables protected by ftdi_module_lock
 */
 #include "usb_u132.h"
-#define TD_DEVNOTRESP 5
+#include <asm/io.h>
+#include "../core/hcd.h"
+#include "../host/ohci.h"
 /* Define these values to match your devices*/
 #define USB_FTDI_ELAN_VENDOR_ID 0x0403
 #define USB_FTDI_ELAN_PRODUCT_ID 0xd6ea
@@ -578,7 +585,7 @@ static void ftdi_elan_status_work(void *
                 } else {
                         dev_err(&ftdi->udev->dev, "initialized failed - trying "
                                 "again in 10 seconds\n");
-                        work_delay_in_msec = 10 *1000;
+                        work_delay_in_msec = 1 *1000;
                 }
         } else if (ftdi->registered == 0) {
                 work_delay_in_msec = 10;
@@ -2323,82 +2330,288 @@ static int ftdi_elan_checkingPCI(struct 
         }
 }
 
-static int ftdi_elan_enumeratePCI(struct usb_ftdi *ftdi)
+
+#define ftdi_read_pcimem(ftdi, member, data) ftdi_elan_read_pcimem(ftdi, \
+        offsetof(struct ohci_regs, member), 0, data);
+#define ftdi_write_pcimem(ftdi, member, data) ftdi_elan_write_pcimem(ftdi, \
+        offsetof(struct ohci_regs, member), 0, data);
+#define OHCI_QUIRK_AMD756 0x01
+#define OHCI_QUIRK_SUPERIO 0x02
+#define OHCI_QUIRK_INITRESET 0x04
+#define OHCI_BIG_ENDIAN 0x08
+#define OHCI_QUIRK_ZFMICRO 0x10
+#define OHCI_CONTROL_INIT OHCI_CTRL_CBSR
+#define OHCI_INTR_INIT (OHCI_INTR_MIE | OHCI_INTR_UE | OHCI_INTR_RD | \
+        OHCI_INTR_WDH)
+static int ftdi_elan_check_controller(struct usb_ftdi *ftdi, int quirk)
+{
+        int devices = 0;
+        int retval;
+        u32 hc_control;
+        int num_ports;
+        u32 control;
+        u32 rh_a = -1;
+        u32 status;
+        u32 fminterval;
+        u32 hc_fminterval;
+        u32 periodicstart;
+        u32 cmdstatus;
+        u32 roothub_a;
+        int mask = OHCI_INTR_INIT;
+        int sleep_time = 0;
+        int reset_timeout = 30;        /* ... allow extra time */
+        int temp;
+        retval = ftdi_write_pcimem(ftdi, intrdisable, OHCI_INTR_MIE);
+        if (retval)
+                return retval;
+        retval = ftdi_read_pcimem(ftdi, control, &control);
+        if (retval)
+                return retval;
+        retval = ftdi_read_pcimem(ftdi, roothub.a, &rh_a);
+        if (retval)
+                return retval;
+        num_ports = rh_a & RH_A_NDP;
+        retval = ftdi_read_pcimem(ftdi, fminterval, &hc_fminterval);
+        if (retval)
+                return retval;
+        hc_fminterval &= 0x3fff;
+        if (hc_fminterval != FI) {
+        }
+        hc_fminterval |= FSMP(hc_fminterval) << 16;
+        retval = ftdi_read_pcimem(ftdi, control, &hc_control);
+        if (retval)
+                return retval;
+        switch (hc_control & OHCI_CTRL_HCFS) {
+        case OHCI_USB_OPER:
+                sleep_time = 0;
+                break;
+        case OHCI_USB_SUSPEND:
+        case OHCI_USB_RESUME:
+                hc_control &= OHCI_CTRL_RWC;
+                hc_control |= OHCI_USB_RESUME;
+                sleep_time = 10;
+                break;
+        default:
+                hc_control &= OHCI_CTRL_RWC;
+                hc_control |= OHCI_USB_RESET;
+                sleep_time = 50;
+                break;
+        }
+        retval = ftdi_write_pcimem(ftdi, control, hc_control);
+        if (retval)
+                return retval;
+        retval = ftdi_read_pcimem(ftdi, control, &control);
+        if (retval)
+                return retval;
+        msleep(sleep_time);
+        retval = ftdi_read_pcimem(ftdi, roothub.a, &roothub_a);
+        if (retval)
+                return retval;
+        if (!(roothub_a & RH_A_NPS)) {        /* power down each port */
+                for (temp = 0; temp < num_ports; temp++) {
+                        retval = ftdi_write_pcimem(ftdi,
+                                roothub.portstatus[temp], RH_PS_LSDA);
+                        if (retval)
+                                return retval;
+                }
+        }
+        retval = ftdi_read_pcimem(ftdi, control, &control);
+        if (retval)
+                return retval;
+      retry:retval = ftdi_read_pcimem(ftdi, cmdstatus, &status);
+        if (retval)
+                return retval;
+        retval = ftdi_write_pcimem(ftdi, cmdstatus, OHCI_HCR);
+        if (retval)
+                return retval;
+      extra:{
+                retval = ftdi_read_pcimem(ftdi, cmdstatus, &status);
+                if (retval)
+                        return retval;
+                if (0 != (status & OHCI_HCR)) {
+                        if (--reset_timeout == 0) {
+                                dev_err(&ftdi->udev->dev, "USB HC reset timed o"
+                                        "ut!\n");
+                                return -ENODEV;
+                        } else {
+                                msleep(5);
+                                goto extra;
+                        }
+                }
+        }
+        if (quirk & OHCI_QUIRK_INITRESET) {
+                retval = ftdi_write_pcimem(ftdi, control, hc_control);
+                if (retval)
+                        return retval;
+                retval = ftdi_read_pcimem(ftdi, control, &control);
+                if (retval)
+                        return retval;
+        }
+        retval = ftdi_write_pcimem(ftdi, ed_controlhead, 0x00000000);
+        if (retval)
+                return retval;
+        retval = ftdi_write_pcimem(ftdi, ed_bulkhead, 0x11000000);
+        if (retval)
+                return retval;
+        retval = ftdi_write_pcimem(ftdi, hcca, 0x00000000);
+        if (retval)
+                return retval;
+        retval = ftdi_read_pcimem(ftdi, fminterval, &fminterval);
+        if (retval)
+                return retval;
+        retval = ftdi_write_pcimem(ftdi, fminterval,
+                ((fminterval & FIT) ^ FIT) | hc_fminterval);
+        if (retval)
+                return retval;
+        retval = ftdi_write_pcimem(ftdi, periodicstart,
+                ((9 *hc_fminterval) / 10) & 0x3fff);
+        if (retval)
+                return retval;
+        retval = ftdi_read_pcimem(ftdi, fminterval, &fminterval);
+        if (retval)
+                return retval;
+        retval = ftdi_read_pcimem(ftdi, periodicstart, &periodicstart);
+        if (retval)
+                return retval;
+        if (0 == (fminterval & 0x3fff0000) || 0 == periodicstart) {
+                if (!(quirk & OHCI_QUIRK_INITRESET)) {
+                        quirk |= OHCI_QUIRK_INITRESET;
+                        goto retry;
+                } else
+                        dev_err(&ftdi->udev->dev, "init err(%08x %04x)\n",
+                                fminterval, periodicstart);
+        }                        /* start controller operations */
+        hc_control &= OHCI_CTRL_RWC;
+        hc_control |= OHCI_CONTROL_INIT | OHCI_CTRL_BLE | OHCI_USB_OPER;
+        retval = ftdi_write_pcimem(ftdi, control, hc_control);
+        if (retval)
+                return retval;
+        retval = ftdi_write_pcimem(ftdi, cmdstatus, OHCI_BLF);
+        if (retval)
+                return retval;
+        retval = ftdi_read_pcimem(ftdi, cmdstatus, &cmdstatus);
+        if (retval)
+                return retval;
+        retval = ftdi_read_pcimem(ftdi, control, &control);
+        if (retval)
+                return retval;
+        retval = ftdi_write_pcimem(ftdi, roothub.status, RH_HS_DRWE);
+        if (retval)
+                return retval;
+        retval = ftdi_write_pcimem(ftdi, intrstatus, mask);
+        if (retval)
+                return retval;
+        retval = ftdi_write_pcimem(ftdi, intrdisable,
+                OHCI_INTR_MIE | OHCI_INTR_OC | OHCI_INTR_RHSC | OHCI_INTR_FNO |
+                OHCI_INTR_UE | OHCI_INTR_RD | OHCI_INTR_SF | OHCI_INTR_WDH |
+                OHCI_INTR_SO);
+        if (retval)
+                return retval;        /* handle root hub init quirks ... */
+        retval = ftdi_read_pcimem(ftdi, roothub.a, &roothub_a);
+        if (retval)
+                return retval;
+        roothub_a &= ~(RH_A_PSM | RH_A_OCPM);
+        if (quirk & OHCI_QUIRK_SUPERIO) {
+                roothub_a |= RH_A_NOCP;
+                roothub_a &= ~(RH_A_POTPGT | RH_A_NPS);
+                retval = ftdi_write_pcimem(ftdi, roothub.a, roothub_a);
+                if (retval)
+                        return retval;
+        } else if ((quirk & OHCI_QUIRK_AMD756) || distrust_firmware) {
+                roothub_a |= RH_A_NPS;
+                retval = ftdi_write_pcimem(ftdi, roothub.a, roothub_a);
+                if (retval)
+                        return retval;
+        }
+        retval = ftdi_write_pcimem(ftdi, roothub.status, RH_HS_LPSC);
+        if (retval)
+                return retval;
+        retval = ftdi_write_pcimem(ftdi, roothub.b,
+                (roothub_a & RH_A_NPS) ? 0 : RH_B_PPCM);
+        if (retval)
+                return retval;
+        retval = ftdi_read_pcimem(ftdi, control, &control);
+        if (retval)
+                return retval;
+        mdelay((roothub_a >> 23) & 0x1fe);
+        for (temp = 0; temp < num_ports; temp++) {
+                u32 portstatus;
+                retval = ftdi_read_pcimem(ftdi, roothub.portstatus[temp],
+                        &portstatus);
+                if (retval)
+                        return retval;
+                if (1 & portstatus)
+                        devices += 1;
+        }
+        return devices;
+}
+
+static int ftdi_elan_setup_controller(struct usb_ftdi *ftdi, int fn)
 {
         u32 latence_timer;
-        u32 controlreg;
         int UxxxStatus;
         u32 pcidata;
         int reg = 0;
-        int foundOHCI = 0;
-        u8 fn;
-        int activePCIfn = 0;
-        u32 pciVID = 0;
-        u32 pciPID = 0;
-        UxxxStatus = ftdi_elan_read_reg(ftdi, &controlreg);
-        if (UxxxStatus)
-                return UxxxStatus;
-        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x00000000L);
-        if (UxxxStatus)
-                return UxxxStatus;
-        msleep(750);
-        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x00000200L | 0x100);
+        int activePCIfn = fn << 8;
+        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x0000025FL | 0x2800);
         if (UxxxStatus)
                 return UxxxStatus;
-        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x00000200L | 0x500);
+        reg = 16;
+        UxxxStatus = ftdi_elan_write_config(ftdi, activePCIfn | reg, 0,
+                0xFFFFFFFF);
         if (UxxxStatus)
                 return UxxxStatus;
-        UxxxStatus = ftdi_elan_read_reg(ftdi, &controlreg);
+        UxxxStatus = ftdi_elan_read_config(ftdi, activePCIfn | reg, 0,
+                &pcidata);
         if (UxxxStatus)
                 return UxxxStatus;
-        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x0000020CL | 0x000);
+        UxxxStatus = ftdi_elan_write_config(ftdi, activePCIfn | reg, 0,
+                0xF0000000);
         if (UxxxStatus)
                 return UxxxStatus;
-        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x0000020DL | 0x000);
+        UxxxStatus = ftdi_elan_read_config(ftdi, activePCIfn | reg, 0,
+                &pcidata);
         if (UxxxStatus)
                 return UxxxStatus;
-        msleep(250);
-        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x0000020FL | 0x000);
+        reg = 12;
+        UxxxStatus = ftdi_elan_read_config(ftdi, activePCIfn | reg, 0,
+                &latence_timer);
         if (UxxxStatus)
                 return UxxxStatus;
-        UxxxStatus = ftdi_elan_read_reg(ftdi, &controlreg);
+        latence_timer &= 0xFFFF00FF;
+        latence_timer |= 0x00001600;
+        UxxxStatus = ftdi_elan_write_config(ftdi, activePCIfn | reg, 0x00,
+                latence_timer);
         if (UxxxStatus)
                 return UxxxStatus;
-        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x0000025FL | 0x800);
+        UxxxStatus = ftdi_elan_read_config(ftdi, activePCIfn | reg, 0,
+                &pcidata);
         if (UxxxStatus)
                 return UxxxStatus;
-        UxxxStatus = ftdi_elan_read_reg(ftdi, &controlreg);
+        reg = 4;
+        UxxxStatus = ftdi_elan_write_config(ftdi, activePCIfn | reg, 0x00,
+                0x06);
         if (UxxxStatus)
                 return UxxxStatus;
-        UxxxStatus = ftdi_elan_read_reg(ftdi, &controlreg);
+        UxxxStatus = ftdi_elan_read_config(ftdi, activePCIfn | reg, 0,
+                &pcidata);
         if (UxxxStatus)
                 return UxxxStatus;
-        msleep(1000);
-        for (fn = 0; (fn < 4) && (!foundOHCI); fn++) {
-                activePCIfn = fn << 8;
-                ftdi->function = fn + 1;
-                UxxxStatus = ftdi_elan_read_config(ftdi, activePCIfn | reg, 0,
-                        &pcidata);
+        for (reg = 0; reg <= 0x54; reg += 4) {
+                UxxxStatus = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
                 if (UxxxStatus)
                         return UxxxStatus;
-                pciVID = pcidata & 0xFFFF;
-                pciPID = (pcidata >> 16) & 0xFFFF;
-                if ((pciVID == 0x1045) && (pciPID == 0xc861)) {
-                        foundOHCI = 1;
-                } else if ((pciVID == 0x1033) && (pciPID == 0x0035)) {
-                        foundOHCI = 1;
-                } else if ((pciVID == 0x10b9) && (pciPID == 0x5237)) {
-                        foundOHCI = 1;
-                } else if ((pciVID == 0x11c1) && (pciPID == 0x5802)) {
-                        foundOHCI = 1;
-                } else if ((pciVID == 0x11AB) && (pciPID == 0x1FA6)) {
-                }
-        }
-        if (foundOHCI == 0) {
-                return -ENXIO;
         }
-        ftdi->platform_data.vendor = pciVID;
-        ftdi->platform_data.device = pciPID;
+        return 0;
+}
+
+static int ftdi_elan_close_controller(struct usb_ftdi *ftdi, int fn)
+{
+        u32 latence_timer;
+        int UxxxStatus;
+        u32 pcidata;
+        int reg = 0;
+        int activePCIfn = fn << 8;
         UxxxStatus = ftdi_elan_write_reg(ftdi, 0x0000025FL | 0x2800);
         if (UxxxStatus)
                 return UxxxStatus;
@@ -2412,7 +2625,7 @@ static int ftdi_elan_enumeratePCI(struct
         if (UxxxStatus)
                 return UxxxStatus;
         UxxxStatus = ftdi_elan_write_config(ftdi, activePCIfn | reg, 0,
-                0xF0000000);
+                0x00000000);
         if (UxxxStatus)
                 return UxxxStatus;
         UxxxStatus = ftdi_elan_read_config(ftdi, activePCIfn | reg, 0,
@@ -2436,7 +2649,7 @@ static int ftdi_elan_enumeratePCI(struct
                 return UxxxStatus;
         reg = 4;
         UxxxStatus = ftdi_elan_write_config(ftdi, activePCIfn | reg, 0x00,
-                0x06);
+                0x00);
         if (UxxxStatus)
                 return UxxxStatus;
         UxxxStatus = ftdi_elan_read_config(ftdi, activePCIfn | reg, 0,
@@ -2446,159 +2659,139 @@ static int ftdi_elan_enumeratePCI(struct
         return 0;
 }
 
+static int ftdi_elan_found_controller(struct usb_ftdi *ftdi, int fn, int quirk)
+{
+        int result;
+        int UxxxStatus;
+        UxxxStatus = ftdi_elan_setup_controller(ftdi, fn);
+        if (UxxxStatus)
+                return UxxxStatus;
+        result = ftdi_elan_check_controller(ftdi, quirk);
+        UxxxStatus = ftdi_elan_close_controller(ftdi, fn);
+        if (UxxxStatus)
+                return UxxxStatus;
+        return result;
+}
+
+static int ftdi_elan_enumeratePCI(struct usb_ftdi *ftdi)
+{
+        u32 controlreg;
+        u8 sensebits;
+        int UxxxStatus;
+        UxxxStatus = ftdi_elan_read_reg(ftdi, &controlreg);
+        if (UxxxStatus)
+                return UxxxStatus;
+        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x00000000L);
+        if (UxxxStatus)
+                return UxxxStatus;
+        msleep(750);
+        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x00000200L | 0x100);
+        if (UxxxStatus)
+                return UxxxStatus;
+        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x00000200L | 0x500);
+        if (UxxxStatus)
+                return UxxxStatus;
+        UxxxStatus = ftdi_elan_read_reg(ftdi, &controlreg);
+        if (UxxxStatus)
+                return UxxxStatus;
+        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x0000020CL | 0x000);
+        if (UxxxStatus)
+                return UxxxStatus;
+        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x0000020DL | 0x000);
+        if (UxxxStatus)
+                return UxxxStatus;
+        msleep(250);
+        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x0000020FL | 0x000);
+        if (UxxxStatus)
+                return UxxxStatus;
+        UxxxStatus = ftdi_elan_read_reg(ftdi, &controlreg);
+        if (UxxxStatus)
+                return UxxxStatus;
+        UxxxStatus = ftdi_elan_write_reg(ftdi, 0x0000025FL | 0x800);
+        if (UxxxStatus)
+                return UxxxStatus;
+        UxxxStatus = ftdi_elan_read_reg(ftdi, &controlreg);
+        if (UxxxStatus)
+                return UxxxStatus;
+        UxxxStatus = ftdi_elan_read_reg(ftdi, &controlreg);
+        if (UxxxStatus)
+                return UxxxStatus;
+        msleep(1000);
+        sensebits = (controlreg >> 16) & 0x000F;
+        if (0x0D == sensebits)
+                return 0;
+        else
+		return - ENXIO;
+}
+
 static int ftdi_elan_setupOHCI(struct usb_ftdi *ftdi)
 {
+        int UxxxStatus;
         u32 pcidata;
-        int U132Status;
-        int reg;
-        int reset_repeat = 0;
-      do_reset:reg = 8;
-        U132Status = ftdi_elan_write_pcimem(ftdi, reg, 0x0e, 0x01);
-        if (U132Status)
-                return U132Status;
-      reset_check:{
-                U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-                if (U132Status)
-                        return U132Status;
-                if (pcidata & 1) {
-                        msleep(500);
-                        if (reset_repeat++ > 100) {
-                                reset_repeat = 0;
-                                goto do_reset;
-                        } else
-                                goto reset_check;
+        int reg = 0;
+        u8 fn;
+        int activePCIfn = 0;
+        int max_devices = 0;
+        int controllers = 0;
+        int unrecognized = 0;
+        ftdi->function = 0;
+        for (fn = 0; (fn < 4); fn++) {
+                u32 pciVID = 0;
+                u32 pciPID = 0;
+                int devices = 0;
+                activePCIfn = fn << 8;
+                UxxxStatus = ftdi_elan_read_config(ftdi, activePCIfn | reg, 0,
+                        &pcidata);
+                if (UxxxStatus)
+                        return UxxxStatus;
+                pciVID = pcidata & 0xFFFF;
+                pciPID = (pcidata >> 16) & 0xFFFF;
+                if ((pciVID == PCI_VENDOR_ID_OPTI) && (pciPID == 0xc861)) {
+                        devices = ftdi_elan_found_controller(ftdi, fn, 0);
+                        controllers += 1;
+                } else if ((pciVID == PCI_VENDOR_ID_NEC) && (pciPID == 0x0035))
+                        {
+                        devices = ftdi_elan_found_controller(ftdi, fn, 0);
+                        controllers += 1;
+                } else if ((pciVID == PCI_VENDOR_ID_AL) && (pciPID == 0x5237)) {
+                        devices = ftdi_elan_found_controller(ftdi, fn, 0);
+                        controllers += 1;
+                } else if ((pciVID == PCI_VENDOR_ID_ATT) && (pciPID == 0x5802))
+                        {
+                        devices = ftdi_elan_found_controller(ftdi, fn, 0);
+                        controllers += 1;
+                } else if (pciVID == PCI_VENDOR_ID_AMD && pciPID == 0x740c) {
+                        devices = ftdi_elan_found_controller(ftdi, fn,
+                                OHCI_QUIRK_AMD756);
+                        controllers += 1;
+                } else if (pciVID == PCI_VENDOR_ID_COMPAQ && pciPID == 0xa0f8) {
+                        devices = ftdi_elan_found_controller(ftdi, fn,
+                                OHCI_QUIRK_ZFMICRO);
+                        controllers += 1;
+                } else if (0 == pcidata) {
+                } else
+                        unrecognized += 1;
+                if (devices > max_devices) {
+                        max_devices = devices;
+                        ftdi->function = fn + 1;
+                        ftdi->platform_data.vendor = pciVID;
+                        ftdi->platform_data.device = pciPID;
                 }
         }
-        goto dump_regs;
-        msleep(500);
-        reg = 0x28;
-        U132Status = ftdi_elan_write_pcimem(ftdi, reg, 0x00, 0x11000000);
-        if (U132Status)
-                return U132Status;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        reg = 0x40;
-        U132Status = ftdi_elan_write_pcimem(ftdi, reg, 0x00, 0x2edf);
-        if (U132Status)
-                return U132Status;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        reg = 0x34;
-        U132Status = ftdi_elan_write_pcimem(ftdi, reg, 0x00, 0x2edf2edf);
-        if (U132Status)
-                return U132Status;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        reg = 4;
-        U132Status = ftdi_elan_write_pcimem(ftdi, reg, 0x00, 0xA0);
-        if (U132Status)
-                return U132Status;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        msleep(250);
-        reg = 8;
-        U132Status = ftdi_elan_write_pcimem(ftdi, reg, 0x0e, 0x04);
-        if (U132Status)
-                return U132Status;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        reg = 0x28;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        reg = 8;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        reg = 0x48;
-        U132Status = ftdi_elan_write_pcimem(ftdi, reg, 0x00, 0x00001200);
-        if (U132Status)
-                return U132Status;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        reg = 0x54;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        reg = 0x58;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        reg = 0x34;
-        U132Status = ftdi_elan_write_pcimem(ftdi, reg, 0x00, 0x28002edf);
-        if (U132Status)
-                return U132Status;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        msleep(100);
-        reg = 0x50;
-        U132Status = ftdi_elan_write_pcimem(ftdi, reg, 0x00, 0x10000);
-        if (U132Status)
-                return U132Status;
-        reg = 0x54;
-      power_check:U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        if (!(pcidata & 1)) {
-                msleep(500);
-                goto power_check;
-        }
-        msleep(3000);
-        reg = 0x54;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        reg = 0x58;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        reg = 0x54;
-        U132Status = ftdi_elan_write_pcimem(ftdi, reg, 0x00, 0x02);
-        if (U132Status)
-                return U132Status;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        reg = 0x54;
-        U132Status = ftdi_elan_write_pcimem(ftdi, reg, 0x00, 0x10);
-        if (U132Status)
-                return U132Status;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        msleep(750);
-        reg = 0x54;
-        if (0) {
-                U132Status = ftdi_elan_write_pcimem(ftdi, reg, 0x00, 0x02);
-                if (U132Status)
-                        return U132Status;
-        }
-        if (0) {
-                U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-                if (U132Status)
-                        return U132Status;
-        }
-        reg = 0x54;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-        reg = 0x58;
-        U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-        if (U132Status)
-                return U132Status;
-      dump_regs:for (reg = 0; reg <= 0x54; reg += 4) {
-                U132Status = ftdi_elan_read_pcimem(ftdi, reg, 0, &pcidata);
-                if (U132Status)
-                        return U132Status;
+        if (ftdi->function > 0) {
+                UxxxStatus = ftdi_elan_setup_controller(ftdi,
+                        ftdi->function - 1);
+                if (UxxxStatus)
+                        return UxxxStatus;
+                return 0;
+        } else if (controllers > 0) {
+                return -ENXIO;
+        } else if (unrecognized > 0) {
+                return -ENXIO;
+        } else {
+                ftdi->enumerated = 0;
+                return -ENXIO;
         }
-        return 0;
 }
 
 
@@ -2732,6 +2925,7 @@ static void ftdi_elan_disconnect(struct 
                         platform_device_unregister(&ftdi->platform_dev);
                         ftdi->synchronized = 0;
                         ftdi->enumerated = 0;
+                        ftdi->initialized = 0;
                         ftdi->registered = 0;
                 }
                 flush_workqueue(status_queue);
