Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265610AbUABTpd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 14:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265619AbUABTpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 14:45:33 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:36100 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S265610AbUABTpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 14:45:23 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: UNICODE ioctls on background console
Date: Fri, 2 Jan 2004 22:33:12 +0300
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4dc9/8ruJXhlCgM"
Message-Id: <200401022233.12115.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_4dc9/8ruJXhlCgM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Why are those ioctls forcibly applied to foreground console only? This makes 
--tty option for consolechars non-functional and prevents console 
initialization (for non-ASCII charsets) as part of system startup (or as part 
of getty) because it works only when called on currently active console.

I'm running with the following patch without any ill effects nor can I see any 
harm looking in code.

Any reason it cannot be applied?

regards

-andrey

--Boundary-00=_4dc9/8ruJXhlCgM
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.0-unicode_background_cons.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.0-unicode_background_cons.patch"

--- ../tmp/linux-2.6.0/drivers/char/vt_ioctl.c	2003-12-18 05:59:06.000000000 +0300
+++ linux-2.6.0/drivers/char/vt_ioctl.c	2004-01-02 18:38:38.000000000 +0300
@@ -332,7 +332,7 @@ do_fontx_ioctl(int cmd, struct consolefo
 }
 
 static inline int 
-do_unimap_ioctl(int cmd, struct unimapdesc *user_ud,int perm)
+do_unimap_ioctl(int cmd, struct unimapdesc *user_ud,int perm, unsigned int console)
 {
 	struct unimapdesc tmp;
 	int i = 0; 
@@ -348,9 +348,9 @@ do_unimap_ioctl(int cmd, struct unimapde
 	case PIO_UNIMAP:
 		if (!perm)
 			return -EPERM;
-		return con_set_unimap(fg_console, tmp.entry_ct, tmp.entries);
+		return con_set_unimap(console, tmp.entry_ct, tmp.entries);
 	case GIO_UNIMAP:
-		return con_get_unimap(fg_console, tmp.entry_ct, &(user_ud->entry_ct), tmp.entries);
+		return con_get_unimap(console, tmp.entry_ct, &(user_ud->entry_ct), tmp.entries);
 	}
 	return 0;
 }
@@ -966,13 +966,13 @@ int vt_ioctl(struct tty_struct *tty, str
 			return -EPERM;
 		i = copy_from_user(&ui, (void *)arg, sizeof(struct unimapinit));
 		if (i) return -EFAULT;
-		con_clear_unimap(fg_console, &ui);
+		con_clear_unimap(console, &ui);
 		return 0;
 	      }
 
 	case PIO_UNIMAP:
 	case GIO_UNIMAP:
-		return do_unimap_ioctl(cmd, (struct unimapdesc *)arg, perm);
+		return do_unimap_ioctl(cmd, (struct unimapdesc *)arg, perm, console);
 
 	case VT_LOCKSWITCH:
 		if (!capable(CAP_SYS_TTY_CONFIG))

--Boundary-00=_4dc9/8ruJXhlCgM--

