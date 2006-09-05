Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWIEMJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWIEMJF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 08:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWIEMJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 08:09:04 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:725 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751222AbWIEMJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 08:09:03 -0400
Date: Tue, 5 Sep 2006 14:05:14 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 14/16] GFS2: The DLM interface module
In-Reply-To: <1157031710.3384.811.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609051352110.24010@yvahk01.tjqt.qr>
References: <1157031710.3384.811.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+/* make_strname - convert GFS lock numbers to a string */
>+
>+static inline void make_strname(struct lm_lockname *lockname,
>+				struct gdlm_strname *str)
>+{
>+	sprintf(str->name, "%8x%16llx", lockname->ln_type,
>+		(unsigned long long)lockname->ln_number);

Is this format specifier safe enough? "%08x%016llx" perhaps?

Imagine (if this happens at all):

  ln_type = 1; ln_number = 16;
  %8x = "1", "%16llx" = "10", giving us "110"

  ln_type = 17; ln_number = 0;
  %8x = "11", "%16llx" = "0", giving us "110".

Whoops, name clash.


>+int gdlm_get_lock(lm_lockspace_t *lockspace, struct lm_lockname *name,
>+		  lm_lock_t **lockp)
>+{
>+	struct gdlm_lock *lp;
>+	int error;
>+
>+	error = gdlm_create_lp((struct gdlm_ls *) lockspace, name, &lp);
>+
>+	*lockp = (lm_lock_t *) lp;

This cast is alright in itself. Considering however that lm_lock_t is
currently typedef'ed to void, it looks a little different. (One _could_ get rid
of it, but better not while it is called lm_lock_t. Leave as-is for now.)

>+static wait_queue_head_t send_wq;
>+static wait_queue_head_t recv_wq;
>+
>+struct plock_op {
>+	struct list_head list;
>+	int done;
>+	struct gdlm_plock_info info;
>+};
>+
>+static inline void set_version(struct gdlm_plock_info *info)
>+{
>+	info->version[0] = GDLM_PLOCK_VERSION_MAJOR;
>+	info->version[1] = GDLM_PLOCK_VERSION_MINOR;
>+	info->version[2] = GDLM_PLOCK_VERSION_PATCH;
>+}
>+
>+static int check_version(struct gdlm_plock_info *info)
>+{
>+	if ((GDLM_PLOCK_VERSION_MAJOR != info->version[0]) ||
>+	    (GDLM_PLOCK_VERSION_MINOR < info->version[1])) {
>+		log_error("plock device version mismatch: "
>+			  "kernel (%u.%u.%u), user (%u.%u.%u)",
>+			  GDLM_PLOCK_VERSION_MAJOR,
>+			  GDLM_PLOCK_VERSION_MINOR,
>+			  GDLM_PLOCK_VERSION_PATCH,
>+			  info->version[0],
>+			  info->version[1],
>+			  info->version[2]);
>+		return -EINVAL;
>+	}
>+	return 0;
>+}
>+
>+static void send_op(struct plock_op *op)
>+{
>+	set_version(&op->info);
>+	INIT_LIST_HEAD(&op->list);
>+	spin_lock(&ops_lock);
>+	list_add_tail(&op->list, &send_list);
>+	spin_unlock(&ops_lock);
>+	wake_up(&send_wq);
>+}
>+
>+int gdlm_plock(lm_lockspace_t *lockspace, struct lm_lockname *name,
>+	       struct file *file, int cmd, struct file_lock *fl)
>+{
>+	struct gdlm_ls *ls = (struct gdlm_ls *) lockspace;
>+	struct plock_op *op;
>+	int rv;
>+
>+	op = kzalloc(sizeof(*op), GFP_KERNEL);
>+	if (!op)
>+		return -ENOMEM;
>+
>+	op->info.optype		= GDLM_PLOCK_OP_LOCK;
>+	op->info.pid		= fl->fl_pid;
>+	op->info.ex		= (fl->fl_type == F_WRLCK);
>+	op->info.wait		= IS_SETLKW(cmd);
>+	op->info.fsid		= ls->id;
>+	op->info.number		= name->ln_number;
>+	op->info.start		= fl->fl_start;
>+	op->info.end		= fl->fl_end;
>+	op->info.owner		= (__u64)(long) fl->fl_owner;

Can't op->info.owner be a 'struct fowner *'? Is op->info.owner shared over the
network?

>+static ssize_t block_show(struct gdlm_ls *ls, char *buf)
>+{
>+	ssize_t ret;
>+	int val = 0;
>+
>+	if (test_bit(DFL_BLOCK_LOCKS, &ls->flags))
>+		val = 1;
>+	ret = sprintf(buf, "%d\n", val);

Safe enough - @buf big enough?

>+	if (val == 1)
>+		set_bit(DFL_BLOCK_LOCKS, &ls->flags);
>+	else if (val == 0) {
>+		clear_bit(DFL_BLOCK_LOCKS, &ls->flags);
>+		gdlm_submit_delayed(ls);
>+	} else
>+		ret = -EINVAL;

Ingo surely wants you to {} it.

>+static ssize_t id_show(struct gdlm_ls *ls, char *buf)
>+{
>+	return sprintf(buf, "%u\n", ls->id);
>+}
>+
>+static ssize_t jid_show(struct gdlm_ls *ls, char *buf)
>+{
>+	return sprintf(buf, "%d\n", ls->jid);
>+}
>+
>+static ssize_t first_show(struct gdlm_ls *ls, char *buf)
>+{
>+	return sprintf(buf, "%d\n", ls->first);
>+}
>+
>+static ssize_t first_done_show(struct gdlm_ls *ls, char *buf)
>+{
>+	return sprintf(buf, "%d\n", ls->first_done);
>+}
>+
>+static ssize_t recover_show(struct gdlm_ls *ls, char *buf)
>+{
>+	return sprintf(buf, "%d\n", ls->recover_jid);
>+}

Big enough?

>+static ssize_t recover_done_show(struct gdlm_ls *ls, char *buf)
>+{
>+	return sprintf(buf, "%d\n", ls->recover_jid_done);
>+}
>+
>+static ssize_t recover_status_show(struct gdlm_ls *ls, char *buf)
>+{
>+	return sprintf(buf, "%d\n", ls->recover_jid_status);
>+}





Jan Engelhardt
-- 
