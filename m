Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270030AbTGMASn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 20:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270039AbTGMASn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 20:18:43 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:3712
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S270030AbTGMASl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 20:18:41 -0400
Date: Sun, 13 Jul 2003 02:33:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030713003307.GH16313@dualathlon.random>
References: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva> <20030710135747.GT825@suse.de> <1057932804.13313.58.camel@tiny.suse.com> <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058034751.13318.95.camel@tiny.suse.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Jul 12, 2003 at 02:32:32PM -0400, Chris Mason wrote:
> Anyway, if you've got doubts about the current patch, I'd be happy to
> run a specific benchmark you think will show the bad read
> characteristics.

the main reason I dropped the two queues in elevator-lowatency is that
the ability of calling schedule just once only for the I/O completion
with reads was a minor thing compared having to wait a potential 32M
queue to be flushed to disk before being able to read a byte from disk.
So I didn't want to complicate the code with minor things, while fixing
what I considered the major issue (i.e. the overkill queue size with
contigous writes, and too small queue size while seeking).

I already attacked that problem years ago with the max_bomb_segments
(the dead ioctl ;). You know, at that time I attacked the problem from
the wrong side: rather than limting the mbytes in the queue like
elevator-lowatency does, I enforced a max limit on the single request
size, because I didn't have an idea of how critical it is to get 512k
requests for each SG DMA operation in any actual storage (the same
mistake that the anticipatory scheduler developers did when they thought
anticipatory scheduler could in any way obviate the need of very
aggressive readahead).  elevator-lowlatency is the max_bomb thing in a
way that doesn't hurt contigous I/O throughput at all, with very similar
latency benefits. Furthmore elevator-lowatency allowed me to grow a lot
the number of requests without killing down a box with gigabytes large
I/O queues, so now in presence of heavily-seeking 512bytes per-request
(the opposite of 512k per request with contigous I/O) many more requests
can sit in the elevator in turn allowing a more aggressive reordering of
requests during seeking. That should result in a performance improvement
when seeking (besides the fariness improvement under a flood of
contigous I/O).

Having two queues, could allow a reader to sleep just once, while this
way it also has to wait for batch_sectors before being able to queue. So
I think what it could do is basically only a cpu saving thing (one less
schedule) and I doubt it would be noticeable.

And in general I don't like too much assumptions that considers reads
different than writes, writes can be latency critical too with fsync
(especially with journaling).  Infact if it was just the sync-reads that
we cared about I think read-latency2 from Andrew would already work well
and it's much less invasive, but I consider that a dirty hack compared
to the elevator-lowlatency that fixes stuff for sync writes too, as well
as sync reads, without assuming special workloads. read-latency2
basically makes a very hardcoded assumption that writes aren't latency
critical and it tries to hide the effect of the overkill size of the
queue, by simply putting all reads near the head of the queue, no matter
if the queue size is 1m or 10m or 100m.  The whole point of
elevator-lowlatency is not to add read-hacks that assumes only reads are
latency critical. and of course an overkill size of the queue isn't good
for the VM system too, since that memory is unfreeable and it could
render much harder for the VM to be nice with apps allocating ram during
write throttling etc..

Overall I'm not against resurrecting the specialized read queue, after
all writes also gets a special queue (so one could claim that's an
optimization for sync-writes not sync-reads, it's very symmetric ;), but
conceptually I don't find it very worthwhile. So I would prefer to have
a benchmark as you suggested, before complicating things in mainline
(and as you can see now it's a bit more tricky to retain the two
queues ;).

Andrea
