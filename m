Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWI1Ta5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWI1Ta5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 15:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbWI1Ta5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 15:30:57 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:11190 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751982AbWI1Ta5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 15:30:57 -0400
Date: Thu, 28 Sep 2006 15:30:53 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Cory Olmo <colmo@TrustedCS.com>
Subject: [PATCH] SELinux - support mls categories for context mounts
Message-ID: <Pine.LNX.4.64.0609281529140.28065@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cory Olmo <colmo@TrustedCS.com>

This patch allows commas to be embedded into context mount options (i.e. 
"-o context=some_selinux_context_t"), to better support multiple 
categories, which are separated by commas and confuse mount.

For example, with the current code:

  mount -t iso9660 /dev/cdrom /media/cdrom -o \
  ro,context=system_u:object_r:iso9660_t:s0:c1,c3,c4,exec

The context option that will be interpreted by SELinux is
context=system_u:object_r:iso9660_t:s0:c1

instead of
context=system_u:object_r:iso9660_t:s0:c1,c3,c4

The options that will be passed on to the file system will be
ro,c3,c4,exec.

The proposed solution is to allow/require the SELinux context option 
specified to mount to use quotes when the context contains a comma.

This patch modifies the option parsing in parse_opts(), contained in 
mount.c, to take options after finding a comma only if it hasn't seen a 
quote or if the quotes are matched.  It also introduces a new function 
that will strip the quotes from the context option prior to translation.  
The quotes are replaced after the translation is completed to insure that 
in the event the raw context contains commas the kernel will be able to 
interpret the correct context.

Signed-off-by: Cory Olmo <colmo@TrustedCS.com>
Signed-off-by: James Morris <jmorris@namei.org>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Please apply.

---

 security/selinux/hooks.c |   32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff -purN -X dontdiff linux-2.6.18-mm1.o/security/selinux/hooks.c linux-2.6.18-mm1.w/security/selinux/hooks.c
--- linux-2.6.18-mm1.o/security/selinux/hooks.c	2006-09-26 22:55:11.000000000 -0400
+++ linux-2.6.18-mm1.w/security/selinux/hooks.c	2006-09-28 15:26:04.000000000 -0400
@@ -398,7 +398,7 @@ static int try_context_mount(struct supe
 		/* Standard string-based options. */
 		char *p, *options = data;
 
-		while ((p = strsep(&options, ",")) != NULL) {
+		while ((p = strsep(&options, "|")) != NULL) {
 			int token;
 			substring_t args[MAX_OPT_ARGS];
 
@@ -1930,11 +1930,34 @@ static inline void take_option(char **to
 	*to += len;
 }
 
+static inline void take_selinux_option(char **to, char *from, int *first, 
+		                       int len)
+{
+	int current_size = 0;
+
+	if (!*first) {
+		**to = '|';
+		*to += 1;
+	}
+	else
+		*first = 0;
+
+	while (current_size < len) {
+		if (*from != '"') {
+			**to = *from;
+			*to += 1;
+		}
+		from += 1;
+		current_size += 1;
+	}
+}
+
 static int selinux_sb_copy_data(struct file_system_type *type, void *orig, void *copy)
 {
 	int fnosec, fsec, rc = 0;
 	char *in_save, *in_curr, *in_end;
 	char *sec_curr, *nosec_save, *nosec;
+	int open_quote = 0;
 
 	in_curr = orig;
 	sec_curr = copy;
@@ -1956,11 +1979,14 @@ static int selinux_sb_copy_data(struct f
 	in_save = in_end = orig;
 
 	do {
-		if (*in_end == ',' || *in_end == '\0') {
+		if (*in_end == '"')
+			open_quote = !open_quote;
+		if ((*in_end == ',' && open_quote == 0) ||
+				*in_end == '\0') {
 			int len = in_end - in_curr;
 
 			if (selinux_option(in_curr, len))
-				take_option(&sec_curr, in_curr, &fsec, len);
+				take_selinux_option(&sec_curr, in_curr, &fsec, len);
 			else
 				take_option(&nosec, in_curr, &fnosec, len);
 
