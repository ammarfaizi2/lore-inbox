Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWCDDmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWCDDmk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 22:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWCDDmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 22:42:40 -0500
Received: from smtp-out.google.com ([216.239.45.12]:34466 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750833AbWCDDmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 22:42:39 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=AtFwrLFLBLwoq0foQ4Op7+VRQZoA5Prw3yHNI0h4unLJQl68SezBCY19OZCbNwGe5
	mpz00ak4OYZBeMMkKKJtw==
Message-ID: <44090CA1.5000705@google.com>
Date: Fri, 03 Mar 2006 19:42:25 -0800
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Fasheh <mark.fasheh@oracle.com>
CC: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: Ocfs2 performance bugs of doom
References: <4408C2E8.4010600@google.com> <20060304005315.GG31587@ca-server1.us.oracle.com>
In-Reply-To: <20060304005315.GG31587@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fasheh wrote:
> I completely agree that we need to increase the memory dedicated to the
> hash, but I fear that vmallocing a 1 megabyte table per domain (effectively
> per mount) is going overboard. I will assume that this was a straw man patch
> :)

A meg's worth of vmalloc is a small price to pay for killing off the current
gross cpu wastage.  After that you get into various fiddling that really does
not matter much compared to the next half dozen items on the sucks-most list.

>>Of course the Right Think To Do is kmalloc a vector of pages and mask the
>>hash into it, but as a lazy person I would rather sink the time into
>>writing this deathless prose.
> 
> Right. That's one possible approach - I was originally thinking of
> allocating a large global lockres hash table allocated at module init time.
> This way we don't have to make large allocs for each domain.
> 
> Before anything else though, I'd really like to get an idea of how large we
> want things. This might very well dictate the severity of the solution.

I made the table big enough to stomp the lookup overhead into insignificance
up to the point your lock purging kicks in.  If you want to adjust one you
also want to adjust the other, they go together.  As a rough rule of thumb,
handling about 100,000 cached locks efficiently seems right to me.
Eventually, somebody will want to handle way more or way less than that, but
right now that requirement is pretty theoretical.

>>I failed to quantify the improvement precisely because there are other
>>glitchy things going on that interfere with accurate measurement. So now
>>we get to...
> 
> Definitely if you get a chance to show how much just the lookup optimization
> helps, I'd like to know. I'll also try to gather some numbers.

To test this I set the hash table size even lower than you originally had it
and I think the simple-minded loop optimization improved throughput by some
double digit's worth of percent.  In other words, well worth the two line
additional test.

>> ...look at real time for the untar and sync!
> 
> Indeed. The real time numbers are certainly confusing. I actually saw real
> time decrease on most of my tests (usually I hack things to increase the
> hash allocation to something like a few pages). I want to do some more
> consecutive untars though.

This is major badness, but who knows, it might not even be in ocfs2 itself.
A lazy person might wait for the next point release before investigating
further.

>>Ocfs2 sometimes sits and gazes at its navel for minutes at a time, doing
>>nothing at all.  Timer bug?  A quick glance at SysRq-t shows ocfs2 waiting
>>in io_schedule.  Waiting for io that never happens?  This needs more
>>investigation.
> 
> Did you notice this during the untar? If not, do you have any reproducible
> test case?

During the untar.  Very reproducible.  Just untar a few kernel trees into
different directories.  I will try another kernel release first though, just
in case this was a duh that has already been picked up.

>>Delete performance remains horrible, even with a 256 meg journal[4] which
>>is unconscionably big anyway.  Compare to ext3, which deletes kernel trees
>>at a steady 2 seconds per, with a much smaller journal.  Ocfs2 takes more
>>like a minute.
> 
> This doesn't surprise me - our unlink performance leaves much to be desired
> at the moment. How many nodes did you have mounted when you ran that test?

One, on a local disk :-/

> Off the top of my head,the two things which I would guess are hurting delete
> the most right now are node messaging and lack of directory read ahead. The
> first will be solved by more intelligent use of the DLM so that the network
> will only be hit for those nodes that actually care about a given inode --
> unlink rename and mount/unmount are the only things left that still use the
> slower 'vote' mechanism. Directory readahead is much easier to solve, it's
> just that nobody has gotten around to fixing that yet :/ I bet there's more
> to figure out with respect to unlink performance.

I will watch you work on it with interest.

>>[2] It is high time we pried loose the ocfs2 design process from secret
>>irc channels and dark tunnels running deep beneath Oracle headquarters,
>>and started sharing the squishy goodness of filesystem clustering
>>development with some more of the smart people lurking here.
> 
> We're not trying to hide anything from anyone :)

I wasn't implying that, but it's a fact that most of the ocfs2 discussion
happens offline, and I completely understand how easy it is to settle into
that pattern.  But by so doing, we are really cheating the community of part
of the benefit of having an open source community in the first place, which
to be able to watch the development process in real time and learn from it.
Not to mention creating a better historical record and - need I mention it -
a googleable database of development strategies.

> I'm always happy to talk about design. We've been in bugfix (and more
 > recently, performance fix) mode for a while now, so there hasn't been
 > much new design yet.

Fortunately, it seems that the core design is pretty solid already.  I'd
add that a main goal at this point should be to explain as much as
possible of the internals to outsiders, and I certainly include myself in
that at this point.  Please use one syllable words where possible :-)

>>+		if (likely(res->lockname.name[0] != name[0]))
> 
> Is the likely() here necessary? It actually surprises me that the check even
> helps so much - if you check the way OCFS2 lock names are built, the first
> few bytes are very regular - the first char is going to almost always be one
> of M, D, or W. Hmm, I guess if you're hitting it 1/3 fewer times...

Sure, you can improve the test by knowing more about the distribution,
which is prefectly fair because this function does not to be very general.
To tell the truth, I did not check to see which of my hacks sped things
up.  I was more interested in just reorganizing it to make it easier to
optimize.  You could check the second byte or first word
or whatever.

The likely itself is correct though: if the hash chains are short then
you don't care, and if they are long then the early fail is certainly
most likely.  What I didn't check is if gcc is even smart enough to
unroll the loop the correct way to eliminate some jumps.  It would be
easy to unroll this loop by hand a few iterations to test that.

>>+			continue;
>>+		if (likely(res->lockname.len != len))
> 
> Also here, lengths of OCFS2 locks are also actually fairly regular, so
> perhaps the likely() isn't right?

Yes, that one is questionable.  Maybe:

    if (likely((res->lockname.name[0] ^ name[0]) | (res->lockname.len ^ len)))

which modern processors should parallelize very nicely.

At this point it might be a good idea to step back and let some
micro-optimization mavens lurking here have a go at it.  Even a tiny
optimization in this inner loop is a major performance win.

Regards,

Daniel
