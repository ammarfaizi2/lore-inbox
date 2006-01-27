Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422676AbWA0X1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422676AbWA0X1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422683AbWA0X1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:27:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21383 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422676AbWA0X1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:27:23 -0500
Date: Fri, 27 Jan 2006 15:28:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: paulmck@us.ibm.com
Cc: dada1@cosmosbay.com, dipankar@in.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       nickpiggin@yahoo.com.au, hch@infradead.org
Subject: Re: [patch 2/2] fix file counting
Message-Id: <20060127152857.32066a69.akpm@osdl.org>
In-Reply-To: <20060127231420.GA10075@us.ibm.com>
References: <20060126184010.GD4166@in.ibm.com>
	<20060126184127.GE4166@in.ibm.com>
	<20060126184233.GF4166@in.ibm.com>
	<43D92DD6.6090607@cosmosbay.com>
	<20060127145412.7d23e004.akpm@osdl.org>
	<20060127231420.GA10075@us.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@us.ibm.com> wrote:
>
> > > I am using a patch that seems sligthly better : It removes the filp_count_lock 
> > > as yours but introduces a percpu variable, and a lazy nr_files . (Its value 
> > > can be off with a delta of +/- 16*num_possible_cpus()
> > 
> > Yes, I think that is better.
> 
> I agree that Eric's approach likely improves performance on large systems
> due to decreased cache thrashing.  However, the real problem is getting
> both good throughput and good latency in RCU callback processing, given
> Lee Revell's latency testing results.  Once we get that in hand, then
> we should consider Eric's approach.

Dipankar's patch risks worsening large-SMP scalability, doesn't it? 
Putting an atomic op into the file_free path?

And afaict it fixes up the skew in the nr_files accounting but we're still
exposed to the risk of large amounts of memory getting chewed up due to RCU
latencies?

(And it forgot to initialise the atomic_t)

(And has a couple of suspicious-looking module exports.  We don't support
CONFIG_PROC_FS=m).

