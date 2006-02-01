Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWBAADI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWBAADI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 19:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWBAADI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 19:03:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27075 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932210AbWBAADH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 19:03:07 -0500
Date: Tue, 31 Jan 2006 16:01:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: "V. Ananda Krishnan" <mansarov@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, bunk@stusta.de,
       gregkh@suse.de, Scott_Kilau@digi.com
Subject: Re: [RFC: linux-2.6.16-rc1 patch] jsm: fix for high baud rates
 problem
Message-Id: <20060131160150.0cae687e.akpm@osdl.org>
In-Reply-To: <43DE30F1.6040107@us.ibm.com>
References: <43DE30F1.6040107@us.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"V. Ananda Krishnan" <mansarov@us.ibm.com> wrote:
>
> igi serial port console doesn't work when baud rates are set higher 
> than 38400.  So the lookup table and code in jsm_neo.c has been modified 
> and tested.

- All the code you've added is one tabstop too far to the right.

- We can simplify the definition of baud_rates[]

- Using local variable `baud' as a temporary cflag is confusing.

- The baud_rates[] scanning can be simplified.

- local `i' doesn't need the initialiser.



How's this look?

--- 25/drivers/serial/jsm/jsm_neo.c~jsm-fix-for-high-baud-rates-problem-tidy	Tue Jan 31 15:57:46 2006
+++ 25-akpm/drivers/serial/jsm/jsm_neo.c	Tue Jan 31 15:57:46 2006
@@ -965,50 +965,47 @@ static void neo_param(struct jsm_channel
 			baud = ch->ch_custom_speed;
 			if (ch->ch_flags & CH_BAUD0)
 				ch->ch_flags &= ~(CH_BAUD0);
-		} else {
-			int i= 0;
-			struct baud_rates {
-				unsigned int rate;
-				unsigned int cflag;
-			};
-			static struct baud_rates baud_rates[] = {
-				{ 921600, B921600 },
-				{ 460800, B460800 },
-				{ 230400, B230400 },
-				{ 115200, B115200 },
-				{  57600, B57600  },
-				{  38400, B38400  },
-				{  19200, B19200  },
-				{   9600, B9600   },
-				{   4800, B4800   },
-				{   2400, B2400   },
-				{   1200, B1200   },
-				{    600, B600    },
-				{    300, B300    },
-				{    200, B200    },
-				{    150, B150    },
-				{    134, B134    },
-				{    110, B110    },
-				{     75, B75     },
-				{     50, B50     },
-				{      0, B600	  }
-			};
+	} else {
+		int i;
+		unsigned int cflag;
+		static struct {
+			unsigned int rate;
+			unsigned int cflag;
+		} baud_rates[] = {
+			{ 921600, B921600 },
+			{ 460800, B460800 },
+			{ 230400, B230400 },
+			{ 115200, B115200 },
+			{  57600, B57600  },
+			{  38400, B38400  },
+			{  19200, B19200  },
+			{   9600, B9600   },
+			{   4800, B4800   },
+			{   2400, B2400   },
+			{   1200, B1200   },
+			{    600, B600    },
+			{    300, B300    },
+			{    200, B200    },
+			{    150, B150    },
+			{    134, B134    },
+			{    110, B110    },
+			{     75, B75     },
+			{     50, B50     },
+		};
 
-			baud = C_BAUD(ch->uart_port.info->tty);
-
-			for (i = 0; baud_rates[i].rate; i++) {
-				if (baud_rates[i].cflag == baud)
-					break;
+		cflag = C_BAUD(ch->uart_port.info->tty);
+		baud = 9600;
+		for (i = 0; i < ARRAY_SIZE(baud_rates); i++) {
+			if (baud_rates[i].cflag == cflag) {
+				baud = baud_rates[i].rate;
+				break;
 			}
-			baud = baud_rates[i].rate;
-
-			if (baud == 0)
-				baud = 9600;
-
-			if (ch->ch_flags & CH_BAUD0)
-				ch->ch_flags &= ~(CH_BAUD0);
 		}
 
+		if (ch->ch_flags & CH_BAUD0)
+			ch->ch_flags &= ~(CH_BAUD0);
+	}
+
 	if (ch->ch_c_cflag & PARENB)
 		lcr |= UART_LCR_PARITY;
 
_

