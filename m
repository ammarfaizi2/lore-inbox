Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRAGJAG>; Sun, 7 Jan 2001 04:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129632AbRAGI7z>; Sun, 7 Jan 2001 03:59:55 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:9959 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S129595AbRAGI7k>; Sun, 7 Jan 2001 03:59:40 -0500
Date: Sun, 7 Jan 2001 10:00:02 +0100 (CET)
From: Matthias Juchem <matthias@gandalf.math.uni-mannheim.de>
Reply-To: Matthias Juchem <juchem@uni-mannheim.de>
To: <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>, Ulrich Drepper <drepper@cygnus.com>
Subject: [PATCH] Re: [PATCH] new bug report script
In-Reply-To: <m3k887bxsf.fsf@otr.mynet.cygnus.com>
Message-ID: <Pine.LNX.4.30.0101070950530.7104-100000@gandalf.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan.

My previous patch contained a few bugs (i.e. libc5 was not found). Here is
a patch that depends on the previous one.

Regards,
 Matthias

On 6 Jan 2001, Ulrich Drepper wrote:
> This is wrong.  You cannot execute libc.so.5.
[..]


--- scripts/bugreport.pl.orig	Sun Jan  7 09:57:42 2001
+++ scripts/bugreport.pl	Sun Jan  7 09:58:11 2001
@@ -47,7 +47,7 @@
 ##################### main ###################################################

 {
-    print "\nbugreport.pl - Linux Kernel Problem Report Generator v0.1\n";
+    print "\nbugreport.pl - Linux Kernel Problem Report Generator v0.2\n";
     print "=========================================================\n";
     print "       written by Matthias Juchem <matthias\@brightice.de>\n\n";

@@ -217,12 +217,14 @@
     }

     # c library 5
-    if ( -e "/lib/libc.so.5" ) {
-	( $v_libc5 = `/lib/libc.so.5`) =~ m/GNU C Library .+ version (\S+),/;
-	$v_libc5 = $1;
-    } else {
-	$v_libc5 = "not found";
+    opendir LIBDIR, "/lib" or die "/lib/ not found, very strange";
+    my @allfiles = readdir LIBDIR;
+    closedir LIBDIR;
+    $v_libc5 = 'not found';
+    foreach (sort @allfiles) {
+	m/libc.so.(5\S+)/ and $v_libc5 = $1;
     }
+    closedir LIBDIR;

     # c library 6
     if ( -e "/lib/libc.so.6" ) {
@@ -269,32 +271,60 @@
     }

     # util-linux
-    ( $v_utillinux = `mount --version` ) =~ m/mount-(\S+)\n/;
-    $v_utillinux = $1;
+    if (exists_prog("mount")) {
+	( $v_utillinux = `mount --version` ) =~ m/mount-(\S+)\n/;
+	$v_utillinux = $1;
+    } else {
+	$v_utillinux = "not found";
+    }

     # nettools
-    ( $v_nettools = `hostname -V 2>&1` ) =~ m/tools (\S+)\n/;
-    $v_nettools = $1;
+    if (exists_prog("hostname")) {
+	( $v_nettools = `hostname -V 2>&1` ) =~ m/tools (\S+)\n/;
+	$v_nettools = $1;
+    } else {
+	$v_nettools = "not found";
+    }

     # pppd
-    ( $v_pppd = `pppd -V 2>&1`) =~ m/pppd version (\S+)\n/;
-    $v_pppd = $1;
+    if (exists_prog("pppd")) {
+	( $v_pppd = `pppd --version /dev/tty 2>&1`) =~ m/pppd version (\S+)/;
+	$v_pppd = $1;
+    } else {
+	$v_pppd = "not found";
+    }

     # kbd
-    ( $v_kbd = `loadkeys -h 2>&1`) =~ m/loadkeys version (\S+)\n/;
-    $v_kbd = $1;
+    if (exists_prog("loadkeys")) {
+	( $v_kbd = `loadkeys -h 2>&1`) =~ m/loadkeys version (\S+)\n/;
+	$v_kbd = $1;
+    } else {
+	$v_kbd = "not found";
+    }

     # shutils
-    ( $v_shutils = `expr --v 2>&1`) =~ m/\(GNU sh-utils\) (\S+)\n/;
-    $v_shutils = $1;
+    if (exists_prog("expr")) {
+	( $v_shutils = `expr --v 2>&1`) =~ m/\(GNU sh-utils\) (\S+)\n/;
+	$v_shutils = $1;
+    } else {
+	$v_shutils = "not found";
+    }

     # e2fsprogs
-    ( $v_e2fsprogs = `tune2fs 2>&1`) =~ m/tune2fs (\S+),/;
-    $v_e2fsprogs = $1;
+    if (exists_prog("tune2fs")) {
+	( $v_e2fsprogs = `tune2fs 2>&1`) =~ m/tune2fs (\S+),/;
+	$v_e2fsprogs = $1;
+    } else {
+	$v_e2fsprogs = "not found";
+    }

     # bash
-    ( $v_bash = `bash --version`) =~ m/GNU bash, version (\S+) /;
-    $v_bash = $1;
+    if (exists_prog("bash")) {
+	( $v_bash = `bash --version`) =~ m/GNU bash, version (\S+) /;
+	$v_bash = $1;
+    } else {
+	$v_bash = "not found";
+    }


     # loaded modules

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
