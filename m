Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWHRLjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWHRLjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWHRLjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:39:22 -0400
Received: from parabel.levigo.net ([62.206.214.16]:13748 "EHLO
	parabel.matrix.de") by vger.kernel.org with ESMTP id S964873AbWHRLjV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:39:21 -0400
Message-ID: <44E5A6DE.7090402@gdsys.de>
Date: Fri, 18 Aug 2006 13:39:10 +0200
From: Dirk Eibach <eibach@gdsys.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] char/moxa.c: fix endianess and multiple-card issues
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-5; AVE: 7.1.1.3; VDF: 6.35.1.112; host: mailrelay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dirk Eibach <eibach@gdsys.de>

While testing Moxa C218T/PCI on PowerPC 405EP I found that loading 
firmware using the linux kernel driver fails because calculation of the 
checksum is not endianess independent in the original code.

After I fixed this I found that uploading firmware in a system with 
multiple cards causes a kernel oops. I had a look in the recent moxa 
sources and found that they do some kind of locking there. Applying this 
lock fixed the problem.

This patch applies to kernel 2.6.16.

Signed-off-by: Dirk Eibach <eibach@gdsys.de>
---
--- linux-2.6.16/drivers/char/moxa.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-chameleon/drivers/char/moxa.c	2006-08-18 
13:21:59.000000000 +0200
@@ -143,6 +143,7 @@ typedef struct _moxa_board_conf {

  static moxa_board_conf moxa_boards[MAX_BOARDS];
  static void __iomem *moxaBaseAddr[MAX_BOARDS];
+static int loadstat[MAX_BOARDS]={0,0,0,0};

  struct moxa_str {
  	int type;
@@ -1690,6 +1691,8 @@ int MoxaDriverPoll(void)
  	if (moxaCard == 0)
  		return (-1);
  	for (card = 0; card < MAX_BOARDS; card++) {
+	        if(loadstat[card]==0)
+			continue;
  		if ((ports = moxa_boards[card].numPorts) == 0)
  			continue;
  		if (readb(moxaIntPend[card]) == 0xff) {
@@ -2905,6 +2908,7 @@ static int moxaloadcode(int cardno, unsi
  		}
  		break;
  	}
+	loadstat[cardno] = 1;
  	return (0);
  }

@@ -2922,7 +2926,7 @@ static int moxaloadc218(int cardno, void
  	len1 = len >> 1;
  	ptr = (ushort *) moxaBuff;
  	for (i = 0; i < len1; i++)
-		usum += *(ptr + i);
+		usum += le16_to_cpu(*(ptr + i));
  	retry = 0;
  	do {
  		len1 = len >> 1;
@@ -2994,7 +2998,7 @@ static int moxaloadc320(int cardno, void
  	wlen = len >> 1;
  	uptr = (ushort *) moxaBuff;
  	for (i = 0; i < wlen; i++)
-		usum += uptr[i];
+		usum += le16_to_cpu(uptr[i]);
  	retry = 0;
  	j = 0;
  	do {



