Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVC2L7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVC2L7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVC2L5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:57:50 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:21001 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262254AbVC2Lz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:55:26 -0500
Date: Tue, 29 Mar 2005 12:55:11 +0100 (BST)
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
In-Reply-To: <20050329103504.GA19468@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.58.0503291252030.22838@phoenix.infradead.org>
References: <1111766900.4566.20.camel@sauron.oktetlabs.ru>
 <20050326044421.GA24358@gondor.apana.org.au> <1112030556.17983.35.camel@sauron.oktetlabs.ru>
 <20050329103504.GA19468@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1456859747-1136616773-1112097311=:22838"
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dedekind@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1456859747-1136616773-1112097311=:22838
Content-Type: TEXT/PLAIN; charset=US-ASCII

> Are you sure that 12 bytes is enough for all cases? It would seem
> to be safer to use the formula in deflateBound/compressBound from
> later versions (> 1.2) of zlib to calculate the reserve.
>
I'm not sure. David Woodhouse (the author) said that this is probably 
enough in any case but a lot of time has gone since the code was written 
and he doesn't remember for sure. I have also seen some magic number "12" 
somewhere in zlib, but I'm not sure.

At least my practice shows that 12 is Ok for JFFS2 where we compress fewer 
then 4K a a time. I'll explore this.

> We normally put the operator on the preceding line, i.e.,
>
> while (foo &&
>        bar) {
If this is the the common practice for Linux, then OK. My argument is the 
GNU Coding style which recommends:

----------------------------------------------------------------------
When you split an expression into multiple lines, split it before an 
operator, not after one. Here is the right way:

     if (foo_this_is_long && bar > win (x, y, z)
         && remaining_condition)
----------------------------------------------------------------------

while the Linux coding style doesn't mention this AFAIR. And of course, 
Linux doesn't have to obey that rule. 

Ok. This is not the final patch but more like RFC and I can re-format and 
re-send it. :-) Please, feel free to re-format it as you would like 
yourself.

And one more thing I wanted to offer. In the 
deflate_[compress|uncompress|pcompress] functions we call the 
zlib_[in|de]flateReset function at the beginning. This is OK. But when we 
unload the deflate module we don't call zlib_[in|de]flateEnd to free all 
the zlib internal data. It looks like a bug for me. Please, consider the 
attached patch.

--
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
--1456859747-1136616773-1112097311=:22838
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="streamEnd-1.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0503291255110.22838@phoenix.infradead.org>
Content-Description: 
Content-Disposition: attachment; filename="streamEnd-1.diff"

ZGlmZiAtYXVOcnAgbGludXgtMi42LjExLjUvY3J5cHRvL2RlZmxhdGUuYyBs
aW51eC0yLjYuMTEuNV9jaGFuZ2VkL2NyeXB0by9kZWZsYXRlLmMNCi0tLSBs
aW51eC0yLjYuMTEuNS9jcnlwdG8vZGVmbGF0ZS5jCTIwMDUtMDMtMjkgMTU6
Mzc6NDQuMDAwMDAwMDAwICswNDAwDQorKysgbGludXgtMi42LjExLjVfY2hh
bmdlZC9jcnlwdG8vZGVmbGF0ZS5jCTIwMDUtMDMtMjkgMTU6Mzc6MzguMDAw
MDAwMDAwICswNDAwDQpAQCAtOTMsMTEgKzkzLDEzIEBAIG91dF9mcmVlOg0K
IA0KIHN0YXRpYyB2b2lkIGRlZmxhdGVfY29tcF9leGl0KHN0cnVjdCBkZWZs
YXRlX2N0eCAqY3R4KQ0KIHsNCisJemxpYl9kZWZsYXRlRW5kKCZjdHgtPmNv
bXBfc3RyZWFtKTsNCiAJdmZyZWUoY3R4LT5jb21wX3N0cmVhbS53b3Jrc3Bh
Y2UpOw0KIH0NCiANCiBzdGF0aWMgdm9pZCBkZWZsYXRlX2RlY29tcF9leGl0
KHN0cnVjdCBkZWZsYXRlX2N0eCAqY3R4KQ0KIHsNCisJemxpYl9pbmZsYXRl
RW5kKCZjdHgtPmRlY29tcF9zdHJlYW0pOw0KIAlrZnJlZShjdHgtPmRlY29t
cF9zdHJlYW0ud29ya3NwYWNlKTsNCiB9DQogDQo=

--1456859747-1136616773-1112097311=:22838--
