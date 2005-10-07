Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbVJGOFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbVJGOFD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbVJGOFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:05:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20876 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932629AbVJGOFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:05:01 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Add request-key process documentation
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 07 Oct 2005 15:04:52 +0100
Message-ID: <11549.1128693892@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch adds documentation for the process by which request-key
works, including how it permits helper processes to gain access to the
requestor's keyrings.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-reqdoc-2614rc3.diff 
 Documentation/keys-request-key.txt |  161 +++++++++++++++++++++++++++++++++++++
 Documentation/keys.txt             |   18 ++--
 security/keys/request_key.c        |    2 
 security/keys/request_key_auth.c   |    2 
 4 files changed, 176 insertions(+), 7 deletions(-)

diff -uNrp linux-2.6.14-rc3-keys/Documentation/keys-request-key.txt linux-2.6.14-rc3-keys-split/Documentation/keys-request-key.txt
--- linux-2.6.14-rc3-keys/Documentation/keys-request-key.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-rc3-keys-split/Documentation/keys-request-key.txt	2005-10-07 14:56:02.000000000 +0100
@@ -0,0 +1,161 @@
+			      ===================
+			      KEY REQUEST SERVICE
+			      ===================
+
+The key request service is part of the key retention service (refer to
+Documentation/keys.txt). This document explains more fully how that the
+requesting algorithm works.
+
+The process starts by either the kernel requesting a service by calling
+request_key():
+
+	struct key *request_key(const struct key_type *type,
+				const char *description,
+				const char *callout_string);
+
+Or by userspace invoking the request_key system call:
+
+	key_serial_t request_key(const char *type,
+				 const char *description,
+				 const char *callout_info,
+				 key_serial_t dest_keyring);
+
+The main difference between the two access points is that the in-kernel
+interface does not need to link the key to a keyring to prevent it from being
+immediately destroyed. The kernel interface returns a pointer directly to the
+key, and it's up to the caller to destroy the key.
+
+The userspace interface links the key to a keyring associated with the process
+to prevent the key from going away, and returns the serial number of the key to
+the caller.
+
+
+===========
+THE PROCESS
+===========
+
+A request proceeds in the following manner:
+
+ (1) Process A calls request_key() [the userspace syscall calls the kernel
+     interface].
+
+ (2) request_key() searches the process's subscribed keyrings to see if there's
+     a suitable key there. If there is, it returns the key. If there isn't, and
+     callout_info is not set, an error is returned. Otherwise the process
+     proceeds to the next step.
+
+ (3) request_key() sees that A doesn't have the desired key yet, so it creates
+     two things:
+
+     (a) An uninstantiated key U of requested type and description.
+
+     (b) An authorisation key V that refers to key U and notes that process A
+     	 is the context in which key U should be instantiated and secured, and
+     	 from which associated key requests may be satisfied.
+
+ (4) request_key() then forks and executes /sbin/request-key with a new session
+     keyring that contains a link to auth key V.
+
+ (5) /sbin/request-key execs an appropriate program to perform the actual
+     instantiation.
+
+ (6) The program may want to access another key from A's context (say a
+     Kerberos TGT key). It just requests the appropriate key, and the keyring
+     search notes that the session keyring has auth key V in its bottom level.
+
+     This will permit it to then search the keyrings of process A with the
+     UID, GID, groups and security info of process A as if it was process A,
+     and come up with key W.
+
+ (7) The program then does what it must to get the data with which to
+     instantiate key U, using key W as a reference (perhaps it contacts a
+     Kerberos server using the TGT) and then instantiates key U.
+
+ (8) Upon instantiating key U, auth key V is automatically revoked so that it
+     may not be used again.
+
+ (9) The program then exits 0 and request_key() deletes key V and returns key
+     U to the caller.
+
+This also extends further. If key W (step 5 above) didn't exist, key W would be
+created uninstantiated, another auth key (X) would be created [as per step 3]
+and another copy of /sbin/request-key spawned [as per step 4]; but the context
+specified by auth key X will still be process A, as it was in auth key V.
+
+This is because process A's keyrings can't simply be attached to
+/sbin/request-key at the appropriate places because (a) execve will discard two
+of them, and (b) it requires the same UID/GID/Groups all the way through.
+
+
+======================
+NEGATIVE INSTANTIATION
+======================
+
+Rather than instantiating a key, it is possible for the possessor of an
+authorisation key to negatively instantiate a key that's under construction.
+This is a short duration placeholder that causes any attempt at re-requesting
+the key whilst it exists to fail with error ENOKEY.
+
+This is provided to prevent excessive repeated spawning of /sbin/request-key
+processes for a key that will never be obtainable.
+
+Should the /sbin/request-key process exit anything other than 0 or die on a
+signal, the key under construction will be automatically negatively
+instantiated for a short amount of time.
+
+
+====================
+THE SEARCH ALGORITHM
+====================
+
+A search of any particular keyring proceeds in the following fashion:
+
+ (1) When the key management code searches for a key (keyring_search_aux) it
+     firstly calls key_permission(SEARCH) on the keyring it's starting with,
+     if this denies permission, it doesn't search further.
+
+ (2) It considers all the non-keyring keys within that keyring and, if any key
+     matches the criteria specified, calls key_permission(SEARCH) on it to see
+     if the key is allowed to be found. If it is, that key is returned; if
+     not, the search continues, and the error code is retained if of higher
+     priority than the one currently set.
+
+ (3) It then considers all the keyring-type keys in the keyring it's currently
+     searching. It calls key_permission(SEARCH) on each keyring, and if this
+     grants permission, it recurses, executing steps (2) and (3) on that
+     keyring.
+
+The process stops immediately a valid key is found with permission granted to
+use it. Any error from a previous match attempt is discarded and the key is
+returned.
+
+When search_process_keyrings() is invoked, it performs the following searches
+until one succeeds:
+
+ (1) If extant, the process's thread keyring is searched.
+
+ (2) If extant, the process's process keyring is searched.
+
+ (3) The process's session keyring is searched.
+
+ (4) If the process has a request_key() authorisation key in its session
+     keyring then:
+
+     (a) If extant, the calling process's thread keyring is searched.
+
+     (b) If extant, the calling process's process keyring is searched.
+
+     (c) The calling process's session keyring is searched.
+
+The moment one succeeds, all pending errors are discarded and the found key is
+returned.
+
+Only if all these fail does the whole thing fail with the highest priority
+error. Note that several errors may have come from LSM.
+
+The error priority is:
+
+	EKEYREVOKED > EKEYEXPIRED > ENOKEY
+
+EACCES/EPERM are only returned on a direct search of a specific keyring where
+the basal keyring does not grant Search permission.
diff -uNrp linux-2.6.14-rc3-keys/Documentation/keys.txt linux-2.6.14-rc3-keys-split/Documentation/keys.txt
--- linux-2.6.14-rc3-keys/Documentation/keys.txt	2005-10-03 10:48:15.000000000 +0100
+++ linux-2.6.14-rc3-keys-split/Documentation/keys.txt	2005-10-07 14:46:31.000000000 +0100
@@ -361,6 +361,8 @@ The main syscalls are:
      /sbin/request-key will be invoked in an attempt to obtain a key. The
      callout_info string will be passed as an argument to the program.
 
+     See also Documentation/keys-request-key.txt.
+
 
 The keyctl syscall functions are:
 
@@ -533,8 +535,8 @@ The keyctl syscall functions are:
 
  (*) Read the payload data from a key:
 
-	key_serial_t keyctl(KEYCTL_READ, key_serial_t keyring, char *buffer,
-			    size_t buflen);
+	long keyctl(KEYCTL_READ, key_serial_t keyring, char *buffer,
+		    size_t buflen);
 
      This function attempts to read the payload data from the specified key
      into the buffer. The process must have read permission on the key to
@@ -555,9 +557,9 @@ The keyctl syscall functions are:
 
  (*) Instantiate a partially constructed key.
 
-	key_serial_t keyctl(KEYCTL_INSTANTIATE, key_serial_t key,
-			    const void *payload, size_t plen,
-			    key_serial_t keyring);
+	long keyctl(KEYCTL_INSTANTIATE, key_serial_t key,
+		    const void *payload, size_t plen,
+		    key_serial_t keyring);
 
      If the kernel calls back to userspace to complete the instantiation of a
      key, userspace should use this call to supply data for the key before the
@@ -576,8 +578,8 @@ The keyctl syscall functions are:
 
  (*) Negatively instantiate a partially constructed key.
 
-	key_serial_t keyctl(KEYCTL_NEGATE, key_serial_t key,
-			    unsigned timeout, key_serial_t keyring);
+	long keyctl(KEYCTL_NEGATE, key_serial_t key,
+		    unsigned timeout, key_serial_t keyring);
 
      If the kernel calls back to userspace to complete the instantiation of a
      key, userspace should use this call mark the key as negative before the
@@ -688,6 +690,8 @@ payload contents" for more information.
     If successful, the key will have been attached to the default keyring for
     implicitly obtained request-key keys, as set by KEYCTL_SET_REQKEY_KEYRING.
 
+    See also Documentation/keys-request-key.txt.
+
 
 (*) When it is no longer required, the key should be released using:
 
diff -uNrp linux-2.6.14-rc3-keys/security/keys/request_key_auth.c linux-2.6.14-rc3-keys-split/security/keys/request_key_auth.c
--- linux-2.6.14-rc3-keys/security/keys/request_key_auth.c	2005-10-03 10:48:43.000000000 +0100
+++ linux-2.6.14-rc3-keys-split/security/keys/request_key_auth.c	2005-10-07 14:55:05.000000000 +0100
@@ -7,6 +7,8 @@
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
+ *
+ * See Documentation/keys-request-key.txt
  */
 
 #include <linux/module.h>
diff -uNrp linux-2.6.14-rc3-keys/security/keys/request_key.c linux-2.6.14-rc3-keys-split/security/keys/request_key.c
--- linux-2.6.14-rc3-keys/security/keys/request_key.c	2005-10-03 10:48:43.000000000 +0100
+++ linux-2.6.14-rc3-keys-split/security/keys/request_key.c	2005-10-07 14:54:56.000000000 +0100
@@ -7,6 +7,8 @@
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
+ *
+ * See Documentation/keys-request-key.txt
  */
 
 #include <linux/module.h>
