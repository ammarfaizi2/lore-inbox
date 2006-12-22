Return-Path: <linux-kernel-owner+w=401wt.eu-S1423181AbWLVGxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423181AbWLVGxJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 01:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423183AbWLVGxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 01:53:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:40996 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423181AbWLVGxH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 01:53:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=JnHPyY13IcxKSdbFnD4+wyMLMz2v2z3w+h3jxuauqCfbYb14ryP5oCMMiVOMqcQ7bkLPmmYRJ6CvdO76+YUCeTyMVZY6UcGeeawoKKXuNqqXm/NBGTFL4fX8e+Mp08zTtxC48FPRShrvdRjetipm0fynlxrR8bEtWfyPkZEKhfA=
Message-ID: <74d0deb30612212253s7d35cf92q80bbebe9d8ae9476@mail.gmail.com>
Date: Fri, 22 Dec 2006 07:53:04 +0100
From: "pHilipp Zabel" <philipp.zabel@gmail.com>
To: "Nicolas Pitre" <nico@cam.org>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
Cc: "David Brownell" <david-b@pacbell.net>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Victor" <andrew@sanpeople.com>,
       "Bill Gatliff" <bgat@billgatliff.com>,
       "Haavard Skinnemoen" <hskinnemoen@atmel.com>,
       "Kevin Hilman" <khilman@mvista.com>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Tony Lindgren" <tony@atomide.com>
In-Reply-To: <Pine.LNX.4.64.0612211457390.18171@xanadu.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_43691_3575219.1166770384200"
References: <200611111541.34699.david-b@pacbell.net>
	 <200612201312.36616.david-b@pacbell.net>
	 <20061220221252.732f4e97.akpm@osdl.org>
	 <200612202244.03351.david-b@pacbell.net>
	 <Pine.LNX.4.64.0612210925130.18171@xanadu.home>
	 <74d0deb30612210703y735e53kf14e7c800dae7140@mail.gmail.com>
	 <Pine.LNX.4.64.0612211205530.18171@xanadu.home>
	 <74d0deb30612211132j6186ad00te536eb420636e7c8@mail.gmail.com>
	 <Pine.LNX.4.64.0612211457390.18171@xanadu.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_43691_3575219.1166770384200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/21/06, Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 21 Dec 2006, pHilipp Zabel wrote:
>
> > > > --- linux-2.6.orig/arch/arm/mach-pxa/generic.c        2006-12-16
> > > > +++ linux-2.6/arch/arm/mach-pxa/generic.c     2006-12-16
> > > > 16:47:45.000000000
> > > > @@ -129,6 +129,29 @@
> > > > EXPORT_SYMBOL(pxa_gpio_mode);
> > > >
> > > > /*
> > > > + * Return GPIO level, nonzero means high, zero is low
> > > > + */
> > > > +int pxa_gpio_get_value(unsigned gpio)
> > > > +{
> > > > +     return GPLR(gpio) & GPIO_bit(gpio);
> > > > +}
> > > > +
> > > > +EXPORT_SYMBOL(pxa_gpio_get_value);
> > > > +
> > > > +/*
> > > > + * Set output GPIO level
> > > > + */
> > > > +void pxa_gpio_set_value(unsigned gpio, int value)
> > > > +{
> > > > +     if (value)
> > > > +             GPSR(gpio) = GPIO_bit(gpio);
> > > > +     else
> > > > +             GPCR(gpio) = GPIO_bit(gpio);
> > > > +}
> > > > +
> > > > +EXPORT_SYMBOL(pxa_gpio_set_value);
> > >
> > > Instead of duplicating code here, you probably should just reuse
> > > __gpio_set_value() and __gpio_get_value() inside those functions.
> >
> > Probably? What I am wondering is this: can the compiler
> > optimize away the range check that is duplicated in GPSR/GPCR
> > and  GPIO_bit for __gpio_set/get_value? Or could we optimize
> > this case by expanding the macros in place (which would mean
> > duplicating code from pxa-regs.h)...
>
> Sorry I don't quite follow you here.  Why would you expand the macro in
> place?

And that is no surprise because I seem to have problems to follow
myself here now after a good night's rest. Basically I was thinking
that after expanding the macros in place the code could be optimized.
Of course, this doesn't have any advantage for the inlined functions
(gpio is constant, so most of the code will be optimized away anyway),
and shaving one or two words off pxa_gpio_setval is hardly worthwile.

> My suggestion is only about not duplicating the source code.  The
> generated assembly will be the same.
>
> And your patch looks fine to me now, except for this:
>
> +int pxa_gpio_get_value(unsigned gpio)
> +{
> +       __gpio_get_value(gpio);
> +}
>
> You certainly meant to add a "return" in there, right?

Oh yes. Sorry.

cheers
Philipp

Index: linux-2.6/include/asm-arm/arch-pxa/gpio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/include/asm-arm/arch-pxa/gpio.h	2006-12-21
20:07:48.000000000 +0100
@@ -0,0 +1,82 @@
+/*
+ * linux/include/asm-arm/arch-pxa/gpio.h
+ *
+ * PXA GPIO wrappers for arch-neutral GPIO calls
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
+#ifndef __ASM_ARCH_PXA_GPIO_H
+#define __ASM_ARCH_PXA_GPIO_H
+
+#include <asm/arch/pxa-regs.h>
+#include <asm/arch/irqs.h>
+#include <asm/arch/hardware.h>
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
+	return pxa_gpio_mode(gpio | GPIO_IN);
+}
+
+static inline int gpio_direction_output(unsigned gpio)
+{
+	return pxa_gpio_mode(gpio | GPIO_OUT);
+}
+
+static inline int __gpio_get_value(unsigned gpio)
+{
+	return GPLR(gpio) & GPIO_bit(gpio);
+}
+
+#define gpio_get_value(gpio)			\
+	(__builtin_constant_p(gpio) ?		\
+	 __gpioe_get_value(gpio) :		\
+	 pxa_gpio_get_value(gpio))
+
+static inline void __gpio_set_value(unsigned gpio, int value)
+{
+	if (value)
+		GPSR(gpio) = GPIO_bit(gpio);
+	else
+		GPCR(gpio) = GPIO_bit(gpio);
+}
+
+#define gpio_set_value(gpio,value)		\
+	(__builtin_constant_p(gpio) ?		\
+	 __gpio_set_value(gpio, value) :	\
+	 pxa_gpio_set_value(gpio, value))
+
+#include <asm-generic/gpio.h>			/* cansleep wrappers */
+
+#define gpio_to_irq(gpio)	IRQ_GPIO(gpio)
+#define irq_to_gpio(irq)	IRQ_TO_GPIO(irq)
+
+
+#endif
Index: linux-2.6/arch/arm/mach-pxa/generic.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-pxa/generic.c	2006-12-21
13:30:01.000000000 +0100
+++ linux-2.6/arch/arm/mach-pxa/generic.c	2006-12-21 21:25:24.000000000 +0100
@@ -36,6 +36,7 @@
 #include <asm/mach/map.h>

 #include <asm/arch/pxa-regs.h>
+#include <asm/arch/gpio.h>
 #include <asm/arch/udc.h>
 #include <asm/arch/pxafb.h>
 #include <asm/arch/serial.h>
@@ -105,13 +106,16 @@
  * Handy function to set GPIO alternate functions
  */

-void pxa_gpio_mode(int gpio_mode)
+int pxa_gpio_mode(int gpio_mode)
 {
 	unsigned long flags;
 	int gpio = gpio_mode & GPIO_MD_MASK_NR;
 	int fn = (gpio_mode & GPIO_MD_MASK_FN) >> 8;
 	int gafr;

+	if (gpio > PXA_LAST_GPIO)
+		return -EINVAL;
+
 	local_irq_save(flags);
 	if (gpio_mode & GPIO_DFLT_LOW)
 		GPCR(gpio) = GPIO_bit(gpio);
@@ -124,11 +128,33 @@
 	gafr = GAFR(gpio) & ~(0x3 << (((gpio) & 0xf)*2));
 	GAFR(gpio) = gafr |  (fn  << (((gpio) & 0xf)*2));
 	local_irq_restore(flags);
+
+	return 0;
 }

 EXPORT_SYMBOL(pxa_gpio_mode);

 /*
+ * Return GPIO level
+ */
+int pxa_gpio_get_value(unsigned gpio)
+{
+	return __gpio_get_value(gpio);
+}
+
+EXPORT_SYMBOL(pxa_gpio_get_value);
+
+/*
+ * Set output GPIO level
+ */
+void pxa_gpio_set_value(unsigned gpio, int value)
+{
+	__gpio_set_value(gpio, value);
+}
+
+EXPORT_SYMBOL(pxa_gpio_set_value);
+
+/*
  * Routine to safely enable or disable a clock in the CKEN
  */
 void pxa_set_cken(int clock, int enable)
Index: linux-2.6/include/asm-arm/arch-pxa/hardware.h
===================================================================
--- linux-2.6.orig/include/asm-arm/arch-pxa/hardware.h	2006-12-21
13:30:01.000000000 +0100
+++ linux-2.6/include/asm-arm/arch-pxa/hardware.h	2006-12-21
20:03:55.000000000 +0100
@@ -65,7 +65,17 @@
 /*
  * Handy routine to set GPIO alternate functions
  */
-extern void pxa_gpio_mode( int gpio_mode );
+extern int pxa_gpio_mode( int gpio_mode );
+
+/*
+ * Return GPIO level, nonzero means high, zero is low
+ */
+extern int pxa_gpio_get_value(unsigned gpio);
+
+/*
+ * Set output GPIO level
+ */
+extern void pxa_gpio_set_value(unsigned gpio, int value);

 /*
  * Routine to enable or disable CKEN

------=_Part_43691_3575219.1166770384200
Content-Type: text/x-patch; name=gpio-api-pxa.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ew08q40o
Content-Disposition: attachment; filename="gpio-api-pxa.patch"

SW5kZXg6IGxpbnV4LTIuNi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1weGEvZ3Bpby5oCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0tIC9kZXYvbnVsbAkxOTcwLTAxLTAxIDAwOjAwOjAwLjAwMDAwMDAwMCArMDAwMAorKysg
bGludXgtMi42L2luY2x1ZGUvYXNtLWFybS9hcmNoLXB4YS9ncGlvLmgJMjAwNi0xMi0yMSAyMDow
Nzo0OC4wMDAwMDAwMDAgKzAxMDAKQEAgLTAsMCArMSw4MiBAQAorLyoKKyAqIGxpbnV4L2luY2x1
ZGUvYXNtLWFybS9hcmNoLXB4YS9ncGlvLmgKKyAqCisgKiBQWEEgR1BJTyB3cmFwcGVycyBmb3Ig
YXJjaC1uZXV0cmFsIEdQSU8gY2FsbHMKKyAqCisgKiBXcml0dGVuIGJ5IFBoaWxpcHAgWmFiZWwg
PHBoaWxpcHAuemFiZWxAZ21haWwuY29tPgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv
ZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisgKiBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hl
ZCBieQorICogdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBv
ZiB0aGUgTGljZW5zZSwgb3IKKyAqIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24u
CisgKgorICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQg
d2lsbCBiZSB1c2VmdWwsCisgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZl
biB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1Mg
Rk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiBTZWUgdGhlCisgKiBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorICoKKyAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZl
ZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiBhbG9uZyB3aXRo
IHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQorICogRm91
bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIx
MTEtMTMwNyBVU0EKKyAqCisgKi8KKworI2lmbmRlZiBfX0FTTV9BUkNIX1BYQV9HUElPX0gKKyNk
ZWZpbmUgX19BU01fQVJDSF9QWEFfR1BJT19ICisKKyNpbmNsdWRlIDxhc20vYXJjaC9weGEtcmVn
cy5oPgorI2luY2x1ZGUgPGFzbS9hcmNoL2lycXMuaD4KKyNpbmNsdWRlIDxhc20vYXJjaC9oYXJk
d2FyZS5oPgorCisjaW5jbHVkZSA8YXNtL2Vycm5vLmg+CisKK3N0YXRpYyBpbmxpbmUgaW50IGdw
aW9fcmVxdWVzdCh1bnNpZ25lZCBncGlvLCBjb25zdCBjaGFyICpsYWJlbCkKK3sKKwlyZXR1cm4g
MDsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGdwaW9fZnJlZSh1bnNpZ25lZCBncGlvKQorewor
CXJldHVybjsKK30KKworc3RhdGljIGlubGluZSBpbnQgZ3Bpb19kaXJlY3Rpb25faW5wdXQodW5z
aWduZWQgZ3BpbykKK3sKKwlyZXR1cm4gcHhhX2dwaW9fbW9kZShncGlvIHwgR1BJT19JTik7Cit9
CisKK3N0YXRpYyBpbmxpbmUgaW50IGdwaW9fZGlyZWN0aW9uX291dHB1dCh1bnNpZ25lZCBncGlv
KQoreworCXJldHVybiBweGFfZ3Bpb19tb2RlKGdwaW8gfCBHUElPX09VVCk7Cit9CisKK3N0YXRp
YyBpbmxpbmUgaW50IF9fZ3Bpb19nZXRfdmFsdWUodW5zaWduZWQgZ3BpbykKK3sKKwlyZXR1cm4g
R1BMUihncGlvKSAmIEdQSU9fYml0KGdwaW8pOworfQorCisjZGVmaW5lIGdwaW9fZ2V0X3ZhbHVl
KGdwaW8pCQkJXAorCShfX2J1aWx0aW5fY29uc3RhbnRfcChncGlvKSA/CQlcCisJIF9fZ3Bpb2Vf
Z2V0X3ZhbHVlKGdwaW8pIDoJCVwKKwkgcHhhX2dwaW9fZ2V0X3ZhbHVlKGdwaW8pKQorCitzdGF0
aWMgaW5saW5lIHZvaWQgX19ncGlvX3NldF92YWx1ZSh1bnNpZ25lZCBncGlvLCBpbnQgdmFsdWUp
Cit7CisJaWYgKHZhbHVlKQorCQlHUFNSKGdwaW8pID0gR1BJT19iaXQoZ3Bpbyk7CisJZWxzZQor
CQlHUENSKGdwaW8pID0gR1BJT19iaXQoZ3Bpbyk7Cit9CisKKyNkZWZpbmUgZ3Bpb19zZXRfdmFs
dWUoZ3Bpbyx2YWx1ZSkJCVwKKwkoX19idWlsdGluX2NvbnN0YW50X3AoZ3BpbykgPwkJXAorCSBf
X2dwaW9fc2V0X3ZhbHVlKGdwaW8sIHZhbHVlKSA6CVwKKwkgcHhhX2dwaW9fc2V0X3ZhbHVlKGdw
aW8sIHZhbHVlKSkKKworI2luY2x1ZGUgPGFzbS1nZW5lcmljL2dwaW8uaD4JCQkvKiBjYW5zbGVl
cCB3cmFwcGVycyAqLworCisjZGVmaW5lIGdwaW9fdG9faXJxKGdwaW8pCUlSUV9HUElPKGdwaW8p
CisjZGVmaW5lIGlycV90b19ncGlvKGlycSkJSVJRX1RPX0dQSU8oaXJxKQorCisKKyNlbmRpZgpJ
bmRleDogbGludXgtMi42L2FyY2gvYXJtL21hY2gtcHhhL2dlbmVyaWMuYwo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0t
LSBsaW51eC0yLjYub3JpZy9hcmNoL2FybS9tYWNoLXB4YS9nZW5lcmljLmMJMjAwNi0xMi0yMSAx
MzozMDowMS4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi9hcmNoL2FybS9tYWNoLXB4YS9n
ZW5lcmljLmMJMjAwNi0xMi0yMSAyMToyNToyNC4wMDAwMDAwMDAgKzAxMDAKQEAgLTM2LDYgKzM2
LDcgQEAKICNpbmNsdWRlIDxhc20vbWFjaC9tYXAuaD4KIAogI2luY2x1ZGUgPGFzbS9hcmNoL3B4
YS1yZWdzLmg+CisjaW5jbHVkZSA8YXNtL2FyY2gvZ3Bpby5oPgogI2luY2x1ZGUgPGFzbS9hcmNo
L3VkYy5oPgogI2luY2x1ZGUgPGFzbS9hcmNoL3B4YWZiLmg+CiAjaW5jbHVkZSA8YXNtL2FyY2gv
c2VyaWFsLmg+CkBAIC0xMDUsMTMgKzEwNiwxNiBAQAogICogSGFuZHkgZnVuY3Rpb24gdG8gc2V0
IEdQSU8gYWx0ZXJuYXRlIGZ1bmN0aW9ucwogICovCiAKLXZvaWQgcHhhX2dwaW9fbW9kZShpbnQg
Z3Bpb19tb2RlKQoraW50IHB4YV9ncGlvX21vZGUoaW50IGdwaW9fbW9kZSkKIHsKIAl1bnNpZ25l
ZCBsb25nIGZsYWdzOwogCWludCBncGlvID0gZ3Bpb19tb2RlICYgR1BJT19NRF9NQVNLX05SOwog
CWludCBmbiA9IChncGlvX21vZGUgJiBHUElPX01EX01BU0tfRk4pID4+IDg7CiAJaW50IGdhZnI7
CiAKKwlpZiAoZ3BpbyA+IFBYQV9MQVNUX0dQSU8pCisJCXJldHVybiAtRUlOVkFMOworCiAJbG9j
YWxfaXJxX3NhdmUoZmxhZ3MpOwogCWlmIChncGlvX21vZGUgJiBHUElPX0RGTFRfTE9XKQogCQlH
UENSKGdwaW8pID0gR1BJT19iaXQoZ3Bpbyk7CkBAIC0xMjQsMTEgKzEyOCwzMyBAQAogCWdhZnIg
PSBHQUZSKGdwaW8pICYgfigweDMgPDwgKCgoZ3BpbykgJiAweGYpKjIpKTsKIAlHQUZSKGdwaW8p
ID0gZ2FmciB8ICAoZm4gIDw8ICgoKGdwaW8pICYgMHhmKSoyKSk7CiAJbG9jYWxfaXJxX3Jlc3Rv
cmUoZmxhZ3MpOworCisJcmV0dXJuIDA7CiB9CiAKIEVYUE9SVF9TWU1CT0wocHhhX2dwaW9fbW9k
ZSk7CiAKIC8qCisgKiBSZXR1cm4gR1BJTyBsZXZlbAorICovCitpbnQgcHhhX2dwaW9fZ2V0X3Zh
bHVlKHVuc2lnbmVkIGdwaW8pCit7CisJcmV0dXJuIF9fZ3Bpb19nZXRfdmFsdWUoZ3Bpbyk7Cit9
CisKK0VYUE9SVF9TWU1CT0wocHhhX2dwaW9fZ2V0X3ZhbHVlKTsKKworLyoKKyAqIFNldCBvdXRw
dXQgR1BJTyBsZXZlbAorICovCit2b2lkIHB4YV9ncGlvX3NldF92YWx1ZSh1bnNpZ25lZCBncGlv
LCBpbnQgdmFsdWUpCit7CisJX19ncGlvX3NldF92YWx1ZShncGlvLCB2YWx1ZSk7Cit9CisKK0VY
UE9SVF9TWU1CT0wocHhhX2dwaW9fc2V0X3ZhbHVlKTsKKworLyoKICAqIFJvdXRpbmUgdG8gc2Fm
ZWx5IGVuYWJsZSBvciBkaXNhYmxlIGEgY2xvY2sgaW4gdGhlIENLRU4KICAqLwogdm9pZCBweGFf
c2V0X2NrZW4oaW50IGNsb2NrLCBpbnQgZW5hYmxlKQpJbmRleDogbGludXgtMi42L2luY2x1ZGUv
YXNtLWFybS9hcmNoLXB4YS9oYXJkd2FyZS5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi5vcmln
L2luY2x1ZGUvYXNtLWFybS9hcmNoLXB4YS9oYXJkd2FyZS5oCTIwMDYtMTItMjEgMTM6MzA6MDEu
MDAwMDAwMDAwICswMTAwCisrKyBsaW51eC0yLjYvaW5jbHVkZS9hc20tYXJtL2FyY2gtcHhhL2hh
cmR3YXJlLmgJMjAwNi0xMi0yMSAyMDowMzo1NS4wMDAwMDAwMDAgKzAxMDAKQEAgLTY1LDcgKzY1
LDE3IEBACiAvKgogICogSGFuZHkgcm91dGluZSB0byBzZXQgR1BJTyBhbHRlcm5hdGUgZnVuY3Rp
b25zCiAgKi8KLWV4dGVybiB2b2lkIHB4YV9ncGlvX21vZGUoIGludCBncGlvX21vZGUgKTsKK2V4
dGVybiBpbnQgcHhhX2dwaW9fbW9kZSggaW50IGdwaW9fbW9kZSApOworCisvKgorICogUmV0dXJu
IEdQSU8gbGV2ZWwsIG5vbnplcm8gbWVhbnMgaGlnaCwgemVybyBpcyBsb3cKKyAqLworZXh0ZXJu
IGludCBweGFfZ3Bpb19nZXRfdmFsdWUodW5zaWduZWQgZ3Bpbyk7CisKKy8qCisgKiBTZXQgb3V0
cHV0IEdQSU8gbGV2ZWwKKyAqLworZXh0ZXJuIHZvaWQgcHhhX2dwaW9fc2V0X3ZhbHVlKHVuc2ln
bmVkIGdwaW8sIGludCB2YWx1ZSk7CiAKIC8qCiAgKiBSb3V0aW5lIHRvIGVuYWJsZSBvciBkaXNh
YmxlIENLRU4K
------=_Part_43691_3575219.1166770384200--
