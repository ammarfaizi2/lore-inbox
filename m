Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129042AbRBFKNJ>; Tue, 6 Feb 2001 05:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbRBFKNG>; Tue, 6 Feb 2001 05:13:06 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:8197 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S129042AbRBFKMx>;
	Tue, 6 Feb 2001 05:12:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: alan@lxorguk.ukuu.org.uk, hiren_mehta@agilent.com
Subject: Re: problem with devfsd compilation
Date: Thu, 1 Feb 2001 21:26:51 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01020121265100.00537@hal>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I am trying to compile devfsd on my system running RedHat linux 7.0
>> (kernel 2.2.16-22). I get the error "RTLD_NEXT" undefined. I am not
>> sure where this symbol is defined. Is there anything that I am missing 
>> on my system. 
>
>
>Sounds like a missing include in the devfsd code. That comes from 
>dlfcn.h. 

Following small patch fixes this and workarounds devfs related problem
which appeared in 2.4.0-test12-pre8:
	when I'm logging out, devfsd tries to state /dev/vcc/[1-6] but sometimes
	fails perhaps due to some race in kernel. As result devfsd quits with 
	error message. Retrying to state node suceeds on next attempt.
	I don't know why it happens, but I guess it's related to 
	change in drivers/char/tty_io.c between test12-pre7 and pre8
	(change to use flush_scheduled_tasks())

Hint: it seems to be easier to reproduce on slower machine (it happens seldom 
	on PIII-700, but very often on P200MMX)

Andris


--- devfsd/devfsd.c~1	Mon Jul  3 22:43:07 2000
+++ devfsd/devfsd.c	Fri Jan 12 13:19:33 2001
@@ -189,6 +189,7 @@
 #include <signal.h>
 #include <regex.h>
 #include <errno.h>
+#define __USE_GNU
 #include <dlfcn.h>
 #include <rpcsvc/ypclnt.h>
 #include <rpcsvc/yp_prot.h>
@@ -918,15 +919,29 @@
     [RETURNS] Nothing.
 */
 {
+    int tries=0;
     mode_t new_mode;
     struct stat statbuf;
 
+Retry:   
     if (lstat (info->devname, &statbuf) != 0)
     {
-	SYSLOG (LOG_ERR, "error stat(2)ing: \"%s\"\t%s\n",
-		info->devname, ERRSTRING);
-	SYSLOG (LOG_ERR, "exiting\n");
-	exit (1);
+	if (tries<10)
+	{
+	   tries++;
+           SYSLOG (LOG_ERR, "error stat(2)ing: \"%s\"\t%s\n",
+	   	   info->devname, ERRSTRING);
+           SYSLOG (LOG_ERR, "retrying (attempt %d) ...\n",tries);
+	   usleep (1000);  /* Let's sleep a bit  */
+	   goto Retry;
+	}
+	else
+	{
+	   SYSLOG (LOG_ERR, "error stat(2)ing: \"%s\"\t%s\n",
+	   	   info->devname, ERRSTRING);
+	   SYSLOG (LOG_ERR, "exiting\n");
+	   exit (1);
+	}
     }
     new_mode = (statbuf.st_mode & S_IFMT) |
 	(entry->u.permissions.mode & ~S_IFMT);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
