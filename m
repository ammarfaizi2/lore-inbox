Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280653AbRKFWrS>; Tue, 6 Nov 2001 17:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280641AbRKFWrJ>; Tue, 6 Nov 2001 17:47:09 -0500
Received: from gate.mesa.nl ([194.151.5.70]:35853 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S280653AbRKFWq7>;
	Tue, 6 Nov 2001 17:46:59 -0500
Date: Tue, 6 Nov 2001 23:46:55 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Massimo Dal Zotto <dz@cs.unitn.it>
Cc: linux-kernel@vger.kernel.org, stephane@tuxfinder.org
Subject: Re: [PATCH] SMM BIOS on Dell i8100
Message-ID: <20011106234655.A28603@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <20011105231759.02B541195E@a.mx.spoiled.org> <200111061645.RAA02115@fandango.cs.unitn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111061645.RAA02115@fandango.cs.unitn.it>; from dz@cs.unitn.it on Tue, Nov 06, 2001 at 05:45:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Massimo,
Here is a small patch to sort of implement autorepeat for the volume buttons.
It just adds a -r | --repeat <count> option to i8kbuttons. With the
default timeout and -r 1 I get a reasonable autorepeat function.
The name/docs might not be optimal but I leave that to you if you choose
to include the patch. It is agains i8kutils-1.2.

-Marcel
--- i8kbuttons.1.org	Tue Nov  6 22:30:56 2001
+++ i8kbuttons.1	Tue Nov  6 22:33:47 2001
@@ -36,6 +36,11 @@
 \fB\-t\fR, \fB\-\-timeout\fR <\fImilliseconds\fP>
 Specifies the interval in milliseconds at which the daemon checks the
 button status. Useful values are in the range of 50\-200. Default is 100.
+.TP 
+\fB\-r\fR, \fB\-\-repeat\fR <\fIcount\fP>
+Enables autorepeat (0 is off is default). While holding down one of the volume
+buttons, the volume is changed every count timeoutintervals. So with -t 100 -r 2
+it will change every 200 milliseconds.
 .LP 
 .SH "FILES"
 .LP 
--- i8kbuttons.c.org	Tue Nov  6 22:18:09 2001
+++ i8kbuttons.c	Tue Nov  6 22:24:08 2001
@@ -89,6 +89,7 @@
     printf("	-d|--down <command>\n");
     printf("	-m|--mute <command>\n");
     printf("	-t|--timeout <milliseconds>\n");
+    printf("	-r|--repeat <count>\n");
     printf("\n");
 }
 
@@ -97,6 +98,8 @@
 {
     int fd, status;
     int timeout = POLL_TIMEOUT;
+    int repeat = 0;
+    int autorpt = 0;
     int last = 0;
     char *progname;
     struct timespec req;
@@ -137,6 +140,11 @@
 	    }
 	    continue;
 	}
+	if ((strcmp(argv[0],"-r")==0) || (strcmp(argv[0],"--repeat")==0)) {
+	    if (argc < 2) break;
+	    autorpt = atoi(argv[1]);
+	    continue;
+	}
 	break;
     }
     if (argc > 0) {
@@ -162,8 +170,10 @@
 	DPRINTF("%d\n", status);
 
 	if (status == last) {
-	    continue;
+	    if (!autorpt || (repeat++ < autorpt))
+	        continue;
 	}
+        repeat = 0;
 	last = status;
 
 	switch (status) {



-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
