Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154047-13684>; Wed, 6 Jan 1999 20:49:31 -0500
Received: by vger.rutgers.edu id <154201-13684>; Wed, 6 Jan 1999 08:46:20 -0500
Received: from login1.powertech.no ([195.159.0.151]:21745 "EHLO mail.powertech.no" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <156393-13684>; Wed, 6 Jan 1999 01:05:57 -0500
To: linux-kernel@vger.rutgers.edu
From: Egil Kvaleberg <egil@kvaleberg.no>
Subject: Re: [PATCH] HZ change for ix86
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-User-Agent: Mana 4.0beta (Linux)
Organization: Siving Egil Kvaleberg AS
Message-ID: <%gPxk2ciEs@draugen.kvaleberg.no>
References: <19990105094830.A17862@kg1.ping.de>
Mime-Version: 1.0
Date: Wed, 6 Jan 1999 08:21:03 GMT
Sender: owner-linux-kernel@vger.rutgers.edu

On 5 Jan 1999, Kurt Garloff wrote:

> your system might feel snappier
> when increasing HZ

Not just "might feel" snappier. Somewhat to my surprise, it can also
significantly increase overall performance. On my twin hacked-Celeron
machine, which is temporarily set up with a slow 2Gb IDE disk for test
purposes, a simple HZ change from 100 to 1000 decreased the time for a full
kernel compile from almost 4 minutes to just above 3 minutes. Presumably due
to better CPU utilization. 

> I created a patch which changes the values of HZ to 400 and fixed all places
> I could spot which report the jiffies value to userspace.

At the very least, I think you should say something along:

	#define HZ 400
	
	#define HZ_STD 100
	#define HZ_TO_STD (HZ / HZ_STD)
	
But doesn't this entire approach seem a bit hackish? As you note, there is
an overhead involved. And unless you want to introduce floating point
(ouch!), it fails miserably for many useful values of HZ. Finally, it also
does not provide user space with the benefit of increased time resolution. 

IMHO, the right thing would be to implement CLK_TCK properly as a true
reflection of HZ. Now, it seems to be fixed: e.g. 100 for i386, and 1024 
for alpha. 

The easiest approach would be to make "timebits.h" pick up HZ from the 
kernel, thus:

        #include <asm/param.h>
        #define CLK_TCK HZ
        
The downside is of course that programs would need to be recompiled for any
change in HZ. The best thing would be to fix CLK_TCK at runtime. But could
this possibly break anything? 
        
Re. HZ, there are probably a couple of other places that also needs to be 
cleaned up. In timex.h, I came over this:

	#ifdef __alpha__
	# define SHIFT_HZ 10            /* log2(HZ) */
	#else
	# define SHIFT_HZ 7             /* log2(HZ) */
	#endif

Trivial to fix, though, with something akin to "#if HZ >= 1000".

Egil
-- 
Email: egil@kvaleberg.no  Voice: +47 22523641, 92022870 Fax: +47 22525899
Snail: Egil Kvaleberg, Husebybakken 14A, 0379 Oslo, Norway
URL:   http://www.kvaleberg.no/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
