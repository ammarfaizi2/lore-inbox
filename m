Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129703AbRAWKBU>; Tue, 23 Jan 2001 05:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbRAWKBL>; Tue, 23 Jan 2001 05:01:11 -0500
Received: from mail.mojomofo.com ([208.248.233.19]:51728 "EHLO mojomofo.com")
	by vger.kernel.org with ESMTP id <S129485AbRAWKA4>;
	Tue, 23 Jan 2001 05:00:56 -0500
Message-ID: <01e901c08523$5b6af660$0300a8c0@methusela>
From: "Aaron Tiensivu" <mojomofo@mojomofo.com>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-ppp@vger.kernel.org>
Subject: [2.4.1-p10] Multilink PPP crash fix
Date: Tue, 23 Jan 2001 04:59:20 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01E6_01C084F9.3ECF4CB0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_01E6_01C084F9.3ECF4CB0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I took out my can of RAID and went bug hunting.
The kernel was always crashing in this subroutine and the comment near the
list walk clued me in.
I've run this fixed kernel all night and can no longer make it OOPS from a
racy list walk.

It may be overkill to use ppp_lock instead of the finer grained locks but it
works great so far
and I don't believe this routine gets called a lot.

---
Life is like a box of chocolates: Mass produced and usually stale.



------=_NextPart_000_01E6_01C084F9.3ECF4CB0
Content-Type: application/octet-stream;
	name="2.4.1-p10-mppp-fix.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="2.4.1-p10-mppp-fix.patch"

--- linux/drivers/net/ppp_generic.c.virgin	Mon Jan 22 02:37:42 2001=0A=
+++ linux/drivers/net/ppp_generic.c	Tue Jan 23 04:36:48 2001=0A=
@@ -1569,11 +1569,12 @@=0A=
 	struct sk_buff_head *list =3D &ppp->mrq;=0A=
 	u32 seq =3D skb->sequence;=0A=
 =0A=
-	/* N.B. we don't need to lock the list lock because we have the=0A=
-	   ppp unit receive-side lock. */=0A=
+	ppp_lock(ppp);=0A=
 	for (p =3D list->next; p !=3D (struct sk_buff *)list; p =3D p->next)=0A=
 		if (seq_before(seq, p->sequence))=0A=
 			break;=0A=
+	ppp_unlock(ppp);=0A=
+=0A=
 	__skb_insert(skb, p->prev, p, list);=0A=
 }=0A=
 =0A=

------=_NextPart_000_01E6_01C084F9.3ECF4CB0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
