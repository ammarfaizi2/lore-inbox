Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVGEQZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVGEQZx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 12:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVGEQZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 12:25:42 -0400
Received: from kanga.kvack.org ([66.96.29.28]:60833 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261876AbVGEQLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 12:11:45 -0400
Date: Tue, 5 Jul 2005 12:12:59 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Chris Mason <mason@suse.com>
Cc: suparna@in.ibm.com, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: aio-stress throughput regressions from 2.6.11 to 2.6.12
Message-ID: <20050705161259.GC19683@kvack.org>
References: <20050701075600.GC4625@in.ibm.com> <200507051000.25591.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507051000.25591.mason@suse.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 10:00:24AM -0400, Chris Mason wrote:
> If it doesn't regress, I would suspect something in the aio core.  My first 
> attempts at the context switch reduction patches caused this kind of 
> regression.  There was too much latency in sending the events up to userland.

AIO will by its very nature have a higher rate of context switches unless 
the subsystem in question does its completion from the interrupt handler.  
There are a few optimizations in this area that we can do to improve things 
for some of the common usage models: when sleeping in read_events() we can 
do iocb runs in the sleeping task instead of switching to the aio helper 
daemon.  That might help for Oracle's usage model of aio, and it should 
also help aio-stress.

There are also other ways of reducing the overhead of the context switches.  
O_DIRECT operations could take note of the mm they are operating on and 
do its get_user_pages() on the mm without the tlb being flushed.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
