Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWBJR3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWBJR3i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWBJR3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:29:38 -0500
Received: from science.horizon.com ([192.35.100.1]:13623 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751349AbWBJR3h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:29:37 -0500
Date: 10 Feb 2006 12:29:29 -0500
Message-ID: <20060210172929.27423.qmail@science.horizon.com>
From: linux@horizon.com
To: nickpiggin@yahoo.com.au, torvalds@osdl.org
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux@horizon.com,
       sct@redhat.com
In-Reply-To: <Pine.LNX.4.64.0602100759190.19172@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arrgh.  You're being thick.  So I'm going to try to be very clear.

> But that's what MS_SYNC is. MS_SYNC says "I need this data written now".
> 
> MS_ASYNC moves it into the page cache. That makes 100% sense. Then it will 
> be written by the regular dirty page writeout. That makes 100% sense. 

No.  MS_ASYNC says "I need the data written now.".  MS_SYNC says
"I need the data to have been written."  Notice the difference:
one is in the future tense and one is in the past tense.

One is "get to work" and the other is "are you done yet?"

>> I don't think there's anything wrong with your fadvise additions.
>> I'd rather see MS_ASYNC start IO immediately and add another MS_
>> flag for Linux to propogate bits.

> Why? I miss the _reason_ you want to do this.

I believe we all agree that MS_ASYNC is at most a performance hint.
It doesn't give any firm guarantee about when the write will happen, just
"soon".  Deleting every msync(MS_ASYNC) from a program cannot make it
buggier, just possibly slower.

Further, among the various discussions, we have identified two possible
cases where someone might want to give a hint to the operating system
that it would be a Good Idea to copy some dirty data to backing storage:

1) The application is done writing the data, and it's just a hint to
   the VM system that there's no sense procrastinating.  This is purely
   as kindness to the VM system; the application never intends check
   up on the write with MS_SYNC.  The data is still wanted for read,
   so MADV_DONTNEED would be inappropraite.
2) The application is going to invoke MS_SYNC some time in the
   future and it would appreciate it if the job were already started.

(If you can think of a third, please mention it.)

Moving the data to the page cache addresses #1.
I want to address #2.

As you yourself have pointed out, there are zero promises unless you
follow up with MS_SYNC or equivalent.  If you don't, all you're doing
is offering a clue to the VM system.  That's a very optional hint;
It'll get around to cleaning the page itself if it needs the space.

But now suppose we *do* follow up with MS_SYNC.  In this case,
the hint given by MS_ASYNC is a little more pointed: I am going
to need this write completed soon, so don't delay.

The only thing we can argue about here is the granularity.  Is buffering
the hinted data for 5 to 30 seconds to do a bulk write appropriate?
Will it be at least that long before the MS_SYNC request arrives?  Or,
as in my application, are times well under 1 second more common?

My opinion is that people don't like waiting 5 seconds for computers
to do their stuff.  Not a lot of applications take that long to
generate all the data they're going to.


Now, I'm not saying that both of these can't be useful, and for the
first, just marking the page cache dirty isn't good enough.

But if you read the standard definition of MS_ASYNC, it seems absolutely
crystal "anybody who can't see this is an illiterate moron" clear
that MS_ASYNC is described as useful for use case #2.

If you want to add support for case #1 with a longer timeout and big
batches, then you'll have to add another option.  I might point out
that msync() with flags = 0 has done that on Linux for a while.

But if you're providing separate support for both use cases, then
please RTFS and notice which one is closer to the documented
behaviour of MS_ASYNC and thereby deserves the standard flag name.

Here's a quote to help you, from IEEE STS 1003.1-2001:
# When MS_ASYNC is specified, msync() shall return immediately once all
# the write operations are initiated or queued for servicing

You can language lawyer if you like, but when I tell you to "buy a
ticket or join the queue", I expect you to be waiting in the queue to
buy tickets, not some other, slower queue.  And I expect you to know
that unless you're deliberately being difficult.

> The current MS_ASYNC behaviour is the sane one. It's the one that doesn't 
> cause the harddisk to start ticking senselessly. It's the one that allows 
> a person on a laptop to say "don't write dirty data every 5 seconds - do 
> it just every hour".

IT's not sane, it's just useless.  What application is going to wait
even 5 seconds to follow up with MS_SYNC?  Software timeouts are
a bit shorters than the snooze button on your alarm clock.

> In contrast, _your_ proposal is just inflexible and inconvenient.

I can't comment on flexibility, but it's very convenient for a
clearly defined set of applications (which I happen to be maintaining
one of), and has the advantage of being specified in the relevant
Unix standards.

> If somebody really really wants to "start flushing data now", then he can 
> do so, but that actually has absolutely zero to do with "msync()" any 
> more. A person who wants the flushing to start "now" might want to flush 
> any random dirty buffers.

No, they want to flush just the data that they're going to wait on the
completion of the 

As I said, it's a poor man's asynchronous I/O.  Funn async I/O is
probably more flexible, but isn't wiely deployed yet.

> Your suggestion is no different from saying "we should make every 
> 'write()' call start the IO". Which is obviously crap.

NO, dammit!  That would be the equivalent of saying that every memory write
to an mmapped page should start the I/O.  Which is, indeed, obviously
crap.  If you don't have any particular schedule for performing the
write-back, then don't do anything at all!  The VM system will clean the
page when it needs the RAM for something else.

The only reason for calling msync(MS_ASYNC) is because I have a deadline
in mind, and I think that for an OS to assume that it doesn't need to take
action on that advance warning for 5 seconds or so grossly overestimating
the time scales at which computers work these dats.


Used as a basic async I/O primitive, MS_ASYNC lets you start multiple
writes, and then you can wait for completion with MS_SYNC without
forcing an execution order on the OS.  If the data hasn't been dirtied
in between, MS_SYNC is just waiting for the in-progress I/O to
complete.  (You can use MADV_WILLNEED similarly for reads.)


MS_ASYNC is all about performance.  That's its only possible use.
Sticking a 5-second delay into a performance hint is the "obviously
crap" in this discussion.

Sheesh!
