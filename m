Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUHITgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUHITgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266891AbUHISzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:55:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:30870 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266850AbUHISvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:51:41 -0400
From: Hollis Blanchard <hollisb@us.ibm.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [RFC] Host Virtual Serial Interface driver
Date: Mon, 9 Aug 2004 13:46:56 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
References: <1091827384.31867.21.camel@localhost> <20040809105113.4923342d.rddunlap@osdl.org>
In-Reply-To: <20040809105113.4923342d.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408091346.56518.hollisb@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 August 2004 12:51, Randy.Dunlap wrote:
> 
> To the extent possible, we like to put the linux/* files in alpha
> order, and same with the asm/* files.  Separately, as you have them.

Ok.

> | #define __ALIGNED__	__attribute__((__aligned__(sizeof(long))))
>
> You should explain this bit (__ALIGNED__).

Ok.

> | static inline int hdrlen(const uint8_t *packet)
> | {
> | 	const int lengths[] = { 4, 6, 6, 8, };
> | 	struct hvsi_header *header = (struct hvsi_header *)packet;
> |
> | 	return lengths[VS_DATA_PACKET_HEADER - header->type];
> | }
>
> Any chance of bad data (value) in header->type ?

No, but I realized that was only being called from one place anyways, so this 
is simpler:

--- drivers/char/hvsi.c.lkml1   2004-08-09 13:34:22.000000000 -0500
+++ drivers/char/hvsi.c 2004-08-09 13:49:08.000000000 -0500
@@ -211,29 +211,11 @@
        spin_unlock_irqrestore(&hp->lock, flags);
 }

-static inline int hdrlen(const uint8_t *packet)
-{
-       const int lengths[] = { 4, 6, 6, 8, };
-       struct hvsi_header *header = (struct hvsi_header *)packet;
-
-       return lengths[VS_DATA_PACKET_HEADER - header->type];
-}
-
-static inline const uint8_t *payload(const uint8_t *packet)
-{
-       return packet + hdrlen(packet);
-}
-
 static inline int len_packet(const uint8_t *packet)
 {
        return (int)((struct hvsi_header *)packet)->len;
 }

-static inline int len_payload(const uint8_t *packet)
-{
-       return len_packet(packet) - hdrlen(packet);
-}
-
 static inline int is_header(const uint8_t *packet)
 {
        struct hvsi_header *header = (struct hvsi_header *)packet;
@@ -443,8 +425,9 @@
 static struct tty_struct *hvsi_recv_data(struct hvsi_struct *hp,
                const uint8_t *packet)
 {
-       const uint8_t *data = payload(packet);
-       int datalen = len_payload(packet);
+       const struct hvsi_header *header = (const struct hvsi_header *)packet;
+       const uint8_t *data = packet + sizeof(struct hvsi_header);
+       int datalen = header->len - sizeof(struct hvsi_header);
        int overflow = datalen - TTY_THRESHOLD_THROTTLE;

        pr_debug("queueing %i chars '%.*s'\n", datalen, datalen, data);

(And yes, header->len is guaranteed to be ok by the got_packet() check in the 
caller.)

> | 		if (hangup) {
> | 			tty_hangup(hangup);
> | 		}
>
> extra braces (style); maybe in a few other places also.

Ok.

-- 
Hollis Blanchard
IBM Linux Technology Center
