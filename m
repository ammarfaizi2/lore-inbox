Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268611AbRHBDU5>; Wed, 1 Aug 2001 23:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268606AbRHBDUr>; Wed, 1 Aug 2001 23:20:47 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:35735 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268598AbRHBDUa>; Wed, 1 Aug 2001 23:20:30 -0400
Message-ID: <3B68C6FF.31035354@yahoo.co.uk>
Date: Wed, 01 Aug 2001 23:20:31 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PATCH to fix bug: "serial" does not show up in /proc/interrupts
Content-Type: multipart/mixed;
 boundary="------------4706668D69139E11E46D515A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4706668D69139E11E46D515A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here is a patch to fix the serial driver so that its name
appears in /proc/interrupts.  The bug was caused by code
that was overwriting the string literal "serial" with "".
gcc merges all the "serial" strings together into one, so
the "serial" sent to irq_request() was being ""ed as a
side-effect.

Here is the patch to 2.4.7-ac3 both inline and attached.
// Thomas Hood  <jdthood_AT_yahoo.co.uk>

--- serial.c_ORIG       Wed Aug  1 23:02:09 2001
+++ serial.c    Wed Aug  1 23:11:01 2001
@@ -4852,10 +4852,13 @@

 MODULE_DEVICE_TABLE(pci, serial_pci_tbl);

+/* serial_pci_driver_name[] gets truncated to ""  if the pci probe fails */
+static char serial_pci_driver_name[] = "serial";
+
 static struct pci_driver serial_pci_driver = {
-       name:           "serial",
+       name:           serial_pci_driver_name,
        probe:          serial_init_one,
-       remove:        serial_remove_one,
+       remove:         serial_remove_one,
        id_table:       serial_pci_tbl,
 };


I wrote:
> I noticed the following anomaly.  I am using a modular serial
> driver for /dev/ttyS0 and /dev/ttyS1 (actually /dev/tts/0 and
> /dev/tts/1 under devfs).  See the listing of my /proc/interrupts
> below.  I have /dev/ttyS1 open; it uses IRQ3; but note that the
> name of the serial driver is not printed in the list.
> 
> root@thanatos:~# cat /proc/interrupts
>            CPU0       
>   0:      65078          XT-PIC  timer
>   1:       1546          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   3:       1979          XT-PIC  
>   5:       3324          XT-PIC  CS4231
>   8:          1          XT-PIC  rtc
>  10:         27          XT-PIC  mwave_3780i
>  11:       5021          XT-PIC  usb-uhci, Texas Instruments PCI1250, Texas Instruments PCI1250 (#2)
>  12:       3268          XT-PIC  PS/2 Mouse
>  14:       8807          XT-PIC  ide0
>  15:          4          XT-PIC  ide1
> NMI:          0 
> ERR:          0
> 
> Strange.  But it gets stranger.  I insert a combination modem/
> ethernet pcmcia card and I get:
> 
>   7:          9          XT-PIC  xirc2ps_cs,
> 
> In the past, there was something printed after the comma,
> but now there's just a space.  Bizarre.
> 
> I was not able to find any silly bugs in the serial driver
> or irq routines that would account for this, so I am worried
> that something is very wrong somewhere.
> 
> --
> Thomas Hood
> jdthood_AT_yahoo.co.uk
>
--------------4706668D69139E11E46D515A
Content-Type: text/plain; charset=us-ascii;
 name="toms-serial-patch-20010801-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="toms-serial-patch-20010801-1"

--- serial.c_ORIG	Wed Aug  1 23:02:09 2001
+++ serial.c	Wed Aug  1 23:11:01 2001
@@ -4852,10 +4852,13 @@
 
 MODULE_DEVICE_TABLE(pci, serial_pci_tbl);
 
+/* serial_pci_driver_name[] gets truncated to ""  if the pci probe fails */
+static char serial_pci_driver_name[] = "serial";
+
 static struct pci_driver serial_pci_driver = {
-       name:           "serial",
+       name:           serial_pci_driver_name,
        probe:          serial_init_one,
-       remove:	       serial_remove_one,
+       remove:         serial_remove_one,
        id_table:       serial_pci_tbl,
 };
 

--------------4706668D69139E11E46D515A--

