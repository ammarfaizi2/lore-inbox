Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUH0Nlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUH0Nlg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 09:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUH0Nlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 09:41:35 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:16519 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S261169AbUH0Nld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 09:41:33 -0400
Date: Fri, 27 Aug 2004 15:39:47 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org, Albert Cahalan <albert@users.sf.net>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [1/2][PATCH] nproc: netlink access to /proc information
Message-ID: <20040827133947.GA23844@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Albert Cahalan <albert@users.sf.net>,
	William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>
References: <20040827122412.GA20052@k3.hellgate.ch> <20040827122435.GA20334@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827122435.GA20334@k3.hellgate.ch>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I failed to mention that the patch is missing some rather basic locking
(say, in nproc_select_pid). Yeah, it is _that_ experimental :-/. I ignored
the locking issue when mulling over the semantics of the new interface and
forgot it later.

The patch below should be an improvement.

Roger

--- kernel/nproc.c.01	2004-08-27 15:38:36.686602557 +0200
+++ kernel/nproc.c	2004-08-27 15:38:36.686602557 +0200
@@ -278,18 +278,23 @@ int nproc_select_pid(struct nlmsghdr *nl
 
 	for (i = 0; i < tcnt; i++) {
 		task_t *tsk;
+		read_lock(&tasklist_lock);
 		tsk = find_task_by_pid(pids[i]);
+		if (tsk)
+			get_task_struct(tsk);
+		read_unlock(&tasklist_lock);
+		if (!tsk)
+			goto err_srch;
 		pdebug("task found for pid %d: %s.\n", pids[i], tsk->comm);
-		if (!tsk) {
-			err = -ESRCH;
-			goto out;
-		}
 		err = nproc_pid_fields(nlh, fdata, len, tsk);
+		put_task_struct(tsk);
 	}
 
-out:
 	return err;
 
+err_srch:
+	return -ESRCH;
+
 err_inval:
 	return -EINVAL;
 }
