Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWCDAxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWCDAxV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 19:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWCDAxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 19:53:21 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:18024 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751469AbWCDAxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 19:53:20 -0500
Date: Fri, 3 Mar 2006 16:53:16 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Daniel Phillips <phillips@google.com>
Cc: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: Ocfs2 performance bugs of doom
Message-ID: <20060304005315.GG31587@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <4408C2E8.4010600@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4408C2E8.4010600@google.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Fri, Mar 03, 2006 at 02:27:52PM -0800, Daniel Phillips wrote:
> Hi ocfs2 guys,
> 
> Actually, ocfs2 is not doomed - far from it!  I just wanted to grab a few
> more of those eyeballs that normally glaze over each time they see a
> cluster mail run by on lkml[1].  Today's news: you are still not finished
> with global lock systime badness, and I already have more performance bugs
> for you.
Thanks for continuing to profile this stuff. We've definitely got lots of
profiling to do, so any help is welcome.

> So the ocfs2 guys switched from double word to single word hash table heads
> and quadrupled the size of the hash table.  Problem solved, right?  No!
Heh, well if you remember from irc I told you that there was more to do -
specifically that I was looking at increasing the memory dedicated to the
hash. 

> I included two patches below.  The first vmallocs a megabyte hash table
> instead of a single page.  This definitively squishes away the global
> lock hash table overhead so that systime stays about twice as high as
> ext3 instead of starting at three times and increasing to four times
> with the (new improved) 4K hash table.
I completely agree that we need to increase the memory dedicated to the
hash, but I fear that vmallocing a 1 megabyte table per domain (effectively
per mount) is going overboard. I will assume that this was a straw man patch
:)

> Of course the Right Think To Do is kmalloc a vector of pages and mask the
> hash into it, but as a lazy person I would rather sink the time into
> writing this deathless prose.
Right. That's one possible approach - I was originally thinking of
allocating a large global lockres hash table allocated at module init time.
This way we don't have to make large allocs for each domain.

Before anything else though, I'd really like to get an idea of how large we
want things. This might very well dictate the severity of the solution.

> The __dlm_lookup_lockres rewrite shows a measurable improvement in
> hash chain traversal overhead.  Every little bit helps.
Yes, this patch seems much easier to swallow ;) Thanks for doing that work.
I have some comments about it below.

> I failed to quantify the improvement precisely because there are other
> glitchy things going on that interfere with accurate measurement. So now
> we get to...
Definitely if you get a chance to show how much just the lookup optimization
helps, I'd like to know. I'll also try to gather some numbers.

> Things to notice: with the still-teensy hash table, systime for global
> lock lookups is still way too high, eventually stabilizing when lock
> purging kicks in at about 4 times ext3's systime.  Not good (but indeed,
> not as excruciatingly painful as two days ago).
> 
> With the attached patches we kill the hash table overhead dead, dead,
> dead.  But look at real time for the untar and sync!
Indeed. The real time numbers are certainly confusing. I actually saw real
time decrease on most of my tests (usually I hack things to increase the
hash allocation to something like a few pages). I want to do some more
consecutive untars though.

Btw, for what it's worth, here's some single untar numbers I have lying
around. Sync numbers are basicaly the same.

Before the hlist patch:
    real    0m21.279s
    user    0m3.940s
    sys     0m18.884s

With the hlist patch:
    real    0m15.717s
    user    0m3.924s
    sys     0m13.324s

> Ocfs2 starts little or no writeout during the untar itself.  Ext3 does.
> Solution: check ext3 to see what secret incantations Andrew conjured up
> to fiddle it into doing something reasonable.
Good idea. As you probably already know, we've never been beyond checking to
see how ext3 handles a given problem :)

> Ocfs2 sometimes sits and gazes at its navel for minutes at a time, doing
> nothing at all.  Timer bug?  A quick glance at SysRq-t shows ocfs2 waiting
> in io_schedule.  Waiting for io that never happens?  This needs more
> investigation.
Did you notice this during the untar? If not, do you have any reproducible
test case?

> Delete performance remains horrible, even with a 256 meg journal[4] which
> is unconscionably big anyway.  Compare to ext3, which deletes kernel trees
> at a steady 2 seconds per, with a much smaller journal.  Ocfs2 takes more
> like a minute.
This doesn't surprise me - our unlink performance leaves much to be desired
at the moment. How many nodes did you have mounted when you ran that test?
Off the top of my head,the two things which I would guess are hurting delete
the most right now are node messaging and lack of directory read ahead. The
first will be solved by more intelligent use of the DLM so that the network
will only be hit for those nodes that actually care about a given inode --
unlink rename and mount/unmount are the only things left that still use the
slower 'vote' mechanism. Directory readahead is much easier to solve, it's
just that nobody has gotten around to fixing that yet :/ I bet there's more
to figure out with respect to unlink performance.

> I would chase down these glitches too, except that I really need to get
> back to my cluster block devices, without which we cannot fully bake
> our cluster cake.  After all, there are six of you and only one of me, I
> had better go work on the thing nobody else is working on.
Hey, we appreciate the help so far - thanks.

> [2] It is high time we pried loose the ocfs2 design process from secret
> irc channels and dark tunnels running deep beneath Oracle headquarters,
> and started sharing the squishy goodness of filesystem clustering
> development with some more of the smart people lurking here.
We're not trying to hide anything from anyone :) I'm always happy to talk
about design. We've been in bugfix (and more recently, performance fix) mode
for a while now, so there hasn't been much new design yet.


> -	bucket = &(dlm->lockres_hash[hash % DLM_HASH_BUCKETS]);
> -
> -	/* check for pre-existing lock */
> -	hlist_for_each(iter, bucket) {
> -		tmpres = hlist_entry(iter, struct dlm_lock_resource, 
> hash_node);
> -		if (tmpres->lockname.len == len &&
> -		    memcmp(tmpres->lockname.name, name, len) == 0) {
> -			dlm_lockres_get(tmpres);
> -			break;
> -		}
> -
> -		tmpres = NULL;
> +		if (likely(res->lockname.name[0] != name[0]))
Is the likely() here necessary? It actually surprises me that the check even
helps so much - if you check the way OCFS2 lock names are built, the first
few bytes are very regular - the first char is going to almost always be one
of M, D, or W. Hmm, I guess if you're hitting it 1/3 fewer times...

> +			continue;
> +		if (likely(res->lockname.len != len))
Also here, lengths of OCFS2 locks are also actually fairly regular, so
perhaps the likely() isn't right?
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
