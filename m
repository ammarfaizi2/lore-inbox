Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRKAABe>; Wed, 31 Oct 2001 19:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276468AbRKAABI>; Wed, 31 Oct 2001 19:01:08 -0500
Received: from [208.129.208.52] ([208.129.208.52]:58636 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S276052AbRKAAAr>;
	Wed, 31 Oct 2001 19:00:47 -0500
Date: Wed, 31 Oct 2001 15:53:39 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Kravetz <kravetz@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>,
        Hubertus Franke <frankeh@watson.ibm.com>,
        <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [PATCH][RFC] Proposal For A More Scalable Scheduler
 ...
In-Reply-To: <20011031151243.E1105@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.40.0110311544330.1484-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Mike Kravetz wrote:

> I'm going to try and merge your 'cache warmth' replacement for
> PROC_CHANGE_PENALTY into the LSE MQ scheduler, as well as enable
> the code to prevent task stealing during IPI delivery.  This
> should still be significantly different than your design because
> MQ will still attempt to make global decisions.  Results should
> be interesting.

I'm currently evaluating different weights for that.
Right now I'm using :

    if (p->cpu_jtime > jiffies)
        weight += p->cpu_jtime - jiffies;

that might be too much.
Solutions :

1)
    if (p->cpu_jtime > jiffies)
        weight += (p->cpu_jtime - jiffies) >> 1;

2)
    int wtable[];

    if (p->cpu_jtime > jiffies)
        weight += wtable[p->cpu_jtime - jiffies];

Speed will like 1).
Other optimization is jiffies that is volatile and forces gcc to always
reload it.

static inline int goodness(struct task_struct * p, struct mm_struct
*this_mm, unsigned long jiff)

might be better, with jiffies taken out of the goodness loop.
Mike I suggest you to use the LatSched patch to 1) know how really is
performing the scheduler 2) understand if certain test gives certain
results due wierd distributions.




- Davide


