Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWDKLay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWDKLay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWDKLai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:30:38 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:6409 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750764AbWDKLaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:30:30 -0400
Date: Tue, 11 Apr 2006 13:30:12 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, klibc@zytor.com,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [klibc] [PATCH] kbuild: rebuild initramfs if included files changes
Message-ID: <20060411113012.GA13670@mars.ravnborg.org>
References: <20060409205920.GA22482@mars.ravnborg.org> <20060410223209.GA16842@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410223209.GA16842@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2006 at 12:32:09AM +0200, Sam Ravnborg wrote:
> On Sun, Apr 09, 2006 at 10:59:20PM +0200, Sam Ravnborg wrote:
> > This fix has been implemented in preparation for the upcoming klibc
> > merge in -mm. But as it fixes a real (but rare I hope) bug in vanilla
> > kernel it will be added to my pending 2.6.17 kbuild queue.
> > 
> > I've done quite some changes to the gen_initramfs script and
> > being shell programming newbie review by more experienced shell
> > hackers would be appreciated.
> > 
> > I did a git mv scripts/gen_initramfs_list.sh usr/gen_initramfs.sh
> > But the changes was so many that git does not see the rename.
> > Due to the rename the diffstat shows a bit mroe changes than reality.
> 
> This patch turned out to be bogus.
> I have something new in the works - will be finished tomorrow.
And here it goes.

 scripts/gen_initramfs_list.sh |  225 ++++++++++++++++++++++++++++--------------
 usr/Makefile                  |   91 ++++++----------
 2 files changed, 189 insertions(+), 127 deletions(-)
 
diff-tree d39a206bc35d46a3b2eb98cd4f34e340d5e56a50 (from d9df92e22aca939857c5bc9ecb130ef22307ccc1)
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Tue Apr 11 13:24:32 2006 +0200

    kbuild: rebuild initramfs if content of initramfs changes
    
    initramfs.cpio.gz being build in usr/ and included in the
    kernel was not rebuild when the included files changed.
    
    To fix this the following was done:
    - let gen_initramfs.sh generate a list of files and directories included
      in the initramfs
    - gen_initramfs generate the gzipped cpio archive so we could simplify
      the kbuild file (Makefile)
    - utilising the kbuild infrastructure so when uid/gid root mapping changes
      the initramfs will be rebuild
    
    With this change we have a much more robust initramfs generation.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/scripts/gen_initramfs_list.sh b/scripts/gen_initramfs_list.sh
index 6d41116..56b3bed 100644
--- a/scripts/gen_initramfs_list.sh
+++ b/scripts/gen_initramfs_list.sh
@@ -1,22 +1,55 @@
 #!/bin/bash
 # Copyright (C) Martin Schlemmer <azarah@nosferatu.za.org>
-# Released under the terms of the GNU GPL
-#
-# Generate a newline separated list of entries from the file/directory
-# supplied as an argument.
-#
-# If a file/directory is not supplied then generate a small dummy file.
+# Copyright (c) 2006           Sam Ravnborg <sam@ravnborg.org>
 #
-# The output is suitable for gen_init_cpio built from usr/gen_init_cpio.c.
+# Released under the terms of the GNU GPL
 #
+# Generate a cpio packed initramfs. It uses gen_init_cpio to generate
+# the cpio archive, and gzip to pack it.
+# The script may also be used to generate the inputfile used for gen_init_cpio
+# This script assumes that gen_init_cpio is located in usr/ directory
+
+# error out on errors
+set -e
+
+usage() {
+cat << EOF
+Usage:
+$0 [-o <file>] [-u <uid>] [-g <gid>] {-d | <cpio_source>} ...
+	-o <file>      Create gzipped initramfs file named <file> using
+	               gen_init_cpio and gzip
+	-u <uid>       User ID to map to user ID 0 (root).
+	               <uid> is only meaningful if <cpio_source>
+	               is a directory.
+	-g <gid>       Group ID to map to group ID 0 (root).
+	               <gid> is only meaningful if <cpio_source>
+	               is a directory.
+	<cpio_source>  File list or directory for cpio archive.
+	               If <cpio_source> is a .cpio file it will be used
+		       as direct input to initramfs.
+	-d             Output the default cpio list.
+
+All options except -o and -l may be repeated and are interpreted
+sequentially and immediately.  -u and -g states are preserved across
+<cpio_source> options so an explicit "-u 0 -g 0" is required
+to reset the root/group mapping.
+EOF
+}
 
+list_default_initramfs() {
+	# echo usr/kinit/kinit
+	:
+}
+
 default_initramfs() {
-	cat <<-EOF
+	cat <<-EOF >> ${output}
 		# This is a very simple, default initramfs
 
 		dir /dev 0755 0 0
 		nod /dev/console 0600 0 0 c 5 1
 		dir /root 0700 0 0
+		# file /kinit usr/kinit/kinit 0755 0 0
+		# slink /init kinit 0755 0 0
 	EOF
 }
 
@@ -40,20 +73,30 @@ filetype() {
 		echo "invalid"
 	fi
 	return 0
+}
+
+list_print_mtime() {
+	:
 }
 
 print_mtime() {
-	local argv1="$1"
 	local my_mtime="0"
 
-	if [ -e "${argv1}" ]; then
-		my_mtime=$(find "${argv1}" -printf "%T@\n" | sort -r | head -n 1)
+	if [ -e "$1" ]; then
+		my_mtime=$(find "$1" -printf "%T@\n" | sort -r | head -n 1)
 	fi
-	
-	echo "# Last modified: ${my_mtime}"
-	echo
+
+	echo "# Last modified: ${my_mtime}" >> ${output}
+	echo "" >> ${output}
+}
+
+list_parse() {
+	echo "$1 \\"
 }
 
+# for each file print a line in following format
+# <filetype> <name> <path to file> <octal mode> <uid> <gid>
+# for links, devices etc the format differs. See gen_init_cpio for details
 parse() {
 	local location="$1"
 	local name="${location/${srcdir}//}"
@@ -99,80 +142,112 @@ parse() {
 			;;
 	esac
 
-	echo "${str}"
+	echo "${str}" >> ${output}
 
 	return 0
 }
 
-usage() {
-	printf    "Usage:\n"
-	printf    "$0 [ [-u <root_uid>] [-g <root_gid>] [-d | <cpio_source>] ] . . .\n"
-	printf    "\n"
-	printf -- "-u <root_uid>  User ID to map to user ID 0 (root).\n"
-	printf    "               <root_uid> is only meaningful if <cpio_source>\n"
-	printf    "               is a directory.\n"
-	printf -- "-g <root_gid>  Group ID to map to group ID 0 (root).\n"
-	printf    "               <root_gid> is only meaningful if <cpio_source>\n"
-	printf    "               is a directory.\n"
-	printf    "<cpio_source>  File list or directory for cpio archive.\n"
-	printf    "               If <cpio_source> is not provided then a\n"
-	printf    "               a default list will be output.\n"
-	printf -- "-d             Output the default cpio list.  If no <cpio_source>\n"
-	printf    "               is given then the default cpio list will be output.\n"
-	printf    "\n"
-	printf    "All options may be repeated and are interpreted sequentially\n"
-	printf    "and immediately.  -u and -g states are preserved across\n"
-	printf    "<cpio_source> options so an explicit \"-u 0 -g 0\" is required\n"
-	printf    "to reset the root/group mapping.\n"
+unknown_option() {
+	printf "ERROR: unknown option \"$arg\"\n" >&2
+	printf "If the filename validly begins with '-', " >&2
+	printf "then it must be prefixed\n" >&2
+	printf "by './' so that it won't be interpreted as an option." >&2
+	printf "\n" >&2
+	usage >&2
+	exit 1
+}
+
+list_header() {
+	echo "deps_initramfs := \\"
+}
+
+header() {
+	printf "\n#####################\n# $1\n" >> ${output}
+}
+
+# process one directory (incl sub-directories)
+dir_filelist() {
+	${dep_list}header "$1"
+
+	srcdir=$(echo "$1" | sed -e 's://*:/:g')
+	dirlist=$(find "${srcdir}" -printf "%p %m %U %G\n" 2>/dev/null)
+
+	# If $dirlist is only one line, then the directory is empty
+	if [  "$(echo "${dirlist}" | wc -l)" -gt 1 ]; then
+		${dep_list}print_mtime "$1"
+
+		echo "${dirlist}" | \
+		while read x; do
+			${dep_list}parse ${x}
+		done
+	fi
 }
 
-build_list() {
-	printf "\n#####################\n# $cpio_source\n"
-
-	if [ -f "$cpio_source" ]; then
-		print_mtime "$cpio_source"
-		cat "$cpio_source"
-	elif [ -d "$cpio_source" ]; then
-		srcdir=$(echo "$cpio_source" | sed -e 's://*:/:g')
-		dirlist=$(find "${srcdir}" -printf "%p %m %U %G\n" 2>/dev/null)
-
-		# If $dirlist is only one line, then the directory is empty
-		if [  "$(echo "${dirlist}" | wc -l)" -gt 1 ]; then
-			print_mtime "$cpio_source"
-		
-			echo "${dirlist}" | \
-			while read x; do
-				parse ${x}
-			done
+# if only one file is specified and it is .cpio file then use it direct as fs
+# if a directory is specified then add all files in given direcotry to fs
+# if a regular file is specified assume it is in gen_initramfs format
+input_file() {
+	source="$1"
+	if [ -f "$1" ]; then
+		${dep_list}header "$1"
+		is_cpio="$(echo "$1" | sed 's/^.*\.cpio/cpio/')"
+		if [ $2 -eq 0 -a ${is_cpio} == "cpio" ]; then
+			cpio_file=$1
+			[ ! -z ${dep_list} ] && echo "$1"
+			return 0
+		fi
+		if [ -z ${dep_list} ]; then
+			print_mtime "$1" >> ${output}
+			cat "$1"         >> ${output}
 		else
-			# Failsafe in case directory is empty
-			default_initramfs
+			grep ^file "$1" | cut -d ' ' -f 3
 		fi
+	elif [ -d "$1" ]; then
+		dir_filelist "$1"
 	else
-		echo "  $0: Cannot open '$cpio_source'" >&2
+		echo "  ${prog}: Cannot open '$1'" >&2
 		exit 1
 	fi
 }
 
-
+prog=$0
 root_uid=0
 root_gid=0
+dep_list=
+cpio_file=
+cpio_list=
+output="/dev/stdout"
+output_file=""
 
+arg="$1"
+case "$arg" in
+	"-l")	# files included in initramfs - used by kbuild
+		dep_list="list_"
+		shift
+		;;
+	"-o")	# generate gzipped cpio image named $1
+		shift
+		output_file="$1"
+		cpio_list="$(mktemp ${TMPDIR:-/tmp}/cpiolist.XXXXXX)"
+		output=${cpio_list}
+		shift
+		;;
+esac
 while [ $# -gt 0 ]; do
 	arg="$1"
 	shift
 	case "$arg" in
-		"-u")
+		"-u")	# map $1 to uid=0 (root)
 			root_uid="$1"
 			shift
 			;;
-		"-g")
+		"-g")	# map $1 to gid=0 (root)
 			root_gid="$1"
 			shift
 			;;
-		"-d")
+		"-d")	# display default initramfs list
 			default_list="$arg"
-			default_initramfs
+			${dep_list}default_initramfs
 			;;
 		"-h")
 			usage
@@ -181,23 +256,27 @@ while [ $# -gt 0 ]; do
 		*)
 			case "$arg" in
 				"-"*)
-					printf "ERROR: unknown option \"$arg\"\n" >&2
-					printf "If the filename validly begins with '-', then it must be prefixed\n" >&2
-					printf "by './' so that it won't be interpreted as an option." >&2
-					printf "\n" >&2
-					usage >&2
-					exit 1
+					unknown_option
 					;;
-				*)
-					cpio_source="$arg"
-					build_list
+				*)	# input file/dir - process it
+					input_file "$arg" "$#"
 					;;
 			esac
 			;;
 	esac
 done
-
-# spit out the default cpio list if a source hasn't been specified
-[ -z "$cpio_source" -a -z "$default_list" ] && default_initramfs
 
+# If output_file is set we will generate cpio archive and gzip it
+# we are carefull to delete tmp files
+if [ ! -z ${output_file} ]; then
+	if [ -z ${cpio_file} ]; then
+		cpio_tfile="$(mktemp ${TMPDIR:-/tmp}/cpiofile.XXXXXX)"
+		usr/gen_init_cpio ${cpio_list} > ${cpio_tfile}
+	else
+		cpio_tfile=${cpio_file}
+	fi
+	rm ${cpio_list}
+	cat ${cpio_tfile} | gzip -f -9 - > ${output_file}
+	[ -z ${cpio_file} ] && rm ${cpio_tfile}
+fi
 exit 0
diff --git a/usr/Makefile b/usr/Makefile
index e2129cb..19d74e6 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -1,65 +1,48 @@
+#
+# kbuild file for usr/ - including initramfs image
+#
 
-obj-y := initramfs_data.o
-
-hostprogs-y  := gen_init_cpio
+klibcdirs:;
 
-clean-files := initramfs_data.cpio.gz initramfs_list
+# Generate builtin.o based on initramfs_data.o
+obj-y := initramfs_data.o
 
 # initramfs_data.o contains the initramfs_data.cpio.gz image.
 # The image is included using .incbin, a dependency which is not
 # tracked automatically.
 $(obj)/initramfs_data.o: $(obj)/initramfs_data.cpio.gz FORCE
-
-ifdef CONFIG_INITRAMFS_ROOT_UID
-gen_initramfs_args += -u $(CONFIG_INITRAMFS_ROOT_UID)
-endif
-
-ifdef CONFIG_INITRAMFS_ROOT_GID
-gen_initramfs_args += -g $(CONFIG_INITRAMFS_ROOT_GID)
-endif
-
-# The $(shell echo $(CONFIG_INITRAMFS_SOURCE)) is to remove the
-# gratuitous begin and end quotes from the Kconfig string type.
-# Internal, escaped quotes in the Kconfig string will loose the
-# escape and become active quotes.
-quotefixed_initramfs_source := $(shell echo $(CONFIG_INITRAMFS_SOURCE))
-
-filechk_initramfs_list = $(CONFIG_SHELL) \
- $(srctree)/scripts/gen_initramfs_list.sh $(gen_initramfs_args) $(quotefixed_initramfs_source)
-
-$(obj)/initramfs_list: $(obj)/Makefile FORCE
-	$(call filechk,initramfs_list)
 
-quiet_cmd_cpio = CPIO    $@
-      cmd_cpio = ./$< $(obj)/initramfs_list > $@
-
-
-# Check if the INITRAMFS_SOURCE is a cpio archive
-ifneq (,$(findstring .cpio,$(quotefixed_initramfs_source)))
-
-# INITRAMFS_SOURCE has a cpio archive - verify that it's a single file
-ifneq (1,$(words $(quotefixed_initramfs_source)))
-$(error Only a single file may be specified in CONFIG_INITRAMFS_SOURCE (="$(quotefixed_initramfs_source)") when a cpio archive is directly specified.)
-endif
-# Now use the cpio archive directly
-initramfs_data_cpio = $(quotefixed_initramfs_source)
-targets += $(quotefixed_initramfs_source)
-
-else
-
-# INITRAMFS_SOURCE is not a cpio archive - create one
-$(obj)/initramfs_data.cpio: $(obj)/gen_init_cpio \
-                            $(initramfs-y) $(obj)/initramfs_list FORCE
-	$(call if_changed,cpio)
-
-targets += initramfs_data.cpio
-initramfs_data_cpio = $(obj)/initramfs_data.cpio
-
+#####
+# Generate the initramfs cpio archive
+
+hostprogs-y := gen_init_cpio
+initramfs   := $(CONFIG_SHELL) $(srctree)/scripts/gen_initramfs_list.sh
+ramfs-input := $(if $(filter-out "",$(CONFIG_INITRAMFS_SOURCE)), \
+                    $(CONFIG_INITRAMFS_SOURCE),-d)
+ramfs-args  := \
+        $(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID)) \
+        $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID)) \
+        $(ramfs-input)
+
+# .initramfs_data.cpio.gz.d is used to identify all files included
+# in initramfs and to detect if any files are added/removed.
+# Removed files are identified by directory timestamp being updated
+# The dependency list is generated by gen_initramfs.sh -l
+ifneq ($(wildcard $(obj)/.initramfs_data.cpio.gz.d),)
+	include $(obj)/.initramfs_data.cpio.gz.d
 endif
-
-
-$(obj)/initramfs_data.cpio.gz: $(initramfs_data_cpio) FORCE
-	$(call if_changed,gzip)
 
-targets += initramfs_data.cpio.gz
+quiet_cmd_initfs = GEN     $@
+      cmd_initfs = $(initramfs) -o $@ $(ramfs-args) $(ramfs-input)
+
+targets := initramfs_data.cpio.gz
+$(deps_initramfs): klibcdirs
+# We rebuild initramfs_data.cpio.gz if:
+# 1) Any included file is newer then initramfs_data.cpio.gz
+# 2) There are changes in which files are included (added or deleted)
+# 3) If gen_init_cpio are newer than initramfs_data.cpio.gz
+# 4) arguments to gen_initramfs.sh changes
+$(obj)/initramfs_data.cpio.gz: $(obj)/gen_init_cpio $(deps_initramfs) klibcdirs
+	$(Q)$(initramfs) -l $(ramfs-input) > $(obj)/.initramfs_data.cpio.gz.d
+	$(call if_changed,initfs)
 
