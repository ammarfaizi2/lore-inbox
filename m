Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbTAJMX0>; Fri, 10 Jan 2003 07:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbTAJMX0>; Fri, 10 Jan 2003 07:23:26 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:2480 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id <S264936AbTAJMXW>;
	Fri, 10 Jan 2003 07:23:22 -0500
Date: Fri, 10 Jan 2003 13:32:08 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] 3 net drivers [etherleak]
Message-ID: <Pine.LNX.4.51.0301101326070.25610@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-23717851-1876919955-1042201928=:25610"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---23717851-1876919955-1042201928=:25610
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

about a discussion about padding of ethernet frames, here are 3 patches
to 3 old popular net drivers that should do the padding:
- eexpress.c
- 3c507.c
- eepro.c

I do not have these old cards handy, it would be nice if someone who has
them, could test the drivers (which should be very easy with them compiled
as modules)

Is this a good solution?

Regards,
Maciej Soltysiak


Here are the 3 little patches:

--- linux/drivers/net/eexpress.c	2002-11-29 00:53:13.000000000 +0100
+++ linux.new/drivers/net/eexpress.c	2003-01-10 13:23:01.000000000 +0100
@@ -660,10 +654,16 @@
 #endif

 	{
-		unsigned short length = (ETH_ZLEN < buf->len) ? buf->len :
-			ETH_ZLEN;
+		unsigned short length;
 		unsigned short *data = (unsigned short *)buf->data;

+		if (ETH_ZLEN < buf->len) {
+			length = buf->len;
+		} else {
+			length = ETH_ZLEN;
+			memset(data + buf->len, 0, length - buf->len);
+		}
+
 		lp->stats.tx_bytes += length;

 	        eexp_hw_tx_pio(dev,data,length);

--- linux/drivers/net/3c507.c	2002-02-25 20:37:58.000000000 +0100
+++ linux.new/drivers/net/3c507.c	2003-01-10 13:02:02.000000000 +0100
@@ -19,6 +19,10 @@
 	Mark Salazar <leslie@access.digex.net> made the changes for cards with
 	only 16K packet buffers.

+
+	Maciej Soltysiak:	Padding of ethernet frames of length less
+				than ETH_ZLEN (RFC 894, RFC 1042)
+
 	Things remaining to do:
 	Verify that the tx and rx buffers don't have fencepost errors.
 	Move the theory of operation and memory map documentation.
@@ -26,8 +30,8 @@
 */

 #define DRV_NAME		"3c507"
-#define DRV_VERSION		"1.10a"
-#define DRV_RELDATE		"11/17/2001"
+#define DRV_VERSION		"1.11"
+#define DRV_RELDATE		"01/10/2003"

 static const char version[] =
 	DRV_NAME ".c:v" DRV_VERSION " " DRV_RELDATE " Donald Becker (becker@scyld.com)\n";
@@ -494,9 +498,16 @@
 	struct net_local *lp = (struct net_local *) dev->priv;
 	int ioaddr = dev->base_addr;
 	unsigned long flags;
-	short length = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
+	short length;
 	unsigned char *buf = skb->data;

+	if (ETH_ZLEN < skb->len) {
+		length = skb->len;
+	} else {
+		length = ETH_ZLEN;
+		memset(buf + skb->len, 0, length - skb->len);
+	}
+
 	netif_stop_queue (dev);

 	spin_lock_irqsave (&lp->lock, flags);

--- linux/drivers/net/eepro.c	2002-11-29 00:53:13.000000000 +0100
+++ linux.new/drivers/net/eepro.c	2003-01-10 13:01:55.000000000 +0100
@@ -23,6 +23,8 @@
 	This is a compatibility hardware problem.

 	Versions:
+	0.14	padding of ethernet frames of length less than
+		ETH_ZLEN (01/10/2003)
 	0.13a   in memory shortage, drop packets also in board
 		(Michael Westermann <mw@microdata-pos.de>, 07/30/2002)
 	0.13    irq sharing, rewrote probe function, fixed a nasty bug in
@@ -104,7 +106,7 @@
 */

 static const char version[] =
-	"eepro.c: v0.13 11/08/2001 aris@cathedrallabs.org\n";
+	"eepro.c: v0.14 01/10/2003 aris@cathedrallabs.org\n";

 #include <linux/module.h>

@@ -1138,9 +1140,16 @@
 	spin_lock_irqsave(&lp->lock, flags);

 	{
-		short length = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
+		short length;
 		unsigned char *buf = skb->data;

+		if (ETH_ZLEN <= skb->len) {
+			length = skb->len
+		} else {
+			length = ETH_ZLEN;
+			memset(buf + skb->len, 0, length - skb->len);
+		}
+
 		if (hardware_send_packet(dev, buf, length))
 			/* we won't wake queue here because we're out of space */
 			lp->stats.tx_dropped++;
---23717851-1876919955-1042201928=:25610
Content-Type: TEXT/plain; name="eexpress.c.padding.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.51.0301101332071.25610@dns.toxicfilms.tv>
Content-Description: eexpress
Content-Disposition: attachment; filename="eexpress.c.padding.diff"

LS0tIGxpbnV4L2RyaXZlcnMvbmV0L2VleHByZXNzLmMJMjAwMi0xMS0yOSAw
MDo1MzoxMy4wMDAwMDAwMDAgKzAxMDANCisrKyBsaW51eC5uZXcvZHJpdmVy
cy9uZXQvZWV4cHJlc3MuYwkyMDAzLTAxLTEwIDEzOjIzOjAxLjAwMDAwMDAw
MCArMDEwMA0KQEAgLTY2MCwxMCArNjU0LDE2IEBADQogI2VuZGlmDQogICAN
CiAJew0KLQkJdW5zaWduZWQgc2hvcnQgbGVuZ3RoID0gKEVUSF9aTEVOIDwg
YnVmLT5sZW4pID8gYnVmLT5sZW4gOg0KLQkJCUVUSF9aTEVOOw0KKwkJdW5z
aWduZWQgc2hvcnQgbGVuZ3RoOw0KIAkJdW5zaWduZWQgc2hvcnQgKmRhdGEg
PSAodW5zaWduZWQgc2hvcnQgKilidWYtPmRhdGE7DQogDQorCQlpZiAoRVRI
X1pMRU4gPCBidWYtPmxlbikgew0KKwkJCWxlbmd0aCA9IGJ1Zi0+bGVuOw0K
KwkJfSBlbHNlIHsNCisJCQlsZW5ndGggPSBFVEhfWkxFTjsNCisJCQltZW1z
ZXQoZGF0YSArIGJ1Zi0+bGVuLCAwLCBsZW5ndGggLSBidWYtPmxlbik7DQor
CQl9DQorCQkNCiAJCWxwLT5zdGF0cy50eF9ieXRlcyArPSBsZW5ndGg7DQog
DQogCSAgICAgICAgZWV4cF9od190eF9waW8oZGV2LGRhdGEsbGVuZ3RoKTsN
Cg==

---23717851-1876919955-1042201928=:25610
Content-Type: TEXT/plain; name="3c507.c.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.51.0301101332072.25610@dns.toxicfilms.tv>
Content-Description: 3c507
Content-Disposition: attachment; filename="3c507.c.diff"

LS0tIGxpbnV4L2RyaXZlcnMvbmV0LzNjNTA3LmMJMjAwMi0wMi0yNSAyMDoz
Nzo1OC4wMDAwMDAwMDAgKzAxMDANCisrKyBsaW51eC5uZXcvZHJpdmVycy9u
ZXQvM2M1MDcuYwkyMDAzLTAxLTEwIDEzOjAyOjAyLjAwMDAwMDAwMCArMDEw
MA0KQEAgLTE5LDYgKzE5LDEwIEBADQogCU1hcmsgU2FsYXphciA8bGVzbGll
QGFjY2Vzcy5kaWdleC5uZXQ+IG1hZGUgdGhlIGNoYW5nZXMgZm9yIGNhcmRz
IHdpdGgNCiAJb25seSAxNksgcGFja2V0IGJ1ZmZlcnMuDQogDQorDQorCU1h
Y2llaiBTb2x0eXNpYWs6CVBhZGRpbmcgb2YgZXRoZXJuZXQgZnJhbWVzIG9m
IGxlbmd0aCBsZXNzDQorCQkJCXRoYW4gRVRIX1pMRU4gKFJGQyA4OTQsIFJG
QyAxMDQyKQ0KKw0KIAlUaGluZ3MgcmVtYWluaW5nIHRvIGRvOg0KIAlWZXJp
ZnkgdGhhdCB0aGUgdHggYW5kIHJ4IGJ1ZmZlcnMgZG9uJ3QgaGF2ZSBmZW5j
ZXBvc3QgZXJyb3JzLg0KIAlNb3ZlIHRoZSB0aGVvcnkgb2Ygb3BlcmF0aW9u
IGFuZCBtZW1vcnkgbWFwIGRvY3VtZW50YXRpb24uDQpAQCAtMjYsOCArMzAs
OCBAQA0KICovDQogDQogI2RlZmluZSBEUlZfTkFNRQkJIjNjNTA3Ig0KLSNk
ZWZpbmUgRFJWX1ZFUlNJT04JCSIxLjEwYSINCi0jZGVmaW5lIERSVl9SRUxE
QVRFCQkiMTEvMTcvMjAwMSINCisjZGVmaW5lIERSVl9WRVJTSU9OCQkiMS4x
MSINCisjZGVmaW5lIERSVl9SRUxEQVRFCQkiMDEvMTAvMjAwMyINCiANCiBz
dGF0aWMgY29uc3QgY2hhciB2ZXJzaW9uW10gPQ0KIAlEUlZfTkFNRSAiLmM6
diIgRFJWX1ZFUlNJT04gIiAiIERSVl9SRUxEQVRFICIgRG9uYWxkIEJlY2tl
ciAoYmVja2VyQHNjeWxkLmNvbSlcbiI7DQpAQCAtNDk0LDkgKzQ5OCwxNiBA
QA0KIAlzdHJ1Y3QgbmV0X2xvY2FsICpscCA9IChzdHJ1Y3QgbmV0X2xvY2Fs
ICopIGRldi0+cHJpdjsNCiAJaW50IGlvYWRkciA9IGRldi0+YmFzZV9hZGRy
Ow0KIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KLQlzaG9ydCBsZW5ndGggPSBF
VEhfWkxFTiA8IHNrYi0+bGVuID8gc2tiLT5sZW4gOiBFVEhfWkxFTjsNCisJ
c2hvcnQgbGVuZ3RoOw0KIAl1bnNpZ25lZCBjaGFyICpidWYgPSBza2ItPmRh
dGE7DQogDQorCWlmIChFVEhfWkxFTiA8IHNrYi0+bGVuKSB7DQorCQlsZW5n
dGggPSBza2ItPmxlbjsNCisJfSBlbHNlIHsNCisJCWxlbmd0aCA9IEVUSF9a
TEVOOw0KKwkJbWVtc2V0KGJ1ZiArIHNrYi0+bGVuLCAwLCBsZW5ndGggLSBz
a2ItPmxlbik7DQorCX0NCisNCiAJbmV0aWZfc3RvcF9xdWV1ZSAoZGV2KTsN
CiANCiAJc3Bpbl9sb2NrX2lycXNhdmUgKCZscC0+bG9jaywgZmxhZ3MpOw0K

---23717851-1876919955-1042201928=:25610
Content-Type: TEXT/plain; name="eepro.c.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.51.0301101332080.25610@dns.toxicfilms.tv>
Content-Description: eepro
Content-Disposition: attachment; filename="eepro.c.diff"

LS0tIGxpbnV4L2RyaXZlcnMvbmV0L2VlcHJvLmMJMjAwMi0xMS0yOSAwMDo1
MzoxMy4wMDAwMDAwMDAgKzAxMDANCisrKyBsaW51eC5uZXcvZHJpdmVycy9u
ZXQvZWVwcm8uYwkyMDAzLTAxLTEwIDEzOjAxOjU1LjAwMDAwMDAwMCArMDEw
MA0KQEAgLTIzLDYgKzIzLDggQEANCiAJVGhpcyBpcyBhIGNvbXBhdGliaWxp
dHkgaGFyZHdhcmUgcHJvYmxlbS4NCiANCiAJVmVyc2lvbnM6DQorCTAuMTQJ
cGFkZGluZyBvZiBldGhlcm5ldCBmcmFtZXMgb2YgbGVuZ3RoIGxlc3MgdGhh
bg0KKwkJRVRIX1pMRU4gKDAxLzEwLzIwMDMpDQogCTAuMTNhICAgaW4gbWVt
b3J5IHNob3J0YWdlLCBkcm9wIHBhY2tldHMgYWxzbyBpbiBib2FyZA0KIAkJ
KE1pY2hhZWwgV2VzdGVybWFubiA8bXdAbWljcm9kYXRhLXBvcy5kZT4sIDA3
LzMwLzIwMDIpDQogCTAuMTMgICAgaXJxIHNoYXJpbmcsIHJld3JvdGUgcHJv
YmUgZnVuY3Rpb24sIGZpeGVkIGEgbmFzdHkgYnVnIGluDQpAQCAtMTA0LDcg
KzEwNiw3IEBADQogKi8NCiANCiBzdGF0aWMgY29uc3QgY2hhciB2ZXJzaW9u
W10gPQ0KLQkiZWVwcm8uYzogdjAuMTMgMTEvMDgvMjAwMSBhcmlzQGNhdGhl
ZHJhbGxhYnMub3JnXG4iOw0KKwkiZWVwcm8uYzogdjAuMTQgMDEvMTAvMjAw
MyBhcmlzQGNhdGhlZHJhbGxhYnMub3JnXG4iOw0KIA0KICNpbmNsdWRlIDxs
aW51eC9tb2R1bGUuaD4NCiANCkBAIC0xMTM4LDkgKzExNDAsMTYgQEANCiAJ
c3Bpbl9sb2NrX2lycXNhdmUoJmxwLT5sb2NrLCBmbGFncyk7DQogDQogCXsN
Ci0JCXNob3J0IGxlbmd0aCA9IEVUSF9aTEVOIDwgc2tiLT5sZW4gPyBza2It
PmxlbiA6IEVUSF9aTEVOOw0KKwkJc2hvcnQgbGVuZ3RoOw0KIAkJdW5zaWdu
ZWQgY2hhciAqYnVmID0gc2tiLT5kYXRhOw0KIA0KKwkJaWYgKEVUSF9aTEVO
IDw9IHNrYi0+bGVuKSB7DQorCQkJbGVuZ3RoID0gc2tiLT5sZW4NCisJCX0g
ZWxzZSB7DQorCQkJbGVuZ3RoID0gRVRIX1pMRU47DQorCQkJbWVtc2V0KGJ1
ZiArIHNrYi0+bGVuLCAwLCBsZW5ndGggLSBza2ItPmxlbik7DQorCQl9DQor
CQkNCiAJCWlmIChoYXJkd2FyZV9zZW5kX3BhY2tldChkZXYsIGJ1ZiwgbGVu
Z3RoKSkNCiAJCQkvKiB3ZSB3b24ndCB3YWtlIHF1ZXVlIGhlcmUgYmVjYXVz
ZSB3ZSdyZSBvdXQgb2Ygc3BhY2UgKi8NCiAJCQlscC0+c3RhdHMudHhfZHJv
cHBlZCsrOw0K

---23717851-1876919955-1042201928=:25610--
