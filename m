Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbVKJOAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVKJOAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVKJOAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:00:51 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:49597 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750888AbVKJOAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:00:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=rVM6lS4ugmm132/QLvhvqfZhZwNSz1Rsoh9DzEN6xUlVxYIJ1keBhLouqOp2uqHVCv8FR7AImYxFea/rxoChG7shELoe8EBubAeq0ohAkqasuUiGQZdWnXC1smU0Ow14/IgQAtKKcikYiVF1nePKm77yFqn9w9Giut5LESJ36S8=
Date: Thu, 10 Nov 2005 23:00:42 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] cfq-iosched: fix slice_left calculation
Message-ID: <20051110140042.GA25774@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When cfq slice expires, remainder of slice is calculated and stored in
cfqq->slice_left.  Current code calculates the opposite of remainder -
how many jiffies the cfqq has used past slice end.  This patch fixes
the bug.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -861,8 +861,8 @@ __cfq_slice_expired(struct cfq_data *cfq
 	 * store what was left of this slice, if the queue idled out
 	 * or was preempted
 	 */
-	if (time_after(now, cfqq->slice_end))
-		cfqq->slice_left = now - cfqq->slice_end;
+	if (time_after(cfqq->slice_end, now))
+		cfqq->slice_left = cfqq->slice_end - now;
 	else
 		cfqq->slice_left = 0;
 
