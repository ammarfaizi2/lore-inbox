Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWIEOR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWIEOR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 10:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWIEOR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 10:17:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18330 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964989AbWIEOR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 10:17:57 -0400
Subject: Re: [PATCH 11/16] GFS2: Quota and LVB handling
From: Steven Whitehouse <swhiteho@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
In-Reply-To: <Pine.LNX.4.61.0609051142550.32409@yvahk01.tjqt.qr>
References: <1157031525.3384.805.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.61.0609051142550.32409@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 05 Sep 2006 15:23:42 +0100
Message-Id: <1157466222.3384.1019.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-09-05 at 11:56 +0200, Jan Engelhardt wrote:
> >+static uint64_t qd2offset(struct gfs2_quota_data *qd)
> >+{
> >+	uint64_t offset;
> >+
> >+	offset = 2 * (uint64_t)qd->qd_id + !test_bit(QDF_USER, &qd->qd_flags);
> 
> At the moment this (test_bit) might work, because the only other quota besides
> USER is GROUP. But think of XFS, it has a third quota type. With !test_bit, +1
> would be added for GROUP and PROJECT (3rd xfs quota type), although PROJECT
> would likely need +2 by then.
> 
Yes, I think that might have to go on the todo list for now though as
its a more invasive change.


> 
> >+static int sort_qd(const void *a, const void *b)
> >+{
Now with early returns and const.

> >+	x = qc->qc_change;
> >+	x = be64_to_cpu(x) + change;
> >+	qc->qc_change = cpu_to_be64(x);
> 
> There probably is a reason (apart from styling, Ingo) why it's not
> 
> 	qc->qc_change = cpu_to_be64(be64_to_cpu(qc->qc_change) + change);
> 
> Do some architectures do this conversion in more than one step? That is, is
> there risk of having undefined behavior in the expression evaluation of above
> statement like there is in ..?
> 
> 	printf("%d\n", c, modify_int(&c));
> 
I've left this as it is for the time being, but I can't see a reason why
that should be a problem myself.

> >+static int gfs2_adjust_quota(struct gfs2_inode *ip, loff_t loc,
> >+			     int64_t change, struct gfs2_quota_data *qd)
> >+{
> >+	unsigned offset = loc & (PAGE_CACHE_SHIFT - 1);
> >+	void *kaddr;
> >+	__be64 *ptr;
> >+
> >+	kaddr = kmap_atomic(page, KM_USER0);
> >+	ptr = (__be64 *)(kaddr + offset);
> 
> Nocast I'd say.
> 
ok.

> >+#if 0
> >+	qd->qd_qb.qb_limit = cpu_to_be64(q.qu_limit);
> >+	qd->qd_qb.qb_warn = cpu_to_be64(q.qu_warn);
> >+#endif
> 
> Enable or disable.
> 
> >+#if 0
> 
> Yes or no. :)
> 
All removed now. The patch is:

http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=48fac1790935ef2f9548d92e7c8ba604d1b80c12

Steve.



