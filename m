Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965209AbWGKEyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbWGKEyB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbWGKEyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:54:01 -0400
Received: from waha.wetafx.co.nz ([210.55.0.200]:23216 "EHLO waha.wetafx.co.nz")
	by vger.kernel.org with ESMTP id S965209AbWGKEyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:54:00 -0400
Message-ID: <44B32888.6050406@wetafx.co.nz>
Date: Tue, 11 Jul 2006 16:26:48 +1200
From: Bill Ryder <bryder@wetafx.co.nz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 Thunderbird/1.5.0.4 Mnenhy/0.7.4.0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18-rc1]  Make group sorting optional in the 2.6.x kernels
Content-Type: multipart/mixed;
 boundary="------------060909080303020303050002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060909080303020303050002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello all,

I've read all the stuff on submitting patches and this seems to be the
place.

Please CC me on any replies to this (although I do watch this through
list with  gmane)

Here's the patch description. I've attached the patch. Hopefully I've
followed the rules in Documentation/Submit* - apart from CC'ing Linus).

Summary:

Patch to allow the option of not sorting a process's supplemental
(also known ask secondary aka supplementary) group list. 

Setting the kernel config option of UNSORTED_SUPPLEMENTAL_GROUPLIST
will allow the use of setgroups(2) to reorder a supplemental
group list to work around the NFS AUTH_UNIX 16 group limit. 

In fact I  think this should be the default option because anyone using
setgroups
may get an unpleasant surprise with 2.6.x. But for now this patch makes
it an option.

Longer version:

Like many places Weta Digital (we did the VFX for Lord of the Rings,
King Kong etc)
uses supplemental group lists to allow users access to multiple
directories and files (films mostly in our
case) . Unfortunately NFSv2 and NFSv3 AUTH_UNIX flavour authentication
is hardcoded to only support 16 supplemental groups. Since we currently
have some users and processes which need to be in more than 16 groups
we use setgroups to build a list of groups that a process requires when
they access data on nfs exported filesystems.

This worked fine for the 2.4.x kernels. 2.6.x is designed to handle
thousands of groups for a single user. To support that the kernel was
changed to sort the group list, then use a binary search to decide if
a user was in the correct group. Unfortunately this BREAKS the use of
setgroups(2) to put the 16 most important groups first. 

This patch provides the option of not sorting that list. The help
describes the pitfalls of not sorting the groups (performance when
there are a lot of groups).

----
Bill Ryder
System Engineer
Weta Digital




--------------060909080303020303050002
Content-Type: text/x-patch;
 name="linux-2.6.18-rc1.unsorted_groups.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.18-rc1.unsorted_groups.patch"

diff -uprN -X linux-2.6.18-rc1.orig/Documentation/dontdiff linux-2.6.18-rc1.orig/arch/i386/Kconfig linux-2.6.18-rc1.unsorted_groups/arch/i386/Kconfig
--- linux-2.6.18-rc1.orig/arch/i386/Kconfig	2006-07-07 13:12:20.000000000 +1200
+++ linux-2.6.18-rc1.unsorted_groups/arch/i386/Kconfig	2006-07-07 11:46:34.000000000 +1200
@@ -258,6 +258,7 @@ config SCHED_MC
 	  increased overhead in some places. If unsure say N here.
 
 source "kernel/Kconfig.preempt"
+source "kernel/Kconfig.unsortedgroups"
 
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors"
diff -uprN -X linux-2.6.18-rc1.orig/Documentation/dontdiff linux-2.6.18-rc1.orig/arch/mips/Kconfig linux-2.6.18-rc1.unsorted_groups/arch/mips/Kconfig
--- linux-2.6.18-rc1.orig/arch/mips/Kconfig	2006-07-07 13:12:22.000000000 +1200
+++ linux-2.6.18-rc1.unsorted_groups/arch/mips/Kconfig	2006-07-07 11:46:34.000000000 +1200
@@ -1820,6 +1820,7 @@ config HZ
 	default 1024 if HZ_1024
 
 source "kernel/Kconfig.preempt"
+source "kernel/Kconfig.unsortedgroups"
 
 config RTC_DS1742
 	bool "DS1742 BRAM/RTC support"
diff -uprN -X linux-2.6.18-rc1.orig/Documentation/dontdiff linux-2.6.18-rc1.orig/arch/parisc/Kconfig linux-2.6.18-rc1.unsorted_groups/arch/parisc/Kconfig
--- linux-2.6.18-rc1.orig/arch/parisc/Kconfig	2006-07-07 13:12:23.000000000 +1200
+++ linux-2.6.18-rc1.unsorted_groups/arch/parisc/Kconfig	2006-07-07 11:46:34.000000000 +1200
@@ -220,6 +220,7 @@ config NODES_SHIFT
 source "kernel/Kconfig.preempt"
 source "kernel/Kconfig.hz"
 source "mm/Kconfig"
+source "kernel/Kconfig.unsortedgroups"
 
 config COMPAT
 	def_bool y
diff -uprN -X linux-2.6.18-rc1.orig/Documentation/dontdiff linux-2.6.18-rc1.orig/arch/powerpc/Kconfig linux-2.6.18-rc1.unsorted_groups/arch/powerpc/Kconfig
--- linux-2.6.18-rc1.orig/arch/powerpc/Kconfig	2006-07-07 13:12:23.000000000 +1200
+++ linux-2.6.18-rc1.unsorted_groups/arch/powerpc/Kconfig	2006-07-07 11:46:34.000000000 +1200
@@ -593,6 +593,7 @@ config HIGHMEM
 source kernel/Kconfig.hz
 source kernel/Kconfig.preempt
 source "fs/Kconfig.binfmt"
+source "kernel/Kconfig.unsortedgroups"
 
 # We optimistically allocate largepages from the VM, so make the limit
 # large enough (16MB). This badly named config option is actually
diff -uprN -X linux-2.6.18-rc1.orig/Documentation/dontdiff linux-2.6.18-rc1.orig/arch/x86_64/Kconfig linux-2.6.18-rc1.unsorted_groups/arch/x86_64/Kconfig
--- linux-2.6.18-rc1.orig/arch/x86_64/Kconfig	2006-07-07 13:12:26.000000000 +1200
+++ linux-2.6.18-rc1.unsorted_groups/arch/x86_64/Kconfig	2006-07-07 11:46:34.000000000 +1200
@@ -273,6 +273,8 @@ config SCHED_MC
 	  increased overhead in some places. If unsure say N here.
 
 source "kernel/Kconfig.preempt"
+source "kernel/Kconfig.unsortedgroups"
+
 
 config NUMA
        bool "Non Uniform Memory Access (NUMA) Support"
diff -uprN -X linux-2.6.18-rc1.orig/Documentation/dontdiff linux-2.6.18-rc1.orig/kernel/Kconfig.unsortedgroups linux-2.6.18-rc1.unsorted_groups/kernel/Kconfig.unsortedgroups
--- linux-2.6.18-rc1.orig/kernel/Kconfig.unsortedgroups	1970-01-01 12:00:00.000000000 +1200
+++ linux-2.6.18-rc1.unsorted_groups/kernel/Kconfig.unsortedgroups	2006-07-07 11:46:34.000000000 +1200
@@ -0,0 +1,16 @@
+#
+# Groups order
+#
+config USE_UNSORTED_SUPPLEMENTAL_GROUPS
+	bool "Use unsorted supplemental groups"
+	help
+
+	 If you need to use setgroups(2) to order a process's supplemental group list so that you can 
+         choose which 16 groups are sent during a NFSv2 or NFSv3 AUTH_UNIX (the default authentication protocol)
+         transaction you need to say Y here.
+
+         If you do not have users with more than 16 groups who need to access NFS you don't need this.
+
+         Do not set this option if you are going to have users in thousands of secondary groups. The default 
+	 kernel implementation sorts the groups and then binary searches them for membership. This option forces 
+  	 the search to be linear.
diff -uprN -X linux-2.6.18-rc1.orig/Documentation/dontdiff linux-2.6.18-rc1.orig/kernel/sys.c linux-2.6.18-rc1.unsorted_groups/kernel/sys.c
--- linux-2.6.18-rc1.orig/kernel/sys.c	2006-07-07 13:12:44.000000000 +1200
+++ linux-2.6.18-rc1.unsorted_groups/kernel/sys.c	2006-07-11 14:45:08.007916000 +1200
@@ -1535,14 +1535,22 @@ static void groups_sort(struct group_inf
 	}
 }
 
-/* a simple bsearch */
+/* if USE_UNSORTED_SUPPLEMENTAL_GROUPS is set this is a linear search. If not it's a binary search */
 int groups_search(struct group_info *group_info, gid_t grp)
 {
-	unsigned int left, right;
 
 	if (!group_info)
 		return 0;
 
+#ifdef USE_UNSORTED_SUPPLEMENTAL_GROUPS
+	unsigned int i;
+
+	for (i=0; i < group_info->ngroups; i++)
+		if (GROUP_AT(group_info,i) == grp)
+			return 1;
+#else
+	unsigned int left, right;
+
 	left = 0;
 	right = group_info->ngroups;
 	while (left < right) {
@@ -1555,6 +1563,7 @@ int groups_search(struct group_info *gro
 		else
 			return 1;
 	}
+#endif
 	return 0;
 }
 
@@ -1568,7 +1577,10 @@ int set_current_groups(struct group_info
 	if (retval)
 		return retval;
 
+#ifndef USE_UNSORTED_SUPPLEMENTAL_GROUPS
 	groups_sort(group_info);
+#endif
+
 	get_group_info(group_info);
 
 	task_lock(current);

--------------060909080303020303050002--
