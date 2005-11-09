Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbVKIRNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbVKIRNZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVKIRNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:13:25 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:9414 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751419AbVKIRNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:13:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=NbxcM7w4lotjyeQG+1yhGZDTu/GDDlfl5z0KDxk1wOVnm8UoGSPzW7TjXbo0AVqDuJzb87mVb1f2/P1gOKy/CkDaK6SOa3/8eqgBFioQEfWI6NhvVWvECahTni1g/lOOz4Tlyw16Rl3QQC4SgUEk4eR9slpEsP3Y10LUJDBpl0Y=
Date: Thu, 10 Nov 2005 02:13:17 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] blk: run queue in elevator_switch
Message-ID: <20051109171317.GB24115@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

elevator_dispatch needs to run queue after forced dispatching;
otherwise, the queue might stall.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/block/elevator.c b/block/elevator.c
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -695,6 +695,8 @@ static void elevator_switch(request_queu
 		;
 
 	while (q->rq.elvpriv) {
+		blk_remove_plug(q);
+		q->request_fn(q);
 		spin_unlock_irq(q->queue_lock);
 		msleep(10);
 		spin_lock_irq(q->queue_lock);
