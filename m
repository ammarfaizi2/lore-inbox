Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUHQGU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUHQGU0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 02:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUHQGU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 02:20:26 -0400
Received: from holomorphy.com ([207.189.100.168]:62892 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263429AbUHQGUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 02:20:20 -0400
Date: Mon, 16 Aug 2004 23:20:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
Message-ID: <20040817062017.GL11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816143710.1cd0bd2c.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 02:37:10PM -0700, Andrew Morton wrote:
> handle-undefined-symbols.patch
>   Fail if vmlinux contains undefined symbols
> sparc32-ignore-undefined-symbols-with-3-or-more-leading-underscores.patch
>   sparc32: ignore undefined symbols with 3 or more leading underscores

Okay, this patch has officially made my shitlist along with whatever
introduced the second check. The following appears to be necessary to
get sparc64 to link, which of course clashes wildly with the UML
changes to get *it* to link.

And why the Hell are we checking twice??? Check #2 lagging behind
check #1 wrt. updates caused a relatively large amount of pain as I had
to scour the whole damn tree for where the Hell check #2 was happening
and that on a relatively slow box as my faster sparc64 box is down until
ambient temperature regulation issues are mitigated by weather.

This scripting crap is fragile and nightmarish. We should probably be
examining the ELF bits directly in C.


-- wli

Index: mm1-2.6.8.1/Makefile
===================================================================
--- mm1-2.6.8.1.orig/Makefile	2004-08-16 21:09:23.000000000 -0700
+++ mm1-2.6.8.1/Makefile	2004-08-16 23:06:39.530357000 -0700
@@ -542,8 +542,29 @@
 	$(if $($(quiet)cmd_vmlinux__),					\
 	  echo '  $($(quiet)cmd_vmlinux__)' &&) 			\
 	$(cmd_vmlinux__);						\
-	if $(OBJDUMP) --syms $@ | $(AWK) '$$4!~/^___.*/ { print $$0 }'	\
-		| egrep -q '^([^R]|R[^E]|RE[^G])[^w]*\*UND\*'; then	\
+	if $(OBJDUMP) --syms $@						\
+	| $(AWK) 'BEGIN {						\
+		status = 1						\
+	}								\
+	$$4 !~ /^___.*/ && $$1 !~ /^REG.*/ {				\
+		for (i = 0; i < NF; ++i) {				\
+			if ($$i == "*UND*") {				\
+				for (j = i - 1; j >= 0; --j) {		\
+					if ($$j == "w")			\
+						break;			\
+				}					\
+				if (j < 0) {				\
+					printf "undefined!!\n";		\
+					print $$0;			\
+					status = 0			\
+				}					\
+			}						\
+		}							\
+	}								\
+	END {								\
+		exit status						\
+	}';								\
+		then							\
 		echo 'ldchk: $@: final image has undefined symbols:';	\
 		$(NM) $@ | sed 's/^ *U \(.*\)/  \1/p;d';		\
 		$(RM) -f $@;						\
Index: mm1-2.6.8.1/scripts/mksysmap
===================================================================
--- mm1-2.6.8.1.orig/scripts/mksysmap	2004-08-16 21:07:48.000000000 -0700
+++ mm1-2.6.8.1/scripts/mksysmap	2004-08-16 23:07:40.852035000 -0700
@@ -18,9 +18,31 @@
 # they are used by the sparc BTFIXUP logic - and is assumed to be undefined.
 
 
-if [ "`$NM -u $1 | grep -v ' ___'`" != "" ]; then
-	echo "$1: error: undefined symbol(s) found:"
-	$NM -u $1 | grep -v ' ___'
+if $(OBJDUMP) --syms $@							\
+	| $(AWK) 'BEGIN {						\
+		status = 1						\
+	}								\
+	$$4 !~ /^___.*/ && $$1 !~ /^REG.*/ {				\
+		for (i = 0; i < NF; ++i) {				\
+			if ($$i == "*UND*") {				\
+				for (j = i - 1; j >= 0; --j) {		\
+					if ($$j == "w")			\
+						break;			\
+				}					\
+				if (j < 0) {				\
+					printf "undefined!!\n";		\
+					print $$0;			\
+					status = 0			\
+				}					\
+			}						\
+		}							\
+	}								\
+	END {								\
+		exit status						\
+	}';								\
+	then
+		echo "$1: error: undefined symbol(s) found:"
+		$NM -u $1 | grep -v ' ___'
 	exit 1
 fi
 
