Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268001AbUHXPWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268001AbUHXPWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267993AbUHXPWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:22:48 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:12265 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S267987AbUHXPWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:22:09 -0400
From: mita akinobu <amgta@yacht.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: [util-linux] readprofile ignores the last element in /proc/profile
Date: Wed, 25 Aug 2004 00:22:09 +0900
User-Agent: KMail/1.5.4
Cc: Andries Brouwer <aeb@cwi.nl>, Alessandro Rubini <rubini@ipvvis.unipv.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408250022.09878.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The readprofile command does not print the number of clock ticks about
the last element in profiling buffer.

Since the number of clock ticks which occur on the module functions is
as same as the value of the last element of prof_buffer[]. when many
ticks occur on there, some users who browsing the output of readprofile
may overlook the fact that the bottle-neck may exist in the modules.

I create the patch which enable to print clock ticks of the last
element as "*unknown*".

# readprofile
 77843 poll_idle                                1526.3333
     1 cpu_idle                                   0.0043
 [...]
     4 schedule_timeout                           0.0209
     2 *unknown*
108494 total                                      0.0385

If the clock ticks of '*unknown*' is large, it is highly recommended
to use OProfile, or to retry readprofile after compiling suspicious
modules into the kernel.

Mr.Brouwer, Could you apply this patch against util-linux-2.12a?


--- util-linux-2.12a/sys-utils/readprofile.c.orig	2004-08-24 23:11:16.383760112 +0900
+++ util-linux-2.12a/sys-utils/readprofile.c	2004-08-24 23:15:03.780190600 +0900
@@ -145,6 +145,7 @@ main(int argc, char **argv) {
 	int maplineno=1;
 	int popenMap;   /* flag to tell if popen() has been used */
 	int header_printed;
+	int end_of_text=0;
 
 #define next (current^1)
 
@@ -314,7 +315,7 @@ main(int argc, char **argv) {
 	/*
 	 * Main loop.
 	 */
-	while (fgets(mapline,S_LEN,map)) {
+	while (!end_of_text && fgets(mapline,S_LEN,map)) {
 		unsigned int this=0;
 
 		if (sscanf(mapline,"%llx %s %s",&next_add,mode,next_name)!=3) {
@@ -327,9 +328,8 @@ main(int argc, char **argv) {
 		/* ignore any LEADING (before a '[tT]' symbol is found)
 		   Absolute symbols */
 		if ((*mode == 'A' || *mode == '?') && total == 0) continue;
-		if (*mode != 'T' && *mode != 't' &&
-		    *mode != 'W' && *mode != 'w')
-			break;	/* only text is profiled */
+		if (!strcmp(next_name, "_etext"))
+			end_of_text = 1;
 
 		if (indx >= len / sizeof(*buf)) {
 			fprintf(stderr, _("%s: profile address out of range. "
@@ -367,6 +367,9 @@ main(int argc, char **argv) {
 
 		maplineno++;
 	}
+	/* clock ticks, out of kernel text */
+	printf("%6i %s\n", buf[len/sizeof(*buf)-1], "*unknown*");
+
 	/* trailer */
 	if (optVerbose)
 		printf("%016x %-40s %6i %8.4f\n",


