Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVCJMGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVCJMGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 07:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVCJMGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 07:06:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27108 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262536AbVCJMCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 07:02:24 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, trond.myklebust@fys.uio.no
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] keys: Discard key spinlock and use RCU for key payload [try #3]
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Thu, 10 Mar 2005 12:01:51 +0000
Message-ID: <4181.1110456111@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch changes the key implementation in a number of ways:

 (1) It removes the spinlock from the key structure.

 (2) The key flags are now accessed using atomic bitops instead of
     write-locking the key spinlock and using C bitwise operators.

     The three instantiation flags are dealt with with the construction
     semaphore held during the request_key/instantiate/negate sequence, thus
     rendering the spinlock superfluous.

     The key flags are also now bit numbers not bit masks.

 (3) The key payload is now accessed using RCU. This permits the recursive
     keyring search algorithm to be simplified greatly since no locks need be
     taken other than the usual RCU preemption disablement. Searching now does
     not require any locks or semaphores to be held; merely that the starting
     keyring be pinned.

 (4) The keyring payload now includes an RCU head so that it can be disposed
     of by call_rcu(). This requires that the payload be copied on unlink to
     prevent introducing races in copy-down vs search-up.

 (5) The user key payload is now a structure with the data following it. It
     includes an RCU head like the keyring payload and for the same reason. It
     also contains a data length because the data length in the key may be
     changed on another CPU whilst an RCU protected read is in progress on the
     payload. This would then see the supposed RCU payload and the on-key data
     length getting out of sync.

     I'm tempted to drop the key's datalen entirely, except that it's used in
     conjunction with quota management and so is a little tricky to get rid
     of.

 (6) Update the keys documentation.

I've updated the patch to be against 2.6.11-mm2.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
diff -uNrp linux-2.6.11-mm2/Documentation/keys.txt linux-2.6.11-mm2-keys-rcu/Documentation/keys.txt
--- linux-2.6.11-mm2/Documentation/keys.txt	2005-03-09 10:36:51.000000000 +0000
+++ linux-2.6.11-mm2-keys-rcu/Documentation/keys.txt	2005-03-10 11:26:24.774284678 +0000
@@ -22,6 +22,7 @@ This document has the following sections
 	- New procfs files
 	- Userspace system call interface
 	- Kernel services
+	- Notes on accessing payload contents
 	- Defining a key type
 	- Request-key callback service
 	- Key access filesystem
@@ -45,27 +46,26 @@ Each key has a number of attributes:
 	- State.
 
 
- (*) Each key is issued a serial number of type key_serial_t that is unique
-     for the lifetime of that key. All serial numbers are positive non-zero
-     32-bit integers.
+ (*) Each key is issued a serial number of type key_serial_t that is unique for
+     the lifetime of that key. All serial numbers are positive non-zero 32-bit
+     integers.
 
      Userspace programs can use a key's serial numbers as a way to gain access
      to it, subject to permission checking.
 
  (*) Each key is of a defined "type". Types must be registered inside the
-     kernel by a kernel service (such as a filesystem) before keys of that
-     type can be added or used. Userspace programs cannot define new types
-     directly.
+     kernel by a kernel service (such as a filesystem) before keys of that type
+     can be added or used. Userspace programs cannot define new types directly.
 
-     Key types are represented in the kernel by struct key_type. This defines
-     a number of operations that can be performed on a key of that type.
+     Key types are represented in the kernel by struct key_type. This defines a
+     number of operations that can be performed on a key of that type.
 
      Should a type be removed from the system, all the keys of that type will
      be invalidated.
 
  (*) Each key has a description. This should be a printable string. The key
-     type provides an operation to perform a match between the description on
-     a key and a criterion string.
+     type provides an operation to perform a match between the description on a
+     key and a criterion string.
 
  (*) Each key has an owner user ID, a group ID and a permissions mask. These
      are used to control what a process may do to a key from userspace, and
@@ -74,10 +74,10 @@ Each key has a number of attributes:
  (*) Each key can be set to expire at a specific time by the key type's
      instantiation function. Keys can also be immortal.
 
- (*) Each key can have a payload. This is a quantity of data that represent
-     the actual "key". In the case of a keyring, this is a list of keys to
-     which the keyring links; in the case of a user-defined key, it's an
-     arbitrary blob of data.
+ (*) Each key can have a payload. This is a quantity of data that represent the
+     actual "key". In the case of a keyring, this is a list of keys to which
+     the keyring links; in the case of a user-defined key, it's an arbitrary
+     blob of data.
 
      Having a payload is not required; and the payload can, in fact, just be a
      value stored in the struct key itself.
@@ -92,8 +92,8 @@ Each key has a number of attributes:
 
  (*) Each key can be in one of a number of basic states:
 
-     (*) Uninstantiated. The key exists, but does not have any data
-	 attached. Keys being requested from userspace will be in this state.
+     (*) Uninstantiated. The key exists, but does not have any data attached.
+     	 Keys being requested from userspace will be in this state.
 
      (*) Instantiated. This is the normal state. The key is fully formed, and
 	 has data attached.
@@ -140,10 +140,10 @@ The key service provides a number of fea
      clone, fork, vfork or execve occurs. A new keyring is created only when
      required.
 
-     The process-specific keyring is replaced with an empty one in the child
-     on clone, fork, vfork unless CLONE_THREAD is supplied, in which case it
-     is shared. execve also discards the process's process keyring and creates
-     a new one.
+     The process-specific keyring is replaced with an empty one in the child on
+     clone, fork, vfork unless CLONE_THREAD is supplied, in which case it is
+     shared. execve also discards the process's process keyring and creates a
+     new one.
 
      The session-specific keyring is persistent across clone, fork, vfork and
      execve, even when the latter executes a set-UID or set-GID binary. A
@@ -177,11 +177,11 @@ The key service provides a number of fea
      If a system call that modifies a key or keyring in some way would put the
      user over quota, the operation is refused and error EDQUOT is returned.
 
- (*) There's a system call interface by which userspace programs can create
-     and manipulate keys and keyrings.
+ (*) There's a system call interface by which userspace programs can create and
+     manipulate keys and keyrings.
 
- (*) There's a kernel interface by which services can register types and
-     search for keys.
+ (*) There's a kernel interface by which services can register types and search
+     for keys.
 
  (*) There's a way for the a search done from the kernel to call back to
      userspace to request a key that can't be found in a process's keyrings.
@@ -194,9 +194,9 @@ The key service provides a number of fea
 KEY ACCESS PERMISSIONS
 ======================
 
-Keys have an owner user ID, a group access ID, and a permissions mask. The
-mask has up to eight bits each for user, group and other access. Only five of
-each set of eight bits are defined. These permissions granted are:
+Keys have an owner user ID, a group access ID, and a permissions mask. The mask
+has up to eight bits each for user, group and other access. Only five of each
+set of eight bits are defined. These permissions granted are:
 
  (*) View
 
@@ -210,8 +210,8 @@ each set of eight bits are defined. Thes
 
  (*) Write
 
-     This permits a key's payload to be instantiated or updated, or it allows
-     a link to be added to or removed from a keyring.
+     This permits a key's payload to be instantiated or updated, or it allows a
+     link to be added to or removed from a keyring.
 
  (*) Search
 
@@ -238,8 +238,8 @@ about the status of the key service:
  (*) /proc/keys
 
      This lists all the keys on the system, giving information about their
-     type, description and permissions. The payload of the key is not
-     available this way:
+     type, description and permissions. The payload of the key is not available
+     this way:
 
 	SERIAL   FLAGS  USAGE EXPY PERM   UID   GID   TYPE      DESCRIPTION: SUMMARY
 	00000001 I-----    39 perm 1f0000     0     0 keyring   _uid_ses.0: 1/4
@@ -318,21 +318,21 @@ The main syscalls are:
      If a key of the same type and description as that proposed already exists
      in the keyring, this will try to update it with the given payload, or it
      will return error EEXIST if that function is not supported by the key
-     type. The process must also have permission to write to the key to be
-     able to update it. The new key will have all user permissions granted and
-     no group or third party permissions.
-
-     Otherwise, this will attempt to create a new key of the specified type
-     and description, and to instantiate it with the supplied payload and
-     attach it to the keyring. In this case, an error will be generated if the
-     process does not have permission to write to the keyring.
+     type. The process must also have permission to write to the key to be able
+     to update it. The new key will have all user permissions granted and no
+     group or third party permissions.
+
+     Otherwise, this will attempt to create a new key of the specified type and
+     description, and to instantiate it with the supplied payload and attach it
+     to the keyring. In this case, an error will be generated if the process
+     does not have permission to write to the keyring.
 
      The payload is optional, and the pointer can be NULL if not required by
      the type. The payload is plen in size, and plen can be zero for an empty
      payload.
 
-     A new keyring can be generated by setting type "keyring", the keyring
-     name as the description (or NULL) and setting the payload to NULL.
+     A new keyring can be generated by setting type "keyring", the keyring name
+     as the description (or NULL) and setting the payload to NULL.
 
      User defined keys can be created by specifying type "user". It is
      recommended that a user defined key's description by prefixed with a type
@@ -369,9 +369,9 @@ The keyctl syscall functions are:
 	key_serial_t keyctl(KEYCTL_GET_KEYRING_ID, key_serial_t id,
 			    int create);
 
-     The special key specified by "id" is looked up (with the key being
-     created if necessary) and the ID of the key or keyring thus found is
-     returned if it exists.
+     The special key specified by "id" is looked up (with the key being created
+     if necessary) and the ID of the key or keyring thus found is returned if
+     it exists.
 
      If the key does not yet exist, the key will be created if "create" is
      non-zero; and the error ENOKEY will be returned if "create" is zero.
@@ -402,8 +402,8 @@ The keyctl syscall functions are:
 
      This will try to update the specified key with the given payload, or it
      will return error EOPNOTSUPP if that function is not supported by the key
-     type. The process must also have permission to write to the key to be
-     able to update it.
+     type. The process must also have permission to write to the key to be able
+     to update it.
 
      The payload is of length plen, and may be absent or empty as for
      add_key().
@@ -422,8 +422,8 @@ The keyctl syscall functions are:
 
 	long keyctl(KEYCTL_CHOWN, key_serial_t key, uid_t uid, gid_t gid);
 
-     This function permits a key's owner and group ID to be changed. Either
-     one of uid or gid can be set to -1 to suppress that change.
+     This function permits a key's owner and group ID to be changed. Either one
+     of uid or gid can be set to -1 to suppress that change.
 
      Only the superuser can change a key's owner to something other than the
      key's current owner. Similarly, only the superuser can change a key's
@@ -484,12 +484,12 @@ The keyctl syscall functions are:
 
 	long keyctl(KEYCTL_LINK, key_serial_t keyring, key_serial_t key);
 
-     This function creates a link from the keyring to the key. The process
-     must have write permission on the keyring and must have link permission
-     on the key.
+     This function creates a link from the keyring to the key. The process must
+     have write permission on the keyring and must have link permission on the
+     key.
 
-     Should the keyring not be a keyring, error ENOTDIR will result; and if
-     the keyring is full, error ENFILE will result.
+     Should the keyring not be a keyring, error ENOTDIR will result; and if the
+     keyring is full, error ENFILE will result.
 
      The link procedure checks the nesting of the keyrings, returning ELOOP if
      it appears to deep or EDEADLK if the link would introduce a cycle.
@@ -503,8 +503,8 @@ The keyctl syscall functions are:
      specified key, and removes it if found. Subsequent links to that key are
      ignored. The process must have write permission on the keyring.
 
-     If the keyring is not a keyring, error ENOTDIR will result; and if the
-     key is not present, error ENOENT will be the result.
+     If the keyring is not a keyring, error ENOTDIR will result; and if the key
+     is not present, error ENOENT will be the result.
 
 
  (*) Search a keyring tree for a key:
@@ -513,9 +513,9 @@ The keyctl syscall functions are:
 			    const char *type, const char *description,
 			    key_serial_t dest_keyring);
 
-     This searches the keyring tree headed by the specified keyring until a
-     key is found that matches the type and description criteria. Each keyring
-     is checked for keys before recursion into its children occurs.
+     This searches the keyring tree headed by the specified keyring until a key
+     is found that matches the type and description criteria. Each keyring is
+     checked for keys before recursion into its children occurs.
 
      The process must have search permission on the top level keyring, or else
      error EACCES will result. Only keyrings that the process has search
@@ -549,8 +549,8 @@ The keyctl syscall functions are:
      As much of the data as can be fitted into the buffer will be copied to
      userspace if the buffer pointer is not NULL.
 
-     On a successful return, the function will always return the amount of
-     data available rather than the amount copied.
+     On a successful return, the function will always return the amount of data
+     available rather than the amount copied.
 
 
  (*) Instantiate a partially constructed key.
@@ -568,8 +568,8 @@ The keyctl syscall functions are:
      it, and the key must be uninstantiated.
 
      If a keyring is specified (non-zero), the key will also be linked into
-     that keyring, however all the constraints applying in KEYCTL_LINK apply
-     in this case too.
+     that keyring, however all the constraints applying in KEYCTL_LINK apply in
+     this case too.
 
      The payload and plen arguments describe the payload data as for add_key().
 
@@ -587,8 +587,8 @@ The keyctl syscall functions are:
      it, and the key must be uninstantiated.
 
      If a keyring is specified (non-zero), the key will also be linked into
-     that keyring, however all the constraints applying in KEYCTL_LINK apply
-     in this case too.
+     that keyring, however all the constraints applying in KEYCTL_LINK apply in
+     this case too.
 
 
 ===============
@@ -601,17 +601,14 @@ be broken down into two areas: keys and 
 Dealing with keys is fairly straightforward. Firstly, the kernel service
 registers its type, then it searches for a key of that type. It should retain
 the key as long as it has need of it, and then it should release it. For a
-filesystem or device file, a search would probably be performed during the
-open call, and the key released upon close. How to deal with conflicting keys
-due to two different users opening the same file is left to the filesystem
-author to solve.
-
-When accessing a key's payload data, key->lock should be at least read locked,
-or else the data may be changed by an update being performed from userspace
-whilst the driver or filesystem is trying to access it. If no update method is
-supplied, then the key's payload may be accessed without holding a lock as
-there is no way to change it, provided it can be guaranteed that the key's
-type definition won't go away.
+filesystem or device file, a search would probably be performed during the open
+call, and the key released upon close. How to deal with conflicting keys due to
+two different users opening the same file is left to the filesystem author to
+solve.
+
+When accessing a key's payload contents, certain precautions must be taken to
+prevent access vs modification races. See the section "Notes on accessing
+payload contents" for more information.
 
 (*) To search for a key, call:
 
@@ -690,6 +687,54 @@ type definition won't go away.
 	void unregister_key_type(struct key_type *type);
 
 
+===================================
+NOTES ON ACCESSING PAYLOAD CONTENTS
+===================================
+
+The simplest payload is just a number in key->payload.value. In this case,
+there's no need to indulge in RCU or locking when accessing the payload.
+
+More complex payload contents must be allocated and a pointer to them set in
+key->payload.data. One of the following ways must be selected to access the
+data:
+
+ (1) Unmodifyable key type.
+
+     If the key type does not have a modify method, then the key's payload can
+     be accessed without any form of locking, provided that it's known to be
+     instantiated (uninstantiated keys cannot be "found").
+
+ (2) The key's semaphore.
+
+     The semaphore could be used to govern access to the payload and to control
+     the payload pointer. It must be write-locked for modifications and would
+     have to be read-locked for general access. The disadvantage of doing this
+     is that the accessor may be required to sleep.
+
+ (3) RCU.
+
+     RCU must be used when the semaphore isn't already held; if the semaphore
+     is held then the contents can't change under you unexpectedly as the
+     semaphore must still be used to serialise modifications to the key. The
+     key management code takes care of this for the key type.
+
+     However, this means using:
+
+	rcu_read_lock() ... rcu_dereference() ... rcu_read_unlock()
+
+     to read the pointer, and:
+
+	rcu_dereference() ... rcu_assign_pointer() ... call_rcu()
+
+     to set the pointer and dispose of the old contents after a grace period.
+     Note that only the key type should ever modify a key's payload.
+
+     Furthermore, an RCU controlled payload must hold a struct rcu_head for the
+     use of call_rcu() and, if the payload is of variable size, the length of
+     the payload. key->datalen cannot be relied upon to be consistent with the
+     payload just dereferenced if the key's semaphore is not held.
+
+
 ===================
 DEFINING A KEY TYPE
 ===================
@@ -717,15 +762,15 @@ The structure has a number of fields, so
 
 	int key_payload_reserve(struct key *key, size_t datalen);
 
-     With the revised data length. Error EDQUOT will be returned if this is
-     not viable.
+     With the revised data length. Error EDQUOT will be returned if this is not
+     viable.
 
 
  (*) int (*instantiate)(struct key *key, const void *data, size_t datalen);
 
      This method is called to attach a payload to a key during construction.
-     The payload attached need not bear any relation to the data passed to
-     this function.
+     The payload attached need not bear any relation to the data passed to this
+     function.
 
      If the amount of data attached to the key differs from the size in
      keytype->def_datalen, then key_payload_reserve() should be called.
@@ -734,38 +779,47 @@ The structure has a number of fields, so
      The fact that KEY_FLAG_INSTANTIATED is not set in key->flags prevents
      anything else from gaining access to the key.
 
-     This method may sleep if it wishes.
+     It is safe to sleep in this method.
 
 
  (*) int (*duplicate)(struct key *key, const struct key *source);
 
      If this type of key can be duplicated, then this method should be
-     provided. It is called to copy the payload attached to the source into
-     the new key. The data length on the new key will have been updated and
-     the quota adjusted already.
+     provided. It is called to copy the payload attached to the source into the
+     new key. The data length on the new key will have been updated and the
+     quota adjusted already.
 
      This method will be called with the source key's semaphore read-locked to
-     prevent its payload from being changed. It is safe to sleep here.
+     prevent its payload from being changed, thus RCU constraints need not be
+     applied to the source key.
+
+     This method does not have to lock the destination key in order to attach a
+     payload. The fact that KEY_FLAG_INSTANTIATED is not set in key->flags
+     prevents anything else from gaining access to the key.
+
+     It is safe to sleep in this method.
 
 
  (*) int (*update)(struct key *key, const void *data, size_t datalen);
 
-     If this type of key can be updated, then this method should be
-     provided. It is called to update a key's payload from the blob of data
-     provided.
+     If this type of key can be updated, then this method should be provided.
+     It is called to update a key's payload from the blob of data provided.
 
      key_payload_reserve() should be called if the data length might change
-     before any changes are actually made. Note that if this succeeds, the
-     type is committed to changing the key because it's already been altered,
-     so all memory allocation must be done first.
-
-     key_payload_reserve() should be called with the key->lock write locked,
-     and the changes to the key's attached payload should be made before the
-     key is locked.
-
-     The key will have its semaphore write-locked before this method is
-     called. Any changes to the key should be made with the key's rwlock
-     write-locked also. It is safe to sleep here.
+     before any changes are actually made. Note that if this succeeds, the type
+     is committed to changing the key because it's already been altered, so all
+     memory allocation must be done first.
+
+     The key will have its semaphore write-locked before this method is called,
+     but this only deters other writers; any changes to the key's payload must
+     be made under RCU conditions, and call_rcu() must be used to dispose of
+     the old payload.
+
+     key_payload_reserve() should be called before the changes are made, but
+     after all allocations and other potentially failing function calls are
+     made.
+
+     It is safe to sleep in this method.
 
 
  (*) int (*match)(const struct key *key, const void *desc);
@@ -782,12 +836,12 @@ The structure has a number of fields, so
 
  (*) void (*destroy)(struct key *key);
 
-     This method is optional. It is called to discard the payload data on a
-     key when it is being destroyed.
+     This method is optional. It is called to discard the payload data on a key
+     when it is being destroyed.
 
-     This method does not need to lock the key; it can consider the key as
-     being inaccessible. Note that the key's type may have changed before this
-     function is called.
+     This method does not need to lock the key to access the payload; it can
+     consider the key as being inaccessible at this time. Note that the key's
+     type may have been changed before this function is called.
 
      It is not safe to sleep in this method; the caller may hold spinlocks.
 
@@ -797,26 +851,31 @@ The structure has a number of fields, so
      This method is optional. It is called during /proc/keys reading to
      summarise a key's description and payload in text form.
 
-     This method will be called with the key's rwlock read-locked. This will
-     prevent the key's payload and state changing; also the description should
-     not change. This also means it is not safe to sleep in this method.
+     This method will be called with the RCU read lock held. rcu_dereference()
+     should be used to read the payload pointer if the payload is to be
+     accessed. key->datalen cannot be trusted to stay consistent with the
+     contents of the payload.
+
+     The description will not change, though the key's state may.
+
+     It is not safe to sleep in this method; the RCU read lock is held by the
+     caller.
 
 
  (*) long (*read)(const struct key *key, char __user *buffer, size_t buflen);
 
      This method is optional. It is called by KEYCTL_READ to translate the
-     key's payload into something a blob of data for userspace to deal
-     with. Ideally, the blob should be in the same format as that passed in to
-     the instantiate and update methods.
+     key's payload into something a blob of data for userspace to deal with.
+     Ideally, the blob should be in the same format as that passed in to the
+     instantiate and update methods.
 
      If successful, the blob size that could be produced should be returned
      rather than the size copied.
 
-     This method will be called with the key's semaphore read-locked. This
-     will prevent the key's payload changing. It is not necessary to also
-     read-lock key->lock when accessing the key's payload. It is safe to sleep
-     in this method, such as might happen when the userspace buffer is
-     accessed.
+     This method will be called with the key's semaphore read-locked. This will
+     prevent the key's payload changing. It is not necessary to use RCU locking
+     when accessing the key's payload. It is safe to sleep in this method, such
+     as might happen when the userspace buffer is accessed.
 
 
 ============================
@@ -853,8 +912,8 @@ If it returns with the key remaining in 
 be marked as being negative, it will be added to the session keyring, and an
 error will be returned to the key requestor.
 
-Supplementary information may be provided from whoever or whatever invoked
-this service. This will be passed as the <callout_info> parameter. If no such
+Supplementary information may be provided from whoever or whatever invoked this
+service. This will be passed as the <callout_info> parameter. If no such
 information was made available, then "-" will be passed as this parameter
 instead.
 
diff -uNrp linux-2.6.11-mm2/include/linux/key.h linux-2.6.11-mm2-keys-rcu/include/linux/key.h
--- linux-2.6.11-mm2/include/linux/key.h	2005-03-09 10:37:33.000000000 +0000
+++ linux-2.6.11-mm2-keys-rcu/include/linux/key.h	2005-03-10 10:12:04.625785240 +0000
@@ -18,7 +18,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/rbtree.h>
-#include <linux/spinlock.h>
+#include <linux/rcupdate.h>
 #include <asm/atomic.h>
 
 #ifdef __KERNEL__
@@ -78,7 +78,6 @@ struct key {
 	key_serial_t		serial;		/* key serial number */
 	struct rb_node		serial_node;
 	struct key_type		*type;		/* type of key */
-	rwlock_t		lock;		/* examination vs change lock */
 	struct rw_semaphore	sem;		/* change vs change sem */
 	struct key_user		*user;		/* owner of this key */
 	time_t			expiry;		/* time at which key expires (or 0) */
@@ -86,14 +85,10 @@ struct key {
 	gid_t			gid;
 	key_perm_t		perm;		/* access permissions */
 	unsigned short		quotalen;	/* length added to quota */
-	unsigned short		datalen;	/* payload data length */
-	unsigned short		flags;		/* status flags (change with lock writelocked) */
-#define KEY_FLAG_INSTANTIATED	0x00000001	/* set if key has been instantiated */
-#define KEY_FLAG_DEAD		0x00000002	/* set if key type has been deleted */
-#define KEY_FLAG_REVOKED	0x00000004	/* set if key had been revoked */
-#define KEY_FLAG_IN_QUOTA	0x00000008	/* set if key consumes quota */
-#define KEY_FLAG_USER_CONSTRUCT	0x00000010	/* set if key is being constructed in userspace */
-#define KEY_FLAG_NEGATIVE	0x00000020	/* set if key is negative */
+	unsigned short		datalen;	/* payload data length
+						 * - may not match RCU dereferenced payload
+						 * - payload should contain own length
+						 */
 
 #ifdef KEY_DEBUGGING
 	unsigned		magic;
@@ -101,6 +96,14 @@ struct key {
 #define KEY_DEBUG_MAGIC_X	0xf8e9dacbu
 #endif
 
+	unsigned long		flags;		/* status flags (change with bitops) */
+#define KEY_FLAG_INSTANTIATED	0	/* set if key has been instantiated */
+#define KEY_FLAG_DEAD		1	/* set if key type has been deleted */
+#define KEY_FLAG_REVOKED	2	/* set if key had been revoked */
+#define KEY_FLAG_IN_QUOTA	3	/* set if key consumes quota */
+#define KEY_FLAG_USER_CONSTRUCT	4	/* set if key is being constructed in userspace */
+#define KEY_FLAG_NEGATIVE	5	/* set if key is negative */
+
 	/* the description string
 	 * - this is used to match a key against search criteria
 	 * - this should be a printable string
@@ -250,6 +253,8 @@ extern int keyring_add_key(struct key *k
 
 extern struct key *key_lookup(key_serial_t id);
 
+extern void keyring_replace_payload(struct key *key, void *replacement);
+
 #define key_serial(key) ((key) ? (key)->serial : 0)
 
 /*
diff -uNrp linux-2.6.11-mm2/include/linux/key-ui.h linux-2.6.11-mm2-keys-rcu/include/linux/key-ui.h
--- linux-2.6.11-mm2/include/linux/key-ui.h	2005-01-04 11:13:54.000000000 +0000
+++ linux-2.6.11-mm2-keys-rcu/include/linux/key-ui.h	2005-03-10 10:12:04.629784910 +0000
@@ -31,8 +31,10 @@ extern spinlock_t key_serial_lock;
  * subscribed
  */
 struct keyring_list {
-	unsigned	maxkeys;	/* max keys this list can hold */
-	unsigned	nkeys;		/* number of keys currently held */
+	struct rcu_head	rcu;		/* RCU deletion hook */
+	unsigned short	maxkeys;	/* max keys this list can hold */
+	unsigned short	nkeys;		/* number of keys currently held */
+	unsigned short	delkey;		/* key to be unlinked by RCU */
 	struct key	*keys[0];
 };
 
diff -uNrp linux-2.6.11-mm2/security/keys/key.c linux-2.6.11-mm2-keys-rcu/security/keys/key.c
--- linux-2.6.11-mm2/security/keys/key.c	2005-03-02 12:09:11.000000000 +0000
+++ linux-2.6.11-mm2-keys-rcu/security/keys/key.c	2005-03-10 11:11:46.042675631 +0000
@@ -293,7 +293,6 @@ struct key *key_alloc(struct key_type *t
 	}
 
 	atomic_set(&key->usage, 1);
-	rwlock_init(&key->lock);
 	init_rwsem(&key->sem);
 	key->type = type;
 	key->user = user;
@@ -307,7 +306,7 @@ struct key *key_alloc(struct key_type *t
 	key->payload.data = NULL;
 
 	if (!not_in_quota)
-		key->flags |= KEY_FLAG_IN_QUOTA;
+		key->flags |= 1 << KEY_FLAG_IN_QUOTA;
 
 	memset(&key->type_data, 0, sizeof(key->type_data));
 
@@ -358,7 +357,7 @@ int key_payload_reserve(struct key *key,
 	key_check(key);
 
 	/* contemplate the quota adjustment */
-	if (delta != 0 && key->flags & KEY_FLAG_IN_QUOTA) {
+	if (delta != 0 && test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
 		spin_lock(&key->user->lock);
 
 		if (delta > 0 &&
@@ -404,23 +403,17 @@ static int __key_instantiate_and_link(st
 	down_write(&key_construction_sem);
 
 	/* can't instantiate twice */
-	if (!(key->flags & KEY_FLAG_INSTANTIATED)) {
+	if (!test_bit(KEY_FLAG_INSTANTIATED, &key->flags)) {
 		/* instantiate the key */
 		ret = key->type->instantiate(key, data, datalen);
 
 		if (ret == 0) {
 			/* mark the key as being instantiated */
-			write_lock(&key->lock);
-
 			atomic_inc(&key->user->nikeys);
-			key->flags |= KEY_FLAG_INSTANTIATED;
+			set_bit(KEY_FLAG_INSTANTIATED, &key->flags);
 
-			if (key->flags & KEY_FLAG_USER_CONSTRUCT) {
-				key->flags &= ~KEY_FLAG_USER_CONSTRUCT;
+			if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
 				awaken = 1;
-			}
-
-			write_unlock(&key->lock);
 
 			/* and link it into the destination keyring */
 			if (keyring)
@@ -485,21 +478,17 @@ int key_negate_and_link(struct key *key,
 	down_write(&key_construction_sem);
 
 	/* can't instantiate twice */
-	if (!(key->flags & KEY_FLAG_INSTANTIATED)) {
+	if (!test_bit(KEY_FLAG_INSTANTIATED, &key->flags)) {
 		/* mark the key as being negatively instantiated */
-		write_lock(&key->lock);
-
 		atomic_inc(&key->user->nikeys);
-		key->flags |= KEY_FLAG_INSTANTIATED | KEY_FLAG_NEGATIVE;
+		set_bit(KEY_FLAG_NEGATIVE, &key->flags);
+		set_bit(KEY_FLAG_INSTANTIATED, &key->flags);
 		now = current_kernel_time();
 		key->expiry = now.tv_sec + timeout;
 
-		if (key->flags & KEY_FLAG_USER_CONSTRUCT) {
-			key->flags &= ~KEY_FLAG_USER_CONSTRUCT;
+		if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
 			awaken = 1;
-		}
 
-		write_unlock(&key->lock);
 		ret = 0;
 
 		/* and link it into the destination keyring */
@@ -552,8 +541,10 @@ static void key_cleanup(void *data)
 	rb_erase(&key->serial_node, &key_serial_tree);
 	spin_unlock(&key_serial_lock);
 
+	key_check(key);
+
 	/* deal with the user's key tracking and quota */
-	if (key->flags & KEY_FLAG_IN_QUOTA) {
+	if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
 		spin_lock(&key->user->lock);
 		key->user->qnkeys--;
 		key->user->qnbytes -= key->quotalen;
@@ -561,7 +552,7 @@ static void key_cleanup(void *data)
 	}
 
 	atomic_dec(&key->user->nkeys);
-	if (key->flags & KEY_FLAG_INSTANTIATED)
+	if (test_bit(KEY_FLAG_INSTANTIATED, &key->flags))
 		atomic_dec(&key->user->nikeys);
 
 	key_user_put(key->user);
@@ -630,9 +621,9 @@ struct key *key_lookup(key_serial_t id)
 	goto error;
 
  found:
-	/* pretent doesn't exist if it's dead */
+	/* pretend it doesn't exist if it's dead */
 	if (atomic_read(&key->usage) == 0 ||
-	    (key->flags & KEY_FLAG_DEAD) ||
+	    test_bit(KEY_FLAG_DEAD, &key->flags) ||
 	    key->type == &key_type_dead)
 		goto not_found;
 
@@ -707,12 +698,9 @@ static inline struct key *__key_update(s
 
 	ret = key->type->update(key, payload, plen);
 
-	if (ret == 0) {
+	if (ret == 0)
 		/* updating a negative key instantiates it */
-		write_lock(&key->lock);
-		key->flags &= ~KEY_FLAG_NEGATIVE;
-		write_unlock(&key->lock);
-	}
+		clear_bit(KEY_FLAG_NEGATIVE, &key->flags);
 
 	up_write(&key->sem);
 
@@ -840,12 +828,9 @@ int key_update(struct key *key, const vo
 		down_write(&key->sem);
 		ret = key->type->update(key, payload, plen);
 
-		if (ret == 0) {
+		if (ret == 0)
 			/* updating a negative key instantiates it */
-			write_lock(&key->lock);
-			key->flags &= ~KEY_FLAG_NEGATIVE;
-			write_unlock(&key->lock);
-		}
+			clear_bit(KEY_FLAG_NEGATIVE, &key->flags);
 
 		up_write(&key->sem);
 	}
@@ -891,10 +876,7 @@ struct key *key_duplicate(struct key *so
 		goto error2;
 
 	atomic_inc(&key->user->nikeys);
-
-	write_lock(&key->lock);
-	key->flags |= KEY_FLAG_INSTANTIATED;
-	write_unlock(&key->lock);
+	set_bit(KEY_FLAG_INSTANTIATED, &key->flags);
 
  error_k:
 	up_read(&key_types_sem);
@@ -921,9 +903,7 @@ void key_revoke(struct key *key)
 	/* make sure no one's trying to change or use the key when we mark
 	 * it */
 	down_write(&key->sem);
-	write_lock(&key->lock);
-	key->flags |= KEY_FLAG_REVOKED;
-	write_unlock(&key->lock);
+	set_bit(KEY_FLAG_REVOKED, &key->flags);
 	up_write(&key->sem);
 
 } /* end key_revoke() */
@@ -974,24 +954,33 @@ void unregister_key_type(struct key_type
 	/* withdraw the key type */
 	list_del_init(&ktype->link);
 
-	/* need to withdraw all keys of this type */
+	/* mark all the keys of this type dead */
 	spin_lock(&key_serial_lock);
 
 	for (_n = rb_first(&key_serial_tree); _n; _n = rb_next(_n)) {
 		key = rb_entry(_n, struct key, serial_node);
 
-		if (key->type != ktype)
-			continue;
+		if (key->type == ktype)
+			key->type = &key_type_dead;
+	}
+
+	spin_unlock(&key_serial_lock);
+
+	/* make sure everyone revalidates their keys */
+	synchronize_kernel();
+
+	/* we should now be able to destroy the payloads of all the keys of
+	 * this type with impunity */
+	spin_lock(&key_serial_lock);
 
-		write_lock(&key->lock);
-		key->type = &key_type_dead;
-		write_unlock(&key->lock);
-
-		/* there shouldn't be anyone looking at the description or
-		 * payload now */
-		if (ktype->destroy)
-			ktype->destroy(key);
-		memset(&key->payload, 0xbd, sizeof(key->payload));
+	for (_n = rb_first(&key_serial_tree); _n; _n = rb_next(_n)) {
+		key = rb_entry(_n, struct key, serial_node);
+
+		if (key->type == ktype) {
+			if (ktype->destroy)
+				ktype->destroy(key);
+			memset(&key->payload, 0xbd, sizeof(key->payload));
+		}
 	}
 
 	spin_unlock(&key_serial_lock);
@@ -1036,4 +1025,5 @@ void __init key_init(void)
 
 	/* link the two root keyrings together */
 	key_link(&root_session_keyring, &root_user_keyring);
+
 } /* end key_init() */
diff -uNrp linux-2.6.11-mm2/security/keys/keyctl.c linux-2.6.11-mm2-keys-rcu/security/keys/keyctl.c
--- linux-2.6.11-mm2/security/keys/keyctl.c	2005-03-02 12:09:11.000000000 +0000
+++ linux-2.6.11-mm2-keys-rcu/security/keys/keyctl.c	2005-03-10 10:12:04.639784085 +0000
@@ -728,7 +728,6 @@ long keyctl_chown_key(key_serial_t id, u
 	/* make the changes with the locks held to prevent chown/chown races */
 	ret = -EACCES;
 	down_write(&key->sem);
-	write_lock(&key->lock);
 
 	if (!capable(CAP_SYS_ADMIN)) {
 		/* only the sysadmin can chown a key to some other UID */
@@ -755,7 +754,6 @@ long keyctl_chown_key(key_serial_t id, u
 	ret = 0;
 
  no_access:
-	write_unlock(&key->lock);
 	up_write(&key->sem);
 	key_put(key);
  error:
@@ -784,26 +782,19 @@ long keyctl_setperm_key(key_serial_t id,
 		goto error;
 	}
 
-	/* make the changes with the locks held to prevent chown/chmod
-	 * races */
+	/* make the changes with the locks held to prevent chown/chmod races */
 	ret = -EACCES;
 	down_write(&key->sem);
-	write_lock(&key->lock);
 
-	/* if we're not the sysadmin, we can only chmod a key that we
-	 * own */
-	if (!capable(CAP_SYS_ADMIN) && key->uid != current->fsuid)
-		goto no_access;
-
-	/* changing the permissions mask */
-	key->perm = perm;
-	ret = 0;
+	/* if we're not the sysadmin, we can only change a key that we own */
+	if (capable(CAP_SYS_ADMIN) || key->uid == current->fsuid) {
+		key->perm = perm;
+		ret = 0;
+	}
 
- no_access:
-	write_unlock(&key->lock);
 	up_write(&key->sem);
 	key_put(key);
- error:
+error:
 	return ret;
 
 } /* end keyctl_setperm_key() */
diff -uNrp linux-2.6.11-mm2/security/keys/keyring.c linux-2.6.11-mm2-keys-rcu/security/keys/keyring.c
--- linux-2.6.11-mm2/security/keys/keyring.c	2005-03-02 12:09:11.000000000 +0000
+++ linux-2.6.11-mm2-keys-rcu/security/keys/keyring.c	2005-03-10 10:12:04.644783672 +0000
@@ -132,10 +132,17 @@ static int keyring_duplicate(struct key 
 		(PAGE_SIZE - sizeof(*klist)) / sizeof(struct key);
 
 	ret = 0;
-	sklist = source->payload.subscriptions;
 
-	if (sklist && sklist->nkeys > 0) {
+	/* find out how many keys are currently linked */
+	rcu_read_lock();
+	sklist = rcu_dereference(source->payload.subscriptions);
+	max = 0;
+	if (sklist)
 		max = sklist->nkeys;
+	rcu_read_unlock();
+
+	/* allocate a new payload and stuff load with key links */
+	if (max > 0) {
 		BUG_ON(max > limit);
 
 		max = (max + 3) & ~3;
@@ -148,6 +155,10 @@ static int keyring_duplicate(struct key 
 		if (!klist)
 			goto error;
 
+		/* set links */
+		rcu_read_lock();
+		sklist = rcu_dereference(source->payload.subscriptions);
+
 		klist->maxkeys = max;
 		klist->nkeys = sklist->nkeys;
 		memcpy(klist->keys,
@@ -157,7 +168,9 @@ static int keyring_duplicate(struct key 
 		for (loop = klist->nkeys - 1; loop >= 0; loop--)
 			atomic_inc(&klist->keys[loop]->usage);
 
-		keyring->payload.subscriptions = klist;
+		rcu_read_unlock();
+
+		rcu_assign_pointer(keyring->payload.subscriptions, klist);
 		ret = 0;
 	}
 
@@ -192,7 +205,7 @@ static void keyring_destroy(struct key *
 		write_unlock(&keyring_name_lock);
 	}
 
-	klist = keyring->payload.subscriptions;
+	klist = rcu_dereference(keyring->payload.subscriptions);
 	if (klist) {
 		for (loop = klist->nkeys - 1; loop >= 0; loop--)
 			key_put(klist->keys[loop]);
@@ -216,17 +229,20 @@ static void keyring_describe(const struc
 		seq_puts(m, "[anon]");
 	}
 
-	klist = keyring->payload.subscriptions;
+	rcu_read_lock();
+	klist = rcu_dereference(keyring->payload.subscriptions);
 	if (klist)
 		seq_printf(m, ": %u/%u", klist->nkeys, klist->maxkeys);
 	else
 		seq_puts(m, ": empty");
+	rcu_read_unlock();
 
 } /* end keyring_describe() */
 
 /*****************************************************************************/
 /*
  * read a list of key IDs from the keyring's contents
+ * - the keyring's semaphore is read-locked
  */
 static long keyring_read(const struct key *keyring,
 			 char __user *buffer, size_t buflen)
@@ -237,7 +253,7 @@ static long keyring_read(const struct ke
 	int loop, ret;
 
 	ret = 0;
-	klist = keyring->payload.subscriptions;
+	klist = rcu_dereference(keyring->payload.subscriptions);
 
 	if (klist) {
 		/* calculate how much data we could return */
@@ -320,7 +336,7 @@ struct key *keyring_search_aux(struct ke
 			       key_match_func_t match)
 {
 	struct {
-		struct key *keyring;
+		struct keyring_list *keylist;
 		int kix;
 	} stack[KEYRING_SEARCH_MAX_DEPTH];
 
@@ -328,10 +344,12 @@ struct key *keyring_search_aux(struct ke
 	struct timespec now;
 	struct key *key;
 	long err;
-	int sp, psp, kix;
+	int sp, kix;
 
 	key_check(keyring);
 
+	rcu_read_lock();
+
 	/* top keyring must have search permission to begin the search */
 	key = ERR_PTR(-EACCES);
 	if (!key_permission(keyring, KEY_SEARCH))
@@ -347,11 +365,10 @@ struct key *keyring_search_aux(struct ke
 
 	/* start processing a new keyring */
  descend:
-	read_lock(&keyring->lock);
-	if (keyring->flags & KEY_FLAG_REVOKED)
+	if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
 		goto not_this_keyring;
 
-	keylist = keyring->payload.subscriptions;
+	keylist = rcu_dereference(keyring->payload.subscriptions);
 	if (!keylist)
 		goto not_this_keyring;
 
@@ -364,7 +381,7 @@ struct key *keyring_search_aux(struct ke
 			continue;
 
 		/* skip revoked keys and expired keys */
-		if (key->flags & KEY_FLAG_REVOKED)
+		if (test_bit(KEY_FLAG_REVOKED, &key->flags))
 			continue;
 
 		if (key->expiry && now.tv_sec >= key->expiry)
@@ -379,7 +396,7 @@ struct key *keyring_search_aux(struct ke
 			continue;
 
 		/* we set a different error code if we find a negative key */
-		if (key->flags & KEY_FLAG_NEGATIVE) {
+		if (test_bit(KEY_FLAG_NEGATIVE, &key->flags)) {
 			err = -ENOKEY;
 			continue;
 		}
@@ -390,48 +407,37 @@ struct key *keyring_search_aux(struct ke
 	/* search through the keyrings nested in this one */
 	kix = 0;
  ascend:
-	while (kix < keylist->nkeys) {
+	for (; kix < keylist->nkeys; kix++) {
 		key = keylist->keys[kix];
 		if (key->type != &key_type_keyring)
-			goto next;
+			continue;
 
 		/* recursively search nested keyrings
 		 * - only search keyrings for which we have search permission
 		 */
 		if (sp >= KEYRING_SEARCH_MAX_DEPTH)
-			goto next;
+			continue;
 
 		if (!key_permission(key, KEY_SEARCH))
-			goto next;
-
-		/* evade loops in the keyring tree */
-		for (psp = 0; psp < sp; psp++)
-			if (stack[psp].keyring == keyring)
-				goto next;
+			continue;
 
 		/* stack the current position */
-		stack[sp].keyring = keyring;
+		stack[sp].keylist = keylist;
 		stack[sp].kix = kix;
 		sp++;
 
 		/* begin again with the new keyring */
 		keyring = key;
 		goto descend;
-
-	next:
-		kix++;
 	}
 
 	/* the keyring we're looking at was disqualified or didn't contain a
 	 * matching key */
  not_this_keyring:
-	read_unlock(&keyring->lock);
-
 	if (sp > 0) {
 		/* resume the processing of a keyring higher up in the tree */
 		sp--;
-		keyring = stack[sp].keyring;
-		keylist = keyring->payload.subscriptions;
+		keylist = stack[sp].keylist;
 		kix = stack[sp].kix + 1;
 		goto ascend;
 	}
@@ -442,16 +448,9 @@ struct key *keyring_search_aux(struct ke
 	/* we found a viable match */
  found:
 	atomic_inc(&key->usage);
-	read_unlock(&keyring->lock);
-
-	/* unwind the keyring stack */
-	while (sp > 0) {
-		sp--;
-		read_unlock(&stack[sp].keyring->lock);
-	}
-
 	key_check(key);
  error:
+	rcu_read_unlock();
 	return key;
 
 } /* end keyring_search_aux() */
@@ -489,7 +488,9 @@ struct key *__keyring_search_one(struct 
 	struct key *key;
 	int loop;
 
-	klist = keyring->payload.subscriptions;
+	rcu_read_lock();
+
+	klist = rcu_dereference(keyring->payload.subscriptions);
 	if (klist) {
 		for (loop = 0; loop < klist->nkeys; loop++) {
 			key = klist->keys[loop];
@@ -497,7 +498,7 @@ struct key *__keyring_search_one(struct 
 			if (key->type == ktype &&
 			    key->type->match(key, description) &&
 			    key_permission(key, perm) &&
-			    !(key->flags & KEY_FLAG_REVOKED)
+			    !test_bit(KEY_FLAG_REVOKED, &key->flags)
 			    )
 				goto found;
 		}
@@ -509,6 +510,7 @@ struct key *__keyring_search_one(struct 
  found:
 	atomic_inc(&key->usage);
  error:
+	rcu_read_unlock();
 	return key;
 
 } /* end __keyring_search_one() */
@@ -540,7 +542,7 @@ struct key *find_keyring_by_name(const c
 				    &keyring_name_hash[bucket],
 				    type_data.link
 				    ) {
-			if (keyring->flags & KEY_FLAG_REVOKED)
+			if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
 				continue;
 
 			if (strcmp(keyring->description, name) != 0)
@@ -579,7 +581,7 @@ struct key *find_keyring_by_name(const c
 static int keyring_detect_cycle(struct key *A, struct key *B)
 {
 	struct {
-		struct key *subtree;
+		struct keyring_list *keylist;
 		int kix;
 	} stack[KEYRING_SEARCH_MAX_DEPTH];
 
@@ -587,20 +589,21 @@ static int keyring_detect_cycle(struct k
 	struct key *subtree, *key;
 	int sp, kix, ret;
 
+	rcu_read_lock();
+
 	ret = -EDEADLK;
 	if (A == B)
-		goto error;
+		goto cycle_detected;
 
 	subtree = B;
 	sp = 0;
 
 	/* start processing a new keyring */
  descend:
-	read_lock(&subtree->lock);
-	if (subtree->flags & KEY_FLAG_REVOKED)
+	if (test_bit(KEY_FLAG_REVOKED, &subtree->flags))
 		goto not_this_keyring;
 
-	keylist = subtree->payload.subscriptions;
+	keylist = rcu_dereference(subtree->payload.subscriptions);
 	if (!keylist)
 		goto not_this_keyring;
 	kix = 0;
@@ -619,7 +622,7 @@ static int keyring_detect_cycle(struct k
 				goto too_deep;
 
 			/* stack the current position */
-			stack[sp].subtree = subtree;
+			stack[sp].keylist = keylist;
 			stack[sp].kix = kix;
 			sp++;
 
@@ -632,13 +635,10 @@ static int keyring_detect_cycle(struct k
 	/* the keyring we're looking at was disqualified or didn't contain a
 	 * matching key */
  not_this_keyring:
-	read_unlock(&subtree->lock);
-
 	if (sp > 0) {
 		/* resume the checking of a keyring higher up in the tree */
 		sp--;
-		subtree = stack[sp].subtree;
-		keylist = subtree->payload.subscriptions;
+		keylist = stack[sp].keylist;
 		kix = stack[sp].kix + 1;
 		goto ascend;
 	}
@@ -646,30 +646,36 @@ static int keyring_detect_cycle(struct k
 	ret = 0; /* no cycles detected */
 
  error:
+	rcu_read_unlock();
 	return ret;
 
  too_deep:
 	ret = -ELOOP;
-	goto error_unwind;
+	goto error;
+
  cycle_detected:
 	ret = -EDEADLK;
- error_unwind:
-	read_unlock(&subtree->lock);
-
-	/* unwind the keyring stack */
-	while (sp > 0) {
-		sp--;
-		read_unlock(&stack[sp].subtree->lock);
-	}
-
 	goto error;
 
 } /* end keyring_detect_cycle() */
 
 /*****************************************************************************/
 /*
+ * dispose of a keyring list after the RCU grace period
+ */
+static void keyring_link_rcu_disposal(struct rcu_head *rcu)
+{
+	struct keyring_list *klist =
+		container_of(rcu, struct keyring_list, rcu);
+
+	kfree(klist);
+
+} /* end keyring_link_rcu_disposal() */
+
+/*****************************************************************************/
+/*
  * link a key into to a keyring
- * - must be called with the keyring's semaphore held
+ * - must be called with the keyring's semaphore write-locked
  */
 int __key_link(struct key *keyring, struct key *key)
 {
@@ -679,7 +685,7 @@ int __key_link(struct key *keyring, stru
 	int ret;
 
 	ret = -EKEYREVOKED;
-	if (keyring->flags & KEY_FLAG_REVOKED)
+	if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
 		goto error;
 
 	ret = -ENOTDIR;
@@ -704,25 +710,31 @@ int __key_link(struct key *keyring, stru
 	if (ret < 0)
 		goto error2;
 
+	preempt_disable();
 	klist = keyring->payload.subscriptions;
 
 	if (klist && klist->nkeys < klist->maxkeys) {
 		/* there's sufficient slack space to add directly */
 		atomic_inc(&key->usage);
 
-		write_lock(&keyring->lock);
-		klist->keys[klist->nkeys++] = key;
-		write_unlock(&keyring->lock);
+		klist->keys[klist->nkeys] = key;
+		wmb();
+		klist->nkeys++;
+		preempt_enable();
 
 		ret = 0;
 	}
 	else {
+		preempt_enable();
+
 		/* grow the key list */
 		max = 4;
 		if (klist)
 			max += klist->maxkeys;
 
 		ret = -ENFILE;
+		if (max > 65535)
+			goto error3;
 		size = sizeof(*klist) + sizeof(*key) * max;
 		if (size > PAGE_SIZE)
 			goto error3;
@@ -743,14 +755,13 @@ int __key_link(struct key *keyring, stru
 
 		/* add the key into the new space */
 		atomic_inc(&key->usage);
-
-		write_lock(&keyring->lock);
-		keyring->payload.subscriptions = nklist;
 		nklist->keys[nklist->nkeys++] = key;
-		write_unlock(&keyring->lock);
+
+		rcu_assign_pointer(keyring->payload.subscriptions, nklist);
 
 		/* dispose of the old keyring list */
-		kfree(klist);
+		if (klist)
+			call_rcu(&klist->rcu, keyring_link_rcu_disposal);
 
 		ret = 0;
 	}
@@ -791,11 +802,26 @@ EXPORT_SYMBOL(key_link);
 
 /*****************************************************************************/
 /*
+ * dispose of a keyring list after the RCU grace period, freeing the unlinked
+ * key
+ */
+static void keyring_unlink_rcu_disposal(struct rcu_head *rcu)
+{
+	struct keyring_list *klist =
+		container_of(rcu, struct keyring_list, rcu);
+
+	key_put(klist->keys[klist->delkey]);
+	kfree(klist);
+
+} /* end keyring_unlink_rcu_disposal() */
+
+/*****************************************************************************/
+/*
  * unlink the first link to a key from a keyring
  */
 int key_unlink(struct key *keyring, struct key *key)
 {
-	struct keyring_list *klist;
+	struct keyring_list *klist, *nklist;
 	int loop, ret;
 
 	key_check(keyring);
@@ -819,31 +845,45 @@ int key_unlink(struct key *keyring, stru
 	ret = -ENOENT;
 	goto error;
 
- key_is_present:
+key_is_present:
+	/* we need to copy the key list for RCU purposes */
+	nklist = kmalloc(sizeof(*klist) + sizeof(*key) * klist->maxkeys,
+			 GFP_KERNEL);
+	if (!nklist)
+		goto nomem;
+	nklist->maxkeys = klist->maxkeys;
+	nklist->nkeys = klist->nkeys - 1;
+
+	if (loop > 0)
+		memcpy(&nklist->keys[0],
+		       &klist->keys[0],
+		       loop * sizeof(klist->keys[0]));
+
+	if (loop < nklist->nkeys)
+		memcpy(&nklist->keys[loop],
+		       &klist->keys[loop + 1],
+		       (nklist->nkeys - loop) * sizeof(klist->keys[0]));
+
 	/* adjust the user's quota */
 	key_payload_reserve(keyring,
 			    keyring->datalen - KEYQUOTA_LINK_BYTES);
 
-	/* shuffle down the key pointers
-	 * - it might be worth shrinking the allocated memory, but that runs
-	 *   the risk of ENOMEM as we would have to copy
-	 */
-	write_lock(&keyring->lock);
-
-	klist->nkeys--;
-	if (loop < klist->nkeys)
-		memcpy(&klist->keys[loop],
-		       &klist->keys[loop + 1],
-		       (klist->nkeys - loop) * sizeof(struct key *));
-
-	write_unlock(&keyring->lock);
+	rcu_assign_pointer(keyring->payload.subscriptions, nklist);
 
 	up_write(&keyring->sem);
-	key_put(key);
+
+	/* schedule for later cleanup */
+	klist->delkey = loop;
+	call_rcu(&klist->rcu, keyring_unlink_rcu_disposal);
+
 	ret = 0;
 
- error:
+error:
 	return ret;
+nomem:
+	ret = -ENOMEM;
+	up_write(&keyring->sem);
+	goto error;
 
 } /* end key_unlink() */
 
@@ -851,13 +891,32 @@ EXPORT_SYMBOL(key_unlink);
 
 /*****************************************************************************/
 /*
+ * dispose of a keyring list after the RCU grace period, releasing the keys it
+ * links to
+ */
+static void keyring_clear_rcu_disposal(struct rcu_head *rcu)
+{
+	struct keyring_list *klist;
+	int loop;
+
+	klist = container_of(rcu, struct keyring_list, rcu);
+
+	for (loop = klist->nkeys - 1; loop >= 0; loop--)
+		key_put(klist->keys[loop]);
+
+	kfree(klist);
+
+} /* end keyring_clear_rcu_disposal() */
+
+/*****************************************************************************/
+/*
  * clear the specified process keyring
  * - implements keyctl(KEYCTL_CLEAR)
  */
 int keyring_clear(struct key *keyring)
 {
 	struct keyring_list *klist;
-	int loop, ret;
+	int ret;
 
 	ret = -ENOTDIR;
 	if (keyring->type == &key_type_keyring) {
@@ -870,20 +929,15 @@ int keyring_clear(struct key *keyring)
 			key_payload_reserve(keyring,
 					    sizeof(struct keyring_list));
 
-			write_lock(&keyring->lock);
-			keyring->payload.subscriptions = NULL;
-			write_unlock(&keyring->lock);
+			rcu_assign_pointer(keyring->payload.subscriptions,
+					   NULL);
 		}
 
 		up_write(&keyring->sem);
 
 		/* free the keys after the locks have been dropped */
-		if (klist) {
-			for (loop = klist->nkeys - 1; loop >= 0; loop--)
-				key_put(klist->keys[loop]);
-
-			kfree(klist);
-		}
+		if (klist)
+			call_rcu(&klist->rcu, keyring_clear_rcu_disposal);
 
 		ret = 0;
 	}
diff -uNrp linux-2.6.11-mm2/security/keys/proc.c linux-2.6.11-mm2-keys-rcu/security/keys/proc.c
--- linux-2.6.11-mm2/security/keys/proc.c	2005-01-04 11:14:01.000000000 +0000
+++ linux-2.6.11-mm2-keys-rcu/security/keys/proc.c	2005-03-10 10:12:04.648783342 +0000
@@ -140,7 +140,7 @@ static int proc_keys_show(struct seq_fil
 
 	now = current_kernel_time();
 
-	read_lock(&key->lock);
+	rcu_read_lock();
 
 	/* come up with a suitable timeout value */
 	if (key->expiry == 0) {
@@ -164,14 +164,17 @@ static int proc_keys_show(struct seq_fil
 			sprintf(xbuf, "%luw", timo / (60*60*24*7));
 	}
 
+#define showflag(KEY, LETTER, FLAG) \
+	(test_bit(FLAG,	&(KEY)->flags) ? LETTER : '-')
+
 	seq_printf(m, "%08x %c%c%c%c%c%c %5d %4s %06x %5d %5d %-9.9s ",
 		   key->serial,
-		   key->flags & KEY_FLAG_INSTANTIATED	? 'I' : '-',
-		   key->flags & KEY_FLAG_REVOKED	? 'R' : '-',
-		   key->flags & KEY_FLAG_DEAD		? 'D' : '-',
-		   key->flags & KEY_FLAG_IN_QUOTA	? 'Q' : '-',
-		   key->flags & KEY_FLAG_USER_CONSTRUCT	? 'U' : '-',
-		   key->flags & KEY_FLAG_NEGATIVE	? 'N' : '-',
+		   showflag(key, 'I', KEY_FLAG_INSTANTIATED),
+		   showflag(key, 'R', KEY_FLAG_REVOKED),
+		   showflag(key, 'D', KEY_FLAG_DEAD),
+		   showflag(key, 'Q', KEY_FLAG_IN_QUOTA),
+		   showflag(key, 'U', KEY_FLAG_USER_CONSTRUCT),
+		   showflag(key, 'N', KEY_FLAG_NEGATIVE),
 		   atomic_read(&key->usage),
 		   xbuf,
 		   key->perm,
@@ -179,11 +182,13 @@ static int proc_keys_show(struct seq_fil
 		   key->gid,
 		   key->type->name);
 
+#undef showflag
+
 	if (key->type->describe)
 		key->type->describe(key, m);
 	seq_putc(m, '\n');
 
-	read_unlock(&key->lock);
+	rcu_read_unlock();
 
 	return 0;
 
diff -uNrp linux-2.6.11-mm2/security/keys/process_keys.c linux-2.6.11-mm2-keys-rcu/security/keys/process_keys.c
--- linux-2.6.11-mm2/security/keys/process_keys.c	2005-03-09 10:37:39.000000000 +0000
+++ linux-2.6.11-mm2-keys-rcu/security/keys/process_keys.c	2005-03-10 10:14:40.297966976 +0000
@@ -38,10 +38,9 @@ struct key root_user_keyring = {
 	.serial		= 2,
 	.type		= &key_type_keyring,
 	.user		= &root_key_user,
-	.lock		= RW_LOCK_UNLOCKED,
 	.sem		= __RWSEM_INITIALIZER(root_user_keyring.sem),
 	.perm		= KEY_USR_ALL,
-	.flags		= KEY_FLAG_INSTANTIATED,
+	.flags		= 1 << KEY_FLAG_INSTANTIATED,
 	.description	= "_uid.0",
 #ifdef KEY_DEBUGGING
 	.magic		= KEY_DEBUG_MAGIC,
@@ -54,10 +53,9 @@ struct key root_session_keyring = {
 	.serial		= 1,
 	.type		= &key_type_keyring,
 	.user		= &root_key_user,
-	.lock		= RW_LOCK_UNLOCKED,
 	.sem		= __RWSEM_INITIALIZER(root_session_keyring.sem),
 	.perm		= KEY_USR_ALL,
-	.flags		= KEY_FLAG_INSTANTIATED,
+	.flags		= 1 << KEY_FLAG_INSTANTIATED,
 	.description	= "_uid_ses.0",
 #ifdef KEY_DEBUGGING
 	.magic		= KEY_DEBUG_MAGIC,
@@ -349,9 +347,7 @@ void key_fsuid_changed(struct task_struc
 	/* update the ownership of the thread keyring */
 	if (tsk->thread_keyring) {
 		down_write(&tsk->thread_keyring->sem);
-		write_lock(&tsk->thread_keyring->lock);
 		tsk->thread_keyring->uid = tsk->fsuid;
-		write_unlock(&tsk->thread_keyring->lock);
 		up_write(&tsk->thread_keyring->sem);
 	}
 
@@ -366,9 +362,7 @@ void key_fsgid_changed(struct task_struc
 	/* update the ownership of the thread keyring */
 	if (tsk->thread_keyring) {
 		down_write(&tsk->thread_keyring->sem);
-		write_lock(&tsk->thread_keyring->lock);
 		tsk->thread_keyring->gid = tsk->fsgid;
-		write_unlock(&tsk->thread_keyring->lock);
 		up_write(&tsk->thread_keyring->sem);
 	}
 
@@ -588,7 +582,7 @@ struct key *lookup_user_key(key_serial_t
 	}
 
 	ret = -EIO;
-	if (!partial && !(key->flags & KEY_FLAG_INSTANTIATED))
+	if (!partial && !test_bit(KEY_FLAG_INSTANTIATED, &key->flags))
 		goto invalid_key;
 
 	ret = -EACCES;
diff -uNrp linux-2.6.11-mm2/security/keys/request_key.c linux-2.6.11-mm2-keys-rcu/security/keys/request_key.c
--- linux-2.6.11-mm2/security/keys/request_key.c	2005-03-09 10:37:39.000000000 +0000
+++ linux-2.6.11-mm2-keys-rcu/security/keys/request_key.c	2005-03-10 10:12:04.686780208 +0000
@@ -105,7 +105,7 @@ static struct key *__request_key_constru
 	struct key_construction cons;
 	struct timespec now;
 	struct key *key;
-	int ret, negative;
+	int ret, negated;
 
 	/* create a key and add it to the queue */
 	key = key_alloc(type, description,
@@ -113,9 +113,7 @@ static struct key *__request_key_constru
 	if (IS_ERR(key))
 		goto alloc_failed;
 
-	write_lock(&key->lock);
-	key->flags |= KEY_FLAG_USER_CONSTRUCT;
-	write_unlock(&key->lock);
+	set_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags);
 
 	cons.key = key;
 	list_add_tail(&cons.link, &key->user->consq);
@@ -130,7 +128,7 @@ static struct key *__request_key_constru
 
 	/* if the key wasn't instantiated, then we want to give an error */
 	ret = -ENOKEY;
-	if (!(key->flags & KEY_FLAG_INSTANTIATED))
+	if (!test_bit(KEY_FLAG_INSTANTIATED, &key->flags))
 		goto request_failed;
 
 	down_write(&key_construction_sem);
@@ -139,7 +137,7 @@ static struct key *__request_key_constru
 
 	/* also give an error if the key was negatively instantiated */
  check_not_negative:
-	if (key->flags & KEY_FLAG_NEGATIVE) {
+	if (test_bit(KEY_FLAG_NEGATIVE, &key->flags)) {
 		key_put(key);
 		key = ERR_PTR(-ENOKEY);
 	}
@@ -152,24 +150,23 @@ static struct key *__request_key_constru
 	 * - remove from construction queue
 	 * - mark the key as dead
 	 */
-	negative = 0;
+	negated = 0;
 	down_write(&key_construction_sem);
 
 	list_del(&cons.link);
 
-	write_lock(&key->lock);
-	key->flags &= ~KEY_FLAG_USER_CONSTRUCT;
-
 	/* check it didn't get instantiated between the check and the down */
-	if (!(key->flags & KEY_FLAG_INSTANTIATED)) {
-		key->flags |= KEY_FLAG_INSTANTIATED | KEY_FLAG_NEGATIVE;
-		negative = 1;
+	if (!test_bit(KEY_FLAG_INSTANTIATED, &key->flags)) {
+		set_bit(KEY_FLAG_NEGATIVE, &key->flags);
+		set_bit(KEY_FLAG_INSTANTIATED, &key->flags);
+		negated = 1;
 	}
 
-	write_unlock(&key->lock);
+	clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags);
+
 	up_write(&key_construction_sem);
 
-	if (!negative)
+	if (!negated)
 		goto check_not_negative; /* surprisingly, the key got
 					  * instantiated */
 
@@ -250,7 +247,7 @@ static struct key *request_key_construct
 
 	for (;;) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (!(ckey->flags & KEY_FLAG_USER_CONSTRUCT))
+		if (!test_bit(KEY_FLAG_USER_CONSTRUCT, &ckey->flags))
 			break;
 		schedule();
 	}
@@ -339,7 +336,8 @@ int key_validate(struct key *key)
 	if (key) {
 		/* check it's still accessible */
 		ret = -EKEYREVOKED;
-		if (key->flags & (KEY_FLAG_REVOKED | KEY_FLAG_DEAD))
+		if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
+		    test_bit(KEY_FLAG_DEAD, &key->flags))
 			goto error;
 
 		/* check it hasn't expired */
diff -uNrp linux-2.6.11-mm2/security/keys/user_defined.c linux-2.6.11-mm2-keys-rcu/security/keys/user_defined.c
--- linux-2.6.11-mm2/security/keys/user_defined.c	2005-01-04 11:14:01.000000000 +0000
+++ linux-2.6.11-mm2-keys-rcu/security/keys/user_defined.c	2005-03-10 11:48:52.070696850 +0000
@@ -42,12 +42,19 @@ struct key_type key_type_user = {
 	.read		= user_read,
 };
 
+struct user_key_payload {
+	struct rcu_head	rcu;		/* RCU destructor */
+	unsigned short	datalen;	/* length of this data */
+	char		data[0];	/* actual data */
+};
+
 /*****************************************************************************/
 /*
  * instantiate a user defined key
  */
 static int user_instantiate(struct key *key, const void *data, size_t datalen)
 {
+	struct user_key_payload *upayload;
 	int ret;
 
 	ret = -EINVAL;
@@ -58,13 +65,15 @@ static int user_instantiate(struct key *
 	if (ret < 0)
 		goto error;
 
-	/* attach the data */
 	ret = -ENOMEM;
-	key->payload.data = kmalloc(datalen, GFP_KERNEL);
-	if (!key->payload.data)
+	upayload = kmalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
+	if (!upayload)
 		goto error;
 
-	memcpy(key->payload.data, data, datalen);
+	/* attach the data */
+	upayload->datalen = datalen;
+	memcpy(upayload->data, data, datalen);
+	rcu_assign_pointer(key->payload.data, upayload);
 	ret = 0;
 
  error:
@@ -75,18 +84,25 @@ static int user_instantiate(struct key *
 /*****************************************************************************/
 /*
  * duplicate a user defined key
+ * - both keys' semaphores are locked against further modification
+ * - the new key cannot yet be accessed
  */
 static int user_duplicate(struct key *key, const struct key *source)
 {
+	struct user_key_payload *upayload, *spayload;
 	int ret;
 
 	/* just copy the payload */
 	ret = -ENOMEM;
-	key->payload.data = kmalloc(source->datalen, GFP_KERNEL);
+	upayload = kmalloc(sizeof(*upayload) + source->datalen, GFP_KERNEL);
+	if (upayload) {
+		spayload = rcu_dereference(source->payload.data);
+		BUG_ON(source->datalen != spayload->datalen);
 
-	if (key->payload.data) {
-		key->datalen = source->datalen;
-		memcpy(key->payload.data, source->payload.data, source->datalen);
+		upayload->datalen = key->datalen = spayload->datalen;
+		memcpy(upayload->data, spayload->data, key->datalen);
+
+		key->payload.data = upayload;
 		ret = 0;
 	}
 
@@ -96,40 +112,54 @@ static int user_duplicate(struct key *ke
 
 /*****************************************************************************/
 /*
+ * dispose of the old data from an updated user defined key
+ */
+static void user_update_rcu_disposal(struct rcu_head *rcu)
+{
+	struct user_key_payload *upayload;
+
+	upayload = container_of(rcu, struct user_key_payload, rcu);
+
+	kfree(upayload);
+
+} /* end user_update_rcu_disposal() */
+
+/*****************************************************************************/
+/*
  * update a user defined key
+ * - the key's semaphore is write-locked
  */
 static int user_update(struct key *key, const void *data, size_t datalen)
 {
-	void *new, *zap;
+	struct user_key_payload *upayload, *zap;
 	int ret;
 
 	ret = -EINVAL;
 	if (datalen <= 0 || datalen > 32767 || !data)
 		goto error;
 
-	/* copy the data */
+	/* construct a replacement payload */
 	ret = -ENOMEM;
-	new = kmalloc(datalen, GFP_KERNEL);
-	if (!new)
+	upayload = kmalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
+	if (!upayload)
 		goto error;
 
-	memcpy(new, data, datalen);
+	upayload->datalen = datalen;
+	memcpy(upayload->data, data, datalen);
 
 	/* check the quota and attach the new data */
-	zap = new;
-	write_lock(&key->lock);
+	zap = upayload;
 
 	ret = key_payload_reserve(key, datalen);
 
 	if (ret == 0) {
 		/* attach the new data, displacing the old */
 		zap = key->payload.data;
-		key->payload.data = new;
+		rcu_assign_pointer(key->payload.data, upayload);
 		key->expiry = 0;
 	}
 
-	write_unlock(&key->lock);
-	kfree(zap);
+	call_rcu(&zap->rcu, user_update_rcu_disposal);
 
  error:
 	return ret;
@@ -152,13 +182,15 @@ static int user_match(const struct key *
  */
 static void user_destroy(struct key *key)
 {
-	kfree(key->payload.data);
+	struct user_key_payload *upayload = key->payload.data;
+
+	kfree(upayload);
 
 } /* end user_destroy() */
 
 /*****************************************************************************/
 /*
- * describe the user
+ * describe the user key
  */
 static void user_describe(const struct key *key, struct seq_file *m)
 {
@@ -171,18 +203,23 @@ static void user_describe(const struct k
 /*****************************************************************************/
 /*
  * read the key data
+ * - the key's semaphore is read-locked
  */
 static long user_read(const struct key *key,
 		      char __user *buffer, size_t buflen)
 {
-	long ret = key->datalen;
+	struct user_key_payload *upayload;
+	long ret;
+
+	upayload = rcu_dereference(key->payload.data);
+	ret = upayload->datalen;
 
 	/* we can return the data as is */
 	if (buffer && buflen > 0) {
-		if (buflen > key->datalen)
-			buflen = key->datalen;
+		if (buflen > upayload->datalen)
+			buflen = upayload->datalen;
 
-		if (copy_to_user(buffer, key->payload.data, buflen) != 0)
+		if (copy_to_user(buffer, upayload->data, buflen) != 0)
 			ret = -EFAULT;
 	}
 
