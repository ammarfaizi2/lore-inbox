Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbULZWyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbULZWyh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 17:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbULZWyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 17:54:37 -0500
Received: from mail.dif.dk ([193.138.115.101]:60573 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261177AbULZWy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 17:54:29 -0500
Date: Mon, 27 Dec 2004 00:05:25 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Tobias Ringstrom <tori@unhappy.mine.nu>
Cc: linux-net <linux-net@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Add a few casts to silence warnings in drivers/net/tulip/dmfe.c 
 (and change a single pointer variable type to match what it points to).
Message-ID: <Pine.LNX.4.61.0412262350360.3552@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I noticed these warnings when doing a allyesconfig build of 2.6.10 : 

drivers/net/tulip/dmfe.c:1809: warning: passing arg 1 of `__le16_to_cpup' from incompatible pointer type
drivers/net/tulip/dmfe.c:1821: warning: passing arg 1 of `__le32_to_cpup' from incompatible pointer type
drivers/net/tulip/dmfe.c:1821: warning: passing arg 1 of `__le32_to_cpup' from incompatible pointer type

the expected types are __le16* and __le32*, but the passed types are 
char*. I think it should be fine to just explicitly cast to the expected 
types, so that's what the patch below does. The patch also changes the 
type of the srom variable from char* to unsigned char* since the srom 
member of struct dmfe_board_info that it is initialized to point to is an 
array of unsigned char.

Patch is compile tested only as I have no hardware to do a proper test.
Please review, comment and apply (hopefully) :)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-orig/drivers/net/tulip/dmfe.c linux-2.6.10/drivers/net/tulip/dmfe.c
--- linux-2.6.10-orig/drivers/net/tulip/dmfe.c	2004-12-24 22:35:27.000000000 +0100
+++ linux-2.6.10/drivers/net/tulip/dmfe.c	2004-12-27 00:00:02.000000000 +0100
@@ -1794,7 +1794,7 @@ static u16 phy_read_1bit(unsigned long i
 
 static void dmfe_parse_srom(struct dmfe_board_info * db)
 {
-	char * srom = db->srom;
+	unsigned char *srom = db->srom;
 	int dmfe_mode, tmp_reg;
 
 	DMFE_DBUG(0, "dmfe_parse_srom() ", 0);
@@ -1806,7 +1806,7 @@ static void dmfe_parse_srom(struct dmfe_
 	if ( ( (int) srom[18] & 0xff) == SROM_V41_CODE) {
 		/* SROM V4.01 */
 		/* Get NIC support media mode */
-		db->NIC_capability = le16_to_cpup(srom + 34);
+		db->NIC_capability = le16_to_cpup((__le16 *)(srom + 34));
 		db->PHY_reg4 = 0;
 		for (tmp_reg = 1; tmp_reg < 0x10; tmp_reg <<= 1) {
 			switch( db->NIC_capability & tmp_reg ) {
@@ -1818,7 +1818,7 @@ static void dmfe_parse_srom(struct dmfe_
 		}
 
 		/* Media Mode Force or not check */
-		dmfe_mode = le32_to_cpup(srom + 34) & le32_to_cpup(srom + 36);
+		dmfe_mode = le32_to_cpup((__le32 *)(srom + 34)) & le32_to_cpup((__le32 *)(srom + 36));
 		switch(dmfe_mode) {
 		case 0x4: dmfe_media_mode = DMFE_100MHF; break;	/* 100MHF */
 		case 0x2: dmfe_media_mode = DMFE_10MFD; break;	/* 10MFD */



Please keep me in the CC loop on replies.


-- 
Jesper Juhl



