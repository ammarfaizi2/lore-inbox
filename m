Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271537AbRIJSSc>; Mon, 10 Sep 2001 14:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271552AbRIJSSW>; Mon, 10 Sep 2001 14:18:22 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:57615 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271537AbRIJSSO>; Mon, 10 Sep 2001 14:18:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Robert Love <rml@tech9.net>
Subject: Re: Feedback on preemptible kernel patch
Date: Mon, 10 Sep 2001 20:25:44 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Arjan Filius <iafilius@xs4all.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109092317330.16723-100000@sjoerd.sjoerdnet> <20010910031728Z16177-26183+705@humbolt.nl.linux.org> <1000098594.18895.1.camel@phantasy>
In-Reply-To: <1000098594.18895.1.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010910181831Z16258-26184+244@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 10, 2001 07:09 am, Robert Love wrote:
> On Sun, 2001-09-09 at 23:24, Daniel Phillips wrote:
> > This may not be your fault.  It's a GFP_NOFS recursive allocation - this
> > comes either from grow_buffers or ReiserFS, probably the former.  In
> > either case, it means we ran completely out of free pages, even though
> > the caller is willing to wait.  Hmm.  It smells like a loophole in vm
> > scanning.
> 
> I am not a VM hacker -- can you tell me where to start? what do you
> suspect it is?
> 
> If the user stops seeing the error with preemption disabled, is your
> theory nulled, or does that just mean the problem is agitated by
> preemption?
> 
> I don't think Arjan was using ReiserFS, so its from grow_buffers...
> 
> I appreciate your help.

The first thing to check is whether memory is really exhausted at the
time the errors are logged (cat /proc/meminfo).  Then you want to see
which paths in __alloc_pages could possibly allow this PF_MEMALLOC +
GFP_WAIT allocation request to drop all the way through without being
serviced.  Sorry, I haven't had time to do that and won't for a few
days.  Even if you triggered it, it is probably a hole in the scan
logic.  We have __GFP_WAIT, so it should wait.

Here's a hint, look very critically at this part of page_alloc.c:

455    /*
456     * Fail in case no progress was made and the
457     * allocation may not be able to block on IO.
458     */
459    return NULL;

--
Daniel
