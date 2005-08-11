Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVHKWIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVHKWIZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 18:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVHKWIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 18:08:25 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:2908 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S932289AbVHKWIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 18:08:24 -0400
Subject: Re: [PATCH/RFT 5/5] CLOCK-Pro page replacement
From: Song Jiang <sjiang@lanl.gov>
To: Rik van Riel <riel@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050810200944.197606000@jumble.boston.redhat.com>
References: <20050810200216.644997000@jumble.boston.redhat.com>
	 <20050810200944.197606000@jumble.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1123798095.4692.66.camel@moon.c3.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-14) 
Date: Thu, 11 Aug 2005 16:08:15 -0600
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My current test focuses on the looping case, where I repeatedly 
scan a file whose size is larger than the memory size but less 
than two times of memory sizes. My initial results are as follows:


My machine has 2GB memory.
The size of the file to be scanned is 2.5GB.
I looped for 4 time. The times and associated disk bandwidths
for each loop are below:

loop 0 time = 34.229424s bandwith = 76.58MB
loop 1 time = 37.574041s bandwith = 69.76MB
loop 2 time = 38.181791s bandwith = 68.65MB
loop 3 time = 38.141794s bandwith = 68.72MB

This shows that the current patches cannot do a 
better job than the original kernel, which notoriously
underperforms for the case -- no matter how many times
the file is accessed, no hits at all. Meanwhile, Clock-Pro
is supposed to do a better job, because part of the
file can be protected in the active list and get a decent 
number of hits.

Here is from /proc/meminfo:

Active:          11356 kB
Inactive:      1994400 kB

So no file pages are promoted into the active list, just
as in the original kernel.

Here is from /proc/refaults:     

    Refault distance          Hits
         0 -     32768           192
    32768 -     65536           269
    65536 -     98304           447
    98304 -    131072           603
   131072 -    163840          1087
   163840 -    196608           909
   196608 -    229376           558
   229376 -    262144           404
   262144 -    294912           287
   294912 -    327680           191
   327680 -    360448            79
   360448 -    393216            68
   393216 -    425984            41
   425984 -    458752            45
   458752 -    491520            31
New/Beyond    491520          2443

In the statistic, we do see many hits at the distance of around 
150,000 pages. If we consider the inactive list size (1.9GB), 
this position corresponds to the file size. However, if everything
happens as expected, all the hits should happen at the
distance. Unfortunately, there are also many hits listed as
New/Beyond. Because "Beyond"s should not be there, are they all
"New"s? Futhermore, I didn't see where the refault_histogram 
statistics get reset, though they almost stop increasing after
the first run. Can you show me that? 


   Song Jiang
   at LANL

