Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbTBGPjA>; Fri, 7 Feb 2003 10:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbTBGPjA>; Fri, 7 Feb 2003 10:39:00 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:3343 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S265754AbTBGPi6>;
	Fri, 7 Feb 2003 10:38:58 -0500
Message-ID: <3E43D552.8010707@acm.org>
Date: Fri, 07 Feb 2003 09:48:34 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mauricio Martinez <mauricio@coe.neu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20 drivers/cdrom/cdu31a.c
References: <Pine.GSO.4.33.0302070833310.15863-100000@Amps.coe.neu.edu>
In-Reply-To: <Pine.GSO.4.33.0302070833310.15863-100000@Amps.coe.neu.edu>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020605070702070507000309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020605070702070507000309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I don't guess anyone I've sent documentation to has taken up support of 
this drive.  It's amazing that any of these things are still running, 
since I think they stop manufacturing them in 1994.  I don't think I 
have a machine that it will even work in any more.  I guess they were 
well-built drives.

The change you are suggesting is probably not the best, you probably 
need to fix it higher up to do multiple requests if nsect is > 4.  I've 
attached a patch.  It compiles, but I obviously can't test it.

Looking through the code, there's obvious SMP problems and a few other 
things.  I have a new machine with an ISA slot (I think), I might try to 
plug it in.

-Corey

Mauricio Martinez wrote:

>This patch fixes the kernel oops while trying to read a data CD. Thanks to
>Brian Gerst and Faik Uygur for your suggestions.
>
>It looks like the variable nblocks must be <= 4 so the read ahead buffer
>size is not exceeded (which is the cause of the oops). Changing its value
>doesn't seem to be the right way, but it makes the device work properly.
>
>Feedback of any sort welcome.
>
>  
>

--------------020605070702070507000309
Content-Type: text/plain;
 name="linux-cdu31a.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-cdu31a.diff"

--- drivers/cdrom/cdu31a.c.old	Fri Feb  7 09:16:08 2003
+++ drivers/cdrom/cdu31a.c	Fri Feb  7 09:42:53 2003
@@ -1341,7 +1341,7 @@
 #endif
 }
 
-/* read data from the drive.  Note the nsect must be <= 4. */
+/* read data from the drive.  Note the nblocks must be <= 4. */
 static void
 read_data_block(char *buffer,
 		unsigned int block,
@@ -1364,7 +1364,7 @@
 	bytesleft = nblocks * 512;
 	offset = 0;
 
-	/* If the data in the read-ahead does not match the block offset,
+	/* If the data in the read ahead does not match the block offset,
 	   then fix things up. */
 	if (((block % 4) * 512) != ((2048 - readahead_dataleft) % 2048)) {
 		sony_next_block += block % 4;
@@ -1384,9 +1384,9 @@
 			       readahead_buffer + (2048 -
 						   readahead_dataleft),
 			       readahead_dataleft);
-			readahead_dataleft = 0;
 			bytesleft -= readahead_dataleft;
 			offset += readahead_dataleft;
+			readahead_dataleft = 0;
 		} else {
 			/* The readahead will fill the whole buffer, get the data
 			   and return. */
@@ -1533,7 +1533,7 @@
 
 /*
  * The OS calls this to perform a read or write operation to the drive.
- * Write obviously fail.  Reads to a read ahead of sony_buffer_size
+ * Writes obviously fail.  Reads to a read ahead of sony_buffer_size
  * bytes to help speed operations.  This especially helps since the OS
  * uses 1024 byte blocks and the drive uses 2048 byte blocks.  Since most
  * data access on a CD is done sequentially, this saves a lot of operations.
@@ -1546,6 +1546,7 @@
 	unsigned int res_size;
 	int num_retries;
 	unsigned long flags;
+	char *buffer;
 
 
 #if DEBUG
@@ -1616,6 +1617,7 @@
 
 		block = CURRENT->sector;
 		nblock = CURRENT->nr_sectors;
+		buffer = CURRENT->buffer;
 
 		if (!sony_toc_read) {
 			printk("CDU31A: TOC not read\n");
@@ -1695,8 +1697,17 @@
 				}
 			}
 
-			read_data_block(CURRENT->buffer, block, nblock,
-					res_reg, &res_size);
+			if (nblock >= 4) {
+				read_data_block(buffer, block, 4,
+						res_reg, &res_size);
+				nblock -= 4;
+				block += 4;
+				buffer += 4 * 512;
+			} else {
+				read_data_block(buffer, block, nblock,
+						res_reg, &res_size);
+				nblock = 0;
+			}
 			if (res_reg[0] == 0x20) {
 				if (num_retries > MAX_CDU31A_RETRIES) {
 					end_request(0);
@@ -1714,6 +1725,8 @@
 					     translate_error(res_reg[1]),
 					     block, nblock);
 				}
+				goto try_read_again;
+			} else if (nblock > 0) {
 				goto try_read_again;
 			} else {
 				end_request(1);

--------------020605070702070507000309--

