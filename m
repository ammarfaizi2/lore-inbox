Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbWGJELO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWGJELO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 00:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161326AbWGJELO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 00:11:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:33368 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161051AbWGJELN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 00:11:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=Y1tTRqR7kTUELdHwTXrk2cpkLXHPgTO1UPxuS/i2q7Q8FNoeXn8wx89dTu5GTrhYQMplMrNBBA1DzOUrbJ3DlxKtFp/IHiYDGZwGevK5Dsrd8jAWQiA3Ldy7MhKBngs8Z4AwR9titx+67La7luTMrnQ1qg87TYKgxELI7S5bsok=
Message-ID: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>
Date: Mon, 10 Jul 2006 00:11:11 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Andrew Morton" <akpm@osdl.org>
Subject: [PATCH] Clean up old names in tty code to current names
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3404_11026676.1152504671665"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3404_11026676.1152504671665
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Fix various places in the tty code to make it match the current naming system.

-- 
Jon Smirl
jonsmirl@gmail.com

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

diff --git a/drivers/char/pty.c b/drivers/char/pty.c
index 34dd4c3..af43f37 100644
--- a/drivers/char/pty.c
+++ b/drivers/char/pty.c
@@ -279,7 +279,7 @@ static void __init legacy_pty_init(void)

 	pty_slave_driver->owner = THIS_MODULE;
 	pty_slave_driver->driver_name = "pty_slave";
-	pty_slave_driver->name = "ttyp";
+	pty_slave_driver->name = "pts";
 	pty_slave_driver->major = PTY_SLAVE_MAJOR;
 	pty_slave_driver->minor_start = 0;
 	pty_slave_driver->type = TTY_DRIVER_TYPE_PTY;
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index bfdb902..4a83e94 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -3245,7 +3245,7 @@ #endif
 #ifdef CONFIG_VT
 	cdev_init(&vc0_cdev, &console_fops);
 	if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
-	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
+	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/tty0") < 0)
 		panic("Couldn't register /dev/tty0 driver\n");
 	class_device_create(tty_class, NULL, MKDEV(TTY_MAJOR, 0), NULL, "tty0");

diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index da7e66a..a627e8b 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -2662,6 +2662,7 @@ int __init vty_init(void)
 	if (!console_driver)
 		panic("Couldn't allocate console driver\n");
 	console_driver->owner = THIS_MODULE;
+	console_driver->driver_name = "vtconsole";
 	console_driver->name = "tty";
 	console_driver->name_base = 1;
 	console_driver->major = TTY_MAJOR;
diff --git a/fs/proc/proc_tty.c b/fs/proc/proc_tty.c
index 15c4455..042aefe 100644
--- a/fs/proc/proc_tty.c
+++ b/fs/proc/proc_tty.c
@@ -48,7 +48,7 @@ static void show_tty_range(struct seq_fi
 			seq_printf(m, ":vtmaster");
 		break;
 	case TTY_DRIVER_TYPE_CONSOLE:
-		seq_printf(m, "console");
+		seq_printf(m, "vt:console");
 		break;
 	case TTY_DRIVER_TYPE_SERIAL:
 		seq_printf(m, "serial");
@@ -84,10 +84,10 @@ static int show_tty_driver(struct seq_fi
 #ifdef CONFIG_UNIX98_PTYS
 		seq_printf(m, "%-20s /dev/%-8s ", "/dev/ptmx", "ptmx");
 		seq_printf(m, "%3d %7d ", TTYAUX_MAJOR, 2);
-		seq_printf(m, "system\n");
+		seq_printf(m, "system:/dev/ptmx\n");
 #endif
 #ifdef CONFIG_VT
-		seq_printf(m, "%-20s /dev/%-8s ", "/dev/vc/0", "vc/0");
+		seq_printf(m, "%-20s /dev/%-8s ", "/dev/tty0", "tty0");
 		seq_printf(m, "%3d %7d ", TTY_MAJOR, 0);
 		seq_printf(m, "system:vtmaster\n");
 #endif

------=_Part_3404_11026676.1152504671665
Content-Type: text/x-patch; name=cleanup-tty-naming.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_epgbcf6j
Content-Disposition: attachment; filename="cleanup-tty-naming.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9wdHkuYyBiL2RyaXZlcnMvY2hhci9wdHkuYwppbmRl
eCAzNGRkNGMzLi5hZjQzZjM3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvcHR5LmMKKysrIGIv
ZHJpdmVycy9jaGFyL3B0eS5jCkBAIC0yNzksNyArMjc5LDcgQEAgc3RhdGljIHZvaWQgX19pbml0
IGxlZ2FjeV9wdHlfaW5pdCh2b2lkKQogCiAJcHR5X3NsYXZlX2RyaXZlci0+b3duZXIgPSBUSElT
X01PRFVMRTsKIAlwdHlfc2xhdmVfZHJpdmVyLT5kcml2ZXJfbmFtZSA9ICJwdHlfc2xhdmUiOwot
CXB0eV9zbGF2ZV9kcml2ZXItPm5hbWUgPSAidHR5cCI7CisJcHR5X3NsYXZlX2RyaXZlci0+bmFt
ZSA9ICJwdHMiOwogCXB0eV9zbGF2ZV9kcml2ZXItPm1ham9yID0gUFRZX1NMQVZFX01BSk9SOwog
CXB0eV9zbGF2ZV9kcml2ZXItPm1pbm9yX3N0YXJ0ID0gMDsKIAlwdHlfc2xhdmVfZHJpdmVyLT50
eXBlID0gVFRZX0RSSVZFUl9UWVBFX1BUWTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90dHlf
aW8uYyBiL2RyaXZlcnMvY2hhci90dHlfaW8uYwppbmRleCBiZmRiOTAyLi40YTgzZTk0IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2NoYXIvdHR5X2lvLmMKKysrIGIvZHJpdmVycy9jaGFyL3R0eV9pby5j
CkBAIC0zMjQ1LDcgKzMyNDUsNyBAQCAjZW5kaWYKICNpZmRlZiBDT05GSUdfVlQKIAljZGV2X2lu
aXQoJnZjMF9jZGV2LCAmY29uc29sZV9mb3BzKTsKIAlpZiAoY2Rldl9hZGQoJnZjMF9jZGV2LCBN
S0RFVihUVFlfTUFKT1IsIDApLCAxKSB8fAotCSAgICByZWdpc3Rlcl9jaHJkZXZfcmVnaW9uKE1L
REVWKFRUWV9NQUpPUiwgMCksIDEsICIvZGV2L3ZjLzAiKSA8IDApCisJICAgIHJlZ2lzdGVyX2No
cmRldl9yZWdpb24oTUtERVYoVFRZX01BSk9SLCAwKSwgMSwgIi9kZXYvdHR5MCIpIDwgMCkKIAkJ
cGFuaWMoIkNvdWxkbid0IHJlZ2lzdGVyIC9kZXYvdHR5MCBkcml2ZXJcbiIpOwogCWNsYXNzX2Rl
dmljZV9jcmVhdGUodHR5X2NsYXNzLCBOVUxMLCBNS0RFVihUVFlfTUFKT1IsIDApLCBOVUxMLCAi
dHR5MCIpOwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdnQuYyBiL2RyaXZlcnMvY2hhci92
dC5jCmluZGV4IGRhN2U2NmEuLmE2MjdlOGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hhci92dC5j
CisrKyBiL2RyaXZlcnMvY2hhci92dC5jCkBAIC0yNjYyLDYgKzI2NjIsNyBAQCBpbnQgX19pbml0
IHZ0eV9pbml0KHZvaWQpCiAJaWYgKCFjb25zb2xlX2RyaXZlcikKIAkJcGFuaWMoIkNvdWxkbid0
IGFsbG9jYXRlIGNvbnNvbGUgZHJpdmVyXG4iKTsKIAljb25zb2xlX2RyaXZlci0+b3duZXIgPSBU
SElTX01PRFVMRTsKKwljb25zb2xlX2RyaXZlci0+ZHJpdmVyX25hbWUgPSAidnRjb25zb2xlIjsK
IAljb25zb2xlX2RyaXZlci0+bmFtZSA9ICJ0dHkiOwogCWNvbnNvbGVfZHJpdmVyLT5uYW1lX2Jh
c2UgPSAxOwogCWNvbnNvbGVfZHJpdmVyLT5tYWpvciA9IFRUWV9NQUpPUjsKZGlmZiAtLWdpdCBh
L2ZzL3Byb2MvcHJvY190dHkuYyBiL2ZzL3Byb2MvcHJvY190dHkuYwppbmRleCAxNWM0NDU1Li4w
NDJhZWZlIDEwMDY0NAotLS0gYS9mcy9wcm9jL3Byb2NfdHR5LmMKKysrIGIvZnMvcHJvYy9wcm9j
X3R0eS5jCkBAIC00OCw3ICs0OCw3IEBAIHN0YXRpYyB2b2lkIHNob3dfdHR5X3JhbmdlKHN0cnVj
dCBzZXFfZmkKIAkJCXNlcV9wcmludGYobSwgIjp2dG1hc3RlciIpOwogCQlicmVhazsKIAljYXNl
IFRUWV9EUklWRVJfVFlQRV9DT05TT0xFOgotCQlzZXFfcHJpbnRmKG0sICJjb25zb2xlIik7CisJ
CXNlcV9wcmludGYobSwgInZ0OmNvbnNvbGUiKTsKIAkJYnJlYWs7CiAJY2FzZSBUVFlfRFJJVkVS
X1RZUEVfU0VSSUFMOgogCQlzZXFfcHJpbnRmKG0sICJzZXJpYWwiKTsKQEAgLTg0LDEwICs4NCwx
MCBAQCBzdGF0aWMgaW50IHNob3dfdHR5X2RyaXZlcihzdHJ1Y3Qgc2VxX2ZpCiAjaWZkZWYgQ09O
RklHX1VOSVg5OF9QVFlTCiAJCXNlcV9wcmludGYobSwgIiUtMjBzIC9kZXYvJS04cyAiLCAiL2Rl
di9wdG14IiwgInB0bXgiKTsKIAkJc2VxX3ByaW50ZihtLCAiJTNkICU3ZCAiLCBUVFlBVVhfTUFK
T1IsIDIpOwotCQlzZXFfcHJpbnRmKG0sICJzeXN0ZW1cbiIpOworCQlzZXFfcHJpbnRmKG0sICJz
eXN0ZW06L2Rldi9wdG14XG4iKTsKICNlbmRpZgogI2lmZGVmIENPTkZJR19WVAotCQlzZXFfcHJp
bnRmKG0sICIlLTIwcyAvZGV2LyUtOHMgIiwgIi9kZXYvdmMvMCIsICJ2Yy8wIik7CisJCXNlcV9w
cmludGYobSwgIiUtMjBzIC9kZXYvJS04cyAiLCAiL2Rldi90dHkwIiwgInR0eTAiKTsKIAkJc2Vx
X3ByaW50ZihtLCAiJTNkICU3ZCAiLCBUVFlfTUFKT1IsIDApOwogCQlzZXFfcHJpbnRmKG0sICJz
eXN0ZW06dnRtYXN0ZXJcbiIpOwogI2VuZGlmCg==
------=_Part_3404_11026676.1152504671665--
