Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129855AbRAXDey>; Tue, 23 Jan 2001 22:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130320AbRAXDep>; Tue, 23 Jan 2001 22:34:45 -0500
Received: from casablanca.magic.fr ([195.154.101.81]:63694 "EHLO
	casablanca.magic.fr") by vger.kernel.org with ESMTP
	id <S129855AbRAXDei>; Tue, 23 Jan 2001 22:34:38 -0500
Message-ID: <3A6E4DF1.EE691AF5@magic.fr>
Date: Wed, 24 Jan 2001 04:37:21 +0100
From: "Jo l'Indien" <l_indien@magic.fr>
Reply-To: l_indien@magic.fr, jma@netgem.com
Organization: Les grandes plaines
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-pre10 i586)
X-Accept-Language: fr-FR, fr, en, en-GB, en-US, ro
MIME-Version: 1.0
To: paulus@linuxcare.com, callahan@maths.ox.ac.uk, jfree@sovereign.org
CC: linux-kernel@vger.kernel.org
Subject: Bug in ppp_async.c
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id OAA11677

I found a bug in the 2.4.1-pre10 version of ppp_async.c

In fact, a lot of ioctl are not supported any more,
whih make the pppd start fail.
The bad patch is:

diff -u --recursive --new-file v2.4.0/linux/drivers/net/ppp_async.c
linux/drivers/net/ppp_async.c
--- v2.4.0/linux/drivers/net/ppp_async.c Fri Apr 21 13:31:10 2000
+++ linux/drivers/net/ppp_async.c Mon Jan 15 11:04:57 2001
@@ -259,25 +244,6 @@
   err = 0;
   break;

-/*
- * For now, do the same as the old 2.3 driver useta
- */
- case PPPIOCGFLAGS:
- case PPPIOCSFLAGS:
- case PPPIOCGASYNCMAP:
- case PPPIOCSASYNCMAP:
- case PPPIOCGRASYNCMAP:
- case PPPIOCSRASYNCMAP:
- case PPPIOCGXASYNCMAP:
- case PPPIOCSXASYNCMAP:
- case PPPIOCGMRU:
- case PPPIOCSMRU:
-  err = -EPERM;
-  if (!capable(CAP_NET_ADMIN))
-   break;
-  err = ppp_async_ioctl(&ap->chan, cmd, arg);
-  break;
-
  case PPPIOCATTACH:
  case PPPIOCDETACH:
   err = ppp_channel_ioctl(&ap->chan, cmd, arg);


When I apply this patch back, I got the connection,
but it fail after a few seconds...
In fact, there are two other patches to reverse
in order to make the driver do its job again
(sure it does: I'm using this kind of kernel now...):

diff -u --recursive --new-file v2.4.0/linux/drivers/net/ppp_async.c
linux/drivers/net/ppp_async.c
--- v2.4.0/linux/drivers/net/ppp_async.c Fri Apr 21 13:31:10 2000
+++ linux/drivers/net/ppp_async.c Mon Jan 15 11:04:57 2001
@@ -181,12 +175,7 @@
 ppp_asynctty_read(struct tty_struct *tty, struct file *file,
     unsigned char *buf, size_t count)
 {
- /* For now, do the same as the old 2.3.x code useta */
- struct asyncppp *ap = tty->disc_data;
-
- if (ap == 0)
-  return -ENXIO;
- return ppp_channel_read(&ap->chan, file, buf, count);
+ return -EAGAIN;
 }

 /*

Then:

diff -u --recursive --new-file v2.4.0/linux/drivers/net/ppp_async.c
linux/drivers/net/ppp_async.c
--- v2.4.0/linux/drivers/net/ppp_async.c Fri Apr 21 13:31:10 2000
+++ linux/drivers/net/ppp_async.c Mon Jan 15 11:04:57 2001
@@ -203,12 +193,7 @@
 ppp_asynctty_write(struct tty_struct *tty, struct file *file,
      const unsigned char *buf, size_t count)
 {
- /* For now, do the same as the old 2.3.x code useta */
- struct asyncppp *ap = tty->disc_data;
-
- if (ap == 0)
-  return -ENXIO;
- return ppp_channel_write(&ap->chan, buf, count);
+ return -EAGAIN;
 }

 static int

Without these modifications, everything is allright !

Jocelyn Mayer

PS: sorry, but I don't know who is the actual maitainer of this
driver...
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€ù^jÇ«y§m…á@A«a¶Úÿÿü0ÃûnÇú+ƒùd
