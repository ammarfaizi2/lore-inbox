Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbUJZIpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbUJZIpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 04:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUJZIpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 04:45:43 -0400
Received: from ValkamoMari.a.finnair.fi ([157.200.181.102]:28801 "EHLO
	dell.work.holviala.com") by vger.kernel.org with ESMTP
	id S262193AbUJZIpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 04:45:32 -0400
Message-ID: <417E0EA8.7000704@holviala.com>
Date: Tue, 26 Oct 2004 11:45:28 +0300
From: Kim Holviala <kim@holviala.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: [PATCH] mousedev: Fix scrollwheel thingy on IBM ScrollPoint mice
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The scrollwheel thingy (stick) on IBM ScrollPoint mice returns extremely
aggressive values even when touched lightly. This confuses XFree which
assumes the wheel values can only be 1 or -1. Incidently, it also
confuses Windows' default mouse driver which proves the problem is in
the mouse itself.

This patch limits the scroll wheel movements to be either +1 or -1 on
the event -> emulated PS/2 level. I chose to implement it there because
mousedev emulates Microsoft mice but the real ones almoust never return
a bigger value than 1 (or -1).

Kim



diff -ruN linux-2.6.8.1-original/drivers/input/Kconfig linux-2.6.8.1/drivers/input/Kconfig
--- linux-2.6.8.1-original/drivers/input/Kconfig	2004-10-26 08:42:30.000000000 +0300
+++ linux-2.6.8.1/drivers/input/Kconfig	2004-10-26 09:54:58.000000000 +0300
@@ -72,6 +72,17 @@
  	  screen resolution you are using to correctly scale the data. If
  	  you're not using a digitizer, this value is ignored.

+config INPUT_MOUSEDEV_WHEELFIX
+	bool "Limit too fast wheel movement"
+	depends on INPUT_MOUSEDEV
+	default n
+	help
+	  Say Y here if your mouse wheel only works randomly or if it scrolls
+	  too fast. Some mice, like IBM's scrollpoints, return too big wheel
+	  movement values which confuse programs like XFree.
+
+	  If your mouse wheel thingy works as advertised, say N.
+
  config INPUT_JOYDEV
  	tristate "Joystick interface"
  	depends on INPUT
diff -ruN linux-2.6.8.1-original/drivers/input/mousedev.c linux-2.6.8.1/drivers/input/mousedev.c
--- linux-2.6.8.1-original/drivers/input/mousedev.c	2004-10-26 08:42:31.000000000 +0300
+++ linux-2.6.8.1/drivers/input/mousedev.c	2004-10-26 11:21:01.000000000 +0300
@@ -137,7 +137,11 @@
  	switch (code) {
  		case REL_X:	mousedev->packet.dx += value; break;
  		case REL_Y:	mousedev->packet.dy -= value; break;
-		case REL_WHEEL:	mousedev->packet.dz -= value; break;
+		case REL_WHEEL:
+#ifdef CONFIG_INPUT_MOUSEDEV_WHEELFIX
+				if (value) { value = (value < 0 ? -1 : 1); }
+#endif /* CONFIG_INPUT_MOUSEDEV_WHEELFIX */
+				mousedev->packet.dz -= value; break;
  	}
  }

