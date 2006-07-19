Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWGSVeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWGSVeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 17:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWGSVeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 17:34:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:58039 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932503AbWGSVeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 17:34:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=BJoxXKuSpGTsE4FIHFkxtCYO/YWXzjsfcciF1X3I8qaaLxq+e/1QJLcrFm6r8I4uRp9UOy51Dud+qSgPY+I5Q2oJALhoOX4zQMMEJpI9K1P8PHwY6ZgvPNb+Dn5TN0oPAuGYfR4ordZv2Ap5m4haaLQl7dJSkHV8HQpljiTwKog=
Message-ID: <7f45d9390607191434g6261b6f8pf1c9a9688770d95f@mail.gmail.com>
Date: Wed, 19 Jul 2006 15:34:21 -0600
From: "Shaun Jackman" <sjackman@gmail.com>
Reply-To: "Shaun Jackman" <sjackman@gmail.com>
To: "Dmitry Torokhov" <dtor_core@ameritech.net>
Subject: Re: [PATCH] elo: Support non-pressure-sensitive ELO touchscreens
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <7f45d9390603280709u5eea134ejb0aaacdd49984a92@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14211_19442412.1153344861265"
References: <7f45d9390602241045p45aec8auaf881a4dab00c17a@mail.gmail.com>
	 <d120d5000603270828w4aef947cy7202da6076dd1268@mail.gmail.com>
	 <7f45d9390603271515m17a5ee1due5bc3f9f2285ca62@mail.gmail.com>
	 <200603280110.47199.dtor_core@ameritech.net>
	 <7f45d9390603280709u5eea134ejb0aaacdd49984a92@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_14211_19442412.1153344861265
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 3/28/06, Shaun Jackman <sjackman@gmail.com> wrote:
> On 3/27/06, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> ...
> > No, we should not change basic input device's capabilities "on-fly" -
> > userspace should be able to rely on what was reported to it in the first
> > place.
>
> Makes sense.
>
> > From looking over the documentation (thank you for the link)
> > it looks like you would need to issue 'i' command to query controller
> > type and whether the controller supports Z-axis in elo_connect().
>
> This sounds like extra (not strictly necessary) functionality to me
> though. My USB mouse, for example, reports five buttons and three
> wheels, even though it only has three buttons and one wheel. Support
> for the 'i' packet could be added later, if someone has a need. Can
> this patch be applied as is?

Can this patch adding support for non-pressure-sensitive ELO
touchscreens be applied? Any comments?

Thanks,
Shaun

[PATCH] elo: Support non-pressure-sensitive ELO touchscreens

* Use the touch status bit rather than the pressure bits to
  distinguish a BTN_TOUCH event. Non-pressure-sensitive touchscreens
  always report full pressure.
* Report ABS_PRESSURE information only if the touchscreen supports it.
* Implement the checksum calculation correctly, and verify that the
  transmitted checksum is correct.
* Use dev_dbg to log errors in the protocol.

Signed-off-by: Shaun Jackman <sjackman@gmail.com>

diff --git a/drivers/input/touchscreen/elo.c b/drivers/input/touchscreen/elo.c
index c86a2eb..b972184 100644
--- a/drivers/input/touchscreen/elo.c
+++ b/drivers/input/touchscreen/elo.c
@@ -35,6 +35,8 @@ MODULE_LICENSE("GPL");
  */

 #define	ELO_MAX_LENGTH	10
+#define ELO10_TOUCH 0x03
+#define ELO10_PRESSURE 0x80

 /*
  * Per-touchscreen data.
@@ -53,38 +55,40 @@ struct elo {
 static void elo_process_data_10(struct elo* elo, unsigned char data,
struct pt_regs *regs)
 {
 	struct input_dev *dev = elo->dev;
+	struct device *dbg = &elo->serio->dev;

-	elo->csum += elo->data[elo->idx] = data;
-
+	elo->data[elo->idx] = data;
 	switch (elo->idx++) {
-
 		case 0:
+			elo->csum = 0xaa;
 			if (data != 'U') {
+				dev_dbg(dbg, "unsynchronized data: 0x%02x\n", data);
 				elo->idx = 0;
-				elo->csum = 0;
 			}
 			break;
-
-		case 1:
-			if (data != 'T') {
-				elo->idx = 0;
-				elo->csum = 0;
-			}
-			break;
-
 		case 9:
-			if (elo->csum) {
-				input_regs(dev, regs);
-				input_report_abs(dev, ABS_X, (elo->data[4] << 8) | elo->data[3]);
-				input_report_abs(dev, ABS_Y, (elo->data[6] << 8) | elo->data[5]);
-				input_report_abs(dev, ABS_PRESSURE, (elo->data[8] << 8) | elo->data[7]);
-				input_report_key(dev, BTN_TOUCH, elo->data[8] || elo->data[7]);
-				input_sync(dev);
-			}
 			elo->idx = 0;
-			elo->csum = 0;
+			if (elo->csum != elo->data[9]) {
+				dev_dbg(dbg, "bad checksum: 0x%02x, expected 0x%02x\n",
+						elo->data[9], elo->csum);
+				break;
+			}
+			if (elo->data[1] != 'T') {
+				dev_dbg(dbg, "unexpected packet: 0x%02x\n",
+						elo->data[1]);
+				break;
+			}
+			input_regs(dev, regs);
+			input_report_abs(dev, ABS_X, (elo->data[4] << 8) | elo->data[3]);
+			input_report_abs(dev, ABS_Y, (elo->data[6] << 8) | elo->data[5]);
+			if (elo->data[2] & ELO10_PRESSURE)
+				input_report_abs(dev, ABS_PRESSURE,
+						(elo->data[8] << 8) | elo->data[7]);
+			input_report_key(dev, BTN_TOUCH, elo->data[2] & ELO10_TOUCH);
+			input_sync(dev);
 			break;
 	}
+	elo->csum += data;
 }

 static void elo_process_data_6(struct elo* elo, unsigned char data,
struct pt_regs *regs)

------=_Part_14211_19442412.1153344861265
Content-Type: text/plain; name=linux-elo.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_epu7qd3n
Content-Disposition: attachment; filename="linux-elo.diff"

W1BBVENIXSBlbG86IFN1cHBvcnQgbm9uLXByZXNzdXJlLXNlbnNpdGl2ZSBFTE8gdG91Y2hzY3Jl
ZW5zCgoqIFVzZSB0aGUgdG91Y2ggc3RhdHVzIGJpdCByYXRoZXIgdGhhbiB0aGUgcHJlc3N1cmUg
Yml0cyB0bwogIGRpc3Rpbmd1aXNoIGEgQlROX1RPVUNIIGV2ZW50LiBOb24tcHJlc3N1cmUtc2Vu
c2l0aXZlIHRvdWNoc2NyZWVucwogIGFsd2F5cyByZXBvcnQgZnVsbCBwcmVzc3VyZS4KKiBSZXBv
cnQgQUJTX1BSRVNTVVJFIGluZm9ybWF0aW9uIG9ubHkgaWYgdGhlIHRvdWNoc2NyZWVuIHN1cHBv
cnRzIGl0LgoqIEltcGxlbWVudCB0aGUgY2hlY2tzdW0gY2FsY3VsYXRpb24gY29ycmVjdGx5LCBh
bmQgdmVyaWZ5IHRoYXQgdGhlCiAgdHJhbnNtaXR0ZWQgY2hlY2tzdW0gaXMgY29ycmVjdC4KKiBV
c2UgZGV2X2RiZyB0byBsb2cgZXJyb3JzIGluIHRoZSBwcm90b2NvbC4KClNpZ25lZC1vZmYtYnk6
IFNoYXVuIEphY2ttYW4gPHNqYWNrbWFuQGdtYWlsLmNvbT4KCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2lucHV0L3RvdWNoc2NyZWVuL2Vsby5jIGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9lbG8u
YwppbmRleCBjODZhMmViLi5iOTcyMTg0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lucHV0L3RvdWNo
c2NyZWVuL2Vsby5jCisrKyBiL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vZWxvLmMKQEAgLTM1
LDYgKzM1LDggQEAgTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOwogICovCiAKICNkZWZpbmUJRUxPX01B
WF9MRU5HVEgJMTAKKyNkZWZpbmUgRUxPMTBfVE9VQ0ggMHgwMworI2RlZmluZSBFTE8xMF9QUkVT
U1VSRSAweDgwCiAKIC8qCiAgKiBQZXItdG91Y2hzY3JlZW4gZGF0YS4KQEAgLTUzLDM4ICs1NSw0
MCBAQCBzdHJ1Y3QgZWxvIHsKIHN0YXRpYyB2b2lkIGVsb19wcm9jZXNzX2RhdGFfMTAoc3RydWN0
IGVsbyogZWxvLCB1bnNpZ25lZCBjaGFyIGRhdGEsIHN0cnVjdCBwdF9yZWdzICpyZWdzKQogewog
CXN0cnVjdCBpbnB1dF9kZXYgKmRldiA9IGVsby0+ZGV2OworCXN0cnVjdCBkZXZpY2UgKmRiZyA9
ICZlbG8tPnNlcmlvLT5kZXY7CiAKLQllbG8tPmNzdW0gKz0gZWxvLT5kYXRhW2Vsby0+aWR4XSA9
IGRhdGE7Ci0KKwllbG8tPmRhdGFbZWxvLT5pZHhdID0gZGF0YTsKIAlzd2l0Y2ggKGVsby0+aWR4
KyspIHsKLQogCQljYXNlIDA6CisJCQllbG8tPmNzdW0gPSAweGFhOwogCQkJaWYgKGRhdGEgIT0g
J1UnKSB7CisJCQkJZGV2X2RiZyhkYmcsICJ1bnN5bmNocm9uaXplZCBkYXRhOiAweCUwMnhcbiIs
IGRhdGEpOwogCQkJCWVsby0+aWR4ID0gMDsKLQkJCQllbG8tPmNzdW0gPSAwOwogCQkJfQogCQkJ
YnJlYWs7Ci0KLQkJY2FzZSAxOgotCQkJaWYgKGRhdGEgIT0gJ1QnKSB7Ci0JCQkJZWxvLT5pZHgg
PSAwOwotCQkJCWVsby0+Y3N1bSA9IDA7Ci0JCQl9Ci0JCQlicmVhazsKLQogCQljYXNlIDk6Ci0J
CQlpZiAoZWxvLT5jc3VtKSB7Ci0JCQkJaW5wdXRfcmVncyhkZXYsIHJlZ3MpOwotCQkJCWlucHV0
X3JlcG9ydF9hYnMoZGV2LCBBQlNfWCwgKGVsby0+ZGF0YVs0XSA8PCA4KSB8IGVsby0+ZGF0YVsz
XSk7Ci0JCQkJaW5wdXRfcmVwb3J0X2FicyhkZXYsIEFCU19ZLCAoZWxvLT5kYXRhWzZdIDw8IDgp
IHwgZWxvLT5kYXRhWzVdKTsKLQkJCQlpbnB1dF9yZXBvcnRfYWJzKGRldiwgQUJTX1BSRVNTVVJF
LCAoZWxvLT5kYXRhWzhdIDw8IDgpIHwgZWxvLT5kYXRhWzddKTsKLQkJCQlpbnB1dF9yZXBvcnRf
a2V5KGRldiwgQlROX1RPVUNILCBlbG8tPmRhdGFbOF0gfHwgZWxvLT5kYXRhWzddKTsKLQkJCQlp
bnB1dF9zeW5jKGRldik7Ci0JCQl9CiAJCQllbG8tPmlkeCA9IDA7Ci0JCQllbG8tPmNzdW0gPSAw
OworCQkJaWYgKGVsby0+Y3N1bSAhPSBlbG8tPmRhdGFbOV0pIHsKKwkJCQlkZXZfZGJnKGRiZywg
ImJhZCBjaGVja3N1bTogMHglMDJ4LCBleHBlY3RlZCAweCUwMnhcbiIsCisJCQkJCQllbG8tPmRh
dGFbOV0sIGVsby0+Y3N1bSk7CisJCQkJYnJlYWs7CisJCQl9CisJCQlpZiAoZWxvLT5kYXRhWzFd
ICE9ICdUJykgeworCQkJCWRldl9kYmcoZGJnLCAidW5leHBlY3RlZCBwYWNrZXQ6IDB4JTAyeFxu
IiwKKwkJCQkJCWVsby0+ZGF0YVsxXSk7CisJCQkJYnJlYWs7CisJCQl9CisJCQlpbnB1dF9yZWdz
KGRldiwgcmVncyk7CisJCQlpbnB1dF9yZXBvcnRfYWJzKGRldiwgQUJTX1gsIChlbG8tPmRhdGFb
NF0gPDwgOCkgfCBlbG8tPmRhdGFbM10pOworCQkJaW5wdXRfcmVwb3J0X2FicyhkZXYsIEFCU19Z
LCAoZWxvLT5kYXRhWzZdIDw8IDgpIHwgZWxvLT5kYXRhWzVdKTsKKwkJCWlmIChlbG8tPmRhdGFb
Ml0gJiBFTE8xMF9QUkVTU1VSRSkKKwkJCQlpbnB1dF9yZXBvcnRfYWJzKGRldiwgQUJTX1BSRVNT
VVJFLAorCQkJCQkJKGVsby0+ZGF0YVs4XSA8PCA4KSB8IGVsby0+ZGF0YVs3XSk7CisJCQlpbnB1
dF9yZXBvcnRfa2V5KGRldiwgQlROX1RPVUNILCBlbG8tPmRhdGFbMl0gJiBFTE8xMF9UT1VDSCk7
CisJCQlpbnB1dF9zeW5jKGRldik7CiAJCQlicmVhazsKIAl9CisJZWxvLT5jc3VtICs9IGRhdGE7
CiB9CiAKIHN0YXRpYyB2b2lkIGVsb19wcm9jZXNzX2RhdGFfNihzdHJ1Y3QgZWxvKiBlbG8sIHVu
c2lnbmVkIGNoYXIgZGF0YSwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpCg==
------=_Part_14211_19442412.1153344861265--
