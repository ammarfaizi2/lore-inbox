Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284737AbRLEVXq>; Wed, 5 Dec 2001 16:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284746AbRLEVXh>; Wed, 5 Dec 2001 16:23:37 -0500
Received: from dsl-213-023-038-088.arcor-ip.net ([213.23.38.88]:7436 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284737AbRLEVX3>;
	Wed, 5 Dec 2001 16:23:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: Ext2 directory index: ALS paper and benchmarks
Date: Wed, 5 Dec 2001 22:26:17 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16BjYc-0000hS-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the filesystem mavens among us, here is a wealth of new information on my 
htree directory index for Ext2, including the paper I presented last month at 
ALS, and a series of benchmark results (therein lies a story, I'll get to 
that[1]).

The paper is here, in browsable html and postscript:

   http://people.nl.linux.org/~phillips/htree/paper/htree.html
   http://people.nl.linux.org/~phillips/htree/htree.ps.gz
   (A Directory Index for Ext2)

Now the benchmarks.  The tests all consist of creating and deleting massive 
numbers of empty files, with names lying in a given numerical range.  
Sometimes the names are created sequentially, sometimes randomly.  I've 
included the C program I wrote to create files with 'random' in this post.

Why should it matter which order files are *created* in?  Well, it shouldn't, 
and it doesn't for the htree index, but read to the end of this post to find 
out why it's interesting.  On the other hand, the order in which files are 
deleted matters a great deal, to some filesystems.  Not htree-indexed Ext2 
though, which I intentionally designed so that best and worst cases are 
almost the same.  (I'll provide additional benchmark results relating to 
random deletion in a subsequent post.)

Here come the charts...

The first is basically the same as the one I presented for my first prototype 
of the htree index, back in February of this year:

   http://people.nl.linux.org/~phillips/htree/indexed.vs.classic.10x10000.create.jpg
   (Indexed ext2 compared to classic ext2 in the range 10,000 to 100,000 files)

The vertical axis is running time, the horizontal axis is number of files.

The only difference between this and February's chart is that this one runs 
out to 100,000 files, which I was unable to do with the original prototype 
because I'd implemented only a single tree level at the time - the index 
became full at about 93,000 files.  Oh, and the rendering quality is a lot 
better this time, thankyou very much staroffice and sct (more on that later).

This chart shows that ext2 with the htree index creates large numbers of 
files exponentially faster than classic ext2, the difference rapidly becoming 
so large that the htree barcharts are barely visible.

The next chart shows the same thing with the classic ext2 results clipped to 
the top of the chart so that we can see the linear performance of the htree 
index:

   http://people.nl.linux.org/~phillips/htree/indexed.vs.classic.10x10000.create.clipped.jpg

File deletions show a similar result:

   http://people.nl.linux.org/~phillips/htree/indexed.vs.classic.10x10000.delete.jpg

Mind you, this is without Ted's recent hack to cache the Ext2 directory index 
position.  Unfortunately my patch steps on that, and update is needed.  With 
Ted's hack, ext2 file deletion performance should be much close to linear, 
until we start getting into random order deletion.  Hopefully I will find the 
time to run another benchmark, so we can see what the position-caching hack 
does for classic ext2.  We are, after all, going to keep running into 
unindexed directories for some time.

This next chart is perhaps the most interesting of the bunch, I think:

   http://people.nl.linux.org/~phillips/htree/indexed.vs.classic.10x100.create.jpg

This shows that the htree index is *always* as fast or faster than classic 
ext2, even for small directories consisting of a few blocks.  This is because 
the htree patch actually branches to the old code for any directory 
consisting of a single block, but as soon as we go to two blocks, the index 
is faster.

This gives us the answer to a question that was raised some months ago: 
obviously indexing a directory consisting of a single block will only slow 
things down, but where is the cutoff?  Several of us speculated about that (I 
can't find the url at the moment) but ultimately the prediction was, that 
htree would squeak ahead of the linear search, even at two blocks.  This is 
now confirmed.

With the small number of files, each test had to be run 10 times to get stable measurements.

Ok, now for the interesting part.  With the htree patch, ext2 can handle 
millions of files per directory; so can reiserfs.  Which is faster?  The 
answer isn't completely straightforward:

   http://people.nl.linux.org/~phillips/htree/indexed.vs.reiser.8x250000.create.jpg

Here, we're testing directories with up to two million files.  Ext2+htree 
wins for the first million files, then suffers some kind of bump that puts 
reiserfs ahead for the next million.  So for *really* huge directories, 
advantage reiserfs, or so it seems.

Curiously, Reiserfs actually depends on the spelling of the filename for a 
lot of its good performance.  Creating files with names that don't follow a 
lexigraphically contiguous sequence produces far different results:

   http://people.nl.linux.org/~phillips/htree/indexed.vs.classic.vs.reiser.10x10000.create.random.jpg

So it seems that for realistic cases, ext2+htree outperforms reiserfs quite 
dramatically.  (Are you reading, Hans?  Fighting words... ;-)

Mind you, I did not try tweaking reiserfs at all, it does have a selection of 
hash functions to choose from.  It's likely that the default - R5 - is not 
very well-suited at all to random names, i.e., names we'd expect to see in 
the wild.  For one thing, this shows the pitfalls of writing hash functions 
that make assumptions about information present in the input string.

I'm sure we'll hear more on this subject.

Finally, it seems that ext2+htree does its work using quite a bit less cpu 
than reiserfs or ext2 (logarithmic graph):

   http://people.nl.linux.org/~phillips/htree/indexed.vs.reiser.10x100000.create.random.cpu.log.jpg

I will supply the full benchmark data in a subsequent post.

Here is the c program I used to create files with 'random' names:

/*
 * randfiles.c
 *
 * Usage: randfiles <basename> <count> <echo?>
 *
 * For benchmarking create performance - create <count> files with
 * numbered names, in random order.  The <echo?> flag, if y, echoes
 * filenames created.  For example, 'randfiles foo 10 y' will create
 * 10 empty files with names ranging from foo0 to foo9.
 *
 * copyleft: Daniel Phillips, Oct 6, 2001, phillips@nl.linux.org
 *
 */

#include <stdlib.h>

#define swap(x, y) do { typeof(x) z = x; x = y; y = z; } while (0)

int main (int argc, char *argv[])
{
	int n = (argc > 2)? strtol(argv[2], 0, 10): 0;
	int i, size = 50, show = argc > 3 && !strncmp(argv[3], "y", 1);
	char name[size];
	int choose[n];
	for (i = 0; i < n; i++) choose[i] = i;
	
	for (i = n; i; i--)
	{
		int j = rand() % i;
		swap(choose[i-1], choose[j]);
	}
	
	for (i = 0; i < n; i++)
	{
		snprintf(name, size, "%s%i", argv[1], choose[i]);
		if (show) printf("create %s\n", name);
		close(open(name, 0100));
	}
	return 0;
}

[1] I'm eternally indebted to Stephen Tweedie for coming to my rescue at the 
last minute.  Shortly before my ALS presentation I had exactly zero graphs 
prepared, let alone slides.  I'd arrived at Oakland with files full of 
benchmark numbers, secure in the knowledge that I could massage them into 
impressive graphics on a moment's notice.  Boy was I ever wrong.  

It seems it's still a 'early days' for kchart and kpresenter.  To do the job, 
I needed something something that actually works.  Stephen Tweedie had just 
the thing on his laptop: staroffice, and he knows how to use it.  So we all 
retired to a Chinese restaurant nearby and Stephen went to work - all I had 
to do was offer advice on which tables to turn into charts.  Most of the time 
went by just getting the first chart, as Stephen had never actually tried 
this before.  Then finally, a few charts magically materialized and, even 
better, began to metamorphose into a slide show.  We all trooped over to the 
conference halls, and continued to work on the slides during the talks preceding mine.

My talk went fine; the charts I've presented here are exactly the ones made 
by Stephen that day.  Thanks.  :-)

--
Daniel
