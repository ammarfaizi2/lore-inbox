Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132439AbRCZOGS>; Mon, 26 Mar 2001 09:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132440AbRCZOGJ>; Mon, 26 Mar 2001 09:06:09 -0500
Received: from smtp23.singnet.com.sg ([165.21.101.203]:36623 "EHLO
	smtp23.singnet.com.sg") by vger.kernel.org with ESMTP
	id <S132439AbRCZOFu>; Mon, 26 Mar 2001 09:05:50 -0500
Message-ID: <3ABF4C87.F5AA909D@magix.com.sg>
Date: Mon, 26 Mar 2001 23:04:55 +0900
From: Anthony <anthony@magix.com.sg>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: linux-kernel@vger.kernel.org, autofs@linux.kernel.org
Subject: Re: Should mount --bind not follow symlinks?
In-Reply-To: <Pine.GSO.4.21.0103120835390.25792-100000@weyl.math.psu.edu> <3AACED42.39DF0A24@magix.com.sg> <20010314143157.B27572@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> The automounter could indeed chase those symlinks.
> 
> Also, if the automounter creates a symlink in /opt anyway, and the link
> subsequently works (as you said), then it shouldn't be returning "No
> such file or directory" the first time.
> 
> In other words the latter behaviour looks like a bug in the automounter,
> and the former is a feature which could be added but isn't needed for
> your application.

Okay!  Well, the following I think fixes everything for me, as a 
small tweak to autofs-4.0.0pre9.

Thanks

Anthony


*** modules/mount_bind.c.Orig   Sun Mar 25 15:43:27 2001
--- modules/mount_bind.c        Mon Mar 26 22:57:10 2001
***************
*** 19,24 ****
--- 19,25 ----
  #include <errno.h>
  #include <fcntl.h>
  #include <unistd.h>
+ #include <stdlib.h>
  #include <syslog.h>
  #include <string.h>
  #include <sys/param.h>
***************
*** 71,76 ****
--- 72,84 ----
    char *fullpath;
    int err;
    int i;
+ 
+   char real[PATH_MAX];
+   if (!realpath(what, real)) {
+     syslog(LOG_NOTICE, MODPREFIX "realpath %s failed: %m", what);
+     return 1;
+   }
+   what = real;
  
    fullpath = alloca(strlen(root)+name_len+2);
    if ( !fullpath ) {
