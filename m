Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317385AbSINRBR>; Sat, 14 Sep 2002 13:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317392AbSINRBR>; Sat, 14 Sep 2002 13:01:17 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:62085 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S317385AbSINRBQ>; Sat, 14 Sep 2002 13:01:16 -0400
Date: Sat, 14 Sep 2002 14:05:49 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
cc: linux-kernel@vger.kernel.org, <conman@kolivas.net>
Subject: Re: your mail
In-Reply-To: <20020914123948.26265.qmail@linuxmail.org>
Message-ID: <Pine.LNX.4.44L.0209141405160.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Sep 2002, Paolo Ciarrocchi wrote:

> I think that only the _memload_ test is not
> working with 2.5.*, am I wrong?

You're right, the memload test doesn't work with 2.5 but
needs the following patch...

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org


--- contest-0.1/mem_load.c.orig	2002-09-13 23:36:47.000000000 -0400
+++ contest-0.1/mem_load.c	2002-09-14 11:10:07.000000000 -0400
@@ -47,24 +47,25 @@
   switch (type) {

   case 0: /* RAM */
-    if ((position = strstr(buffer, "Mem:")) == (char *) NULL) {
-      fprintf (stderr, "Can't parse \"Mem:\" in /proc/meminfo\n");
+    if ((position = strstr(buffer, "MemTotal:")) == (char *) NULL) {
+      fprintf (stderr, "Can't parse \"MemTotal:\" in /proc/meminfo\n");
       exit (-1);
     }
-    sscanf (position, "Mem:  %ul", &size);
+    sscanf (position, "MemTotal:  %ul", &size);
     break;

   case 1:
-    if ((position = strstr(buffer, "Swap:")) == (char *) NULL) {
-      fprintf (stderr, "Can't parse \"Swap:\" in /proc/meminfo\n");
+    if ((position = strstr(buffer, "SwapTotal:")) == (char *) NULL) {
+      fprintf (stderr, "Can't parse \"SwapTotal:\" in /proc/meminfo\n");
       exit (-1);
     }
-    sscanf (position, "Swap: %ul", &size);
+    sscanf (position, "SwapTotal: %ul", &size);
     break;

   }

-  return (size / MB);
+  /* convert from kB to MB */
+  return (size / KB);

 }

--- contest-0.1/mem_load.h.orig	2002-09-14 11:09:28.000000000 -0400
+++ contest-0.1/mem_load.h	2002-09-14 11:09:42.000000000 -0400
@@ -24,6 +24,7 @@

 #define MAX_BUF_SIZE 1024          /* size of /proc/meminfo in bytes */
 #define MB (1024 * 1024)           /* 2^20 bytes */
+#define KB 1024
 #define MAX_MEM_IN_MB (1024 * 64)  /* 64 GB */

 /* Tuning parameter.  Increase if you are getting an 'unreasonable' load

