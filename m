Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292520AbSBTVbO>; Wed, 20 Feb 2002 16:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292519AbSBTVay>; Wed, 20 Feb 2002 16:30:54 -0500
Received: from smtp02.web.de ([217.72.192.151]:64797 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S292518AbSBTVak>;
	Wed, 20 Feb 2002 16:30:40 -0500
Date: Wed, 20 Feb 2002 22:41:54 +0100
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.4-dj3 fix some uses of strsep
Message-Id: <20020220224154.78e8780c.l.s.r@web.de>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

patch below fixes four cases where a s/strtok(/strsep(\&/ is not
sufficient to properly eliminate strtok. The problem arrises
because strsep modifies the pointer it is given while strtok did
not.

The atari file doesn't compile without this patch, because a char
array is mistreated as char pointer. The rest are cases where the
destroyed char pointer is used afterwards.

There may be more errors of that kind, I didn't check (yet). Patch
is untested but should make things "righter". ;)

René



diff -ur linux-2.5.4-dj3/arch/alpha/kernel/setup.c linux/arch/alpha/kernel/setup.c
--- linux-2.5.4-dj3/arch/alpha/kernel/setup.c	Wed Feb 20 20:01:21 2002
+++ linux/arch/alpha/kernel/setup.c	Wed Feb 20 22:08:43 2002
@@ -472,6 +472,7 @@
 	struct percpu_struct *cpu;
 	char *type_name, *var_name, *p;
 	void *kernel_end = _end; /* end of kernel */
+	char *args = command_line;
 
 	hwrpb = (struct hwrpb_struct*) __va(INIT_HWRPB->phys_addr);
 	boot_cpuid = hard_smp_processor_id();
@@ -509,7 +510,7 @@
 	/* 
 	 * Process command-line arguments.
 	 */
-	while ((p = strsep(&command_line, " \t")) != NULL) {
+	while ((p = strsep(&args, " \t")) != NULL) {
 		if (!*p) continue;
 		if (strncmp(p, "alpha_mv=", 9) == 0) {
 			vec = get_sysvec_byname(p+9);
diff -ur linux-2.5.4-dj3/arch/m68k/atari/config.c linux/arch/m68k/atari/config.c
--- linux-2.5.4-dj3/arch/m68k/atari/config.c	Wed Feb 20 20:01:24 2002
+++ linux/arch/m68k/atari/config.c	Wed Feb 20 22:06:51 2002
@@ -205,6 +205,7 @@
     char switches[len+1];
     char *p;
     int ovsc_shift;
+    char *args = switches;
 
     /* copy string to local array, strsep works destructively... */
     strncpy( switches, str, len );
@@ -212,7 +213,7 @@
     atari_switches = 0;
 
     /* parse the options */
-    while ((p = strsep(&switches, ",")) != NULL) {
+    while ((p = strsep(&args, ",")) != NULL) {
 	if (!*p) continue;
 	ovsc_shift = 0;
 	if (strncmp( p, "ov_", 3 ) == 0) {
diff -ur linux-2.5.4-dj3/fs/fat/inode.c linux/fs/fat/inode.c
--- linux-2.5.4-dj3/fs/fat/inode.c	Wed Feb 20 20:02:11 2002
+++ linux/fs/fat/inode.c	Wed Feb 20 22:02:34 2002
@@ -203,6 +203,7 @@
 	char *this_char,*value,save,*savep;
 	char *p;
 	int ret = 1, len;
+	char *args = options;
 
 	opts->name_check = 'n';
 	opts->conversion = 'b';
@@ -221,7 +222,7 @@
 		goto out;
 	save = 0;
 	savep = NULL;
-	while ((this_char = strsep(&options,",")) != NULL) {
+	while ((this_char = strsep(&args,",")) != NULL) {
 		if ((value = strchr(this_char,'=')) != NULL) {
 			save = *value;
 			savep = value;
diff -ur linux-2.5.4-dj3/fs/vfat/namei.c linux/fs/vfat/namei.c
--- linux-2.5.4-dj3/fs/vfat/namei.c	Wed Feb 20 20:02:15 2002
+++ linux/fs/vfat/namei.c	Wed Feb 20 22:01:28 2002
@@ -99,6 +99,7 @@
 {
 	char *this_char,*value,save,*savep;
 	int ret, val;
+	char *args = options;
 
 	opts->unicode_xlate = opts->posixfs = 0;
 	opts->numtail = 1;
@@ -115,7 +116,7 @@
 	save = 0;
 	savep = NULL;
 	ret = 1;
-	while ((this_char = strsep(&options,",")) != NULL) {
+	while ((this_char = strsep(&args,",")) != NULL) {
 		if ((value = strchr(this_char,'=')) != NULL) {
 			save = *value;
 			savep = value;
