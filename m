Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272858AbRIGVNI>; Fri, 7 Sep 2001 17:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272857AbRIGVM6>; Fri, 7 Sep 2001 17:12:58 -0400
Received: from ns.ithnet.com ([217.64.64.10]:5906 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272856AbRIGVMt>;
	Fri, 7 Sep 2001 17:12:49 -0400
Date: Fri, 7 Sep 2001 23:13:02 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: phillips@bonn-fries.net, roger.larsson@skelleftea.mail.telia.com,
        mikeg@wen-online.de, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Message-Id: <20010907231302.41564aa4.skraw@ithnet.com>
In-Reply-To: <689208719.999883299@[10.132.112.53]>
In-Reply-To: <20010907154801.028a48e8.skraw@ithnet.com>
	<689208719.999883299@[10.132.112.53]>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

in an effort to try and find the reason for the real bad performance of vm in
my test bed I tried to find the bad guy that holds all my nice mem and makes
the rest of the system crawl on its knees. Most of my testing is somehow
related to network (because of knfsd) and fs (obviously writing to disk and
reading from CD). So I tried to eliminate some of the unknown factors.
I tried something very simple:
Copy a file from disk a to b (on different controllers) which is bigger than
current free mem (I used a 730 MB file).
What you see is (quite as expected) that your free mem gets lower during this
copy down to the point where you have none left. Up to this the copy seemed
pretty fast, from then on it seemed really slow.
I ended up with a copy time of 4m14 and a completely filled mem (cache).
Obviously this is the cached file data. Fine. Now you rm the new file and your
memory is back. Fine. As two disks are involved I tried next how long it takes
to read the file from the source disk. Therefore I simply used "cat file
>/dev/null". This takes 24 secs and you end up with a filled mem, obviously
again cached file data. Only this time you cannot get it free, because you have
no destination to remove. Ok, you count on vm to remove it later on
automagically. Next try, how long does it take to write such a file onto
destination disk, result at worst: 1m33.
Ok, now the interesting question: 24 secs (read) + 1m33 (write) = 1m57.
This is by far less than 4m14 from the copy test. Why? My simple guess: kernel
needs a damn lot of time to manage the memory mess of this really simple
action.
This brings up the simple question: why the heck does it make sense to cache so
much data of an I/O action that your systems gets under heavy pressure? I can't
tell, can you? Obviously you do not gain performance, but loose. The system
comes up to load 4 with this simple cp.
I really would like to know what part of the kernel holds responsibility for
this tremendous amount of cache pages. How can you influence this (e.g. size)? 
Kernel seems to have a very hard time in finding free mem in this situation,
this is what probably eats a lot of time. So a big performance step should be
possible if it can easier get rid of outdated (name it aged) cache pages. I
don't really care if a cp eats up all mem, as long as it does not equally eat
up the systems performance as a kind of drawback.
Of course this is a cry for help from somebody that can accept that the current
vm is simply a hack with a lot of lists, but no consistent design - and that it
needs cleanup _and_ simplification, and _not_ tuning. You can spend years in
tuning with no real result. So please (Alex), do not add Yet Another Ten Lists,
even if you call them zones, to make defragmentation work.
The only thing which will happen if we continue to go that way is more
inconsistent stuff like

static unsigned int zone_free_plenty(zone_t *zone)
{
        unsigned int free;

        free = zone->free_pages;
        free += zone->inactive_clean_pages;

        return free > zone->pages_high*2;
}

which pretty well shows (on a simple approach) what I mean: if a page is free,
call it free. If it is not, then its _used_. Otherwise you will end up with
more stuff like the above to find out what _could_ be called free, but
according to Daniels last answer to my question (what is the difference between
clean and free?) is not really free, except the case when it is full moon on
second monday of the month.
This code is full to the limit with rough guesses about certain parameters,
things that might happen and workarounds.
If we walk on that way for another 3 months we may as well end up with a system
not being able to do a simple cp without allocation failure. And don't call
this an exaggeration: currently I cannot even burn a simple CD while doing a
nfs copy. This already worked one year ago.
Start from scratch instead: what is the interface definition from
rest-of-kernel to vm functions? Can't be that many. 
We have a lot of brain online here, lets use it.

Regards,
Stephan
