Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVCHKUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVCHKUK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVCHKUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:20:08 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:33491 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261956AbVCHKRb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:17:31 -0500
Date: Tue, 8 Mar 2005 15:57:00 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: sebastien.dugue@bull.net, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, pbadari@us.ibm.com, daniel@osdl.org
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
Message-ID: <20050308102700.GA4207@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1110189607.11938.14.camel@frecb000686> <20050307223917.1e800784.akpm@osdl.org> <20050308090946.GA4100@in.ibm.com> <20050308011814.706c094e.akpm@osdl.org> <20050308094159.GA4144@in.ibm.com> <20050308014141.08a546a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308014141.08a546a9.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 01:41:41AM -0800, Andrew Morton wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >
> > > > can you spot what is going wrong here that we have to try and
> >  > > workaround this later ?
> >  > 
> >  > Good question.  Do we have the i_sem coverage to prevent a concurrent
> >  > truncate?
> >  > 
> >  > But from Sebastien's description it doesn't soound as if a concurrent
> >  > truncate is involved.
> > 
> >  Daniel McNeil has a testcase that reproduces the problem - seemed
> >  like a single thread thing - that's what puzzles me.
> 
> OK.  It'd be nice if we could find a solution which gets around that i_size
> access in the ISR, if someone has the time to look into it?

We hold i_alloc_sem right until dio_complete, don't we ? Is it still
a problem ? 

But, I'm wondering if this solution just covers up the real reason
for the single thread problem ? We shouldn't even be issuing IOs
beyond i_size into the user-space buffer !

BTW, part of what I'd have liked in a rewrite would be to unify more of the
AIO and sync io paths, consider doing all this in task context (like in
the retry code) etc. Would reduce the number of cases to watch out for. 
But that's a different matter, not for now. I agree that the buffered 
vs DIO stuff in combo with AIO is what makes this really complex, so
it is a hard problem.

Regards
Suparna

> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

