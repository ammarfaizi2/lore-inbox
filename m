Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266435AbUBQSts (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 13:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266454AbUBQSts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 13:49:48 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:20152 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266435AbUBQStn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 13:49:43 -0500
Date: Tue, 17 Feb 2004 10:48:55 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@localhost.localdomain
To: Matthias Andree <matthias.andree@gmx.de>
cc: lksctp-developers@lists.sourceforge.net,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: [PATCH] net/sctp/Config.in make oldconfig compatibility (bash)
In-Reply-To: <20040217122347.GA15213@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.58.0402171035440.32361@localhost.localdomain>
References: <20040217122347.GA15213@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Matthias Andree wrote:

> Hello,
>
> I've needed the patch enclosed below the signature to remove some "make
> oldconfig" complaints in the current Linux-2.4 BK version.
>
> Please Cc: feedback to my sender address unless you are including
> linux-kernel; I'm not subscribed to lksctp-developers.
>

I thought SCTP changes were backed out just because of these 'make oldconfig'
errors from the 2.4 tree.

Anyway, i have submitted the attached patch that should fix this to davem.
'make oldconfig' and 'make menuconfig' worked fine after applying this patch.

However i am having problem with 'make xconfig'. When CONFIG_SCTP_HMAC_MD5
or CONFIG_SCTP_HMAC_SHA1 is enabled, everything under Crptographic options
is greyed out.

I would appreciate if some config expert can take a look at this and figure
out what is happening.

Thanks
Sridhar

-------------------------------------------------------------------------------
diff -Nru a/crypto/Config.in b/crypto/Config.in
--- a/crypto/Config.in	Mon Feb 16 15:39:29 2004
+++ b/crypto/Config.in	Mon Feb 16 15:39:29 2004
@@ -11,7 +11,9 @@
      "$CONFIG_INET6_AH" = "y" -o \
      "$CONFIG_INET6_AH" = "m" -o \
      "$CONFIG_INET6_ESP" = "y" -o \
-     "$CONFIG_INET6_ESP" = "m" ]; then
+     "$CONFIG_INET6_ESP" = "m" -o \
+     "$CONFIG_SCTP_HMAC_MD5" = "y" -o \
+     "$CONFIG_SCTP_HMAC_SHA1" = "y" ]; then
   define_bool CONFIG_CRYPTO y
 else
   bool 'Cryptographic API' CONFIG_CRYPTO
@@ -25,7 +27,9 @@
        "$CONFIG_INET6_AH" = "y" -o \
        "$CONFIG_INET6_AH" = "m" -o \
        "$CONFIG_INET6_ESP" = "y" -o \
-       "$CONFIG_INET6_ESP" = "m" ]; then
+       "$CONFIG_INET6_ESP" = "m" -o \
+       "$CONFIG_SCTP_HMAC_MD5" = "y" -o \
+       "$CONFIG_SCTP_HMAC_SHA1" = "y" ]; then
     define_bool CONFIG_CRYPTO_HMAC y
   else
     bool           '  HMAC support' CONFIG_CRYPTO_HMAC
@@ -39,7 +43,8 @@
        "$CONFIG_INET6_AH" = "y" -o \
        "$CONFIG_INET6_AH" = "m" -o \
        "$CONFIG_INET6_ESP" = "y" -o \
-       "$CONFIG_INET6_ESP" = "m" ]; then
+       "$CONFIG_INET6_ESP" = "m" -o \
+       "$CONFIG_SCTP_HMAC_MD5" = "y" ]; then
     define_bool CONFIG_CRYPTO_MD5 y
   else
     tristate       '  MD5 digest algorithm' CONFIG_CRYPTO_MD5
@@ -51,7 +56,8 @@
        "$CONFIG_INET6_AH" = "y" -o \
        "$CONFIG_INET6_AH" = "m" -o \
        "$CONFIG_INET6_ESP" = "y" -o \
-       "$CONFIG_INET6_ESP" = "m" ]; then
+       "$CONFIG_INET6_ESP" = "m" -o \
+       "$CONFIG_SCTP_HMAC_SHA1" = "y" ]; then
     define_bool CONFIG_CRYPTO_SHA1 y
   else
     tristate       '  SHA1 digest algorithm' CONFIG_CRYPTO_SHA1
diff -Nru a/net/sctp/Config.in b/net/sctp/Config.in
--- a/net/sctp/Config.in	Mon Feb 16 15:39:29 2004
+++ b/net/sctp/Config.in	Mon Feb 16 15:39:29 2004
@@ -14,31 +14,9 @@
 if [ "$CONFIG_IP_SCTP" != "n" ]; then
    bool '    SCTP: Debug messages' CONFIG_SCTP_DBG_MSG
    bool '    SCTP: Debug object counts' CONFIG_SCTP_DBG_OBJCNT
-fi
-if [ "$CONFIG_CRYPTO_HMAC" = "n"]; then
-  choice 'SCTP: Cookie HMAC Algorithm' \
-        "HMAC-NONE		CONFIG_SCTP_HMAC_NONE" HMAC-NONE
-else
-  if [ "$CONFIG_CRYPTO_MD5" = "n" -a "$CONFIG_CRYPTO_SHA1" = "n"]; then
-    choice 'SCTP: Cookie HMAC Algorithm' \
-        "HMAC-NONE		CONFIG_SCTP_HMAC_NONE" HMAC-NONE
-  else
-    if [ "$CONFIG_CRYPTO_MD5" != "n" -a "$CONFIG_CRYPTO_SHA1" != "n"]; then
-      choice 'SCTP: Cookie HMAC Algorithm' \
-        "HMAC-NONE		CONFIG_SCTP_HMAC_NONE \
-         HMAC-SHA1              CONFIG_SCTP_HMAC_SHA1 \
-         HMAC-MD5		CONFIG_SCTP_HMAC_MD5"	HMAC-SHA1
-    else
-      if [ "$CONFIG_CRYPTO_MD5" != "n" ]; then
-        choice 'SCTP: Cookie HMAC Algorithm' \
-        "HMAC-NONE		CONFIG_SCTP_HMAC_NONE \
-         HMAC-MD5		CONFIG_SCTP_HMAC_MD5"	HMAC-MD5
-      else
-        choice 'SCTP: Cookie HMAC Algorithm' \
-        "HMAC-NONE		CONFIG_SCTP_HMAC_NONE \
-         HMAC-SHA1		CONFIG_SCTP_HMAC_SHA1"	HMAC-SHA1
-      fi
-    fi
-  fi
+choice 'SCTP: Cookie HMAC Algorithm' \
+   "HMAC-NONE	CONFIG_SCTP_HMAC_NONE \
+    HMAC-SHA1   CONFIG_SCTP_HMAC_SHA1 \
+    HMAC-MD5	CONFIG_SCTP_HMAC_MD5"	HMAC-SHA1
 fi
 endmenu
