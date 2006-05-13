Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWEMDtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWEMDtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 23:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWEMDtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 23:49:03 -0400
Received: from c-67-177-57-20.hsd1.co.comcast.net ([67.177.57.20]:54004 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S932331AbWEMDtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 23:49:00 -0400
Date: Fri, 12 May 2006 21:49:02 -0600
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       James Morris <jmorris@namei.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
Subject: [PATCH 13/13: eCryptfs] Debug functions
Message-ID: <20060513034902.GM18631@hellewell.homeip.net>
References: <20060513033742.GA18598@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060513033742.GA18598@hellewell.homeip.net>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 13th patch in a series of 13 constituting the kernel
components of the eCryptfs cryptographic filesystem.

Functions used only for debugging purposes; typically called when the
verbosity is turned higher than 0.

Signed-off-by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 debug.c |  130 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 130 insertions(+)

Index: linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/debug.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/debug.c	2006-05-12 20:00:26.000000000 -0600
@@ -0,0 +1,130 @@
+/**
+ * eCryptfs: Linux filesystem encryption layer
+ * Functions only useful for debugging.
+ *
+ * Copyright (C) 2006 International Business Machines Corp.
+ *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
+#include "ecryptfs_kernel.h"
+
+/**
+ * ecryptfs_dump_auth_tok - debug function to print auth toks
+ * 
+ * This function will print the contents of an ecryptfs authentication
+ * token.
+ */
+void ecryptfs_dump_auth_tok(struct ecryptfs_auth_tok *auth_tok)
+{
+	char salt[ECRYPTFS_SALT_SIZE * 2 + 1];
+	char sig[ECRYPTFS_SIG_SIZE_HEX + 1];
+
+	ecryptfs_printk(KERN_DEBUG, "Auth tok at mem loc [%p]:\n",
+			auth_tok);
+	if (ECRYPTFS_CHECK_FLAG(auth_tok->flags, ECRYPTFS_PRIVATE_KEY)) {
+		ecryptfs_printk(KERN_DEBUG, " * private key type\n");
+		ecryptfs_printk(KERN_DEBUG, " * (NO PRIVATE KEY SUPPORT "
+				"IN ECRYPTFS VERSION 0.1)\n");
+	} else {
+		ecryptfs_printk(KERN_DEBUG, " * passphrase type\n");
+		ecryptfs_to_hex(salt, auth_tok->token.password.salt,
+				ECRYPTFS_SALT_SIZE);
+		salt[ECRYPTFS_SALT_SIZE * 2] = '\0';
+		ecryptfs_printk(KERN_DEBUG, " * salt = [%s]\n", salt);
+		if (ECRYPTFS_CHECK_FLAG(auth_tok->token.password.flags,
+					ECRYPTFS_PERSISTENT_PASSWORD)) {
+			ecryptfs_printk(KERN_DEBUG, " * persistent\n");
+		}
+		memcpy(sig, auth_tok->token.password.signature,
+		       ECRYPTFS_SIG_SIZE_HEX);
+		sig[ECRYPTFS_SIG_SIZE_HEX] = '\0';
+		ecryptfs_printk(KERN_DEBUG, " * signature = [%s]\n", sig);
+	}
+	if (ECRYPTFS_CHECK_FLAG(auth_tok->flags, ECRYPTFS_CONTAINS_SECRET)) {
+		ecryptfs_printk(KERN_DEBUG, " * contains secret value\n");
+	} else {
+		ecryptfs_printk(KERN_DEBUG, " * lacks secret value\n");
+	}
+	if (ECRYPTFS_CHECK_FLAG(auth_tok->flags, ECRYPTFS_EXPIRED))
+		ecryptfs_printk(KERN_DEBUG, " * expired\n");
+	ecryptfs_printk(KERN_DEBUG, " * session_key.flags = [0x%x]\n",
+			auth_tok->session_key.flags);
+	if (auth_tok->session_key.flags
+	    & ECRYPTFS_USERSPACE_SHOULD_TRY_TO_DECRYPT)
+		ecryptfs_printk(KERN_DEBUG,
+				" * Userspace decrypt request set\n");
+	if (auth_tok->session_key.flags
+	    & ECRYPTFS_USERSPACE_SHOULD_TRY_TO_ENCRYPT)
+		ecryptfs_printk(KERN_DEBUG,
+				" * Userspace encrypt request set\n");
+	if (auth_tok->session_key.flags & ECRYPTFS_CONTAINS_DECRYPTED_KEY) {
+		ecryptfs_printk(KERN_DEBUG, " * Contains decrypted key\n");
+		ecryptfs_printk(KERN_DEBUG,
+				" * session_key.decrypted_key_size = [0x%x]\n",
+				auth_tok->session_key.decrypted_key_size);
+		ecryptfs_printk(KERN_DEBUG, " * Decrypted session key "
+				"dump:\n");
+		if (ecryptfs_verbosity > 0)
+			ecryptfs_dump_hex(auth_tok->session_key.decrypted_key,
+					  ECRYPTFS_DEFAULT_KEY_BYTES);
+	}
+	if (auth_tok->session_key.flags & ECRYPTFS_CONTAINS_ENCRYPTED_KEY) {
+		ecryptfs_printk(KERN_DEBUG, " * Contains encrypted key\n");
+		ecryptfs_printk(KERN_DEBUG,
+				" * session_key.encrypted_key_size = [0x%x]\n",
+				auth_tok->session_key.encrypted_key_size);
+		ecryptfs_printk(KERN_DEBUG, " * Encrypted session key "
+				"dump:\n");
+		if (ecryptfs_verbosity > 0)
+			ecryptfs_dump_hex(auth_tok->session_key.encrypted_key,
+					  auth_tok->session_key.
+					  encrypted_key_size);
+	}
+}
+
+/**
+ * ecryptfs_dump_hex - debug hex printer
+ * @data: string of bytes to be printed
+ * @bytes: number of bytes to print
+ * 
+ * Dump hexadecimal representation of char array
+ */
+void ecryptfs_dump_hex(char *data, int bytes)
+{
+	int i = 0;
+	int add_newline = 1;
+
+	if (ecryptfs_verbosity < 1)
+		return;
+	if (bytes != 0) {
+		printk(KERN_DEBUG "0x%.2x.", (unsigned char)data[i]);
+		i++;
+	}
+	while (i < bytes) {
+		printk("0x%.2x.", (unsigned char)data[i]);
+		i++;
+		if (i % 16 == 0) {
+			printk("\n");
+			add_newline = 0;
+		} else
+			add_newline = 1;
+	}
+	if (add_newline)
+		printk("\n");
+}
+
