Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293722AbSDDMbq>; Thu, 4 Apr 2002 07:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312290AbSDDMbh>; Thu, 4 Apr 2002 07:31:37 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:49895 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S293722AbSDDMba>; Thu, 4 Apr 2002 07:31:30 -0500
Date: Thu, 4 Apr 2002 04:30:12 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Cc: benh@kernel.crashing.org, martin_rogge@ki.maus.de,
        jgarzik@mandrakesoft.com, dok@convergence.de,
        kraxel@goldbach.in-berlin.de, langa2@kph.uni-mainz.de
Subject: Patch: linux-2.5.8-pre1: Complete strtok --> strsep conversion
Message-ID: <20020404043012.A526@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.5.8-pre1 on longer defines strtok.  Instead,
kernel code is supposed to use strsep.  Seven files still
referenced strtok.  This patch converts the remaining strtok calls
to strsep and eliminates the EXPORT_SYMBOL(strtok) from ppc64.

	The line numbers in the patches may be skewed a bit because
there are other differences between my version of some of these
files and Linus's.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="strtok.diffs"

--- linux-2.5.8-pre1/drivers/video/atafb.c	2002-04-03 23:38:32.000000000 -0800
+++ linux/drivers/video/atafb.c	2002-04-04 03:34:00.000000000 -0800
@@ -2874,12 +2873,9 @@
 	user_mode[0]        =
 	fb_info.fontname[0] = '\0';
 
-    if (!options || !*options)
-		return 0;
-     
-    for(this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,",")) {
+    while ((this_opt = strsep(&options, ",")) != NULL) {
 	if (!*this_opt) continue;
 	if ((temp=get_video_mode(this_opt)))
 		default_par=temp;
--- linux-2.5.8-pre1/drivers/video/clgenfb.c	2002-03-18 12:37:10.000000000 -0800
+++ linux/drivers/video/clgenfb.c	2002-04-04 03:34:00.000000000 -0800
@@ -2857,12 +2883,8 @@
 
 	DPRINTK ("ENTER\n");
 
-	if (!options || !*options)
-		return 0;
-
-	for (this_opt = strtok (options, ","); this_opt != NULL;
-	     this_opt = strtok (NULL, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt) continue;
 
 		DPRINTK("clgenfb_setup: option '%s'\n", this_opt);
--- linux-2.5.8-pre1/drivers/video/neofb.c	2002-03-18 12:37:04.000000000 -0800
+++ linux/drivers/video/neofb.c	2002-04-04 03:34:00.000000000 -0800
@@ -2362,10 +2362,7 @@
 
   DBG("neofb_setup");
 
-  if (!options || !*options)
-    return 0;
-
-  for (this_opt=strtok(options,","); this_opt; this_opt=strtok(NULL,","))
+  while ((this_opt = strsep(&options, ",")) != NULL)
     {
       if (!*this_opt) continue;
 
--- linux-2.5.8-pre1/drivers/video/sis/sis_main.c	2002-03-18 12:37:17.000000000 -0800
+++ linux/drivers/video/sis/sis_main.c	2002-04-04 04:01:17.000000000 -0800
@@ -2254,13 +2254,9 @@
 	fb_info.fontname[0] = '\0';
 	ivideo.refresh_rate = 0;
 
-	if (!options || !*options)
-		return 0;
-
-	for (this_opt = strtok (options, ","); this_opt;
-	     this_opt = strtok (NULL, ",")) {
+	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt)
 			continue;
 
--- linux-2.5.8-pre1/drivers/scsi/ibmmca.c	2002-03-18 12:37:05.000000000 -0800
+++ linux/drivers/scsi/ibmmca.c	2002-04-04 03:34:00.000000000 -0800
@@ -1406,9 +1408,8 @@
    io_base = 0;
    id_base = 0;
    if (str) {
-      token = strtok(str,",");
       j = 0;
-      while (token) {
+      while ((token = strsep(&str, ",")) != NULL) {
 	 if (!strcmp(token,"activity")) display_mode |= LED_ACTIVITY;
 	 if (!strcmp(token,"display")) display_mode |= LED_DISP;
 	 if (!strcmp(token,"adisplay")) display_mode |= LED_ADISP;
@@ -1424,8 +1425,7 @@
 	      scsi_id[id_base++] = simple_strtoul(token,NULL,0);
 	    j++;
 	 }
-	 token = strtok(NULL,",");
       }
    } else if (ints) {
       for (i = 0; i < IM_MAX_HOSTS && 2*i+2 < ints[0]; i++) {
--- linux-2.5.8-pre1/arch/ppc64/kernel/ppc_ksyms.c	2002-03-18 12:37:08.000000000 -0800
+++ linux/arch/ppc64/kernel/ppc_ksyms.c	2002-04-04 04:06:05.000000000 -0800
@@ -109,7 +109,6 @@
 EXPORT_SYMBOL(strchr);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(strpbrk);
-EXPORT_SYMBOL(strtok);
 EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strnlen);

--2oS5YaxWCcQjTEyO--
