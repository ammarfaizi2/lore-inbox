Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVDYRNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVDYRNc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 13:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVDYRNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 13:13:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51426 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262692AbVDYQxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 12:53:38 -0400
Date: Tue, 26 Apr 2005 00:57:05 +0800
From: David Teigland <teigland@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH 1a/7] dlm: core locking
Message-ID: <20050425165705.GA11938@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Apologies, patch 1 was too large on its own.]

The core dlm functions.  Processes dlm_lock() and dlm_unlock() requests.
Creates lockspaces which give applications separate contexts/namespaces in
which to do their locking.  Manages locks on resources' grant/convert/wait
queues.  Sends and receives high level locking operations between nodes.
Delivers completion and blocking callbacks (ast's) to lock holders.
Manages the distributed directory that tracks the current master node for
each resource.

Signed-Off-By: Dave Teigland <teigland@redhat.com>
Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>

---

 drivers/dlm/ast.c          |  166 +++++++++++++
 drivers/dlm/ast.h          |   26 ++
 drivers/dlm/dir.c          |  439 ++++++++++++++++++++++++++++++++++++
 drivers/dlm/dir.h          |   30 ++
 drivers/dlm/dlm_internal.h |  472 +++++++++++++++++++++++++++++++++++++++
 drivers/dlm/lock.h         |   38 +++
 drivers/dlm/lockspace.c    |  535 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dlm/lockspace.h    |   26 ++
 drivers/dlm/lvb_table.h    |   37 +++
 drivers/dlm/main.c         |   93 +++++++
 drivers/dlm/memory.c       |  135 +++++++++++
 drivers/dlm/memory.h       |   30 ++
 drivers/dlm/util.c         |  190 +++++++++++++++
 drivers/dlm/util.h         |   23 +
 include/linux/dlm.h        |  307 +++++++++++++++++++++++++
 15 files changed, 2547 insertions(+)

--- a/include/linux/dlm.h	1970-01-01 07:30:00.000000000 +0730
+++ b/include/linux/dlm.h	2005-04-25 22:52:03.790841992 +0800
@@ -0,0 +1,307 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
+**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+**
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#ifndef __DLM_DOT_H__
+#define __DLM_DOT_H__
+
+/*
+ * Interface to DLM - routines and structures to use DLM lockspaces.
+ */
+
+/*
+ * Lock Modes
+ */
+
+#define DLM_LOCK_IV            (-1)	/* invalid */
+#define DLM_LOCK_NL            (0)	/* null */
+#define DLM_LOCK_CR            (1)	/* concurrent read */
+#define DLM_LOCK_CW            (2)	/* concurrent write */
+#define DLM_LOCK_PR            (3)	/* protected read */
+#define DLM_LOCK_PW            (4)	/* protected write */
+#define DLM_LOCK_EX            (5)	/* exclusive */
+
+/*
+ * Maximum size in bytes of a dlm_lock name
+ */
+
+#define DLM_RESNAME_MAXLEN     (64)
+
+/*
+ * Size in bytes of Lock Value Block
+ */
+
+#define DLM_LVB_LEN            (32)
+
+/*
+ * Flags to dlm_lock
+ *
+ * DLM_LKF_NOQUEUE
+ *
+ * Do not queue the lock request on the wait queue if it cannot be granted
+ * immediately.  If the lock cannot be granted because of this flag, DLM will
+ * either return -EAGAIN from the dlm_lock call or will return 0 from
+ * dlm_lock and -EAGAIN in the lock status block when the AST is executed.
+ *
+ * DLM_LKF_CANCEL
+ *
+ * Used to cancel a pending lock request or conversion.  A converting lock is
+ * returned to its previously granted mode.
+ *
+ * DLM_LKF_CONVERT
+ *
+ * Indicates a lock conversion request.  For conversions the name and namelen
+ * are ignored and the lock ID in the LKSB is used to identify the lock.
+ *
+ * DLM_LKF_VALBLK
+ *
+ * Requests DLM to return the current contents of the lock value block in the
+ * lock status block.  When this flag is set in a lock conversion from PW or EX
+ * modes, DLM assigns the value specified in the lock status block to the lock
+ * value block of the lock resource.  The LVB is a DLM_LVB_LEN size array
+ * containing application-specific information.
+ *
+ * DLM_LKF_QUECVT
+ *
+ * Force a conversion request to be queued, even if it is compatible with
+ * the granted modes of other locks on the same resource.
+ *
+ * DLM_LKF_IVVALBLK
+ *
+ * Invalidate the lock value block.
+ *
+ * DLM_LKF_CONVDEADLK
+ *
+ * Allows the dlm to resolve conversion deadlocks internally by demoting the
+ * granted mode of a converting lock to NL.  The DLM_SBF_DEMOTED flag is
+ * returned for a conversion that's been effected by this.
+ *
+ * DLM_LKF_PERSISTENT
+ *
+ * Only relevant to locks originating in userspace.  A persistent lock will not
+ * be removed if the process holding the lock exits.
+ *
+ * DLM_LKF_NODLKWT
+ * DLM_LKF_NODLCKBLK
+ *
+ * net yet implemented
+ *
+ * DLM_LKF_EXPEDITE
+ *
+ * Used only with new requests for NL mode locks.  Tells the lock manager
+ * to grant the lock, ignoring other locks in convert and wait queues.
+ *
+ * DLM_LKF_NOQUEUEBAST
+ *
+ * Send blocking AST's before returning -EAGAIN to the caller.  It is only
+ * used along with the NOQUEUE flag.  Blocking AST's are not sent for failed
+ * NOQUEUE requests otherwise.
+ *
+ * DLM_LKF_HEADQUE
+ *
+ * Add a lock to the head of the convert or wait queue rather than the tail.
+ *
+ * DLM_LKF_NOORDER
+ *
+ * Disregard the standard grant order rules and grant a lock as soon as it
+ * is compatible with other granted locks.
+ *
+ * DLM_LKF_ORPHAN
+ *
+ * not yet implemented
+ *
+ * DLM_LKF_ALTPR
+ *
+ * If the requested mode cannot be granted immediately, try to grant the lock
+ * in PR mode instead.  If this alternate mode is granted instead of the
+ * requested mode, DLM_SBF_ALTMODE is returned in the lksb.
+ *
+ * DLM_LKF_ALTCW
+ *
+ * The same as ALTPR, but the alternate mode is CW.
+ */
+
+#define DLM_LKF_NOQUEUE        (0x00000001)
+#define DLM_LKF_CANCEL         (0x00000002)
+#define DLM_LKF_CONVERT        (0x00000004)
+#define DLM_LKF_VALBLK         (0x00000008)
+#define DLM_LKF_QUECVT         (0x00000010)
+#define DLM_LKF_IVVALBLK       (0x00000020)
+#define DLM_LKF_CONVDEADLK     (0x00000040)
+#define DLM_LKF_PERSISTENT     (0x00000080)
+#define DLM_LKF_NODLCKWT       (0x00000100)
+#define DLM_LKF_NODLCKBLK      (0x00000200)
+#define DLM_LKF_EXPEDITE       (0x00000400)
+#define DLM_LKF_NOQUEUEBAST    (0x00000800)
+#define DLM_LKF_HEADQUE        (0x00001000)
+#define DLM_LKF_NOORDER        (0x00002000)
+#define DLM_LKF_ORPHAN         (0x00004000)
+#define DLM_LKF_ALTPR          (0x00008000)
+#define DLM_LKF_ALTCW          (0x00010000)
+
+/*
+ * Some return codes that are not in errno.h
+ */
+
+#define DLM_ECANCEL            (0x10001)
+#define DLM_EUNLOCK            (0x10002)
+
+typedef void dlm_lockspace_t;
+
+/*
+ * Lock range structure
+ */
+
+struct dlm_range {
+	uint64_t ra_start;
+	uint64_t ra_end;
+};
+
+/*
+ * Lock status block
+ *
+ * Use this structure to specify the contents of the lock value block.  For a
+ * conversion request, this structure is used to specify the lock ID of the
+ * lock.  DLM writes the status of the lock request and the lock ID assigned
+ * to the request in the lock status block.
+ *
+ * sb_lkid: the returned lock ID.  It is set on new (non-conversion) requests.
+ * It is available when dlm_lock returns.
+ *
+ * sb_lvbptr: saves or returns the contents of the lock's LVB according to rules
+ * shown for the DLM_LKF_VALBLK flag.
+ *
+ * sb_flags: DLM_SBF_DEMOTED is returned if in the process of promoting a lock,
+ * it was first demoted to NL to avoid conversion deadlock.
+ * DLM_SBF_VALNOTVALID is returned if the resource's LVB is marked invalid.
+ *
+ * sb_status: the returned status of the lock request set prior to AST
+ * execution.  Possible return values:
+ *
+ * 0 if lock request was successful
+ * -EAGAIN if request would block and is flagged DLM_LKF_NOQUEUE
+ * -ENOMEM if there is no memory to process request
+ * -EINVAL if there are invalid parameters
+ * -DLM_EUNLOCK if unlock request was successful
+ * -DLM_ECANCEL if a cancel completed successfully
+ */
+
+#define DLM_SBF_DEMOTED        (0x01)
+#define DLM_SBF_VALNOTVALID    (0x02)
+#define DLM_SBF_ALTMODE        (0x04)
+
+struct dlm_lksb {
+	int 	 sb_status;
+	uint32_t sb_lkid;
+	char 	 sb_flags;
+	char *	 sb_lvbptr;
+};
+
+
+#ifdef __KERNEL__
+
+/*
+ * dlm_new_lockspace
+ *
+ * Starts a lockspace with the given name.  If the named lockspace exists in
+ * the cluster, the calling node joins it.
+ */
+
+int dlm_new_lockspace(char *name, int namelen, dlm_lockspace_t **lockspace,
+		      int flags);
+
+/*
+ * dlm_release_lockspace
+ *
+ * Stop a lockspace.
+ */
+
+int dlm_release_lockspace(dlm_lockspace_t *lockspace, int force);
+
+/*
+ * dlm_lock
+ *
+ * Make an asyncronous request to acquire or convert a lock on a named
+ * resource.
+ *
+ * lockspace: context for the request
+ * mode: the requested mode of the lock (DLM_LOCK_)
+ * lksb: lock status block for input and async return values
+ * flags: input flags (DLM_LKF_)
+ * name: name of the resource to lock, can be binary
+ * namelen: the length in bytes of the resource name (MAX_RESNAME_LEN)
+ * parent: the lock ID of a parent lock or 0 if none
+ * lockast: function DLM executes when it completes processing the request
+ * astarg: argument passed to lockast and bast functions
+ * bast: function DLM executes when this lock later blocks another request
+ *
+ * Returns:
+ * 0 if request is successfully queued for processing
+ * -EINVAL if any input parameters are invalid
+ * -EAGAIN if request would block and is flagged DLM_LKF_NOQUEUE
+ * -ENOMEM if there is no memory to process request
+ * -ENOTCONN if there is a communication error
+ *
+ * If the call to dlm_lock returns an error then the operation has failed and
+ * the AST routine will not be called.  If dlm_lock returns 0 it is still
+ * possible that the lock operation will fail. The AST routine will be called
+ * when the locking is complete and the status is returned in the lksb.
+ *
+ * If the AST routines or parameter are passed to a conversion operation then
+ * they will overwrite those values that were passed to a previous dlm_lock
+ * call.
+ *
+ * AST routines should not block (at least not for long), but may make
+ * any locking calls they please.
+ */
+
+int dlm_lock(dlm_lockspace_t *lockspace,
+	     int mode,
+	     struct dlm_lksb *lksb,
+	     uint32_t flags,
+	     void *name,
+	     unsigned int namelen,
+	     uint32_t parent_lkid,
+	     void (*lockast) (void *astarg),
+	     void *astarg,
+	     void (*bast) (void *astarg, int mode),
+	     struct dlm_range *range);
+
+/*
+ * dlm_unlock
+ *
+ * Asynchronously release a lock on a resource.  The AST routine is called
+ * when the resource is successfully unlocked.
+ *
+ * lockspace: context for the request
+ * lkid: the lock ID as returned in the lksb
+ * flags: input flags (DLM_LKF_)
+ * lksb: if NULL the lksb parameter passed to last lock request is used
+ * astarg: the arg used with the completion ast for the unlock
+ *
+ * Returns:
+ * 0 if request is successfully queued for processing
+ * -EINVAL if any input parameters are invalid
+ * -ENOTEMPTY if the lock still has sublocks
+ * -EBUSY if the lock is waiting for a remote lock operation
+ * -ENOTCONN if there is a communication error
+ */
+
+int dlm_unlock(dlm_lockspace_t *lockspace,
+	       uint32_t lkid,
+	       uint32_t flags,
+	       struct dlm_lksb *lksb,
+	       void *astarg);
+
+#endif				/* __KERNEL__ */
+
+#endif				/* __DLM_DOT_H__ */
--- a/drivers/dlm/dlm_internal.h	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/dlm_internal.h	2005-04-25 22:52:04.462739848 +0800
@@ -0,0 +1,472 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
+**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+**
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#ifndef __DLM_INTERNAL_DOT_H__
+#define __DLM_INTERNAL_DOT_H__
+
+/*
+ * This is the main header file to be included in each DLM source file.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <linux/ctype.h>
+#include <linux/spinlock.h>
+#include <linux/vmalloc.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/random.h>
+#include <linux/delay.h>
+#include <linux/socket.h>
+#include <linux/kthread.h>
+#include <linux/kobject.h>
+#include <linux/kref.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+#include <linux/dlm.h>
+
+#define DLM_LOCKSPACE_LEN	(64)
+#define DLM_TOSS_SECS		(10)
+#define DLM_SCAN_SECS		(5)
+
+#ifndef TRUE
+#define TRUE (1)
+#endif
+
+#ifndef FALSE
+#define FALSE (0)
+#endif
+
+#define MAX(a, b) (((a) > (b)) ? (a) : (b))
+
+#if (BITS_PER_LONG == 64)
+#define PRIx64 "lx"
+#else
+#define PRIx64 "Lx"
+#endif
+
+struct dlm_ls;
+struct dlm_lkb;
+struct dlm_rsb;
+struct dlm_member;
+struct dlm_lkbtable;
+struct dlm_rsbtable;
+struct dlm_dirtable;
+struct dlm_direntry;
+struct dlm_recover;
+struct dlm_header;
+struct dlm_message;
+struct dlm_rcom;
+struct dlm_mhandle;
+
+#define log_print(fmt, args...) printk("dlm: "fmt"\n", ##args)
+#define log_error(ls, fmt, args...) printk("dlm: %s: " fmt "\n", (ls)->ls_name, ##args)
+
+#ifdef CONFIG_DLM_DEBUG
+int dlm_create_debug_file(struct dlm_ls *ls);
+void dlm_delete_debug_file(struct dlm_ls *ls);
+#else
+static inline int dlm_create_debug_file(struct dlm_ls *ls) { return 0; }
+static inline void dlm_delete_debug_file(struct dlm_ls *ls) { }
+#endif
+
+#ifdef DLM_LOG_DEBUG
+#define log_debug(ls, fmt, args...) log_error(ls, fmt, ##args)
+#else
+#define log_debug(ls, fmt, args...)
+#endif
+
+#define DLM_ASSERT(x, do) \
+{ \
+  if (!(x)) \
+  { \
+    printk("\nDLM:  Assertion failed on line %d of file %s\n" \
+               "DLM:  assertion:  \"%s\"\n" \
+               "DLM:  time = %lu\n", \
+               __LINE__, __FILE__, #x, jiffies); \
+    {do} \
+    printk("\n"); \
+    BUG(); \
+    panic("DLM:  Record message above and reboot.\n"); \
+  } \
+}
+
+
+struct dlm_direntry {
+	struct list_head	list;
+	uint32_t		master_nodeid;
+	uint16_t		length;
+	char			name[1];
+};
+
+struct dlm_dirtable {
+	struct list_head	list;
+	rwlock_t		lock;
+};
+
+struct dlm_rsbtable {
+	struct list_head	list;
+	struct list_head	toss;
+	rwlock_t		lock;
+};
+
+struct dlm_lkbtable {
+	struct list_head	list;
+	rwlock_t		lock;
+	uint16_t		counter;
+};
+
+/*
+ * Lockspace member (per node in a ls)
+ */
+
+struct dlm_member {
+	struct list_head	list;
+	int			nodeid;
+	int			gone_event;
+};
+
+/*
+ * Save and manage recovery state for a lockspace.
+ */
+
+struct dlm_recover {
+	struct list_head	list;
+	int *			nodeids;
+	int			node_count;
+	int			event_id;
+};
+
+/*
+ * Pass input args to second stage locking function.
+ */
+
+struct dlm_args {
+	uint32_t		flags;
+	void *			astaddr;
+	long			astparam;
+	void *			bastaddr;
+	int			mode;
+	struct dlm_lksb *	lksb;
+	struct dlm_range *	range;
+};
+
+
+/*
+ * Lock block
+ *
+ * A lock can be one of three types:
+ *
+ * local copy      lock is mastered locally
+ *                 (lkb_nodeid is zero and DLM_LKF_MSTCPY is not set)
+ * process copy    lock is mastered on a remote node
+ *                 (lkb_nodeid is non-zero and DLM_LKF_MSTCPY is not set)
+ * master copy     master node's copy of a lock owned by remote node
+ *                 (lkb_nodeid is non-zero and DLM_LKF_MSTCPY is set)
+ *
+ * lkb_exflags: a copy of the most recent flags arg provided to dlm_lock or
+ * dlm_unlock.  The dlm does not modify these or use any private flags in
+ * this field; it only contains DLM_LKF_ flags from dlm.h.  These flags
+ * are sent as-is to the remote master when the lock is remote.
+ *
+ * lkb_flags: internal dlm flags (DLM_IFL_ prefix) from dlm_internal.h.
+ * Some internal flags are shared between the master and process nodes;
+ * these shared flags are kept in the lower two bytes.  One of these
+ * flags set on the master copy will be propagated to the process copy
+ * and v.v.  Other internal flags are private to the master or process
+ * node (e.g. DLM_IFL_MSTCPY).  These are kept in the high two bytes.
+ *
+ * lkb_sbflags: status block flags.  These flags are copied directly into
+ * the caller's lksb.sb_flags prior to the dlm_lock/dlm_unlock completion
+ * ast.  All defined in dlm.h with DLM_SBF_ prefix.
+ *
+ * lkb_status: the lock status indicates which rsb queue the lock is
+ * on, grant, convert, or wait.  DLM_LKSTS_ WAITING/GRANTED/CONVERT
+ *
+ * lkb_wait_type: the dlm message type (DLM_MSG_ prefix) for which a
+ * reply is needed.  Only set when the lkb is on the lockspace waiters
+ * list awaiting a reply from a remote node.
+ *
+ * lkb_nodeid: when the lkb is a local copy, nodeid is 0; when the lkb
+ * is a master copy, nodeid specifies the remote lock holder, when the
+ * lkb is a process copy, the nodeid specifies the lock master.
+ */
+
+/* lkb_ast_type */
+
+#define AST_COMP		(1)
+#define AST_BAST		(2)
+
+/* lkb_range[] */
+
+#define GR_RANGE_START		(0)
+#define GR_RANGE_END		(1)
+#define RQ_RANGE_START		(2)
+#define RQ_RANGE_END		(3)
+
+/* lkb_status */
+
+#define DLM_LKSTS_WAITING	(1)
+#define DLM_LKSTS_GRANTED	(2)
+#define DLM_LKSTS_CONVERT	(3)
+
+/* lkb_flags */
+
+#define DLM_IFL_MSTCPY		(0x00010000)
+#define DLM_IFL_RESEND		(0x00020000)
+#define DLM_IFL_RANGE		(0x00000001)
+
+struct dlm_lkb {
+	struct dlm_rsb *	lkb_resource;	/* the rsb */
+	struct kref		lkb_ref;
+	int			lkb_nodeid;	/* copied from rsb */
+	int			lkb_ownpid;	/* pid of lock owner */
+	uint32_t		lkb_id;		/* our lock ID */
+	uint32_t		lkb_remid;	/* lock ID on remote partner */
+	uint32_t		lkb_exflags;	/* external flags from caller */
+	uint32_t		lkb_sbflags;	/* lksb flags */
+	uint32_t		lkb_flags;	/* internal flags */
+	uint32_t		lkb_lvbseq;	/* lvb sequence number */
+
+	int8_t			lkb_status;     /* granted, waiting, convert */
+	int8_t			lkb_rqmode;	/* requested lock mode */
+	int8_t			lkb_grmode;	/* granted lock mode */
+	int8_t			lkb_bastmode;	/* requested mode */
+	int8_t			lkb_highbast;	/* highest mode bast sent for */
+
+	int8_t			lkb_wait_type;	/* type of reply waiting for */
+	int8_t			lkb_ast_type;	/* type of ast queued for */
+
+	struct list_head	lkb_idtbl_list;	/* lockspace lkbtbl */
+	struct list_head	lkb_statequeue;	/* rsb g/c/w list */
+	struct list_head	lkb_rsb_lookup;	/* waiting for rsb lookup */
+	struct list_head	lkb_wait_reply;	/* waiting for remote reply */
+	struct list_head	lkb_astqueue;	/* need ast to be sent */
+
+	uint64_t *		lkb_range;	/* array of gr/rq ranges */
+	char *			lkb_lvbptr;
+	struct dlm_lksb *       lkb_lksb;       /* caller's status block */
+	void *			lkb_astaddr;	/* caller's ast function */
+	void *			lkb_bastaddr;	/* caller's bast function */
+	long			lkb_astparam;	/* caller's ast arg */
+};
+
+
+/* find_rsb() flags */
+
+#define R_MASTER		(1)     /* create/add rsb if not found */
+#define R_CREATE		(2)     /* only return rsb if it's a master */
+
+#define RESFL_MASTER_WAIT	(0)
+#define RESFL_MASTER_UNCERTAIN	(1)
+#define RESFL_VALNOTVALID	(2)
+#define RESFL_VALNOTVALID_PREV	(3)
+#define RESFL_NEW_MASTER	(4)
+#define RESFL_NEW_MASTER2	(5)
+#define RESFL_RECOVER_CONVERT	(6)
+
+struct dlm_rsb {
+	struct dlm_ls *		res_ls;		/* the lockspace */
+	struct kref		res_ref;
+	struct semaphore	res_sem;
+	unsigned long		res_flags;	/* RESFL_ */
+	int			res_length;	/* length of rsb name */
+	int			res_nodeid;
+	uint32_t                res_lvbseq;
+	uint32_t		res_bucket;	/* rsbtbl */
+	unsigned long		res_toss_time;
+	uint32_t		res_trial_lkid;	/* lkb trying lookup result */
+	struct list_head	res_lookup;	/* lkbs waiting lookup confirm*/
+	struct list_head	res_hashchain;	/* rsbtbl */
+	struct list_head	res_grantqueue;
+	struct list_head	res_convertqueue;
+	struct list_head	res_waitqueue;
+
+	struct list_head	res_root_list;	    /* used for recovery */
+	struct list_head	res_recover_list;   /* used for recovery */
+	int			res_recover_locks_count;
+
+	char *			res_lvbptr;
+	char			res_name[1];
+};
+
+
+/* dlm_header is first element of all structs sent between nodes */
+
+#define DLM_HEADER_MAJOR	(0x00020000)
+#define DLM_HEADER_MINOR	(0x00000001)
+
+#define DLM_MSG			(1)
+#define DLM_RCOM		(2)
+
+struct dlm_header {
+	uint32_t		h_version;
+	uint32_t		h_lockspace;
+	uint32_t		h_nodeid;	/* nodeid of sender */
+	uint16_t		h_length;
+	uint8_t			h_cmd;		/* DLM_MSG, DLM_RCOM */
+	uint8_t			h_pad;
+};
+
+
+#define DLM_MSG_REQUEST		(1)
+#define DLM_MSG_CONVERT		(2)
+#define DLM_MSG_UNLOCK		(3)
+#define DLM_MSG_CANCEL		(4)
+#define DLM_MSG_REQUEST_REPLY	(5)
+#define DLM_MSG_CONVERT_REPLY	(6)
+#define DLM_MSG_UNLOCK_REPLY	(7)
+#define DLM_MSG_CANCEL_REPLY	(8)
+#define DLM_MSG_GRANT		(9)
+#define DLM_MSG_BAST		(10)
+#define DLM_MSG_LOOKUP		(11)
+#define DLM_MSG_REMOVE		(12)
+#define DLM_MSG_LOOKUP_REPLY	(13)
+
+struct dlm_message {
+	struct dlm_header	m_header;
+	uint32_t		m_type;		/* DLM_MSG_ */
+	uint32_t		m_nodeid;
+	uint32_t		m_pid;
+	uint32_t		m_lkid;		/* lkid on sender */
+	uint32_t		m_remid;	/* lkid on receiver */
+	uint32_t		m_parent_lkid;
+	uint32_t		m_parent_remid;
+	uint32_t		m_exflags;
+	uint32_t		m_sbflags;
+	uint32_t		m_flags;
+	uint32_t		m_lvbseq;
+	int			m_status;
+	int			m_grmode;
+	int			m_rqmode;
+	int			m_bastmode;
+	int			m_asts;
+	int			m_result;	/* 0 or -EXXX */
+	char			m_lvb[DLM_LVB_LEN];
+	uint64_t		m_range[2];
+	char			m_name[0];
+};
+
+
+#define DIR_VALID		(1)
+#define DIR_ALL_VALID		(2)
+#define NODES_VALID		(4)
+#define NODES_ALL_VALID		(8)
+
+#define DLM_RCOM_STATUS		(1)
+#define DLM_RCOM_NAMES		(2)
+#define DLM_RCOM_LOOKUP		(3)
+#define DLM_RCOM_LOCK		(4)
+#define DLM_RCOM_STATUS_REPLY	(5)
+#define DLM_RCOM_NAMES_REPLY	(6)
+#define DLM_RCOM_LOOKUP_REPLY	(7)
+#define DLM_RCOM_LOCK_REPLY	(8)
+
+struct dlm_rcom {
+	struct dlm_header	rc_header;
+	uint32_t		rc_type;	/* DLM_RCOM_ */
+	int			rc_result;	/* multi-purpose */
+	uint64_t		rc_id;		/* match reply with request */
+	char			rc_buf[0];
+};
+
+
+#define LSST_NONE		(0)
+#define LSST_INIT		(1)
+#define LSST_INIT_DONE		(2)
+#define LSST_CLEAR		(3)
+#define LSST_WAIT_START		(4)
+#define LSST_RECONFIG_DONE	(5)
+
+#define LSFL_WORK		(0)
+#define LSFL_LS_RUN		(1)
+#define LSFL_LS_STOP		(2)
+#define LSFL_LS_START		(3)
+#define LSFL_LS_FINISH		(4)
+#define LSFL_RCOM_READY		(5)
+#define LSFL_FINISH_RECOVERY	(6)
+#define LSFL_DIR_VALID		(7)
+#define LSFL_ALL_DIR_VALID	(8)
+#define LSFL_NODES_VALID	(9)
+#define LSFL_ALL_NODES_VALID	(10)
+#define LSFL_LS_TERMINATE	(11)
+#define LSFL_JOIN_DONE		(12)
+#define LSFL_LEAVE_DONE		(13)
+
+struct dlm_ls {
+	struct list_head	ls_list;	/* list of lockspaces */
+	uint32_t		ls_global_id;	/* global unique lockspace ID */
+	int			ls_count;	/* reference count */
+	unsigned long		ls_flags;	/* LSFL_ */
+	struct kobject		ls_kobj;
+
+	struct dlm_rsbtable *	ls_rsbtbl;
+	uint32_t		ls_rsbtbl_size;
+
+	struct dlm_lkbtable *	ls_lkbtbl;
+	uint32_t		ls_lkbtbl_size;
+
+	struct dlm_dirtable *	ls_dirtbl;
+	uint32_t		ls_dirtbl_size;
+
+	struct semaphore	ls_waiters_sem;
+	struct list_head	ls_waiters;	/* lkbs needing a reply */
+
+	struct list_head	ls_nodes;	/* current nodes in ls */
+	struct list_head	ls_nodes_gone;	/* dead node list, recovery */
+	int			ls_num_nodes;	/* number of nodes in ls */
+	int			ls_low_nodeid;
+	int *			ls_node_array;
+	int *			ls_nodeids_next;
+	int			ls_nodeids_next_count;
+
+	struct dlm_rsb		ls_stub_rsb;	/* for returning errors */
+	struct dlm_lkb		ls_stub_lkb;	/* for returning errors */
+	struct dlm_message	ls_stub_ms;	/* for faking a reply */
+
+	struct dentry *		ls_debug_dentry;/* debugfs */
+
+	/* recovery related */
+
+	wait_queue_head_t	ls_wait_member;
+	struct task_struct *	ls_recoverd_task;
+	struct semaphore	ls_recoverd_active;
+	struct list_head	ls_recover;	/* dlm_recover structs */
+	spinlock_t		ls_recover_lock;
+	int			ls_last_stop;
+	int			ls_last_start;
+	int			ls_last_finish;
+	int			ls_startdone;
+	int			ls_state;	/* recovery states */
+
+	struct rw_semaphore	ls_in_recovery;	/* block local requests */
+	struct list_head	ls_requestqueue;/* queue remote requests */
+	struct semaphore	ls_requestqueue_lock;
+	char *			ls_recover_buf;
+	struct list_head	ls_recover_list;
+	spinlock_t		ls_recover_list_lock;
+	int			ls_recover_list_count;
+	wait_queue_head_t	ls_wait_general;
+
+	struct list_head	ls_root_list;	/* root resources */
+	struct rw_semaphore	ls_root_sem;	/* protect root_list */
+
+	int			ls_namelen;
+	char			ls_name[1];
+};
+
+
+#endif				/* __DLM_INTERNAL_DOT_H__ */
--- a/drivers/dlm/lvb_table.h	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/lvb_table.h	2005-04-25 22:52:03.985812352 +0800
@@ -0,0 +1,37 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
+**  
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#ifndef __LVB_TABLE_DOT_H__
+#define __LVB_TABLE_DOT_H__
+
+/*
+ * This defines the direction of transfer of LVB data.
+ * Granted mode is the row; requested mode is the column.
+ * Usage: matrix[grmode+1][rqmode+1]
+ * 1 = LVB is returned to the caller
+ * 0 = LVB is written to the resource
+ * -1 = nothing happens to the LVB
+ */
+
+const int dlm_lvb_operations[8][8] = {
+        /* UN   NL  CR  CW  PR  PW  EX  PD*/
+        {  -1,  1,  1,  1,  1,  1,  1, -1 }, /* UN */
+        {  -1,  1,  1,  1,  1,  1,  1,  0 }, /* NL */
+        {  -1, -1,  1,  1,  1,  1,  1,  0 }, /* CR */
+        {  -1, -1, -1,  1,  1,  1,  1,  0 }, /* CW */
+        {  -1, -1, -1, -1,  1,  1,  1,  0 }, /* PR */
+        {  -1,  0,  0,  0,  0,  0,  1,  0 }, /* PW */
+        {  -1,  0,  0,  0,  0,  0,  0,  0 }, /* EX */
+        {  -1,  0,  0,  0,  0,  0,  0,  0 }  /* PD */
+};
+
+#endif
--- a/drivers/dlm/ast.c	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/ast.c	2005-04-25 22:52:03.713853696 +0800
@@ -0,0 +1,166 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
+**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+**  
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#include "dlm_internal.h"
+#include "lock.h"
+
+#define WAKE_ASTS  0
+
+static struct list_head		ast_queue;
+static struct semaphore		ast_queue_lock;
+static struct task_struct *	astd_task;
+static unsigned long		astd_wakeflags;
+static struct semaphore		astd_running;
+
+
+void dlm_del_ast(struct dlm_lkb *lkb)
+{
+	down(&ast_queue_lock);
+	if (lkb->lkb_ast_type & (AST_COMP | AST_BAST))
+		list_del(&lkb->lkb_astqueue);
+	up(&ast_queue_lock);
+}
+
+void dlm_add_ast(struct dlm_lkb *lkb, int type)
+{
+	down(&ast_queue_lock);
+	if (!(lkb->lkb_ast_type & (AST_COMP | AST_BAST))) {
+		kref_get(&lkb->lkb_ref);
+		list_add_tail(&lkb->lkb_astqueue, &ast_queue);
+	}
+	lkb->lkb_ast_type |= type;
+	up(&ast_queue_lock);
+
+	set_bit(WAKE_ASTS, &astd_wakeflags);
+	wake_up_process(astd_task);
+}
+
+static void process_asts(void)
+{
+	struct dlm_ls *ls = NULL;
+	struct dlm_rsb *r = NULL;
+	struct dlm_lkb *lkb;
+	void (*cast) (long param);
+	void (*bast) (long param, int mode);
+	int type = 0, found, bmode;
+
+	for (;;) {
+		found = FALSE;
+		down(&ast_queue_lock);
+		list_for_each_entry(lkb, &ast_queue, lkb_astqueue) {
+			r = lkb->lkb_resource;
+			ls = r->res_ls;
+
+			if (!test_bit(LSFL_LS_RUN, &ls->ls_flags))
+				continue;
+
+			list_del(&lkb->lkb_astqueue);
+			type = lkb->lkb_ast_type;
+			lkb->lkb_ast_type = 0;
+			found = TRUE;
+			break;
+		}
+		up(&ast_queue_lock);
+
+		if (!found)
+			break;
+
+		cast = lkb->lkb_astaddr;
+		bast = lkb->lkb_bastaddr;
+		bmode = lkb->lkb_bastmode;
+
+		if ((type & AST_COMP) && cast)
+			cast(lkb->lkb_astparam);
+
+		/* FIXME: Is it safe to look at lkb_grmode here
+		   without doing a lock_rsb() ?
+		   Look at other checks in v1 to avoid basts. */
+
+		if ((type & AST_BAST) && bast)
+			if (!dlm_modes_compat(lkb->lkb_grmode, bmode))
+				bast(lkb->lkb_astparam, bmode);
+
+		/* this removes the reference added by dlm_add_ast
+		   and may result in the lkb being freed */
+		dlm_put_lkb(lkb);
+
+		schedule();
+	}
+}
+
+static inline int no_asts(void)
+{
+	int ret;
+
+	down(&ast_queue_lock);
+	ret = list_empty(&ast_queue);
+	up(&ast_queue_lock);
+	return ret;
+}
+
+static int dlm_astd(void *data)
+{
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (!test_bit(WAKE_ASTS, &astd_wakeflags))
+			schedule();
+		set_current_state(TASK_RUNNING);
+
+		down(&astd_running);
+		if (test_and_clear_bit(WAKE_ASTS, &astd_wakeflags))
+			process_asts();
+		up(&astd_running);
+	}
+	return 0;
+}
+
+void dlm_astd_wake(void)
+{
+	if (!no_asts()) {
+		set_bit(WAKE_ASTS, &astd_wakeflags);
+		wake_up_process(astd_task);
+	}
+}
+
+int dlm_astd_start(void)
+{
+	struct task_struct *p;
+	int error = 0;
+
+	INIT_LIST_HEAD(&ast_queue);
+	init_MUTEX(&ast_queue_lock);
+	init_MUTEX(&astd_running);
+
+	p = kthread_run(dlm_astd, NULL, "dlm_astd");
+	if (IS_ERR(p))
+		error = PTR_ERR(p);
+	else
+		astd_task = p;
+	return error;
+}
+
+void dlm_astd_stop(void)
+{
+	kthread_stop(astd_task);
+}
+
+void dlm_astd_suspend(void)
+{
+	down(&astd_running);
+}
+
+void dlm_astd_resume(void)
+{
+	up(&astd_running);
+}
+
--- a/drivers/dlm/ast.h	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/ast.h	2005-04-25 22:52:03.720852632 +0800
@@ -0,0 +1,26 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
+**  
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#ifndef __ASTD_DOT_H__
+#define __ASTD_DOT_H__
+
+void dlm_add_ast(struct dlm_lkb *lkb, int type);
+void dlm_del_ast(struct dlm_lkb *lkb);
+
+void dlm_astd_wake(void);
+int dlm_astd_start(void);
+void dlm_astd_stop(void);
+void dlm_astd_suspend(void);
+void dlm_astd_resume(void);
+
+#endif
+
--- a/drivers/dlm/dir.c	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/dir.c	2005-04-25 22:52:03.778843816 +0800
@@ -0,0 +1,439 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
+**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+**  
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#include "dlm_internal.h"
+#include "lockspace.h"
+#include "member.h"
+#include "lowcomms.h"
+#include "rcom.h"
+#include "config.h"
+#include "memory.h"
+#include "recover.h"
+#include "util.h"
+#include "lock.h"
+
+
+static void put_free_de(struct dlm_ls *ls, struct dlm_direntry *de)
+{
+	spin_lock(&ls->ls_recover_list_lock);
+	list_add(&de->list, &ls->ls_recover_list);
+	spin_unlock(&ls->ls_recover_list_lock);
+}
+
+static struct dlm_direntry *get_free_de(struct dlm_ls *ls, int len)
+{
+	int found = FALSE;
+	struct dlm_direntry *de;
+
+	spin_lock(&ls->ls_recover_list_lock);
+	list_for_each_entry(de, &ls->ls_recover_list, list) {
+		if (de->length == len) {
+			list_del(&de->list);
+			de->master_nodeid = 0;
+			memset(de->name, 0, len);
+			found = TRUE;
+			break;
+		}
+	}
+	spin_unlock(&ls->ls_recover_list_lock);
+
+	if (!found)
+		de = allocate_direntry(ls, len);
+	return de;
+}
+
+void dlm_clear_free_entries(struct dlm_ls *ls)
+{
+	struct dlm_direntry *de;
+
+	spin_lock(&ls->ls_recover_list_lock);
+	while (!list_empty(&ls->ls_recover_list)) {
+		de = list_entry(ls->ls_recover_list.next, struct dlm_direntry,
+				list);
+		list_del(&de->list);
+		free_direntry(de);
+	}
+	spin_unlock(&ls->ls_recover_list_lock);
+}
+
+/* 
+ * We use the upper 16 bits of the hash value to select the directory node.
+ * Low bits are used for distribution of rsb's among hash buckets on each node.
+ *
+ * To give the exact range wanted (0 to num_nodes-1), we apply a modulus of
+ * num_nodes to the hash value.  This value in the desired range is used as an
+ * offset into the sorted list of nodeid's to give the particular nodeid of the
+ * directory node.
+ */
+
+int dlm_dir_name2nodeid(struct dlm_ls *ls, char *name, int length)
+{
+	struct list_head *tmp;
+	struct dlm_member *memb = NULL;
+	uint32_t hash, node, n = 0;
+	int nodeid;
+
+	if (ls->ls_num_nodes == 1) {
+		nodeid = dlm_our_nodeid();
+		goto out;
+	}
+
+	hash = dlm_hash(name, length);
+	node = (hash >> 16) % ls->ls_num_nodes;
+
+	if (ls->ls_node_array) {
+		nodeid = ls->ls_node_array[node];
+		goto out;
+	}
+
+	list_for_each(tmp, &ls->ls_nodes) {
+		if (n++ != node)
+			continue;
+		memb = list_entry(tmp, struct dlm_member, list);
+		break;
+	}
+
+	DLM_ASSERT(memb , printk("num_nodes=%u n=%u node=%u\n",
+				 ls->ls_num_nodes, n, node););
+	nodeid = memb->nodeid;
+ out:
+	return nodeid;
+}
+
+int dlm_dir_nodeid(struct dlm_rsb *rsb)
+{
+	return dlm_dir_name2nodeid(rsb->res_ls, rsb->res_name, rsb->res_length);
+}
+
+static inline uint32_t dir_hash(struct dlm_ls *ls, char *name, int len)
+{
+	uint32_t val;
+
+	val = dlm_hash(name, len);
+	val &= (ls->ls_dirtbl_size - 1);
+
+	return val;
+}
+
+static void add_entry_to_hash(struct dlm_ls *ls, struct dlm_direntry *de)
+{
+	uint32_t bucket;
+
+	bucket = dir_hash(ls, de->name, de->length);
+	list_add_tail(&de->list, &ls->ls_dirtbl[bucket].list);
+}
+
+static struct dlm_direntry *search_bucket(struct dlm_ls *ls, char *name,
+					  int namelen, uint32_t bucket)
+{
+	struct dlm_direntry *de;
+
+	list_for_each_entry(de, &ls->ls_dirtbl[bucket].list, list) {
+		if (de->length == namelen && !memcmp(name, de->name, namelen))
+			goto out;
+	}
+	de = NULL;
+ out:
+	return de;
+}
+
+void dlm_dir_remove_entry(struct dlm_ls *ls, int nodeid, char *name, int namelen)
+{
+	struct dlm_direntry *de;
+	uint32_t bucket;
+
+	bucket = dir_hash(ls, name, namelen);
+
+	write_lock(&ls->ls_dirtbl[bucket].lock);
+
+	de = search_bucket(ls, name, namelen, bucket);
+
+	if (!de) {
+		log_error(ls, "remove fr %u none", nodeid);
+		goto out;
+	}
+
+	if (de->master_nodeid != nodeid) {
+		log_error(ls, "remove fr %u ID %u", nodeid, de->master_nodeid);
+		goto out;
+	}
+
+	list_del(&de->list);
+	free_direntry(de);
+ out:
+	write_unlock(&ls->ls_dirtbl[bucket].lock);
+}
+
+void dlm_dir_clear(struct dlm_ls *ls)
+{
+	struct list_head *head;
+	struct dlm_direntry *de;
+	int i;
+
+	DLM_ASSERT(list_empty(&ls->ls_recover_list), );
+
+	for (i = 0; i < ls->ls_dirtbl_size; i++) {
+		write_lock(&ls->ls_dirtbl[i].lock);
+		head = &ls->ls_dirtbl[i].list;
+		while (!list_empty(head)) {
+			de = list_entry(head->next, struct dlm_direntry, list);
+			list_del(&de->list);
+			put_free_de(ls, de);
+		}
+		write_unlock(&ls->ls_dirtbl[i].lock);
+	}
+}
+
+int dlm_recover_directory(struct dlm_ls *ls)
+{
+	struct dlm_member *memb;
+	struct dlm_direntry *de;
+	char *b, *last_name;
+	int error = -ENOMEM, last_len, count = 0;
+	uint16_t namelen;
+
+	log_debug(ls, "dlm_recover_directory");
+
+	dlm_dir_clear(ls);
+
+	last_name = kmalloc(DLM_RESNAME_MAXLEN, GFP_KERNEL);
+	if (!last_name)
+		goto out;
+
+	list_for_each_entry(memb, &ls->ls_nodes, list) {
+		memset(last_name, 0, DLM_RESNAME_MAXLEN);
+		last_len = 0;
+
+		for (;;) {
+			error = dlm_recovery_stopped(ls);
+			if (error)
+				goto free_last;
+
+			error = dlm_rcom_names(ls, memb->nodeid,
+					       last_name, last_len);
+			if (error)
+				goto free_last;
+
+			schedule();
+
+			/* 
+			 * pick namelen/name pairs out of received buffer
+			 */
+
+			b = ls->ls_recover_buf + sizeof(struct dlm_rcom);
+
+			for (;;) {
+				memcpy(&namelen, b, sizeof(uint16_t));
+				namelen = be16_to_cpu(namelen);
+				b += sizeof(uint16_t);
+
+				/* namelen of 0xFFFFF marks end of names for
+				   this node; namelen of 0 marks end of the
+				   buffer */
+
+				if (namelen == 0xFFFF)
+					goto done;
+				if (!namelen)
+					break;
+
+				error = -ENOMEM;
+				de = get_free_de(ls, namelen);
+				if (!de)
+					goto free_last;
+
+				de->master_nodeid = memb->nodeid;
+				de->length = namelen;
+				last_len = namelen;
+				memcpy(de->name, b, namelen);
+				memcpy(last_name, b, namelen);
+				b += namelen;
+
+				add_entry_to_hash(ls, de);
+				count++;
+			}
+		}
+         done:
+		;
+	}
+
+	set_bit(LSFL_DIR_VALID, &ls->ls_flags);
+	error = 0;
+
+	log_debug(ls, "dlm_recover_directory %d entries", count);
+
+ free_last:
+	kfree(last_name);
+ out:
+	dlm_clear_free_entries(ls);
+	return error;
+}
+
+static int get_entry(struct dlm_ls *ls, int nodeid, char *name,
+		     int namelen, int *r_nodeid)
+{
+	struct dlm_direntry *de, *tmp;
+	uint32_t bucket;
+
+	bucket = dir_hash(ls, name, namelen);
+
+	write_lock(&ls->ls_dirtbl[bucket].lock);
+	de = search_bucket(ls, name, namelen, bucket);
+	if (de) {
+		*r_nodeid = de->master_nodeid;
+		write_unlock(&ls->ls_dirtbl[bucket].lock);
+		if (*r_nodeid == nodeid)
+			return -EEXIST;
+		return 0;
+	}
+
+	write_unlock(&ls->ls_dirtbl[bucket].lock);
+
+	de = allocate_direntry(ls, namelen);
+	if (!de)
+		return -ENOMEM;
+
+	de->master_nodeid = nodeid;
+	de->length = namelen;
+	memcpy(de->name, name, namelen);
+
+	write_lock(&ls->ls_dirtbl[bucket].lock);
+	tmp = search_bucket(ls, name, namelen, bucket);
+	if (tmp) {
+		free_direntry(de);
+		de = tmp;
+	} else {
+		list_add_tail(&de->list, &ls->ls_dirtbl[bucket].list);
+	}
+	*r_nodeid = de->master_nodeid;
+	write_unlock(&ls->ls_dirtbl[bucket].lock);
+	return 0;
+}
+
+int dlm_dir_lookup(struct dlm_ls *ls, int nodeid, char *name, int namelen,
+		   int *r_nodeid)
+{
+	return get_entry(ls, nodeid, name, namelen, r_nodeid);
+}
+
+/* 
+ * The node with lowest id queries all nodes to determine when all are done.
+ * All other nodes query the low nodeid for this.
+ */
+
+int dlm_dir_rebuild_wait(struct dlm_ls *ls)
+{
+	int error;
+
+	if (ls->ls_low_nodeid == dlm_our_nodeid()) {
+		error = dlm_wait_status_all(ls, DIR_VALID);
+		if (!error)
+			set_bit(LSFL_ALL_DIR_VALID, &ls->ls_flags);
+	} else
+		error = dlm_wait_status_low(ls, DIR_ALL_VALID);
+
+	return error;
+}
+
+/* Copy the names of master rsb's into the buffer provided.
+   Only select names whose dir node is the given nodeid. */
+
+int dlm_copy_master_names(struct dlm_ls *ls, char *inbuf, int inlen,
+			  char *outbuf, int outlen, int nodeid)
+{
+	struct list_head *list;
+	struct dlm_rsb *start_r = NULL, *r = NULL;
+	int offset = 0, start_namelen, error, dir_nodeid;
+	char *start_name;
+	uint16_t be_namelen;
+
+	/*
+	 * Find the rsb where we left off (or start again)
+	 */
+
+	start_namelen = inlen;
+	start_name = inbuf;
+
+	if (start_namelen > 1) {
+		/*
+		 * We could also use a find_rsb_root() function here that
+		 * searched the ls_root_list.
+		 */
+		error = dlm_find_rsb(ls, start_name, start_namelen, R_MASTER,
+				     &start_r);
+		DLM_ASSERT(!error && start_r,
+			   printk("error %d\n", error););
+		DLM_ASSERT(!list_empty(&start_r->res_root_list),
+			   dlm_print_rsb(start_r););
+		dlm_put_rsb(start_r);
+	}
+
+	/* 
+	 * Send rsb names for rsb's we're master of and whose directory node
+	 * matches the requesting node.
+	 */
+
+	down_read(&ls->ls_root_sem);
+	if (start_r)
+		list = start_r->res_root_list.next;
+	else
+		list = ls->ls_root_list.next;
+
+	for (offset = 0; list != &ls->ls_root_list; list = list->next) {
+		r = list_entry(list, struct dlm_rsb, res_root_list);
+		if (r->res_nodeid)
+			continue;
+
+		dir_nodeid = dlm_dir_nodeid(r);
+		if (dir_nodeid != nodeid)
+			continue;
+		
+		/*
+		 * The block ends when we can't fit the following in the
+		 * remaining buffer space:
+		 * namelen (uint16_t) +
+		 * name (r->res_length) +
+		 * end-of-block record 0x0000 (uint16_t)
+		 */
+
+		if (offset + sizeof(uint16_t)*2 + r->res_length > outlen) {
+			/* Write end-of-block record */
+			be_namelen = 0;
+			memcpy(outbuf + offset, &be_namelen, sizeof(uint16_t));
+			offset += sizeof(uint16_t);
+			goto out;
+		}
+
+		be_namelen = cpu_to_be16(r->res_length);
+		memcpy(outbuf + offset, &be_namelen, sizeof(uint16_t));
+		offset += sizeof(uint16_t);
+		memcpy(outbuf + offset, r->res_name, r->res_length);
+		offset += r->res_length;
+	}
+
+	/* 
+	 * If we've reached the end of the list (and there's room) write a
+	 * terminating record.
+	 */
+
+	if ((list == &ls->ls_root_list) &&
+	    (offset + sizeof(uint16_t) <= outlen)) {
+		be_namelen = 0xFFFF;
+		memcpy(outbuf + offset, &be_namelen, sizeof(uint16_t));
+		offset += sizeof(uint16_t);
+	}
+
+ out:
+	up_read(&ls->ls_root_sem);
+	return offset;
+}
+
--- a/drivers/dlm/dir.h	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/dir.h	2005-04-25 22:52:03.787842448 +0800
@@ -0,0 +1,30 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
+**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+**  
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#ifndef __DIR_DOT_H__
+#define __DIR_DOT_H__
+
+
+int dlm_dir_nodeid(struct dlm_rsb *rsb);
+int dlm_dir_name2nodeid(struct dlm_ls *ls, char *name, int length);
+void dlm_dir_remove_entry(struct dlm_ls *ls, int nodeid, char *name, int len);
+void dlm_dir_clear(struct dlm_ls *ls);
+void dlm_clear_free_entries(struct dlm_ls *ls);
+int dlm_recover_directory(struct dlm_ls *ls);
+int dlm_dir_lookup(struct dlm_ls *ls, int nodeid, char *name, int namelen,
+	int *r_nodeid);
+int dlm_copy_master_names(struct dlm_ls *ls, char *inbuf, int inlen,
+	char *outbuf, int outlen, int nodeid);
+int dlm_dir_rebuild_wait(struct dlm_ls *ls);
+
+#endif				/* __DIR_DOT_H__ */
--- a/drivers/dlm/lock.h	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/lock.h	2005-04-25 22:52:03.936819800 +0800
@@ -0,0 +1,38 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
+**  
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#ifndef __LOCK_DOT_H__
+#define __LOCK_DOT_H__
+
+void dlm_print_lkb(struct dlm_lkb *lkb);
+void dlm_print_rsb(struct dlm_rsb *r);
+int dlm_receive_message(struct dlm_header *hd, int nodeid, int recovery);
+int dlm_modes_compat(int mode1, int mode2);
+int dlm_find_rsb(struct dlm_ls *ls, char *name, int namelen,
+	unsigned int flags, struct dlm_rsb **r_ret);
+int dlm_is_master(struct dlm_rsb *r);
+void dlm_put_rsb(struct dlm_rsb *r);
+void dlm_hold_rsb(struct dlm_rsb *r);
+void dlm_lock_rsb(struct dlm_rsb *r);
+void dlm_unlock_rsb(struct dlm_rsb *r);
+int dlm_put_lkb(struct dlm_lkb *lkb);
+int dlm_remove_from_waiters(struct dlm_lkb *lkb);
+void dlm_scan_rsbs(struct dlm_ls *ls);
+
+int dlm_purge_locks(struct dlm_ls *ls);
+int dlm_grant_after_purge(struct dlm_ls *ls);
+int dlm_recover_waiters_post(struct dlm_ls *ls);
+void dlm_recover_waiters_pre(struct dlm_ls *ls);
+int dlm_recover_master_copy(struct dlm_ls *ls, struct dlm_rcom *rc);
+int dlm_recover_process_copy(struct dlm_ls *ls, struct dlm_rcom *rc);
+
+#endif
--- a/drivers/dlm/lockspace.c	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/lockspace.c	2005-04-25 22:52:03.956816760 +0800
@@ -0,0 +1,535 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
+**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+**
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#include "dlm_internal.h"
+#include "lockspace.h"
+#include "member.h"
+#include "member_sysfs.h"
+#include "recoverd.h"
+#include "ast.h"
+#include "dir.h"
+#include "lowcomms.h"
+#include "config.h"
+#include "memory.h"
+#include "lock.h"
+
+static int			ls_count;
+static struct semaphore		ls_lock;
+static struct list_head		lslist;
+static spinlock_t		lslist_lock;
+static struct task_struct *	scand_task;
+
+
+int dlm_lockspace_init(void)
+{
+	ls_count = 0;
+	init_MUTEX(&ls_lock);
+	INIT_LIST_HEAD(&lslist);
+	spin_lock_init(&lslist_lock);
+	return 0;
+}
+
+void dlm_lockspace_exit(void)
+{
+}
+
+int dlm_scand(void *data)
+{
+	struct dlm_ls *ls;
+
+	while (!kthread_should_stop()) {
+		list_for_each_entry(ls, &lslist, ls_list)
+			dlm_scan_rsbs(ls);
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(DLM_SCAN_SECS * HZ);
+	}
+	return 0;
+}
+
+int dlm_scand_start(void)
+{
+	struct task_struct *p;
+	int error = 0;
+
+	p = kthread_run(dlm_scand, NULL, "dlm_scand");
+	if (IS_ERR(p))
+		error = PTR_ERR(p);
+	else
+		scand_task = p;
+	return error;
+}
+
+void dlm_scand_stop(void)
+{
+	kthread_stop(scand_task);
+}
+
+static struct dlm_ls *find_lockspace_name(char *name, int namelen)
+{
+	struct dlm_ls *ls;
+
+	spin_lock(&lslist_lock);
+
+	list_for_each_entry(ls, &lslist, ls_list) {
+		if (ls->ls_namelen == namelen &&
+		    memcmp(ls->ls_name, name, namelen) == 0)
+			goto out;
+	}
+	ls = NULL;
+ out:
+	spin_unlock(&lslist_lock);
+	return ls;
+}
+
+struct dlm_ls *dlm_find_lockspace_global(uint32_t id)
+{
+	struct dlm_ls *ls;
+
+	spin_lock(&lslist_lock);
+
+	list_for_each_entry(ls, &lslist, ls_list) {
+		if (ls->ls_global_id == id) {
+			ls->ls_count++;
+			goto out;
+		}
+	}
+	ls = NULL;
+ out:
+	spin_unlock(&lslist_lock);
+	return ls;
+}
+
+struct dlm_ls *dlm_find_lockspace_local(void *id)
+{
+	struct dlm_ls *ls = id;
+
+	spin_lock(&lslist_lock);
+	ls->ls_count++;
+	spin_unlock(&lslist_lock);
+	return ls;
+}
+
+void dlm_put_lockspace(struct dlm_ls *ls)
+{
+	spin_lock(&lslist_lock);
+	ls->ls_count--;
+	spin_unlock(&lslist_lock);
+}
+
+static void remove_lockspace(struct dlm_ls *ls)
+{
+	for (;;) {
+		spin_lock(&lslist_lock);
+		if (ls->ls_count == 0) {
+			list_del(&ls->ls_list);
+			spin_unlock(&lslist_lock);
+			return;
+		}
+		spin_unlock(&lslist_lock);
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+	}
+}
+
+static int threads_start(void)
+{
+	int error;
+
+	/* Thread which process lock requests for all lockspace's */
+	error = dlm_astd_start();
+	if (error) {
+		log_print("cannot start dlm_astd thread %d", error);
+		goto fail;
+	}
+
+	error = dlm_scand_start();
+	if (error) {
+		log_print("cannot start dlm_scand thread %d", error);
+		goto astd_fail;
+	}
+
+	/* Thread for sending/receiving messages for all lockspace's */
+	error = dlm_lowcomms_start();
+	if (error) {
+		log_print("cannot start dlm lowcomms %d", error);
+		goto scand_fail;
+	}
+
+	return 0;
+
+ scand_fail:
+	dlm_scand_stop();
+ astd_fail:
+	dlm_astd_stop();
+ fail:
+	return error;
+}
+
+static void threads_stop(void)
+{
+	dlm_scand_stop();
+	dlm_lowcomms_stop();
+	dlm_astd_stop();
+}
+
+static int new_lockspace(char *name, int namelen, void **lockspace, int flags)
+{
+	struct dlm_ls *ls;
+	int i, size, error = -ENOMEM;
+
+	if (namelen > DLM_LOCKSPACE_LEN)
+		return -EINVAL;
+
+	if (!try_module_get(THIS_MODULE))
+		return -EINVAL;
+
+	ls = find_lockspace_name(name, namelen);
+	if (ls) {
+		*lockspace = ls;
+		module_put(THIS_MODULE);
+		return -EEXIST;
+	}
+
+	ls = kmalloc(sizeof(struct dlm_ls) + namelen, GFP_KERNEL);
+	if (!ls)
+		goto out;
+	memset(ls, 0, sizeof(struct dlm_ls) + namelen);
+	memcpy(ls->ls_name, name, namelen);
+	ls->ls_namelen = namelen;
+	ls->ls_count = 0;
+	ls->ls_flags = 0;
+
+	size = dlm_config.rsbtbl_size;
+	ls->ls_rsbtbl_size = size;
+
+	ls->ls_rsbtbl = kmalloc(sizeof(struct dlm_rsbtable) * size, GFP_KERNEL);
+	if (!ls->ls_rsbtbl)
+		goto out_lsfree;
+	for (i = 0; i < size; i++) {
+		INIT_LIST_HEAD(&ls->ls_rsbtbl[i].list);
+		INIT_LIST_HEAD(&ls->ls_rsbtbl[i].toss);
+		rwlock_init(&ls->ls_rsbtbl[i].lock);
+	}
+
+	size = dlm_config.lkbtbl_size;
+	ls->ls_lkbtbl_size = size;
+
+	ls->ls_lkbtbl = kmalloc(sizeof(struct dlm_lkbtable) * size, GFP_KERNEL);
+	if (!ls->ls_lkbtbl)
+		goto out_rsbfree;
+	for (i = 0; i < size; i++) {
+		INIT_LIST_HEAD(&ls->ls_lkbtbl[i].list);
+		rwlock_init(&ls->ls_lkbtbl[i].lock);
+		ls->ls_lkbtbl[i].counter = 1;
+	}
+
+	size = dlm_config.dirtbl_size;
+	ls->ls_dirtbl_size = size;
+
+	ls->ls_dirtbl = kmalloc(sizeof(struct dlm_dirtable) * size, GFP_KERNEL);
+	if (!ls->ls_dirtbl)
+		goto out_lkbfree;
+	for (i = 0; i < size; i++) {
+		INIT_LIST_HEAD(&ls->ls_dirtbl[i].list);
+		rwlock_init(&ls->ls_dirtbl[i].lock);
+	}
+
+	ls->ls_recover_buf = kmalloc(dlm_config.buffer_size, GFP_KERNEL);
+	if (!ls->ls_recover_buf)
+		goto out_dirfree;
+
+	init_waitqueue_head(&ls->ls_wait_member);
+	INIT_LIST_HEAD(&ls->ls_nodes);
+	INIT_LIST_HEAD(&ls->ls_nodes_gone);
+	INIT_LIST_HEAD(&ls->ls_waiters);
+	ls->ls_num_nodes = 0;
+	ls->ls_node_array = NULL;
+	ls->ls_recoverd_task = NULL;
+	init_MUTEX(&ls->ls_recoverd_active);
+	INIT_LIST_HEAD(&ls->ls_recover);
+	spin_lock_init(&ls->ls_recover_lock);
+	INIT_LIST_HEAD(&ls->ls_recover_list);
+	ls->ls_recover_list_count = 0;
+	spin_lock_init(&ls->ls_recover_list_lock);
+	init_waitqueue_head(&ls->ls_wait_general);
+	INIT_LIST_HEAD(&ls->ls_root_list);
+	INIT_LIST_HEAD(&ls->ls_requestqueue);
+	ls->ls_last_stop = 0;
+	ls->ls_last_start = 0;
+	ls->ls_last_finish = 0;
+	init_MUTEX(&ls->ls_waiters_sem);
+	init_MUTEX(&ls->ls_requestqueue_lock);
+	init_rwsem(&ls->ls_root_sem);
+	init_rwsem(&ls->ls_in_recovery);
+
+	memset(&ls->ls_stub_rsb, 0, sizeof(struct dlm_rsb));
+	ls->ls_stub_rsb.res_ls = ls;
+
+	down_write(&ls->ls_in_recovery);
+
+	error = dlm_recoverd_start(ls);
+	if (error) {
+		log_error(ls, "can't start dlm_recoverd %d", error);
+		goto out_rcomfree;
+	}
+
+	ls->ls_state = LSST_INIT;
+
+	spin_lock(&lslist_lock);
+	list_add(&ls->ls_list, &lslist);
+	spin_unlock(&lslist_lock);
+
+	dlm_create_debug_file(ls);
+
+	error = dlm_kobject_setup(ls);
+	if (error)
+		goto out_del;
+
+	error = kobject_register(&ls->ls_kobj);
+	if (error)
+		goto out_del;
+
+	kobject_uevent(&ls->ls_kobj, KOBJ_ONLINE, NULL);
+
+	/* Now we depend on userspace to notice the new ls, join it and
+	   give us a start or terminate.  The ls isn't actually running
+	   until it receives a start. */
+
+	error = wait_event_interruptible(ls->ls_wait_member,
+				test_bit(LSFL_JOIN_DONE, &ls->ls_flags));
+	if (error)
+		goto out_unreg;
+
+	if (test_bit(LSFL_LS_TERMINATE, &ls->ls_flags)) {
+		error = -ERESTARTSYS;
+		goto out_unreg;
+	}
+
+	*lockspace = ls;
+	return 0;
+
+ out_unreg:
+	kobject_unregister(&ls->ls_kobj);
+ out_del:
+	dlm_delete_debug_file(ls);
+	spin_lock(&lslist_lock);
+	list_del(&ls->ls_list);
+	spin_unlock(&lslist_lock);
+	dlm_recoverd_stop(ls);
+ out_rcomfree:
+	kfree(ls->ls_recover_buf);
+ out_dirfree:
+	kfree(ls->ls_dirtbl);
+ out_lkbfree:
+	kfree(ls->ls_lkbtbl);
+ out_rsbfree:
+	kfree(ls->ls_rsbtbl);
+ out_lsfree:
+	kfree(ls);
+ out:
+	module_put(THIS_MODULE);
+	return error;
+}
+
+int dlm_new_lockspace(char *name, int namelen, void **lockspace, int flags)
+{
+	int error = 0;
+
+	down(&ls_lock);
+	if (!ls_count)
+		error = threads_start();
+	if (error)
+		goto out;
+
+	error = new_lockspace(name, namelen, lockspace, flags);
+	if (!error)
+		ls_count++;
+ out:
+	up(&ls_lock);
+	return error;
+}
+
+/* Return 1 if the lockspace still has active remote locks,
+ *        2 if the lockspace still has active local locks.
+ */
+static int lockspace_busy(struct dlm_ls *ls)
+{
+	int i, lkb_found = 0;
+	struct dlm_lkb *lkb;
+
+	/* NOTE: We check the lockidtbl here rather than the resource table.
+	   This is because there may be LKBs queued as ASTs that have been
+	   unlinked from their RSBs and are pending deletion once the AST has
+	   been delivered */
+
+	for (i = 0; i < ls->ls_lkbtbl_size; i++) {
+		read_lock(&ls->ls_lkbtbl[i].lock);
+		if (!list_empty(&ls->ls_lkbtbl[i].list)) {
+			lkb_found = 1;
+			list_for_each_entry(lkb, &ls->ls_lkbtbl[i].list,
+					    lkb_idtbl_list) {
+				if (!lkb->lkb_nodeid) {
+					read_unlock(&ls->ls_lkbtbl[i].lock);
+					return 2;
+				}
+			}
+		}
+		read_unlock(&ls->ls_lkbtbl[i].lock);
+	}
+	return lkb_found;
+}
+
+static int release_lockspace(struct dlm_ls *ls, int force)
+{
+	struct dlm_lkb *lkb;
+	struct dlm_rsb *rsb;
+	struct dlm_recover *rv;
+	struct list_head *head;
+	int i, error;
+	int busy = lockspace_busy(ls);
+
+	if (busy > force)
+		return -EBUSY;
+
+	if (force < 3) {
+		error = kobject_uevent(&ls->ls_kobj, KOBJ_OFFLINE, NULL);
+		error = wait_event_interruptible(ls->ls_wait_member,
+				test_bit(LSFL_LEAVE_DONE, &ls->ls_flags));
+	}
+
+	dlm_recoverd_stop(ls);
+
+	remove_lockspace(ls);
+
+	dlm_delete_debug_file(ls);
+
+	dlm_astd_suspend();
+
+	kfree(ls->ls_recover_buf);
+
+	/*
+	 * Free direntry structs.
+	 */
+
+	dlm_dir_clear(ls);
+	kfree(ls->ls_dirtbl);
+
+	/*
+	 * Free all lkb's on lkbtbl[] lists.
+	 */
+
+	for (i = 0; i < ls->ls_lkbtbl_size; i++) {
+		head = &ls->ls_lkbtbl[i].list;
+		while (!list_empty(head)) {
+			lkb = list_entry(head->next, struct dlm_lkb,
+					 lkb_idtbl_list);
+
+			list_del(&lkb->lkb_idtbl_list);
+
+			dlm_del_ast(lkb);
+
+			if (lkb->lkb_lvbptr && lkb->lkb_flags & DLM_IFL_MSTCPY)
+				free_lvb(lkb->lkb_lvbptr);
+
+			free_lkb(lkb);
+		}
+	}
+	dlm_astd_resume();
+
+	kfree(ls->ls_lkbtbl);
+
+	/*
+	 * Free all rsb's on rsbtbl[] lists
+	 */
+
+	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
+		head = &ls->ls_rsbtbl[i].list;
+		while (!list_empty(head)) {
+			rsb = list_entry(head->next, struct dlm_rsb,
+					 res_hashchain);
+
+			list_del(&rsb->res_hashchain);
+
+			if (rsb->res_lvbptr)
+				free_lvb(rsb->res_lvbptr);
+
+			free_rsb(rsb);
+		}
+
+		head = &ls->ls_rsbtbl[i].toss;
+		while (!list_empty(head)) {
+			rsb = list_entry(head->next, struct dlm_rsb,
+					 res_hashchain);
+			list_del(&rsb->res_hashchain);
+
+			if (rsb->res_lvbptr)
+				free_lvb(rsb->res_lvbptr);
+
+			free_rsb(rsb);
+		}
+	}
+
+	kfree(ls->ls_rsbtbl);
+
+	/*
+	 * Free structures on any other lists
+	 */
+
+	head = &ls->ls_recover;
+	while (!list_empty(head)) {
+		rv = list_entry(head->next, struct dlm_recover, list);
+		list_del(&rv->list);
+		kfree(rv);
+	}
+
+	dlm_clear_free_entries(ls);
+	dlm_clear_members(ls);
+	dlm_clear_members_gone(ls);
+	kfree(ls->ls_node_array);
+	kobject_unregister(&ls->ls_kobj);
+	kfree(ls);
+
+	down(&ls_lock);
+	ls_count--;
+	if (!ls_count)
+		threads_stop();
+	up(&ls_lock);
+	
+	module_put(THIS_MODULE);
+	return 0;
+}
+
+/*
+ * Called when a system has released all its locks and is not going to use the
+ * lockspace any longer.  We free everything we're managing for this lockspace.
+ * Remaining nodes will go through the recovery process as if we'd died.  The
+ * lockspace must continue to function as usual, participating in recoveries,
+ * until this returns.
+ *
+ * Force has 4 possible values:
+ * 0 - don't destroy locksapce if it has any LKBs
+ * 1 - destroy lockspace if it has remote LKBs but not if it has local LKBs
+ * 2 - destroy lockspace regardless of LKBs
+ * 3 - destroy lockspace as part of a forced shutdown
+ */
+
+int dlm_release_lockspace(void *lockspace, int force)
+{
+	struct dlm_ls *ls;
+
+	ls = dlm_find_lockspace_local(lockspace);
+	if (!ls)
+		return -EINVAL;
+	dlm_put_lockspace(ls);
+	return release_lockspace(ls, force);
+}
--- a/drivers/dlm/lockspace.h	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/lockspace.h	2005-04-25 22:52:03.964815544 +0800
@@ -0,0 +1,26 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
+**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+**  
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#ifndef __LOCKSPACE_DOT_H__
+#define __LOCKSPACE_DOT_H__
+
+int dlm_lockspace_init(void);
+void dlm_lockspace_exit(void);
+int dlm_new_lockspace(char *name, int namelen, void **ls, int flags);
+int dlm_release_lockspace(void *ls, int force);
+struct dlm_ls *dlm_find_lockspace_global(uint32_t id);
+struct dlm_ls *dlm_find_lockspace_local(void *id);
+struct dlm_ls *dlm_find_lockspace_name(char *name, int namelen);
+void dlm_put_lockspace(struct dlm_ls *ls);
+
+#endif				/* __LOCKSPACE_DOT_H__ */
--- a/drivers/dlm/main.c	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/main.c	2005-04-25 22:52:03.989811744 +0800
@@ -0,0 +1,93 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
+**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+**  
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#include "dlm_internal.h"
+#include "lockspace.h"
+#include "member_sysfs.h"
+#include "lock.h"
+#include "device.h"
+#include "memory.h"
+#include "lowcomms.h"
+
+int dlm_register_debugfs(void);
+void dlm_unregister_debugfs(void);
+int dlm_node_ioctl_init(void);
+void dlm_node_ioctl_exit(void);
+
+int __init init_dlm(void)
+{
+	int error;
+
+	error = dlm_memory_init();
+	if (error)
+		goto out;
+
+	error = dlm_lockspace_init();
+	if (error)
+		goto out_mem;
+
+	error = dlm_node_ioctl_init();
+	if (error)
+		goto out_ls;
+
+	error = dlm_member_sysfs_init();
+	if (error)
+		goto out_node;
+
+	error = dlm_register_debugfs();
+	if (error)
+		goto out_member;
+
+	error = dlm_lowcomms_init();
+	if (error)
+		goto out_debug;
+
+	printk("DLM (built %s %s) installed\n", __DATE__, __TIME__);
+
+	return 0;
+
+ out_debug:
+	dlm_unregister_debugfs();
+ out_member:
+	dlm_member_sysfs_exit();
+ out_node:
+	dlm_node_ioctl_exit();
+ out_ls:
+	dlm_lockspace_exit();
+ out_mem:
+	dlm_memory_exit();
+ out:
+	return error;
+}
+
+void __exit exit_dlm(void)
+{
+	dlm_lowcomms_exit();
+	dlm_member_sysfs_exit();
+	dlm_node_ioctl_exit();
+	dlm_lockspace_exit();
+	dlm_memory_exit();
+	dlm_unregister_debugfs();
+}
+
+module_init(init_dlm);
+module_exit(exit_dlm);
+
+MODULE_DESCRIPTION("Distributed Lock Manager");
+MODULE_AUTHOR("Red Hat, Inc.");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(dlm_new_lockspace);
+EXPORT_SYMBOL(dlm_release_lockspace);
+EXPORT_SYMBOL(dlm_lock);
+EXPORT_SYMBOL(dlm_unlock);
--- a/drivers/dlm/memory.c	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/memory.c	2005-04-25 22:52:04.051802320 +0800
@@ -0,0 +1,135 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
+**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+**  
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#include "dlm_internal.h"
+#include "config.h"
+
+static kmem_cache_t *lkb_cache;
+static kmem_cache_t *lvb_cache;
+
+
+int dlm_memory_init(void)
+{
+	int ret = -ENOMEM;
+
+	lkb_cache = kmem_cache_create("dlm_lkb", sizeof(struct dlm_lkb),
+				__alignof__(struct dlm_lkb), 0, NULL, NULL);
+	if (!lkb_cache)
+		goto out;
+
+	lvb_cache = kmem_cache_create("dlm_lvb", DLM_LVB_LEN,
+				__alignof__(uint64_t), 0, NULL, NULL);
+
+	if (!lvb_cache)
+		goto out_lkb;
+
+	return 0;
+
+ out_lkb:
+	kmem_cache_destroy(lkb_cache);
+ out:
+	return ret;
+}
+
+void dlm_memory_exit(void)
+{
+	kmem_cache_destroy(lkb_cache);
+	kmem_cache_destroy(lvb_cache);
+}
+
+char *allocate_lvb(struct dlm_ls *ls)
+{
+	char *l;
+
+	l = kmem_cache_alloc(lvb_cache, GFP_KERNEL);
+	if (l)
+		memset(l, 0, DLM_LVB_LEN);
+	return l;
+}
+
+void free_lvb(char *l)
+{
+	kmem_cache_free(lvb_cache, l);
+}
+
+/* use lvb cache since they are the same size */
+
+uint64_t *allocate_range(struct dlm_ls *ls)
+{
+	uint64_t *p;
+
+	p = kmem_cache_alloc(lvb_cache, GFP_KERNEL);
+	if (p)
+		memset(p, 0, 4*sizeof(uint64_t));
+	return p;
+}
+
+void free_range(uint64_t *l)
+{
+	kmem_cache_free(lvb_cache, l);
+}
+
+/* FIXME: have some minimal space built-in to rsb for the name and
+   kmalloc a separate name if needed, like dentries are done */
+
+struct dlm_rsb *allocate_rsb(struct dlm_ls *ls, int namelen)
+{
+	struct dlm_rsb *r;
+
+	DLM_ASSERT(namelen <= DLM_RESNAME_MAXLEN,);
+
+	r = kmalloc(sizeof(*r) + namelen, GFP_KERNEL);
+	if (r)
+		memset(r, 0, sizeof(*r) + namelen);
+	return r;
+}
+
+void free_rsb(struct dlm_rsb *r)
+{
+	if (r->res_lvbptr)
+		free_lvb(r->res_lvbptr);
+	kfree(r);
+}
+
+struct dlm_lkb *allocate_lkb(struct dlm_ls *ls)
+{
+	struct dlm_lkb *lkb;
+
+	lkb = kmem_cache_alloc(lkb_cache, GFP_KERNEL);
+	if (lkb)
+		memset(lkb, 0, sizeof(*lkb));
+	return lkb;
+}
+
+void free_lkb(struct dlm_lkb *lkb)
+{
+	kmem_cache_free(lkb_cache, lkb);
+}
+
+struct dlm_direntry *allocate_direntry(struct dlm_ls *ls, int namelen)
+{
+	struct dlm_direntry *de;
+
+	DLM_ASSERT(namelen <= DLM_RESNAME_MAXLEN,);
+
+	de = kmalloc(sizeof(*de) + namelen, GFP_KERNEL);
+	if (de)
+		memset(de, 0, sizeof(*de) + namelen);
+	return de;
+}
+
+void free_direntry(struct dlm_direntry *de)
+{
+	kfree(de);
+}
+
--- a/drivers/dlm/memory.h	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/memory.h	2005-04-25 22:52:04.056801560 +0800
@@ -0,0 +1,30 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
+**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+**  
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#ifndef __MEMORY_DOT_H__
+#define __MEMORY_DOT_H__
+
+int dlm_memory_init(void);
+void dlm_memory_exit(void);
+struct dlm_rsb *allocate_rsb(struct dlm_ls *ls, int namelen);
+void free_rsb(struct dlm_rsb *r);
+struct dlm_lkb *allocate_lkb(struct dlm_ls *ls);
+void free_lkb(struct dlm_lkb *l);
+struct dlm_direntry *allocate_direntry(struct dlm_ls *ls, int namelen);
+void free_direntry(struct dlm_direntry *de);
+char *allocate_lvb(struct dlm_ls *ls);
+void free_lvb(char *l);
+uint64_t *allocate_range(struct dlm_ls *ls);
+void free_range(uint64_t *l);
+
+#endif		/* __MEMORY_DOT_H__ */
--- a/drivers/dlm/util.c	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/util.c	2005-04-25 22:52:04.199779824 +0800
@@ -0,0 +1,190 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
+**  
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#include "dlm_internal.h"
+#include "rcom.h"
+
+/**
+ * dlm_hash - hash an array of data
+ * @data: the data to be hashed
+ * @len: the length of data to be hashed
+ *
+ * Copied from GFS which copied from...
+ *
+ * Take some data and convert it to a 32-bit hash.
+ * This is the 32-bit FNV-1a hash from:
+ * http://www.isthe.com/chongo/tech/comp/fnv/
+ */
+
+static inline uint32_t
+hash_more_internal(const void *data, unsigned int len, uint32_t hash)
+{
+	unsigned char *p = (unsigned char *)data;
+	unsigned char *e = p + len;
+	uint32_t h = hash;
+
+	while (p < e) {
+		h ^= (uint32_t)(*p++);
+		h *= 0x01000193;
+	}
+
+	return h;
+}
+
+uint32_t dlm_hash(const void *data, int len)
+{
+	uint32_t h = 0x811C9DC5;
+	h = hash_more_internal(data, len, h);
+	return h;
+}
+
+static void header_out(struct dlm_header *hd)
+{
+	hd->h_version		= cpu_to_le32(hd->h_version);
+	hd->h_lockspace		= cpu_to_le32(hd->h_lockspace);
+	hd->h_nodeid		= cpu_to_le32(hd->h_nodeid);
+	hd->h_length		= cpu_to_le16(hd->h_length);
+}
+
+static void header_in(struct dlm_header *hd)
+{
+	hd->h_version		= le32_to_cpu(hd->h_version);
+	hd->h_lockspace		= le32_to_cpu(hd->h_lockspace);
+	hd->h_nodeid		= le32_to_cpu(hd->h_nodeid);
+	hd->h_length		= le16_to_cpu(hd->h_length);
+}
+
+void dlm_message_out(struct dlm_message *ms)
+{
+	struct dlm_header *hd = (struct dlm_header *) ms;
+
+	header_out(hd);
+
+	ms->m_type		= cpu_to_le32(ms->m_type);
+	ms->m_nodeid		= cpu_to_le32(ms->m_nodeid);
+	ms->m_pid		= cpu_to_le32(ms->m_pid);
+	ms->m_lkid		= cpu_to_le32(ms->m_lkid);
+	ms->m_remid		= cpu_to_le32(ms->m_remid);
+	ms->m_parent_lkid	= cpu_to_le32(ms->m_parent_lkid);
+	ms->m_parent_remid	= cpu_to_le32(ms->m_parent_remid);
+	ms->m_exflags		= cpu_to_le32(ms->m_exflags);
+	ms->m_sbflags		= cpu_to_le32(ms->m_sbflags);
+	ms->m_flags		= cpu_to_le32(ms->m_flags);
+	ms->m_lvbseq		= cpu_to_le32(ms->m_lvbseq);
+
+	ms->m_status		= cpu_to_le32(ms->m_status);
+	ms->m_grmode		= cpu_to_le32(ms->m_grmode);
+	ms->m_rqmode		= cpu_to_le32(ms->m_rqmode);
+	ms->m_bastmode		= cpu_to_le32(ms->m_bastmode);
+	ms->m_asts		= cpu_to_le32(ms->m_asts);
+	ms->m_result		= cpu_to_le32(ms->m_result);
+
+	ms->m_range[0]		= cpu_to_le64(ms->m_range[0]);
+	ms->m_range[1]		= cpu_to_le64(ms->m_range[1]);
+}
+
+void dlm_message_in(struct dlm_message *ms)
+{
+	struct dlm_header *hd = (struct dlm_header *) ms;
+
+	header_in(hd);
+
+	ms->m_type		= le32_to_cpu(ms->m_type);
+	ms->m_nodeid		= le32_to_cpu(ms->m_nodeid);
+	ms->m_pid		= le32_to_cpu(ms->m_pid);
+	ms->m_lkid		= le32_to_cpu(ms->m_lkid);
+	ms->m_remid		= le32_to_cpu(ms->m_remid);
+	ms->m_parent_lkid	= le32_to_cpu(ms->m_parent_lkid);
+	ms->m_parent_remid	= le32_to_cpu(ms->m_parent_remid);
+	ms->m_exflags		= le32_to_cpu(ms->m_exflags);
+	ms->m_sbflags		= le32_to_cpu(ms->m_sbflags);
+	ms->m_flags		= le32_to_cpu(ms->m_flags);
+	ms->m_lvbseq		= le32_to_cpu(ms->m_lvbseq);
+
+	ms->m_status		= le32_to_cpu(ms->m_status);
+	ms->m_grmode		= le32_to_cpu(ms->m_grmode);
+	ms->m_rqmode		= le32_to_cpu(ms->m_rqmode);
+	ms->m_bastmode		= le32_to_cpu(ms->m_bastmode);
+	ms->m_asts		= le32_to_cpu(ms->m_asts);
+	ms->m_result		= le32_to_cpu(ms->m_result);
+
+	ms->m_range[0]		= le64_to_cpu(ms->m_range[0]);
+	ms->m_range[1]		= le64_to_cpu(ms->m_range[1]);
+}
+
+static void rcom_lock_out(struct rcom_lock *rl)
+{
+	rl->rl_ownpid		= cpu_to_le32(rl->rl_ownpid);
+	rl->rl_lkid		= cpu_to_le32(rl->rl_lkid);
+	rl->rl_remid		= cpu_to_le32(rl->rl_remid);
+	rl->rl_parent_lkid	= cpu_to_le32(rl->rl_parent_lkid);
+	rl->rl_parent_remid	= cpu_to_le32(rl->rl_parent_remid);
+	rl->rl_exflags		= cpu_to_le32(rl->rl_exflags);
+	rl->rl_flags		= cpu_to_le32(rl->rl_flags);
+	rl->rl_lvbseq		= cpu_to_le32(rl->rl_lvbseq);
+	rl->rl_result		= cpu_to_le32(rl->rl_result);
+	rl->rl_wait_type	= cpu_to_le16(rl->rl_wait_type);
+	rl->rl_namelen		= cpu_to_le16(rl->rl_namelen);
+	rl->rl_range[0]		= cpu_to_le64(rl->rl_range[0]);
+	rl->rl_range[1]		= cpu_to_le64(rl->rl_range[1]);
+	rl->rl_range[2]		= cpu_to_le64(rl->rl_range[2]);
+	rl->rl_range[3]		= cpu_to_le64(rl->rl_range[3]);
+}
+
+static void rcom_lock_in(struct rcom_lock *rl)
+{
+	rl->rl_ownpid		= le32_to_cpu(rl->rl_ownpid);
+	rl->rl_lkid		= le32_to_cpu(rl->rl_lkid);
+	rl->rl_remid		= le32_to_cpu(rl->rl_remid);
+	rl->rl_parent_lkid	= le32_to_cpu(rl->rl_parent_lkid);
+	rl->rl_parent_remid	= le32_to_cpu(rl->rl_parent_remid);
+	rl->rl_exflags		= le32_to_cpu(rl->rl_exflags);
+	rl->rl_flags		= le32_to_cpu(rl->rl_flags);
+	rl->rl_lvbseq		= le32_to_cpu(rl->rl_lvbseq);
+	rl->rl_result		= le32_to_cpu(rl->rl_result);
+	rl->rl_wait_type	= le16_to_cpu(rl->rl_wait_type);
+	rl->rl_namelen		= le16_to_cpu(rl->rl_namelen);
+	rl->rl_range[0]		= le64_to_cpu(rl->rl_range[0]);
+	rl->rl_range[1]		= le64_to_cpu(rl->rl_range[1]);
+	rl->rl_range[2]		= le64_to_cpu(rl->rl_range[2]);
+	rl->rl_range[3]		= le64_to_cpu(rl->rl_range[3]);
+}
+
+void dlm_rcom_out(struct dlm_rcom *rc)
+{
+	struct dlm_header *hd = (struct dlm_header *) rc;
+	int type = rc->rc_type;
+
+	header_out(hd);
+
+	rc->rc_type		= cpu_to_le16(rc->rc_type);
+	rc->rc_result		= cpu_to_le16(rc->rc_result);
+	rc->rc_id		= cpu_to_le64(rc->rc_id);
+
+	if (type == DLM_RCOM_LOCK)
+		rcom_lock_out((struct rcom_lock *) rc->rc_buf);
+}
+
+void dlm_rcom_in(struct dlm_rcom *rc)
+{
+	struct dlm_header *hd = (struct dlm_header *) rc;
+
+	header_in(hd);
+
+	rc->rc_type		= le16_to_cpu(rc->rc_type);
+	rc->rc_result		= le16_to_cpu(rc->rc_result);
+	rc->rc_id		= le64_to_cpu(rc->rc_id);
+
+	if (rc->rc_type == DLM_RCOM_LOCK)
+		rcom_lock_in((struct rcom_lock *) rc->rc_buf);
+}
+
--- a/drivers/dlm/util.h	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/util.h	2005-04-25 22:52:04.199779824 +0800
@@ -0,0 +1,23 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
+**  
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#ifndef __UTIL_DOT_H__
+#define __UTIL_DOT_H__
+
+uint32_t dlm_hash(const char *data, int len);
+
+void dlm_message_out(struct dlm_message *ms);
+void dlm_message_in(struct dlm_message *ms);
+void dlm_rcom_out(struct dlm_rcom *rc);
+void dlm_rcom_in(struct dlm_rcom *rc);
+
+#endif
