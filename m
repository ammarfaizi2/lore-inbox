Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWBJT3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWBJT3K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 14:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWBJT3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 14:29:10 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:51820 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751317AbWBJT3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 14:29:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=UoC2iFBVTc/+sprw1yOSp4FUH0ZRDagcC/dU+zhE2+zr4lJX1N1z4HJHOwYSXhIzUYlQXzlXsku/K34dqVcgTxnhYkRFZeWRWhVmDleCiztAGVRxvAzHURjos97aVT758n9VRwVIqLcnTWz2tc3fQ65rfGJdM4J/Vn1FufoU1qQ=  ;
Message-ID: <43ECE97F.1080902@yahoo.com.au>
Date: Sat, 11 Feb 2006 06:29:03 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com> <20060209004208.0ada27ef.akpm@osdl.org> <43EB3801.70903@yahoo.com.au> <20060209094815.75041932.akpm@osdl.org> <43EC0A44.1020302@yahoo.com.au> <20060209195035.5403ce95.akpm@osdl.org> <43EC0F3F.1000805@yahoo.com.au> <20060209201333.62db0e24.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au> <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au> <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au> <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au> <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au> <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au> <20060209231432.03a09dee.akpm@osdl.org> <43EC8A06.40405@yahoo.com.au> <Pine.LNX.4.64.0602100815580.19172@g5.osdl.org> <43ECC69D.1010001@yahoo.com.au> <Pine.LNX.4.64.0602100904330.19172@g5.osdl.org> <43ECD471.9080203@yahoo.com.au> <Pine.LNX.4.64.0602101011350.19172@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602101011350.19172@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 11 Feb 2006, Nick Piggin wrote:
> 
>>What do you mean by overlapping?
> 
> 
> I'm just talking about the "same area gets re-dirtied while it's already 
> busy being written". Depending on the _program_, this:

OK, that's what I thought.

>  - So let's say that you append to the log, and chose (for some reason, 
>    never mind) to let the kernel know. So you effectively do something 
>    like
> 
> 		memcpy(logptr, newentry, newentrysize);
> 		logptr = logptr + newentrysize;
> 		if (time_to_msync) {
> 			msync(msyncptr, logptr - msyncptr, MS_ASYNC);
> 			msyncptr = logptr;
> 		}
> 
> Ok? 
> 
> Now, the question is, what do we want to happen at the MS_ASYNC.
> 

Well it is all very well to just make up this case but I don't
see what it proves (eg. some application may actually work better
if creat is implemented with unlink to be extreme). But I'll try
to humour you :)

Being a logging program it would appear to have some data integrity
requirements, and as such I would guess it is going to use MS_SYNC
in the very near future before writing another entry to the log
(in case a crash happens while generating the next entry).

However the fact the MS_ASYNC is even called in the first place
indicates to me that there must be some window before the MS_SYNC
point (for whatever reason). So I would really want MS_ASYNC to
actually send the page to backing store asap in order to get some
pipelining going.

> In particular, what happens if the _previous_ MS_ASYNC had started the IO 
> (either directly, like in your world, or by bdflush just picking it up, 
> it really doesn't matter) on the _previous_ old end of the log area, so 
> the partial page at the old "msyncptr" point may actually be under IO 
> still.
> 

I wouldn't expect any IO there at all because there would be no
"dangling" MS_ASYNC, and there would be no random clowns writing
to our very important log. But just on the off chance that there
was some IO going on:

> We have multiple choices:
>  - we ignore the issue (which is what the current behaviour for MS_ASYNC 
>    is, since it just marks things dirty in the page cache)
>  - we mark the page dirty, but we don't start IO on it, since it's busy 
>    (and since it's dirty, it will _eventually_ get written out)
>  - we actually wait for the old IO, in order to start IO on it again.
> 
> Now, I don't think that the third option is sane for MS_ASYNC (ie I don't 
> think even you want -that- behaviour), but in general, all these three 
> choices are actually sane. Notice how none of them actually involve 
> waiting for the new _result_. It's only a question about whether to wait 
> for an old write when we start a new one, or leave the new one entirely 
> _unstarted_.
> 

3 is obviously wrong because it blocks. 1 is what we have now which
I'm arguing against (on efficiency grounds). So that leaves us with 2,
which is an acceptable compromise for a situation which isn't likely
to come up much with a well coded app.

> 
>>fadvise(fd, 100, 200, FADV_ASYNC_WRITE);
>>fadvise(fd, 300, 400, FADV_ASYNC_WRITE);
>>fadvise(fd, 100, 200, FADV_WRITE_WAIT);
>>fadvise(fd, 300, 400, FADV_WRITE_WAIT);
> 
> 
> I'm saying that a valid pattern is
> 
> 	.. dirty offset 100-200 ..
> 	fadvice(fd, 100, 200, FADV_WRITE_START_TRY);
> 
> 	.. dirty offset 200-300 ..
> 	fadvice(fd, 200, 300, FADV_WRITE_START_TRY);
> 
> 	.. dirty offset 300-400 ..
> 	fadvice(fd, 300, 400, FADV_WRITE_START_TRY);
> 
> is a valid thing to do ("try to start IO, but don't guarantee it") as a 
> way to get things going. But that would never pair up with a "wait for 
> IO", because there's no guarantee that the IO got started (for example, we 
> may have started the IO when only bytes 100-200 were dirty, then we 
> dirtied the other bytes, but we didn't re-start the IO for them because 
> the previous IO to the same page was still pending, so the bytes never hit 
> storage and they aren't even outstanding).
> 
> But the "FADV_WRITE_START_TRY" is actually the best thing if what you are 
> trying to do is to keep changes _minimal_ so that when you later acutally 
> finish the whole thing, you can do
> 
> 	fadvice(fd, 100, 400, FADV_WRITE_WAIT);
> 
> which is your "write and wait".
> 

[argh! that was actually Andrew's "wait for writeout", but OK ;)]

> So far so good, and we don't actually care. The unconditional "write and 
> wait" at the end means that it's irrelevant whether the "START_TRY" thing 
> actually started the IO or not - the START_TRY thing _can_ be a no-op if 
> you want to. 
> 
> These sound like the semantics you want. No?
> 

Yes (and I'd likewise argue that an efficient FADV_WRITE_START_TRY
implementation should really try to get IO going. Ie. exactly what
I'm arguing for MS_ASYNC).

> And yes, I'm perfectly happy with them. I think this is what people would 
> do. I just wanted to make sure that we're AWARE of the fact that it 
> implies that the ASYNC thing wouldn't necessarily always even start IO.
> 

True. I believe our MS_ASYNC is technically within the standards.
I think it is suboptimal for sane users and against the spirit
of the spec.

> And the reason I wanted to make sure of that is that the whole thread 
> started from you complaining about MS_ASYNC not starting the IO. I'm 
> saying that if you _require_ starting of IO, then the FADV_WRITE_WAIT 
> actually sensibly has different semantics, which can be a lot cheaper to 
> do in the presense of other writers (ie then the write-wait would only 
> need to wait for any outstanding IO, not start writing out stuff that 
> somebody else had written).
> 
> And the reason I wanted to take up the semantic difference is because 
> there _are_ semantic differences.
> 
> If you only "commit" things when you have nothing dangling, you'll see the 
> above patterns. But it's a valid thing to commit things after you've made 
> "further" log changes (that you're _not_ ready to commit). For example, 

I don't think so in general because userspace can't guarantee something
*is not* sent to backing store, only that it *is*.

> say that your log is really dirtying all the time, but you synchronize it 
> at certain points and write the pointer to the synchronized state 
> somewhere else. What would you do?
> 
> Your pattern would actually be
> 
> 	.. dirty offset 100-200 ..
> 	fadvice(fd, 100, 200, FADV_WRITE_START);
> 
> 	.. dirty offset 200-300 ..
> 	fadvice(fd, 200, 300, FADV_WRITE_START);
> 
> 	.. dirty offset 300-400 ..
> 	fadvice(fd, 300, 400, FADV_WRITE_START);
> 
> 	.. dirty offset 400-415 .. (for the next transaction)
> 

- IOW if the app or OS crashed here it would be possible to see 400-415 on
the disk and none of the previous transactions (assuming we don't know
the page size).

- If you are saying that the app does know the page size, then it is
obvious that it is by no stretch of the imagination hand optimising
IO, because it will have started 3 different IOs for the same page.

- Or (final option) only the first fadvise started IO, then any or all
of the subsequent transactions might not be synched after FADV_JUST_WAIT
(depending on what the DMA to disk saw).

> 	fadvice(fd, 100, 400, FADV_JUST_WAIT); (for the previous one)
> 
> and here is where the semantics differ. The "always start IO, and just 
> wait for IO" won't be waiting for the partial stuff (that doesn't matter). 
> While the "write and wait" would synchronously write stuff that we just 
> don't care about (just because they happen to be on the same "IO 
> granularity" block).
> 
> This "unconditional write start" + "unconditional wait only" pattern in 
> theory allows you to optimize all the IO patterns by hand, and have less 
> synchronous waits, because it wouldn't wait for state that is dirty, but 
> that doesn't matter.
> 

I'm not convinced. You above example was bogus.

> But as long as people are _aware_ of this issue, I don't much care. 
> 
> 			Linus
> 


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
