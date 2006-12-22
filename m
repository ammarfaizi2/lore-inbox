Return-Path: <linux-kernel-owner+w=401wt.eu-S1945954AbWLVHRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945954AbWLVHRD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 02:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945955AbWLVHRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 02:17:03 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:1672 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945953AbWLVHRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 02:17:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=TZ8wV8dbKY5kAC8aMWUsuRdsr9kEMnFm8ZNmReAnkC5xR21PZ+POL0sA2B5o6o32hdfZTPlB50M0ygncnk0k8Tj4p44rehSEXy6pCyTUE3aCCTvgkVILQ6S5Z/vPxSWwbqNE84U5PVNiGPW+glrjBWqfVJYlxmbVc+FRfBPSeHw=
Message-ID: <74d0deb30612212316i12090ca0hfe8524a80f63475a@mail.gmail.com>
Date: Fri, 22 Dec 2006 08:16:58 +0100
From: "pHilipp Zabel" <philipp.zabel@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [patch 2.6.20-rc1 5/6] SA1100 GPIO wrappers
Cc: "David Brownell" <david-b@pacbell.net>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Victor" <andrew@sanpeople.com>,
       "Bill Gatliff" <bgat@billgatliff.com>,
       "Haavard Skinnemoen" <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       "Kevin Hilman" <khilman@mvista.com>, "Nicolas Pitre" <nico@cam.org>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Tony Lindgren" <tony@atomide.com>
In-Reply-To: <20061220221328.ee3bfc5d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_43919_19015539.1166771818655"
References: <200611111541.34699.david-b@pacbell.net>
	 <200612201304.03912.david-b@pacbell.net>
	 <200612201313.22572.david-b@pacbell.net>
	 <20061220221328.ee3bfc5d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_43919_19015539.1166771818655
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/21/06, Andrew Morton <akpm@osdl.org> wrote:
> On Wed, 20 Dec 2006 13:13:21 -0800
> David Brownell <david-b@pacbell.net> wrote:
>
> > +#define gpio_get_value(gpio) \
> > +     (GPLR & GPIO_GPIO(gpio))
> > +
> > +#define gpio_set_value(gpio,value) \
> > +     ((value) ? (GPSR = GPIO_GPIO(gpio)) : (GPCR(gpio) = GPIO_GPIO(gpio)))
>
> likewise.

I have done the same to the SA1100 wrappers as to the PXA wrappers now.
Maybe the non-inline functions in generic.c are overkill for those much simpler
macros on SA...

regards
Philipp

Index: linux-2.6/include/asm-arm/arch-sa1100/gpio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/include/asm-arm/arch-sa1100/gpio.h	2006-12-22
08:07:08.000000000 +0100
@@ -0,0 +1,95 @@
+/*
+ * linux/include/asm-arm/arch-pxa/gpio.h
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
+#include <asm/arch/hardware.h>
+#include <asm/arch/irqs.h>
+
+#include <asm/errno.h>
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
+static inline int gpio_direction_input(unsigned gpio)
+{
+	if (gpio > GPIO_MAX)
+		return -EINVAL;
+	GPDR = (GPDR_In << gpio);
+}
+
+static inline int gpio_direction_output(unsigned gpio)
+{
+	if (gpio > GPIO_MAX)
+		return -EINVAL;
+	GPDR = (GPDR_Out << gpio);
+}
+
+static inline int __gpio_get_value(unsigned gpio)
+{
+	return GPLR & GPIO_GPIO(gpio);
+}
+
+#define gpio_get_value(gpio)			\
+	(__builtin_constant_p(gpio) ?		\
+	 __gpioe_get_value(gpio) :		\
+	 sa1100_gpio_get_value(gpio))
+
+static inline void __gpio_set_value(unsigned gpio, int value)
+{
+	if (value)
+		GPSR = GPIO_GPIO(gpio);
+	else
+		GPCR = GPIO_GPIO(gpio);
+}
+
+#define gpio_set_value(gpio,value)		\
+	(__builtin_constant_p(gpio) ?		\
+	 __gpio_set_value(gpio, value) :	\
+	 sa1100_gpio_set_value(gpio, value))
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
+#endif
Index: linux-2.6/arch/arm/mach-sa1100/generic.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-sa1100/generic.c	2006-12-22
07:57:46.000000000 +0100
+++ linux-2.6/arch/arm/mach-sa1100/generic.c	2006-12-22 08:12:51.000000000 +0100
@@ -28,6 +28,8 @@
 #include <asm/mach/flash.h>
 #include <asm/irq.h>

+#include <asm/arch/gpio.h>
+
 #include "generic.h"

 #define NR_FREQS	16
@@ -139,6 +141,26 @@
 }

 /*
+ * Return GPIO level
+ */
+int sa1100_gpio_get_value(unsigned gpio)
+{
+	return __gpio_get_value(gpio);
+}
+
+EXPORT_SYMBOL(sa1100_gpio_get_value);
+
+/*
+ * Set output GPIO level
+ */
+void sa1100_gpio_set_value(unsigned gpio, int value)
+{
+	__gpio_set_value(gpio, value);
+}
+
+EXPORT_SYMBOL(sa1100_gpio_set_value);
+
+/*
  * Default power-off for SA1100
  */
 static void sa1100_power_off(void)
Index: linux-2.6/include/asm-arm/arch-sa1100/hardware.h
===================================================================
--- linux-2.6.orig/include/asm-arm/arch-sa1100/hardware.h	2006-12-22
07:58:13.000000000 +0100
+++ linux-2.6/include/asm-arm/arch-sa1100/hardware.h	2006-12-22
08:02:23.000000000 +0100
@@ -48,6 +48,16 @@

 #endif

+/*
+ * Return GPIO level, nonzero means high, zero is low
+ */
+extern int sa1100_gpio_get_value(unsigned gpio);
+
+/*
+ * Set output GPIO level
+ */
+void sa1100_gpio_set_value(unsigned gpio, int value);
+
 #include "SA-1100.h"

 #ifdef CONFIG_SA1101

------=_Part_43919_19015539.1166771818655
Content-Type: text/x-patch; name=gpio-api-sa1100.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ew09qqow
Content-Disposition: attachment; filename="gpio-api-sa1100.patch"

SW5kZXg6IGxpbnV4LTIuNi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1zYTExMDAvZ3Bpby5oCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KLS0tIC9kZXYvbnVsbAkxOTcwLTAxLTAxIDAwOjAwOjAwLjAwMDAwMDAwMCArMDAwMAor
KysgbGludXgtMi42L2luY2x1ZGUvYXNtLWFybS9hcmNoLXNhMTEwMC9ncGlvLmgJMjAwNi0xMi0y
MiAwODowNzowOC4wMDAwMDAwMDAgKzAxMDAKQEAgLTAsMCArMSw5NSBAQAorLyoKKyAqIGxpbnV4
L2luY2x1ZGUvYXNtLWFybS9hcmNoLXB4YS9ncGlvLmgKKyAqCisgKiBTQTExMDAgR1BJTyB3cmFw
cGVycyBmb3IgYXJjaC1uZXV0cmFsIEdQSU8gY2FsbHMKKyAqCisgKiBXcml0dGVuIGJ5IFBoaWxp
cHAgWmFiZWwgPHBoaWxpcHAuemFiZWxAZ21haWwuY29tPgorICoKKyAqIFRoaXMgcHJvZ3JhbSBp
cyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5Cisg
KiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFz
IHB1Ymxpc2hlZCBieQorICogdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZl
cnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyAqIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVy
IHZlcnNpb24uCisgKgorICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3Bl
IHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdp
dGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogTUVSQ0hBTlRBQklMSVRZIG9y
IEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiBTZWUgdGhlCisgKiBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqIFlvdSBzaG91bGQgaGF2
ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiBh
bG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2Fy
ZQorICogRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3Rv
biwgTUEgMDIxMTEtMTMwNyBVU0EKKyAqCisgKi8KKworI2lmbmRlZiBfX0FTTV9BUkNIX1NBMTEw
MF9HUElPX0gKKyNkZWZpbmUgX19BU01fQVJDSF9TQTExMDBfR1BJT19ICisKKyNpbmNsdWRlIDxh
c20vYXJjaC9oYXJkd2FyZS5oPgorI2luY2x1ZGUgPGFzbS9hcmNoL2lycXMuaD4KKworI2luY2x1
ZGUgPGFzbS9lcnJuby5oPgorCitzdGF0aWMgaW5saW5lIGludCBncGlvX3JlcXVlc3QodW5zaWdu
ZWQgZ3BpbywgY29uc3QgY2hhciAqbGFiZWwpCit7CisJcmV0dXJuIDA7Cit9CisKK3N0YXRpYyBp
bmxpbmUgdm9pZCBncGlvX2ZyZWUodW5zaWduZWQgZ3BpbykKK3sKKwlyZXR1cm47Cit9CisKK3N0
YXRpYyBpbmxpbmUgaW50IGdwaW9fZGlyZWN0aW9uX2lucHV0KHVuc2lnbmVkIGdwaW8pCit7CisJ
aWYgKGdwaW8gPiBHUElPX01BWCkKKwkJcmV0dXJuIC1FSU5WQUw7CisJR1BEUiA9IChHUERSX0lu
IDw8IGdwaW8pOworfQorCitzdGF0aWMgaW5saW5lIGludCBncGlvX2RpcmVjdGlvbl9vdXRwdXQo
dW5zaWduZWQgZ3BpbykKK3sKKwlpZiAoZ3BpbyA+IEdQSU9fTUFYKQorCQlyZXR1cm4gLUVJTlZB
TDsKKwlHUERSID0gKEdQRFJfT3V0IDw8IGdwaW8pOworfQorCitzdGF0aWMgaW5saW5lIGludCBf
X2dwaW9fZ2V0X3ZhbHVlKHVuc2lnbmVkIGdwaW8pCit7CisJcmV0dXJuIEdQTFIgJiBHUElPX0dQ
SU8oZ3Bpbyk7Cit9CisKKyNkZWZpbmUgZ3Bpb19nZXRfdmFsdWUoZ3BpbykJCQlcCisJKF9fYnVp
bHRpbl9jb25zdGFudF9wKGdwaW8pID8JCVwKKwkgX19ncGlvZV9nZXRfdmFsdWUoZ3BpbykgOgkJ
XAorCSBzYTExMDBfZ3Bpb19nZXRfdmFsdWUoZ3BpbykpCisKK3N0YXRpYyBpbmxpbmUgdm9pZCBf
X2dwaW9fc2V0X3ZhbHVlKHVuc2lnbmVkIGdwaW8sIGludCB2YWx1ZSkKK3sKKwlpZiAodmFsdWUp
CisJCUdQU1IgPSBHUElPX0dQSU8oZ3Bpbyk7CisJZWxzZQorCQlHUENSID0gR1BJT19HUElPKGdw
aW8pOworfQorCisjZGVmaW5lIGdwaW9fc2V0X3ZhbHVlKGdwaW8sdmFsdWUpCQlcCisJKF9fYnVp
bHRpbl9jb25zdGFudF9wKGdwaW8pID8JCVwKKwkgX19ncGlvX3NldF92YWx1ZShncGlvLCB2YWx1
ZSkgOglcCisJIHNhMTEwMF9ncGlvX3NldF92YWx1ZShncGlvLCB2YWx1ZSkpCisKK3N0YXRpYyBp
bmxpbmUgdW5zaWduZWQgZ3Bpb190b19pcnEodW5zaWduZWQgZ3BpbykKK3sKKwlpZiAoZ3BpbyA8
IDExKQorCQlyZXR1cm4gSVJRX0dQSU8wICsgZ3BpbzsKKwllbHNlCisJCXJldHVybiBJUlFfR1BJ
TzExIC0gMTEgKyBncGlvOworfQorCitzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGlycV90b19ncGlv
KHVuc2lnbmVkIGlycSkKK3sKKwlpZiAoaXJxIDwgSVJRX0dQSU8xMV8yNykKKwkJcmV0dXJuIGly
cSAtIElSUV9HUElPMDsKKwllbHNlCisJCXJldHVybiBpcnEgLSBJUlFfR1BJTzExICsgMTE7Cit9
CisKKyNlbmRpZgpJbmRleDogbGludXgtMi42L2FyY2gvYXJtL21hY2gtc2ExMTAwL2dlbmVyaWMu
Ywo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYub3JpZy9hcmNoL2FybS9tYWNoLXNhMTEwMC9nZW5l
cmljLmMJMjAwNi0xMi0yMiAwNzo1Nzo0Ni4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi9h
cmNoL2FybS9tYWNoLXNhMTEwMC9nZW5lcmljLmMJMjAwNi0xMi0yMiAwODoxMjo1MS4wMDAwMDAw
MDAgKzAxMDAKQEAgLTI4LDYgKzI4LDggQEAKICNpbmNsdWRlIDxhc20vbWFjaC9mbGFzaC5oPgog
I2luY2x1ZGUgPGFzbS9pcnEuaD4KIAorI2luY2x1ZGUgPGFzbS9hcmNoL2dwaW8uaD4KKwogI2lu
Y2x1ZGUgImdlbmVyaWMuaCIKIAogI2RlZmluZSBOUl9GUkVRUwkxNgpAQCAtMTM5LDYgKzE0MSwy
NiBAQAogfQogCiAvKgorICogUmV0dXJuIEdQSU8gbGV2ZWwKKyAqLworaW50IHNhMTEwMF9ncGlv
X2dldF92YWx1ZSh1bnNpZ25lZCBncGlvKQoreworCXJldHVybiBfX2dwaW9fZ2V0X3ZhbHVlKGdw
aW8pOworfQorCitFWFBPUlRfU1lNQk9MKHNhMTEwMF9ncGlvX2dldF92YWx1ZSk7CisKKy8qCisg
KiBTZXQgb3V0cHV0IEdQSU8gbGV2ZWwKKyAqLwordm9pZCBzYTExMDBfZ3Bpb19zZXRfdmFsdWUo
dW5zaWduZWQgZ3BpbywgaW50IHZhbHVlKQoreworCV9fZ3Bpb19zZXRfdmFsdWUoZ3BpbywgdmFs
dWUpOworfQorCitFWFBPUlRfU1lNQk9MKHNhMTEwMF9ncGlvX3NldF92YWx1ZSk7CisKKy8qCiAg
KiBEZWZhdWx0IHBvd2VyLW9mZiBmb3IgU0ExMTAwCiAgKi8KIHN0YXRpYyB2b2lkIHNhMTEwMF9w
b3dlcl9vZmYodm9pZCkKSW5kZXg6IGxpbnV4LTIuNi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1zYTEx
MDAvaGFyZHdhcmUuaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYub3JpZy9pbmNsdWRlL2FzbS1h
cm0vYXJjaC1zYTExMDAvaGFyZHdhcmUuaAkyMDA2LTEyLTIyIDA3OjU4OjEzLjAwMDAwMDAwMCAr
MDEwMAorKysgbGludXgtMi42L2luY2x1ZGUvYXNtLWFybS9hcmNoLXNhMTEwMC9oYXJkd2FyZS5o
CTIwMDYtMTItMjIgMDg6MDI6MjMuMDAwMDAwMDAwICswMTAwCkBAIC00OCw2ICs0OCwxNiBAQAog
CiAjZW5kaWYKIAorLyoKKyAqIFJldHVybiBHUElPIGxldmVsLCBub256ZXJvIG1lYW5zIGhpZ2gs
IHplcm8gaXMgbG93CisgKi8KK2V4dGVybiBpbnQgc2ExMTAwX2dwaW9fZ2V0X3ZhbHVlKHVuc2ln
bmVkIGdwaW8pOworCisvKgorICogU2V0IG91dHB1dCBHUElPIGxldmVsCisgKi8KK3ZvaWQgc2Ex
MTAwX2dwaW9fc2V0X3ZhbHVlKHVuc2lnbmVkIGdwaW8sIGludCB2YWx1ZSk7CisKICNpbmNsdWRl
ICJTQS0xMTAwLmgiCiAKICNpZmRlZiBDT05GSUdfU0ExMTAxCg==
------=_Part_43919_19015539.1166771818655--
