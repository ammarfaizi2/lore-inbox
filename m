Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265994AbUAKWmj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 17:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266001AbUAKWmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 17:42:38 -0500
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:43655 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265994AbUAKWmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 17:42:32 -0500
Date: Sun, 11 Jan 2004 23:42:29 +0100
From: Rudo Thomas <rudo@matfyz.cz>
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm1: A couple of problems
Message-ID: <20040111224229.GA8941@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Ricardo Galli <gallir@uib.es>,
	linux-kernel@vger.kernel.org
References: <200401111239.15445.gallir@uib.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <200401111239.15445.gallir@uib.es>
User-Agent: Mutt/1.5.4i-ja.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> - artsd running with ALSA gives the error: "CPU overloading, stopping" 
> just few seconds after it began to play a song. It's a P4 HT with SMP 
> enabled.

I suppose this is a compatibility problem.

I have just recompiled arts-1.1.94 (aka kde3.2beta2) in gentoo and it does not
print the above message. Gentoo contains some kind of patch to arts. I attached
it. Try if it helps.

Have a nice day.

Rudo.

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="arts-1.2.0_beta2-alsafix.diff"

--- arts/configure.in.in	2003/08/28 17:28:59	1.94
+++ arts/configure.in.in	2003/11/24 20:13:09	1.95
@@ -549,6 +549,26 @@ AC_DEFUN([AC_CHECK_LIBASOUND],
       #include <alsa/asoundlib.h>
       #endif
     ],[
+      #if (SND_LIB_MAJOR == 1) && (SND_LIB_MINOR == 0)
+        /* we have ALSA 1.x */
+      #else
+        #error not ALSA 1.x
+      #endif
+    ],
+    kde_has_alsa_1_0=yes,
+    kde_has_alsa_1_0=no)
+  fi
+
+  if test "x$kde_has_asoundlib" = "xyes"; then
+    AC_TRY_COMPILE([
+      #include "confdefs.h"
+      #ifdef HAVE_SYS_ASOUNDLIB_H
+      #include <sys/asoundlib.h>
+      #endif
+      #ifdef HAVE_ALSA_ASOUNDLIB_H
+      #include <alsa/asoundlib.h>
+      #endif
+    ],[
     #if (SND_LIB_MAJOR == 0) && (SND_LIB_MINOR == 5)
       /* we have ALSA 0.5.x */
     #else
@@ -575,6 +595,18 @@ AC_DEFUN([AC_CHECK_LIBASOUND],
           AC_DEFINE(HAVE_SND_PCM_RESUME, 1,
             [Define if libasound has snd_pcm_resume()])])
       fi
+      if test "x$kde_has_alsa_1_0" = "xyes"; then
+        LIBASOUND="-lasound"
+        AC_DEFINE(HAVE_LIBASOUND2, 1,
+          [Define if you have libasound.so.2 (required for ALSA 0.9.x/1.x support)])
+	AC_DEFINE(ALSA_PCM_OLD_SW_PARAMS_API, 1,
+          [Define if you have alsa 1.x])
+	AC_DEFINE(ALSA_PCM_OLD_HW_PARAMS_API, 1,
+          [Define if you have alsa 1.x])
+        AC_CHECK_LIB(asound,snd_pcm_resume,[
+          AC_DEFINE(HAVE_SND_PCM_RESUME, 1,
+            [Define if libasound has snd_pcm_resume()])])
+      fi
     ])
   fi
   AC_SUBST(LIBASOUND)

--XsQoSWH+UP9D9v3l--
