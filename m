Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317931AbSHCWBG>; Sat, 3 Aug 2002 18:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317935AbSHCWBG>; Sat, 3 Aug 2002 18:01:06 -0400
Received: from dsl-213-023-022-101.arcor-ip.net ([213.23.22.101]:47805 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317931AbSHCWBB>;
	Sat, 3 Aug 2002 18:01:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] Rmap speedup
Date: Sun, 4 Aug 2002 00:05:57 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <E17aiJv-0007cr-00@starship> <E17aptH-0008DR-00@starship> <3D4B692B.46817AD0@zip.com.au>
In-Reply-To: <3D4B692B.46817AD0@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17b725-00031K-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wait a second guys, the problem is with the script, look at those CPU
numbers:

> ./daniel.sh  39.78s user 71.72s system 368% cpu 30.260 total
> quad:/home/akpm> time ./daniel.sh
> ./daniel.sh  38.45s user 70.00s system 365% cpu 29.642 total

They should be 399%!!  With my fancy script, the processes themselves are
getting serialized somehow.

Lets back up and try this again with this pair of scripts, much closer to
the original:

doitlots:
-------------------------------
#!/bin/sh

doit()
{
        ( cat $1 | wc -l )
}
        
count=0
        
while [ $count != 500 ]
do
        doit doitlots > /dev/null

        count=$(expr $count + 1)
done
echo done
-------------------------------


forklots:
-------------------------------
echo >foocount
./doitlots >>foocount &
./doitlots >>foocount &
./doitlots >>foocount &
./doitlots >>foocount &
./doitlots >>foocount &
./doitlots >>foocount &
./doitlots >>foocount &
./doitlots >>foocount &
./doitlots >>foocount &

count=0

while [ $count != 10 ]
do
	count=$(wc foocount | cut -b -8)
done
-------------------------------

/me makes the sign of the beast at bash

-- 
Daniel
