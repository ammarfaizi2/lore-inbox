Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbVLQVTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVLQVTF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 16:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbVLQVTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 16:19:05 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:7556 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S932507AbVLQVTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 16:19:04 -0500
Message-ID: <43A480C0.9080201@ru.mvista.com>
Date: Sun, 18 Dec 2005 00:18:56 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: [PATCH/RFC] SPI core: turn transfers to be linked list
Content-Type: multipart/mixed;
 boundary="------------090803040003070405040906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090803040003070405040906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greetings,

the patch attached changes the way transfers are chained in the SPI 
core. Namely, they are turned into linked lists instead of array. The 
reason behind is that we'd like to be able to use lightweight memory 
allocation  mechanism to use it in interrupt context. An example of such 
kind of mechanism can be found in spi-alloc.c file in our core. The 
lightweightness is achieved by the knowledge that all the blocks to be 
allocated are of the same size. We'd like to use this allocation 
technique for both message structure and transfer structure The problem 
with the current code is that transfers are represnted as an array so it 
can be of any size effectively.

Vitaly

--------------090803040003070405040906
Content-Type: text/plain;
 name="spi-list.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spi-list.patch"

diff -uNr a/drivers/spi/spi.c b/drivers/spi/spi.c
--- a/drivers/spi/spi.c	2005-12-17 22:13:13.947792000 +0300
+++ b/drivers/spi/spi.c	2005-12-17 22:29:07.283863088 +0300
@@ -535,7 +535,9 @@
 	static DECLARE_MUTEX(lock);
 
 	int			status;
-	struct spi_message	message;
+	struct spi_message	message = {
+		.transfers = LIST_HEAD_INIT(message.transfers);
+	};
 	struct spi_transfer	x[2];
 
 	/* Use preallocated DMA-safe buffer.  We can't avoid copying here,
@@ -551,13 +553,13 @@
 	memcpy(buf, txbuf, n_tx);
 	x[0].tx_buf = buf;
 	x[0].len = n_tx;
+	list_add_tail(&x[0].link, &message.transfers);
 
 	x[1].rx_buf = buf + n_tx;
 	x[1].len = n_rx;
+	list_add_tail(&x[1].link, &message.transfers);
 
 	/* do the i/o */
-	message.transfers = x;
-	message.n_transfer = ARRAY_SIZE(x);
 	status = spi_sync(spi, &message);
 	if (status == 0) {
 		memcpy(rxbuf, x[1].rx_buf, n_rx);
diff -uNr a/include/linux/spi/spi.h b/include/linux/spi/spi.h
--- a/include/linux/spi/spi.h	2005-12-17 22:13:13.957790000 +0300
+++ b/include/linux/spi/spi.h	2005-12-17 23:39:32.304562312 +0300
@@ -286,6 +286,8 @@
 
 	unsigned	cs_change:1;
 	u16		delay_usecs;
+
+	struct list_head link;
 };
 
 /**
@@ -304,8 +306,7 @@
  * @state: for use by whichever driver currently owns the message
  */
 struct spi_message {
-	struct spi_transfer	*transfers;
-	unsigned		n_transfer;
+	struct list_head	transfers;
 
 	struct spi_device	*spi;
 
@@ -406,16 +407,16 @@
 spi_write(struct spi_device *spi, const u8 *buf, size_t len)
 {
 	struct spi_transfer	t = {
-			.tx_buf		= buf,
-			.rx_buf		= NULL,
-			.len		= len,
-			.cs_change	= 0,
-		};
+		.tx_buf		= buf,
+		.rx_buf		= NULL,
+		.len		= len,
+		.cs_change	= 0,
+	};
 	struct spi_message	m = {
-			.transfers	= &t,
-			.n_transfer	= 1,
-		};
+		.transfers = LIST_HEAD_INIT(m.transfers);
+	};
 
+	list_add_tail(&t.link, &m.transfers);
 	return spi_sync(spi, &m);
 }
 
@@ -432,16 +433,16 @@
 spi_read(struct spi_device *spi, u8 *buf, size_t len)
 {
 	struct spi_transfer	t = {
-			.tx_buf		= NULL,
-			.rx_buf		= buf,
-			.len		= len,
-			.cs_change	= 0,
-		};
+		.tx_buf		= NULL,
+		.rx_buf		= buf,
+		.len		= len,
+		.cs_change	= 0,
+	};
 	struct spi_message	m = {
-			.transfers	= &t,
-			.n_transfer	= 1,
-		};
+		.transfers = LIST_HEAD_INIT(m.transfers);
+	};
 
+	list_add_tail(&t.link, &m.transfers);
 	return spi_sync(spi, &m);
 }
 

--------------090803040003070405040906--
