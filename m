Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261806AbSIXVZO>; Tue, 24 Sep 2002 17:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261808AbSIXVZO>; Tue, 24 Sep 2002 17:25:14 -0400
Received: from packet.digeo.com ([12.110.80.53]:45233 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261806AbSIXVZM> convert rfc822-to-8bit;
	Tue, 24 Sep 2002 17:25:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: CDCether.c
Date: Tue, 24 Sep 2002 14:30:21 -0700
Message-ID: <4C568C6A13479744AA1EA3E97EEEB3231B7DEF@schumi.digeo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CDCether.c
Thread-Index: AcJgIgnus42w3vBdT82TaaICKg2DqwD7v1Dw
From: "Michael Duane" <Mike.Duane@digeo.com>
To: "Brad Hards" <bhards@bigpond.net.au>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Think I found the problem.  The following patch is generated on the
2.5.36 code base.  Seems that the ^ will only work where skb->len
is <= ether_dev->data_ep_out_size. (ether_dev->data_ep_out_size is
64 on my modem).

Mike

--- linux-2.5.36/drivers/usb/net/cdc-ether.c	Tue Sep 17 17:58:43 2002
+++ patched/drivers/usb/net/cdc-ether.c	Tue Sep 24 14:24:55 2002
@@ -276,7 +276,7 @@
 	// into an integer number of USB packets, we force it to send one 
 	// more byte so the device will get a runt USB packet signalling the 
 	// end of the ethernet frame
-	if ( (skb->len) ^ (ether_dev->data_ep_out_size) ) {
+	if ( (skb->len) % (ether_dev->data_ep_out_size) ) {
 		// It was not an exact multiple
 		// no need to add anything extra
 		count = skb->len;

> -----Original Message-----
> From: Brad Hards [mailto:bhards@bigpond.net.au]
> Sent: Thursday, September 19, 2002 2:12 PM
> To: Michael Duane; linux-kernel@vger.kernel.org
> Subject: Re: CDCether.c
> 
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Fri, 20 Sep 2002 01:22, Michael Duane wrote:
> > No, this is quite different. It appears to be a function of packet
> > size. ping -s <size> <host> will generate packet loss up to 100
> > percent with any size of (86+(64*n)).  All other values work fine.
> > tcpdump on the linux side sees multiple packet retries with
> > correct back-off timeing, but the network side never sees the
> > packet. Now for the odd part - any network activity on another
> > session to the same box will free the "wedged" packet and the
> > network will recieve the last packet sent in the linux retry
> > sequence.
> Ahh, maybe a missing zero length packet problem.  I'll take 
> another look.
> 
> Brad
> 
> 
> - -- 
> http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. 
> Birds in Black.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.6 (GNU/Linux)
> Comment: For info see http://www.gnupg.org
> 
> iD8DBQE9ij2RW6pHgIdAuOMRAmgqAJwPPipMhYxO2QQ0L1VB6yXJtbX8GQCdGpvw
> mWRRiqjOTJUmYWsXLyghSgo=
> =LRBZ
> -----END PGP SIGNATURE-----
> 
> 
