Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161253AbWAMH4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161253AbWAMH4L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 02:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWAMH4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 02:56:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62397 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932678AbWAMH4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 02:56:10 -0500
Date: Thu, 12 Jan 2006 23:55:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [PATCH] reiserfs: use __GFP_NOFAIL instead of yield and retry
 loop for allocation
Message-Id: <20060112235548.0e1e4343.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0601130944360.20349@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0601130932090.17696@sbz-30.cs.Helsinki.FI>
	<20060112234238.01979912.akpm@osdl.org>
	<Pine.LNX.4.58.0601130944360.20349@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
>
> Hi,
> 
> Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
> > >
> > >  -      retry:
> > >  -	jl = kzalloc(sizeof(struct reiserfs_journal_list), GFP_NOFS);
> > >  -	if (!jl) {
> > >  -		yield();
> > >  -		goto retry;
> > >  -	}
> > >  +	jl = kzalloc(sizeof(struct reiserfs_journal_list),
> > >  +		     GFP_NOFS | __GFP_NOFAIL);
> 
> On Thu, 12 Jan 2006, Andrew Morton wrote:
> > yup, that's what __GFP_NOFAIL is for: to consolidate and identify all those
> > places which want to lock up when we're short of memory...  They all need
> > fixing, really.
> 
> Out of curiosity, are there any potential problems with combining GFP_NOFS 
> and __GFP_NOFAIL? Can we really guarantee to give out memory if we're not 
> allowed to page out?
> 

GFP_NOFS increases the risk (relative to GFP_KERNEL) because page reclaim
can do less things than GFP_KERNEL to free memory.

GFP_NOFS allocations can still perform swapspace writes, however.  GFP_NOIO
cannot even do that.
