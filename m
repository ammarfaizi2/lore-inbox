Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUE0Mc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUE0Mc0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 08:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUE0Mc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 08:32:26 -0400
Received: from mail45.messagelabs.com ([140.174.2.179]:65445 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S262079AbUE0Mb4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 08:31:56 -0400
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-18.tower-45.messagelabs.com!1085661112!3201861
X-StarScan-Version: 5.2.11; banners=-,-,-
X-Originating-IP: [141.156.156.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: why swap at all?
Date: Thu, 27 May 2004 08:31:26 -0400
Message-ID: <5D3C2276FD64424297729EB733ED1F7606242C53@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: why swap at all?
Thread-Index: AcRD34xKYM7Z1fBaSduF1269Cn1faAABvRHA
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Andy Lutomirski" <luto@myrealbox.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: "Tom Felker" <tcfelker@mtco.com>, "Matthias Schniedermeyer" <ms@citd.de>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I have 16GB of ram should I use swap?
Would swap cause the machine to slow down?


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Andy Lutomirski
Sent: Thursday, May 27, 2004 7:39 AM
To: Nick Piggin
Cc: Tom Felker; Matthias Schniedermeyer; linux-kernel@vger.kernel.org
Subject: Re: why swap at all?

Nick Piggin wrote:
> Tom Felker wrote:
> 
>> On Wednesday 26 May 2004 7:37 am, Matthias Schniedermeyer wrote:
>>
>>
>>> program to kernel: "i read ONCE though this file caching not
useful".
>>
>>
>>
>> Very true.  The system is based on the assumption that just-used
pages 
>> are more useful that older pages, and it slows when this isn't true.

>> We need ways to tell the kernel whether the assumption holds.
>>
> 
> A streaming flag is great, but we usually do OK without it. There
> is a "used once" heuristic that often gets it right as far as I
> know. Basically, new pages that are only used once put almost zero
> pressure on the rest of the memory.

(Disclaimer: I don't know all that much about the current scheme.)

First, I don't believe this works.  A couple weeks ago I did

# cp -a <~100GB> <different physical disk>

and my system was nearly unusable for a few hours.  This is Athlon 64 
3200+, 512MB RAM, DMA on on both drives, iowait time around 90%.  So
this 
was an io/pagecache problem.

The benchmark involved was ls.  It took several seconds.  If I ran it
again 
in 5 seconds or so, it was fine.  Much longer and it would take several 
seconds again.  Sounds like pages getting evicted in LRU order.

I have this problem not only on every linux kernel I've ever tried (on 
different computers) but on other OS's as well.  It's not an easy one to
solve.

For kicks, I checked out vmstat 1 (I don't have a copy right of the 
output).  It looked like cp -a dirtied pages as long as it could get
them, 
and they got written out as quickly as they could.  And, for whatever 
reason, the writes lag behind the reads by an amount comparable to the
size 
of my physical memory.

It seems like some kind of limiting/balancing of what gets to use the
cache 
is needed.  I bet that most workloads that touch data much larger than
RAM 
don't benefit that much from caching it all.  (Yes, that
kernel-tree-grep 
from cache is nice, but having glibc in cache is also nice.)

Should there be something like a (small) limit to how many dirty, 
non-mmaped pages a task can have?  I have no objection to a program
taking 
longer to finish because the 100MB it writes need to mostly hit the
platter 
before it returns, since, in return, I get a usable system while it's 
running and it's not taking any more CPU time.

Second (IMHO) a "used once" heuristic has a fundamental problem:

If there are more pages "used more than once" _in roughly sequential
order_ 
than fit in memory, then trying to cache them all is absurd.  That is,
if 
some program makes _multiple passes_ over that 100GB (mkisofs?), the
system 
should never try to cache it all.  It would be better off taking a guess

(even a wild-ass-guess) of which 200MB to cache plus a few MB for 
readahead, leaving pages from other programs in cache for more than a
few 
seconds, and probably getting better performance (i.e. those 200MB are
at 
least cached next time around).


Is any of this reasonable?

--Andy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


