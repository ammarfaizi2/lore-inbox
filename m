Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267421AbUHMT6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267421AbUHMT6a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267502AbUHMT4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:56:44 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:43309 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267406AbUHMTuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:50:16 -0400
Date: Fri, 13 Aug 2004 21:52:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [12/12] kbuild: __crc_* symbols in System.map
Message-ID: <20040813195238.GL10556@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040813192804.GA10486@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813192804.GA10486@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/13 20:14:30+02:00 sam@mars.ravnborg.org 
#   kbuild: __crc_* symbols in System.map
#   
#   David S. Miller <davem@redhat.com> wrote:
#   Shouldn't we be grepping __crc_ symbols out of the System.map file?
#   
#   For one thing, these can confuse readprofile.  It's algorithm is
#   to start at _stext, then stop when it sees a line in the System.map
#   which is not text (mode is one of 'T' 't' 'W' or 'w')
#   
#   It will exit early if there are some intermixed __crc_* things in
#   there (since they are are mode 'A').
#   
#   For example, in my current sparc64 kernel I have this:
#   
#   00000000004cef80 t do_split
#   00000000004cf2a0 t add_dirent_to_buf
#   00000000004cf5a7 A __crc_init_special_inode
#   00000000004cf640 t make_indexed_dir
#   00000000004cf900 t ext3_add_entry
#   
#   So no symbols after add_dirent_to_buf will be shown in the profiling
#   output of readprofile.
#   
#   Implementation ported to mksysmap by Sam.
#   Included two System.map related fixes:
#   - Print "SYSMAP  System.map" during build
#   - Sort symbols in System.map
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/mksysmap
#   2004/08/13 20:14:14+02:00 sam@mars.ravnborg.org +8 -1
#   Remove __crc_ symbols from System.map
#   Now also sort the output; '-n' option to nm
# 
# Makefile
#   2004/08/13 20:14:14+02:00 sam@mars.ravnborg.org +6 -6
#   Print out:
#   SYSMAP  System.map
#   during build.
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-08-13 21:07:25 +02:00
+++ b/Makefile	2004-08-13 21:07:25 +02:00
@@ -608,12 +608,12 @@
 
 define rule_vmlinux
 	$(rule_vmlinux__);
-	$(Q)$(if $($(quiet)cmd_sysmap),          \
-	  echo '  $($(quiet)cmd_sysmap) $@' &&)  \
-	$(cmd_sysmap) $@ System.map;             \
-	if [ $$? -ne 0 ]; then                   \
-		rm -f $@;                        \
-		/bin/false;                      \
+	$(Q)$(if $($(quiet)cmd_sysmap),                  \
+	  echo '  $($(quiet)cmd_sysmap) System.map' &&)  \
+	$(cmd_sysmap) $@ System.map;                     \
+	if [ $$? -ne 0 ]; then                           \
+		rm -f $@;                                \
+		/bin/false;                              \
 	fi;
 	$(rule_verify_kallsyms)
 endef
diff -Nru a/scripts/mksysmap b/scripts/mksysmap
--- a/scripts/mksysmap	2004-08-13 21:07:25 +02:00
+++ b/scripts/mksysmap	2004-08-13 21:07:25 +02:00
@@ -51,4 +51,11 @@
 #   U - undefined global symbols
 #   w - local weak symbols
 
-nm $1 | grep -v ' [aUw] ' > $2
+# readprofile starts reading symbols when _stext is found, and
+# continue until it finds a symbol which is not either of 'T', 't',
+# 'W' or 'w'. __crc_ are 'A' and placed in the middle
+# so we just ignore them to let readprofile continue to work.
+# (At least sparc64 has __crc_ in the middle).
+
+$NM -n $1 | grep -v '\( [aUw] \)\|\(__crc_\)' > $2
+
