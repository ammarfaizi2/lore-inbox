Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUJZUMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUJZUMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUJZUMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:12:45 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:41360 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261378AbUJZULo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:11:44 -0400
Date: Wed, 27 Oct 2004 00:12:16 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.9-bk7] Select cpio_list or source directory for initramfs image updates [u]
Message-ID: <20041026221216.GA30918@mars.ravnborg.org>
Mail-Followup-To: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <200410200849.i9K8n5921516@mail.osdl.org> <1098533188.668.9.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098533188.668.9.camel@nosferatu.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 02:06:28PM +0200, Martin Schlemmer [c] wrote:
> Hi,
> 
> Here is some updates after talking to Sam Ravnborg.  He did not yet come
> back to me, I am not sure if I understood 100% what he meant, but hopefully
> somebody else will be so kind as to comment.

Hi Martin.
Took a look at your patch and did not like it.
Attached my version which I will push towards Linus soon.

Main difference is that I move logic to gen_initramfs_list-sh.
Then I also use filechk - so I actually generate the file - but
do not update the final file unless needed.

Current patch will not rebuild image if one of the
programs listed are changed. But it should give a good
foundation to do so.

	Sam

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/27 00:07:03+02:00 sam@mars.ravnborg.org 
#   kbuild/usr: initramfs list fixed and simplified
#   
#   Moving logic to scripts/gen_initramfs_list.sh make a nice cleanup in
#   usr/Makefile.
#   A new initramfs image will be generated if the initramfs_list file changes.
#   This patch also fixes the bug with make O=..
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# usr/Makefile
#   2004/10/27 00:06:46+02:00 sam@mars.ravnborg.org +9 -20
#   Simplify - logic moved to gen_initramfs_list.sh script
# 
# scripts/gen_initramfs_list.sh
#   2004/10/27 00:06:46+02:00 sam@mars.ravnborg.org +35 -16
#   Moved logic to this file.
#   It now handles both dirs, files and no input given.
#   For invalid input print error and boild out.
# 
# scripts/Makefile.lib
#   2004/10/27 00:06:46+02:00 sam@mars.ravnborg.org +27 -0
#   Added filechk - copy from top level Makefile
# 
# BitKeeper/etc/ignore
#   2004/10/27 00:06:24+02:00 sam@mars.ravnborg.org +1 -0
#   added usr/initramfs_list
# 
# BitKeeper/deleted/.del-initramfs_list~e02c62efaa478389
#   2004/10/27 00:02:17+02:00 sam@mars.ravnborg.org +0 -0
#   Delete: usr/initramfs_list
# 
diff -Nru a/scripts/Makefile.lib b/scripts/Makefile.lib
--- a/scripts/Makefile.lib	2004-10-27 00:07:50 +02:00
+++ b/scripts/Makefile.lib	2004-10-27 00:07:50 +02:00
@@ -232,3 +232,30 @@
 # Usage:
 # $(Q)$(MAKE) $(build)=dir
 build := -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.build obj
+
+# filechk is used to check if the content of a generated file is updated.
+# Sample usage:
+# define filechk_sample
+#	echo $KERNELRELEASE
+# endef
+# version.h : Makefile
+#	$(call filechk,sample)
+# The rule defined shall write to stdout the content of the new file.
+# The existing file will be compared with the new one.
+# - If no file exist it is created
+# - If the content differ the new file is used
+# - If they are equal no change, and no timestamp update
+
+define filechk
+	$(Q)set -e;				\
+	echo '  CHK     $@';			\
+	mkdir -p $(dir $@);			\
+	$(filechk_$(1)) $(2) > $@.tmp;		\
+	if [ -r $@ ] && cmp -s $@ $@.tmp; then	\
+		rm -f $@.tmp;			\
+	else					\
+		echo '  UPD     $@';		\
+		mv -f $@.tmp $@;		\
+	fi
+endef
+
diff -Nru a/scripts/gen_initramfs_list.sh b/scripts/gen_initramfs_list.sh
--- a/scripts/gen_initramfs_list.sh	2004-10-27 00:07:50 +02:00
+++ b/scripts/gen_initramfs_list.sh	2004-10-27 00:07:50 +02:00
@@ -2,25 +2,26 @@
 # Copyright (C) Martin Schlemmer <azarah@nosferatu.za.org>
 # Released under the terms of the GNU GPL
 #
-# A script to generate newline separated entries (to stdout) from a directory's
-# contents suitable for use as a cpio_list for gen_init_cpio.
+# Generate a newline separated list of entries from the file/directory pointed
+# out by the environment variable: CONFIG_INITRAMFS_SOURCE
 #
-# Arguements: $1 -- the source directory
+# If CONFIG_INITRAMFS_SOURCE is non-existing then generate a small dummy file.
+#
+# The output is suitable for gen_init_cpio as found in usr/Makefile.
 #
 # TODO:  Add support for symlinks, sockets and pipes when gen_init_cpio
 #        supports them.
 
-usage() {
-	echo "Usage: $0 initramfs-source-dir"
-	exit 1
+simple_initramfs() {
+	cat <<-EOF
+		# This is a very simple initramfs
+
+		dir /dev 0755 0 0
+		nod /dev/console 0600 0 0 c 5 1
+		dir /root 0700 0 0
+	EOF
 }
 
-srcdir=$(echo "$1" | sed -e 's://*:/:g')
-
-if [ "$#" -gt 1 -o ! -d "${srcdir}" ]; then
-	usage
-fi
-
 filetype() {
 	local argv1="$1"
 
@@ -76,9 +77,27 @@
 	return 0
 }
 
-find "${srcdir}" -printf "%p %m %U %G\n" | \
-while read x; do
-	parse ${x}
-done
+if [ -z $1 ]; then
+	simple_initramfs
+elif [ -f $1 ]; then
+	cat $1
+elif [ -d $1 ]; then
+	srcdir=$(echo "$1" | sed -e 's://*:/:g')
+	dirlist=$(find "${srcdir}" -printf "%p %m %U %G\n" 2>/dev/null)
+
+	# If $dirlist is only one line, then the directory is empty
+	if [  "$(echo "${dirlist}" | wc -l)" -gt 1 ]; then
+		echo "${dirlist}" | \
+		while read x; do
+			parse ${x}
+		done
+	else
+		# Failsafe in case directory is empty
+		simple_initramfs
+	fi
+else
+	echo "  $0: Cannot open '$1' (CONFIG_INITRAMFS_SOURCE)" >&2
+	exit 1
+fi
 
 exit 0
diff -Nru a/usr/Makefile b/usr/Makefile
--- a/usr/Makefile	2004-10-27 00:07:50 +02:00
+++ b/usr/Makefile	2004-10-27 00:07:50 +02:00
@@ -3,7 +3,7 @@
 
 hostprogs-y  := gen_init_cpio
 
-clean-files := initramfs_data.cpio.gz
+clean-files := initramfs_data.cpio.gz initramfs_list
 
 # If you want a different list of files in the initramfs_data.cpio
 # then you can either overwrite the cpio_list in this directory
@@ -23,28 +23,17 @@
 # Commented out for now
 # initramfs-y := $(obj)/root/hello
 
-quiet_cmd_gen_list = GEN_INITRAMFS_LIST $@
-      cmd_gen_list = $(shell \
-        if test -f $(CONFIG_INITRAMFS_SOURCE); then \
-	  if [ $(CONFIG_INITRAMFS_SOURCE) != $@ ]; then \
-	    echo 'cp -f $(CONFIG_INITRAMFS_SOURCE) $@'; \
-	  else \
-	    echo 'echo Using shipped $@'; \
-	  fi; \
-	elif test -d $(CONFIG_INITRAMFS_SOURCE); then \
-	  echo 'scripts/gen_initramfs_list.sh $(CONFIG_INITRAMFS_SOURCE) > $@'; \
-	else \
-	  echo 'echo Using shipped $@'; \
-	fi)
-
-
-$(INITRAMFS_LIST): FORCE
-	$(call cmd,gen_list)
+filechk_initramfs_list = $(CONFIG_SHELL) \
+ $(srctree)/scripts/gen_initramfs_list.sh $(CONFIG_INITRAMFS_SOURCE)
+			   
+$(obj)/initramfs_list: FORCE
+	$(call filechk,initramfs_list)
 
 quiet_cmd_cpio = CPIO    $@
-      cmd_cpio = ./$< $(INITRAMFS_LIST) > $@
+      cmd_cpio = ./$< $(obj)/initramfs_list > $@
 
-$(obj)/initramfs_data.cpio: $(obj)/gen_init_cpio $(initramfs-y) $(INITRAMFS_LIST) FORCE
+$(obj)/initramfs_data.cpio: $(obj)/gen_init_cpio \
+                            $(initramfs-y) $(obj)/initramfs_list FORCE
 	$(call if_changed,cpio)
 
 targets += initramfs_data.cpio
diff -Nru a/usr/initramfs_list b/usr/initramfs_list
--- a/usr/initramfs_list	2004-10-27 00:07:50 +02:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,5 +0,0 @@
-# This is a very simple initramfs - mostly preliminary for future expansion
-
-dir /dev 0755 0 0
-nod /dev/console 0600 0 0 c 5 1
-dir /root 0700 0 0


