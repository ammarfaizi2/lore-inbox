Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWBXSIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWBXSIa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 13:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWBXSIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 13:08:30 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:35002 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932409AbWBXSI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 13:08:29 -0500
Subject: Re: [RFC][WIP] DIO simplification and AIO-DIO stability
From: Badari Pulavarty <pbadari@us.ibm.com>
To: suparna@in.ibm.com
Cc: Zach Brown <zach.brown@oracle.com>, akpm@osdl.org, sct@redhat.com,
       mason@suse.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-aio@kvack.org, kenneth.w.chen@intel.com,
       lkml <linux-kernel@vger.kernel.org>, sonny@burdell.org
In-Reply-To: <20060224111239.GA2180@in.ibm.com>
References: <20060223072955.GA14244@in.ibm.com>
	 <43FE5F84.4000001@oracle.com>  <20060224111239.GA2180@in.ibm.com>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 10:09:41 -0800
Message-Id: <1140804586.22756.205.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-24 at 16:42 +0530, Suparna Bhattacharya wrote:
> On Thu, Feb 23, 2006 at 05:21:08PM -0800, Zach Brown wrote:
> > Suparna Bhattacharya wrote:
> > 
> > > A recent AIO-DIO bug reported by Kenneth Chen, came very close
> > > to being the proverbial last straw for me.
> > 
> > Me too, though I found out about it from a different path.  Our QA guys
> > were pulling drives under load and it got stuck.  Trying to fix that bug
> > (io error setting dio->result to -EIO stops finished_one_bio() from
> > calling aio_complete()) without introducing other regressions involved
> > an incredible amount of squinting and head scratching.  In wandering
> > around I found what seem to be other additional bugs:
> > 
> > - errors that hit after dio->result is sampled in the buffered fallback
> > case are lost.  dio->result should be checked again after waiting.
> > 
> > - a few paths try to do arithmetic with dio->result assuming it's the
> > number of bytes transferred when it could be -EIO.
> 
> Yes there is a race in the way dio->result is used both by completion
> path and the post submission path.
> 
> > 
> > - the AIO path seems to forget to check dio->page_errors, but I didn't
> > look very hard to see what that means.
> > 
> > - the AIO bio completion paths don't populate dio->bio_list so reaping
> > doesn't happen in the AIO issuing case.. maybe that's intentional?
> 
> It is intentional. The async case operates differently in that it
> doesn't need/use the reaping logic at all. It just submits the entire
> IO outright, without the pipelining sophistication of the original
> synchronous DIO code. That's yet another point of divergence between
> AIO and synchronous path, perhaps it would have been simpler if both
> followed the same logic.
> 
> > 
> > > It would be quite pointless (and painful!), if the rewrite ends up becoming
> > > just as tricky and error prone as before. Such a patch will need a very
> > > close critical review by many sharp eyes, to avoid disrupting the current
> > > state of stability.
> > 
> > So, I'm all for wringing the current bugs and confusion out of the
> > current code.  But the words "a patch" and "rewrite" terrify me.  It
> 
> Perhaps I shouldn't have used the term rewrite. The proposal retains
> much of the current core logic, but mainly alters the way we
> serialise vs concurrent buffered IO, and other pain points. But it
> would certainly be more than incremental patches to fix individual
> problems.

Yes. locking and error handling desperately needs a re-write, especially
keeping AIO in mind. I would love to see "kicking back to buffered mode"
completely go away. If Ken and Zach are willing to provide help on
looking over & testing error handling cases (with pulling drives :)), 
I have no problem with re-write :)

Thanks,
Badari

