Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751894AbWITQus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbWITQus (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbWITQtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:49:39 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:63692 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751925AbWITQtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:49:10 -0400
Subject: [PATCH] slim: misc cleanups requested at inclusion time.
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <20060914165205.c56365e7.akpm@osdl.org>
References: <1158083865.18137.13.camel@localhost.localdomain>
	 <20060914165205.c56365e7.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 09:49:00 -0700
Message-Id: <1158770940.16727.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miscellaneous fixes requested when the intial patches were pulled in
last week.  This patch addresses the following comments.


On Thu, 2006-09-14 at 16:52 -0700, Andrew Morton wrote: 
> trivial things:
> > +char *slm_iac_str[] = {
> > +	ZERO_STR,
> > +	UNTRUSTED_STR,
> > +	USER_STR,
> > +	SYSTEM_STR
> > +};
> 
> Could this be made static?
> 
No because it is used in slm_secfs.c.

> > +		case '#':
> > +			while ((*bufp != '\n') && (bufp++ < buf_end)) ;
> 
> newline needed here.
Added in the patch.

> > +static int has_file_wperm(struct slm_file_xattr *cur_level)
> > +{
> > +	int i, j = 0;
> > +	struct files_struct *files = current->files;
> > +	unsigned long fd = 0;
> > +	struct fdtable *fdt;
> > +	struct file *file;
> > +	int rc = 0;
> > +
> > +	if (is_kernel_thread(current))
> > +		return 0;
> > +
> > +	if (!files || !cur_level)
> > +		return 0;
> > +
> > +	spin_lock(&files->file_lock);
> > +	fdt = files_fdtable(files);
> > +
> > +	for (;;) {
> > +		i = j * __NFDBITS;
> > +		if (i >= fdt->max_fdset || i >= fdt->max_fds)
> > +			break;
> > +		fd = fdt->open_fds->fds_bits[j++];
> > +		while (fd) {
> > +			if (fd & 1) {
> > +				file = fdt->fd[i++];
> > +				if (file)
> > +					rc = mark_has_file_wperm(file,
> > +						cur_level);
> > +			}
> > +			fd >>= 1;
> > +		}
> > +	}
> > +	spin_unlock(&files->file_lock);
> > +	return rc;
> > +}
> 
> Could we use a more meaningful identifier than `j' here?  Perhaps `i' too?
This function has been cleaned up with the use of find_next_bit and i
and j are no longer used in the patch below.

> > +	for (iac = 0; iac < sizeof(slm_iac_str) / sizeof(char *); iac++) {
> 
> ARRAY_SIZE()
Fixed below.


> > +		if (strncmp(token, slm_iac_str[iac], strlen(slm_iac_str[iac]))
> > +		    == 0)
> > +			return iac;
> > +	}
> > +	return SLM_IAC_ERROR;
> > +}
> > +
> >
> > ...
> >
> > +
> > +static inline int slm_getprocattr(struct task_struct *tsk,
> > +				  char *name, void *value, size_t size)
> It's rather pointless to declare a function inline and to then only refer to
> it via a pointer-to-function.  Please review all inlinings.
All inlines have been reviewed and fixed if necessary in the patch
below.  3 hooks were affected.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
---
security/slim/slm_main.c |   29 ++++++++++-------------------
1 files changed, 10 insertions(+), 19 deletions(-) 
--- linux-2.6.18-rc6-orig/security/slim/slm_main.c	2006-09-18 16:41:51.000000000 -0500
+++ linux-2.6.18-rc6/security/slim/slm_main.c	2006-09-19 16:45:34.000000000 -0500
@@ -61,6 +60,7 @@ static char *get_token(char *buf_start, 
 			break;
 		case '#':
 			while ((*bufp != '\n') && (bufp++ < buf_end)) ;
+
 			bufp++;
 			break;
 		default:
@@ -141,7 +141,6 @@ static inline int mark_has_file_wperm(st
  */
 static int has_file_wperm(struct slm_file_xattr *cur_level)
 {
-	int i, j = 0;
 	struct files_struct *files = current->files;
 	unsigned long fd = 0;
 	struct fdtable *fdt;
@@ -157,21 +156,12 @@ static int has_file_wperm(struct slm_fil
 	spin_lock(&files->file_lock);
 	fdt = files_fdtable(files);
 
-	for (;;) {
-		i = j * __NFDBITS;
-		if (i >= fdt->max_fdset || i >= fdt->max_fds)
-			break;
-		fd = fdt->open_fds->fds_bits[j++];
-		while (fd) {
-			if (fd & 1) {
-				file = fdt->fd[i++];
-				if (file)
-					rc = mark_has_file_wperm(file,
-						cur_level);
-			}
-			fd >>= 1;
-		}
+	while((fd=find_next_bit(fdt->open_fds->fds_bits, fdt->max_fdset, fd)) < fdt->max_fdset) {
+		file = fdt->fd[fd++];
+		if (file)
+			rc = mark_has_file_wperm(file, cur_level);
 	}
+
 	spin_unlock(&files->file_lock);
 	return rc;
 }
@@ -241,7 +231,7 @@ static enum slm_iac_level parse_iac(char
 
 	if (strncmp(token, EXEMPT_STR, strlen(EXEMPT_STR)) == 0)
 		return SLM_IAC_EXEMPT;
-	for (iac = 0; iac < sizeof(slm_iac_str) / sizeof(char *); iac++) {
+	for (iac = 0; iac < ARRAY_SIZE(slm_iac_str); iac++) {
 		if (strncmp(token, slm_iac_str[iac], strlen(slm_iac_str[iac]))
 		    == 0)
 			return iac;
@@ -1243,7 +1233,7 @@ static int slm_task_post_setuid(uid_t ol
 	return rc;
 }
 
-static inline int slm_setprocattr(struct task_struct *tsk,
+static int slm_setprocattr(struct task_struct *tsk,
 				  char *name, void *value, size_t size)
 {
 	dprintk(SLM_BASE, "%s: %s \n", __FUNCTION__, name);
@@ -1251,7 +1241,7 @@ static inline int slm_setprocattr(struct
 
 }
 
-static inline int slm_getprocattr(struct task_struct *tsk,
+static int slm_getprocattr(struct task_struct *tsk,
 				  char *name, void *value, size_t size)
 {
 	struct slm_tsec_data *tsec = tsk->security;
@@ -1473,7 +1463,7 @@ static int slm_inode_setattr(struct dent
 	return rc;
 }
 
-static inline int slm_capable(struct task_struct *tsk, int cap)
+static int slm_capable(struct task_struct *tsk, int cap)
 {
 	struct slm_tsec_data *tsec = tsk->security;
 	int rc = 0;


