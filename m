Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264944AbTLZHar (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 02:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbTLZHar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 02:30:47 -0500
Received: from hoemail1.lucent.com ([192.11.226.161]:52869 "EHLO
	hoemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S264944AbTLZHan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 02:30:43 -0500
Date: Fri, 26 Dec 2003 13:05:08 +0530 (IST)
From: Mahendra M <mm94@india.ascend.com>
X-X-Sender: mmahendra@paiute.india.ascend.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Compile error for vt.c and Warnings for kernel/power/console.c
Message-ID: <Pine.LNX.4.44.0312261259580.8010-200000@paiute.india.ascend.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-24657980-1109530660-1072424108=:8010"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---24657980-1109530660-1072424108=:8010
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi all,

While compiling the kernel ( 2.6.0 ), I noticed this piece of code that
lead to a compile time error.

For the following config : ( make bzImage )

CONFIG_VT=y
# CONFIG_VT_CONSOLE is not set

Problem 1
---------
kernel/power/console.c:13: warning: `orig_fgconsole' defined but not used
kernel/power/console.c:13: warning: `orig_kmsg' defined but not used

Issue : orig_fgconsole and orig_kmsg are used only if SUSPEND_CONSOLE is
defined. SUSPEND_CONSOLE is defined only for
#if defined(CONFIG_VT) && defined(CONFIG_VT_CONSOLE)

To fix this, the change can be made as follows :
#ifdef SUSPEND_CONSOLE
static int orig_fgconsole, orig_kmsg;
#endif

Problem 2 ( This is the same as my earlier problem )
----------------------------------------------------
drivers/char/vt.c: In function `vty_init':
drivers/char/vt.c:2542: `console_driver' undeclared (first use in this 
function)drivers/char/vt.c:2542: (Each undeclared identifier is reported 
only once
drivers/char/vt.c:2542: for each function it appears in.)
make[2]: *** [drivers/char/vt.o] Error 1

This is because of the following -

# ifdef drivers/char/vt.c 2188
2089    #ifdef CONFIG_VT_CONSOLE
2188     |struct tty_driver *console_driver;

# ifdef drivers/char/vt.c 2540
2540    int __init vty_init(void)

A fix for this would be to have the declaration of console_driver out of
the scope of #ifdef CONFIG_VT_CONSOLE

Note : The problems don't appear if CONFIG_VT_CONSOLE=y.

Please find attached a patch for the same. I have compiled it for an
x86 and the problem disappears. 

Regards,
Mahendra

-- 
-------------------------------------------------------------------------------
Mahendra M  -  Mahendra_M AT infosys DOT com / mm94 AT india DOT ascend DOT com
Infosys Technologies Ltd, Bangalore.
-------------------------------------------------------------------------------


---24657980-1109530660-1072424108=:8010
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="patch-2.6.0-my"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0312261305080.8010@paiute.india.ascend.com>
Content-Description: Patch
Content-Disposition: attachment; filename="patch-2.6.0-my"

ZGlmZiAtdXJOIC1YIC9yb290L2RvbnRkaWZmIGxpbnV4LTIuNi4wL2RyaXZl
cnMvY2hhci92dC5jIGxpbnV4LTIuNi4wLW15L2RyaXZlcnMvY2hhci92dC5j
DQotLS0gbGludXgtMi42LjAvZHJpdmVycy9jaGFyL3Z0LmMJMjAwMy0xMi0y
NCAwOTo1MDo1NS4wMDAwMDAwMDAgKzA1MzANCisrKyBsaW51eC0yLjYuMC1t
eS9kcml2ZXJzL2NoYXIvdnQuYwkyMDAzLTEyLTI0IDA5OjUyOjAxLjAwMDAw
MDAwMCArMDUzMA0KQEAgLTIwODYsNiArMjA4Niw4IEBADQogCXNjaGVkdWxl
X2NvbnNvbGVfY2FsbGJhY2soKTsNCiB9DQogDQorc3RydWN0IHR0eV9kcml2
ZXIgKmNvbnNvbGVfZHJpdmVyOw0KKw0KICNpZmRlZiBDT05GSUdfVlRfQ09O
U09MRQ0KIA0KIC8qDQpAQCAtMjE4NSw4ICsyMTg3LDYgQEANCiAJY2xlYXJf
Yml0KDAsICZwcmludGluZyk7DQogfQ0KIA0KLXN0cnVjdCB0dHlfZHJpdmVy
ICpjb25zb2xlX2RyaXZlcjsNCi0NCiBzdGF0aWMgc3RydWN0IHR0eV9kcml2
ZXIgKnZ0X2NvbnNvbGVfZGV2aWNlKHN0cnVjdCBjb25zb2xlICpjLCBpbnQg
KmluZGV4KQ0KIHsNCiAJKmluZGV4ID0gYy0+aW5kZXggPyBjLT5pbmRleC0x
IDogZmdfY29uc29sZTsNCmRpZmYgLXVyTiAtWCAvcm9vdC9kb250ZGlmZiBs
aW51eC0yLjYuMC9rZXJuZWwvcG93ZXIvY29uc29sZS5jIGxpbnV4LTIuNi4w
LW15L2tlcm5lbC9wb3dlci9jb25zb2xlLmMNCi0tLSBsaW51eC0yLjYuMC9r
ZXJuZWwvcG93ZXIvY29uc29sZS5jCTIwMDMtMTItMjQgMDk6NDM6NDYuMDAw
MDAwMDAwICswNTMwDQorKysgbGludXgtMi42LjAtbXkva2VybmVsL3Bvd2Vy
L2NvbnNvbGUuYwkyMDAzLTEyLTI0IDA5OjUyOjEzLjAwMDAwMDAwMCArMDUz
MA0KQEAgLTEwLDcgKzEwLDEwIEBADQogDQogc3RhdGljIGludCBuZXdfbG9n
bGV2ZWwgPSAxMDsNCiBzdGF0aWMgaW50IG9yaWdfbG9nbGV2ZWw7DQorDQor
I2lmZGVmIFNVU1BFTkRfQ09OU09MRQ0KIHN0YXRpYyBpbnQgb3JpZ19mZ2Nv
bnNvbGUsIG9yaWdfa21zZzsNCisjZW5kaWYNCiANCiBpbnQgcG1fcHJlcGFy
ZV9jb25zb2xlKHZvaWQpDQogew0K
---24657980-1109530660-1072424108=:8010--
