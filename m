Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbUL3Ocv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbUL3Ocv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 09:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbUL3Ocb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 09:32:31 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:11139 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261647AbUL3Obv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 09:31:51 -0500
X-Qmail-Scanner-Mail-From: solt2@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Rcpt-To: linux-net@vger.kernel.org,linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.23 (Clear:RC:0(213.238.102.201):. Processed in 0.555293 secs)
Date: Thu, 30 Dec 2004 15:40:20 +0100
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Mailer: The Bat! (v3.0.1.33) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <714805690.20041230154020@dns.toxicfilms.tv>
To: linux-net@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Update to module_params() in 3c59x.c
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----------A8F20B36D9BC02"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------A8F20B36D9BC02
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi!

This patch:
1) updates the 3c59x.c driver to use module_param() stuff.
2) kills a strange character somewhere at the bottom of the patch

I hope it is right, it is my first glance at module_param() :-)

 3c59x.c |   67 +++++++++++++++++++++++++++++++---------------------------------
 1 files changed, 33 insertions(+), 34 deletions(-)

Oh, in order to use the module_param() macros i had to move the variable
before module_param.

Signed-off-by: Maciej Soltysiak <solt2@dns.toxicfilms.tv>

Please review and hopefully apply.
Regars,
Maciej


diff -ru linux.orig/drivers/net/3c59x.c linux/drivers/net/3c59x.c
--- linux.orig/drivers/net/3c59x.c      2004-12-30 15:27:40.000000000 +0100
+++ linux/drivers/net/3c59x.c   2004-12-30 14:33:29.000000000 +0100
@@ -240,6 +240,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/timer.h>
@@ -269,6 +270,23 @@
 
 #include <linux/delay.h>
 
+/* This driver uses 'options' to pass the media type, full-duplex flag, etc. */
+/* Option count limit only -- unlimited interfaces are supported. */
+#define MAX_UNITS 8
+static int options[MAX_UNITS] = { -1, -1, -1, -1, -1, -1, -1, -1,};
+static int full_duplex[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
+static int hw_checksums[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
+static int flow_ctrl[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
+static int enable_wol[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
+static int global_options = -1;
+static int global_full_duplex = -1;
+static int global_enable_wol = -1;
+
+/* #define dev_alloc_skb dev_alloc_skb_debug */
+
+/* Variables to work-around the Compaq PCI BIOS32 problem. */
+static int compaq_ioaddr, compaq_irq, compaq_device_id = 0x5900;
+static struct net_device *compaq_net_device;
 
 static char version[] __devinitdata =
 DRV_NAME ": Donald Becker and others. www.scyld.com/network/vortex.html\n";
@@ -279,21 +297,21 @@
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
-MODULE_PARM(debug, "i");
-MODULE_PARM(global_options, "i");
-MODULE_PARM(options, "1-" __MODULE_STRING(8) "i");
-MODULE_PARM(global_full_duplex, "i");
-MODULE_PARM(full_duplex, "1-" __MODULE_STRING(8) "i");
-MODULE_PARM(hw_checksums, "1-" __MODULE_STRING(8) "i");
-MODULE_PARM(flow_ctrl, "1-" __MODULE_STRING(8) "i");
-MODULE_PARM(global_enable_wol, "i");
-MODULE_PARM(enable_wol, "1-" __MODULE_STRING(8) "i");
-MODULE_PARM(rx_copybreak, "i");
-MODULE_PARM(max_interrupt_work, "i");
-MODULE_PARM(compaq_ioaddr, "i");
-MODULE_PARM(compaq_irq, "i");
-MODULE_PARM(compaq_device_id, "i");
-MODULE_PARM(watchdog, "i");
+module_param(debug, int, 0);
+module_param(global_options, int, 0);
+module_param_array(options, int, NULL, 0);
+module_param(global_full_duplex, int, 0);
+module_param_array(full_duplex, int, NULL, 0);
+module_param_array(hw_checksums, int, NULL, 0);
+module_param_array(flow_ctrl, int, NULL, 0);
+module_param(global_enable_wol, int, 0);
+module_param_array(enable_wol, int, NULL, 0);
+module_param(rx_copybreak, int, 0);
+module_param(max_interrupt_work, int, 0);
+module_param(compaq_ioaddr, int, 0);
+module_param(compaq_irq, int, 0);
+module_param(compaq_device_id, int, 0);
+module_param(watchdog, int, 0);
 MODULE_PARM_DESC(debug, "3c59x debug level (0-6)");
 MODULE_PARM_DESC(options, "3c59x: Bits 0-3: media type, bit 4: bus mastering, bit 9: full duplex");
 MODULE_PARM_DESC(global_options, "3c59x: same as options, but applies to all NICs if options is unset");
@@ -910,25 +928,6 @@
 static struct ethtool_ops vortex_ethtool_ops;
 static void set_8021q_mode(struct net_device *dev, int enable);
 
-
-/* This driver uses 'options' to pass the media type, full-duplex flag, etc. */
-/* Option count limit only -- unlimited interfaces are supported. */
-#define MAX_UNITS 8
-static int options[MAX_UNITS] = { -1, -1, -1, -1, -1, -1, -1, -1,};
-static int full_duplex[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
-static int hw_checksums[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
-static int flow_ctrl[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
-static int enable_wol[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
-static int global_options = -1;
-static int global_full_duplex = -1;
-static int global_enable_wol = -1;
-
-/* #define dev_alloc_skb dev_alloc_skb_debug */
-
-/* Variables to work-around the Compaq PCI BIOS32 problem. */
-static int compaq_ioaddr, compaq_irq, compaq_device_id = 0x5900;
-static struct net_device *compaq_net_device;
-
 static int vortex_cards_found;
 
 #ifdef CONFIG_NET_POLL_CONTROLLER

------------A8F20B36D9BC02
Content-Type: application/octet-stream; name="3c59x.c.diff"
Content-transfer-encoding: base64
Content-Disposition: attachment; filename="3c59x.c.diff"

ZGlmZiAtcnUgbGludXgub3JpZy9kcml2ZXJzL25ldC8zYzU5eC5jIGxpbnV4L2RyaXZlcnMv
bmV0LzNjNTl4LmMKLS0tIGxpbnV4Lm9yaWcvZHJpdmVycy9uZXQvM2M1OXguYwkyMDA0LTEy
LTMwIDE1OjI3OjQwLjAwMDAwMDAwMCArMDEwMAorKysgbGludXgvZHJpdmVycy9uZXQvM2M1
OXguYwkyMDA0LTEyLTMwIDE0OjMzOjI5LjAwMDAwMDAwMCArMDEwMApAQCAtMjQwLDYgKzI0
MCw3IEBACiAKICNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4KICNpbmNsdWRlIDxsaW51eC9t
b2R1bGUuaD4KKyNpbmNsdWRlIDxsaW51eC9tb2R1bGVwYXJhbS5oPgogI2luY2x1ZGUgPGxp
bnV4L2tlcm5lbC5oPgogI2luY2x1ZGUgPGxpbnV4L3N0cmluZy5oPgogI2luY2x1ZGUgPGxp
bnV4L3RpbWVyLmg+CkBAIC0yNjksNiArMjcwLDIzIEBACiAKICNpbmNsdWRlIDxsaW51eC9k
ZWxheS5oPgogCisvKiBUaGlzIGRyaXZlciB1c2VzICdvcHRpb25zJyB0byBwYXNzIHRoZSBt
ZWRpYSB0eXBlLCBmdWxsLWR1cGxleCBmbGFnLCBldGMuICovCisvKiBPcHRpb24gY291bnQg
bGltaXQgb25seSAtLSB1bmxpbWl0ZWQgaW50ZXJmYWNlcyBhcmUgc3VwcG9ydGVkLiAqLwor
I2RlZmluZSBNQVhfVU5JVFMgOAorc3RhdGljIGludCBvcHRpb25zW01BWF9VTklUU10gPSB7
IC0xLCAtMSwgLTEsIC0xLCAtMSwgLTEsIC0xLCAtMSx9Oworc3RhdGljIGludCBmdWxsX2R1
cGxleFtNQVhfVU5JVFNdID0gey0xLCAtMSwgLTEsIC0xLCAtMSwgLTEsIC0xLCAtMX07Citz
dGF0aWMgaW50IGh3X2NoZWNrc3Vtc1tNQVhfVU5JVFNdID0gey0xLCAtMSwgLTEsIC0xLCAt
MSwgLTEsIC0xLCAtMX07CitzdGF0aWMgaW50IGZsb3dfY3RybFtNQVhfVU5JVFNdID0gey0x
LCAtMSwgLTEsIC0xLCAtMSwgLTEsIC0xLCAtMX07CitzdGF0aWMgaW50IGVuYWJsZV93b2xb
TUFYX1VOSVRTXSA9IHstMSwgLTEsIC0xLCAtMSwgLTEsIC0xLCAtMSwgLTF9Oworc3RhdGlj
IGludCBnbG9iYWxfb3B0aW9ucyA9IC0xOworc3RhdGljIGludCBnbG9iYWxfZnVsbF9kdXBs
ZXggPSAtMTsKK3N0YXRpYyBpbnQgZ2xvYmFsX2VuYWJsZV93b2wgPSAtMTsKKworLyogI2Rl
ZmluZSBkZXZfYWxsb2Nfc2tiIGRldl9hbGxvY19za2JfZGVidWcgKi8KKworLyogVmFyaWFi
bGVzIHRvIHdvcmstYXJvdW5kIHRoZSBDb21wYXEgUENJIEJJT1MzMiBwcm9ibGVtLiAqLwor
c3RhdGljIGludCBjb21wYXFfaW9hZGRyLCBjb21wYXFfaXJxLCBjb21wYXFfZGV2aWNlX2lk
ID0gMHg1OTAwOworc3RhdGljIHN0cnVjdCBuZXRfZGV2aWNlICpjb21wYXFfbmV0X2Rldmlj
ZTsKIAogc3RhdGljIGNoYXIgdmVyc2lvbltdIF9fZGV2aW5pdGRhdGEgPQogRFJWX05BTUUg
IjogRG9uYWxkIEJlY2tlciBhbmQgb3RoZXJzLiB3d3cuc2N5bGQuY29tL25ldHdvcmsvdm9y
dGV4Lmh0bWxcbiI7CkBAIC0yNzksMjEgKzI5NywyMSBAQAogTU9EVUxFX0xJQ0VOU0UoIkdQ
TCIpOwogTU9EVUxFX1ZFUlNJT04oRFJWX1ZFUlNJT04pOwogCi1NT0RVTEVfUEFSTShkZWJ1
ZywgImkiKTsKLU1PRFVMRV9QQVJNKGdsb2JhbF9vcHRpb25zLCAiaSIpOwotTU9EVUxFX1BB
Uk0ob3B0aW9ucywgIjEtIiBfX01PRFVMRV9TVFJJTkcoOCkgImkiKTsKLU1PRFVMRV9QQVJN
KGdsb2JhbF9mdWxsX2R1cGxleCwgImkiKTsKLU1PRFVMRV9QQVJNKGZ1bGxfZHVwbGV4LCAi
MS0iIF9fTU9EVUxFX1NUUklORyg4KSAiaSIpOwotTU9EVUxFX1BBUk0oaHdfY2hlY2tzdW1z
LCAiMS0iIF9fTU9EVUxFX1NUUklORyg4KSAiaSIpOwotTU9EVUxFX1BBUk0oZmxvd19jdHJs
LCAiMS0iIF9fTU9EVUxFX1NUUklORyg4KSAiaSIpOwotTU9EVUxFX1BBUk0oZ2xvYmFsX2Vu
YWJsZV93b2wsICJpIik7Ci1NT0RVTEVfUEFSTShlbmFibGVfd29sLCAiMS0iIF9fTU9EVUxF
X1NUUklORyg4KSAiaSIpOwotTU9EVUxFX1BBUk0ocnhfY29weWJyZWFrLCAiaSIpOwotTU9E
VUxFX1BBUk0obWF4X2ludGVycnVwdF93b3JrLCAiaSIpOwotTU9EVUxFX1BBUk0oY29tcGFx
X2lvYWRkciwgImkiKTsKLU1PRFVMRV9QQVJNKGNvbXBhcV9pcnEsICJpIik7Ci1NT0RVTEVf
UEFSTShjb21wYXFfZGV2aWNlX2lkLCAiaSIpOwotTU9EVUxFX1BBUk0od2F0Y2hkb2csICJp
Iik7Cittb2R1bGVfcGFyYW0oZGVidWcsIGludCwgMCk7Cittb2R1bGVfcGFyYW0oZ2xvYmFs
X29wdGlvbnMsIGludCwgMCk7Cittb2R1bGVfcGFyYW1fYXJyYXkob3B0aW9ucywgaW50LCBO
VUxMLCAwKTsKK21vZHVsZV9wYXJhbShnbG9iYWxfZnVsbF9kdXBsZXgsIGludCwgMCk7Citt
b2R1bGVfcGFyYW1fYXJyYXkoZnVsbF9kdXBsZXgsIGludCwgTlVMTCwgMCk7Cittb2R1bGVf
cGFyYW1fYXJyYXkoaHdfY2hlY2tzdW1zLCBpbnQsIE5VTEwsIDApOworbW9kdWxlX3BhcmFt
X2FycmF5KGZsb3dfY3RybCwgaW50LCBOVUxMLCAwKTsKK21vZHVsZV9wYXJhbShnbG9iYWxf
ZW5hYmxlX3dvbCwgaW50LCAwKTsKK21vZHVsZV9wYXJhbV9hcnJheShlbmFibGVfd29sLCBp
bnQsIE5VTEwsIDApOworbW9kdWxlX3BhcmFtKHJ4X2NvcHlicmVhaywgaW50LCAwKTsKK21v
ZHVsZV9wYXJhbShtYXhfaW50ZXJydXB0X3dvcmssIGludCwgMCk7Cittb2R1bGVfcGFyYW0o
Y29tcGFxX2lvYWRkciwgaW50LCAwKTsKK21vZHVsZV9wYXJhbShjb21wYXFfaXJxLCBpbnQs
IDApOworbW9kdWxlX3BhcmFtKGNvbXBhcV9kZXZpY2VfaWQsIGludCwgMCk7Cittb2R1bGVf
cGFyYW0od2F0Y2hkb2csIGludCwgMCk7CiBNT0RVTEVfUEFSTV9ERVNDKGRlYnVnLCAiM2M1
OXggZGVidWcgbGV2ZWwgKDAtNikiKTsKIE1PRFVMRV9QQVJNX0RFU0Mob3B0aW9ucywgIjNj
NTl4OiBCaXRzIDAtMzogbWVkaWEgdHlwZSwgYml0IDQ6IGJ1cyBtYXN0ZXJpbmcsIGJpdCA5
OiBmdWxsIGR1cGxleCIpOwogTU9EVUxFX1BBUk1fREVTQyhnbG9iYWxfb3B0aW9ucywgIjNj
NTl4OiBzYW1lIGFzIG9wdGlvbnMsIGJ1dCBhcHBsaWVzIHRvIGFsbCBOSUNzIGlmIG9wdGlv
bnMgaXMgdW5zZXQiKTsKQEAgLTkxMCwyNSArOTI4LDYgQEAKIHN0YXRpYyBzdHJ1Y3QgZXRo
dG9vbF9vcHMgdm9ydGV4X2V0aHRvb2xfb3BzOwogc3RhdGljIHZvaWQgc2V0XzgwMjFxX21v
ZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgaW50IGVuYWJsZSk7CiAKLQwKLS8qIFRoaXMg
ZHJpdmVyIHVzZXMgJ29wdGlvbnMnIHRvIHBhc3MgdGhlIG1lZGlhIHR5cGUsIGZ1bGwtZHVw
bGV4IGZsYWcsIGV0Yy4gKi8KLS8qIE9wdGlvbiBjb3VudCBsaW1pdCBvbmx5IC0tIHVubGlt
aXRlZCBpbnRlcmZhY2VzIGFyZSBzdXBwb3J0ZWQuICovCi0jZGVmaW5lIE1BWF9VTklUUyA4
Ci1zdGF0aWMgaW50IG9wdGlvbnNbTUFYX1VOSVRTXSA9IHsgLTEsIC0xLCAtMSwgLTEsIC0x
LCAtMSwgLTEsIC0xLH07Ci1zdGF0aWMgaW50IGZ1bGxfZHVwbGV4W01BWF9VTklUU10gPSB7
LTEsIC0xLCAtMSwgLTEsIC0xLCAtMSwgLTEsIC0xfTsKLXN0YXRpYyBpbnQgaHdfY2hlY2tz
dW1zW01BWF9VTklUU10gPSB7LTEsIC0xLCAtMSwgLTEsIC0xLCAtMSwgLTEsIC0xfTsKLXN0
YXRpYyBpbnQgZmxvd19jdHJsW01BWF9VTklUU10gPSB7LTEsIC0xLCAtMSwgLTEsIC0xLCAt
MSwgLTEsIC0xfTsKLXN0YXRpYyBpbnQgZW5hYmxlX3dvbFtNQVhfVU5JVFNdID0gey0xLCAt
MSwgLTEsIC0xLCAtMSwgLTEsIC0xLCAtMX07Ci1zdGF0aWMgaW50IGdsb2JhbF9vcHRpb25z
ID0gLTE7Ci1zdGF0aWMgaW50IGdsb2JhbF9mdWxsX2R1cGxleCA9IC0xOwotc3RhdGljIGlu
dCBnbG9iYWxfZW5hYmxlX3dvbCA9IC0xOwotCi0vKiAjZGVmaW5lIGRldl9hbGxvY19za2Ig
ZGV2X2FsbG9jX3NrYl9kZWJ1ZyAqLwotCi0vKiBWYXJpYWJsZXMgdG8gd29yay1hcm91bmQg
dGhlIENvbXBhcSBQQ0kgQklPUzMyIHByb2JsZW0uICovCi1zdGF0aWMgaW50IGNvbXBhcV9p
b2FkZHIsIGNvbXBhcV9pcnEsIGNvbXBhcV9kZXZpY2VfaWQgPSAweDU5MDA7Ci1zdGF0aWMg
c3RydWN0IG5ldF9kZXZpY2UgKmNvbXBhcV9uZXRfZGV2aWNlOwotCiBzdGF0aWMgaW50IHZv
cnRleF9jYXJkc19mb3VuZDsKIAogI2lmZGVmIENPTkZJR19ORVRfUE9MTF9DT05UUk9MTEVS
Cg==
------------A8F20B36D9BC02--

