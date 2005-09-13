Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932679AbVIMPgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbVIMPgJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVIMPgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:36:08 -0400
Received: from qproxy.gmail.com ([72.14.204.195]:26412 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932679AbVIMPgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:36:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=toBXsAVTXG16rqYrvRw3PuOja8DZPgCox0Ljnmnv2KaEMOcrXEbvbWUYQ4Cpb2ddmvZJVo8Df2XJ1z/yx+JaxPESuBzZJI1wWKmAIMp0nvRNJh1uxe4/enyBmkCsyw1nnKNR2ldLJPb6lL+sy3AQZj/6CTKypgVOyAjoObPqcD4=
Message-ID: <e778aab0050913083656dc8c8f@mail.gmail.com>
Date: Tue, 13 Sep 2005 11:36:06 -0400
From: roy wood <roy.wood@gmail.com>
Reply-To: roy.wood@gmail.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/input/joystick/interact.c ; Linux 2.6.13-1
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7634_23351716.1126625766474"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_7634_23351716.1126625766474
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch to the Interact joystick driver adds support for the
"RaiderPro Digital" model of joystick from Interact.  The patch is
made against kernel version 2.6.13-1.

I've tested this using a RaiderPro and it works perfectly.  I do not
have versions of the other supported Interact controllers that this
driver supports, so I cannot attest to whether I've broken things or
not (hopefully not).

This is my first patch submission, so please don't jump on my head too
hard if I missed something in the LKML FAQ (I did read it!).

Assuming anyone's read this far, I'd appreciate direct feedback via
email on this patch, since I'm not a regular LKML subscriber.  I'll
poll the archive for a week or so to keep an eye on the thread, but
direct email would guarantee I don't miss anything.

Also, apparently I need to send this directly to Linus to get this
into the tree.  Anyone care to tell me the best email address to use
to do that?  I promise not to foreward it to recruiters at MS.  :-)



--- linux-2.6.13.1/drivers/input/joystick/interact.c=092005-09-09
22:42:58.000000000 -0400
+++ linux-2.6.13.1-Interact/drivers/input/joystick/interact.c=092005-09-12
16:07:50.000000000 -0400
@@ -5,10 +5,16 @@
  *
  *  Based on the work of:
  *=09Toby Deshane
+ *
+ *  History:
+ *  --------
+ *  2005-09-12: rrwood - Add support for RaiderPro
  */
=20
 /*
  * InterAct digital gamepad/joystick driver for Linux
+ *
+ * Note that the "new" Interact web site is http://www.speed-link.com/
  */
=20
 /*
@@ -45,45 +51,66 @@
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
=20
-#define INTERACT_MAX_START=09600=09/* 400 us */
-#define INTERACT_MAX_STROBE=0960=09/* 40 us */
+#define INTERACT_MAX_START=09600=09/* 600 us */
+#define INTERACT_MAX_STROBE=0960=09/* 60 us */
 #define INTERACT_MAX_LENGTH=0932=09/* 32 bits */
=20
 #define INTERACT_TYPE_HHFX=090=09/* HammerHead/FX */
 #define INTERACT_TYPE_PP8D=091=09/* ProPad 8 */
+#define INTERACT_TYPE_RAIDERPRO=092=09/* RaiderPro */
=20
 struct interact {
-=09struct gameport *gameport;
-=09struct input_dev dev;
-=09int bads;
-=09int reads;
-=09unsigned char type;
-=09unsigned char length;
-=09char phys[32];
+=09struct gameport *gameport; /* Kernel gameport struct ptr */
+=09struct input_dev dev;      /* Kernel input_dev struct ptr */
+=09int bads;                  /* Count of bad reads from joystick */
+=09int reads;                 /* Count of total reads from joystick */
+=09unsigned char type;        /* Joystick model index */
+=09unsigned char length;      /* Number of bits in input packets */
+=09char phys[32];             /* Physical device name */
 };
=20
-static short interact_abs_hhfx[] =3D
+
+/* I think the original purpose of setting up lists of controller
+ * axes/buttons was to provide a single location to maintain such
+ * information.  Although the table-based approach certainly makes=20
+ * the interact_connect() code below MUCH simpler and cleaner, the
+ * interact_poll() code ends up being very hard to read, unfortunately.
+ *
+ * I was tempted to either rewrite interact_poll() in a clearer fashion,
+ * or to implement a more comprehensive table-driven decoding approach
+ * (with values for offset, masking, shifting of each value).  I'm a
+ * bit leery of making such massive change though, since I don't have the
+ * controllers to test the result.  Instead, I'll just add support=20
+ * for the RaiderPro as clearly as I can.....
+ */
+
+static short interact_abs_hhfx[] =3D=20
 =09{ ABS_RX, ABS_RY, ABS_X, ABS_Y, ABS_HAT0X, ABS_HAT0Y, -1 };
 static short interact_abs_pp8d[] =3D
 =09{ ABS_X, ABS_Y, -1 };
+static short interact_abs_raiderpro[] =3D=20
+=09{ ABS_X, ABS_Y, ABS_THROTTLE, ABS_HAT0X, ABS_HAT0Y, -1 };
=20
 static short interact_btn_hhfx[] =3D
 =09{ BTN_TR, BTN_X, BTN_Y, BTN_Z, BTN_A, BTN_B, BTN_C, BTN_TL, BTN_TL2,
BTN_TR2, BTN_MODE, BTN_SELECT, -1 };
 static short interact_btn_pp8d[] =3D
 =09{ BTN_C, BTN_TL, BTN_TR, BTN_A, BTN_B, BTN_Y, BTN_Z, BTN_X, -1 };
+static short interact_btn_raiderpro[] =3D
+=09{ BTN_TRIGGER, BTN_THUMB, BTN_BASE, BTN_BASE2, BTN_BASE3, BTN_BASE4, -1=
 };
=20
 struct interact_type {
-=09int id;
-=09short *abs;
-=09short *btn;
-=09char *name;
-=09unsigned char length;
-=09unsigned char b8;
+=09int id;               /* Numeric device ID read during configuration */
+=09short *abs;           /* Pointer to list of axes identifiers */
+=09short *btn;           /* Pointer to list of button identifiers */
+=09char *name;           /* Pointer to device model descriptor string */
+=09unsigned char length; /* Number of bits in input data packet */
+=09unsigned char b8;     /* Count of analog (non-hat) axes in *abs list */
 };
=20
 static struct interact_type interact_type[] =3D {
 =09{ 0x6202, interact_abs_hhfx, interact_btn_hhfx, "InterAct
HammerHead/FX",    32, 4 },
 =09{ 0x53f8, interact_abs_pp8d, interact_btn_pp8d, "InterAct ProPad 8
Digital", 16, 0 },
+=09{ 0x51F8, interact_abs_raiderpro, interact_btn_raiderpro, "InterAct
RaiderPro Digital",    32, 3 },
 =09{ 0 }};
=20
 /*
@@ -137,44 +164,70 @@
 =09interact->reads++;
=20
 =09if (interact_read_packet(interact->gameport, interact->length, data)
< interact->length) {
+=09=09/* Couldn't read a full packet, so update the bad-count,=20
+=09=09 * queue another read, and get out */
 =09=09interact->bads++;
-=09} else {
+=09=09input_sync(dev);
+=09=09return;
+=09}
+
+/* During development and debugging, it's nice to see all the read data */
+/* printk("d0:%08X d1:%08X d2:%08X\n", data[0], data[1], data[2]); */
=20
+=09
+=09if (INTERACT_MAX_LENGTH - interact->length > 0) {
+=09=09/* If data packets are less than max length, shift them
+=09=09 * for easier processing below (ProPad goofiness) */
 =09=09for (i =3D 0; i < 3; i++)
 =09=09=09data[i] <<=3D INTERACT_MAX_LENGTH - interact->length;
+=09}
=20
-=09=09switch (interact->type) {
-
-=09=09=09case INTERACT_TYPE_HHFX:
-
-=09=09=09=09for (i =3D 0; i < 4; i++)
-=09=09=09=09=09input_report_abs(dev, interact_abs_hhfx[i], (data[i & 1] >>=
 ((i
>> 1) << 3)) & 0xff);
-
-=09=09=09=09for (i =3D 0; i < 2; i++)
-=09=09=09=09=09input_report_abs(dev, ABS_HAT0Y - i,
-=09=09=09=09=09=09((data[1] >> ((i << 1) + 17)) & 1)  - ((data[1] >> ((i <=
< 1) +
16)) & 1));
-
-=09=09=09=09for (i =3D 0; i < 8; i++)
-=09=09=09=09=09input_report_key(dev, interact_btn_hhfx[i], (data[0] >> (i =
+ 16)) & 1);
-
-=09=09=09=09for (i =3D 0; i < 4; i++)
-=09=09=09=09=09input_report_key(dev, interact_btn_hhfx[i + 8], (data[1] >>=
 (i +
20)) & 1);
-
-=09=09=09=09break;
-
-=09=09=09case INTERACT_TYPE_PP8D:
+=09
+=09/* Unpack the data we read and pass along the info to the input layer *=
/
+=09
+=09if (interact->type =3D=3D INTERACT_TYPE_HHFX) {
+=09=09for (i =3D 0; i < 4; i++)
+=09=09=09input_report_abs(dev, interact_abs_hhfx[i], (data[i & 1] >> ((i >=
>
1) << 3)) & 0xff);
=20
-=09=09=09=09for (i =3D 0; i < 2; i++)
-=09=09=09=09=09input_report_abs(dev, interact_abs_pp8d[i],
-=09=09=09=09=09=09((data[0] >> ((i << 1) + 20)) & 1)  - ((data[0] >> ((i <=
< 1) +
21)) & 1));
+=09=09for (i =3D 0; i < 2; i++)
+=09=09=09input_report_abs(dev, ABS_HAT0Y - i, ((data[1] >> ((i << 1) + 17)=
)
& 1)  - ((data[1] >> ((i << 1) + 16)) & 1));
=20
-=09=09=09=09for (i =3D 0; i < 8; i++)
-=09=09=09=09=09input_report_key(dev, interact_btn_pp8d[i], (data[1] >> (i =
+ 16)) & 1);
+=09=09for (i =3D 0; i < 8; i++)
+=09=09=09input_report_key(dev, interact_btn_hhfx[i], (data[0] >> (i + 16))=
 & 1);
=20
-=09=09=09=09break;
-=09=09}
+=09=09for (i =3D 0; i < 4; i++)
+=09=09=09input_report_key(dev, interact_btn_hhfx[i + 8], (data[1] >> (i + =
20)) & 1);
+=09}
+=09else if (interact->type =3D=3D INTERACT_TYPE_PP8D) {
+=09=09for (i =3D 0; i < 2; i++)
+=09=09=09input_report_abs(dev, interact_abs_pp8d[i], ((data[0] >> ((i << 1=
)
+ 20)) & 1)  - ((data[0] >> ((i << 1) + 21)) & 1));
+
+=09=09for (i =3D 0; i < 8; i++)
+=09=09=09input_report_key(dev, interact_btn_pp8d[i], (data[1] >> (i + 16))=
 & 1);
+
+=09}=09
+=09else if (interact->type =3D=3D INTERACT_TYPE_RAIDERPRO) {
+=09=09int hatRight =3D (data[0] >> 20) & 0x01;
+=09=09int hatLeft =3D  (data[0] >> 21) & 0x01;
+=09=09int hatDown =3D  (data[0] >> 22) & 0x01;
+=09=09int hatUp =3D    (data[0] >> 23) & 0x01;
+=09=09
+=09=09input_report_abs(dev, ABS_HAT0X,    hatRight - hatLeft);
+=09=09input_report_abs(dev, ABS_HAT0Y,    hatUp - hatDown);
+=09=09
+=09=09input_report_abs(dev, ABS_X,        (data[0] >> 8) & 0xff);
+=09=09input_report_abs(dev, ABS_Y,        (data[1] >> 8) & 0xff);
+=09=09input_report_abs(dev, ABS_THROTTLE, data[1] & 0xff);
+
+=09=09input_report_key(dev, BTN_BASE4,    (data[1] >> 16) & 1);
+=09=09input_report_key(dev, BTN_BASE2,    (data[1] >> 19) & 1);
+=09=09input_report_key(dev, BTN_BASE3,    (data[1] >> 20) & 1);
+=09=09input_report_key(dev, BTN_THUMB,    (data[1] >> 21) & 1);
+=09=09input_report_key(dev, BTN_BASE,     (data[1] >> 22) & 1);
+=09=09input_report_key(dev, BTN_TRIGGER,  (data[1] >> 23) & 1);
 =09}
=20
+=09/* Queue another read */
 =09input_sync(dev);
 }
=20
@@ -235,7 +288,7 @@
 =09=09=09break;
=20
 =09if (!interact_type[i].length) {
-=09=09printk(KERN_WARNING "interact.c: Unknown joystick on %s. [len %d d0
%08x d1 %08x i2 %08x]\n",
+=09=09printk(KERN_WARNING "interact.c: Unknown joystick on %s. [len %d d0
%08x d1 %08x d2 %08x]\n",
 =09=09=09gameport->phys, i, data[0], data[1], data[2]);
 =09=09err =3D -ENODEV;
 =09=09goto fail2;
@@ -262,6 +315,10 @@
=20
 =09interact->dev.evbit[0] =3D BIT(EV_KEY) | BIT(EV_ABS);
=20
+=09/* This is the one place it's nice to have tables of the axes/buttons,
+=09 * since it makes it so easy to report the controller characteristics
+=09 * to the kernel's input layer */
+
 =09for (i =3D 0; (t =3D interact_type[interact->type].abs[i]) >=3D 0; i++)=
 {
 =09=09set_bit(t, interact->dev.absbit);
 =09=09if (i < interact_type[interact->type].b8) {

------=_Part_7634_23351716.1126625766474
Content-Type: text/x-patch; name="interact.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="interact.diff"

LS0tIGxpbnV4LTIuNi4xMy4xL2RyaXZlcnMvaW5wdXQvam95c3RpY2svaW50ZXJhY3QuYwkyMDA1
LTA5LTA5IDIyOjQyOjU4LjAwMDAwMDAwMCAtMDQwMAorKysgbGludXgtMi42LjEzLjEtSW50ZXJh
Y3QvZHJpdmVycy9pbnB1dC9qb3lzdGljay9pbnRlcmFjdC5jCTIwMDUtMDktMTIgMTY6MDc6NTAu
MDAwMDAwMDAwIC0wNDAwCkBAIC01LDEwICs1LDE2IEBACiAgKgogICogIEJhc2VkIG9uIHRoZSB3
b3JrIG9mOgogICoJVG9ieSBEZXNoYW5lCisgKgorICogIEhpc3Rvcnk6CisgKiAgLS0tLS0tLS0K
KyAqICAyMDA1LTA5LTEyOiBycndvb2QgLSBBZGQgc3VwcG9ydCBmb3IgUmFpZGVyUHJvCiAgKi8K
IAogLyoKICAqIEludGVyQWN0IGRpZ2l0YWwgZ2FtZXBhZC9qb3lzdGljayBkcml2ZXIgZm9yIExp
bnV4CisgKgorICogTm90ZSB0aGF0IHRoZSAibmV3IiBJbnRlcmFjdCB3ZWIgc2l0ZSBpcyBodHRw
Oi8vd3d3LnNwZWVkLWxpbmsuY29tLwogICovCiAKIC8qCkBAIC00NSw0NSArNTEsNjYgQEAKIE1P
RFVMRV9ERVNDUklQVElPTihEUklWRVJfREVTQyk7CiBNT0RVTEVfTElDRU5TRSgiR1BMIik7CiAK
LSNkZWZpbmUgSU5URVJBQ1RfTUFYX1NUQVJUCTYwMAkvKiA0MDAgdXMgKi8KLSNkZWZpbmUgSU5U
RVJBQ1RfTUFYX1NUUk9CRQk2MAkvKiA0MCB1cyAqLworI2RlZmluZSBJTlRFUkFDVF9NQVhfU1RB
UlQJNjAwCS8qIDYwMCB1cyAqLworI2RlZmluZSBJTlRFUkFDVF9NQVhfU1RST0JFCTYwCS8qIDYw
IHVzICovCiAjZGVmaW5lIElOVEVSQUNUX01BWF9MRU5HVEgJMzIJLyogMzIgYml0cyAqLwogCiAj
ZGVmaW5lIElOVEVSQUNUX1RZUEVfSEhGWAkwCS8qIEhhbW1lckhlYWQvRlggKi8KICNkZWZpbmUg
SU5URVJBQ1RfVFlQRV9QUDhECTEJLyogUHJvUGFkIDggKi8KKyNkZWZpbmUgSU5URVJBQ1RfVFlQ
RV9SQUlERVJQUk8JMgkvKiBSYWlkZXJQcm8gKi8KIAogc3RydWN0IGludGVyYWN0IHsKLQlzdHJ1
Y3QgZ2FtZXBvcnQgKmdhbWVwb3J0OwotCXN0cnVjdCBpbnB1dF9kZXYgZGV2OwotCWludCBiYWRz
OwotCWludCByZWFkczsKLQl1bnNpZ25lZCBjaGFyIHR5cGU7Ci0JdW5zaWduZWQgY2hhciBsZW5n
dGg7Ci0JY2hhciBwaHlzWzMyXTsKKwlzdHJ1Y3QgZ2FtZXBvcnQgKmdhbWVwb3J0OyAvKiBLZXJu
ZWwgZ2FtZXBvcnQgc3RydWN0IHB0ciAqLworCXN0cnVjdCBpbnB1dF9kZXYgZGV2OyAgICAgIC8q
IEtlcm5lbCBpbnB1dF9kZXYgc3RydWN0IHB0ciAqLworCWludCBiYWRzOyAgICAgICAgICAgICAg
ICAgIC8qIENvdW50IG9mIGJhZCByZWFkcyBmcm9tIGpveXN0aWNrICovCisJaW50IHJlYWRzOyAg
ICAgICAgICAgICAgICAgLyogQ291bnQgb2YgdG90YWwgcmVhZHMgZnJvbSBqb3lzdGljayAqLwor
CXVuc2lnbmVkIGNoYXIgdHlwZTsgICAgICAgIC8qIEpveXN0aWNrIG1vZGVsIGluZGV4ICovCisJ
dW5zaWduZWQgY2hhciBsZW5ndGg7ICAgICAgLyogTnVtYmVyIG9mIGJpdHMgaW4gaW5wdXQgcGFj
a2V0cyAqLworCWNoYXIgcGh5c1szMl07ICAgICAgICAgICAgIC8qIFBoeXNpY2FsIGRldmljZSBu
YW1lICovCiB9OwogCi1zdGF0aWMgc2hvcnQgaW50ZXJhY3RfYWJzX2hoZnhbXSA9CisKKy8qIEkg
dGhpbmsgdGhlIG9yaWdpbmFsIHB1cnBvc2Ugb2Ygc2V0dGluZyB1cCBsaXN0cyBvZiBjb250cm9s
bGVyCisgKiBheGVzL2J1dHRvbnMgd2FzIHRvIHByb3ZpZGUgYSBzaW5nbGUgbG9jYXRpb24gdG8g
bWFpbnRhaW4gc3VjaAorICogaW5mb3JtYXRpb24uICBBbHRob3VnaCB0aGUgdGFibGUtYmFzZWQg
YXBwcm9hY2ggY2VydGFpbmx5IG1ha2VzIAorICogdGhlIGludGVyYWN0X2Nvbm5lY3QoKSBjb2Rl
IGJlbG93IE1VQ0ggc2ltcGxlciBhbmQgY2xlYW5lciwgdGhlCisgKiBpbnRlcmFjdF9wb2xsKCkg
Y29kZSBlbmRzIHVwIGJlaW5nIHZlcnkgaGFyZCB0byByZWFkLCB1bmZvcnR1bmF0ZWx5LgorICoK
KyAqIEkgd2FzIHRlbXB0ZWQgdG8gZWl0aGVyIHJld3JpdGUgaW50ZXJhY3RfcG9sbCgpIGluIGEg
Y2xlYXJlciBmYXNoaW9uLAorICogb3IgdG8gaW1wbGVtZW50IGEgbW9yZSBjb21wcmVoZW5zaXZl
IHRhYmxlLWRyaXZlbiBkZWNvZGluZyBhcHByb2FjaAorICogKHdpdGggdmFsdWVzIGZvciBvZmZz
ZXQsIG1hc2tpbmcsIHNoaWZ0aW5nIG9mIGVhY2ggdmFsdWUpLiAgSSdtIGEKKyAqIGJpdCBsZWVy
eSBvZiBtYWtpbmcgc3VjaCBtYXNzaXZlIGNoYW5nZSB0aG91Z2gsIHNpbmNlIEkgZG9uJ3QgaGF2
ZSB0aGUKKyAqIGNvbnRyb2xsZXJzIHRvIHRlc3QgdGhlIHJlc3VsdC4gIEluc3RlYWQsIEknbGwg
anVzdCBhZGQgc3VwcG9ydCAKKyAqIGZvciB0aGUgUmFpZGVyUHJvIGFzIGNsZWFybHkgYXMgSSBj
YW4uLi4uLgorICovCisKK3N0YXRpYyBzaG9ydCBpbnRlcmFjdF9hYnNfaGhmeFtdID0gCiAJeyBB
QlNfUlgsIEFCU19SWSwgQUJTX1gsIEFCU19ZLCBBQlNfSEFUMFgsIEFCU19IQVQwWSwgLTEgfTsK
IHN0YXRpYyBzaG9ydCBpbnRlcmFjdF9hYnNfcHA4ZFtdID0KIAl7IEFCU19YLCBBQlNfWSwgLTEg
fTsKK3N0YXRpYyBzaG9ydCBpbnRlcmFjdF9hYnNfcmFpZGVycHJvW10gPSAKKwl7IEFCU19YLCBB
QlNfWSwgQUJTX1RIUk9UVExFLCBBQlNfSEFUMFgsIEFCU19IQVQwWSwgLTEgfTsKIAogc3RhdGlj
IHNob3J0IGludGVyYWN0X2J0bl9oaGZ4W10gPQogCXsgQlROX1RSLCBCVE5fWCwgQlROX1ksIEJU
Tl9aLCBCVE5fQSwgQlROX0IsIEJUTl9DLCBCVE5fVEwsIEJUTl9UTDIsIEJUTl9UUjIsIEJUTl9N
T0RFLCBCVE5fU0VMRUNULCAtMSB9Owogc3RhdGljIHNob3J0IGludGVyYWN0X2J0bl9wcDhkW10g
PQogCXsgQlROX0MsIEJUTl9UTCwgQlROX1RSLCBCVE5fQSwgQlROX0IsIEJUTl9ZLCBCVE5fWiwg
QlROX1gsIC0xIH07CitzdGF0aWMgc2hvcnQgaW50ZXJhY3RfYnRuX3JhaWRlcnByb1tdID0KKwl7
IEJUTl9UUklHR0VSLCBCVE5fVEhVTUIsIEJUTl9CQVNFLCBCVE5fQkFTRTIsIEJUTl9CQVNFMywg
QlROX0JBU0U0LCAtMSB9OwogCiBzdHJ1Y3QgaW50ZXJhY3RfdHlwZSB7Ci0JaW50IGlkOwotCXNo
b3J0ICphYnM7Ci0Jc2hvcnQgKmJ0bjsKLQljaGFyICpuYW1lOwotCXVuc2lnbmVkIGNoYXIgbGVu
Z3RoOwotCXVuc2lnbmVkIGNoYXIgYjg7CisJaW50IGlkOyAgICAgICAgICAgICAgIC8qIE51bWVy
aWMgZGV2aWNlIElEIHJlYWQgZHVyaW5nIGNvbmZpZ3VyYXRpb24gKi8KKwlzaG9ydCAqYWJzOyAg
ICAgICAgICAgLyogUG9pbnRlciB0byBsaXN0IG9mIGF4ZXMgaWRlbnRpZmllcnMgKi8KKwlzaG9y
dCAqYnRuOyAgICAgICAgICAgLyogUG9pbnRlciB0byBsaXN0IG9mIGJ1dHRvbiBpZGVudGlmaWVy
cyAqLworCWNoYXIgKm5hbWU7ICAgICAgICAgICAvKiBQb2ludGVyIHRvIGRldmljZSBtb2RlbCBk
ZXNjcmlwdG9yIHN0cmluZyAqLworCXVuc2lnbmVkIGNoYXIgbGVuZ3RoOyAvKiBOdW1iZXIgb2Yg
Yml0cyBpbiBpbnB1dCBkYXRhIHBhY2tldCAqLworCXVuc2lnbmVkIGNoYXIgYjg7ICAgICAvKiBD
b3VudCBvZiBhbmFsb2cgKG5vbi1oYXQpIGF4ZXMgaW4gKmFicyBsaXN0ICovCiB9OwogCiBzdGF0
aWMgc3RydWN0IGludGVyYWN0X3R5cGUgaW50ZXJhY3RfdHlwZVtdID0gewogCXsgMHg2MjAyLCBp
bnRlcmFjdF9hYnNfaGhmeCwgaW50ZXJhY3RfYnRuX2hoZngsICJJbnRlckFjdCBIYW1tZXJIZWFk
L0ZYIiwgICAgMzIsIDQgfSwKIAl7IDB4NTNmOCwgaW50ZXJhY3RfYWJzX3BwOGQsIGludGVyYWN0
X2J0bl9wcDhkLCAiSW50ZXJBY3QgUHJvUGFkIDggRGlnaXRhbCIsIDE2LCAwIH0sCisJeyAweDUx
RjgsIGludGVyYWN0X2Fic19yYWlkZXJwcm8sIGludGVyYWN0X2J0bl9yYWlkZXJwcm8sICJJbnRl
ckFjdCBSYWlkZXJQcm8gRGlnaXRhbCIsICAgIDMyLCAzIH0sCiAJeyAwIH19OwogCiAvKgpAQCAt
MTM3LDQ0ICsxNjQsNzAgQEAKIAlpbnRlcmFjdC0+cmVhZHMrKzsKIAogCWlmIChpbnRlcmFjdF9y
ZWFkX3BhY2tldChpbnRlcmFjdC0+Z2FtZXBvcnQsIGludGVyYWN0LT5sZW5ndGgsIGRhdGEpIDwg
aW50ZXJhY3QtPmxlbmd0aCkgeworCQkvKiBDb3VsZG4ndCByZWFkIGEgZnVsbCBwYWNrZXQsIHNv
IHVwZGF0ZSB0aGUgYmFkLWNvdW50LCAKKwkJICogcXVldWUgYW5vdGhlciByZWFkLCBhbmQgZ2V0
IG91dCAqLwogCQlpbnRlcmFjdC0+YmFkcysrOwotCX0gZWxzZSB7CisJCWlucHV0X3N5bmMoZGV2
KTsKKwkJcmV0dXJuOworCX0KKworLyogRHVyaW5nIGRldmVsb3BtZW50IGFuZCBkZWJ1Z2dpbmcs
IGl0J3MgbmljZSB0byBzZWUgYWxsIHRoZSByZWFkIGRhdGEgKi8KKy8qIHByaW50aygiZDA6JTA4
WCBkMTolMDhYIGQyOiUwOFhcbiIsIGRhdGFbMF0sIGRhdGFbMV0sIGRhdGFbMl0pOyAqLwogCisJ
CisJaWYgKElOVEVSQUNUX01BWF9MRU5HVEggLSBpbnRlcmFjdC0+bGVuZ3RoID4gMCkgeworCQkv
KiBJZiBkYXRhIHBhY2tldHMgYXJlIGxlc3MgdGhhbiBtYXggbGVuZ3RoLCBzaGlmdCB0aGVtCisJ
CSAqIGZvciBlYXNpZXIgcHJvY2Vzc2luZyBiZWxvdyAoUHJvUGFkIGdvb2ZpbmVzcykgKi8KIAkJ
Zm9yIChpID0gMDsgaSA8IDM7IGkrKykKIAkJCWRhdGFbaV0gPDw9IElOVEVSQUNUX01BWF9MRU5H
VEggLSBpbnRlcmFjdC0+bGVuZ3RoOworCX0KIAotCQlzd2l0Y2ggKGludGVyYWN0LT50eXBlKSB7
Ci0KLQkJCWNhc2UgSU5URVJBQ1RfVFlQRV9ISEZYOgotCi0JCQkJZm9yIChpID0gMDsgaSA8IDQ7
IGkrKykKLQkJCQkJaW5wdXRfcmVwb3J0X2FicyhkZXYsIGludGVyYWN0X2Fic19oaGZ4W2ldLCAo
ZGF0YVtpICYgMV0gPj4gKChpID4+IDEpIDw8IDMpKSAmIDB4ZmYpOwotCi0JCQkJZm9yIChpID0g
MDsgaSA8IDI7IGkrKykKLQkJCQkJaW5wdXRfcmVwb3J0X2FicyhkZXYsIEFCU19IQVQwWSAtIGks
Ci0JCQkJCQkoKGRhdGFbMV0gPj4gKChpIDw8IDEpICsgMTcpKSAmIDEpICAtICgoZGF0YVsxXSA+
PiAoKGkgPDwgMSkgKyAxNikpICYgMSkpOwotCi0JCQkJZm9yIChpID0gMDsgaSA8IDg7IGkrKykK
LQkJCQkJaW5wdXRfcmVwb3J0X2tleShkZXYsIGludGVyYWN0X2J0bl9oaGZ4W2ldLCAoZGF0YVsw
XSA+PiAoaSArIDE2KSkgJiAxKTsKLQotCQkJCWZvciAoaSA9IDA7IGkgPCA0OyBpKyspCi0JCQkJ
CWlucHV0X3JlcG9ydF9rZXkoZGV2LCBpbnRlcmFjdF9idG5faGhmeFtpICsgOF0sIChkYXRhWzFd
ID4+IChpICsgMjApKSAmIDEpOwotCi0JCQkJYnJlYWs7Ci0KLQkJCWNhc2UgSU5URVJBQ1RfVFlQ
RV9QUDhEOgorCQorCS8qIFVucGFjayB0aGUgZGF0YSB3ZSByZWFkIGFuZCBwYXNzIGFsb25nIHRo
ZSBpbmZvIHRvIHRoZSBpbnB1dCBsYXllciAqLworCQorCWlmIChpbnRlcmFjdC0+dHlwZSA9PSBJ
TlRFUkFDVF9UWVBFX0hIRlgpIHsKKwkJZm9yIChpID0gMDsgaSA8IDQ7IGkrKykKKwkJCWlucHV0
X3JlcG9ydF9hYnMoZGV2LCBpbnRlcmFjdF9hYnNfaGhmeFtpXSwgKGRhdGFbaSAmIDFdID4+ICgo
aSA+PiAxKSA8PCAzKSkgJiAweGZmKTsKIAotCQkJCWZvciAoaSA9IDA7IGkgPCAyOyBpKyspCi0J
CQkJCWlucHV0X3JlcG9ydF9hYnMoZGV2LCBpbnRlcmFjdF9hYnNfcHA4ZFtpXSwKLQkJCQkJCSgo
ZGF0YVswXSA+PiAoKGkgPDwgMSkgKyAyMCkpICYgMSkgIC0gKChkYXRhWzBdID4+ICgoaSA8PCAx
KSArIDIxKSkgJiAxKSk7CisJCWZvciAoaSA9IDA7IGkgPCAyOyBpKyspCisJCQlpbnB1dF9yZXBv
cnRfYWJzKGRldiwgQUJTX0hBVDBZIC0gaSwgKChkYXRhWzFdID4+ICgoaSA8PCAxKSArIDE3KSkg
JiAxKSAgLSAoKGRhdGFbMV0gPj4gKChpIDw8IDEpICsgMTYpKSAmIDEpKTsKIAotCQkJCWZvciAo
aSA9IDA7IGkgPCA4OyBpKyspCi0JCQkJCWlucHV0X3JlcG9ydF9rZXkoZGV2LCBpbnRlcmFjdF9i
dG5fcHA4ZFtpXSwgKGRhdGFbMV0gPj4gKGkgKyAxNikpICYgMSk7CisJCWZvciAoaSA9IDA7IGkg
PCA4OyBpKyspCisJCQlpbnB1dF9yZXBvcnRfa2V5KGRldiwgaW50ZXJhY3RfYnRuX2hoZnhbaV0s
IChkYXRhWzBdID4+IChpICsgMTYpKSAmIDEpOwogCi0JCQkJYnJlYWs7Ci0JCX0KKwkJZm9yIChp
ID0gMDsgaSA8IDQ7IGkrKykKKwkJCWlucHV0X3JlcG9ydF9rZXkoZGV2LCBpbnRlcmFjdF9idG5f
aGhmeFtpICsgOF0sIChkYXRhWzFdID4+IChpICsgMjApKSAmIDEpOworCX0KKwllbHNlIGlmIChp
bnRlcmFjdC0+dHlwZSA9PSBJTlRFUkFDVF9UWVBFX1BQOEQpIHsKKwkJZm9yIChpID0gMDsgaSA8
IDI7IGkrKykKKwkJCWlucHV0X3JlcG9ydF9hYnMoZGV2LCBpbnRlcmFjdF9hYnNfcHA4ZFtpXSwg
KChkYXRhWzBdID4+ICgoaSA8PCAxKSArIDIwKSkgJiAxKSAgLSAoKGRhdGFbMF0gPj4gKChpIDw8
IDEpICsgMjEpKSAmIDEpKTsKKworCQlmb3IgKGkgPSAwOyBpIDwgODsgaSsrKQorCQkJaW5wdXRf
cmVwb3J0X2tleShkZXYsIGludGVyYWN0X2J0bl9wcDhkW2ldLCAoZGF0YVsxXSA+PiAoaSArIDE2
KSkgJiAxKTsKKworCX0JCisJZWxzZSBpZiAoaW50ZXJhY3QtPnR5cGUgPT0gSU5URVJBQ1RfVFlQ
RV9SQUlERVJQUk8pIHsKKwkJaW50IGhhdFJpZ2h0ID0gKGRhdGFbMF0gPj4gMjApICYgMHgwMTsK
KwkJaW50IGhhdExlZnQgPSAgKGRhdGFbMF0gPj4gMjEpICYgMHgwMTsKKwkJaW50IGhhdERvd24g
PSAgKGRhdGFbMF0gPj4gMjIpICYgMHgwMTsKKwkJaW50IGhhdFVwID0gICAgKGRhdGFbMF0gPj4g
MjMpICYgMHgwMTsKKwkJCisJCWlucHV0X3JlcG9ydF9hYnMoZGV2LCBBQlNfSEFUMFgsICAgIGhh
dFJpZ2h0IC0gaGF0TGVmdCk7CisJCWlucHV0X3JlcG9ydF9hYnMoZGV2LCBBQlNfSEFUMFksICAg
IGhhdFVwIC0gaGF0RG93bik7CisJCQorCQlpbnB1dF9yZXBvcnRfYWJzKGRldiwgQUJTX1gsICAg
ICAgICAoZGF0YVswXSA+PiA4KSAmIDB4ZmYpOworCQlpbnB1dF9yZXBvcnRfYWJzKGRldiwgQUJT
X1ksICAgICAgICAoZGF0YVsxXSA+PiA4KSAmIDB4ZmYpOworCQlpbnB1dF9yZXBvcnRfYWJzKGRl
diwgQUJTX1RIUk9UVExFLCBkYXRhWzFdICYgMHhmZik7CisKKwkJaW5wdXRfcmVwb3J0X2tleShk
ZXYsIEJUTl9CQVNFNCwgICAgKGRhdGFbMV0gPj4gMTYpICYgMSk7CisJCWlucHV0X3JlcG9ydF9r
ZXkoZGV2LCBCVE5fQkFTRTIsICAgIChkYXRhWzFdID4+IDE5KSAmIDEpOworCQlpbnB1dF9yZXBv
cnRfa2V5KGRldiwgQlROX0JBU0UzLCAgICAoZGF0YVsxXSA+PiAyMCkgJiAxKTsKKwkJaW5wdXRf
cmVwb3J0X2tleShkZXYsIEJUTl9USFVNQiwgICAgKGRhdGFbMV0gPj4gMjEpICYgMSk7CisJCWlu
cHV0X3JlcG9ydF9rZXkoZGV2LCBCVE5fQkFTRSwgICAgIChkYXRhWzFdID4+IDIyKSAmIDEpOwor
CQlpbnB1dF9yZXBvcnRfa2V5KGRldiwgQlROX1RSSUdHRVIsICAoZGF0YVsxXSA+PiAyMykgJiAx
KTsKIAl9CiAKKwkvKiBRdWV1ZSBhbm90aGVyIHJlYWQgKi8KIAlpbnB1dF9zeW5jKGRldik7CiB9
CiAKQEAgLTIzNSw3ICsyODgsNyBAQAogCQkJYnJlYWs7CiAKIAlpZiAoIWludGVyYWN0X3R5cGVb
aV0ubGVuZ3RoKSB7Ci0JCXByaW50ayhLRVJOX1dBUk5JTkcgImludGVyYWN0LmM6IFVua25vd24g
am95c3RpY2sgb24gJXMuIFtsZW4gJWQgZDAgJTA4eCBkMSAlMDh4IGkyICUwOHhdXG4iLAorCQlw
cmludGsoS0VSTl9XQVJOSU5HICJpbnRlcmFjdC5jOiBVbmtub3duIGpveXN0aWNrIG9uICVzLiBb
bGVuICVkIGQwICUwOHggZDEgJTA4eCBkMiAlMDh4XVxuIiwKIAkJCWdhbWVwb3J0LT5waHlzLCBp
LCBkYXRhWzBdLCBkYXRhWzFdLCBkYXRhWzJdKTsKIAkJZXJyID0gLUVOT0RFVjsKIAkJZ290byBm
YWlsMjsKQEAgLTI2Miw2ICszMTUsMTAgQEAKIAogCWludGVyYWN0LT5kZXYuZXZiaXRbMF0gPSBC
SVQoRVZfS0VZKSB8IEJJVChFVl9BQlMpOwogCisJLyogVGhpcyBpcyB0aGUgb25lIHBsYWNlIGl0
J3MgbmljZSB0byBoYXZlIHRhYmxlcyBvZiB0aGUgYXhlcy9idXR0b25zLAorCSAqIHNpbmNlIGl0
IG1ha2VzIGl0IHNvIGVhc3kgdG8gcmVwb3J0IHRoZSBjb250cm9sbGVyIGNoYXJhY3RlcmlzdGlj
cworCSAqIHRvIHRoZSBrZXJuZWwncyBpbnB1dCBsYXllciAqLworCiAJZm9yIChpID0gMDsgKHQg
PSBpbnRlcmFjdF90eXBlW2ludGVyYWN0LT50eXBlXS5hYnNbaV0pID49IDA7IGkrKykgewogCQlz
ZXRfYml0KHQsIGludGVyYWN0LT5kZXYuYWJzYml0KTsKIAkJaWYgKGkgPCBpbnRlcmFjdF90eXBl
W2ludGVyYWN0LT50eXBlXS5iOCkgewo=
------=_Part_7634_23351716.1126625766474--
