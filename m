Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161318AbWKEQhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161318AbWKEQhx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 11:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161334AbWKEQhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 11:37:53 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:46277 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161318AbWKEQhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 11:37:52 -0500
Date: Sun, 5 Nov 2006 17:36:41 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jens Axboe <jens.axboe@oracle.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: menuconfig benchmark for if/endif vs depends-on
Message-ID: <Pine.LNX.4.61.0611031354520.9606@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-760065471-1162744601=:12074"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-760065471-1162744601=:12074
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT



In response to http://lkml.org/lkml/2006/10/20/357 I did a poor-man's 
benchmark over whether

	(1) depends on BLOCK

	(2) if BLOCK/endif

is faster, and surprisingly,

	(1) 8.92s 8.90s 8.92s

	(2) 9.19s 9.21s 9.21s

came up.

This is the `generate` script used:

#!/bin/bash
ele=50000;
for((i = 0; i < $ele; ++i)); do
    echo -en "config V$i\n bool \"$i\"\n depends on BLOCK\n\n";
done >fs/big-thing1;
(
    echo -en "if BLOCK\n\n";
    for((i = 0; i < $ele; ++i)); do
        echo -en "config V$i\n bool \"$i\"\n\n";
    done;
    echo -en "endif\n\n";
) >fs/big-thing2;

One of the generated file would then be included in e.g. fs/Kconfig 
using a "source" statement.

This the patch:
Index: linux-2.6.19-rc4/scripts/kconfig/mconf.c
===================================================================
--- linux-2.6.19-rc4.orig/scripts/kconfig/mconf.c
+++ linux-2.6.19-rc4/scripts/kconfig/mconf.c
@@ -8,6 +8,7 @@
  * i18n, 2005, Arnaldo Carvalho de Melo <acme@conectiva.com.br>
  */
 
+#include <sys/time.h>
 #include <sys/ioctl.h>
 #include <sys/wait.h>
 #include <ctype.h>
@@ -858,6 +859,27 @@ static void conf_cleanup(void)
 	tcsetattr(1, TCSAFLUSH, &ios_org);
 }
 
+static void tv_delta(const struct timeval *past, const struct timeval *now,
+  struct timeval *dest)
+{
+    /* Calculates the time difference between "past" and "now" and stores the
+    result in "dest". All parameters in µs. */
+    unsigned long sec = now->tv_sec - past->tv_sec;
+    long acc = now->tv_usec - past->tv_usec;
+
+    if(acc < 0) {
+        // past: 1.5, now: 2.0, sec = 2 - 1 = 1, acc = 0 - 500000 = -500000;
+        dest->tv_sec = --sec;
+#define MICROSECOND 1000000
+        dest->tv_usec = MICROSECOND + acc;
+    } else {
+        dest->tv_sec = sec;
+        dest->tv_usec = acc;
+    }
+
+    return;
+}
+
 int main(int ac, char **av)
 {
 	struct symbol *sym;
@@ -868,9 +890,17 @@ int main(int ac, char **av)
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 
+        struct timeval tv_past, tv_now, tv_diff;
+        gettimeofday(&tv_past, NULL);
+
 	conf_parse(av[1]);
 	conf_read(NULL);
 
+        gettimeofday(&tv_now, NULL);
+        tv_delta(&tv_past, &tv_now, &tv_diff);
+        printf("Parse time took %ld.%06ld\n", tv_diff.tv_sec, tv_diff.tv_usec);
+        exit(0);
+
 	sym = sym_lookup("KERNELVERSION", 0);
 	sym_calc_value(sym);
 	sprintf(menu_backtitle, _("Linux Kernel v%s Configuration"),
#<EOF>


	-`J'
-- 
--1283855629-760065471-1162744601=:12074--
