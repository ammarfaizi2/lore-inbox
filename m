Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWFZA6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWFZA6c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 20:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964981AbWFZA6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 20:58:31 -0400
Received: from terminus.zytor.com ([192.83.249.54]:14735 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964973AbWFZA6S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:58:18 -0400
Date: Sun, 25 Jun 2006 17:58:00 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 08/43] klibc: default initramfs content stored in usr/initramfs.default
Message-Id: <klibc.200606251757.08@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harcoding default content of initramfs in the gen_initramfs_list.sh
script seems ackward. Move it to a file named:
usr/initramfs.default

This also fixes a small bug when no arguments was passed to
CONFIG_INITRAMFS_SOURCE (-d was passed twice to the script)

Idea and bug report from: "H. Peter Anvin" <hpa@zytor.com>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 15ad2d153c3c214522eef889a14f3cd97f40864a
tree a38cc3695b10712f9dcf6864278ebc9cacc61a25
parent 7c753dbe7467f0d5ff6904f1bf5840350527e3c4
author Sam Ravnborg <sam@ravnborg.org> Mon, 01 May 2006 02:28:18 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 18 Jun 2006 18:46:46 -0700

 scripts/gen_initramfs_list.sh |   51 ++++++++++++++++-------------------------
 usr/initramfs.default         |    9 +++++++
 2 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/scripts/gen_initramfs_list.sh b/scripts/gen_initramfs_list.sh
index 331c079..624015c 100644
--- a/scripts/gen_initramfs_list.sh
+++ b/scripts/gen_initramfs_list.sh
@@ -15,7 +15,7 @@ set -e
 usage() {
 cat << EOF
 Usage:
-$0 [-o <file>] [-u <uid>] [-g <gid>] {-d | <cpio_source>} ...
+$0 [-o <file>] [-u <uid>] [-g <gid>] <cpio_source> ...
 	-o <file>      Create gzipped initramfs file named <file> using
 	               gen_init_cpio and gzip
 	-u <uid>       User ID to map to user ID 0 (root).
@@ -27,7 +27,6 @@ Usage:
 	<cpio_source>  File list or directory for cpio archive.
 	               If <cpio_source> is a .cpio file it will be used
 		       as direct input to initramfs.
-	-d             Output the default cpio list.
 
 All options except -o and -l may be repeated and are interpreted
 sequentially and immediately.  -u and -g states are preserved across
@@ -36,23 +35,6 @@ to reset the root/group mapping.
 EOF
 }
 
-list_default_initramfs() {
-	# echo usr/kinit/kinit
-	:
-}
-
-default_initramfs() {
-	cat <<-EOF >> ${output}
-		# This is a very simple, default initramfs
-
-		dir /dev 0755 0 0
-		nod /dev/console 0600 0 0 c 5 1
-		dir /root 0700 0 0
-		# file /kinit usr/kinit/kinit 0755 0 0
-		# slink /init kinit 0755 0 0
-	EOF
-}
-
 filetype() {
 	local argv1="$1"
 
@@ -167,8 +149,6 @@ header() {
 
 # process one directory (incl sub-directories)
 dir_filelist() {
-	${dep_list}header "$1"
-
 	srcdir=$(echo "$1" | sed -e 's://*:/:g')
 	dirlist=$(find "${srcdir}" -printf "%p %m %U %G\n" 2>/dev/null)
 
@@ -187,9 +167,7 @@ # if only one file is specified and it i
 # if a directory is specified then add all files in given direcotry to fs
 # if a regular file is specified assume it is in gen_initramfs format
 input_file() {
-	source="$1"
 	if [ -f "$1" ]; then
-		${dep_list}header "$1"
 		is_cpio="$(echo "$1" | sed 's/^.*\.cpio/cpio/')"
 		if [ $2 -eq 0 -a ${is_cpio} == "cpio" ]; then
 			cpio_file=$1
@@ -214,6 +192,15 @@ input_file() {
 	fi
 }
 
+# input file/dir - process it
+process_file() {
+	if [ -z ${print_header} ]; then
+		${dep_list}header "$1"
+	fi
+	print_header=y
+	input_file "$1" "$2"
+}
+
 prog=$0
 root_uid=0
 root_gid=0
@@ -249,27 +236,29 @@ while [ $# -gt 0 ]; do
 			root_gid="$1"
 			shift
 			;;
-		"-d")	# display default initramfs list
-			default_list="$arg"
-			${dep_list}default_initramfs
-			;;
 		"-h")
 			usage
 			exit 0
 			;;
 		*)
 			case "$arg" in
-				"-"*)
-					unknown_option
+				"-"*)	unknown_option
 					;;
-				*)	# input file/dir - process it
-					input_file "$arg" "$#"
+				*)	process_file "$arg" "$#"
 					;;
 			esac
 			;;
 	esac
 done
 
+# trailer of dependency list
+if [ ! -z ${dep_list} ]; then
+	echo ""
+	echo "initramfs: \$(deps_initramfs)"
+	echo "\$(deps_initramfs): ;"
+	echo ""
+fi
+
 # If output_file is set we will generate cpio archive and gzip it
 # we are carefull to delete tmp files
 if [ ! -z ${output_file} ]; then
diff --git a/usr/initramfs.default b/usr/initramfs.default
new file mode 100644
index 0000000..d23437a
--- /dev/null
+++ b/usr/initramfs.default
@@ -0,0 +1,9 @@
+#####################
+# This is a very simple, default initramfs
+# See gen_init_cpio for syntax
+
+dir dev 0755 0 0
+nod dev/console 0600 0 0 c 5 1
+dir root 0700 0 0
+file kinit usr/kinit/kinit 0755 0 0
+slink init kinit 0755 0 0
