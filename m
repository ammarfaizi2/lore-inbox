Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVFPTJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVFPTJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 15:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVFPTJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 15:09:49 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:40602 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261792AbVFPTJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 15:09:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=eFEN1qEWixsd6KsVK7fmJsLy2G1sBdoJ/Zt6v3HEwjm8XX0tiw2oa9eGjMfplzJzu/hf5merKVMXFC11XHekWfz35ZpYp0cQROjr7Ej5yan3ek3+b5wJ/s7cbJ0rwj734giKI7DHyZx+gzqaFUF/PnwU8poxYtUNIcUsd7C3p7Q=
Message-ID: <9a87484905061612091470147f@mail.gmail.com>
Date: Thu, 16 Jun 2005 21:09:42 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: [PATCH] fix gcc -W warning in netdevice.h
Cc: Jesper Juhl <juhl-lkml@dif.dk>, LKML <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       "Donald J. Becker" <becker@cesdis.gsfc.nasa.gov>,
       Alan Cox <Alan.Cox@linux.org>, Bjorn Ekwall <bj0rn@blox.se>,
       Pekka Riikonen <priikone@poseidon.pspt.fi>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <17073.9865.218749.808736@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1334_31484794.1118948982009"
References: <Pine.LNX.4.62.0506160053210.3842@dragon.hyggekrogen.localhost>
	 <17073.9865.218749.808736@alkaid.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1334_31484794.1118948982009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 6/16/05, Mikael Pettersson <mikpe@csd.uu.se> wrote:
> Jesper Juhl writes:
>  > --- linux-2.6.12-rc6-mm1-orig/include/linux/netdevice.h      2005-06-1=
2 15:58:58.000000000 +0200
>  > +++ linux-2.6.12-rc6-mm1/include/linux/netdevice.h   2005-06-16 00:52:=
14.000000000 +0200
>  > @@ -778,7 +778,7 @@ enum {
>  >  static inline u32 netif_msg_init(int debug_value, int default_msg_ena=
ble_bits)
>  >  {
>  >      /* use default */
>  > -    if (debug_value < 0 || debug_value >=3D (sizeof(u32) * 8))
>  > +    if (debug_value < 0 || debug_value >=3D (int)(sizeof(u32) * 8))
>  >              return default_msg_enable_bits;
>=20
> I'd change debug_value to unsigned, and drop the "< 0" test and the
> now redundant "(int)" cast. Both cleaner and faster. Win Win :-)

Hmm, yes, even if some caller is currently passing negative values
those values would (when implicitly converted to unsigned) have a
value significantly greater than (sizeof(u32) * 8), so the first if
statement would still be true and the function would then still behave
exactely the same... nice.

Here's a patch.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 include/linux/netdevice.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
      --- linux-2.6.12-rc6-mm1-orig/include/linux/netdevice.h=092005-06-12
15:58:58.000000000 +0200
+++ linux-2.6.12-rc6-mm1/include/linux/netdevice.h=092005-06-16
21:08:18.000000000 +0200
@@ -775,10 +775,10 @@ enum {
 #define netif_msg_hw(p)=09=09((p)->msg_enable & NETIF_MSG_HW)
 #define netif_msg_wol(p)=09((p)->msg_enable & NETIF_MSG_WOL)
=20
-static inline u32 netif_msg_init(int debug_value, int default_msg_enable_b=
its)
+static inline u32 netif_msg_init(unsigned int debug_value, int
default_msg_enable_bits)
 {
 =09/* use default */
-=09if (debug_value < 0 || debug_value >=3D (sizeof(u32) * 8))
+=09if (debug_value >=3D (sizeof(u32) * 8))
 =09=09return default_msg_enable_bits;
 =09if (debug_value =3D=3D 0)=09/* no output */
 =09=09return 0;


(patch also attached since gmail tends to mangle inline patches - grrr)

--=20
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_1334_31484794.1118948982009
Content-Type: text/x-patch; name="netdevice_h-signed-vs-unsigned-2.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="netdevice_h-signed-vs-unsigned-2.patch"

LS0tIGxpbnV4LTIuNi4xMi1yYzYtbW0xLW9yaWcvaW5jbHVkZS9saW51eC9uZXRkZXZpY2UuaAky
MDA1LTA2LTEyIDE1OjU4OjU4LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjEyLXJjNi1t
bTEvaW5jbHVkZS9saW51eC9uZXRkZXZpY2UuaAkyMDA1LTA2LTE2IDIxOjA4OjE4LjAwMDAwMDAw
MCArMDIwMApAQCAtNzc1LDEwICs3NzUsMTAgQEAgZW51bSB7CiAjZGVmaW5lIG5ldGlmX21zZ19o
dyhwKQkJKChwKS0+bXNnX2VuYWJsZSAmIE5FVElGX01TR19IVykKICNkZWZpbmUgbmV0aWZfbXNn
X3dvbChwKQkoKHApLT5tc2dfZW5hYmxlICYgTkVUSUZfTVNHX1dPTCkKIAotc3RhdGljIGlubGlu
ZSB1MzIgbmV0aWZfbXNnX2luaXQoaW50IGRlYnVnX3ZhbHVlLCBpbnQgZGVmYXVsdF9tc2dfZW5h
YmxlX2JpdHMpCitzdGF0aWMgaW5saW5lIHUzMiBuZXRpZl9tc2dfaW5pdCh1bnNpZ25lZCBpbnQg
ZGVidWdfdmFsdWUsIGludCBkZWZhdWx0X21zZ19lbmFibGVfYml0cykKIHsKIAkvKiB1c2UgZGVm
YXVsdCAqLwotCWlmIChkZWJ1Z192YWx1ZSA8IDAgfHwgZGVidWdfdmFsdWUgPj0gKHNpemVvZih1
MzIpICogOCkpCisJaWYgKGRlYnVnX3ZhbHVlID49IChzaXplb2YodTMyKSAqIDgpKQogCQlyZXR1
cm4gZGVmYXVsdF9tc2dfZW5hYmxlX2JpdHM7CiAJaWYgKGRlYnVnX3ZhbHVlID09IDApCS8qIG5v
IG91dHB1dCAqLwogCQlyZXR1cm4gMDsK
------=_Part_1334_31484794.1118948982009--
