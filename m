Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132176AbRACEoL>; Tue, 2 Jan 2001 23:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131771AbRACEoB>; Tue, 2 Jan 2001 23:44:01 -0500
Received: from winds.org ([209.115.81.9]:36613 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S132176AbRACEnv>;
	Tue, 2 Jan 2001 23:43:51 -0500
Date: Tue, 2 Jan 2001 23:13:05 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (2) Compile warning fixes for gcc 2.97
Message-ID: <Pine.LNX.4.21.0101022306200.17456-300000@winds.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1943079249-815385542-978495185=:17456"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1943079249-815385542-978495185=:17456
Content-Type: TEXT/PLAIN; charset=US-ASCII

Here's a set of patches that fix compile warnings using gcc 2.97. The first
patch is purely a syntactical change (mainly removing default: statements that
do nothing), the second is a change in code structure that "looks" correct but
was brought on by the same type of warning where the case label has no effect.

So I split up the patch into two parts so we cna decide to throw out the second
if it is indeed incorrect. The 2nd patch (arp.patch) changes the following code

                switch (dev->type) {
                default:
                        break;
                case ARPHRD_ROSE:
#if defined(CONFIG_AX25) || defined(CONFIG_AX25_MODULE)
                case ARPHRD_AX25:
#if defined(CONFIG_NETROM) || defined(CONFIG_NETROM_MODULE)
                case ARPHRD_NETROM:
#endif
                        neigh->ops = &arp_broken_ops;
                        neigh->output = neigh->ops->output;
                        return 0;
#endif
                }


--to this:--


                switch (dev->type) {
                case ARPHRD_ROSE:
#if defined(CONFIG_AX25) || defined(CONFIG_AX25_MODULE)
                case ARPHRD_AX25:
#endif
#if defined(CONFIG_NETROM) || defined(CONFIG_NETROM_MODULE)
                case ARPHRD_NETROM:
#endif
                        neigh->ops = &arp_broken_ops;
                        neigh->output = neigh->ops->output;
                        return 0;
                }

---
Which I believe is really the correct flow for that switch statement.
If someone disagrees, just toss it and apply the first patch. :-)

Regards,
 Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: bstanoszek@comtime.com

--1943079249-815385542-978495185=:17456
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="gcc297.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0101022313050.17456@winds.org>
Content-Description: 
Content-Disposition: attachment; filename="gcc297.patch"

LS0tIGxpbnV4L2RyaXZlcnMvc291bmQvc2VxdWVuY2VyLmMuYmFrCVR1ZSBK
YW4gIDIgMjI6MzQ6NDQgMjAwMQ0KKysrIGxpbnV4L2RyaXZlcnMvc291bmQv
c2VxdWVuY2VyLmMJVHVlIEphbiAgMiAyMjozNjozMiAyMDAxDQpAQCAtNTEw
LDggKzUxMCw2IEBADQogCQkJCXZvaWNlID0gY2huOw0KIAkJCXN5bnRoX2Rl
dnNbZGV2XS0+YWZ0ZXJ0b3VjaChkZXYsIHZvaWNlLCBwYXJtKTsNCiAJCQli
cmVhazsNCi0NCi0JCWRlZmF1bHQ6DQogCX0NCiAjdW5kZWYgZGV2DQogI3Vu
ZGVmIGNtZA0KQEAgLTYxMyw4ICs2MTEsNiBAQA0KIAkJCWVsc2UJLyogTU9E
RSAxICovDQogCQkJCXN5bnRoX2RldnNbZGV2XS0+YmVuZGVyKGRldiwgY2hu
LCB3MTQpOw0KIAkJCWJyZWFrOw0KLQ0KLQkJZGVmYXVsdDoNCiAJfQ0KIH0N
CiANCkBAIC02ODMsOCArNjc5LDYgQEANCiAJCQkJc2VxX2NvcHlfdG9faW5w
dXQoKHVuc2lnbmVkIGNoYXIgKikgJnBhcm0sIDQpOw0KIAkJCX0NCiAJCQli
cmVhazsNCi0NCi0JCWRlZmF1bHQ6DQogCX0NCiANCiAJcmV0dXJuIFRJTUVS
X05PVF9BUk1FRDsNCkBAIC03MDAsOCArNjk0LDYgQEANCiAJCWNhc2UgTE9D
TF9TVEFSVEFVRElPOg0KIAkJCURNQWJ1Zl9zdGFydF9kZXZpY2VzKHBhcm0p
Ow0KIAkJCWJyZWFrOw0KLQ0KLQkJZGVmYXVsdDoNCiAJfQ0KIH0NCiANCkBA
IC04NTgsOCArODUwLDYgQEANCiAJCWNhc2UgRVZfU1lTRVg6DQogCQkJc2Vx
X3N5c2V4X21lc3NhZ2UocSk7DQogCQkJYnJlYWs7DQotDQotCQlkZWZhdWx0
Og0KIAl9DQogCXJldHVybiAwOw0KIH0NCi0tLSBsaW51eC9kcml2ZXJzL3Nv
dW5kL3NiX2Vzcy5jLmJhawlUdWUgSmFuICAyIDIyOjQwOjAxIDIwMDENCisr
KyBsaW51eC9kcml2ZXJzL3NvdW5kL3NiX2Vzcy5jCVR1ZSBKYW4gIDIgMjI6
NDM6MDUgMjAwMQ0KQEAgLTc2NiwxMiArNzY2LDYgQEANCiAJCWNhc2UgSU1P
REVfSU5QVVQ6DQogCQkJRE1BYnVmX2lucHV0aW50ciAoZGV2KTsNCiAJCQli
cmVhazsNCi0NCi0JCWNhc2UgSU1PREVfSU5JVDoNCi0JCQlicmVhazsNCi0N
Ci0JCWRlZmF1bHQ6DQotCQkJLyogcHJpbnRrKEtFUk5fV0FSTiAiRVNTOiBV
bmV4cGVjdGVkIGludGVycnVwdFxuIik7ICovDQogCX0NCiB9DQogDQpAQCAt
MTUyOSwxMyArMTUyMywxMSBAQA0KIA0KIHN0YXRpYyBpbnQgZXNzX2hhc19y
ZWNfbWl4ZXIgKGludCBzdWJtb2RlbCkNCiB7DQotCXN3aXRjaCAoc3VibW9k
ZWwpIHsNCi0JY2FzZSBTVUJNRExfRVMxODg3Og0KKwlpZihzdWJtb2RlbCA9
PSBTVUJNRExfRVMxODg3KQ0KIAkJcmV0dXJuIDE7DQotCWRlZmF1bHQ6DQor
CWVsc2UNCiAJCXJldHVybiAwOw0KLQl9Ow0KLX07DQorfQ0KIA0KICNpZmRl
ZiBGS1NfTE9HR0lORw0KIHN0YXRpYyBpbnQgZXNzX21peGVyX21vbl9yZWdz
W10NCi0tLSBsaW51eC9kcml2ZXJzL3NvdW5kL3NvdW5kX3RpbWVyLmMuYmFr
CVR1ZSBKYW4gIDIgMjI6NDQ6NTYgMjAwMQ0KKysrIGxpbnV4L2RyaXZlcnMv
c291bmQvc291bmRfdGltZXIuYwlUdWUgSmFuICAyIDIyOjQ1OjA2IDIwMDEN
CkBAIC0xNjQsOCArMTY0LDYgQEANCiAJCWNhc2UgVE1SX0VDSE86DQogCQkJ
c2VxX2NvcHlfdG9faW5wdXQoZXZlbnQsIDgpOw0KIAkJCWJyZWFrOw0KLQ0K
LQkJZGVmYXVsdDoNCiAJfQ0KIAlyZXR1cm4gVElNRVJfTk9UX0FSTUVEOw0K
IH0NCi0tLSBsaW51eC9mcy9pc29mcy9pbm9kZS5jLmJhawlUdWUgSmFuICAy
IDIyOjQ2OjU1IDIwMDENCisrKyBsaW51eC9mcy9pc29mcy9pbm9kZS5jCVR1
ZSBKYW4gIDIgMjI6NDc6MDEgMjAwMQ0KQEAgLTEyNjQsNyArMTI2NCw3IEBA
DQogCSAgICAodm9sdW1lX3NlcV9ubyAhPSAwKSAmJiAodm9sdW1lX3NlcV9u
byAhPSAxKSkgew0KIAkJcHJpbnRrKEtFUk5fV0FSTklORyAiTXVsdGktdm9s
dW1lIENEIHNvbWVob3cgZ290IG1vdW50ZWQuXG4iKTsNCiAJfSBlbHNlDQot
I2VuZGlmIElHTk9SRV9XUk9OR19NVUxUSV9WT0xVTUVfU1BFQ1MNCisjZW5k
aWYgLyogSUdOT1JFX1dST05HX01VTFRJX1ZPTFVNRV9TUEVDUyAqLw0KIAl7
DQogCQlpZiAoU19JU1JFRyhpbm9kZS0+aV9tb2RlKSkgew0KIAkJCWlub2Rl
LT5pX2ZvcCA9ICZnZW5lcmljX3JvX2ZvcHM7DQo=
--1943079249-815385542-978495185=:17456
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="arp.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0101022313051.17456@winds.org>
Content-Description: 
Content-Disposition: attachment; filename="arp.patch"

LS0tIGxpbnV4L25ldC9pcHY0L2FycC5jLmJhawlUdWUgSmFuICAyIDIyOjUz
OjMxIDIwMDENCisrKyBsaW51eC9uZXQvaXB2NC9hcnAuYwlUdWUgSmFuICAy
IDIyOjU2OjEzIDIwMDENCkBAIC0yNjcsNyArMjY3LDYgQEANCiAJCSAgIGlu
IG9sZCBwYXJhZGlnbS4NCiAJCSAqLw0KIA0KLSNpZiAxDQogCQkvKiBTby4u
LiB0aGVzZSAiYW1hdGV1ciIgZGV2aWNlcyBhcmUgaG9wZWxlc3MuDQogCQkg
ICBUaGUgb25seSB0aGluZywgdGhhdCBJIGNhbiBzYXkgbm93Og0KIAkJICAg
SXQgaXMgdmVyeSBzYWQgdGhhdCB3ZSBuZWVkIHRvIGtlZXAgdWdseSBvYnNv
bGV0ZQ0KQEAgLTI4MCwyMCArMjc5LDE4IEBADQogCQkgICBJIHdvbmRlciB3
aHkgcGVvcGxlIGJlbGlldmUgdGhhdCB0aGV5IHdvcmsuDQogCQkgKi8NCiAJ
CXN3aXRjaCAoZGV2LT50eXBlKSB7DQotCQlkZWZhdWx0Og0KLQkJCWJyZWFr
Ow0KIAkJY2FzZSBBUlBIUkRfUk9TRToJDQogI2lmIGRlZmluZWQoQ09ORklH
X0FYMjUpIHx8IGRlZmluZWQoQ09ORklHX0FYMjVfTU9EVUxFKQ0KIAkJY2Fz
ZSBBUlBIUkRfQVgyNToNCisjZW5kaWYNCiAjaWYgZGVmaW5lZChDT05GSUdf
TkVUUk9NKSB8fCBkZWZpbmVkKENPTkZJR19ORVRST01fTU9EVUxFKQ0KIAkJ
Y2FzZSBBUlBIUkRfTkVUUk9NOg0KICNlbmRpZg0KIAkJCW5laWdoLT5vcHMg
PSAmYXJwX2Jyb2tlbl9vcHM7DQogCQkJbmVpZ2gtPm91dHB1dCA9IG5laWdo
LT5vcHMtPm91dHB1dDsNCiAJCQlyZXR1cm4gMDsNCi0jZW5kaWYNCiAJCX0N
Ci0jZW5kaWYNCisNCiAJCWlmIChuZWlnaC0+dHlwZSA9PSBSVE5fTVVMVElD
QVNUKSB7DQogCQkJbmVpZ2gtPm51ZF9zdGF0ZSA9IE5VRF9OT0FSUDsNCiAJ
CQlhcnBfbWNfbWFwKGFkZHIsIG5laWdoLT5oYSwgZGV2LCAxKTsNCg==
--1943079249-815385542-978495185=:17456--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
