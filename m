Return-Path: <linux-kernel-owner+w=401wt.eu-S965130AbXAEAgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbXAEAgW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 19:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbXAEAgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 19:36:22 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:53518 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965117AbXAEAgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 19:36:21 -0500
In-Reply-To: <20070103050323.GA3201@in.ibm.com>
References: <20061227153855.GA25898@in.ibm.com> <5A322D46-A73A-43DD-8667-CE218DDA48B0@oracle.com> <20070103050323.GA3201@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FF12832A-4BA3-45EF-AC5A-0828A79CE973@oracle.com>
Cc: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [RFC] Heads up on a series of AIO patchsets
Date: Thu, 4 Jan 2007 16:36:21 -0800
To: suparna@in.ibm.com
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> generic_write_checks() are done in the submission path, not  
> repeated during
> retries, so such types of checks are not intended to run in the aio  
> thread.

Ah, I see, I was missing the short-cut which avoids re-running parts  
of the write path if we're in a retry.

         if (!is_sync_kiocb(iocb) && kiocbIsRestarted(iocb)) {
                 /* nothing to transfer, may just need to sync data */
                 return ocount;

It's pretty subtle that this has to be placed before the first  
significant current reference and that nothing in the path can return  
-EIOCBRETRY until after all of the significant current references.

In totally unrelated news, I noticed that current->io_wait is set to  
NULL instead of &current->__wait after having run the iocb.  I wonder  
if it shouldn't be saved and restored instead.  And maybe update the  
comment over is_sync_wait()?  Just an observation.

> That is great and I look forward to it :) I am, however assuming that
> whatever implementation you come up will have a different interface
> from current linux aio -- i.e. a next generation aio model, that  
> will be
> easily integratable with kevents etc.

Yeah, that's the hope.

> Which takes me back to Ingo's point - lets have the new evolve  
> parallely
> with the old, if we can, and not hold up the patches for POSIX AIO to
> start using kernel AIO, or for epoll to integrate with AIO.

Sure, though there are only so many hours in a day :).

> OK, I just took a quick look at your blog and I see that you
> are basically implementing Linus' microthreads scheduling approach -
> one year since we had that discussion.

Yeah.  I wanted to see what it would look like.

> Glad to see that you found a way to make it workable ...

Wellll, that remains to be seen.  If nothing else we'll at least hav  
code to point at when discussing it.  If we all agree it's not the  
right way and dismiss the notion, fine, that's progress :).

> (I'm guessing that you are copying over the part
> of the stack in use at the time of every switch, is that correct ?

That was my first pass, yeah.  It turned the knob a little too far  
towards the "invasive but efficient" direction for my taste.  I'm now  
giving it a try by having full stacks for each blocked op, we'll see  
how that goes.

> At what
> point do you do the allocation of the saved stacks ?

I was allocating at block-time to keep memory consumption down, but I  
think my fiddling around with it convinced me that isn't workable.

- z
