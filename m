Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbSJSJb4>; Sat, 19 Oct 2002 05:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263016AbSJSJb4>; Sat, 19 Oct 2002 05:31:56 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1738 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265575AbSJSJbv>; Sat, 19 Oct 2002 05:31:51 -0400
Date: Sat, 19 Oct 2002 11:37:50 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix the compilation of drivers/bluetooth/bt3c_cs.c
Message-ID: <Pine.NEB.4.44.0210191134170.28761-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maksim,

your bluetooth patches in 2.5.44 caused the following compile error in
drivers/bluetooth/bt3c_cs.c that is fixed by the patch below:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/bluetooth/.bt3c_cs.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=bt3c_cs   -c -o
drivers/bluetooth/bt3c_cs.o drivers/bluetooth/bt3c_cs.c
drivers/bluetooth/bt3c_cs.c: In function `bt3c_receive':
drivers/bluetooth/bt3c_cs.c:321: `hci_event_hdr' undeclared (first use in
this function)
drivers/bluetooth/bt3c_cs.c:321: (Each undeclared identifier is reported
only once
drivers/bluetooth/bt3c_cs.c:321: for each function it appears in.)
drivers/bluetooth/bt3c_cs.c:321: `eh' undeclared (first use in this
function)
drivers/bluetooth/bt3c_cs.c:321: warning: statement with no effect
drivers/bluetooth/bt3c_cs.c:322: `hci_acl_hdr' undeclared (first use in
this function)
drivers/bluetooth/bt3c_cs.c:322: `ah' undeclared (first use in this
function)
drivers/bluetooth/bt3c_cs.c:322: warning: statement with no effect
drivers/bluetooth/bt3c_cs.c:323: `hci_sco_hdr' undeclared (first use in
this function)
drivers/bluetooth/bt3c_cs.c:323: `sh' undeclared (first use in this
function)
drivers/bluetooth/bt3c_cs.c:323: warning: statement with no effect
drivers/bluetooth/bt3c_cs.c:328: parse error before `)'
drivers/bluetooth/bt3c_cs.c:334: parse error before `)'
drivers/bluetooth/bt3c_cs.c:341: parse error before `)'
drivers/bluetooth/bt3c_cs.c:320: warning: `dlen' might be used
uninitialized in
this function
make[2]: *** [drivers/bluetooth/bt3c_cs.o] Error 1

<--  snip  -->


cu
Adrian

--- linux-2.5.44-full/drivers/bluetooth/bt3c_cs.c.old	2002-10-19 11:23:35.000000000 +0200
+++ linux-2.5.44-full/drivers/bluetooth/bt3c_cs.c	2002-10-19 11:24:44.000000000 +0200
@@ -318,27 +318,27 @@
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

