Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275813AbRJQNKF>; Wed, 17 Oct 2001 09:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275823AbRJQNJ4>; Wed, 17 Oct 2001 09:09:56 -0400
Received: from mail.anu.edu.au ([150.203.2.7]:3226 "EHLO mail.anu.edu.au")
	by vger.kernel.org with ESMTP id <S275813AbRJQNJt>;
	Wed, 17 Oct 2001 09:09:49 -0400
Message-ID: <3BCD8269.B4E003E5@anu.edu.au>
Date: Wed, 17 Oct 2001 23:06:49 +1000
From: Robert Cohen <robert.cohen@anu.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [Bench] New benchmark showing fileserver problem in 2.4.12
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had a chance to do some more testing with the test program I
posted yesterday. I have been able to try various combinations of
parameters and variations of the programs.

I now have a pretty good idea of what specific activities will see the
performance problems I was seeing. But since I'm not a kernel guru, I
have no idea as to why the problem exists or how to fix it.

I am interested in reports from people who can run the test. I would
like to confirm my findings (or simply confirm that I'm crazy :-).

The problems appear to only happen in very specific set of
circumstances. Its an incredible coincidence that my original
lantest/netatalk testing happened to hit that specific combination of
factors.
So it looks like I havent actually found a generic performance problem
with Linux as such. But I would still like to get to the bottom of this. 

The factors that cause these problems probably won't occur very often in
real usage, but they are things that are not obviously silly. So it does
indicate a problem with some dark corner of the linux kernel that
probably should be investigated.

I have identified 4 specific factors that contribute to the problem. All
4 have to be present for before there is a performance problem.


Summary of the factors involved
===============================

Factor 1: the performance problems only occur when you are rewriting an
existing file in place. That is writing to an existing file which is
opened without O_TRUNC. Equivalently, if you have written a file and
then seek'ed back to the beginning and started writing again. I admit
this is something that not many real programs (except databases) do. But
it still shouldnt cause any problems.

Factor 2: the performance problems only occur when the part of the file
you are rewriting is not already present in the page cache. This tends
to happen when you are doing I/O to files larger than memory. Or if you
are rewriting an existing file which has just been opened.

Factor 3: the performance problems only happens for I/O that is due to
network traffic, not I/O that was generated locally. I realise this is
extremely strange and I have no idea how it knows that I/O is die to
network traffic let alone why it cares. But I can assure you that it
does make a difference.

Factor 4: the performance problem is only evident with small writes eg
write calls with an 8k buffer. Actually, the performance hit is there
with larger writes, just not significant enough to be an issue. Its
tempting to say "well just use larger buffers". But this isnt always
possible and anyway, 8k buffers should still work adequately, just not
optimally.



Experimental evidence
=====================


Factor 1: the performance problems only occur when you are rewriting an
existing file in place. That is writing to an existing file which is
opened without O_TRUNC. Equivalently, if you have written a file and
then seek'ed back to the beginning and started writing again.

Evidence: in the report I posted yesterday, the test I was using
involved 5 clients rewriting 30 Meg files on a 128 Meg machine. The
symptom  was that after about 10 seconds, the throughput as shown by
vmstat "bo" drops sharply and we start getting reads occuring as shown
by the "bi" figure. However, with that test the page cache fills up
after 10 seconds. This is only just before the end of the files are
reached and we start rewriting the files. So its difficult to see which
of those two is causing the problem. Yesterday, I attributed the
problems to the page cache filling up, but I was apparently wrong. 

The new test I am using is 5 copies of

./send 200 2 | rsh server ./receive 200 2.

Here we have 5 clients rewriting 200 Meg file.
With this test, the page cache fills up after about 10 seconds, but
since we are writing a total of 1 Gig of files, the end of the files is
not reached for 2 minutes or so. It is at this point that we start
rewriting the files.

When the page cache fills up, there is no drop in performance. However,
when the end of the file is reached and we start to rewrite, the
throughput drops and we get the reads happening. So the problems are
obviously due to the rewriting of an existing file not due to the page
cache filling.

 It doesnt make any difference whether the test seeks back to the start
to rewrite or if it closes it and reopens without O_TRUNC.



Factor 2: the performance problems only occur when the part of the file
that is being rewritten is not already present in the page cache.

Evidence: I modified the "receive" test program to write to a named file
and to not delete the file after the run, so I could rewrite existing
files with only one pass. 

On a machine with 128 Megs of memory

I created 5 large test files.
I purged these files from the page cache by writing another file larger
than memory and deleting it.

I did a run of 5 copies of ./send 18 1 | rsh server ./receive 18 1 
(each one on a different file).
I did a second run of ./send 18 1 | rsh server ./receive 18 1

With the first run, the files were not present in page cache and the
performance problems were seen. This run took about 95 seconds. Since
the total size of the 5 files is smaller than page cache available, they
were all still present after the first run.

The second run took about 20 seconds. So the presence of data in the
cache makes a significant difference.

It seems natural to say "of course the cache sped things up, thats what
caches are for". However, the cache should not have sped this operation
up. Only writes are being done, no reads. So there is no reason why the
presence of data in the cache which is going to be overwritten anyway
should speed things up. 
Also, the cache shouldnt speed writes up since the program does an fsync
to flush the cache on write. And even if the cache does speed writes, it
should have the same effect on both runs.

I had originally thought the problem occured when the page cache was
full. I assumed it was due to the extra work to purge something from the
page cache to make space for a new write. However with this test I
observed that the performance was bad even when the page cache did not
fill memory and there was plenty of free memory. So it seems that the
performance problem is purely due to rewriting something which is not
present in page cache. It has nothing to do with the amount of free
memory and whether the page cache is filling memory.

In this kind of test, if the collective size of the files is greater
than the amount of memory available for page cache, then problems can be
observed even with the second run. For example if you are writing to 120
Megs of files and there is 100 Megs of page cache. On the second run,
even though 100 megs of the files are present in the page cache, you get
no benefit because each portion of the file will be flushed to make way
for new writes before you get around to rewriting that portion. This is
the standard LRU performance wall when the working set is bigger than
available memory.



Factor 3: the problems only happens for I/O that is due to network
traffic.
Evidence: The problem does occurs when you have a second machine
"rsh"ing into the linux server.
However, if you run the test entirely on the linux server with any of
the following

./send 30 10 | ./receive 30 10
./send 30 10 | rsh localhost ./receive 30 10
./send 30 10 | rsh server ./receive 30 10

then the problem does not occur. Strangely we also don't see any reads
showing up in the vmstat output in these cases.
It seems the page cache is able to rewrite existing files without doing
any reading first under these conditions.

This is the really strange issue. I have no idea why it would make a
difference whether the receive program is taking its standard input from
a local source or from an rsh over the network. Why would the behaviour
of the page cache differ in these circumstances. If any Guru's can clue
me in, I would appreciate it.



Factor 4: the performance problem only occurs with small writes.
Evidence: the  test programs I posted yesterday were doing IO with 8K
buffers (set by a define) because that was what the original benchmark I
was emulating did. If I modify "receive" to use a 64k buffer, I get
adequate throughput.
The anomalous reads are still happening, but don't seem to impact
performance too much. The throughput ramps smoothly between 8k and 64k
buffers.

One possible response is a variation on the old joke: if you have
experience problems when you do 8k writes, then don't do 8k writes.
However, I would like to understand why we are seeing a problem with 8k
writes. Its not as if 8k is *that* small. At worst small writes should
just chew CPU time, but we get lots of CPU idle time during the
benchmark, just poor throughput. The evidence suggests some kind of
constant overhead for each write.

Modifying the buffer size in send, simply reduces the amount of CPU that
send uses. Which is as you would expect. Doing this doesnt have much
effect on the overall throughput.


--
Robert Cohen
Unix Support
TLTSU
Australian National University
Ph: 612 58389
