Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTI0SWR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 14:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTI0SWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 14:22:17 -0400
Received: from smtp5.Stanford.EDU ([171.67.16.30]:47778 "EHLO
	smtp5.Stanford.EDU") by vger.kernel.org with ESMTP id S262139AbTI0SWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 14:22:09 -0400
Message-ID: <3F75D548.7060507@myrealbox.com>
Date: Sat, 27 Sep 2003 11:22:00 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b; MultiZilla v1.5.0.1) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC,PATCH] fix/change exec capabilities handling
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was briefly discussed in April '02 but it was never resolved.  Here goes my
shot at it :)

Currently, after successful execve(), a process' capabilities will be in one of
three states:

euid == 0 --> all caps permitted and effective
uid == 0 && euid != 0 --> all caps permitted but not effective
else --> no caps permitted or effective

The inheritable set is unchanged.  CAP_SETPCAP is an exception to the above
rules [FIXME]

This is bad for several reasons:
1. It can't be extended to support VFS capabilities.
2. It's (almost) impossible to restrict a process running as root, since that
process can exec() to get its capabilities back.
3. Only specially-written daemons can run with restricted capabilities, i.e. one
cannot usefully change capabilities then run something else.


I propose the following changes:

The new file-capability guessing rules are:
  inheritable = FULL
  permitted = (suid root ? FULL : EMPTY)
  effective = (suid nonroot ? EMPTY : FULL)

Any/all of these would be overridden by VFS capabilities once they are implemented.

The new evolution rules are:
  *  pP' = ( (pP & pI & fI) | fP ) & cap_bset
  *  pE' = ( pE | fP ) & fE & pP'
  *  pI' = <full>

Init now has all capabilities inheritable by default, the bounding set is set to
full, and CAP_SETPCAP no longer allows a thread to gain capabilites by calling
exec().

There is one corner case: a process with euid==0 && uid!=0 will lose all
permitted capabilities if it exec()s a setuid-nonroot executable.  This is
special-cased.


Why it is safe?

First, a note: "inheritable" no longer means that a capability will be inherited
even if it isn't already permitted.  That is because it seems to make more sense
that way, and because it is already possible to have inheritable, non-permitted
capabilities.

If no user code ever uses capability support, the new semantics correspond to
the expected behavior for a capability-less system.  That is, execve() preserves
the invariant that:
   inheritable = FULL
   permitted = (uid==0 || euid==0 ? cap_bset : EMPTY)
   effective = (euid==0 ? cap_bset : EMPTY)

Proof:
nonsuid: this is trivial (nothing changes across exec() if inheritable==FULL)

suid-root:
   uid==0, euid==0 --> no changes (the fP and fE masks have no effect)
   uid==0, euid!=0 --> effective set becomes full (correct)
   uid!=0, euid==0 --> this is equivalent to uid==0
   uid!=0, euid!=0 --> all capabilities (in bset) become permitted and effective
(correct)

suid-nonroot:
   uid==0, euid==0 --> effective becomes EMPTY (correct)
   uid==0, euid!=0 --> effective set forced EMPTY, but it already was
   uid!=0, euid!=0 --> effective set forced EMPTY, but it already was
   uid!=0, euid==0 --> _special case_ -- I handle this by forcing
                       fI=EMPTY.  This causes pP'=pE'=EMPTY, pI'=FULL,
                       which is correct
Q.E.D.  ;)
(The safely of this depends on the correctness of setxuid(), but that code is
unchanged and has been around for quite some time.  If it's broken, it's not the
fault of this patch...)

If user programs actually use capabilities, the situation is quite different.
First, this patch _increases_ safety by preventing euid==0||uid==0 processes
from increasing capabilities by calling execve().  For non-root processes with
increased capabilities, exec() now respects the inheritable mask but otherwise
changes nothing, unless the suid bit is set.  In this case, it still behaves
sensibly.

CAP_SETPCAP deserves special mention here.  The setcap function can be used as a
DoS easily, but so can many other things that privileged processes can do.  The
old semantic of allowing processes to execute processes with elevated
capabilities in one of their threads would be dangerous with this patch --
that's why I removed it.

Sanity:

Given the new inheritability semantics, it may make sense to allow processes to
make capabilities they don't have inheritable (using setcap -- exec does it
anyway).  This shouldn't matter much.

Once VFS capabilities go in (I may even code them later this month), they will
do what is expected.  fI != FULL restricts the capabilities the file is allowed
to have.  fP != EMPTY adds capabilities.  fE != FULL causes capabilities to be
non-effective (is this needed?).  The special case for
euid==0,uid!=0,suid-nonroot may be annoying, but I see no way around it --
security is more important.

Since exec() now does the Right Thing for limited-capability root processes and
non-zero-capability nonroot processes, it becomes possible (with some
as-yet-unwritted userspace tools) to give users extra capabilities.  For
example, a backup user could be given CAP_DAC_READ_SEARCH, and programs it runs
would keep that capability.

The attached patch (against 2.6.0-test5) makes these changes.  I tested it (RH9,
2.6.0-test5, sshd, smbd) with no apparent problems.  I ran a similar patch
against a stock RH9 kernel for several months, also with no problems.

A nice demonstration of this patch comes from SuSE's compartment tool, with
(slight) modifications.  It now works as expected, even with --cap and --user. I
posted it at http://www.stanford.edu/~luto/compartment.c


Please let me know what you think.  It would be nice to see this in 2.6, so that
VFS capabilities can be added soon.


--Andy Lutomirski (please CC me in any replies)

P.S. Does anyone know who maintains the capability LSM?  Otherwise, if there are
no serious complaints, I'll submit this to Linus.


--- linux/security/capability.c.orig    2003-09-08 12:50:01.000000000 -0700
+++ linux/security/capability.c    2003-09-26 21:07:52.337737739 -0700
@@ -22,6 +22,7 @@
  #include <linux/skbuff.h>
  #include <linux/netlink.h>
  #include <linux/ptrace.h>
+#include <linux/mount.h>

  int cap_capable (struct task_struct *tsk, int cap)
  {
@@ -89,28 +90,37 @@
  int cap_bprm_set_security (struct linux_binprm *bprm)
  {
      /* Copied from fs/exec.c:prepare_binprm. */
+    int setuid_nonroot = 0;

-    /* We don't have VFS support for capabilities yet */
-    cap_clear (bprm->cap_inheritable);
-    cap_clear (bprm->cap_permitted);
-    cap_clear (bprm->cap_effective);
-
-    /*  To support inheritance of root-permissions and suid-root
-     *  executables under compatibility mode, we raise all three
-     *  capability sets for the file.
-     *
-     *  If only the real uid is 0, we only raise the inheritable
-     *  and permitted sets of the executable file.
-     */
-
-    if (!issecure (SECURE_NOROOT)) {
-        if (bprm->e_uid == 0 || current->uid == 0) {
-            cap_set_full (bprm->cap_inheritable);
-            cap_set_full (bprm->cap_permitted);
+    /* File capabilities in absence of VFS support */
+    cap_set_full(bprm->cap_inheritable);
+    cap_clear(bprm->cap_permitted);
+    cap_set_full(bprm->cap_effective);
+
+    if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
+        /* Account for suid-ness */
+        if(bprm->file->f_dentry->d_inode->i_mode & S_ISUID
+         && !issecure(SECURE_NOROOT)) {
+            if(bprm->file->f_dentry->d_inode->i_uid == 0)
+                cap_set_full(bprm->cap_permitted);
+            else {
+                cap_clear(bprm->cap_effective);
+                setuid_nonroot = 1;
+            }
          }
-        if (bprm->e_uid == 0)
-            cap_set_full (bprm->cap_effective);
+
+        /* At this point, VFS capabilities should be applied. */
+
+        /* kludge: setuid-nonroot sometimes causes a loss of
+         * permitted capabilities.  It should be handled in
+         * cap_bprm_compute_creds, but that would require an
+         * extra field in the bprm.  This works identically.
+         */
+        if(setuid_nonroot && current->uid != 0 && current->euid == 0)
+            cap_clear(bprm->cap_inheritable);
      }
+
+
      return 0;
  }

@@ -120,15 +130,26 @@
      return (p->ptrace & PT_PTRACED) && !(p->ptrace & PT_PTRACE_CAP);
  }

+/*
+ * Evolution of capabilities:
+ *
+ *  pP' = ( (pP & pI & fI) | fP ) & cap_bset
+ *  pE' = ( pE | fP ) & fE & pP'
+ *  pI' = <full>
+ */
+
+
  void cap_bprm_compute_creds (struct linux_binprm *bprm)
  {
      /* Derived from fs/exec.c:compute_creds. */
-    kernel_cap_t new_permitted, working;
+    kernel_cap_t new_permitted;

-    new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
-    working = cap_intersect (bprm->cap_inheritable,
-                 current->cap_inheritable);
-    new_permitted = cap_combine (new_permitted, working);
+    new_permitted = cap_intersect (current->cap_permitted,
+     bprm->cap_inheritable);
+    new_permitted = cap_intersect (new_permitted,
+     current->cap_inheritable);
+    new_permitted = cap_combine (new_permitted, bprm->cap_permitted);
+    new_permitted = cap_intersect (new_permitted, cap_bset);

      task_lock(current);
      if (!cap_issubset (new_permitted, current->cap_permitted)) {
@@ -138,11 +159,8 @@
              || atomic_read (&current->fs->count) > 1
              || atomic_read (&current->files->count) > 1
              || atomic_read (&current->sighand->count) > 1) {
-            if (!capable (CAP_SETPCAP)) {
-                new_permitted = cap_intersect (new_permitted,
-                                   current->
-                                   cap_permitted);
-            }
+            new_permitted = cap_intersect(new_permitted,
+             current->cap_permitted);
          }
      }

@@ -150,9 +168,16 @@
       * in the init_task struct. Thus we skip the usual
       * capability rules */
      if (current->pid != 1) {
-        current->cap_permitted = new_permitted;
          current->cap_effective =
-            cap_intersect (new_permitted, bprm->cap_effective);
+            cap_combine(current->cap_effective,
+            bprm->cap_permitted);
+        current->cap_effective =
+            cap_intersect(current->cap_effective,
+            bprm->cap_effective);
+        current->cap_effective =
+            cap_intersect(current->cap_effective, new_permitted);
+        current->cap_permitted = new_permitted;
+        cap_set_full(current->cap_inheritable);
      }

      /* AUD: Audit candidate if current->cap_effective is set */
--- linux/kernel/capability.c.orig    2003-09-13 13:38:26.000000000 -0700
+++ linux/kernel/capability.c    2003-09-13 13:37:54.000000000 -0700
@@ -12,7 +12,7 @@
  #include <asm/uaccess.h>

  unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
-kernel_cap_t cap_bset = CAP_INIT_EFF_SET;
+kernel_cap_t cap_bset = CAP_DEFAULT_BSET;

  /*
   * This global lock protects task->cap_* for all tasks including current.
--- linux/include/linux/capability.h.orig    2003-09-13 13:38:43.0000 -0700
+++ linux/include/linux/capability.h    2003-09-13 13:37:12.000000000 -0700
@@ -309,7 +309,8 @@
  #define CAP_EMPTY_SET       to_cap_t(0)
  #define CAP_FULL_SET        to_cap_t(~0)
  #define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
-#define CAP_INIT_INH_SET    to_cap_t(0)
+#define CAP_INIT_INH_SET    CAP_FULL_SET
+#define CAP_DEFAULT_BSET    CAP_FULL_SET

  #define CAP_TO_MASK(x) (1 << (x))
  #define cap_raise(c, flag)   (cap_t(c) |=  CAP_TO_MASK(flag))





