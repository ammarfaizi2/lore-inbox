Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313194AbSDDPXV>; Thu, 4 Apr 2002 10:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313196AbSDDPXM>; Thu, 4 Apr 2002 10:23:12 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:40387 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S313194AbSDDPW5>;
	Thu, 4 Apr 2002 10:22:57 -0500
Date: Thu, 4 Apr 2002 17:22:38 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.7-dj3 - BUG & PATCH
Message-Id: <20020404172238.62bf1d41.sebastian.droege@gmx.de>
In-Reply-To: <20020404054923.A28437@suse.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.D(iwzHM_L01(62"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.D(iwzHM_L01(62
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
I have a problem in 2.5.7-dj3 which doesn't exist in 2.5.8-pre1...
My USB keyboard and mouse are detected properly but aren't usable
I get the same behaviour when unsetting CONFIG_USB_HIDINPUT in 2.5.8-pre1
grepping for CONFIG_USB_HIDINPUT in 2.5.7-dj3 finds something but the option doesn't show in old/menuconfig
When setting CONFIG_USB_HIDINPUT=y by hand in 2.5.7-dj3 I get a compile error:

make[3]: Entering directory `/usr/src/linux-2.5.7/drivers/usb'
gcc -D__KERNEL__ -I/usr/src/linux-2.5.7/include -Wall -Wstrict-prototypes -Wno-trigraphs -O6 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=hid_input  -c -o hid-input.o hid-input.c
hid-input.c:335: redefinition of `hidinput_hid_event'
hid.h:411: `hidinput_hid_event' previously defined here
hid-input.c:413: redefinition of `hidinput_connect'
hid.h:412: `hidinput_connect' previously defined here
hid-input.c:458: redefinition of `hidinput_disconnect'
hid.h:413: `hidinput_disconnect' previously defined here
make[3]: *** [hid-input.o] Fehler 1

I don't see any differences between 2.5.7-dj3 and 2.5.8-pre1 which can cause such error but the patch at the bottom solves it ;)
Maybe someone can explain me why 2.5.8-pre1 compiles without the #ifdefs  (with CONFIG_USB_HIDINPUT set and unset) and not in 2.5.7-dj3

With this patch my mouse and keyboard work again

Bye

diff -Nur linux-2.5.7/drivers/usb/Config.in linux-2.5.7-2/drivers/usb/Config.in
--- linux-2.5.7/drivers/usb/Config.in   Thu Apr  4 17:17:57 2002
+++ linux-2.5.7-2/drivers/usb/Config.in Thu Apr  4 17:15:38 2002
@@ -53,6 +53,7 @@
       comment '  Input core support is needed for USB HID'
    else
       dep_tristate '  USB Human Interface Device (full HID) support' CONFIG_USB_HID $CONFIG_USB $CONFIG_INPUT
+        dep_mbool '    HID input layer support' CONFIG_USB_HIDINPUT $CONFIG_INPUT $CONFIG_USB_HID
          dep_mbool '    /dev/hiddev raw HID device support (EXPERIMENTAL)' CONFIG_USB_HIDDEV $CONFIG_USB_HID
       if [ "$CONFIG_USB_HID" != "y" ]; then
          dep_tristate '  USB HIDBP Keyboard (basic) support' CONFIG_USB_KBD $CONFIG_USB $CONFIG_INPUT
diff -Nur linux-2.5.7/drivers/usb/hid-input.c linux-2.5.7-2/drivers/usb/hid-input.c
--- linux-2.5.7/drivers/usb/hid-input.c Mon Mar 18 21:37:13 2002
+++ linux-2.5.7-2/drivers/usb/hid-input.c       Thu Apr  4 17:20:55 2002
@@ -331,6 +331,7 @@
        }
 }
 
+#ifdef CONFIG_USB_HIDINPUT
 void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value)
 {
        struct input_dev *input = &hid->input;
@@ -373,6 +374,7 @@
        if ((field->flags & HID_MAIN_ITEM_RELATIVE) && (usage->type == EV_KEY))
                input_event(input, usage->type, usage->code, 0);
 }
+#endif
 
 static int hidinput_input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
@@ -403,6 +405,7 @@
        hid_close(hid);
 }
 
+#ifdef CONFIG_USB_HIDINPUT
 /*
  * Register the input device; print a message.
  * Configure the input layer interface
@@ -458,3 +461,4 @@
 {
        input_unregister_device(&hid->input);
 }
+#endif

--=.D(iwzHM_L01(62
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8rG/Fe9FFpVVDScsRAqdiAKDbLES36z3veiKFk2d+e5ys5o4FfgCgmuSx
WA5Od00v8hdKLR8+gmn29v8=
=ctxF
-----END PGP SIGNATURE-----

--=.D(iwzHM_L01(62--

