Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWGILej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWGILej (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 07:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbWGILej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 07:34:39 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:47070 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030252AbWGILeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 07:34:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=p/ZF6/ZhrPTzddi70jTMlkZxZo88oPGbkFQIoWKIq6DQ9lqgQ2ERGs3poGsq067U5odz5/e9+ns556EUZ9dKa12l/B5bs7w0Kg9+MFdi8oX8UIjQU6SraYqtCCHluK7POI4q/NOUqEZ4aJrpWjL++pjPs/kmj9LYTaGG3y8MlcE=
Message-ID: <62b0912f0607090434q735e36b7pd9ab35baf0914e7a@mail.gmail.com>
Date: Sun, 9 Jul 2006 13:34:37 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: linux-kernel@vger.kernel.org, linux.nics@intel.com,
       scott.feldman@intel.com
Subject: [bug] e100 bug: checksum mismatch on 82551ER rev10
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I'm trying to get Linux running on a Nokia IP130 box.

The 3x Intel i82551ER NICs doesn't work.

This is the console messages (I've added printing of the checksum values):

===============================================================
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
PCI: Found IRQ 10 for device 0000:00:0e.0
IRQ routing conflict for 0000:00:0e.0, have irq 11, want irq 10
e100: 0000:00:0e.0: e100_eeprom_load: EEPROM corrupted (stored: e6bc,
calc'ed: 54cf)
e100: eth0: e100_probe: addr 0x80100000, irq 11, MAC addr 00:A0:8E:22:58:58
PCI: Found IRQ 11 for device 0000:00:0f.0
IRQ routing conflict for 0000:00:0f.0, have irq 10, want irq 11
e100: 0000:00:0f.0: e100_eeprom_load: EEPROM corrupted (stored: d9cc,
calc'ed: 53cf)
e100: eth1: e100_probe: addr 0x80300000, irq 10, MAC addr 00:A0:8E:22:58:59
PCI: Found IRQ 10 for device 0000:00:10.0
IRQ routing conflict for 0000:00:10.0, have irq 5, want irq 10
e100: 0000:00:10.0: e100_eeprom_load: EEPROM corrupted (stored: d95a,
calc'ed: 52cf)
e100: eth2: e100_probe: addr 0x80500000, irq 5, MAC addr 00:A0:8E:22:58:5A
===============================================================

With vanilla 2.6.17, the e100 module dies with EAGAIN.

Apply this patch which just removes the error return path (and adds a
little debug info):

===============================================================
--- drivers/net/e100.c.orig     2006-07-09 12:03:14.000000000 +0200
+++ drivers/net/e100.c  2006-07-09 12:03:22.000000000 +0200
@@ -756,8 +756,7 @@
         * the sum of words should be 0xBABA */
        checksum = le16_to_cpu(0xBABA - checksum);
        if(checksum != nic->eeprom[nic->eeprom_wc - 1]) {
-               DPRINTK(PROBE, ERR, "EEPROM corrupted\n");
-               return -EAGAIN;
+               DPRINTK(PROBE, ERR, "EEPROM corrupted (stored: %4.4x, calc'ed: %
4.4x)\n", nic->eeprom[nic->eeprom_wc - 1], checksum);
        }

        return 0;
===============================================================

And everything works!

I think I've heard about this bug before, but I don't know why it occurs.
So the best I can do is the above (ignore failed EEPROM checksum test).

My hardware is:
00:0e.0 Ethernet controller: Intel Corporation 8255xER/82551IT Fast
Ethernet Controller (rev 10)
00:0f.0 Ethernet controller: Intel Corporation 8255xER/82551IT Fast
Ethernet Controller (rev 10)
00:10.0 Ethernet controller: Intel Corporation 8255xER/82551IT Fast
Ethernet Controller (rev 10)

I was wondering if we can just remove the -EAGAIN return from the
driver and in effect turn the EEPROM checksum stuff into a non-fatal
test?  Since I can't figure out the correct way to test the checksum
on this hardware, that seems like the best thing to do to me...
