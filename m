Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263878AbTDDSiz (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 13:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTDDSiz (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 13:38:55 -0500
Received: from smtp2.wanadoo.es ([62.37.236.136]:234 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S263878AbTDDSix (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 13:38:53 -0500
Message-ID: <3E8DD415.6080507@wanadoo.es>
Date: Fri, 04 Apr 2003 20:51:01 +0200
From: =?ISO-8859-1?Q?Xos=C9_Vazquez?= <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kbuild(2.4) bug and half solution
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

There is a bug with three options:

Kernel core (/proc/kcore) format (ELF, A.OUT) [ELF]
Enable procfs status report (+2kb) (CONFIG_FT_PROC_FS) [N/y/?]
Support for /proc/radio-typhoon (CONFIG_RADIO_TYPHOON_PROC_FS) [N/y/?]

these options depend on CONFIG_PROC_FS:

drivers/char/ftape/Config.in
if [ "$CONFIG_PROC_FS" = "y" ]; then
   bool '  Enable procfs status report (+2kb)' CONFIG_FT_PROC_FS
fi

drivers/media/radio/Config.in
   if [ "$CONFIG_PROC_FS" = "y" ]; then
      if [ "$CONFIG_RADIO_TYPHOON" != "n" ]; then
         bool '    Support for /proc/radio-typhoon'
CONFIG_RADIO_TYPHOON_PROC_FS
      fi
   fi

arch/i386/config.in
if [ "$CONFIG_PROC_FS" = "y" ]; then
   choice 'Kernel core (/proc/kcore) format' \
        "ELF            CONFIG_KCORE_ELF        \
         A.OUT          CONFIG_KCORE_AOUT" ELF
fi


but for menu oldconfig is impossible make it good because
___CONFIG_PROC_FS is not defined _before_ these options___.

A solution for the bool options are easy:

--cut--
diff -Naur linux/drivers/char/ftape/Config.in
linux.xose/drivers/char/ftape/Config.in
--- linux/drivers/char/ftape/Config.in  Thu Jan 16 04:26:28 2003
+++ linux.xose/drivers/char/ftape/Config.in     Fri Apr  4 05:16:54 2003
@@ -10,9 +10,9 @@
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
    int '  Number of ftape buffers (EXPERIMENTAL)' CONFIG_FT_NR_BUFFERS 3
 fi
-if [ "$CONFIG_PROC_FS" = "y" ]; then
-   bool '  Enable procfs status report (+2kb)' CONFIG_FT_PROC_FS
-fi
+
+dep_bool '  Enable procfs status report (+2kb)' CONFIG_FT_PROC_FS
$CONFIG_PROC_FS
+
 choice 'Debugging output'                      \
        "Normal         CONFIG_FT_NORMAL_DEBUG  \
         Excessive      CONFIG_FT_FULL_DEBUG    \
diff -Naur linux/drivers/media/radio/Config.in
linux.xose/drivers/media/radio/Config.in
--- linux/drivers/media/radio/Config.in Fri Apr  4 16:24:12 2003
+++ linux.xose/drivers/media/radio/Config.in    Fri Apr  4 05:39:46 2003
@@ -40,11 +40,9 @@
       hex '    Trust i/o port (usually 0x350 or 0x358)'
CONFIG_RADIO_TRUST_PORT 350
    fi
    dep_tristate '  Typhoon Radio (a.k.a. EcoRadio)'
CONFIG_RADIO_TYPHOON $CONFIG_VIDEO_DEV
-   if [ "$CONFIG_PROC_FS" = "y" ]; then
-      if [ "$CONFIG_RADIO_TYPHOON" != "n" ]; then
-         bool '    Support for /proc/radio-typhoon'
CONFIG_RADIO_TYPHOON_PROC_FS
-      fi
-   fi
+
+   dep_mbool '    Support for /proc/radio-typhoon'
CONFIG_RADIO_TYPHOON_PROC_FS $CONFIG_PROC_FS $CONFIG_RADIO_TYPHOON
+
    if [ "$CONFIG_RADIO_TYPHOON" = "y" ]; then
       hex '  Typhoon I/O port (0x316 or 0x336)'
CONFIG_RADIO_TYPHOON_PORT 316
       int '  Typhoon frequency set when muting the device (kHz)'
CONFIG_RADIO_TYPHOON_MUTEFREQ 87500
--end--

to correct the 'choice option' is necesary:
1- to define a 'new' statements called dep_choice
2- to change 'Kernel core (/proc/kcore) format' to a possition bottom
'proc file system support'
3- to change 'proc file system support' to a possition up 'Kernel core
(/proc/kcore) format'

I think 2 and 3 are easier

-thanks-

regards,
-- 
Galiza nin perdoa nin esquence. Governo demision!



