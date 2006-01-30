Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWA3P3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWA3P3C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWA3P3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:29:02 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:24775 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932323AbWA3P3A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:29:00 -0500
Message-ID: <43DE30F1.6040107@us.ibm.com>
Date: Mon, 30 Jan 2006 09:29:53 -0600
From: "V. Ananda Krishnan" <mansarov@us.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Adrian Bunk <bunk@stusta.de>, Greg KH <gregkh@suse.de>,
       Scott_Kilau@digi.com
Subject: [RFC: linux-2.6.16-rc1 patch] jsm: fix for high baud rates problem
Content-Type: multipart/mixed;
 boundary="------------080008000502060500000503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080008000502060500000503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Digi serial port console doesn't work when baud rates are set higher 
than 38400.  So the lookup table and code in jsm_neo.c has been modified 
and tested.  Please let me have the feed-back.

Thanks,
V. Ananda Krishnan



Authors: Scott Kilau and V. Ananda Krishnan
Signed-off-by: V.Ananda Krishnan

...



--------------080008000502060500000503
Content-Type: text/plain;
 name="neo_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="neo_patch"

diff -Naur linux-2.6.16-rc1/drivers/serial/jsm/jsm_neo.c linux-2.6.16-rc1-mod/drivers/serial/jsm/jsm_neo.c
--- linux-2.6.16-rc1/drivers/serial/jsm/jsm_neo.c	2006-01-27 21:19:45.000000000 -0600
+++ linux-2.6.16-rc1-mod/drivers/serial/jsm/jsm_neo.c	2006-01-27 21:43:28.000000000 -0600
@@ -966,47 +966,41 @@
			if (ch->ch_flags & CH_BAUD0)
				ch->ch_flags &= ~(CH_BAUD0);
		} else {
-			int iindex = 0;
-			int jindex = 0;
-
-			const u64 bauds[4][16] = {
-				{
-					0,	50,	75,	110,
-					134,	150,	200,	300,
-					600,	1200,	1800,	2400,
-					4800,	9600,	19200,	38400 },
-				{
-					0,	57600,	115200, 230400,
-					460800, 150,	200,	921600,
-					600,	1200,	1800,	2400,
-					4800,	9600,	19200,	38400 },
-				{
-					0,	57600,	76800, 115200,
-					131657, 153600, 230400, 460800,
-					921600, 1200,	1800,	2400,
-					4800,	9600,	19200,	38400 },
-				{
-					0,	57600,	115200, 230400,
-					460800, 150,	200,	921600,
-					600,	1200,	1800,	2400,
-					4800,	9600,	19200,	38400 }
+			int i= 0;
+			struct baud_rates {
+				unsigned int rate;
+				unsigned int cflag;
+			};
+			static struct baud_rates baud_rates[] = {
+				{ 921600, B921600 },
+				{ 460800, B460800 },
+				{ 230400, B230400 },
+				{ 115200, B115200 },
+				{  57600, B57600  },
+				{  38400, B38400  },
+				{  19200, B19200  },
+				{   9600, B9600   },
+				{   4800, B4800   },
+				{   2400, B2400   },
+				{   1200, B1200   },
+				{    600, B600    },
+				{    300, B300    },
+				{    200, B200    },
+				{    150, B150    },
+				{    134, B134    },
+				{    110, B110    },
+				{     75, B75     },
+				{     50, B50     },
+				{      0, B600	  }
			};

-			baud = C_BAUD(ch->uart_port.info->tty) & 0xff;
-
-			if (ch->ch_c_cflag & CBAUDEX)
-				iindex = 1;
-
-			jindex = baud;
+			baud = C_BAUD(ch->uart_port.info->tty);

-			if ((iindex >= 0) && (iindex < 4) && (jindex >= 0) && (jindex < 16))
-				baud = bauds[iindex][jindex];
-			else {
-				jsm_printk(IOCTL, DEBUG, &ch->ch_bd->pci_dev,
-					"baud indices were out of range (%d)(%d)",
-				iindex, jindex);
-				baud = 0;
+			for (i = 0; baud_rates[i].rate; i++) {
+				if (baud_rates[i].cflag == baud)
+					break;
			}
+			baud = baud_rates[i].rate;

			if (baud == 0)
				baud = 9600;

--------------080008000502060500000503--
