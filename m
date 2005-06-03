Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVFCHzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVFCHzH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 03:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVFCHzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 03:55:07 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:48020 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261174AbVFCHzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 03:55:00 -0400
In-Reply-To: <20050602154333.33df8335.akpm@osdl.org>
Subject: Re: [patch 6/11] s390: in_interrupt vs. in_atomic.
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OF70B2F27D.009D5702-ONC1257015.002B0625-C1257015.002B7793@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 3 Jun 2005 09:54:46 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 03/06/2005 09:54:53
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The condition for no context in do_exception checks for hard and
> > soft interrupts by using in_interrupt() but not for preemption.
> > This is bad for the users of __copy_from/to_user_inatomic because
> > the fault handler might call schedule although the preemption
> > count is != 0. Use in_atomic() instead in_interrupt().
> >
>
> hm.  Under what circumstances do you expect this test to trigger?

e.g. by the following:

static inline int get_futex_value_locked(int *dest, int __user *from)
{
        int ret;

        inc_preempt_count();
        ret = __copy_from_user_inatomic(dest, from, sizeof(int));
        dec_preempt_count();
        preempt_check_resched();

        return ret ? -EFAULT : 0;
}

in_interrupt only checks for HARDIRQ_MASK and SOFTIRQ_MASK but not
for the preemption counter. This is not a theory, we had a bug report
concerning a "bad: scheduling while atomic!" warning.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


