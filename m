Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265642AbUABVFW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 16:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265643AbUABVFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 16:05:22 -0500
Received: from lmdeliver01.st1.spray.net ([212.78.202.210]:31902 "EHLO
	lmdeliver01.st1.spray.net") by vger.kernel.org with ESMTP
	id S265642AbUABVFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 16:05:08 -0500
From: Paolo Ornati <ornati@lycos.it>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Date: Fri, 2 Jan 2004 22:04:27 +0100
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200401021658.41384.ornati@lycos.it> <3FF5B3AB.5020309@wmich.edu>
In-Reply-To: <3FF5B3AB.5020309@wmich.edu>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401022200.22917.ornati@lycos.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 January 2004 19:08, Ed Sweetman wrote:
>
>
> Note, sometimes when moving backwards back to a lower readhead my speed
> does not decrease to the values you see here. readahead on my system
> always goes up (on avg) with higher readahead numbers, maxing at 8192.
> No matter the buffer size or speed or position the ide drive is in.
>
> hdparm -t is difficult to get really accurate, which is why they suggest
> running it multiple times.  I see differences of 4MB/sec on subsequent
> runs without changing anything.  run hdparm -t at least 3-4 times for
> each readahead value.
>
> I suggest trying 128, 256,512,8192 as values for readahead and skip all
> those crap numbers in between.
>
>
> if you still see on avg lower numbers on the top end, try nicing hdparm
> to -20.  Also, update to a newer hdparm. hdparm v5.4, you seem to be
> using an older one.
>

ok, hdparm updated to v5.4

and this is the new script:
_____________________________________________________________________
#!/bin/bash

# This script assumes hdparm v5.4

NR_TESTS=3
RA_VALUES="64 128 256 8192"

killall5
sync
hdparm -a 0 /dev/hda > /dev/null
hdparm -t /dev/hda > /dev/null

for ra in $RA_VALUES; do
    hdparm -a $ra /dev/hda > /dev/null;
    echo -n $ra$'\t';
    tot=0;
    for i in `seq $NR_TESTS`; do
	tmp=`nice -n '-20' hdparm -t /dev/hda|grep 'Timing'|tr -d ' '|cut -d'=' -f2|cut -d'M' -f1`;
	tot=`echo "scale=2; $tot+$tmp" | bc`;
    done;
    s=`echo "scale=2; $tot/$NR_TESTS" | bc`;
    echo $s;
done
_____________________________________________________________________


The results are like the previous.

2.6.0:
64        31.91
128      31.89
256      26.22	# during the transfer HD LED blinks
8192    26.26	# during the transfer HD LED blinks

2.6.1-rc1:
64        25.84	# during the transfer HD LED blinks
128      25.85	# during the transfer HD LED blinks
256      25.90	# during the transfer HD LED blinks
8192    26.42	# during the transfer HD LED blinks

I have tried with and without "nice -n '-20'" but without any visible changes.

Performance with 2.4:
with kernel 2.4.23 && readahead = 8 I get 31.89 MB/s...
changing readahead doesn't seem to affect the speed too much.

Bye

-- 
	Paolo Ornati
	Linux v2.4.23

