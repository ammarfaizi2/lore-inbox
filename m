Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWDUMl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWDUMl3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 08:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWDUMl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 08:41:29 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52707 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750838AbWDUMl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 08:41:28 -0400
X-Sasl-enc: 1k+ea0n+Xle2DMKgKD8k6LI7nNN+yM7nuT6e9YFCH/l4 1145623242
Message-ID: <4448D333.8050203@imap.cc>
Date: Fri, 21 Apr 2006 14:42:27 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       isdn4linux@listserv.isdn4linux.de, kai.germaschewski@gmx.de,
       kkeil@suse.de, fritz@isdn4linux.de,
       Michael.Hipp@student.uni-tuebingen.de
Subject: Re: [PATCH][resend] ISDN: unsafe interaction between isdn_write and
 isdn_writebuf_stub
References: <200604210006.31653.jesper.juhl@gmail.com> <20060420231432.6588aaf3.akpm@osdl.org>
In-Reply-To: <20060420231432.6588aaf3.akpm@osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5469897D5894A499FC009A4D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5469897D5894A499FC009A4D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On 21.04.2006 08:14, Andrew Morton wrote:
> It's simpler to code it this way:
[snip]
> But the code still looks wrong.  If isdn_writebuf_stub() does a short write, we'll
> just retry the entire write.  And if that returns the same short write, we'll
> retry the write again, ad infinitum.

You're right of course. But as i4l has never been able to handle that
case correctly, i4l drivers just don't do short writes, period. They
either return a negative error code, zero to indicate "not ready",
or the requested length. Every i4l driver author learns that very
quickly. (At least I did. ;-)

> One would expect that if a short write happened, we either bale out with an
> error or we advance partway through the buffer and write some more.

isdn_write() is the write method of i4l's character device. If a short
write would indeed occur, just passing it on to the caller should be
ok, too. So I'd propose the following, even simpler version:



From: Jesper Juhl <jesper.juhl@gmail.com>

isdn_writebuf_stub() forgets to detect memory allocation and uaccess errors.
And when that's fixed, if a error happens the caller will just keep on
looping.

So change the caller to detect the error, and to return it.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Karsten Keil <kkeil@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Tilman Schmidt <tilman@imap.cc>

---

 drivers/isdn/i4l/isdn_common.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN linux-2.6.17-rc2-orig/drivers/isdn/i4l/isdn_common.c linux-2.6.17-rc2-work/drivers/isdn/i4l/isdn_common.c
--- linux-2.6.17-rc2-orig/drivers/isdn/i4l/isdn_common.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17-rc2-work/drivers/isdn/i4l/isdn_common.c	2006-04-21 15:09:41.000000000 +0200
@@ -1177,9 +1177,8 @@ isdn_write(struct file *file, const char
 			goto out;
 		}
 		chidx = isdn_minor2chan(minor);
-		while (isdn_writebuf_stub(drvidx, chidx, buf, count) != count)
+		while ((retval = isdn_writebuf_stub(drvidx, chidx, buf, count)) == 0)
 			interruptible_sleep_on(&dev->drv[drvidx]->snd_waitq[chidx]);
-		retval = count;
 		goto out;
 	}
 	if (minor <= ISDN_MINOR_CTRLMAX) {
@@ -1951,9 +1950,10 @@ isdn_writebuf_stub(int drvidx, int chan,
 	struct sk_buff *skb = alloc_skb(hl + len, GFP_ATOMIC);

 	if (!skb)
-		return 0;
+		return -ENOMEM;
 	skb_reserve(skb, hl);
-	copy_from_user(skb_put(skb, len), buf, len);
+	if (!copy_from_user(skb_put(skb, len), buf, len))
+		return -EFAULT;
 	ret = dev->drv[drvidx]->interface->writebuf_skb(drvidx, chan, 1, skb);
 	if (ret <= 0)
 		dev_kfree_skb(skb);

-- 
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Reality is that which, when you stop believing in it, does not go
away. (Philip K. Dick)

--------------enig5469897D5894A499FC009A4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESNM7MdB4Whm86/kRAq6eAJ4jXmDcck0UK3qZLIyu9hoKsL8gMgCdHrrl
/RQB9TGUvAQJ9PJECOtUCos=
=JTMv
-----END PGP SIGNATURE-----

--------------enig5469897D5894A499FC009A4D--
