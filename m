Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129627AbRAPRNV>; Tue, 16 Jan 2001 12:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbRAPRNB>; Tue, 16 Jan 2001 12:13:01 -0500
Received: from m918-mp1-cvx1c.col.ntl.com ([213.104.79.150]:6148 "EHLO
	[213.104.79.150]") by vger.kernel.org with ESMTP id <S129436AbRAPRM5>;
	Tue, 16 Jan 2001 12:12:57 -0500
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "Pierre Rousselet" <pierre.rousselet@wanadoo.fr>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-x features ?
In-Reply-To: <200101151959.f0FJxDB248265@saturn.cs.uml.edu>
From: "John Fremlin" <vii@altern.org>
Date: 16 Jan 2001 13:14:18 +0000
In-Reply-To: "Albert D. Cahalan"'s message of "Mon, 15 Jan 2001 14:59:13 -0500 (EST)"
Message-ID: <m2wvbvod05.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

 "Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> > 1) top (procps-2.0.7) gives me the messages :
> > 'bad data in /proc/uptime'
> > 'bad data in /proc/loadavg'
> > cat /proc/uptime 
> > 1435.30 904.74
> > cat /proc/loadavg
> > 0.01 0.21 0.29 1/17 19444
> > What is wrong ?

You probably have locale settings where the decimal point is a comma
so scanf on /proc/loadavg etc. doesn't work. The following patch
(submitted to RedHat ages ago) fixes that for me.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=procps-2.0.7-intl.patch

diff -u --recursive procps-2.0.7-orig/proc/sysinfo.c procps-2.0.7-hacked/proc/sysinfo.c
--- procps-2.0.7-orig/proc/sysinfo.c	Mon Jul 10 20:36:13 2000
+++ procps-2.0.7-hacked/proc/sysinfo.c	Wed Nov 29 23:11:41 2000
@@ -13,6 +13,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
+#include <locale.h>
+#include <assert.h>
 
 #include <unistd.h>
 #include <fcntl.h>
@@ -62,12 +64,19 @@
 /***********************************************************************/
 int uptime(double *uptime_secs, double *idle_secs) {
     double up=0, idle=0;
+    char*numeric=setlocale(LC_NUMERIC,0);
+    /* It is necessary to save and restore the numeric locale, because
+    if the locale we're in happens to use , instead of decimal point,
+    we can't sscanf the values in /proc/uptime */
+    setlocale(LC_NUMERIC,"C");
 
     FILE_TO_BUF(UPTIME_FILE,uptime_fd);
     if (sscanf(buf, "%lf %lf", &up, &idle) < 2) {
 	fprintf(stderr, "bad data in " UPTIME_FILE "\n");
 	return 0;
     }
+    setlocale(LC_NUMERIC,numeric);
+
     SET_IF_DESIRED(uptime_secs, up);
     SET_IF_DESIRED(idle_secs, idle);
     return up;	/* assume never be zero seconds in practice */
@@ -171,12 +180,20 @@
 /***********************************************************************/
 int loadavg(double *av1, double *av5, double *av15) {
     double avg_1=0, avg_5=0, avg_15=0;
+    /* It is necessary to save and restore the numeric locale, because
+    if the locale we're in happens to use , instead of decimal point,
+    we can't sscanf the values in /proc/loadavg */
+    char*numeric=setlocale(LC_NUMERIC,0);
+    setlocale(LC_NUMERIC,"C");
     
     FILE_TO_BUF(LOADAVG_FILE,loadavg_fd);
     if (sscanf(buf, "%lf %lf %lf", &avg_1, &avg_5, &avg_15) < 3) {
 	fprintf(stderr, "bad data in " LOADAVG_FILE "\n");
 	exit(1);
+
     }
+    setlocale(LC_NUMERIC,numeric);
+    
     SET_IF_DESIRED(av1,  avg_1);
     SET_IF_DESIRED(av5,  avg_5);
     SET_IF_DESIRED(av15, avg_15);

--=-=-=


[...]


-- 

	http://www.penguinpowered.com/~vii

--=-=-=--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
