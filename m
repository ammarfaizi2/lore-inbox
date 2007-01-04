Return-Path: <linux-kernel-owner+w=401wt.eu-S932271AbXADEwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbXADEwx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 23:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbXADEwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 23:52:53 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:41418 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932256AbXADEww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 23:52:52 -0500
Date: Thu, 4 Jan 2007 10:26:21 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-aio@kvack.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
Subject: Re: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
Message-ID: <20070104045621.GA8353@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20070103141556.82db0e81.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103141556.82db0e81.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 02:15:56PM -0800, Andrew Morton wrote:
> On Thu, 28 Dec 2006 13:53:08 +0530
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> 
> > This patchset implements changes to make filesystem AIO read
> > and write asynchronous for the non O_DIRECT case.
> 
> Unfortunately the unplugging changes in Jen's block tree have trashed these
> patches to a degree that I'm not confident in my repair attempts.  So I'll
> drop the fasio patches from -mm.

I took a quick look and the conflicts seem pretty minor to me, the unplugging
changes mostly touch nearby code. Please let know how you want this fixed
up.

>From what I can tell the comments in the unplug patches seem to say that
it needs more work and testing, so perhaps a separate fixup patch may be
a better idea rather than make the fsaio patchset dependent on this.

> 
> Zach's observations regarding this code's reliance upon things at *current
> sounded pretty serious, so I expect we'd be seeing changes for that anyway?

Not really, at least nothing that I can see needing a change.
As I mentioned there is no reliance on *current in the code that
runs in the aio threads that we need to worry about. 

The generic_write_checks etc that Zach was referring to all happens in the
context of submitting process, not in retry context. The model is to perform
all validation at the time of io submission. And of course things like
copy_to_user() are already taken care of by use_mm().

Lets look at it this way - the kernel already has the ability to do 
background writeout on behalf of a task from a kernel thread and likewise
read(ahead) pages that may be consumed by another task. There is also the
ability to operate another task's address space (as used by ptrace).

So there is nothing groundbreaking here.

In fact on most occasions, all the IO is initiated in the context of the
submitting task, so the aio threads mainly deal with checking for completion
and transfering completed data to user space.

> 
> Plus Jens's unplugging changes add more reliance upon context inside
> *current, for the plugging and unplugging operations.  I expect that the
> fsaio patches will need to be aware of the protocol which those proposed
> changes add.

Whatever logic applies to background writeout etc should also just apply
as is to aio worker threads, shouldn't it ? At least at a quick glance I
don't see anything special that needs to be done for fsaio, but its good
to be aware of this anyway, thanks !

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

