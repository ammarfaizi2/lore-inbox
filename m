Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWHJBA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWHJBA5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWHJBA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:00:56 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:17634 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932488AbWHJBA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:00:56 -0400
Date: Wed, 9 Aug 2006 18:01:37 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: stelian@popies.net, linux-kernel@vger.kernel.org, paulus@au1.ibm.com,
       anton@au1.ibm.com, open-iscsi@googlegroups.com, pradeep@us.ibm.com,
       mashirle@us.ibm.com
Subject: Re: [PATCH] memory ordering in __kfifo primitives
Message-ID: <20060810010137.GD1291@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060810001823.GA3026@us.ibm.com> <20060809172910.614ad979.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809172910.614ad979.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 05:29:10PM -0700, Andrew Morton wrote:
> On Wed, 9 Aug 2006 17:18:23 -0700
> "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
> 
> > @@ -129,6 +129,8 @@ unsigned int __kfifo_put(struct kfifo *f
> >  	/* then put the rest (if any) at the beginning of the buffer */
> >  	memcpy(fifo->buffer, buffer + l, len - l);
> >  
> > +	smp_wmb();
> > +
> >  	fifo->in += len;
> >  
> >  	return len;
> > @@ -161,6 +163,8 @@ unsigned int __kfifo_get(struct kfifo *f
> >  	/* then get the rest (if any) from the beginning of the buffer */
> >  	memcpy(buffer + l, fifo->buffer, len - l);
> >  
> > +	smp_mb();
> > +
> >  	fifo->out += len;
> >  
> >  	return len;
> 
> When adding barriers, please also add a little comment explaining what the
> barrier is protecting us from.
> 
> Often it's fairly obvious, but sometimes it is not, and in both cases it is still
> useful to communicate the programmer's intent in this way.

I certainly cannot claim that it was obvious in this case, as the act
of adding the comments caused me to realize that I had added only two
of the four memory barriers that are required.  :-/  Updated patch below.

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
---

 kfifo.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+)

diff -urpNa -X dontdiff linux-2.6.18-rc2/kernel/kfifo.c linux-2.6.18-rc2-kfifo/kernel/kfifo.c
--- linux-2.6.18-rc2/kernel/kfifo.c	2006-07-15 14:53:08.000000000 -0700
+++ linux-2.6.18-rc2-kfifo/kernel/kfifo.c	2006-08-09 17:45:41.000000000 -0700
@@ -122,6 +122,13 @@ unsigned int __kfifo_put(struct kfifo *f
 
 	len = min(len, fifo->size - fifo->in + fifo->out);
 
+	/*
+	 * Ensure that we sample the fifo->out index -before- we
+	 * start putting bytes into the kfifo.
+	 */
+
+	smp_mb();
+
 	/* first put the data starting from fifo->in to buffer end */
 	l = min(len, fifo->size - (fifo->in & (fifo->size - 1)));
 	memcpy(fifo->buffer + (fifo->in & (fifo->size - 1)), buffer, l);
@@ -129,6 +136,13 @@ unsigned int __kfifo_put(struct kfifo *f
 	/* then put the rest (if any) at the beginning of the buffer */
 	memcpy(fifo->buffer, buffer + l, len - l);
 
+	/*
+	 * Ensure that we add the bytes to the kfifo -before-
+	 * we update the fifo->in index.
+	 */
+
+	smp_wmb();
+
 	fifo->in += len;
 
 	return len;
@@ -154,6 +168,13 @@ unsigned int __kfifo_get(struct kfifo *f
 
 	len = min(len, fifo->in - fifo->out);
 
+	/*
+	 * Ensure that we sample the fifo->in index -before- we
+	 * start removing bytes from the kfifo.
+	 */
+
+	smp_rmb();
+
 	/* first get the data from fifo->out until the end of the buffer */
 	l = min(len, fifo->size - (fifo->out & (fifo->size - 1)));
 	memcpy(buffer, fifo->buffer + (fifo->out & (fifo->size - 1)), l);
@@ -161,6 +182,13 @@ unsigned int __kfifo_get(struct kfifo *f
 	/* then get the rest (if any) from the beginning of the buffer */
 	memcpy(buffer + l, fifo->buffer, len - l);
 
+	/*
+	 * Ensure that we remove the bytes from the kfifo -before-
+	 * we update the fifo->out index.
+	 */
+
+	smp_mb();
+
 	fifo->out += len;
 
 	return len;
