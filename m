Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288800AbSBDInn>; Mon, 4 Feb 2002 03:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288788AbSBDIne>; Mon, 4 Feb 2002 03:43:34 -0500
Received: from mgw-x1.nokia.com ([131.228.20.21]:14019 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S288781AbSBDIn1>;
	Mon, 4 Feb 2002 03:43:27 -0500
Message-ID: <3C5E4991.6010707@nokia.com>
Date: Mon, 04 Feb 2002 10:42:57 +0200
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011023
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
CC: affix-devel@lists.sourceforge.net,
        Affix support <affix-support@lists.sourceforge.net>,
        Bluetooth-Drivers-for-Linux 
	<Bluetooth-Drivers-for-Linux@research.nokia.com>,
        NRC-WALLET DL <DL.NRC-WALLET@nokia.com>,
        linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: New Affix Release: Affix-0_9
In-Reply-To: <3C500D09.4080206@nokia.com> <3C5AB093.5050405@nokia.com>
Content-Type: multipart/mixed;
 boundary="------------010607060701090807080003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010607060701090807080003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here is small patch. Apply it for Affix-0_9
Otherwise RFCOMM will not work.

br, Dmitry

Dmitry Kasatkin wrote:

> Hi,
>
> Find new affix release Affix-0_9pre10 on
> http://affix.sourceforge.net
>
> Version 0.9 [01.02.2002]
>
> !!! NOTES
>    Do not patch the kernel with this version.
>    Patch will be available soon
>
> - btctl shows all available devices in the system
>  btctl -i bt0
>  "-i" this options is used to handle certain devices
> - btuarto changed by btuart.o & btuart_cs.o
>  btctl open_uart /dev/ttyS0
>  btctl close_uart /dev/ttyS0
>  commands are use to open Bluetooth adapters having UART interface
> - Added HCI socket (internally used only now)
>  BTPROTO_HCI
> - Added some object locks
> - Added btsdp_browse
>  Use
>  btsdp_browse <bda | local>
>  to browse SDP server data base
>
>
> br, Dmitry
>


-- 
 Dmitry Kasatkin
 Nokia Research Center / Helsinki
 Mobile: +358 50 4836365
 E-Mail: dmitry.kasatkin@nokia.com



--------------010607060701090807080003
Content-Type: text/plain;
 name="patch-Affix-0_9fix1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-Affix-0_9fix1"

diff -ur Affix-0_9/kernel/btcore/af_hci.c affix/kernel/btcore/af_hci.c
--- Affix-0_9/kernel/btcore/af_hci.c	Fri Feb  1 14:56:59 2002
+++ affix/kernel/btcore/af_hci.c	Mon Feb  4 09:46:07 2002
@@ -19,7 +19,7 @@
 */
 
 /* 
-   $Id: af_hci.c,v 2.15 2002/02/01 12:56:59 kds Exp $
+   $Id: af_hci.c,v 2.17 2002/02/04 07:46:07 kds Exp $
 
    AF_AFFIX - HCI Protocol Address family for socket interface
 
@@ -499,6 +499,7 @@
 	}
 
 	hsk->hci = hci;
+	hsk->evl->hci = hci;
 
 	DBFEXIT;
 	return err;
diff -ur Affix-0_9/kernel/btcore/l2cap.c affix/kernel/btcore/l2cap.c
--- Affix-0_9/kernel/btcore/l2cap.c	Fri Feb  1 16:16:26 2002
+++ affix/kernel/btcore/l2cap.c	Mon Feb  4 09:50:40 2002
@@ -19,7 +19,7 @@
 */
 
 /* 
-   $Id: l2cap.c,v 2.38 2002/02/01 14:16:26 kds Exp $
+   $Id: l2cap.c,v 2.40 2002/02/04 07:50:40 kds Exp $
 
    Link Layer Control and Adaptation Protocol
 
@@ -1248,6 +1248,8 @@
 	if( !hcc_linkup(ch->con) )
 		return 0;
 
+	ch->hdrlen = con->hdrlen + L2CAP_HDR_LEN;
+
 	if( STATE(ch) == CHN_CLOSED ) {
 		ENTERSTATE(ch, CHN_W4_L2CAP_CRSP);
 		l2cap_connect_req(ch->con, get_id(ch), ch->psm, ch->lcid);
@@ -1364,7 +1366,7 @@
 		err = -ENOTCONN;
 		goto exit;
 	}
-
+	DBPRT(DBXMITE, "Headroom is: %d\n", skb_headroom(skb));
 	send_data(ch, skb);
 
  exit:
diff -ur Affix-0_9/kernel/btcore/rfcomm.c affix/kernel/btcore/rfcomm.c
--- Affix-0_9/kernel/btcore/rfcomm.c	Fri Jan 25 15:17:13 2002
+++ affix/kernel/btcore/rfcomm.c	Mon Feb  4 10:33:22 2002
@@ -19,7 +19,7 @@
 */
 
 /* 
-   $Id: rfcomm.c,v 2.53 2002/01/25 13:17:13 kds Exp $
+   $Id: rfcomm.c,v 2.54 2002/02/04 08:33:22 kds Exp $
 
    RFCOMM - RFCOMM protocol for Bluetooth
 
@@ -330,6 +330,8 @@
 	if( !rfcomm_connected(sn) )
 		return 0;
 
+	con->hdrlen = sn->hdrlen + LONG_HDR_SIZE + 1;
+
 	if( STATE(con) == RFCON_CLOSED ) {
 		ENTERSTATE(con, RFCON_W4_CONRSP);
 		con->dlci |= (!sn->initiator & 0x01);	/* set session bit */
@@ -610,6 +612,8 @@
 		while( con && IS_DEAD(con) )
 			con = BTL_NEXT(con);
 		if( con ) {
+			con->hdrlen = sn->hdrlen + LONG_HDR_SIZE + 1;
+
 			/* FIXME: check state here */
 			con->credit_based = 1;
 			con->pops->control_ind(con, TYPE_REQUEST, NULL);/* FIXME: ?? */
@@ -620,6 +624,8 @@
 		rfcomm_con	*next;
 		btl_for_each_next(con, sn->cons, next)
 			if( status == 0 ) {
+				con->hdrlen = sn->hdrlen + LONG_HDR_SIZE + 1;
+
 				if( STATE(con) == RFCON_CLOSED ) {
 					ENTERSTATE(con, RFCON_W4_CONRSP);
 					con->dlci |= (!sn->initiator & 0x01);/* session bit */
diff -ur Affix-0_9/kernel/include/affix/rfcomm.h affix/kernel/include/affix/rfcomm.h
--- Affix-0_9/kernel/include/affix/rfcomm.h	Fri Jan 25 16:25:58 2002
+++ affix/kernel/include/affix/rfcomm.h	Mon Feb  4 10:33:22 2002
@@ -19,7 +19,7 @@
 */
 
 /* 
-   $Id: rfcomm.h,v 1.21 2002/01/25 14:25:58 kds Exp $
+   $Id: rfcomm.h,v 1.24 2002/02/04 08:33:22 kds Exp $
 
    RFCOMM - RFCOMM protocol for Bluetooth
 
@@ -169,10 +169,10 @@
 	u8		value[0];
 }__PACK__ mcc_frame;
 
-typedef struct cmd_msg {
+typedef struct cmd_frame {
 	short_frame 	short_pkt;
 	mcc_frame 	mcc_pkt;
-}__PACK__ cmd_msg;
+}__PACK__ cmd_frame;
 
 
 /* Multiplexer Control Channel Commands */
@@ -720,7 +720,7 @@
 extern inline struct sk_buff *rfcomm_alloc_cmd_skb(rfcomm_sn *sn, int cmdlen)
 {
 	struct sk_buff	*skb;
-	int		hdrlen = sn->hdrlen + sizeof(cmd_msg);
+	int		hdrlen = sn->hdrlen + sizeof(cmd_frame);
 
 	if( cmdlen+sizeof(mcc_frame) > SHORT_PAYLOAD_SIZE )
 		hdrlen++;

--------------010607060701090807080003--

