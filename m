Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbVILGk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbVILGk3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 02:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVILGk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 02:40:28 -0400
Received: from sinclair.provo.novell.com ([137.65.81.169]:20826 "EHLO
	sinclair.provo.novell.com") by vger.kernel.org with ESMTP
	id S1750811AbVILGk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 02:40:28 -0400
Message-Id: <43253F2E0200007800024DD4@sinclair.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 12 Sep 2005 00:41:18 -0600
From: "Jan Beulich" <JBeulich@novell.com>
To: <akpm@osdl.org>, "Dave Jones" <davej@redhat.com>
Cc: <zwane@holomorphy.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>, <zach@vmware.com>
Subject: Re: x86-fix-cmpxchg.patch added to -mm tree
References: <200509100006.j8A06rZm020089@shell0.pdx.osdl.net> <20050910003038.GH5283@redhat.com>
In-Reply-To: <20050910003038.GH5283@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part3311581E.4__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=__Part3311581E.4__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>>> Dave Jones <davej@redhat.com> 10.09.05 02:30:38 >>>
>On Fri, Sep 09, 2005 at 05:06:56PM -0700, Andrew Morton wrote:
>
> > - cmpxchg8b gets disabled when the minimum specified hardware
architectur
> >   doesn't support it (like was already happening for the byte,
word, and
> >   long ones).
> >
> > +config X86_CMPXCHG64
> > +	bool
> > +	depends on !M386 && !M486 && !MCYRIXIII && !MGEODEGX1
> > +	default y
>
>This is wrong.  All the Winchip/CyrixIII CPUs do indeed have cx8.
>Though cpuid will report that it's missing until We explicitly enable
>it in init_c3().  Whilst it's "disabled" however, the instruction
does
>run perfectly fine.   This was done because Win NT wouldn't boot if
it
>found a non Intel CPU which had cx8 iirc.
>
>I'm not familiar with the Geode enough to answer definitively.
>Alan seems to be the Geode-guru, and may still have datasheets for
that.

Resubmitting adjusted patch (taking into account also Alan's later
response).

(Note: Patch also attached because the inline version is certain to
get
line wrapped.)

This adjusts i386's cmpxchg patterns so that
- for word and long cmpxchg-es the compiler can utilize all possible
  registers
- cmpxchg8b gets disabled when the minimum specified hardware
architectur
  doesn't support it (like was already happening for the byte, word,
and
  long ones).

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/i386/Kconfig
2.6.13-i386-cmpxchg/arch/i386/Kconfig
--- 2.6.13/arch/i386/Kconfig	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-i386-cmpxchg/arch/i386/Kconfig	2005-09-01
11:45:29.000000000 +0200
@@ -412,6 +412,11 @@ config X86_POPAD_OK
 	depends on !M386
 	default y
 
+config X86_CMPXCHG64
+	bool
+	depends on !M386 && !M486
+	default y
+
 config X86_ALIGNMENT_16
 	bool
 	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII ||
X86_ELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2 ||
MGEODEGX1
diff -Npru 2.6.13/include/asm-i386/system.h
2.6.13-i386-cmpxchg/include/asm-i386/system.h
--- 2.6.13/include/asm-i386/system.h	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-i386-cmpxchg/include/asm-i386/system.h	2005-09-07
11:37:25.000000000 +0200
@@ -149,6 +149,8 @@ struct __xchg_dummy { unsigned long a[10
 #define __xg(x) ((struct __xchg_dummy *)(x))
 
 
+#ifdef CONFIG_X86_CMPXCHG64
+
 /*
  * The semantics of XCHGCMP8B are a bit strange, this is why
  * there is a loop and the loading of %%eax and %%edx has to
@@ -203,6 +205,8 @@ static inline void __set_64bit_var (unsi
  __set_64bit(ptr, (unsigned int)(value), (unsigned
int)((value)>>32ULL) ) : \
  __set_64bit(ptr, ll_low(value), ll_high(value)) )
 
+#endif
+
 /*
  * Note: no "lock" prefix even on SMP: xchg always implies lock
anyway
  * Note 2: xchg has side effect, so that attribute volatile is
necessary,
@@ -241,7 +245,6 @@ static inline unsigned long __xchg(unsig
 
 #ifdef CONFIG_X86_CMPXCHG
 #define __HAVE_ARCH_CMPXCHG 1
-#endif
 
 static inline unsigned long __cmpxchg(volatile void *ptr, unsigned
long old,
 				      unsigned long new, int size)
@@ -257,13 +260,13 @@ static inline unsigned long __cmpxchg(vo
 	case 2:
 		__asm__ __volatile__(LOCK_PREFIX "cmpxchgw %w1,%2"
 				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)),
"0"(old)
+				     : "r"(new), "m"(*__xg(ptr)),
"0"(old)
 				     : "memory");
 		return prev;
 	case 4:
 		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
 				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)),
"0"(old)
+				     : "r"(new), "m"(*__xg(ptr)),
"0"(old)
 				     : "memory");
 		return prev;
 	}
@@ -273,6 +276,30 @@ static inline unsigned long __cmpxchg(vo
 #define cmpxchg(ptr,o,n)\
 	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
 					(unsigned
long)(n),sizeof(*(ptr))))
+
+#endif
+
+#ifdef CONFIG_X86_CMPXCHG64
+
+static inline unsigned long long __cmpxchg64(volatile void *ptr,
unsigned long long old,
+				      unsigned long long new)
+{
+	unsigned long long prev;
+	__asm__ __volatile__(LOCK_PREFIX "cmpxchg8b %3"
+			     : "=A"(prev)
+			     : "b"((unsigned long)new),
+			       "c"((unsigned long)(new >> 32)),
+			       "m"(*__xg(ptr)),
+			       "0"(old)
+			     : "memory");
+	return prev;
+}
+
+#define cmpxchg64(ptr,o,n)\
+	((__typeof__(*(ptr)))__cmpxchg64((ptr),(unsigned long
long)(o),\
+					(unsigned long long)(n)))
+
+#endif
     
 #ifdef __KERNEL__
 struct alt_instr { 


--=__Part3311581E.4__=
Content-Type: application/octet-stream; name="linux-2.6.13-i386-cmpxchg.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-i386-cmpxchg.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKClRoaXMgYWRqdXN0cyBpMzg2J3MgY21weGNo
ZyBwYXR0ZXJucyBzbyB0aGF0Ci0gZm9yIHdvcmQgYW5kIGxvbmcgY21weGNoZy1lcyB0aGUgY29t
cGlsZXIgY2FuIHV0aWxpemUgYWxsIHBvc3NpYmxlCiAgcmVnaXN0ZXJzCi0gY21weGNoZzhiIGdl
dHMgZGlzYWJsZWQgd2hlbiB0aGUgbWluaW11bSBzcGVjaWZpZWQgaGFyZHdhcmUgYXJjaGl0ZWN0
dXIKICBkb2Vzbid0IHN1cHBvcnQgaXQgKGxpa2Ugd2FzIGFscmVhZHkgaGFwcGVuaW5nIGZvciB0
aGUgYnl0ZSwgd29yZCwgYW5kCiAgbG9uZyBvbmVzKS4KClNpZ25lZC1vZmYtYnk6IEphbiBCZXVs
aWNoIDxqYmV1bGljaEBub3ZlbGwuY29tPgoKZGlmZiAtTnBydSAyLjYuMTMvYXJjaC9pMzg2L0tj
b25maWcgMi42LjEzLWkzODYtY21weGNoZy9hcmNoL2kzODYvS2NvbmZpZwotLS0gMi42LjEzL2Fy
Y2gvaTM4Ni9LY29uZmlnCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAy
LjYuMTMtaTM4Ni1jbXB4Y2hnL2FyY2gvaTM4Ni9LY29uZmlnCTIwMDUtMDktMDEgMTE6NDU6Mjku
MDAwMDAwMDAwICswMjAwCkBAIC00MTIsNiArNDEyLDExIEBAIGNvbmZpZyBYODZfUE9QQURfT0sK
IAlkZXBlbmRzIG9uICFNMzg2CiAJZGVmYXVsdCB5CiAKK2NvbmZpZyBYODZfQ01QWENIRzY0CisJ
Ym9vbAorCWRlcGVuZHMgb24gIU0zODYgJiYgIU00ODYKKwlkZWZhdWx0IHkKKwogY29uZmlnIFg4
Nl9BTElHTk1FTlRfMTYKIAlib29sCiAJZGVwZW5kcyBvbiBNV0lOQ0hJUDNEIHx8IE1XSU5DSElQ
MiB8fCBNV0lOQ0hJUEM2IHx8IE1DWVJJWElJSSB8fCBYODZfRUxBTiB8fCBNSzYgfHwgTTU4Nk1N
WCB8fCBNNTg2VFNDIHx8IE01ODYgfHwgTTQ4NiB8fCBNVklBQzNfMiB8fCBNR0VPREVHWDEKZGlm
ZiAtTnBydSAyLjYuMTMvaW5jbHVkZS9hc20taTM4Ni9zeXN0ZW0uaCAyLjYuMTMtaTM4Ni1jbXB4
Y2hnL2luY2x1ZGUvYXNtLWkzODYvc3lzdGVtLmgKLS0tIDIuNi4xMy9pbmNsdWRlL2FzbS1pMzg2
L3N5c3RlbS5oCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMt
aTM4Ni1jbXB4Y2hnL2luY2x1ZGUvYXNtLWkzODYvc3lzdGVtLmgJMjAwNS0wOS0wNyAxMTozNzoy
NS4wMDAwMDAwMDAgKzAyMDAKQEAgLTE0OSw2ICsxNDksOCBAQCBzdHJ1Y3QgX194Y2hnX2R1bW15
IHsgdW5zaWduZWQgbG9uZyBhWzEwCiAjZGVmaW5lIF9feGcoeCkgKChzdHJ1Y3QgX194Y2hnX2R1
bW15ICopKHgpKQogCiAKKyNpZmRlZiBDT05GSUdfWDg2X0NNUFhDSEc2NAorCiAvKgogICogVGhl
IHNlbWFudGljcyBvZiBYQ0hHQ01QOEIgYXJlIGEgYml0IHN0cmFuZ2UsIHRoaXMgaXMgd2h5CiAg
KiB0aGVyZSBpcyBhIGxvb3AgYW5kIHRoZSBsb2FkaW5nIG9mICUlZWF4IGFuZCAlJWVkeCBoYXMg
dG8KQEAgLTIwMyw2ICsyMDUsOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgX19zZXRfNjRiaXRfdmFy
ICh1bnNpCiAgX19zZXRfNjRiaXQocHRyLCAodW5zaWduZWQgaW50KSh2YWx1ZSksICh1bnNpZ25l
ZCBpbnQpKCh2YWx1ZSk+PjMyVUxMKSApIDogXAogIF9fc2V0XzY0Yml0KHB0ciwgbGxfbG93KHZh
bHVlKSwgbGxfaGlnaCh2YWx1ZSkpICkKIAorI2VuZGlmCisKIC8qCiAgKiBOb3RlOiBubyAibG9j
ayIgcHJlZml4IGV2ZW4gb24gU01QOiB4Y2hnIGFsd2F5cyBpbXBsaWVzIGxvY2sgYW55d2F5CiAg
KiBOb3RlIDI6IHhjaGcgaGFzIHNpZGUgZWZmZWN0LCBzbyB0aGF0IGF0dHJpYnV0ZSB2b2xhdGls
ZSBpcyBuZWNlc3NhcnksCkBAIC0yNDEsNyArMjQ1LDYgQEAgc3RhdGljIGlubGluZSB1bnNpZ25l
ZCBsb25nIF9feGNoZyh1bnNpZwogCiAjaWZkZWYgQ09ORklHX1g4Nl9DTVBYQ0hHCiAjZGVmaW5l
IF9fSEFWRV9BUkNIX0NNUFhDSEcgMQotI2VuZGlmCiAKIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQg
bG9uZyBfX2NtcHhjaGcodm9sYXRpbGUgdm9pZCAqcHRyLCB1bnNpZ25lZCBsb25nIG9sZCwKIAkJ
CQkgICAgICB1bnNpZ25lZCBsb25nIG5ldywgaW50IHNpemUpCkBAIC0yNTcsMTMgKzI2MCwxMyBA
QCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgX19jbXB4Y2hnKHZvCiAJY2FzZSAyOgogCQlf
X2FzbV9fIF9fdm9sYXRpbGVfXyhMT0NLX1BSRUZJWCAiY21weGNoZ3cgJXcxLCUyIgogCQkJCSAg
ICAgOiAiPWEiKHByZXYpCi0JCQkJICAgICA6ICJxIihuZXcpLCAibSIoKl9feGcocHRyKSksICIw
IihvbGQpCisJCQkJICAgICA6ICJyIihuZXcpLCAibSIoKl9feGcocHRyKSksICIwIihvbGQpCiAJ
CQkJICAgICA6ICJtZW1vcnkiKTsKIAkJcmV0dXJuIHByZXY7CiAJY2FzZSA0OgogCQlfX2FzbV9f
IF9fdm9sYXRpbGVfXyhMT0NLX1BSRUZJWCAiY21weGNoZ2wgJTEsJTIiCiAJCQkJICAgICA6ICI9
YSIocHJldikKLQkJCQkgICAgIDogInEiKG5ldyksICJtIigqX194ZyhwdHIpKSwgIjAiKG9sZCkK
KwkJCQkgICAgIDogInIiKG5ldyksICJtIigqX194ZyhwdHIpKSwgIjAiKG9sZCkKIAkJCQkgICAg
IDogIm1lbW9yeSIpOwogCQlyZXR1cm4gcHJldjsKIAl9CkBAIC0yNzMsNiArMjc2LDMwIEBAIHN0
YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBfX2NtcHhjaGcodm8KICNkZWZpbmUgY21weGNoZyhw
dHIsbyxuKVwKIAkoKF9fdHlwZW9mX18oKihwdHIpKSlfX2NtcHhjaGcoKHB0ciksKHVuc2lnbmVk
IGxvbmcpKG8pLFwKIAkJCQkJKHVuc2lnbmVkIGxvbmcpKG4pLHNpemVvZigqKHB0cikpKSkKKwor
I2VuZGlmCisKKyNpZmRlZiBDT05GSUdfWDg2X0NNUFhDSEc2NAorCitzdGF0aWMgaW5saW5lIHVu
c2lnbmVkIGxvbmcgbG9uZyBfX2NtcHhjaGc2NCh2b2xhdGlsZSB2b2lkICpwdHIsIHVuc2lnbmVk
IGxvbmcgbG9uZyBvbGQsCisJCQkJICAgICAgdW5zaWduZWQgbG9uZyBsb25nIG5ldykKK3sKKwl1
bnNpZ25lZCBsb25nIGxvbmcgcHJldjsKKwlfX2FzbV9fIF9fdm9sYXRpbGVfXyhMT0NLX1BSRUZJ
WCAiY21weGNoZzhiICUzIgorCQkJICAgICA6ICI9QSIocHJldikKKwkJCSAgICAgOiAiYiIoKHVu
c2lnbmVkIGxvbmcpbmV3KSwKKwkJCSAgICAgICAiYyIoKHVuc2lnbmVkIGxvbmcpKG5ldyA+PiAz
MikpLAorCQkJICAgICAgICJtIigqX194ZyhwdHIpKSwKKwkJCSAgICAgICAiMCIob2xkKQorCQkJ
ICAgICA6ICJtZW1vcnkiKTsKKwlyZXR1cm4gcHJldjsKK30KKworI2RlZmluZSBjbXB4Y2hnNjQo
cHRyLG8sbilcCisJKChfX3R5cGVvZl9fKCoocHRyKSkpX19jbXB4Y2hnNjQoKHB0ciksKHVuc2ln
bmVkIGxvbmcgbG9uZykobyksXAorCQkJCQkodW5zaWduZWQgbG9uZyBsb25nKShuKSkpCisKKyNl
bmRpZgogICAgIAogI2lmZGVmIF9fS0VSTkVMX18KIHN0cnVjdCBhbHRfaW5zdHIgeyAK

--=__Part3311581E.4__=--
