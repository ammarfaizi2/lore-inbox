Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWDXKp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWDXKp5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 06:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWDXKp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 06:45:57 -0400
Received: from 81-178-102-145.dsl.pipex.com ([81.178.102.145]:20129 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750703AbWDXKp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 06:45:56 -0400
Date: Mon, 24 Apr 2006 11:45:53 +0100
To: linux-cifs-client@lists.samba.org, samba-technical@lists.samba.org
Cc: sfrench@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs experimental off leads to compile errors
Message-ID: <20060424104553.GA1010@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of 2.6.17-rc2-git5 it seems that CIFS has stopped working
if CIFS_EXPERIMENTAL isn't enabled .  The following sorts
out the errors, but I am not sure if the semantics of the
experimEnabled_write() are correct when CIFS_EXPERIMENTAL is
disabled.

-apw

=== 8< ===
cifs experimental off leads to compile errors

When compiling with CIFS enabled but with CIFS_EXPERIMENTAL disabled
you get link errors as below.

  fs/built-in.o(.text+0x11bf8c): In function `.cifs_setup_session':
  : undefined reference to `.CIFS_SessSetup'

It seems that we need to help the optimiser out more when disabling
this code.  This patch turns the experimEnabled variable into the
constant (0) when experimental support is not compiled in.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff -upN reference/fs/cifs/cifs_debug.c current/fs/cifs/cifs_debug.c
--- reference/fs/cifs/cifs_debug.c
+++ current/fs/cifs/cifs_debug.c
@@ -616,6 +616,7 @@ experimEnabled_write(struct file *file, 
 	rc = get_user(c, buffer);
 	if (rc)
 		return rc;
+#ifdef CONFIG_CIFS_EXPERIMENTAL
 	if (c == '0' || c == 'n' || c == 'N')
 		experimEnabled = 0;
 	else if (c == '1' || c == 'y' || c == 'Y')
@@ -624,6 +625,9 @@ experimEnabled_write(struct file *file, 
 		experimEnabled = 2;
 
 	return count;
+#else
+	return -ENOSYS;
+#endif
 }
 
 static int
diff -upN reference/fs/cifs/cifsfs.c current/fs/cifs/cifsfs.c
--- reference/fs/cifs/cifsfs.c
+++ current/fs/cifs/cifsfs.c
@@ -52,7 +52,9 @@ int cifsFYI = 0;
 int cifsERROR = 1;
 int traceSMB = 0;
 unsigned int oplockEnabled = 1;
+#ifdef CONFIG_CIFS_EXPERIMENTAL
 unsigned int experimEnabled = 0;
+#endif
 unsigned int linuxExtEnabled = 1;
 unsigned int lookupCacheEnabled = 1;
 unsigned int multiuser_mount = 0;
diff -upN reference/fs/cifs/cifsglob.h current/fs/cifs/cifsglob.h
--- reference/fs/cifs/cifsglob.h
+++ current/fs/cifs/cifsglob.h
@@ -536,7 +536,11 @@ GLOBAL_EXTERN unsigned int multiuser_mou
 				have the uid/password or Kerberos credential 
 				or equivalent for current user */
 GLOBAL_EXTERN unsigned int oplockEnabled;
+#ifdef CONFIG_CIFS_EXPERIMENTAL
 GLOBAL_EXTERN unsigned int experimEnabled;
+#else
+#define experimEnabled (0)
+#endif
 GLOBAL_EXTERN unsigned int lookupCacheEnabled;
 GLOBAL_EXTERN unsigned int extended_security;	/* if on, session setup sent 
 				with more secure ntlmssp2 challenge/resp */
