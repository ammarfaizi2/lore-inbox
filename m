Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWC1Rzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWC1Rzd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWC1Rzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:55:33 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:3764 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932118AbWC1Rzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:55:32 -0500
Date: Tue, 28 Mar 2006 11:55:11 -0600
From: Dimitri Sivanich <sivanich@sgi.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu, roe@sgi.com, steiner@sgi.com,
       clameter@sgi.com
Subject: Re: [PATCH] Call get_time() only when necessary in run_hrtimer_queue
Message-ID: <20060328175511.GC13918@sgi.com>
References: <20060324175136.GA10186@sgi.com> <20060324142849.5cc27edb.akpm@osdl.org> <20060328165127.GC10411@sgi.com> <442974BC.30304@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442974BC.30304@cosmosbay.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 07:39:08PM +0200, Eric Dumazet wrote:
> >
> >Index: linux/kernel/hrtimer.c
> >===================================================================
> >--- linux.orig/kernel/hrtimer.c	2006-03-27 09:43:40.000000000 -0600
> >+++ linux/kernel/hrtimer.c	2006-03-27 12:35:47.416054373 -0600
> >@@ -604,14 +604,17 @@ int hrtimer_get_res(const clockid_t whic
> >  */
> > static inline void run_hrtimer_queue(struct hrtimer_base *base)
> > {
> >-	struct rb_node *node;
> >+	struct rb_node *node = base->first;
> >+
> >+	if (!node)
> >+		return;
> > 
> > 	if (base->get_softirq_time)
> > 		base->softirq_time = base->get_softirq_time();
> > 
> > 	spin_lock_irq(&base->lock);
> > 
> >-	while ((node = base->first)) {
> >+	while (node) {
> 
> Are you sure of this change ?
> 
> base->first may have changed just before you locked the base->lock 
> (spin_lock_irq(&base->lock);)
>

We could the following simpler change instead:

Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>

Index: linux/kernel/hrtimer.c
===================================================================
--- linux.orig/kernel/hrtimer.c	2006-03-28 11:46:45.279722496 -0600
+++ linux/kernel/hrtimer.c	2006-03-28 11:51:36.722469752 -0600
@@ -606,6 +606,9 @@ static inline void run_hrtimer_queue(str
 {
 	struct rb_node *node;
 
+	if (!base->first)
+		return;
+
 	if (base->get_softirq_time)
 		base->softirq_time = base->get_softirq_time();
 

