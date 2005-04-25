Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVDYP23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVDYP23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 11:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVDYP23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:28:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2214 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262659AbVDYPJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:09:02 -0400
Date: Mon, 25 Apr 2005 23:12:39 +0800
From: David Teigland <teigland@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH 3/7] dlm: recovery
Message-ID: <20050425151239.GD6826@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When a node is removed from a lockspace, recovery is required for that
lockspace on all the remaining lockspace members.  Recovery involves: a
full rebuild of the distributed resource directory, selecting a new master
node for locks/resources previously mastered on the removed node, and
rebuilding master-copy locks on newly selected masters.

Signed-Off-By: Dave Teigland <teigland@redhat.com>
Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>

---

 drivers/dlm/member.c       |  347 ++++++++++++++++++++++
 drivers/dlm/member.h       |   29 +
 drivers/dlm/rcom.c         |  413 ++++++++++++++++++++++++++
 drivers/dlm/rcom.h         |   44 ++
 drivers/dlm/recover.c      |  706 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dlm/recover.h      |   31 +
 drivers/dlm/recoverd.c     |  705 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/dlm/recoverd.h     |   23 +
 drivers/dlm/requestqueue.c |  144 +++++++++
 drivers/dlm/requestqueue.h |   21 +
 10 files changed, 2463 insertions(+)

--- a/drivers/dlm/rcom.c	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/rcom.c	2005-04-25 22:52:04.101794720 +0800
@@ -0,0 +1,413 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
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
+#include "lockspace.h"
+#include "member.h"
+#include "lowcomms.h"
+#include "midcomms.h"
+#include "rcom.h"
+#include "recover.h"
+#include "dir.h"
+#include "config.h"
+#include "memory.h"
+#include "lock.h"
+#include "util.h"
+
+
+static int rcom_response(struct dlm_ls *ls)
+{
+	return test_bit(LSFL_RCOM_READY, &ls->ls_flags);
+}
+
+static int create_rcom(struct dlm_ls *ls, int to_nodeid, int type, int len,
+		       struct dlm_rcom **rc_ret, struct dlm_mhandle **mh_ret)
+{
+	struct dlm_rcom *rc;
+	struct dlm_mhandle *mh;
+	char *mb;
+	int mb_len = sizeof(struct dlm_rcom) + len;
+
+	mh = dlm_lowcomms_get_buffer(to_nodeid, mb_len, GFP_KERNEL, &mb);
+	if (!mh)
+		return -ENOBUFS;
+	memset(mb, 0, mb_len);
+
+	rc = (struct dlm_rcom *) mb;
+
+	rc->rc_header.h_version = (DLM_HEADER_MAJOR | DLM_HEADER_MINOR);
+	rc->rc_header.h_lockspace = ls->ls_global_id;
+	rc->rc_header.h_nodeid = dlm_our_nodeid();
+	rc->rc_header.h_length = mb_len;
+	rc->rc_header.h_cmd = DLM_RCOM;
+
+	rc->rc_type = type;
+
+	*mh_ret = mh;
+	*rc_ret = rc;
+	return 0;
+}
+
+static int send_rcom(struct dlm_ls *ls, struct dlm_mhandle *mh,
+		     struct dlm_rcom *rc)
+{
+	dlm_rcom_out(rc);
+	dlm_lowcomms_commit_buffer(mh);
+	return 0;
+}
+
+static int make_status(struct dlm_ls *ls)
+{
+	int status = 0;
+
+	if (test_bit(LSFL_DIR_VALID, &ls->ls_flags))
+		status |= DIR_VALID;
+
+	if (test_bit(LSFL_ALL_DIR_VALID, &ls->ls_flags))
+		status |= DIR_ALL_VALID;
+
+	if (test_bit(LSFL_NODES_VALID, &ls->ls_flags))
+		status |= NODES_VALID;
+
+	if (test_bit(LSFL_ALL_NODES_VALID, &ls->ls_flags))
+		status |= NODES_ALL_VALID;
+
+	return status;
+}
+
+int dlm_rcom_status(struct dlm_ls *ls, int nodeid)
+{
+	struct dlm_rcom *rc;
+	struct dlm_mhandle *mh;
+	int error;
+
+	memset(ls->ls_recover_buf, 0, dlm_config.buffer_size);
+
+	if (nodeid == dlm_our_nodeid()) {
+		rc = (struct dlm_rcom *) ls->ls_recover_buf;
+		rc->rc_result = make_status(ls);
+		return 0;
+	}
+
+	error = create_rcom(ls, nodeid, DLM_RCOM_STATUS, 0, &rc, &mh);
+
+	error = send_rcom(ls, mh, rc);
+
+	error = dlm_wait_function(ls, &rcom_response);
+	clear_bit(LSFL_RCOM_READY, &ls->ls_flags);
+	return error;
+}
+
+static void receive_rcom_status(struct dlm_ls *ls, struct dlm_rcom *rc_in)
+{
+	struct dlm_rcom *rc;
+	struct dlm_mhandle *mh;
+	int error, nodeid = rc_in->rc_header.h_nodeid;
+
+	error = create_rcom(ls, nodeid, DLM_RCOM_STATUS_REPLY, 0, &rc, &mh);
+	rc->rc_result = make_status(ls);
+
+	error = send_rcom(ls, mh, rc);
+}
+
+static void receive_rcom_status_reply(struct dlm_ls *ls, struct dlm_rcom *rc_in)
+{
+	memcpy(ls->ls_recover_buf, rc_in, rc_in->rc_header.h_length);
+	set_bit(LSFL_RCOM_READY, &ls->ls_flags);
+	wake_up(&ls->ls_wait_general);
+}
+
+int dlm_rcom_names(struct dlm_ls *ls, int nodeid, char *last_name, int last_len)
+{
+	struct dlm_rcom *rc;
+	struct dlm_mhandle *mh;
+	int error, len = sizeof(struct dlm_rcom);
+
+	memset(ls->ls_recover_buf, 0, dlm_config.buffer_size);
+
+	if (nodeid == dlm_our_nodeid()) {
+		dlm_copy_master_names(ls, last_name, last_len,
+		                      ls->ls_recover_buf + len,
+		                      dlm_config.buffer_size - len, nodeid);
+		return 0;
+	}
+
+	error = create_rcom(ls, nodeid, DLM_RCOM_NAMES, last_len, &rc, &mh);
+	memcpy(rc->rc_buf, last_name, last_len);
+
+	error = send_rcom(ls, mh, rc);
+
+	error = dlm_wait_function(ls, &rcom_response);
+	clear_bit(LSFL_RCOM_READY, &ls->ls_flags);
+	return error;
+}
+
+static void receive_rcom_names(struct dlm_ls *ls, struct dlm_rcom *rc_in)
+{
+	struct dlm_rcom *rc;
+	struct dlm_mhandle *mh;
+	int error, inlen, outlen;
+	int nodeid = rc_in->rc_header.h_nodeid;
+
+	/*
+	 * We can't run dlm_dir_rebuild_send (which uses ls_nodes) while
+	 * dlm_recoverd is running ls_nodes_reconfig (which changes ls_nodes).
+	 * It could only happen in rare cases where we get a late NAMES 
+	 * message from a previous instance of recovery.
+	 */
+
+	if (!test_bit(LSFL_NODES_VALID, &ls->ls_flags)) {
+		log_debug(ls, "ignoring RCOM_NAMES from %u", nodeid);
+		return;
+	}
+		
+	nodeid = rc_in->rc_header.h_nodeid;
+	inlen = rc_in->rc_header.h_length - sizeof(struct dlm_rcom);
+	outlen = dlm_config.buffer_size - sizeof(struct dlm_rcom);
+
+	error = create_rcom(ls, nodeid, DLM_RCOM_NAMES_REPLY, outlen, &rc, &mh);
+
+	error = dlm_copy_master_names(ls, rc_in->rc_buf, inlen, rc->rc_buf,
+				      outlen, nodeid);
+
+	error = send_rcom(ls, mh, rc);
+}
+
+static void receive_rcom_names_reply(struct dlm_ls *ls, struct dlm_rcom *rc_in)
+{
+	memcpy(ls->ls_recover_buf, rc_in, rc_in->rc_header.h_length);
+	set_bit(LSFL_RCOM_READY, &ls->ls_flags);
+	wake_up(&ls->ls_wait_general);
+}
+
+int dlm_send_rcom_lookup(struct dlm_rsb *r, int dir_nodeid)
+{
+	struct dlm_rcom *rc;
+	struct dlm_mhandle *mh;
+	struct dlm_ls *ls = r->res_ls;
+	int error;
+
+	error = create_rcom(ls, dir_nodeid, DLM_RCOM_LOOKUP, r->res_length,
+			    &rc, &mh);
+	memcpy(rc->rc_buf, r->res_name, r->res_length);
+	rc->rc_id = (unsigned long) r;
+
+	error = send_rcom(ls, mh, rc);
+	return 0;
+}
+
+static void receive_rcom_lookup(struct dlm_ls *ls, struct dlm_rcom *rc_in)
+{
+	struct dlm_rcom *rc;
+	struct dlm_mhandle *mh;
+	int error, ret_nodeid, nodeid = rc_in->rc_header.h_nodeid;
+	int len = rc_in->rc_header.h_length - sizeof(struct dlm_rcom);
+
+	error = dlm_dir_lookup(ls, nodeid, rc_in->rc_buf, len, &ret_nodeid);
+
+	error = create_rcom(ls, nodeid, DLM_RCOM_LOOKUP_REPLY, 0, &rc, &mh);
+	rc->rc_result = ret_nodeid;
+	rc->rc_id = rc_in->rc_id;
+
+	error = send_rcom(ls, mh, rc);
+}
+
+static void receive_rcom_lookup_reply(struct dlm_ls *ls, struct dlm_rcom *rc_in)
+{
+	dlm_recover_master_reply(ls, rc_in);
+}
+
+static void pack_rcom_lock(struct dlm_rsb *r, struct dlm_lkb *lkb,
+			   struct rcom_lock *rl)
+{
+	memset(rl, 0, sizeof(*rl));
+
+	rl->rl_ownpid = lkb->lkb_ownpid;
+	rl->rl_lkid = lkb->lkb_id;
+	rl->rl_exflags = lkb->lkb_exflags;
+	rl->rl_flags = lkb->lkb_flags;
+	rl->rl_lvbseq = lkb->lkb_lvbseq;
+	rl->rl_rqmode = lkb->lkb_rqmode;
+	rl->rl_grmode = lkb->lkb_grmode;
+	rl->rl_status = lkb->lkb_status;
+	rl->rl_wait_type = lkb->lkb_wait_type;
+
+	if (lkb->lkb_bastaddr)
+		rl->rl_asts |= AST_BAST;
+	if (lkb->lkb_astaddr)
+		rl->rl_asts |= AST_COMP;
+
+	if (lkb->lkb_range)
+		memcpy(rl->rl_range, lkb->lkb_range, 4*sizeof(uint64_t));
+
+	/* FIXME: might we have an lvb without DLM_LKF_VALBLK set ?
+	   If so, receive_rcom_lock_args() won't take this copy. */
+
+	if (lkb->lkb_lvbptr)
+		memcpy(rl->rl_lvb, lkb->lkb_lvbptr, DLM_LVB_LEN);
+
+	rl->rl_namelen = r->res_length;
+	memcpy(rl->rl_name, r->res_name, r->res_length);
+}
+
+int dlm_send_rcom_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+{
+	struct dlm_ls *ls = r->res_ls;
+	struct dlm_rcom *rc;
+	struct dlm_mhandle *mh;
+	struct rcom_lock *rl;
+	int error;
+
+	error = create_rcom(ls, r->res_nodeid, DLM_RCOM_LOCK,
+			    sizeof(struct rcom_lock), &rc, &mh);
+
+	rl = (struct rcom_lock *) rc->rc_buf;
+	pack_rcom_lock(r, lkb, rl);
+	rc->rc_id = (unsigned long) r;
+
+	error = send_rcom(ls, mh, rc);
+
+	return error;
+}
+
+static void receive_rcom_lock(struct dlm_ls *ls, struct dlm_rcom *rc_in)
+{
+	struct dlm_rcom *rc;
+	struct dlm_mhandle *mh;
+	int error, nodeid = rc_in->rc_header.h_nodeid;
+
+	dlm_recover_master_copy(ls, rc_in);
+
+	error = create_rcom(ls, nodeid, DLM_RCOM_LOCK_REPLY,
+			    sizeof(struct rcom_lock), &rc, &mh);
+
+	/* We send back the same rcom_lock struct we received, but
+	   dlm_recover_master_copy() has filled in rl_remid and rl_result */
+
+	memcpy(rc->rc_buf, rc_in->rc_buf, sizeof(struct rcom_lock));
+	rc->rc_id = rc_in->rc_id;
+
+	error = send_rcom(ls, mh, rc);
+}
+
+static void receive_rcom_lock_reply(struct dlm_ls *ls, struct dlm_rcom *rc_in)
+{
+	if (!test_bit(LSFL_DIR_VALID, &ls->ls_flags)) {
+		log_debug(ls, "ignoring RCOM_LOCK_REPLY from %u",
+			  rc_in->rc_header.h_nodeid);
+		return;
+	}
+
+	dlm_recover_process_copy(ls, rc_in);
+}
+
+static int send_ls_not_ready(int nodeid, struct dlm_rcom *rc_in)
+{
+	struct dlm_rcom *rc;
+	struct dlm_mhandle *mh;
+	char *mb;
+	int mb_len = sizeof(struct dlm_rcom);
+
+	mh = dlm_lowcomms_get_buffer(nodeid, mb_len, GFP_KERNEL, &mb);
+	if (!mh)
+		return -ENOBUFS;
+	memset(mb, 0, mb_len);
+
+	rc = (struct dlm_rcom *) mb;
+
+	rc->rc_header.h_version = (DLM_HEADER_MAJOR | DLM_HEADER_MINOR);
+	rc->rc_header.h_lockspace = rc_in->rc_header.h_lockspace;
+	rc->rc_header.h_nodeid = dlm_our_nodeid();
+	rc->rc_header.h_length = mb_len;
+	rc->rc_header.h_cmd = DLM_RCOM;
+
+	rc->rc_type = DLM_RCOM_STATUS_REPLY;
+	rc->rc_result = 0;
+
+	dlm_rcom_out(rc);
+	dlm_lowcomms_commit_buffer(mh);
+
+	return 0;
+}
+
+/* Called by dlm_recvd; corresponds to dlm_receive_message() but special
+   recovery-only comms are sent through here. */
+
+void dlm_receive_rcom(struct dlm_header *hd, int nodeid)
+{
+	struct dlm_rcom *rc = (struct dlm_rcom *) hd;
+	struct dlm_ls *ls;
+
+	dlm_rcom_in(rc);
+
+	/* If the lockspace doesn't exist then still send a status message
+	   back; it's possible that it just doesn't have its global_id yet. */
+
+	ls = dlm_find_lockspace_global(hd->h_lockspace);
+	if (!ls) {
+		send_ls_not_ready(nodeid, rc);
+		return;
+	}
+
+	if (dlm_recovery_stopped(ls) && (rc->rc_type != DLM_RCOM_STATUS)) {
+		log_error(ls, "ignoring recovery message %x from %d",
+			  rc->rc_type, nodeid);
+		return;
+	}
+
+	if (nodeid != rc->rc_header.h_nodeid) {
+		log_error(ls, "bad rcom nodeid %d from %d",
+			  rc->rc_header.h_nodeid, nodeid);
+		return;
+	}
+
+	switch (rc->rc_type) {
+	case DLM_RCOM_STATUS:
+		receive_rcom_status(ls, rc);
+		break;
+
+	case DLM_RCOM_NAMES:
+		receive_rcom_names(ls, rc);
+		break;
+
+	case DLM_RCOM_LOOKUP:
+		receive_rcom_lookup(ls, rc);
+		break;
+
+	case DLM_RCOM_LOCK:
+		receive_rcom_lock(ls, rc);
+		break;
+
+	case DLM_RCOM_STATUS_REPLY:
+		receive_rcom_status_reply(ls, rc);
+		break;
+
+	case DLM_RCOM_NAMES_REPLY:
+		receive_rcom_names_reply(ls, rc);
+		break;
+
+	case DLM_RCOM_LOOKUP_REPLY:
+		receive_rcom_lookup_reply(ls, rc);
+		break;
+
+	case DLM_RCOM_LOCK_REPLY:
+		receive_rcom_lock_reply(ls, rc);
+		break;
+
+	default:
+		DLM_ASSERT(0, printk("rc_type=%x\n", rc->rc_type););
+	}
+
+	dlm_put_lockspace(ls);
+}
+
--- a/drivers/dlm/rcom.h	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/rcom.h	2005-04-25 22:52:04.114792744 +0800
@@ -0,0 +1,44 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
+**  Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
+**  
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#ifndef __RCOM_DOT_H__
+#define __RCOM_DOT_H__
+
+struct rcom_lock {
+	uint32_t		rl_ownpid;
+	uint32_t		rl_lkid;
+	uint32_t		rl_remid;
+	uint32_t		rl_parent_lkid;
+	uint32_t		rl_parent_remid;
+	uint32_t		rl_exflags;
+	uint32_t		rl_flags;
+	uint32_t		rl_lvbseq;
+	int			rl_result;
+	int8_t			rl_rqmode;
+	int8_t			rl_grmode;
+	int8_t			rl_status;
+	int8_t			rl_asts;
+	uint16_t		rl_wait_type;
+	uint16_t		rl_namelen;
+	uint64_t		rl_range[4];
+	char			rl_lvb[DLM_LVB_LEN];
+	char			rl_name[DLM_RESNAME_MAXLEN];
+};
+
+int dlm_rcom_status(struct dlm_ls *ls, int nodeid);
+int dlm_rcom_names(struct dlm_ls *ls, int nodeid, char *last_name,int last_len);
+int dlm_send_rcom_lookup(struct dlm_rsb *r, int dir_nodeid);
+int dlm_send_rcom_lock(struct dlm_rsb *r, struct dlm_lkb *lkb);
+void dlm_receive_rcom(struct dlm_header *hd, int nodeid);
+
+#endif
--- a/drivers/dlm/recover.c	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/recover.c	2005-04-25 22:52:04.150787272 +0800
@@ -0,0 +1,706 @@
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
+#include "dir.h"
+#include "config.h"
+#include "ast.h"
+#include "memory.h"
+#include "rcom.h"
+#include "lock.h"
+#include "lowcomms.h"
+#include "member.h"
+
+static void recover_rsb_lvb(struct dlm_rsb *r);
+
+
+/*
+ * Recovery waiting routines: these functions wait for a particular reply from
+ * a remote node, or for the remote node to report a certain status.  They need
+ * to abort if the lockspace is stopped indicating a node has failed (perhaps
+ * the one being waited for).
+ */
+
+int dlm_recovery_stopped(struct dlm_ls *ls)
+{
+	return test_bit(LSFL_LS_STOP, &ls->ls_flags);
+}
+
+/*
+ * Wait until given function returns non-zero or lockspace is stopped (LS_STOP
+ * set due to failure of a node in ls_nodes).  When another function thinks it
+ * could have completed the waited-on task, they should wake up ls_wait_general
+ * to get an immediate response rather than waiting for the timer to detect the
+ * result.  A timer wakes us up periodically while waiting to see if we should
+ * abort due to a node failure.
+ */
+
+int dlm_wait_function(struct dlm_ls *ls, int (*testfn) (struct dlm_ls *ls))
+{
+	int error = 0;
+
+	for (;;) {
+		wait_event_interruptible_timeout(ls->ls_wait_general,
+					testfn(ls) ||
+					test_bit(LSFL_LS_STOP, &ls->ls_flags),
+					(dlm_config.recover_timer * HZ));
+		if (testfn(ls))
+			break;
+		if (dlm_recovery_stopped(ls)) {
+			error = -1;
+			break;
+		}
+	}
+
+	return error;
+}
+
+/*
+ * An efficient way for all nodes to wait for all others to have a certain
+ * status.  The node with the lowest nodeid polls all the others for their
+ * status (dlm_wait_status_all) and all the others poll the node with the low
+ * id for its accumulated result (dlm_wait_status_low).
+ */
+
+int dlm_wait_status_all(struct dlm_ls *ls, unsigned int wait_status)
+{
+	struct dlm_rcom *rc = (struct dlm_rcom *) ls->ls_recover_buf;
+	struct dlm_member *memb;
+	int error = 0;
+
+	list_for_each_entry(memb, &ls->ls_nodes, list) {
+		for (;;) {
+			error = dlm_recovery_stopped(ls);
+			if (error)
+				goto out;
+
+			error = dlm_rcom_status(ls, memb->nodeid);
+			if (error)
+				goto out;
+
+			if (rc->rc_result & wait_status)
+				break;
+			else {
+				set_current_state(TASK_INTERRUPTIBLE);
+				schedule_timeout(HZ >> 1);
+			}
+		}
+	}
+ out:
+	return error;
+}
+
+int dlm_wait_status_low(struct dlm_ls *ls, unsigned int wait_status)
+{
+	struct dlm_rcom *rc = (struct dlm_rcom *) ls->ls_recover_buf;
+	int error = 0, nodeid = ls->ls_low_nodeid;
+
+	for (;;) {
+		error = dlm_recovery_stopped(ls);
+		if (error)
+			goto out;
+
+		error = dlm_rcom_status(ls, nodeid);
+		if (error)
+			break;
+
+		if (rc->rc_result & wait_status)
+			break;
+		else {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(HZ >> 1);
+		}
+	}
+ out:
+	return error;
+}
+
+/*
+ * The recover_list contains all the rsb's for which we've requested the new
+ * master nodeid.  As replies are returned from the resource directories the
+ * rsb's are removed from the list.  When the list is empty we're done.
+ *
+ * The recover_list is later similarly used for all rsb's for which we've sent
+ * new lkb's and need to receive new corresponding lkid's.
+ *
+ * We use the address of the rsb struct as a simple local identifier for the
+ * rsb so we can match an rcom reply with the rsb it was sent for.
+ */
+
+static int recover_list_empty(struct dlm_ls *ls)
+{
+	int empty;
+
+	spin_lock(&ls->ls_recover_list_lock);
+	empty = list_empty(&ls->ls_recover_list);
+	spin_unlock(&ls->ls_recover_list_lock);
+
+	return empty;
+}
+
+static void recover_list_add(struct dlm_rsb *r)
+{
+	struct dlm_ls *ls = r->res_ls;
+
+	spin_lock(&ls->ls_recover_list_lock);
+	if (list_empty(&r->res_recover_list)) {
+		list_add_tail(&r->res_recover_list, &ls->ls_recover_list);
+		ls->ls_recover_list_count++;
+		dlm_hold_rsb(r);
+	}
+	spin_unlock(&ls->ls_recover_list_lock);
+}
+
+static void recover_list_del(struct dlm_rsb *r)
+{
+	struct dlm_ls *ls = r->res_ls;
+
+	spin_lock(&ls->ls_recover_list_lock);
+	list_del_init(&r->res_recover_list);
+	ls->ls_recover_list_count--;
+	spin_unlock(&ls->ls_recover_list_lock);
+
+	dlm_put_rsb(r);
+}
+
+static struct dlm_rsb *recover_list_find(struct dlm_ls *ls, uint64_t id)
+{
+	struct dlm_rsb *r = NULL;
+
+	spin_lock(&ls->ls_recover_list_lock);
+
+	list_for_each_entry(r, &ls->ls_recover_list, res_recover_list) {
+		if (id == (unsigned long) r)
+			goto out;
+	}
+	r = NULL;
+ out:
+	spin_unlock(&ls->ls_recover_list_lock);
+	return r;
+}
+
+void recover_list_clear(struct dlm_ls *ls)
+{
+	struct dlm_rsb *r, *s;
+
+	spin_lock(&ls->ls_recover_list_lock);
+	list_for_each_entry_safe(r, s, &ls->ls_recover_list, res_recover_list) {
+		list_del_init(&r->res_recover_list);
+		dlm_put_rsb(r);
+		ls->ls_recover_list_count--;
+	}
+
+	if (ls->ls_recover_list_count != 0) {
+		log_error(ls, "warning: recover_list_count %d",
+			  ls->ls_recover_list_count);
+		ls->ls_recover_list_count = 0;
+	}
+	spin_unlock(&ls->ls_recover_list_lock);
+}
+
+
+/* Master recovery: find new master node for rsb's that were
+   mastered on nodes that have been removed.
+
+   dlm_recover_masters
+   recover_master
+   dlm_send_rcom_lookup            ->  receive_rcom_lookup
+                                       dlm_dir_lookup
+   receive_rcom_lookup_reply       <-
+   dlm_recover_master_reply
+   set_new_master
+   set_master_lkbs
+   set_lock_master
+*/
+
+/*
+ * Set the lock master for all LKBs in a lock queue
+ * If we are the new master of the rsb, we may have received new
+ * MSTCPY locks from other nodes already which we need to ignore
+ * when setting the new nodeid.
+ */
+
+static void set_lock_master(struct list_head *queue, int nodeid)
+{
+	struct dlm_lkb *lkb;
+
+	list_for_each_entry(lkb, queue, lkb_statequeue)
+		if (!(lkb->lkb_flags & DLM_IFL_MSTCPY))
+			lkb->lkb_nodeid = nodeid;
+}
+
+static void set_master_lkbs(struct dlm_rsb *r)
+{
+	set_lock_master(&r->res_grantqueue, r->res_nodeid);
+	set_lock_master(&r->res_convertqueue, r->res_nodeid);
+	set_lock_master(&r->res_waitqueue, r->res_nodeid);
+}
+
+/*
+ * Propogate the new master nodeid to locks
+ * The NEW_MASTER flag tells dlm_recover_locks() which rsb's to consider.
+ * The NEW_MASTER2 flag tells dlm_recover_lvbs() which rsb's to consider.
+ */
+
+static void set_new_master(struct dlm_rsb *r, int nodeid)
+{
+	dlm_lock_rsb(r);
+
+	/* FIXME: what if there are lkb's waiting on res_lookup ? */
+
+	if (nodeid == dlm_our_nodeid())
+		r->res_nodeid = 0;
+	else
+		r->res_nodeid = nodeid;
+
+	set_master_lkbs(r);
+
+	set_bit(RESFL_NEW_MASTER, &r->res_flags);
+	set_bit(RESFL_NEW_MASTER2, &r->res_flags);
+	dlm_unlock_rsb(r);
+}
+
+/*
+ * We do async lookups on rsb's that need new masters.  The rsb's
+ * waiting for a lookup reply are kept on the recover_list.
+ */
+
+static int recover_master(struct dlm_rsb *r)
+{
+	struct dlm_ls *ls = r->res_ls;
+	int error, dir_nodeid, ret_nodeid, our_nodeid = dlm_our_nodeid();
+
+	dir_nodeid = dlm_dir_nodeid(r);
+
+	if (dir_nodeid == our_nodeid) {
+		error = dlm_dir_lookup(ls, our_nodeid, r->res_name,
+				       r->res_length, &ret_nodeid);
+
+		/* FIXME: is -EEXIST ever a valid error here? */
+		if (error)
+			log_error(ls, "recover dir lookup error %d", error);
+
+		set_new_master(r, ret_nodeid);
+	} else {
+		recover_list_add(r);
+		error = dlm_send_rcom_lookup(r, dir_nodeid);
+	}
+
+	return error;
+}
+
+/*
+ * Go through local root resources and for each rsb which has a master which
+ * has departed, get the new master nodeid from the directory.  The dir will
+ * assign mastery to the first node to look up the new master.  That means
+ * we'll discover in this lookup if we're the new master of any rsb's.
+ *
+ * We fire off all the dir lookup requests individually and asynchronously to
+ * the correct dir node.
+ */
+
+int dlm_recover_masters(struct dlm_ls *ls)
+{
+	struct dlm_rsb *r;
+	int error;
+
+	log_debug(ls, "dlm_recover_masters");
+
+	down_read(&ls->ls_root_sem);
+	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
+		if (!r->res_nodeid)
+			continue;
+
+		error = dlm_recovery_stopped(ls);
+		if (error) {
+			up_read(&ls->ls_root_sem);
+			goto out;
+		}
+
+		clear_bit(RESFL_VALNOTVALID_PREV, &r->res_flags);
+		if (test_bit(RESFL_VALNOTVALID, &r->res_flags))
+			set_bit(RESFL_VALNOTVALID_PREV, &r->res_flags);
+
+		if (dlm_is_removed(ls, r->res_nodeid))
+			recover_master(r);
+
+		schedule();
+	}
+	up_read(&ls->ls_root_sem);
+
+	error = dlm_wait_function(ls, &recover_list_empty);
+
+ out:
+	if (error)
+		recover_list_clear(ls);
+	return error;
+}
+
+int dlm_recover_master_reply(struct dlm_ls *ls, struct dlm_rcom *rc)
+{
+	struct dlm_rsb *r;
+
+	r = recover_list_find(ls, rc->rc_id);
+	if (!r) {
+		log_error(ls, "dlm_recover_master_reply no id %"PRIx64"",
+			  rc->rc_id);
+		goto out;
+	}
+
+	set_new_master(r, rc->rc_result);
+	recover_list_del(r);
+
+	if (recover_list_empty(ls))
+		wake_up(&ls->ls_wait_general);
+ out:
+	return 0;
+}
+
+
+/* Lock recovery: rebuild the process-copy locks we hold on a
+   remastered rsb on the new rsb master.
+
+   dlm_recover_locks
+   recover_locks
+   recover_locks_queue
+   dlm_send_rcom_lock              ->  receive_rcom_lock
+                                       dlm_recover_master_copy
+   receive_rcom_lock_reply         <-
+   dlm_recover_process_copy
+*/
+
+
+/*
+ * keep a count of the number of lkb's we send to the new master; when we get
+ * an equal number of replies then recovery for the rsb is done
+ */
+
+static int recover_locks_queue(struct dlm_rsb *r, struct list_head *head)
+{
+	struct dlm_lkb *lkb;
+	int error = 0;
+
+	list_for_each_entry(lkb, head, lkb_statequeue) {
+	   	error = dlm_send_rcom_lock(r, lkb);
+		if (error)
+			break;
+		r->res_recover_locks_count++;
+	}
+
+	return error;
+}
+
+static int all_queues_empty(struct dlm_rsb *r)
+{
+	if (!list_empty(&r->res_grantqueue) ||
+	    !list_empty(&r->res_convertqueue) ||
+	    !list_empty(&r->res_waitqueue))
+		return FALSE;
+	return TRUE;
+}
+
+static int recover_locks(struct dlm_rsb *r)
+{
+	int error = 0;
+
+	if (all_queues_empty(r))
+		goto out;
+
+	recover_list_add(r);
+
+	error = recover_locks_queue(r, &r->res_grantqueue);
+	if (error)
+		goto out;
+	error = recover_locks_queue(r, &r->res_convertqueue);
+	if (error)
+		goto out;
+	error = recover_locks_queue(r, &r->res_waitqueue);
+ out:
+	return error;
+}
+
+int dlm_recover_locks(struct dlm_ls *ls)
+{
+	struct dlm_rsb *r;
+	int error;
+
+	log_debug(ls, "dlm_recover_locks");
+
+	down_read(&ls->ls_root_sem);
+	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
+		if (!r->res_nodeid)
+			continue;
+
+		error = dlm_recovery_stopped(ls);
+		if (error) {
+			up_read(&ls->ls_root_sem);
+			goto out;
+		}
+
+		if (test_bit(RESFL_NEW_MASTER, &r->res_flags))
+			recover_locks(r);
+	}
+	up_read(&ls->ls_root_sem);
+
+	error = dlm_wait_function(ls, &recover_list_empty);
+
+ out:
+	if (error)
+		recover_list_clear(ls);
+	return error;
+}
+
+void dlm_recovered_lock(struct dlm_rsb *r)
+{
+	r->res_recover_locks_count--;
+	if (!r->res_recover_locks_count) {
+		clear_bit(RESFL_NEW_MASTER, &r->res_flags);
+		recover_list_del(r);
+	}
+
+	if (recover_list_empty(r->res_ls))
+		wake_up(&r->res_ls->ls_wait_general);
+
+	recover_rsb_lvb(r);
+}
+
+/*
+ * This routine is called on all master rsb's by dlm_recoverd.  It is also
+ * called on an rsb when a new lkb is received during the rebuild recovery
+ * stage (implying we are the new master for it.)  So, a newly mastered rsb
+ * will often have this function called on it by dlm_recoverd and by dlm_recvd
+ * when a new lkb is received.
+ *
+ * This function is in charge of making sure the rsb's VALNOTVALID flag is
+ * set correctly and that the lvb contents are set correctly.
+ *
+ * RESFL_VALNOTVALID is set if:
+ * - it was set prior to recovery, OR
+ * - there are only NL/CR locks on the rsb
+ *
+ * RESFL_VALNOTVALID is cleared if:
+ * - it was not set prior to recovery, AND
+ * - there are locks > CR on the rsb
+ *
+ * (We'll only be clearing VALNOTVALID in this function if it
+ *  was set in a prior call to this function when there were
+ *  only NL/CR locks.)
+ *
+ * Whether this node is a new or old master of the rsb is not a factor
+ * in the decision to set/clear VALNOTVALID.
+ *
+ * The LVB contents are only considered for changing when this is a new master
+ * of the rsb (NEW_MASTER2).  Then, the rsb's lvb is taken from any lkb with
+ * mode > CR.  If no lkb's exist with mode above CR, the lvb contents are taken
+ * from the lkb with the largest lvb sequence number.
+ */
+
+static void recover_rsb_lvb(struct dlm_rsb *r)
+{
+	struct dlm_lkb *lkb, *high_lkb = NULL;
+	uint32_t high_seq = 0;
+	int lock_lvb_exists = FALSE;
+	int big_lock_exists = FALSE;
+
+	list_for_each_entry(lkb, &r->res_grantqueue, lkb_statequeue) {
+		if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
+			continue;
+
+		lock_lvb_exists = TRUE;
+
+		if (lkb->lkb_grmode > DLM_LOCK_CR) {
+			big_lock_exists = TRUE;
+			goto setflag;
+		}
+
+		if (((int)lkb->lkb_lvbseq - (int)high_seq) >= 0) {
+			high_lkb = lkb;
+			high_seq = lkb->lkb_lvbseq;
+		}
+	}
+
+	list_for_each_entry(lkb, &r->res_convertqueue, lkb_statequeue) {
+		if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
+			continue;
+
+		lock_lvb_exists = TRUE;
+
+		if (lkb->lkb_grmode > DLM_LOCK_CR) {
+			big_lock_exists = TRUE;
+			goto setflag;
+		}
+
+		if (((int)lkb->lkb_lvbseq - (int)high_seq) >= 0) {
+			high_lkb = lkb;
+			high_seq = lkb->lkb_lvbseq;
+		}
+	}
+
+ setflag:
+	/* there are no locks with lvb's */
+	if (!lock_lvb_exists)
+		goto out;
+
+	/* don't clear valnotvalid if it was already set */
+	if (test_bit(RESFL_VALNOTVALID_PREV, &r->res_flags))
+		goto setlvb;
+
+	if (big_lock_exists)
+		clear_bit(RESFL_VALNOTVALID, &r->res_flags);
+	else
+		set_bit(RESFL_VALNOTVALID, &r->res_flags);
+
+ setlvb:
+	/* don't mess with the lvb unless we're the new master */
+	if (!test_bit(RESFL_NEW_MASTER2, &r->res_flags))
+		goto out;
+
+	if (!r->res_lvbptr)
+		r->res_lvbptr = allocate_lvb(r->res_ls);
+
+	if (big_lock_exists) {
+		r->res_lvbseq = lkb->lkb_lvbseq;
+		memcpy(r->res_lvbptr, lkb->lkb_lvbptr, DLM_LVB_LEN);
+	} else if (high_lkb) {
+		r->res_lvbseq = high_lkb->lkb_lvbseq;
+		memcpy(r->res_lvbptr, high_lkb->lkb_lvbptr, DLM_LVB_LEN);
+	} else {
+		r->res_lvbseq = 0;
+		memset(r->res_lvbptr, 0, DLM_LVB_LEN);
+	}
+ out:
+	return;
+}
+
+int dlm_recover_lvbs(struct dlm_ls *ls)
+{
+	struct dlm_rsb *r;
+
+	down_read(&ls->ls_root_sem);
+	list_for_each_entry(r, &ls->ls_root_list, res_root_list) {
+		if (r->res_nodeid)
+			continue;
+
+		dlm_lock_rsb(r);
+		recover_rsb_lvb(r);
+		dlm_unlock_rsb(r);
+	}
+	up_read(&ls->ls_root_sem);
+	return 0;
+}
+
+/* Create a single list of all root rsb's to be used during recovery */
+
+int dlm_create_root_list(struct dlm_ls *ls)
+{
+	struct dlm_rsb *r;
+	int i, error = 0;
+
+	down_write(&ls->ls_root_sem);
+	if (!list_empty(&ls->ls_root_list)) {
+		log_error(ls, "root list not empty");
+		error = -EINVAL;
+		goto out;
+	}
+
+	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
+		read_lock(&ls->ls_rsbtbl[i].lock);
+		list_for_each_entry(r, &ls->ls_rsbtbl[i].list, res_hashchain) {
+			list_add(&r->res_root_list, &ls->ls_root_list);
+			dlm_hold_rsb(r);
+		}
+		read_unlock(&ls->ls_rsbtbl[i].lock);
+	}
+ out:
+	up_write(&ls->ls_root_sem);
+	return error;
+}
+
+void dlm_release_root_list(struct dlm_ls *ls)
+{
+	struct dlm_rsb *r, *safe;
+
+	down_write(&ls->ls_root_sem);
+	list_for_each_entry_safe(r, safe, &ls->ls_root_list, res_root_list) {
+		list_del_init(&r->res_root_list);
+		dlm_put_rsb(r);
+	}
+	up_write(&ls->ls_root_sem);
+}
+
+void dlm_clear_toss_list(struct dlm_ls *ls)
+{
+	struct dlm_rsb *r, *safe;
+	int i;
+
+	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
+		write_lock(&ls->ls_rsbtbl[i].lock);
+		list_for_each_entry_safe(r, safe, &ls->ls_rsbtbl[i].toss,
+					 res_hashchain) {
+			list_del(&r->res_hashchain);
+			free_rsb(r);
+		}
+		write_unlock(&ls->ls_rsbtbl[i].lock);
+	}
+}
+
+static void recover_conversion(struct dlm_rsb *r)
+{
+	struct dlm_lkb *lkb;
+	int grmode = -1;
+
+	list_for_each_entry(lkb, &r->res_grantqueue, lkb_statequeue) {
+		if (lkb->lkb_grmode == DLM_LOCK_PR ||
+		    lkb->lkb_grmode == DLM_LOCK_CW) {
+			grmode = lkb->lkb_grmode;
+			break;
+		}
+	}
+
+	list_for_each_entry(lkb, &r->res_convertqueue, lkb_statequeue) {
+		if (lkb->lkb_grmode != DLM_LOCK_IV)
+			continue;
+		if (grmode == -1)
+			lkb->lkb_grmode = lkb->lkb_rqmode;
+		else
+			lkb->lkb_grmode = grmode;
+	}
+}
+
+/* All master rsb's flagged RECOVER_CONVERT need to be looked at.  The locks
+   converting PR->CW or CW->PR need to have their lkb_grmode set. */
+
+void dlm_recover_conversions(struct dlm_ls *ls)
+{
+	struct dlm_rsb *r;
+	int i;
+
+	for (i = 0; i < ls->ls_rsbtbl_size; i++) {
+		read_lock(&ls->ls_rsbtbl[i].lock);
+		list_for_each_entry(r, &ls->ls_rsbtbl[i].list, res_hashchain) {
+			if (!test_bit(RESFL_RECOVER_CONVERT, &r->res_flags))
+				continue;
+			clear_bit(RESFL_RECOVER_CONVERT, &r->res_flags);
+
+			dlm_hold_rsb(r);
+			dlm_lock_rsb(r);
+			if (dlm_is_master(r))
+				recover_conversion(r);
+			dlm_unlock_rsb(r);
+			dlm_put_rsb(r);
+		}
+		read_unlock(&ls->ls_rsbtbl[i].lock);
+	}
+}
+
--- a/drivers/dlm/recover.h	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/recover.h	2005-04-25 22:52:04.161785600 +0800
@@ -0,0 +1,31 @@
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
+#ifndef __RECOVER_DOT_H__
+#define __RECOVER_DOT_H__
+
+int dlm_recovery_stopped(struct dlm_ls *ls);
+int dlm_wait_function(struct dlm_ls *ls, int (*testfn) (struct dlm_ls *ls));
+int dlm_wait_status_all(struct dlm_ls *ls, unsigned int wait_status);
+int dlm_wait_status_low(struct dlm_ls *ls, unsigned int wait_status);
+int dlm_recover_masters(struct dlm_ls *ls);
+int dlm_recover_master_reply(struct dlm_ls *ls, struct dlm_rcom *rc);
+int dlm_recover_locks(struct dlm_ls *ls);
+void dlm_recovered_lock(struct dlm_rsb *r);
+int dlm_recover_lvbs(struct dlm_ls *ls);
+int dlm_create_root_list(struct dlm_ls *ls);
+void dlm_release_root_list(struct dlm_ls *ls);
+void dlm_clear_toss_list(struct dlm_ls *ls);
+void dlm_recover_conversions(struct dlm_ls *ls);
+
+#endif				/* __RECOVER_DOT_H__ */
--- a/drivers/dlm/recoverd.c	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/recoverd.c	2005-04-25 22:52:04.174783624 +0800
@@ -0,0 +1,705 @@
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
+#include "dir.h"
+#include "ast.h"
+#include "recover.h"
+#include "lowcomms.h"
+#include "lock.h"
+#include "requestqueue.h"
+
+/*
+ * next_move actions
+ */
+
+#define DO_STOP             (1)
+#define DO_START            (2)
+#define DO_FINISH           (3)
+#define DO_FINISH_STOP      (4)
+#define DO_FINISH_START     (5)
+
+static void set_start_done(struct dlm_ls *ls, int event_id)
+{
+	spin_lock(&ls->ls_recover_lock);
+	ls->ls_startdone = event_id;
+	spin_unlock(&ls->ls_recover_lock);
+
+	kobject_uevent(&ls->ls_kobj, KOBJ_CHANGE, NULL);
+}
+
+static int enable_locking(struct dlm_ls *ls, int event_id)
+{
+	int error = 0;
+
+	spin_lock(&ls->ls_recover_lock);
+	if (ls->ls_last_stop < event_id) {
+		set_bit(LSFL_LS_RUN, &ls->ls_flags);
+		up_write(&ls->ls_in_recovery);
+	} else {
+		error = -EINTR;
+		log_debug(ls, "enable_locking: abort %d", event_id);
+	}
+	spin_unlock(&ls->ls_recover_lock);
+	return error;
+}
+
+static int ls_first_start(struct dlm_ls *ls, struct dlm_recover *rv)
+{
+	int error;
+
+	log_debug(ls, "recover event %u (first)", rv->event_id);
+
+	down(&ls->ls_recoverd_active);
+
+	error = dlm_recover_members_first(ls, rv);
+	if (error) {
+		log_error(ls, "recover_members first failed %d", error);
+		goto out;
+	}
+
+	error = dlm_recover_directory(ls);
+	if (error) {
+		log_error(ls, "recover_directory failed %d", error);
+		goto out;
+	}
+
+	error = dlm_dir_rebuild_wait(ls);
+	if (error) {
+		log_error(ls, "dir_rebuild_wait failed %d", error);
+		goto out;
+	}
+
+	log_debug(ls, "recover event %u done", rv->event_id);
+	set_start_done(ls, rv->event_id);
+
+ out:
+	up(&ls->ls_recoverd_active);
+	return error;
+}
+
+/*
+ * We are given here a new group of nodes which are in the lockspace.  We first
+ * figure out the differences in ls membership from when we were last running.
+ * If nodes from before are gone, then there will be some lock recovery to do.
+ * If there are only nodes which have joined, then there's no lock recovery.
+ *
+ * Lockspace recovery for failed nodes must be completed before any nodes are
+ * allowed to join or leave the lockspace.
+ */
+
+static int ls_reconfig(struct dlm_ls *ls, struct dlm_recover *rv)
+{
+	int error, neg = 0;
+
+	log_debug(ls, "recover event %u", rv->event_id);
+
+	down(&ls->ls_recoverd_active);
+
+	/*
+	 * Suspending and resuming dlm_astd ensures that no lkb's from this ls
+	 * will be processed by dlm_astd during recovery.
+	 */
+
+	dlm_astd_suspend();
+	dlm_astd_resume();
+
+	/*
+	 * This list of root rsb's will be the basis of most of the recovery
+	 * routines.
+	 */
+
+	dlm_create_root_list(ls);
+
+	/*
+	 * Free all the tossed rsb's so we don't have to recover them.
+	 */
+
+	dlm_clear_toss_list(ls);
+
+	/*
+	 * Add or remove nodes from the lockspace's ls_nodes list.
+	 * Also waits for all nodes to complete dlm_recover_members.
+	 */
+
+	error = dlm_recover_members(ls, rv, &neg);
+	if (error) {
+		log_error(ls, "recover_members failed %d", error);
+		goto fail;
+	}
+
+	/*
+	 * Rebuild our own share of the directory by collecting from all other
+	 * nodes their master rsb names that hash to us.
+	 */
+
+	error = dlm_recover_directory(ls);
+	if (error) {
+		log_error(ls, "recover_directory failed %d", error);
+		goto fail;
+	}
+
+	/*
+	 * Purge directory-related requests that are saved in requestqueue.
+	 * All dir requests from before recovery are invalid now due to the dir
+	 * rebuild and will be resent by the requesting nodes.
+	 */
+
+	dlm_purge_requestqueue(ls);
+
+	/*
+	 * Wait for all nodes to complete directory rebuild.
+	 */
+
+	error = dlm_dir_rebuild_wait(ls);
+	if (error) {
+		log_error(ls, "dir_rebuild_wait failed %d", error);
+		goto fail;
+	}
+
+	/*
+	 * We may have outstanding operations that are waiting for a reply from
+	 * a failed node.  Mark these to be resent after recovery.  Unlock and
+	 * cancel ops can just be completed.
+	 */
+
+	dlm_recover_waiters_pre(ls);
+
+	error = dlm_recovery_stopped(ls);
+	if (error)
+		goto fail;
+
+	if (neg) {
+		/*
+		 * Clear lkb's for departed nodes.
+		 */
+
+		dlm_purge_locks(ls);
+
+		/*
+		 * Get new master nodeid's for rsb's that were mastered on
+		 * departed nodes.
+		 */
+
+		error = dlm_recover_masters(ls);
+		if (error) {
+			log_error(ls, "recover_masters failed %d", error);
+			goto fail;
+		}
+
+		/*
+		 * Send our locks on remastered rsb's to the new masters.
+		 */
+
+		error = dlm_recover_locks(ls);
+		if (error) {
+			log_error(ls, "recover_locks failed %d", error);
+			goto fail;
+		}
+
+		dlm_recover_lvbs(ls);
+	}
+
+	dlm_release_root_list(ls);
+
+	log_debug(ls, "recover event %u done", rv->event_id);
+
+	set_start_done(ls, rv->event_id);
+	up(&ls->ls_recoverd_active);
+	return 0;
+
+ fail:
+	log_debug(ls, "recover event %d error %d", rv->event_id, error);
+	up(&ls->ls_recoverd_active);
+	return error;
+}
+
+/*
+ * Between calls to this routine for a ls, there can be multiple stop/start
+ * events from cman where every start but the latest is cancelled by stops.
+ * There can only be a single finish from cman because every finish requires us
+ * to call start_done.  A single finish event could be followed by multiple
+ * stop/start events.  This routine takes any combination of events from cman
+ * and boils them down to one course of action.
+ */
+
+static int next_move(struct dlm_ls *ls, struct dlm_recover **rv_out,
+		     int *finish_out)
+{
+	LIST_HEAD(events);
+	unsigned int cmd = 0, stop, start, finish;
+	unsigned int last_stop, last_start, last_finish;
+	struct dlm_recover *rv = NULL, *start_rv = NULL;
+
+	/*
+	 * Grab the current state of cman/sm events.
+	 */
+
+	spin_lock(&ls->ls_recover_lock);
+
+	stop = test_and_clear_bit(LSFL_LS_STOP, &ls->ls_flags) ? 1 : 0;
+	start = test_and_clear_bit(LSFL_LS_START, &ls->ls_flags) ? 1 : 0;
+	finish = test_and_clear_bit(LSFL_LS_FINISH, &ls->ls_flags) ? 1 : 0;
+
+	last_stop = ls->ls_last_stop;
+	last_start = ls->ls_last_start;
+	last_finish = ls->ls_last_finish;
+
+	while (!list_empty(&ls->ls_recover)) {
+		rv = list_entry(ls->ls_recover.next, struct dlm_recover, list);
+		list_del(&rv->list);
+		list_add_tail(&rv->list, &events);
+	}
+
+	/*
+	 * There are two cases where we need to adjust these event values:
+	 * 1. - we get a first start
+	 *    - we get a stop
+	 *    - we process the start + stop here and notice this special case
+	 * 
+	 * 2. - we get a first start
+	 *    - we process the start
+	 *    - we get a stop
+	 *    - we process the stop here and notice this special case
+	 *
+	 * In both cases, the first start we received was aborted by a
+	 * stop before we received a finish.  last_finish being zero is the
+	 * indication that this is the "first" start, i.e. we've not yet
+	 * finished a start; if we had, last_finish would be non-zero.
+	 * Part of the problem arises from the fact that when we initially
+	 * get start/stop/start, SM uses the same event id for both starts
+	 * (since the first was cancelled).
+	 *
+	 * In both cases, last_start and last_stop will be equal.
+	 * In both cases, finish=0.
+	 * In the first case start=1 && stop=1.
+	 * In the second case start=0 && stop=1.
+	 *
+	 * In both cases, we need to make adjustments to values so:
+	 * - we process the current event (now) as a normal stop
+	 * - the next start we receive will be processed normally
+	 *   (taking into account the assertions below)
+	 *
+	 * In the first case, dlm_ls_start() will have printed the
+	 * "repeated start" warning.
+	 *
+	 * In the first case we need to get rid of the recover event struct.
+	 *
+	 * - set stop=1, start=0, finish=0 for case 4 below
+	 * - last_stop and last_start must be set equal per the case 4 assert
+	 * - ls_last_stop = 0 so the next start will be larger
+	 * - ls_last_start = 0 not really necessary (avoids dlm_ls_start print)
+	 */
+
+	if (!last_finish && (last_start == last_stop)) {
+		log_debug(ls, "move reset %u,%u,%u ids %u,%u,%u", stop,
+			  start, finish, last_stop, last_start, last_finish);
+		stop = 1;
+		start = 0;
+		finish = 0;
+		last_stop = 0;
+		last_start = 0;
+		ls->ls_last_stop = 0;
+		ls->ls_last_start = 0;
+
+		while (!list_empty(&events)) {
+			rv = list_entry(events.next, struct dlm_recover, list);
+			list_del(&rv->list);
+			kfree(rv->nodeids);
+			kfree(rv);
+		}
+	}
+	spin_unlock(&ls->ls_recover_lock);
+
+	log_debug(ls, "move flags %u,%u,%u ids %u,%u,%u", stop, start, finish,
+		  last_stop, last_start, last_finish);
+
+	/*
+	 * Toss start events which have since been cancelled.
+	 */
+
+	while (!list_empty(&events)) {
+		DLM_ASSERT(start,);
+		rv = list_entry(events.next, struct dlm_recover, list);
+		list_del(&rv->list);
+
+		if (rv->event_id <= last_stop) {
+			log_debug(ls, "move skip event %u", rv->event_id);
+			kfree(rv->nodeids);
+			kfree(rv);
+			rv = NULL;
+		} else {
+			log_debug(ls, "move use event %u", rv->event_id);
+			DLM_ASSERT(!start_rv,);
+			start_rv = rv;
+		}
+	}
+
+	/*
+	 * Eight possible combinations of events.
+	 */
+
+	/* 0 */
+	if (!stop && !start && !finish) {
+		DLM_ASSERT(!start_rv,);
+		cmd = 0;
+		goto out;
+	}
+
+	/* 1 */
+	if (!stop && !start && finish) {
+		DLM_ASSERT(!start_rv,);
+		DLM_ASSERT(last_start > last_stop,);
+		DLM_ASSERT(last_finish == last_start,);
+		cmd = DO_FINISH;
+		*finish_out = last_finish;
+		goto out;
+	}
+
+	/* 2 */
+	if (!stop && start && !finish) {
+		DLM_ASSERT(start_rv,);
+		DLM_ASSERT(last_start > last_stop,);
+		cmd = DO_START;
+		*rv_out = start_rv;
+		goto out;
+	}
+
+	/* 3 */
+	if (!stop && start && finish) {
+		DLM_ASSERT(0, printk("finish and start with no stop\n"););
+	}
+
+	/* 4 */
+	if (stop && !start && !finish) {
+		DLM_ASSERT(!start_rv,);
+		DLM_ASSERT(last_start == last_stop,);
+		cmd = DO_STOP;
+		goto out;
+	}
+
+	/* 5 */
+	if (stop && !start && finish) {
+		DLM_ASSERT(!start_rv,);
+		DLM_ASSERT(last_finish == last_start,);
+		DLM_ASSERT(last_stop == last_start,);
+		cmd = DO_FINISH_STOP;
+		*finish_out = last_finish;
+		goto out;
+	}
+
+	/* 6 */
+	if (stop && start && !finish) {
+		if (start_rv) {
+			DLM_ASSERT(last_start > last_stop,);
+			cmd = DO_START;
+			*rv_out = start_rv;
+		} else {
+			DLM_ASSERT(last_stop == last_start,);
+			cmd = DO_STOP;
+		}
+		goto out;
+	}
+
+	/* 7 */
+	if (stop && start && finish) {
+		if (start_rv) {
+			DLM_ASSERT(last_start > last_stop,);
+			DLM_ASSERT(last_start > last_finish,);
+			cmd = DO_FINISH_START;
+			*finish_out = last_finish;
+			*rv_out = start_rv;
+		} else {
+			DLM_ASSERT(last_start == last_stop,);
+			DLM_ASSERT(last_start > last_finish,);
+			cmd = DO_FINISH_STOP;
+			*finish_out = last_finish;
+		}
+		goto out;
+	}
+
+ out:
+	return cmd;
+}
+
+/*
+ * This function decides what to do given every combination of current
+ * lockspace state and next lockspace state.
+ */
+
+static void do_ls_recovery(struct dlm_ls *ls)
+{
+	struct dlm_recover *rv = NULL;
+	int error, cur_state, next_state = 0, do_now, finish_event = 0;
+
+	do_now = next_move(ls, &rv, &finish_event);
+	if (!do_now)
+		goto out;
+
+	cur_state = ls->ls_state;
+	next_state = 0;
+
+	DLM_ASSERT(!test_bit(LSFL_LS_RUN, &ls->ls_flags),
+		    log_error(ls, "curstate=%d donow=%d", cur_state, do_now););
+
+	/*
+	 * LSST_CLEAR - we're not in any recovery state.  We can get a stop or
+	 * a stop and start which equates with a START.
+	 */
+
+	if (cur_state == LSST_CLEAR) {
+		switch (do_now) {
+		case DO_STOP:
+			next_state = LSST_WAIT_START;
+			break;
+
+		case DO_START:
+			error = ls_reconfig(ls, rv);
+			if (error)
+				next_state = LSST_WAIT_START;
+			else
+				next_state = LSST_RECONFIG_DONE;
+			break;
+
+		case DO_FINISH:	/* invalid */
+		case DO_FINISH_STOP:	/* invalid */
+		case DO_FINISH_START:	/* invalid */
+		default:
+			DLM_ASSERT(0,);
+		}
+		goto out;
+	}
+
+	/*
+	 * LSST_WAIT_START - we're not running because of getting a stop or
+	 * failing a start.  We wait in this state for another stop/start or
+	 * just the next start to begin another reconfig attempt.
+	 */
+
+	if (cur_state == LSST_WAIT_START) {
+		switch (do_now) {
+		case DO_STOP:
+			break;
+
+		case DO_START:
+			error = ls_reconfig(ls, rv);
+			if (error)
+				next_state = LSST_WAIT_START;
+			else
+				next_state = LSST_RECONFIG_DONE;
+			break;
+
+		case DO_FINISH:	/* invalid */
+		case DO_FINISH_STOP:	/* invalid */
+		case DO_FINISH_START:	/* invalid */
+		default:
+			DLM_ASSERT(0,);
+		}
+		goto out;
+	}
+
+	/*
+	 * LSST_RECONFIG_DONE - we entered this state after successfully
+	 * completing ls_reconfig and calling set_start_done.  We expect to get
+	 * a finish if everything goes ok.  A finish could be followed by stop
+	 * or stop/start before we get here to check it.  Or a finish may never
+	 * happen, only stop or stop/start.
+	 */
+
+	if (cur_state == LSST_RECONFIG_DONE) {
+		switch (do_now) {
+		case DO_FINISH:
+			dlm_clear_members_finish(ls, finish_event);
+			next_state = LSST_CLEAR;
+
+			dlm_recover_conversions(ls);
+
+			error = enable_locking(ls, finish_event);
+			if (error)
+				break;
+
+			error = dlm_process_requestqueue(ls);
+			if (error)
+				break;
+
+			error = dlm_recover_waiters_post(ls);
+			if (error)
+				break;
+
+			dlm_grant_after_purge(ls);
+
+			dlm_astd_wake();
+
+			log_debug(ls, "recover event %u finished", finish_event);
+			break;
+
+		case DO_STOP:
+			next_state = LSST_WAIT_START;
+			break;
+
+		case DO_FINISH_STOP:
+			dlm_clear_members_finish(ls, finish_event);
+			next_state = LSST_WAIT_START;
+			break;
+
+		case DO_FINISH_START:
+			dlm_clear_members_finish(ls, finish_event);
+			/* fall into DO_START */
+
+		case DO_START:
+			error = ls_reconfig(ls, rv);
+			if (error)
+				next_state = LSST_WAIT_START;
+			else
+				next_state = LSST_RECONFIG_DONE;
+			break;
+
+		default:
+			DLM_ASSERT(0,);
+		}
+		goto out;
+	}
+
+	/*
+	 * LSST_INIT - state after ls is created and before it has been
+	 * started.  A start operation will cause the ls to be started for the
+	 * first time.  A failed start will cause to just wait in INIT for
+	 * another stop/start.
+	 */
+
+	if (cur_state == LSST_INIT) {
+		switch (do_now) {
+		case DO_START:
+			error = ls_first_start(ls, rv);
+			if (!error)
+				next_state = LSST_INIT_DONE;
+			break;
+
+		case DO_STOP:
+			break;
+
+		case DO_FINISH:	/* invalid */
+		case DO_FINISH_STOP:	/* invalid */
+		case DO_FINISH_START:	/* invalid */
+		default:
+			DLM_ASSERT(0,);
+		}
+		goto out;
+	}
+
+	/*
+	 * LSST_INIT_DONE - after the first start operation is completed
+	 * successfully and set_start_done() called.  If there are no errors, a
+	 * finish will arrive next and we'll move to LSST_CLEAR.
+	 */
+
+	if (cur_state == LSST_INIT_DONE) {
+		switch (do_now) {
+		case DO_STOP:
+		case DO_FINISH_STOP:
+			next_state = LSST_WAIT_START;
+			break;
+
+		case DO_START:
+		case DO_FINISH_START:
+			error = ls_reconfig(ls, rv);
+			if (error)
+				next_state = LSST_WAIT_START;
+			else
+				next_state = LSST_RECONFIG_DONE;
+			break;
+
+		case DO_FINISH:
+			next_state = LSST_CLEAR;
+
+			enable_locking(ls, finish_event);
+
+			dlm_process_requestqueue(ls);
+
+			dlm_astd_wake();
+
+			log_debug(ls, "recover event %u finished", finish_event);
+			break;
+
+		default:
+			DLM_ASSERT(0,);
+		}
+		goto out;
+	}
+
+ out:
+	if (next_state)
+		ls->ls_state = next_state;
+
+	if (rv) {
+		kfree(rv->nodeids);
+		kfree(rv);
+	}
+}
+
+int dlm_recoverd(void *arg)
+{
+	struct dlm_ls *ls;
+
+	ls = dlm_find_lockspace_local(arg);
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (!test_bit(LSFL_WORK, &ls->ls_flags))
+			schedule();
+		set_current_state(TASK_RUNNING);
+
+		if (test_and_clear_bit(LSFL_WORK, &ls->ls_flags))
+			do_ls_recovery(ls);
+	}
+
+	dlm_put_lockspace(ls);
+	return 0;
+}
+
+void dlm_recoverd_kick(struct dlm_ls *ls)
+{
+	set_bit(LSFL_WORK, &ls->ls_flags);
+	wake_up_process(ls->ls_recoverd_task);
+}
+
+int dlm_recoverd_start(struct dlm_ls *ls)
+{
+	struct task_struct *p;
+	int error = 0;
+
+	p = kthread_run(dlm_recoverd, ls, "dlm_recoverd");
+	if (IS_ERR(p))
+		error = PTR_ERR(p);
+	else
+                ls->ls_recoverd_task = p;
+	return error;
+}
+
+void dlm_recoverd_stop(struct dlm_ls *ls)
+{
+	kthread_stop(ls->ls_recoverd_task);
+}
+
+void dlm_recoverd_suspend(struct dlm_ls *ls)
+{
+	down(&ls->ls_recoverd_active);
+}
+
+void dlm_recoverd_resume(struct dlm_ls *ls)
+{
+	up(&ls->ls_recoverd_active);
+}
+
--- a/drivers/dlm/recoverd.h	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/recoverd.h	2005-04-25 22:52:04.174783624 +0800
@@ -0,0 +1,23 @@
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
+#ifndef __RECOVERD_DOT_H__
+#define __RECOVERD_DOT_H__
+
+void dlm_recoverd_kick(struct dlm_ls *ls);
+void dlm_recoverd_stop(struct dlm_ls *ls);
+int dlm_recoverd_start(struct dlm_ls *ls);
+void dlm_recoverd_suspend(struct dlm_ls *ls);
+void dlm_recoverd_resume(struct dlm_ls *ls);
+
+#endif				/* __RECOVERD_DOT_H__ */
--- a/drivers/dlm/requestqueue.c	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/requestqueue.c	2005-04-25 22:52:04.183782256 +0800
@@ -0,0 +1,144 @@
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
+#include "member.h"
+#include "lock.h"
+
+struct rq_entry {
+	struct list_head list;
+	int nodeid;
+	char request[1];
+};
+
+/*
+ * Requests received while the lockspace is in recovery get added to the
+ * request queue and processed when recovery is complete.  This happens when
+ * the lockspace is suspended on some nodes before it is on others, or the
+ * lockspace is enabled on some while still suspended on others.
+ */
+
+void dlm_add_requestqueue(struct dlm_ls *ls, int nodeid, struct dlm_header *hd)
+{
+	struct rq_entry *e;
+	int length = hd->h_length;
+
+	if (dlm_is_removed(ls, nodeid))
+		return;
+
+	e = kmalloc(sizeof(struct rq_entry) + length, GFP_KERNEL);
+	if (!e) {
+		printk("dlm_add_requestqueue: out of memory\n");
+		return;
+	}
+
+	e->nodeid = nodeid;
+	memcpy(e->request, hd, length);
+
+	down(&ls->ls_requestqueue_lock);
+	list_add_tail(&e->list, &ls->ls_requestqueue);
+	up(&ls->ls_requestqueue_lock);
+}
+
+int dlm_process_requestqueue(struct dlm_ls *ls)
+{
+	struct rq_entry *e;
+	struct dlm_header *hd;
+	int error = 0;
+
+	down(&ls->ls_requestqueue_lock);
+
+	for (;;) {
+		if (list_empty(&ls->ls_requestqueue)) {
+			up(&ls->ls_requestqueue_lock);
+			error = 0;
+			break;
+		}
+		e = list_entry(ls->ls_requestqueue.next, struct rq_entry, list);
+		up(&ls->ls_requestqueue_lock);
+
+		hd = (struct dlm_header *) e->request;
+		error = dlm_receive_message(hd, e->nodeid, TRUE);
+
+		if (error == -EINTR) {
+			/* entry is left on requestqueue */
+			log_debug(ls, "process_requestqueue abort eintr");
+			break;
+		}
+
+		down(&ls->ls_requestqueue_lock);
+		list_del(&e->list);
+		kfree(e);
+
+		if (!test_bit(LSFL_LS_RUN, &ls->ls_flags)) {
+			log_debug(ls, "process_requestqueue abort ls_run");
+			up(&ls->ls_requestqueue_lock);
+			error = -EINTR;
+			break;
+		}
+		schedule();
+	}
+
+	return error;
+}
+
+/*
+ * After recovery is done, locking is resumed and dlm_recoverd takes all the
+ * saved requests and processes them as they would have been by dlm_recvd.  At
+ * the same time, dlm_recvd will start receiving new requests from remote
+ * nodes.  We want to delay dlm_recvd processing new requests until
+ * dlm_recoverd has finished processing the old saved requests.
+ */
+
+void dlm_wait_requestqueue(struct dlm_ls *ls)
+{
+	for (;;) {
+		down(&ls->ls_requestqueue_lock);
+		if (list_empty(&ls->ls_requestqueue))
+			break;
+		if (!test_bit(LSFL_LS_RUN, &ls->ls_flags))
+			break;
+		up(&ls->ls_requestqueue_lock);
+		schedule();
+	}
+	up(&ls->ls_requestqueue_lock);
+}
+
+/*
+ * Dir lookups and lookup replies send before recovery are invalid because the
+ * directory is rebuilt during recovery, so don't save any requests of this
+ * type.  Don't save any requests from a node that's being removed either.
+ */
+
+void dlm_purge_requestqueue(struct dlm_ls *ls)
+{
+	struct dlm_message *ms;
+	struct rq_entry *e, *safe;
+	uint32_t mstype;
+
+	down(&ls->ls_requestqueue_lock);
+	list_for_each_entry_safe(e, safe, &ls->ls_requestqueue, list) {
+
+		ms = (struct dlm_message *) e->request;
+		mstype = ms->m_type;
+
+		if (dlm_is_removed(ls, e->nodeid) ||
+		    mstype == DLM_MSG_REMOVE ||
+	            mstype == DLM_MSG_LOOKUP ||
+	            mstype == DLM_MSG_LOOKUP_REPLY) {
+			list_del(&e->list);
+			kfree(e);
+		}
+	}
+	up(&ls->ls_requestqueue_lock);
+}
+
--- a/drivers/dlm/requestqueue.h	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/requestqueue.h	2005-04-25 22:52:04.190781192 +0800
@@ -0,0 +1,21 @@
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
+#ifndef __REQUESTQUEUE_DOT_H__
+#define __REQUESTQUEUE_DOT_H__
+
+void dlm_add_requestqueue(struct dlm_ls *ls, int nodeid, struct dlm_header *hd);
+int dlm_process_requestqueue(struct dlm_ls *ls);
+void dlm_wait_requestqueue(struct dlm_ls *ls);
+void dlm_purge_requestqueue(struct dlm_ls *ls);
+
+#endif
--- a/drivers/dlm/member.c	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/member.c	2005-04-25 22:52:04.007809008 +0800
@@ -0,0 +1,347 @@
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
+#include "member_sysfs.h"
+#include "lockspace.h"
+#include "member.h"
+#include "recoverd.h"
+#include "recover.h"
+#include "lowcomms.h"
+
+/*
+ * Following called by dlm_recoverd thread
+ */
+
+static void add_ordered_member(struct dlm_ls *ls, struct dlm_member *new)
+{
+	struct dlm_member *memb = NULL;
+	struct list_head *tmp;
+	struct list_head *newlist = &new->list;
+	struct list_head *head = &ls->ls_nodes;
+
+	list_for_each(tmp, head) {
+		memb = list_entry(tmp, struct dlm_member, list);
+		if (new->nodeid < memb->nodeid)
+			break;
+	}
+
+	if (!memb)
+		list_add_tail(newlist, head);
+	else {
+		/* FIXME: can use list macro here */
+		newlist->prev = tmp->prev;
+		newlist->next = tmp;
+		tmp->prev->next = newlist;
+		tmp->prev = newlist;
+	}
+}
+
+int dlm_add_member(struct dlm_ls *ls, int nodeid)
+{
+	struct dlm_member *memb;
+
+	memb = kmalloc(sizeof(struct dlm_member), GFP_KERNEL);
+	if (!memb)
+		return -ENOMEM;
+
+	memb->nodeid = nodeid;
+	add_ordered_member(ls, memb);
+	ls->ls_num_nodes++;
+	return 0;
+}
+
+void dlm_remove_member(struct dlm_ls *ls, struct dlm_member *memb)
+{
+	list_move(&memb->list, &ls->ls_nodes_gone);
+	ls->ls_num_nodes--;
+}
+
+int dlm_is_member(struct dlm_ls *ls, int nodeid)
+{
+	struct dlm_member *memb;
+
+	list_for_each_entry(memb, &ls->ls_nodes, list) {
+		if (memb->nodeid == nodeid)
+			return TRUE;
+	}
+	return FALSE;
+}
+
+int dlm_is_removed(struct dlm_ls *ls, int nodeid)
+{
+	struct dlm_member *memb;
+
+	list_for_each_entry(memb, &ls->ls_nodes_gone, list) {
+		if (memb->nodeid == nodeid)
+			return TRUE;
+	}
+	return FALSE;
+}
+
+static void clear_memb_list(struct list_head *head)
+{
+	struct dlm_member *memb;
+
+	while (!list_empty(head)) {
+		memb = list_entry(head->next, struct dlm_member, list);
+		list_del(&memb->list);
+		kfree(memb);
+	}
+}
+
+void dlm_clear_members(struct dlm_ls *ls)
+{
+	clear_memb_list(&ls->ls_nodes);
+	ls->ls_num_nodes = 0;
+}
+
+void dlm_clear_members_gone(struct dlm_ls *ls)
+{
+	clear_memb_list(&ls->ls_nodes_gone);
+}
+
+void dlm_clear_members_finish(struct dlm_ls *ls, int finish_event)
+{
+	struct dlm_member *memb, *safe;
+
+	list_for_each_entry_safe(memb, safe, &ls->ls_nodes_gone, list) {
+		if (memb->gone_event <= finish_event) {
+			list_del(&memb->list);
+			kfree(memb);
+		}
+	}
+}
+
+static void make_member_array(struct dlm_ls *ls)
+{
+	struct dlm_member *memb;
+	int i = 0, *array;
+
+	if (ls->ls_node_array) {
+		kfree(ls->ls_node_array);
+		ls->ls_node_array = NULL;
+	}
+
+	array = kmalloc(sizeof(int) * ls->ls_num_nodes, GFP_KERNEL);
+	if (!array)
+		return;
+
+	list_for_each_entry(memb, &ls->ls_nodes, list)
+		array[i++] = memb->nodeid;
+
+	ls->ls_node_array = array;
+}
+
+int dlm_recover_members_wait(struct dlm_ls *ls)
+{
+	int error;
+
+	if (ls->ls_low_nodeid == dlm_our_nodeid()) {
+		error = dlm_wait_status_all(ls, NODES_VALID);
+		if (!error)
+			set_bit(LSFL_ALL_NODES_VALID, &ls->ls_flags);
+	} else
+		error = dlm_wait_status_low(ls, NODES_ALL_VALID);
+
+	return error;
+}
+
+int dlm_recover_members(struct dlm_ls *ls, struct dlm_recover *rv, int *neg_out)
+{
+	struct dlm_member *memb, *safe;
+	int i, error, found, pos = 0, neg = 0, low = -1;
+
+	/* move departed members from ls_nodes to ls_nodes_gone */
+
+	list_for_each_entry_safe(memb, safe, &ls->ls_nodes, list) {
+		found = FALSE;
+		for (i = 0; i < rv->node_count; i++) {
+			if (memb->nodeid == rv->nodeids[i]) {
+				found = TRUE;
+				break;
+			}
+		}
+
+		if (!found) {
+			neg++;
+			memb->gone_event = rv->event_id;
+			dlm_remove_member(ls, memb);
+			log_debug(ls, "remove member %d", memb->nodeid);
+		}
+	}
+
+	/* add new members to ls_nodes */
+
+	for (i = 0; i < rv->node_count; i++) {
+		if (dlm_is_member(ls, rv->nodeids[i]))
+			continue;
+		dlm_add_member(ls, rv->nodeids[i]);
+		pos++;
+		log_debug(ls, "add member %d", rv->nodeids[i]);
+	}
+
+	list_for_each_entry(memb, &ls->ls_nodes, list) {
+		if (low == -1 || memb->nodeid < low)
+			low = memb->nodeid;
+	}
+	ls->ls_low_nodeid = low;
+
+	make_member_array(ls);
+	set_bit(LSFL_NODES_VALID, &ls->ls_flags);
+	*neg_out = neg;
+
+	error = dlm_recover_members_wait(ls);
+	log_debug(ls, "total members %d", ls->ls_num_nodes);
+	return error;
+}
+
+int dlm_recover_members_first(struct dlm_ls *ls, struct dlm_recover *rv)
+{
+	int i, error, nodeid, low = -1;
+
+	dlm_clear_members(ls);
+
+	log_debug(ls, "add members");
+
+	for (i = 0; i < rv->node_count; i++) {
+		nodeid = rv->nodeids[i];
+		dlm_add_member(ls, nodeid);
+
+		if (low == -1 || nodeid < low)
+			low = nodeid;
+	}
+	ls->ls_low_nodeid = low;
+
+	make_member_array(ls);
+	set_bit(LSFL_NODES_VALID, &ls->ls_flags);
+
+	error = dlm_recover_members_wait(ls);
+	log_debug(ls, "total members %d", ls->ls_num_nodes);
+	return error;
+}
+
+/*
+ * Following called from member_sysfs.c
+ */
+
+int dlm_ls_terminate(struct dlm_ls *ls)
+{
+	spin_lock(&ls->ls_recover_lock);
+	set_bit(LSFL_LS_TERMINATE, &ls->ls_flags);
+	set_bit(LSFL_JOIN_DONE, &ls->ls_flags);
+	set_bit(LSFL_LEAVE_DONE, &ls->ls_flags);
+	spin_unlock(&ls->ls_recover_lock);
+	wake_up(&ls->ls_wait_member);
+	log_error(ls, "dlm_ls_terminate");
+	return 0;
+}
+
+int dlm_ls_stop(struct dlm_ls *ls)
+{
+	int new;
+
+	spin_lock(&ls->ls_recover_lock);
+	ls->ls_last_stop = ls->ls_last_start;
+	set_bit(LSFL_LS_STOP, &ls->ls_flags);
+	new = test_and_clear_bit(LSFL_LS_RUN, &ls->ls_flags);
+	spin_unlock(&ls->ls_recover_lock);
+
+	/*
+	 * This in_recovery lock does two things:
+	 *
+	 * 1) Keeps this function from returning until all threads are out
+	 *    of locking routines and locking is truely stopped.
+	 * 2) Keeps any new requests from being processed until it's unlocked
+	 *    when recovery is complete.
+	 */
+
+	if (new)
+		down_write(&ls->ls_in_recovery);
+
+	/*
+	 * The recoverd suspend/resume makes sure that dlm_recoverd (if
+	 * running) has noticed the clearing of LS_RUN above and quit
+	 * processing the previous recovery.  This will be true for all nodes
+	 * before any nodes get the start.
+	 */
+
+	dlm_recoverd_suspend(ls);
+	clear_bit(LSFL_DIR_VALID, &ls->ls_flags);
+	clear_bit(LSFL_ALL_DIR_VALID, &ls->ls_flags);
+	clear_bit(LSFL_NODES_VALID, &ls->ls_flags);
+	clear_bit(LSFL_ALL_NODES_VALID, &ls->ls_flags);
+	dlm_recoverd_resume(ls);
+	dlm_recoverd_kick(ls);
+	return 0;
+}
+
+int dlm_ls_start(struct dlm_ls *ls, int event_nr)
+{
+	struct dlm_recover *rv;
+	int error = 0;
+
+	rv = kmalloc(sizeof(struct dlm_recover), GFP_KERNEL);
+	if (!rv)
+		return -ENOMEM;
+	memset(rv, 0, sizeof(struct dlm_recover));
+
+	spin_lock(&ls->ls_recover_lock);
+
+	if (!ls->ls_nodeids_next) {
+		spin_unlock(&ls->ls_recover_lock);
+		log_error(ls, "existing nodeids_next");
+		kfree(rv);
+		error = -EINVAL;
+		goto out;
+	}
+
+	if (event_nr <= ls->ls_last_start) {
+		spin_unlock(&ls->ls_recover_lock);
+		log_error(ls, "start event_nr %d not greater than last %d",
+			  event_nr, ls->ls_last_start);
+		kfree(rv);
+		error = -EINVAL;
+		goto out;
+	}
+
+	rv->nodeids = ls->ls_nodeids_next;
+	ls->ls_nodeids_next = NULL;
+	rv->node_count = ls->ls_nodeids_next_count;
+	rv->event_id = event_nr;
+	ls->ls_last_start = event_nr;
+	list_add_tail(&rv->list, &ls->ls_recover);
+	set_bit(LSFL_LS_START, &ls->ls_flags);
+	spin_unlock(&ls->ls_recover_lock);
+
+	set_bit(LSFL_JOIN_DONE, &ls->ls_flags);
+	wake_up(&ls->ls_wait_member);
+	dlm_recoverd_kick(ls);
+ out:
+	return error;
+}
+
+int dlm_ls_finish(struct dlm_ls *ls, int event_nr)
+{
+	spin_lock(&ls->ls_recover_lock);
+	if (event_nr != ls->ls_last_start) {
+		spin_unlock(&ls->ls_recover_lock);
+		log_error(ls, "finish event_nr %d doesn't match start %d",
+			  event_nr, ls->ls_last_start);
+		return -EINVAL;
+	}
+	ls->ls_last_finish = event_nr;
+	set_bit(LSFL_LS_FINISH, &ls->ls_flags);
+	spin_unlock(&ls->ls_recover_lock);
+	dlm_recoverd_kick(ls);
+	return 0;
+}
--- a/drivers/dlm/member.h	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/member.h	2005-04-25 22:52:04.019807184 +0800
@@ -0,0 +1,29 @@
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
+#ifndef __MEMBER_DOT_H__
+#define __MEMBER_DOT_H__
+
+int dlm_ls_terminate(struct dlm_ls *ls);
+int dlm_ls_stop(struct dlm_ls *ls);
+int dlm_ls_start(struct dlm_ls *ls, int event_nr);
+int dlm_ls_finish(struct dlm_ls *ls, int event_nr);
+
+void dlm_clear_members(struct dlm_ls *ls);
+void dlm_clear_members_gone(struct dlm_ls *ls);
+void dlm_clear_members_finish(struct dlm_ls *ls, int finish_event);
+int dlm_recover_members_first(struct dlm_ls *ls, struct dlm_recover *rv);
+int dlm_recover_members(struct dlm_ls *ls, struct dlm_recover *rv,int *neg_out);
+int dlm_is_removed(struct dlm_ls *ls, int nodeid);
+
+#endif                          /* __MEMBER_DOT_H__ */
+
