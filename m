Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265579AbSJSJej>; Sat, 19 Oct 2002 05:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265580AbSJSJej>; Sat, 19 Oct 2002 05:34:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:64713 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265579AbSJSJef>; Sat, 19 Oct 2002 05:34:35 -0400
Date: Sat, 19 Oct 2002 11:40:34 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix the compilation of drivers/bluetooth/bluecard_cs.c
Message-ID: <Pine.NEB.4.44.0210191137530.28761-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maksim,

your bluetooth patches in 2.5.44 caused the following compile error in
drivers/bluetooth/bluecard_cs.c that is fixed by the patch below:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/bluetooth/.bluecard_cs.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-Iarch/i386/mach-generic
 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=bluecard_cs   -c -o drivers
/bluetooth/bluecard_cs.o drivers/bluetooth/bluecard_cs.c
drivers/bluetooth/bluecard_cs.c: In function `bluecard_receive':
drivers/bluetooth/bluecard_cs.c:459: `hci_event_hdr' undeclared (first use
in this function)
drivers/bluetooth/bluecard_cs.c:459: (Each undeclared identifier is
reported only once
drivers/bluetooth/bluecard_cs.c:459: for each function it appears in.)
drivers/bluetooth/bluecard_cs.c:459: `eh' undeclared (first use in this
function)
drivers/bluetooth/bluecard_cs.c:459: warning: statement with no effect
drivers/bluetooth/bluecard_cs.c:460: `hci_acl_hdr' undeclared (first use
in this function)
drivers/bluetooth/bluecard_cs.c:460: `ah' undeclared (first use in this
function)
drivers/bluetooth/bluecard_cs.c:460: warning: statement with no effect
drivers/bluetooth/bluecard_cs.c:461: `hci_sco_hdr' undeclared (first use
in this function)
drivers/bluetooth/bluecard_cs.c:461: `sh' undeclared (first use in this
function)
drivers/bluetooth/bluecard_cs.c:461: warning: statement with no effect
drivers/bluetooth/bluecard_cs.c:466: parse error before `)'
drivers/bluetooth/bluecard_cs.c:472: parse error before `)'
drivers/bluetooth/bluecard_cs.c:479: parse error before `)'
drivers/bluetooth/bluecard_cs.c:458: warning: `dlen' might be used
uninitialized in this function
make[2]: *** [drivers/bluetooth/bluecard_cs.o] Error 1

<--  snip  -->

cu
Adrian


--- linux-2.5.44-full/drivers/bluetooth/bluecard_cs.c.old	2002-10-19 11:31:32.000000000 +0200
+++ linux-2.5.44-full/drivers/bluetooth/bluecard_cs.c	2002-10-19 11:32:12.000000000 +0200
@@ -456,27 +456,27 @@
 			if (info->rx_count == 0) {

 				int dlen;
-				hci_event_hdr *eh;
-				hci_acl_hdr *ah;
-				hci_sco_hdr *sh;
+				struct hci_event_hdr *eh;
+				struct hci_acl_hdr *ah;
+				struct hci_sco_hdr *sh;

 				switch (info->rx_state) {

 				case RECV_WAIT_EVENT_HEADER:
-					eh = (hci_event_hdr *)(info->rx_skb->data);
+					eh = (struct hci_event_hdr *)(info->rx_skb->data);
 					info->rx_state = RECV_WAIT_DATA;
 					info->rx_count = eh->plen;
 					break;

 				case RECV_WAIT_ACL_HEADER:
-					ah = (hci_acl_hdr *)(info->rx_skb->data);
+					ah = (struct hci_acl_hdr *)(info->rx_skb->data);
 					dlen = __le16_to_cpu(ah->dlen);
 					info->rx_state = RECV_WAIT_DATA;
 					info->rx_count = dlen;
 					break;

 				case RECV_WAIT_SCO_HEADER:
-					sh = (hci_sco_hdr *)(info->rx_skb->data);
+					sh = (struct hci_sco_hdr *)(info->rx_skb->data);
 					info->rx_state = RECV_WAIT_DATA;
 					info->rx_count = sh->dlen;
 					break;

