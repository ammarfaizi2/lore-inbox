Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWEIFEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWEIFEe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 01:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWEIFEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 01:04:34 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:37884 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751377AbWEIFEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 01:04:33 -0400
Date: Mon, 8 May 2006 22:03:48 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Arjan van de Ven <arjan@infradead.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Erik Mouw <erik@harddisk-recovery.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
In-Reply-To: <1147149399.3198.10.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.62.0605082143270.20330@qynat.qvtvafvgr.pbz>
References: <200605051010.19725.jasons@pioneer-pra.com> 
 <20060507095039.089ad37c.akpm@osdl.org> <445F548A.703@mbligh.org> 
 <1147100149.2888.37.camel@laptopd505.fenrus.org>  <20060508152255.GF1875@harddisk-recovery.com>
  <1147102290.2888.41.camel@laptopd505.fenrus.org>  <445FF714.4050803@yahoo.com.au>
 <1147149399.3198.10.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2006, Arjan van de Ven wrote:

> On Tue, 2006-05-09 at 11:57 +1000, Nick Piggin wrote:
>> Arjan van de Ven wrote:
>>
>>>> ... except that any kernel < 2.6 didn't account tasks waiting for disk
>>>> IO.
>>>>
>>>
>>> they did. It was "D" state, which counted into load average.
>>>
>>
>> Perhaps kernel threads in D state should not contribute toward load avg
>
> that would be a change from, well... a LONG time
>
> The question is what "load" means; if you want to change that... then
> there are even better metrics possible. Like
> "number of processes wanting to run + number of busy spindles + number
> of busy nics + number of VM zones that are below the problem
> watermark" (where "busy" means "queue full")
>
> or 50 million other definitions. If we're going to change the meaning,
> we might as well give it a "real" meaning.
>
> (And even then it is NOT a good measure for determining if the machine
> can perform more work, the graph I put in a previous mail is very real,
> and in practice it seems the saturation line is easily 4x or 5x of the
> "linear" point)

while this is true, it's also true that up in this area it's very easy for 
a spike of activity to cascade through the box and bring everything down 
to it's knees (I've seen a production box go from 'acceptable' response 
time to being effectivly down for two hours with a small 'tar' command 
(10's of K of writes) being the trigger that pushed it over the edge.

in general loadave > 2x #procs has been a good indication that the box is 
in danger and needs careful watching. I don't know when Linux changed it's 
loadavg calculation, but within the last several years there was a change 
that caused the loadaveg to report higher for the same amount of activity 
on the box. as a user it's hard to argue which is the more 'correct' 
value.

of the various functions that you mentioned above.

# processes wanting to run.
   gives a good indication if the cpu is the bottleneck. this is what 
people think loadavg means (the textbooks may be wrong, but they're what 
people learn from)

# spindles busy
   gives a good indication if the disks are the bottleneck. this needs to 
cover seek time and read/write time. My initial reaction is to base this 
on the avg # of outstanding requests to the drive, but I'm not sure how 
this would interact with TCQ/NCQ (it may just be that people need to know 
their drives, and know that a higher value for those drives is 
acceptable). This is one that I don't know how to find today (wait time 
won't show if something else keeps the cpu busy). In many ways this stat 
should be per-drive as well as any summary value (you can't just start 
useing another spindle the way you can just use another cpu, even in a 
NUMA system :-)

# Nic's busy
   don't bother with this, the networking folks have been tracking this for 
years, either locally on the box, or through the networking infrastructure 
(mrtg and friends were built for this)

# vm zones below the danger point
   I'm not sure about this one either in practice watching for pageing 
rates to climb seems to work, but this area is where black magic 
monitoring is in full force (and at the rate of change on the VM doesn't 
help this understanding)

I can understand your reluctance to quickly tinker with the loadavg 
calculation, but would it be possible to make the other values available 
by themselves for a while. then people can experiment in userspace to find 
the best way to combine the values into a single, nicely graphable 'health 
of the box' value.

David Lang

P.S. I would love to be told that I'm just ignorant of how to monitor 
these things independantly. it would make my life much easier to learn 
how.


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

