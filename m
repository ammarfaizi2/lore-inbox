Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVBYOCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVBYOCg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 09:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbVBYOCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 09:02:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50575 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262667AbVBYOCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 09:02:18 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1108857623.19837.21.camel@lade.trondhjem.org> 
References: <1108857623.19837.21.camel@lade.trondhjem.org>  <1108674820.15367.87.camel@lade.trondhjem.org> <1108671541.15367.30.camel@lade.trondhjem.org> <1108658784.10040.7.camel@lade.trondhjem.org> <E1D1U3N-0005Wa-Ja@puzzle.fieldses.org> <Pine.LNX.4.61.0502162341140.8862@shell0.pdx.osdl.net> <21126.1108670591@redhat.com> <22574.1108673362@redhat.com> <3082.1108680742@redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Doc update on locking
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Fri, 25 Feb 2005 14:02:11 +0000
Message-ID: <25981.1109340131@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch updates the documentation on the kernel keys to describe the
locking associated with keys and key type operations.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-lock-doc-2611rc4.diff 
 Documentation/keys.txt |   55 +++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 44 insertions(+), 11 deletions(-)

diff -uNr linux-2.6.11-rc4/Documentation/keys.txt linux-2.6.11-rc4-keys-task/Documentation/keys.txt
--- linux-2.6.11-rc4/Documentation/keys.txt	2005-01-04 11:12:42.000000000 +0000
+++ linux-2.6.11-rc4-keys-task/Documentation/keys.txt	2005-02-25 13:48:17.387035408 +0000
@@ -606,8 +606,12 @@
 due to two different users opening the same file is left to the filesystem
 author to solve.
 
-When accessing a key's payload data, the key->lock should be at least read
-locked, or else the data may be changed by update during the access.
+When accessing a key's payload data, key->lock should be at least read locked,
+or else the data may be changed by an update being performed from userspace
+whilst the driver or filesystem is trying to access it. If no update method is
+supplied, then the key's payload may be accessed without holding a lock as
+there is no way to change it, provided it can be guaranteed that the key's
+type definition won't go away.
 
 (*) To search for a key, call:
 
@@ -719,13 +723,19 @@
 
  (*) int (*instantiate)(struct key *key, const void *data, size_t datalen);
 
-     This method is called to attach a payload to a key during
-     construction. The payload attached need not bear any relation to the data
-     passed to this function.
+     This method is called to attach a payload to a key during construction.
+     The payload attached need not bear any relation to the data passed to
+     this function.
 
      If the amount of data attached to the key differs from the size in
      keytype->def_datalen, then key_payload_reserve() should be called.
 
+     This method does not have to lock the key in order to attach a payload.
+     The fact that KEY_FLAG_INSTANTIATED is not set in key->flags prevents
+     anything else from gaining access to the key.
+
+     This method may sleep if it wishes.
+
 
  (*) int (*duplicate)(struct key *key, const struct key *source);
 
@@ -734,8 +744,8 @@
      the new key. The data length on the new key will have been updated and
      the quota adjusted already.
 
-     The source key will be locked against change on the source->sem, so it is
-     safe to sleep here.
+     This method will be called with the source key's semaphore read-locked to
+     prevent its payload from being changed. It is safe to sleep here.
 
 
  (*) int (*update)(struct key *key, const void *data, size_t datalen);
@@ -749,30 +759,47 @@
      type is committed to changing the key because it's already been altered,
      so all memory allocation must be done first.
 
-     The key will be locked against other changers on key->sem, so it is safe
-     to sleep here.
-
      key_payload_reserve() should be called with the key->lock write locked,
      and the changes to the key's attached payload should be made before the
      key is locked.
 
+     The key will have its semaphore write-locked before this method is
+     called. Any changes to the key should be made with the key's rwlock
+     write-locked also. It is safe to sleep here.
+
 
  (*) int (*match)(const struct key *key, const void *desc);
 
      This method is called to match a key against a description. It should
      return non-zero if the two match, zero if they don't.
 
+     This method should not need to lock the key in any way. The type and
+     description can be considered invariant, and the payload should not be
+     accessed (the key may not yet be instantiated).
+
+     It is not safe to sleep in this method; the caller may hold spinlocks.
+
 
  (*) void (*destroy)(struct key *key);
 
      This method is optional. It is called to discard the payload data on a
      key when it is being destroyed.
 
+     This method does not need to lock the key; it can consider the key as
+     being inaccessible. Note that the key's type may have changed before this
+     function is called.
+
+     It is not safe to sleep in this method; the caller may hold spinlocks.
+
 
  (*) void (*describe)(const struct key *key, struct seq_file *p);
 
      This method is optional. It is called during /proc/keys reading to
-     summarise a key in text form.
+     summarise a key's description and payload in text form.
+
+     This method will be called with the key's rwlock read-locked. This will
+     prevent the key's payload and state changing; also the description should
+     not change. This also means it is not safe to sleep in this method.
 
 
  (*) long (*read)(const struct key *key, char __user *buffer, size_t buflen);
@@ -785,6 +812,12 @@
      If successful, the blob size that could be produced should be returned
      rather than the size copied.
 
+     This method will be called with the key's semaphore read-locked. This
+     will prevent the key's payload changing. It is not necessary to also
+     read-lock key->lock when accessing the key's payload. It is safe to sleep
+     in this method, such as might happen when the userspace buffer is
+     accessed.
+
 
 ============================
 REQUEST-KEY CALLBACK SERVICE
