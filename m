Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289595AbSAJSVK>; Thu, 10 Jan 2002 13:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289589AbSAJSUu>; Thu, 10 Jan 2002 13:20:50 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:39432 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S289588AbSAJSUp>;
	Thu, 10 Jan 2002 13:20:45 -0500
Message-ID: <3C3DDB53.D799A1EC@gmx.net>
Date: Thu, 10 Jan 2002 19:20:03 +0100
From: root <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rene Engelhard <mail@rene-engelhard.de>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Getting ScanLogic USB-ATAPI Adapter to work
In-Reply-To: <20020107211757.A4196@rene-engelhard.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Engelhard wrote:

> Hi Greg, hi Kernel-Hackers,
>
> a long time ago I bought the Adapter mentioned above and got it
> working.
>
> Now, 6 months after that I bought it, my testing is over and I got the
> result: The device is working by changing the usb-storage sources; this
> has not affected any other thing. All my devices (3 of USB) runs perfectly.

I sent a fool-proof patch to the MAINTAINER 6 (nine!) months before and
discussed this on usb-devel. The MAINTAINER has chosen to reject
this patch (for private discussions whith the manufacturer about standards
comliance) and leave users alone ! Although I proposed to him to disable
all QUIRKS and Worksarounds for buggy hardware in his tree and see if the
system still is running he stayed stubborn. As UNUSUAL_DEVS is quite
large he is inconsequent for no apparent reason.

P.S. Please use this patch:
- Don't bloat Config.in with with unnecessary decisions, just fix the bugger
  automatically.
- Be non-intrusive to other devices.

Gunther


--- linux-2.4.6-ac1-orig/drivers/usb/storage/transport.c        Wed Apr 18
20:49:12 2001
+++ linux/drivers/usb/storage/transport.c       Sat Jul 21 12:18:32 2001
@@ -1180,7 +1180,7 @@
                  le32_to_cpu(bcs.Signature), bcs.Tag,
                  bcs.Residue, bcs.Status);
        if (bcs.Signature != cpu_to_le32(US_BULK_CS_SIGN) ||
-           bcs.Tag != bcb.Tag ||
+           ((bcs.Tag != bcb.Tag) && !(us->flags & US_FL_QUIRKS_TAG)) ||
            bcs.Status > US_BULK_STAT_PHASE || partial != 13) {
                US_DEBUGP("Bulk logical error\n");
                return USB_STOR_TRANSPORT_ERROR;
--- linux-2.4.6-ac1-orig/drivers/usb/storage/usb.h      Sun Jul  8 19:53:50
2001
+++ linux/drivers/usb/storage/usb.h     Sat Jul 21 12:05:15 2001
@@ -100,6 +100,8 @@
 #define US_FL_IGNORE_SER      0x00000010 /* Ignore the serial number given
*/
 #define US_FL_SCM_MULT_TARG   0x00000020 /* supports multiple targets */
 #define US_FL_FIX_INQUIRY     0x00000040 /* INQUIRY response needs fixing */
+#define US_FL_QUIRKS_TAG      0x00000080 /* the buggy device doesn't echo the
tag
+                                           in the status response !*/

 #define USB_STOR_STRING_LEN 32

--- linux-2.4.6-ac1-orig/drivers/usb/storage/unusual_devs.h     Sun Jul  8
19:53:50 2001
+++ linux/drivers/usb/storage/unusual_devs.h    Sat Jul 21 12:06:55 2001
@@ -59,6 +59,12 @@
                "FinePix 1400Zoom",
                US_SC_8070, US_PR_CBI, NULL, US_FL_FIX_INQUIRY),

+// Firmware 2.60 needs US_FL_QUIRKS_TAG here ! Bugger device.
+UNUSUAL_DEV(  0x04ce, 0x0002, 0x0000, 0x9999,
+                "Scanlogic",
+                "SL11R USBIDE",
+                US_SC_SCSI, US_PR_BULK, NULL, US_FL_QUIRKS_TAG),
+
 UNUSUAL_DEV(  0x04e6, 0x0001, 0x0200, 0x0200,
                "Matshita",
                "LS-120",






