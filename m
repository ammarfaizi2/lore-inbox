Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUCaWv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 17:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUCaWv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 17:51:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:32650 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262648AbUCaWvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 17:51:53 -0500
Date: Wed, 31 Mar 2004 14:53:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, sct@redhat.com,
       drepper@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Message-Id: <20040331145352.23df0831.akpm@osdl.org>
In-Reply-To: <1080771361.1991.73.camel@sisko.scot.redhat.com>
References: <1080771361.1991.73.camel@sisko.scot.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> wrote:
>
> Hi,
> 
> I've been looking at a discrepancy between msync() behaviour on 2.4.9
> and newer 2.4 kernels, and it looks like things changed again in
> 2.5.68.  From the ChangeLog:
> 
> ChangeSet 1.971.76.156 2003/04/09 11:31:36 akpm@digeo.com
>   [PATCH] Make msync(MS_ASYNC) no longer start the I/O
>   
>   MS_ASYNC will currently wait on previously-submitted I/O, then start new I/O
>   and not wait on it.  This can cause undesirable blocking if msync is called
>   rapidly against the same memory.
>   
>   So instead, change msync(MS_ASYNC) to not start any IO at all.  Just flush
>   the pte dirty bits into the pageframe and leave it at that.
>   
>   The IO _will_ happen within a kupdate period.  And the application can use
>   fsync() or fadvise(FADV_DONTNEED) if it actually wants to schedule the IO
>   immediately.
> 
> Unfortunately, this seems to contradict SingleUnix requirements, which
> state:
> 
>         When MS_ASYNC is specified, msync() shall return immediately
>         once all the write operations are initiated or queued for
>         servicing
>         
> although I can't find an unambiguous definition of "queued for service"
> in the online standard.  I'm reading it as requiring that the I/O has
> reached the block device layer, not simply that it has been marked dirty
> for some future writeback pass to catch; Uli agrees with that
> interpretation.

I don't think I agree with that.  If "queued for service" means we've
started the I/O, then what does "initiated" mean, and why did they specify
"initiated" separately?


What triggered all this was a dinky little test app which Linus wrote to
time some aspect of P4 tlb writeback latency.  It sits in a loop dirtying a
page then msyncing it with MS_ASYNC.  It ran very poorly, because MS_ASYNC
ended up waiting on the previously-submitted I/O before starting new I/O.

One approach to improving that would be for MS_ASYNC to say "if the page is
already under writeout then just skip the I/O".  But that's worthless,
really - it makes the MS_ASYNC semantics too vague.

As you point out, Linus's app should have used the "flags=0" linux
extension.  Didn't think of that.

Your reversion patch would mean that current applications which use
MS_ASYNC will again suffer large latencies if the pages are under writeout.
Sure, users could switch apps to using flags=0 to avoid that, but people
don't know to do that.

So given that SUS is ambiguous about this, I'd suggest that we be able to
demonstrate some real-world reason why this matters.  Why are you concerned
about this?


> The 2.5.68 changeset also includes the comment:
> 
>   (This has triggered an ext3 bug - the page's buffers get dirtied so fast
>   that kjournald keeps writing the buffers over and over for 10-20 seconds
>   before deciding to give up for some reason)
> 
> Was that ever resolved?  If it's still there, I should have a look at it
> if we're restoring the old trigger.

(These changelog thingies are useful, aren't they?)

I don't recall checking since that time.  I expect that Linus's test app
will still livelock kjournals in the current -linus tree - kjournald sits
there trying to write out the dirty buffers but the dang things just keep
on getting dirtied.

If so, I'm sure this patch (queued for 2.6.6) will fix it:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc3/2.6.5-rc3-mm3/broken-out/jbd-move-locked-buffers.patch

