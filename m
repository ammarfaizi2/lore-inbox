Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWGSV31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWGSV31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 17:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWGSV31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 17:29:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:17326 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932542AbWGSV30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 17:29:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type;
        b=FkcQsrFDy2yqbAoFsqHTutSDOOcY0h9yLh3jV5pXx/NlFPOdFWBOyr9D07GvKFSCuy9zCJChuI3sAvAURm4q1aU8kTb3V/X2NRPi39zb3lragmOx6f76O5iJ976EidHksc+hME6B1dElPF0pZSWdBAw3FJ8rFPX+UxdbrYMfKeI=
Message-ID: <7f45d9390607191429y403e5bc8s69e1056e0a27d711@mail.gmail.com>
Date: Wed, 19 Jul 2006 15:29:25 -0600
From: "Shaun Jackman" <sjackman@gmail.com>
Reply-To: "Shaun Jackman" <sjackman@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>,
       "uClinux development list" <uClinux-dev@uclinux.org>
Subject: [PATCH] smc91x: Add support for an external PHY
Cc: "Russell King" <rmk@arm.linux.org.uk>, "Nicolas Pitre" <nico@cam.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14107_22225334.1153344565070"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_14107_22225334.1153344565070
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[PATCH] smc91x: Add support for an external PHY

Add an `extphy' module parameter to the smc91x Ethernet driver. This
parameter enables use of the external MII port and disables the
internal PHY.

Signed-off-by: Shaun Jackman <sjackman@gmail.com>

diff --git a/drivers/net/smc91x.c b/drivers/net/smc91x.c
index 3d8dcb6..d784565 100644
--- a/drivers/net/smc91x.c
+++ b/drivers/net/smc91x.c
@@ -26,6 +26,7 @@
  * 	io	= for the base address
  *	irq	= for the IRQ
  *	nowait	= 0 for normal wait states, 1 eliminates additional wait states
+ *	extphy	= use an external PHY
  *
  * original author:
  * 	Erik Stahlman <erik@vt.edu>
@@ -37,6 +38,7 @@
  * 	Daris A Nevil <dnevil@snmc.com>
  *      Nicolas Pitre <nico@cam.org>
  *	Russell King <rmk@arm.linux.org.uk>
+ *	Shaun Jackman <sjackman@gmail.com>
  *
  * History:
  *   08/20/00  Arnaldo Melo       fix kfree(skb) in smc_hardware_send_packet
@@ -56,6 +58,7 @@
  *                                - clean up (and fix stack overrun) in PHY
  *                                  MII read/write functions
  *   22/09/04  Nicolas Pitre      big update (see commit log for details)
+ *   18/07/06  Shaun Jackman      add extphy parameter
  */
 static const char version[] =
 	"smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@cam.org>\n";
@@ -124,6 +127,13 @@ static int nowait = SMC_NOWAIT;
 module_param(nowait, int, 0400);
 MODULE_PARM_DESC(nowait, "set to 1 for no wait state");

+#ifndef SMC_EXTPHY
+# define SMC_EXTPHY		0
+#endif
+static int extphy = SMC_EXTPHY;
+module_param(extphy, int, 0400);
+MODULE_PARM_DESC(extphy, "set to 1 to use an external PHY");
+
 /*
  * Transmit timeout, default 5 seconds.
  */
@@ -359,6 +369,10 @@ static void smc_reset(struct net_device
 	if (nowait)
 		cfg |= CONFIG_NO_WAIT;

+	/* Use an external PHY if requested. */
+	if (extphy)
+		cfg |= CONFIG_EXT_PHY;
+
 	/*
 	 * Release from possible power-down state
 	 * Configuration register is not affected by Soft Reset
@@ -949,6 +963,9 @@ static void smc_phy_detect(struct net_de

 	lp->phy_type = 0;

+	if (extphy)
+		return;
+
 	/*
 	 * Scan all 32 PHY addresses if necessary, starting at
 	 * PHY#1 to PHY#31, and then PHY#0 last.
@@ -1583,7 +1600,7 @@ smc_open(struct net_device *dev)
 	 * If we are not using a MII interface, we need to
 	 * monitor our own carrier signal to detect faults.
 	 */
-	if (lp->phy_type == 0)
+	if (lp->phy_type == 0 && !extphy)
 		lp->tcr_cur_mode |= TCR_MON_CSN;

 	/* reset the hardware */
@@ -2025,8 +2042,9 @@ #endif
 		if (dev->dma != (unsigned char)-1)
 			printk(" DMA %d", dev->dma);

-		printk("%s%s\n", nowait ? " [nowait]" : "",
-			THROTTLE_TX_PKTS ? " [throttle_tx]" : "");
+		printk("%s%s%s\n", nowait ? " [nowait]" : "",
+			THROTTLE_TX_PKTS ? " [throttle_tx]" : "",
+			extphy ? " [extphy]" : "");

 		if (!is_valid_ether_addr(dev->dev_addr)) {
 			printk("%s: Invalid ethernet MAC address.  Please "
@@ -2046,6 +2064,8 @@ #endif
 		} else if ((lp->phy_type & 0xfffffff0) == 0x02821c50) {
 			PRINTK("%s: PHY LAN83C180\n", dev->name);
 		}
+		if (extphy)
+			PRINTK("%s: Using external PHY\n", dev->name);
 	}

 err_out:

------=_Part_14107_22225334.1153344565070
Content-Type: text/plain; name=linux-smc91x-extphy.diff; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_epu7i6uu
Content-Disposition: attachment; filename="linux-smc91x-extphy.diff"

W1BBVENIXSBzbWM5MXg6IEFkZCBzdXBwb3J0IGZvciBhbiBleHRlcm5hbCBQSFkKCkFkZCBhbiBg
ZXh0cGh5JyBtb2R1bGUgcGFyYW1ldGVyIHRvIHRoZSBzbWM5MXggRXRoZXJuZXQgZHJpdmVyLiBU
aGlzCnBhcmFtZXRlciBlbmFibGVzIHVzZSBvZiB0aGUgZXh0ZXJuYWwgTUlJIHBvcnQgYW5kIGRp
c2FibGVzIHRoZQppbnRlcm5hbCBQSFkuCgpTaWduZWQtb2ZmLWJ5OiBTaGF1biBKYWNrbWFuIDxz
amFja21hbkBnbWFpbC5jb20+CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvc21jOTF4LmMgYi9k
cml2ZXJzL25ldC9zbWM5MXguYwppbmRleCAzZDhkY2I2Li5kNzg0NTY1IDEwMDY0NAotLS0gYS9k
cml2ZXJzL25ldC9zbWM5MXguYworKysgYi9kcml2ZXJzL25ldC9zbWM5MXguYwpAQCAtMjYsNiAr
MjYsNyBAQAogICogCWlvCT0gZm9yIHRoZSBiYXNlIGFkZHJlc3MKICAqCWlycQk9IGZvciB0aGUg
SVJRCiAgKglub3dhaXQJPSAwIGZvciBub3JtYWwgd2FpdCBzdGF0ZXMsIDEgZWxpbWluYXRlcyBh
ZGRpdGlvbmFsIHdhaXQgc3RhdGVzCisgKglleHRwaHkJPSB1c2UgYW4gZXh0ZXJuYWwgUEhZCiAg
KgogICogb3JpZ2luYWwgYXV0aG9yOgogICogCUVyaWsgU3RhaGxtYW4gPGVyaWtAdnQuZWR1PgpA
QCAtMzcsNiArMzgsNyBAQAogICogCURhcmlzIEEgTmV2aWwgPGRuZXZpbEBzbm1jLmNvbT4KICAq
ICAgICAgTmljb2xhcyBQaXRyZSA8bmljb0BjYW0ub3JnPgogICoJUnVzc2VsbCBLaW5nIDxybWtA
YXJtLmxpbnV4Lm9yZy51az4KKyAqCVNoYXVuIEphY2ttYW4gPHNqYWNrbWFuQGdtYWlsLmNvbT4K
ICAqCiAgKiBIaXN0b3J5OgogICogICAwOC8yMC8wMCAgQXJuYWxkbyBNZWxvICAgICAgIGZpeCBr
ZnJlZShza2IpIGluIHNtY19oYXJkd2FyZV9zZW5kX3BhY2tldApAQCAtNTYsNiArNTgsNyBAQAog
ICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gY2xlYW4gdXAgKGFuZCBmaXggc3Rh
Y2sgb3ZlcnJ1bikgaW4gUEhZCiAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBN
SUkgcmVhZC93cml0ZSBmdW5jdGlvbnMKICAqICAgMjIvMDkvMDQgIE5pY29sYXMgUGl0cmUgICAg
ICBiaWcgdXBkYXRlIChzZWUgY29tbWl0IGxvZyBmb3IgZGV0YWlscykKKyAqICAgMTgvMDcvMDYg
IFNoYXVuIEphY2ttYW4gICAgICBhZGQgZXh0cGh5IHBhcmFtZXRlcgogICovCiBzdGF0aWMgY29u
c3QgY2hhciB2ZXJzaW9uW10gPQogCSJzbWM5MXguYzogdjEuMSwgc2VwIDIyIDIwMDQgYnkgTmlj
b2xhcyBQaXRyZSA8bmljb0BjYW0ub3JnPlxuIjsKQEAgLTEyNCw2ICsxMjcsMTMgQEAgc3RhdGlj
IGludCBub3dhaXQgPSBTTUNfTk9XQUlUOwogbW9kdWxlX3BhcmFtKG5vd2FpdCwgaW50LCAwNDAw
KTsKIE1PRFVMRV9QQVJNX0RFU0Mobm93YWl0LCAic2V0IHRvIDEgZm9yIG5vIHdhaXQgc3RhdGUi
KTsKIAorI2lmbmRlZiBTTUNfRVhUUEhZCisjIGRlZmluZSBTTUNfRVhUUEhZCQkwCisjZW5kaWYK
K3N0YXRpYyBpbnQgZXh0cGh5ID0gU01DX0VYVFBIWTsKK21vZHVsZV9wYXJhbShleHRwaHksIGlu
dCwgMDQwMCk7CitNT0RVTEVfUEFSTV9ERVNDKGV4dHBoeSwgInNldCB0byAxIHRvIHVzZSBhbiBl
eHRlcm5hbCBQSFkiKTsKKwogLyoKICAqIFRyYW5zbWl0IHRpbWVvdXQsIGRlZmF1bHQgNSBzZWNv
bmRzLgogICovCkBAIC0zNTksNiArMzY5LDEwIEBAIHN0YXRpYyB2b2lkIHNtY19yZXNldChzdHJ1
Y3QgbmV0X2RldmljZSAKIAlpZiAobm93YWl0KQogCQljZmcgfD0gQ09ORklHX05PX1dBSVQ7CiAK
KwkvKiBVc2UgYW4gZXh0ZXJuYWwgUEhZIGlmIHJlcXVlc3RlZC4gKi8KKwlpZiAoZXh0cGh5KQor
CQljZmcgfD0gQ09ORklHX0VYVF9QSFk7CisKIAkvKgogCSAqIFJlbGVhc2UgZnJvbSBwb3NzaWJs
ZSBwb3dlci1kb3duIHN0YXRlCiAJICogQ29uZmlndXJhdGlvbiByZWdpc3RlciBpcyBub3QgYWZm
ZWN0ZWQgYnkgU29mdCBSZXNldApAQCAtOTQ5LDYgKzk2Myw5IEBAIHN0YXRpYyB2b2lkIHNtY19w
aHlfZGV0ZWN0KHN0cnVjdCBuZXRfZGUKIAogCWxwLT5waHlfdHlwZSA9IDA7CiAKKwlpZiAoZXh0
cGh5KQorCQlyZXR1cm47CisKIAkvKgogCSAqIFNjYW4gYWxsIDMyIFBIWSBhZGRyZXNzZXMgaWYg
bmVjZXNzYXJ5LCBzdGFydGluZyBhdAogCSAqIFBIWSMxIHRvIFBIWSMzMSwgYW5kIHRoZW4gUEhZ
IzAgbGFzdC4KQEAgLTE1ODMsNyArMTYwMCw3IEBAIHNtY19vcGVuKHN0cnVjdCBuZXRfZGV2aWNl
ICpkZXYpCiAJICogSWYgd2UgYXJlIG5vdCB1c2luZyBhIE1JSSBpbnRlcmZhY2UsIHdlIG5lZWQg
dG8KIAkgKiBtb25pdG9yIG91ciBvd24gY2FycmllciBzaWduYWwgdG8gZGV0ZWN0IGZhdWx0cy4K
IAkgKi8KLQlpZiAobHAtPnBoeV90eXBlID09IDApCisJaWYgKGxwLT5waHlfdHlwZSA9PSAwICYm
ICFleHRwaHkpCiAJCWxwLT50Y3JfY3VyX21vZGUgfD0gVENSX01PTl9DU047CiAKIAkvKiByZXNl
dCB0aGUgaGFyZHdhcmUgKi8KQEAgLTIwMjUsOCArMjA0Miw5IEBAICNlbmRpZgogCQlpZiAoZGV2
LT5kbWEgIT0gKHVuc2lnbmVkIGNoYXIpLTEpCiAJCQlwcmludGsoIiBETUEgJWQiLCBkZXYtPmRt
YSk7CiAKLQkJcHJpbnRrKCIlcyVzXG4iLCBub3dhaXQgPyAiIFtub3dhaXRdIiA6ICIiLAotCQkJ
VEhST1RUTEVfVFhfUEtUUyA/ICIgW3Rocm90dGxlX3R4XSIgOiAiIik7CisJCXByaW50aygiJXMl
cyVzXG4iLCBub3dhaXQgPyAiIFtub3dhaXRdIiA6ICIiLAorCQkJVEhST1RUTEVfVFhfUEtUUyA/
ICIgW3Rocm90dGxlX3R4XSIgOiAiIiwKKwkJCWV4dHBoeSA/ICIgW2V4dHBoeV0iIDogIiIpOwog
CiAJCWlmICghaXNfdmFsaWRfZXRoZXJfYWRkcihkZXYtPmRldl9hZGRyKSkgewogCQkJcHJpbnRr
KCIlczogSW52YWxpZCBldGhlcm5ldCBNQUMgYWRkcmVzcy4gIFBsZWFzZSAiCkBAIC0yMDQ2LDYg
KzIwNjQsOCBAQCAjZW5kaWYKIAkJfSBlbHNlIGlmICgobHAtPnBoeV90eXBlICYgMHhmZmZmZmZm
MCkgPT0gMHgwMjgyMWM1MCkgewogCQkJUFJJTlRLKCIlczogUEhZIExBTjgzQzE4MFxuIiwgZGV2
LT5uYW1lKTsKIAkJfQorCQlpZiAoZXh0cGh5KQorCQkJUFJJTlRLKCIlczogVXNpbmcgZXh0ZXJu
YWwgUEhZXG4iLCBkZXYtPm5hbWUpOwogCX0KIAogZXJyX291dDoK
------=_Part_14107_22225334.1153344565070--
