Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSFVVAV>; Sat, 22 Jun 2002 17:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316899AbSFVVAU>; Sat, 22 Jun 2002 17:00:20 -0400
Received: from [213.23.21.195] ([213.23.21.195]:39612 "EHLO starship")
	by vger.kernel.org with ESMTP id <S316897AbSFVVAS>;
	Sat, 22 Jun 2002 17:00:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Date: Sat, 22 Jun 2002 22:59:30 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@zip.com.au>,
       Christopher Li <chrisl@gnuchina.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
References: <20020619113734.D2658@redhat.com> <E17LF65-0001K4-00@starship> <20020622055318.GA22411@clusterfs.com>
In-Reply-To: <20020622055318.GA22411@clusterfs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Lryk-0002zF-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 June 2002 07:53, Andreas Dilger wrote:
> 4) it is probably better to have the most uniform hash function we can
>    find than to do lots more block split/coalesce operations, so the
>    extra cost of half-MD4 may be a benefit overall

That's the thing: we already know the extra cost of half-MD4 is dominant 
here.  It only saves about 1.3% of the splitting, and splitting itself is a 
small part of overall costs.

Argument (1), "cpus are getting faster all the time" a little weak - 
directories are getting bigger all the time too, and... you know, it just 
isn't stylish to waste cycles in common operations.

However, I buy the stability and predictability arguments, and we should go 
with half-md4 for the alpha-test period.  But also, we should see what we can 
do to trim some of the fat off half-MD4 without degrading its nice properties 
too much.  During the same period, I think I see if I can find a better 
multiplier for dx_hack_hash, to even out its distribution a bit.  Armed with 
these results, the release version should use the fastest hash that exhibits 
acceptable statistical behaviour.

I do agree there's a lot to be said for going with a hash that has been 
analyzed rigorously.

> It would be interesting to re-run this test to create a few million
> entries, but with periodic deletes.

Changing the topic slightly, I'm running the following stupid program to test 
for directory growth during steady state operation similar to a mailer:

/* steady.c */

#include <stdlib.h>

int main (int argc, char *argv[])
{
	int target = (argc > 2)? strtol(argv[2], 0, 10): 0;
	int range = (argc > 3)? strtol(argv[3], 0, 10): 0;
	int size = 50, show = argc > 3 && !strncmp(argv[4], "y", 1);
	int balance = 0, deletes = 0;
	char name[size];

	if (!range) return -1;

	while (1)
	{
		snprintf(name, size, "%s%i", argv[1], rand() % range);
		if (balance < target)
		{
			int fd = open(name, 0100);
			if (fd >= 0)
			{
				if (show) printf("create %s\n", name);
				close(fd);
				balance++;
			}
		} else
			if (!remove(name))
			{
				if (show) printf("remove %s (%i), ", name, ++deletes);
				balance--;
			}
	}
	return 0;
}

when run with:

   steady <basename> <count> <range> [y=print output]

it will create up to <count> files with names <basename><rand> with <rand> in 
the range 0 to range-1, then it will start alternately deleting and creating 
random files.  Its algorithm is braindead - it just keeps trying to delete a 
random file until it hits one that exists, and on create, it creates a random 
file and tries again if it hits one already there.  I'm running it now with:

   steady foo 10000 1000000000 y

meaning it's working with a 10,000 file, creating/deleting files with names 
in the rand foo0 to foo999999999, i.e., a billion possible names.  It's a 
horribly inefficient thing to do, since it has about a hundred thousand 
failures for every success, but it was quick to write.  I'm watching for 
directory expansion.  The directory started at 385024 bytes (38.5 bytes/entry 
and grew a block after about 300 steady state remove/create cycles.   Another 
block was added around 500 cycles.  It's up to 1100 cycles now, and hasn't 
added another block.  It sort of looks like the expansion is getting slower.  
This is with dx_hack_hash.  I'll let it run overnight to get a feeling of how 
urgent the steady-state problem is.

What I expect to find is that directory expansion is slower with half-md4, 
perhaps significantly slower.  However, even if it is slower, we can't really 
tolerate any steady-state expansion at all, so it's no excuse for not 
implementing the coalesce.

> Hmm, now that I think about it, split/coalesce operations are only
> important on create and delete, while the hash cost is paid for each
> lookup as well.  It would be interesting to see the comparison with
> a test something like this (sorry, don't have a system which has both
> hash functions working right now):
>
> [code]

Yes, good test: performance against name length.  Well, I don't plan to try 
it just now, since I've run out of time and must get ready for the pilgrimage 
to Ottawa.

-- 
Daniel
