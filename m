Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135656AbRDTHUv>; Fri, 20 Apr 2001 03:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135710AbRDTHUm>; Fri, 20 Apr 2001 03:20:42 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:8461 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S135656AbRDTHU0>;
	Fri, 20 Apr 2001 03:20:26 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15071.58233.929156.72932@argo.ozlabs.ibm.com.au>
Date: Fri, 20 Apr 2001 17:21:29 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cort@fsmlabs.com, benh@kernel.crashing.org,
        jerdfelt@valinux.com
Subject: [PATCH] [RESENT] fix bugs in HID driver
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Oops, re-sent with a subject line this time...]

Linus,

This patch fixes some bugs in drivers/usb/hid.c.  Johannes Erdfelt
(the maintainer) sent it to you previously but it got missed.  Could
it go in 2.4.4 please?  Here are the comments explaining the patch
that I wrote originally:

> The first hunk just fixes some typos in s32ton.  For example, with
> n == 8, the code as it was would return 0x80 if value > 127 but 0xff
> if value < -128.  With my change it returns 0x7f for value > 127 and
> 0x80 for value < -128.
>
> The second hunk fixes the "cdcd" problem that we see on apple
> keyboards that can only handle 2-key rollover.  If you type "c" "d"
> <space> quickly on these keyboards, you get a report with the
> error-rollover code (1) in bytes 2 - 7 (instead of the codes for the
> keys that are down).  Without this patch the code thinks that all the
> keys that were down are now up.  When you release one key you get a
> normal report again and the code thinks that the remaining keys have
> been pressed again.  The patch makes the code just discard the report
> once it sees the error-rollover code.
>
> The remaining hunks fix some endianness problems in the code that sets
> the keyboard leds.

Thanks,
Paul.

diff -urN linux/drivers/usb/hid.c linuxppc_2_4/drivers/usb/hid.c
--- linux/drivers/usb/hid.c	Thu Feb 22 14:25:27 2001
+++ linuxppc_2_4/drivers/usb/hid.c	Mon Feb 12 13:35:00 2001
@@ -698,7 +698,7 @@
 static __inline__ __u32 s32ton(__s32 value, unsigned n)
 {
 	__s32 a = value >> (n - 1);
-	if (a && a != -1) return value > 0 ? 1 << (n - 1) : (1 << n) - 1;
+	if (a && a != -1) return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
 	return value & ((1 << n) - 1);
 }
 
@@ -1016,9 +1016,15 @@
 	__s32 max = field->logical_maximum;
 	__s32 value[count]; /* WARNING: gcc specific */
    
-	for (n = 0; n < count; n++)
+	for (n = 0; n < count; n++) {
 			value[n] = min < 0 ? snto32(extract(data, offset + n * size, size), size) : 
 						    extract(data, offset + n * size, size);
+			/* Handle the ErrorRollOver code (1) by simply ignoring this report */
+			if (!(field->flags & HID_MAIN_ITEM_VARIABLE)
+			    && value[n] >= min && value[n] <= max
+			    && field->usage[value[n] - min].hid == HID_UP_KEYBOARD + 1)
+				return;
+	}
 
 	for (n = 0; n < count; n++) {
 
@@ -1231,7 +1237,7 @@
 
 static int hid_submit_out(struct hid_device *hid)
 {
-	hid->urbout.transfer_buffer_length = hid->out[hid->outtail].dr.length;
+	hid->urbout.transfer_buffer_length = le16_to_cpup(&hid->out[hid->outtail].dr.length);
 	hid->urbout.transfer_buffer = hid->out[hid->outtail].buffer;
 	hid->urbout.setup_packet = (void *) &(hid->out[hid->outtail].dr);
 	hid->urbout.dev = hid->dev;
@@ -1271,8 +1277,8 @@
 	hid_set_field(field, offset, value);
 	hid_output_report(field->report, hid->out[hid->outhead].buffer);
 
-	hid->out[hid->outhead].dr.value = 0x200 | field->report->id;
-	hid->out[hid->outhead].dr.length = ((field->report->size - 1) >> 3) + 1;
+	hid->out[hid->outhead].dr.value = cpu_to_le16(0x200 | field->report->id);
+	hid->out[hid->outhead].dr.length = cpu_to_le16((field->report->size + 7) >> 3);
 
 	hid->outhead = (hid->outhead + 1) & (HID_CONTROL_FIFO_SIZE - 1);
 
@@ -1445,7 +1451,7 @@
 	for (n = 0; n < HID_CONTROL_FIFO_SIZE; n++) {
 		hid->out[n].dr.requesttype = USB_TYPE_CLASS | USB_RECIP_INTERFACE;
 		hid->out[n].dr.request = USB_REQ_SET_REPORT;
-		hid->out[n].dr.index = hid->ifnum;
+		hid->out[n].dr.index = cpu_to_le16(hid->ifnum);
 	}
 
 	hid->input.name = hid->name;
