Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932669AbVIHPMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbVIHPMN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbVIHPMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:12:12 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:2659
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932663AbVIHPMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:12:10 -0400
Message-Id: <4320712A0200007800024469@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:13:14 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix i386 cmpxchg
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part44662A1A.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part44662A1A.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
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
+	depends on !M386 && !M486 && !MCYRIXIII && !MGEODEGX1
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


--=__Part44662A1A.0__=
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
Ym9vbAorCWRlcGVuZHMgb24gIU0zODYgJiYgIU00ODYgJiYgIU1DWVJJWElJSSAmJiAhTUdFT0RF
R1gxCisJZGVmYXVsdCB5CisKIGNvbmZpZyBYODZfQUxJR05NRU5UXzE2CiAJYm9vbAogCWRlcGVu
ZHMgb24gTVdJTkNISVAzRCB8fCBNV0lOQ0hJUDIgfHwgTVdJTkNISVBDNiB8fCBNQ1lSSVhJSUkg
fHwgWDg2X0VMQU4gfHwgTUs2IHx8IE01ODZNTVggfHwgTTU4NlRTQyB8fCBNNTg2IHx8IE00ODYg
fHwgTVZJQUMzXzIgfHwgTUdFT0RFR1gxCmRpZmYgLU5wcnUgMi42LjEzL2luY2x1ZGUvYXNtLWkz
ODYvc3lzdGVtLmggMi42LjEzLWkzODYtY21weGNoZy9pbmNsdWRlL2FzbS1pMzg2L3N5c3RlbS5o
Ci0tLSAyLjYuMTMvaW5jbHVkZS9hc20taTM4Ni9zeXN0ZW0uaAkyMDA1LTA4LTI5IDAxOjQxOjAx
LjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLWkzODYtY21weGNoZy9pbmNsdWRlL2FzbS1pMzg2
L3N5c3RlbS5oCTIwMDUtMDktMDcgMTE6Mzc6MjUuMDAwMDAwMDAwICswMjAwCkBAIC0xNDksNiAr
MTQ5LDggQEAgc3RydWN0IF9feGNoZ19kdW1teSB7IHVuc2lnbmVkIGxvbmcgYVsxMAogI2RlZmlu
ZSBfX3hnKHgpICgoc3RydWN0IF9feGNoZ19kdW1teSAqKSh4KSkKIAogCisjaWZkZWYgQ09ORklH
X1g4Nl9DTVBYQ0hHNjQKKwogLyoKICAqIFRoZSBzZW1hbnRpY3Mgb2YgWENIR0NNUDhCIGFyZSBh
IGJpdCBzdHJhbmdlLCB0aGlzIGlzIHdoeQogICogdGhlcmUgaXMgYSBsb29wIGFuZCB0aGUgbG9h
ZGluZyBvZiAlJWVheCBhbmQgJSVlZHggaGFzIHRvCkBAIC0yMDMsNiArMjA1LDggQEAgc3RhdGlj
IGlubGluZSB2b2lkIF9fc2V0XzY0Yml0X3ZhciAodW5zaQogIF9fc2V0XzY0Yml0KHB0ciwgKHVu
c2lnbmVkIGludCkodmFsdWUpLCAodW5zaWduZWQgaW50KSgodmFsdWUpPj4zMlVMTCkgKSA6IFwK
ICBfX3NldF82NGJpdChwdHIsIGxsX2xvdyh2YWx1ZSksIGxsX2hpZ2godmFsdWUpKSApCiAKKyNl
bmRpZgorCiAvKgogICogTm90ZTogbm8gImxvY2siIHByZWZpeCBldmVuIG9uIFNNUDogeGNoZyBh
bHdheXMgaW1wbGllcyBsb2NrIGFueXdheQogICogTm90ZSAyOiB4Y2hnIGhhcyBzaWRlIGVmZmVj
dCwgc28gdGhhdCBhdHRyaWJ1dGUgdm9sYXRpbGUgaXMgbmVjZXNzYXJ5LApAQCAtMjQxLDcgKzI0
NSw2IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBfX3hjaGcodW5zaWcKIAogI2lmZGVm
IENPTkZJR19YODZfQ01QWENIRwogI2RlZmluZSBfX0hBVkVfQVJDSF9DTVBYQ0hHIDEKLSNlbmRp
ZgogCiBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgX19jbXB4Y2hnKHZvbGF0aWxlIHZvaWQg
KnB0ciwgdW5zaWduZWQgbG9uZyBvbGQsCiAJCQkJICAgICAgdW5zaWduZWQgbG9uZyBuZXcsIGlu
dCBzaXplKQpAQCAtMjU3LDEzICsyNjAsMTMgQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25n
IF9fY21weGNoZyh2bwogCWNhc2UgMjoKIAkJX19hc21fXyBfX3ZvbGF0aWxlX18oTE9DS19QUkVG
SVggImNtcHhjaGd3ICV3MSwlMiIKIAkJCQkgICAgIDogIj1hIihwcmV2KQotCQkJCSAgICAgOiAi
cSIobmV3KSwgIm0iKCpfX3hnKHB0cikpLCAiMCIob2xkKQorCQkJCSAgICAgOiAiciIobmV3KSwg
Im0iKCpfX3hnKHB0cikpLCAiMCIob2xkKQogCQkJCSAgICAgOiAibWVtb3J5Iik7CiAJCXJldHVy
biBwcmV2OwogCWNhc2UgNDoKIAkJX19hc21fXyBfX3ZvbGF0aWxlX18oTE9DS19QUkVGSVggImNt
cHhjaGdsICUxLCUyIgogCQkJCSAgICAgOiAiPWEiKHByZXYpCi0JCQkJICAgICA6ICJxIihuZXcp
LCAibSIoKl9feGcocHRyKSksICIwIihvbGQpCisJCQkJICAgICA6ICJyIihuZXcpLCAibSIoKl9f
eGcocHRyKSksICIwIihvbGQpCiAJCQkJICAgICA6ICJtZW1vcnkiKTsKIAkJcmV0dXJuIHByZXY7
CiAJfQpAQCAtMjczLDYgKzI3NiwzMCBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgX19j
bXB4Y2hnKHZvCiAjZGVmaW5lIGNtcHhjaGcocHRyLG8sbilcCiAJKChfX3R5cGVvZl9fKCoocHRy
KSkpX19jbXB4Y2hnKChwdHIpLCh1bnNpZ25lZCBsb25nKShvKSxcCiAJCQkJCSh1bnNpZ25lZCBs
b25nKShuKSxzaXplb2YoKihwdHIpKSkpCisKKyNlbmRpZgorCisjaWZkZWYgQ09ORklHX1g4Nl9D
TVBYQ0hHNjQKKworc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGxvbmcgX19jbXB4Y2hnNjQo
dm9sYXRpbGUgdm9pZCAqcHRyLCB1bnNpZ25lZCBsb25nIGxvbmcgb2xkLAorCQkJCSAgICAgIHVu
c2lnbmVkIGxvbmcgbG9uZyBuZXcpCit7CisJdW5zaWduZWQgbG9uZyBsb25nIHByZXY7CisJX19h
c21fXyBfX3ZvbGF0aWxlX18oTE9DS19QUkVGSVggImNtcHhjaGc4YiAlMyIKKwkJCSAgICAgOiAi
PUEiKHByZXYpCisJCQkgICAgIDogImIiKCh1bnNpZ25lZCBsb25nKW5ldyksCisJCQkgICAgICAg
ImMiKCh1bnNpZ25lZCBsb25nKShuZXcgPj4gMzIpKSwKKwkJCSAgICAgICAibSIoKl9feGcocHRy
KSksCisJCQkgICAgICAgIjAiKG9sZCkKKwkJCSAgICAgOiAibWVtb3J5Iik7CisJcmV0dXJuIHBy
ZXY7Cit9CisKKyNkZWZpbmUgY21weGNoZzY0KHB0cixvLG4pXAorCSgoX190eXBlb2ZfXygqKHB0
cikpKV9fY21weGNoZzY0KChwdHIpLCh1bnNpZ25lZCBsb25nIGxvbmcpKG8pLFwKKwkJCQkJKHVu
c2lnbmVkIGxvbmcgbG9uZykobikpKQorCisjZW5kaWYKICAgICAKICNpZmRlZiBfX0tFUk5FTF9f
CiBzdHJ1Y3QgYWx0X2luc3RyIHsgCg==

--=__Part44662A1A.0__=--
