Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWHQPO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWHQPO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 11:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWHQPO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 11:14:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53458 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964930AbWHQPO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 11:14:26 -0400
Date: Thu, 17 Aug 2006 08:14:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Neil Brown <neilb@suse.de>, David Chinner <dgc@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow
 writeback.
Message-Id: <20060817081415.f48fbb37.akpm@osdl.org>
In-Reply-To: <1155818179.5662.19.camel@localhost>
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	<20060815010611.7dc08fb1.akpm@osdl.org>
	<20060815230050.GB51703024@melbourne.sgi.com>
	<17635.60378.733953.956807@cse.unsw.edu.au>
	<20060816231448.cc71fde7.akpm@osdl.org>
	<1155818179.5662.19.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006 08:36:19 -0400
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> On Wed, 2006-08-16 at 23:14 -0700, Andrew Morton wrote:
> > btw, one thing which afaik NFS _still_ doesn't do is to wake up processes
> > which are stuck in blk_congestion_wait() when NFS has retired a bunch of
> > writes.  It should do so, otherwise NFS write-intensive workloads might end
> > up sleeping for too long.  I guess the amount of buffering and hysteresis
> > we have in there has thus far prevented any problems from being observed.
> 
> Are we to understand it that you consider blk_congestion_wait() to be an
> official API, and not just another block layer hack inside the VM?
> 
> 'cos currently the only tools for waking up processes in
> blk_congestion_wait() are the two routines:
> 
>    static void clear_queue_congested(request_queue_t *q, int rw)
> and
>    static void set_queue_congested(request_queue_t *q, int rw)
> 
> in block/ll_rw_blk.c. Hardly a model of well thought out code...
> 

We've been over this before...

Take a look at blk_congestion_wait().  It doesn't know about request
queues.  We'd need a new

void writeback_congestion_end(int rw)
{
	wake_up(congestion_wqh[rw]);
}

or similar.
