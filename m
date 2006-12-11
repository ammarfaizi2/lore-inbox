Return-Path: <linux-kernel-owner+w=401wt.eu-S936615AbWLKPl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936615AbWLKPl4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 10:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936649AbWLKPl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 10:41:56 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:60145 "EHLO
	mailer.campus.mipt.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936615AbWLKPlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 10:41:55 -0500
Date: Mon, 11 Dec 2006 18:45:19 +0300
Message-Id: <200612111545.kBBFjJEl012709@vass.7ka.mipt.ru>
From: Vasily Tarasov <vtaras@openvz.org>
To: Jens Axboe <jens.axboe@oracle.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Kirill Korotaev <dev@openvz.org>
CC: OpenVZ Developers List <devel@openvz.org>
Subject: [PATCH] cfq: wrong sync writes detection
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 11 Dec 2006 18:42:34 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CFQ I/O scheduler does the following actions to
find out whether the request is sync:

rw = rq_data_dir(rq); => possible values for rw are 0 or 1

static inline pid_t cfq_queue_pid(struct task_struct *task, int rw)
{
        if (rw == READ || rw == WRITE_SYNC) => second condition is always false
                return task->pid;

        return CFQ_KEY_ASYNC;
}

The following patch fixes the bug by adding sync parameter,
wich is obtained through bio_sync macros.

Signed-off-by: Vasily Tarasov <vtaras@openvz.org>

--

--- ./block/cfq-iosched.c.syncwrite	2006-09-20 07:42:06.000000000 +0400
+++ ./block/cfq-iosched.c	2006-12-11 07:23:03.000000000 +0300
@@ -324,9 +324,9 @@ static int cfq_queue_empty(request_queue
 	return !cfqd->busy_queues;
 }
 
-static inline pid_t cfq_queue_pid(struct task_struct *task, int rw)
+static inline pid_t cfq_queue_pid(struct task_struct *task, int rw, int sync)
 {
-	if (rw == READ || rw == WRITE_SYNC)
+	if (rw == READ || sync)
 		return task->pid;
 
 	return CFQ_KEY_ASYNC;
@@ -621,7 +621,7 @@ static struct request *
 cfq_find_rq_fmerge(struct cfq_data *cfqd, struct bio *bio)
 {
 	struct task_struct *tsk = current;
-	pid_t key = cfq_queue_pid(tsk, bio_data_dir(bio));
+	pid_t key = cfq_queue_pid(tsk, bio_data_dir(bio), bio_sync(bio));
 	struct cfq_queue *cfqq;
 	struct rb_node *n;
 	sector_t sector;
@@ -1958,7 +1958,8 @@ static int cfq_may_queue(request_queue_t
 	 * so just lookup a possibly existing queue, or return 'may queue'
 	 * if that fails
 	 */
-	cfqq = cfq_find_cfq_hash(cfqd, cfq_queue_pid(tsk, rw), tsk->ioprio);
+	cfqq = cfq_find_cfq_hash(cfqd, cfq_queue_pid(tsk, rw,
+					bio_sync(bio)), tsk->ioprio);
 	if (cfqq) {
 		cfq_init_prio_data(cfqq);
 		cfq_prio_boost(cfqq);
@@ -2020,7 +2021,7 @@ cfq_set_request(request_queue_t *q, stru
 	struct task_struct *tsk = current;
 	struct cfq_io_context *cic;
 	const int rw = rq_data_dir(rq);
-	pid_t key = cfq_queue_pid(tsk, rw);
+	pid_t key = cfq_queue_pid(tsk, rw, bio_sync(bio));
 	struct cfq_queue *cfqq;
 	struct cfq_rq *crq;
 	unsigned long flags;

