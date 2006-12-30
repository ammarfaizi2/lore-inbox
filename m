Return-Path: <linux-kernel-owner+w=401wt.eu-S1754514AbWL3N7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754514AbWL3N7m (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 08:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754529AbWL3N7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 08:59:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:37297 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754514AbWL3N7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 08:59:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=DS/flE59LrTnDZCf3oGHX0ZxsowIY+c9V/hkV9QGAYbDkFo5tL6kKx8ngbCK3orrA8g23BgMLzh4XFY0LIElOKMO8gd2U+4voGGPYedgOGfUt1smEWRiwZCq/SC0VwYU7V5XHqzoC/MFeb06J2HOpYFYlOssYgMfQ3AGDEoTIro=
Message-ID: <74d0deb30612300559y144427ebi45518e8f2edfb14d@mail.gmail.com>
Date: Sat, 30 Dec 2006 14:59:39 +0100
From: "pHilipp Zabel" <philipp.zabel@gmail.com>
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [patch 2.6.20-rc1 5/6] SA1100 GPIO wrappers
Cc: "Nicolas Pitre" <nico@cam.org>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Victor" <andrew@sanpeople.com>,
       "Bill Gatliff" <bgat@billgatliff.com>,
       "Haavard Skinnemoen" <hskinnemoen@atmel.com>,
       "Kevin Hilman" <khilman@mvista.com>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Tony Lindgren" <tony@atomide.com>
In-Reply-To: <200612292201.24989.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_115107_5697212.1167487179635"
References: <200611111541.34699.david-b@pacbell.net>
	 <200612291821.44675.david-b@pacbell.net>
	 <Pine.LNX.4.64.0612292141440.18171@xanadu.home>
	 <200612292201.24989.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_115107_5697212.1167487179635
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/30/06, David Brownell <david-b@pacbell.net> wrote:
> On Friday 29 December 2006 7:15 pm, Nicolas Pitre wrote:
> > On Fri, 29 Dec 2006, David Brownell wrote:
> >
> > > Here's a version that compiles ...
> >
> > This patch is completely broken.
>
> It's just what Philipp sent, with the "won't compile" bugs fixed.
> Oh, and some #include tweaks.  Philipp?

Corrected version attached. I also removed the out of line versions of
gpio_set/get_value.

> > and you most probably need to protect the implied read-modify-write
> > cycle with a spinlock unless the generic gpio API expects this
> > protection is the responsibility of the caller.
>
> No such lock is known to the caller.  Some of those calls will need
> to move to a C file somewhere.

Moved into generic.c

regards
Philipp

----------------------

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

Index: linux-2.6/include/asm-arm/arch-sa1100/gpio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/include/asm-arm/arch-sa1100/gpio.h	2006-12-30
14:43:49.000000000 +0100
@@ -0,0 +1,72 @@
+/*
+ * linux/include/asm-arm/arch-sa1100/gpio.h
+ *
+ * SA1100 GPIO wrappers for arch-neutral GPIO calls
+ *
+ * Written by Philipp Zabel <philipp.zabel@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+
+#ifndef __ASM_ARCH_SA1100_GPIO_H
+#define __ASM_ARCH_SA1100_GPIO_H
+
+#include <asm/hardware.h>
+#include <asm/irq.h>
+
+static inline int gpio_request(unsigned gpio, const char *label)
+{
+	return 0;
+}
+
+static inline void gpio_free(unsigned gpio)
+{
+	return;
+}
+
+#define gpio_direction_input sa1100_gpio_direction_output
+#define gpio_direction_output sa1100_gpio_direction_output
+
+static inline int gpio_get_value(unsigned gpio)
+{
+	return GPLR & GPIO_GPIO(gpio);
+}
+
+static inline void gpio_set_value(unsigned gpio, int value)
+{
+	if (value)
+		GPSR = GPIO_GPIO(gpio);
+	else
+		GPCR = GPIO_GPIO(gpio);
+}
+
+static inline unsigned gpio_to_irq(unsigned gpio)
+{
+	if (gpio < 11)
+		return IRQ_GPIO0 + gpio;
+	else
+		return IRQ_GPIO11 - 11 + gpio;
+}
+
+static inline unsigned irq_to_gpio(unsigned irq)
+{
+	if (irq < IRQ_GPIO11_27)
+		return irq - IRQ_GPIO0;
+	else
+		return irq - IRQ_GPIO11 + 11;
+}
+
+#endif /* __ASM_ARCH_SA1100_GPIO_H */
Index: linux-2.6/arch/arm/mach-sa1100/generic.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-sa1100/generic.c	2006-12-27
21:50:03.000000000 +0100
+++ linux-2.6/arch/arm/mach-sa1100/generic.c	2006-12-30 14:50:42.000000000 +0100
@@ -138,6 +138,36 @@
 	return v;
 }

+int sa1100_gpio_direction_input(unsigned gpio)
+{
+        unsigned long flags;
+
+	if (gpio > GPIO_MAX)
+		return -EINVAL;
+
+        local_irq_save(flags);
+	GPDR &= ~GPIO_GPIO(gpio);
+        local_irq_restore(flags);
+	return 0;
+}
+
+EXPORT_SYMBOL(sa1100_gpio_direction_input);
+
+int sa1100_gpio_direction_output(unsigned gpio)
+{
+        unsigned long flags;
+
+	if (gpio > GPIO_MAX)
+		return -EINVAL;
+
+        local_irq_save(flags);
+	GPDR |= GPIO_GPIO(gpio);
+        local_irq_restore(flags);
+	return 0;
+}
+
+EXPORT_SYMBOL(sa1100_gpio_direction_output);
+
 /*
  * Default power-off for SA1100
  */
Index: linux-2.6/include/asm-arm/arch-sa1100/hardware.h
===================================================================
--- linux-2.6.orig/include/asm-arm/arch-sa1100/hardware.h	2006-12-27
21:50:05.000000000 +0100
+++ linux-2.6/include/asm-arm/arch-sa1100/hardware.h	2006-12-30
14:43:30.000000000 +0100
@@ -48,6 +48,9 @@

 #endif

+extern int sa1100_gpio_direction_input(unsigned gpio);
+extern int sa1100_gpio_direction_output(unsigned gpio);
+
 #include "SA-1100.h"

 #ifdef CONFIG_SA1101

------=_Part_115107_5697212.1167487179635
Content-Type: text/x-patch; name=gpio-api-sa1100.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ewc3pk5s
Content-Disposition: attachment; filename="gpio-api-sa1100.patch"

SW5kZXg6IGxpbnV4LTIuNi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1zYTExMDAvZ3Bpby5oCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KLS0tIC9kZXYvbnVsbAkxOTcwLTAxLTAxIDAwOjAwOjAwLjAwMDAwMDAwMCArMDAwMAor
KysgbGludXgtMi42L2luY2x1ZGUvYXNtLWFybS9hcmNoLXNhMTEwMC9ncGlvLmgJMjAwNi0xMi0z
MCAxNDo0Mzo0OS4wMDAwMDAwMDAgKzAxMDAKQEAgLTAsMCArMSw3MiBAQAorLyoKKyAqIGxpbnV4
L2luY2x1ZGUvYXNtLWFybS9hcmNoLXNhMTEwMC9ncGlvLmgKKyAqCisgKiBTQTExMDAgR1BJTyB3
cmFwcGVycyBmb3IgYXJjaC1uZXV0cmFsIEdQSU8gY2FsbHMKKyAqCisgKiBXcml0dGVuIGJ5IFBo
aWxpcHAgWmFiZWwgPHBoaWxpcHAuemFiZWxAZ21haWwuY29tPgorICoKKyAqIFRoaXMgcHJvZ3Jh
bSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5
CisgKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
IGFzIHB1Ymxpc2hlZCBieQorICogdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVy
IHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqIChhdCB5b3VyIG9wdGlvbikgYW55IGxh
dGVyIHZlcnNpb24uCisgKgorICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBo
b3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7
IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogTUVSQ0hBTlRBQklMSVRZ
IG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiBTZWUgdGhlCisgKiBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqIFlvdSBzaG91bGQg
aGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisg
KiBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0
d2FyZQorICogRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJv
c3RvbiwgTUEgMDIxMTEtMTMwNyBVU0EKKyAqCisgKi8KKworI2lmbmRlZiBfX0FTTV9BUkNIX1NB
MTEwMF9HUElPX0gKKyNkZWZpbmUgX19BU01fQVJDSF9TQTExMDBfR1BJT19ICisKKyNpbmNsdWRl
IDxhc20vaGFyZHdhcmUuaD4KKyNpbmNsdWRlIDxhc20vaXJxLmg+CisKK3N0YXRpYyBpbmxpbmUg
aW50IGdwaW9fcmVxdWVzdCh1bnNpZ25lZCBncGlvLCBjb25zdCBjaGFyICpsYWJlbCkKK3sKKwly
ZXR1cm4gMDsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGdwaW9fZnJlZSh1bnNpZ25lZCBncGlv
KQoreworCXJldHVybjsKK30KKworI2RlZmluZSBncGlvX2RpcmVjdGlvbl9pbnB1dCBzYTExMDBf
Z3Bpb19kaXJlY3Rpb25fb3V0cHV0CisjZGVmaW5lIGdwaW9fZGlyZWN0aW9uX291dHB1dCBzYTEx
MDBfZ3Bpb19kaXJlY3Rpb25fb3V0cHV0CisKK3N0YXRpYyBpbmxpbmUgaW50IGdwaW9fZ2V0X3Zh
bHVlKHVuc2lnbmVkIGdwaW8pCit7CisJcmV0dXJuIEdQTFIgJiBHUElPX0dQSU8oZ3Bpbyk7Cit9
CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBncGlvX3NldF92YWx1ZSh1bnNpZ25lZCBncGlvLCBpbnQg
dmFsdWUpCit7CisJaWYgKHZhbHVlKQorCQlHUFNSID0gR1BJT19HUElPKGdwaW8pOworCWVsc2UK
KwkJR1BDUiA9IEdQSU9fR1BJTyhncGlvKTsKK30KKworc3RhdGljIGlubGluZSB1bnNpZ25lZCBn
cGlvX3RvX2lycSh1bnNpZ25lZCBncGlvKQoreworCWlmIChncGlvIDwgMTEpCisJCXJldHVybiBJ
UlFfR1BJTzAgKyBncGlvOworCWVsc2UKKwkJcmV0dXJuIElSUV9HUElPMTEgLSAxMSArIGdwaW87
Cit9CisKK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgaXJxX3RvX2dwaW8odW5zaWduZWQgaXJxKQor
eworCWlmIChpcnEgPCBJUlFfR1BJTzExXzI3KQorCQlyZXR1cm4gaXJxIC0gSVJRX0dQSU8wOwor
CWVsc2UKKwkJcmV0dXJuIGlycSAtIElSUV9HUElPMTEgKyAxMTsKK30KKworI2VuZGlmIC8qIF9f
QVNNX0FSQ0hfU0ExMTAwX0dQSU9fSCAqLwpJbmRleDogbGludXgtMi42L2FyY2gvYXJtL21hY2gt
c2ExMTAwL2dlbmVyaWMuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYub3JpZy9hcmNoL2FybS9t
YWNoLXNhMTEwMC9nZW5lcmljLmMJMjAwNi0xMi0yNyAyMTo1MDowMy4wMDAwMDAwMDAgKzAxMDAK
KysrIGxpbnV4LTIuNi9hcmNoL2FybS9tYWNoLXNhMTEwMC9nZW5lcmljLmMJMjAwNi0xMi0zMCAx
NDo1MDo0Mi4wMDAwMDAwMDAgKzAxMDAKQEAgLTEzOCw2ICsxMzgsMzYgQEAKIAlyZXR1cm4gdjsK
IH0KIAoraW50IHNhMTEwMF9ncGlvX2RpcmVjdGlvbl9pbnB1dCh1bnNpZ25lZCBncGlvKQorewor
ICAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOworCisJaWYgKGdwaW8gPiBHUElPX01BWCkKKwkJ
cmV0dXJuIC1FSU5WQUw7CisKKyAgICAgICAgbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOworCUdQRFIg
Jj0gfkdQSU9fR1BJTyhncGlvKTsKKyAgICAgICAgbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOwor
CXJldHVybiAwOworfQorCitFWFBPUlRfU1lNQk9MKHNhMTEwMF9ncGlvX2RpcmVjdGlvbl9pbnB1
dCk7CisKK2ludCBzYTExMDBfZ3Bpb19kaXJlY3Rpb25fb3V0cHV0KHVuc2lnbmVkIGdwaW8pCit7
CisgICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7CisKKwlpZiAoZ3BpbyA+IEdQSU9fTUFYKQor
CQlyZXR1cm4gLUVJTlZBTDsKKworICAgICAgICBsb2NhbF9pcnFfc2F2ZShmbGFncyk7CisJR1BE
UiB8PSBHUElPX0dQSU8oZ3Bpbyk7CisgICAgICAgIGxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsK
KwlyZXR1cm4gMDsKK30KKworRVhQT1JUX1NZTUJPTChzYTExMDBfZ3Bpb19kaXJlY3Rpb25fb3V0
cHV0KTsKKwogLyoKICAqIERlZmF1bHQgcG93ZXItb2ZmIGZvciBTQTExMDAKICAqLwpJbmRleDog
bGludXgtMi42L2luY2x1ZGUvYXNtLWFybS9hcmNoLXNhMTEwMC9oYXJkd2FyZS5oCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0tIGxpbnV4LTIuNi5vcmlnL2luY2x1ZGUvYXNtLWFybS9hcmNoLXNhMTEwMC9oYXJkd2Fy
ZS5oCTIwMDYtMTItMjcgMjE6NTA6MDUuMDAwMDAwMDAwICswMTAwCisrKyBsaW51eC0yLjYvaW5j
bHVkZS9hc20tYXJtL2FyY2gtc2ExMTAwL2hhcmR3YXJlLmgJMjAwNi0xMi0zMCAxNDo0MzozMC4w
MDAwMDAwMDAgKzAxMDAKQEAgLTQ4LDYgKzQ4LDkgQEAKIAogI2VuZGlmCiAKK2V4dGVybiBpbnQg
c2ExMTAwX2dwaW9fZGlyZWN0aW9uX2lucHV0KHVuc2lnbmVkIGdwaW8pOworZXh0ZXJuIGludCBz
YTExMDBfZ3Bpb19kaXJlY3Rpb25fb3V0cHV0KHVuc2lnbmVkIGdwaW8pOworCiAjaW5jbHVkZSAi
U0EtMTEwMC5oIgogCiAjaWZkZWYgQ09ORklHX1NBMTEwMQo=
------=_Part_115107_5697212.1167487179635--
