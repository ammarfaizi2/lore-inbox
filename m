Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWIEKAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWIEKAX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 06:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWIEKAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 06:00:23 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:17560 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750792AbWIEKAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 06:00:21 -0400
Date: Tue, 5 Sep 2006 11:56:30 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 11/16] GFS2: Quota and LVB handling
In-Reply-To: <1157031525.3384.805.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609051142550.32409@yvahk01.tjqt.qr>
References: <1157031525.3384.805.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+static uint64_t qd2offset(struct gfs2_quota_data *qd)
>+{
>+	uint64_t offset;
>+
>+	offset = 2 * (uint64_t)qd->qd_id + !test_bit(QDF_USER, &qd->qd_flags);

At the moment this (test_bit) might work, because the only other quota besides
USER is GROUP. But think of XFS, it has a third quota type. With !test_bit, +1
would be added for GROUP and PROJECT (3rd xfs quota type), although PROJECT
would likely need +2 by then.

>+	offset *= sizeof(struct gfs2_quota);
>+
>+	return offset;
>+}
>+

>+ found:
>+	for (b = 0; b < 8; b++)
>+		if (!(byte & (1 << b)))
>+			break;
>+	qd->qd_slot = c * (8 * PAGE_SIZE) + o * 8 + b;



>+static int sort_qd(const void *a, const void *b)
>+{
>+	struct gfs2_quota_data *qd_a = *(struct gfs2_quota_data **)a;
>+	struct gfs2_quota_data *qd_b = *(struct gfs2_quota_data **)b;
>+	int ret = 0;
>+
>+	if (!test_bit(QDF_USER, &qd_a->qd_flags) !=
>+	    !test_bit(QDF_USER, &qd_b->qd_flags)) {
>+		if (test_bit(QDF_USER, &qd_a->qd_flags))
>+			ret = -1;
>+		else
>+			ret = 1;
>+	} else {
>+		if (qd_a->qd_id < qd_b->qd_id)
>+			ret = -1;
>+		else if (qd_a->qd_id > qd_b->qd_id)
>+			ret = 1;
>+	}
>+
>+	return ret;
>+}

Here is another const candidate. And you can use early-returns[1]. 

[1] Like @@ -1213,31 +1213,26 @@ in
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=75d3b817a0b48425da921052955cc58f20bbab52

>+	x = qc->qc_change;
>+	x = be64_to_cpu(x) + change;
>+	qc->qc_change = cpu_to_be64(x);

There probably is a reason (apart from styling, Ingo) why it's not

	qc->qc_change = cpu_to_be64(be64_to_cpu(qc->qc_change) + change);

Do some architectures do this conversion in more than one step? That is, is
there risk of having undefined behavior in the expression evaluation of above
statement like there is in ..?

	printf("%d\n", c, modify_int(&c));

>+static int gfs2_adjust_quota(struct gfs2_inode *ip, loff_t loc,
>+			     int64_t change, struct gfs2_quota_data *qd)
>+{
>+	unsigned offset = loc & (PAGE_CACHE_SHIFT - 1);
>+	void *kaddr;
>+	__be64 *ptr;
>+
>+	kaddr = kmap_atomic(page, KM_USER0);
>+	ptr = (__be64 *)(kaddr + offset);

Nocast I'd say.

>+#if 0
>+	qd->qd_qb.qb_limit = cpu_to_be64(q.qu_limit);
>+	qd->qd_qb.qb_warn = cpu_to_be64(q.qu_warn);
>+#endif

Enable or disable.

>+#if 0

Yes or no. :)

>+int gfs2_quota_read(struct gfs2_sbd *sdp, int user, uint32_t id,
>+		    struct gfs2_quota *q)
>+{
>+	struct gfs2_quota_data *qd;
>+	struct gfs2_holder q_gh;
>+	int error;
>+
>+	if (((user) ? (id != current->fsuid) : (!in_group_p(id))) &&



Jan Engelhardt
-- 
