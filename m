Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267269AbUG2VaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267269AbUG2VaK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267438AbUG2V2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:28:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44260 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267269AbUG2VYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:24:19 -0400
Date: Thu, 29 Jul 2004 23:24:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: sten_wang@davicom.com.tw, Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, tulip-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [2.6 patch] net/tulip/dmfe.c: fix inline compile errors (fwd)
Message-ID: <20040729212411.GG23589@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:
The patch forwarded below is still required in 2.6.8-rc2-mm1.


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Thu, 15 Jul 2004 00:03:25 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: sten_wang@davicom.com.tw
Cc: jgarzik@pobox.com, tulip-users@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [2.6 patch] net/tulip/dmfe.c: fix inline compile errors

Trying to compile drivers/net/tulip/dmfe.c in 2.6.8-rc1-mm1 using
gcc 3.4 results in the following compile error:

<--  snip  -->

...
  CC      drivers/net/tulip/dmfe.o
drivers/net/tulip/dmfe.c: In function `dmfe_rx_packet':
drivers/net/tulip/dmfe.c:323: sorry, unimplemented: inlining failed in 
call to 'cal_CRC': function body not available
drivers/net/tulip/dmfe.c:936: sorry, unimplemented: called from here
make[3]: *** [drivers/net/tulip/dmfe.o] Error 1

<--  snip  -->


The patch below moves an inlined function above the place where it is 
called the first time.


diffstat output:
 drivers/net/tulip/dmfe.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc1-mm1-full-3.4/drivers/net/tulip/dmfe.c.old	2004-07-14 23:55:07.000000000 +0200
+++ linux-2.6.8-rc1-mm1-full-3.4/drivers/net/tulip/dmfe.c	2004-07-14 23:55:40.000000000 +0200
@@ -314,13 +314,13 @@
 static u8 dmfe_sense_speed(struct dmfe_board_info *);
 static void dmfe_process_mode(struct dmfe_board_info *);
 static void dmfe_timer(unsigned long);
+static inline u32 cal_CRC(unsigned char *, unsigned int, u8);
 static void dmfe_rx_packet(struct DEVICE *, struct dmfe_board_info *);
 static void dmfe_free_tx_pkt(struct DEVICE *, struct dmfe_board_info *);
 static void dmfe_reuse_skb(struct dmfe_board_info *, struct sk_buff *);
 static void dmfe_dynamic_reset(struct DEVICE *);
 static void dmfe_free_rxbuffer(struct dmfe_board_info *);
 static void dmfe_init_dm910x(struct DEVICE *);
-static inline u32 cal_CRC(unsigned char *, unsigned int, u8);
 static void dmfe_parse_srom(struct dmfe_board_info *);
 static void dmfe_program_DM9801(struct dmfe_board_info *, int);
 static void dmfe_program_DM9802(struct dmfe_board_info *);
@@ -885,6 +885,20 @@
 
 
 /*
+ *	Calculate the CRC valude of the Rx packet
+ *	flag = 	1 : return the reverse CRC (for the received packet CRC)
+ *		0 : return the normal CRC (for Hash Table index)
+ */
+
+static inline u32 cal_CRC(unsigned char * Data, unsigned int Len, u8 flag)
+{
+	u32 crc = crc32(~0, Data, Len);
+	if (flag) crc = ~crc;
+	return crc;
+}
+
+
+/*
  *	Receive the come packet and pass to upper layer
  */
 
@@ -1774,20 +1788,6 @@
 
 
 /*
- *	Calculate the CRC valude of the Rx packet
- *	flag = 	1 : return the reverse CRC (for the received packet CRC)
- *		0 : return the normal CRC (for Hash Table index)
- */
-
-static inline u32 cal_CRC(unsigned char * Data, unsigned int Len, u8 flag)
-{
-	u32 crc = crc32(~0, Data, Len);
-	if (flag) crc = ~crc;
-	return crc;
-}
-
-
-/*
  *	Parser SROM and media mode
  */
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

