Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRALLg4>; Fri, 12 Jan 2001 06:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130078AbRALLgl>; Fri, 12 Jan 2001 06:36:41 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:1796 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S129401AbRALLg1>;
	Fri, 12 Jan 2001 06:36:27 -0500
Content-Type: text/plain;
  charset="iso-8859-13"
From: Andris Pavenis <pavenis@latnet.lv>
To: rgooch@atnf.csiro.au
Subject: Re: devfs breakage in 2.4.0 release
Date: Fri, 12 Jan 2001 13:35:20 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01010615285000.00465@hal>
In-Reply-To: <01010615285000.00465@hal>
MIME-Version: 1.0
Message-Id: <01011213352000.00369@hal>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 January 2001 15:28, Andris Pavenis wrote:
> Noticed following devfs related problems with kernel version 2.4.0 on one
> Pentium 200MMX box (the same problem with 2.4.0-ac2, but earlier
> 2.4.0-test10 doesn't have this problem)
>
> I was able to reproduce it reliably by following steps:
>          - booted machine in runlevel 3
>          - logged in as user and started MC (on first console)
>          - logged out
>          - logged in as different user (in this case root) and tried to
> start MC again
>
> This time it hangs. The source of problem appears to be devfs related as
> devfsd exited with error message that it cannot state vcc/1 as there is no
> such file or directory. Related parts of log files (boot parameter
> devfs=dall) and other related information (I hope...) is in attachment. Of
> course MC is not behaving nicely, but the primary source of problem seems
> to be devfs

As I tested devfsd dies after I'm logging out (very often on P200MMX,
much more seldom on P3 700). I suspect some devfs related race

> On this machine kernel was compiled for Pentium CPUs. I tried to reproduce
> the same on a different machine with Pentium III 700 using kernel 2.4.0.
> It took more relogging as on Pentium 200, but I got the same problem once
> (on slower machine I was able to reproduce it more reliably).
>

I tries 2.4.1-pre3 and got the same. Modifying devfsd.c to retry stating
some times before giving up workarounds the problem (As far as I tested 
I'm getting only one retry ...)

Perhaps it's kernel's bug anyway, but I think it's doesn't harm to make
devfsd slightly more errorproof. I'm including patch for devfsd (I had also 
to define __USE_GNU to get devfsd compile with glibc-2.2 at all ...)

Of course best solution would be to fix the race itself (it appeared sometimes
between 2.4.0-test10 and 2.4.0-test12, first one is OK) ....

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
