Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVCHOnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVCHOnq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 09:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVCHOnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 09:43:46 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:10426 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261362AbVCHOnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 09:43:43 -0500
Subject: [PATCH][SELINUX] Fix selinux_setprocattr
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 08 Mar 2005 09:36:04 -0500
Message-Id: <1110292564.5428.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.11-mm2 changes the selinux_setprocattr hook function (which
handles writes to nodes in the /proc/pid/attr directory) to ignore an
optional terminating newline at the end of the value, and to handle a
value beginning with a newline or a null in the same manner as a zero
length value (clearing the attribute for the process and resetting it
to using the default policy behavior).  This change is to address the
divergence from POSIX in the existing API, as POSIX says that write(2)
with a zero count will return zero with no other effect, as well as to
simplify use of the API from scripts (although that isn't
recommended).  Please apply.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by:  James Morris <jmorris@redhat.com>

 security/selinux/hooks.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff -X /home/sds/dontdiff -ru linux-2.6.11-mm2/security/selinux/hooks.c linux-2.6.11-mm2-sel/security/selinux/hooks.c
--- linux-2.6.11-mm2/security/selinux/hooks.c	2005-03-08 08:43:52.867139656 -0500
+++ linux-2.6.11-mm2-sel/security/selinux/hooks.c	2005-03-08 08:44:02.733639720 -0500
@@ -4106,6 +4106,7 @@
 	struct task_security_struct *tsec;
 	u32 sid = 0;
 	int error;
+	char *str = value;
 
 	if (current != p) {
 		/* SELinux only allows a process to change its own
@@ -4130,8 +4131,11 @@
 		return error;
 
 	/* Obtain a SID for the context, if one was specified. */
-	if (size) {
-		int error;
+	if (size && str[1] && str[1] != '\n') {
+		if (str[size-1] == '\n') {
+			str[size-1] = 0;
+			size--;
+		}
 		error = security_context_to_sid(value, size, &sid);
 		if (error)
 			return error;

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

