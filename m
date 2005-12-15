Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVLOOn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVLOOn4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVLOOnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:43:37 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:44796 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750720AbVLOOic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:38:32 -0500
Message-ID: <43A17FDC.8040706@de.ibm.com>
Date: Thu, 15 Dec 2005 15:38:20 +0100
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-scsi@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch 6/6] statistics infrastructure - exploitation: zfcp
References: <43A044E6.7060403@de.ibm.com>	 <20051214165900.GA26580@infradead.org>  <43A0E8E7.1060706@de.ibm.com>	 <1134632229.16486.3.camel@laptopd505.fenrus.org>	 <43A1524E.70200@de.ibm.com> <1134647174.16486.35.camel@laptopd505.fenrus.org>
In-Reply-To: <1134647174.16486.35.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Thu, 2005-12-15 at 12:23 +0100, Martin Peschke wrote:
>
>  
>
>>Given the idea of struct statistic, the lower layer driver could use a 
>>given pointer to an upper layer's struct statistic in order to call 
>>statistic_inc(stat, x).
>>
>>The lower layer driver could call an upper layer driver's function to 
>>have the upper layer update a statistic. 
>>    
>>
>
>Why? it's an open source world, what you suggest is more something for a
>"must hide behind interfaces" closed world ;)
>  
>
Regarding the statistic_inc() & friends proposal, I see it as a handy 
abstraction that allows device driver programmers to worry about other 
things than reimplementing counters and other vehicles conveying 
statistics information.
If statistic_inc() would only be able to hide a single counter the value 
of which is just increased over time, I would agree with you.
But it implements several ways of data processing, including counters, 
fill level indicators (counters for total number of measurements, plus 
minimum, average, maximum), histograms (a set of counters for discrete 
values or ranges of values), as well as statistics that take the 
dimension time into account (for things like megabytes per seconds, or 
queue utilization per whatever-unit-of-time).

Regarding the "lower layer driver could call an upper layer driver's 
function" idea:
I didn't say I like all the listed alternatives the same. Actually I 
don't like this one.
I just wanted to be polite and discuss alternatives in order not to 
appear to be ignorant by simply insisting on my approach ;)

>if done right, the LLDD gets access to the transport class information,
>including the array of stats, so the LLDD can update those just fine.
>Just the API should be clear about who owns updating which field; a
>comment will suffice for that ;)
>  
>
Well, transport classes are fine for transport specific purposes.
I don't think that any statistic, particularly not request latencies and 
request sizes, belong there.

But I like the general idea hidden in what you say:
If done right, the layer that gathers statistics data gets access to the 
statistic, so that it can update this just fine.

>>The lower layer driver could temporarily store some measurement data in 
>>the data structure passed between those two; the upper layer driver 
>>picks it up later and calls whatever statistic library routine is 
>>appropriate. Requires additional bytes and one store/retrieve operation 
>>more than the struct statistic idea.
>>    
>>
>
>way way too complex for no reason.
>  
>
Agreed, another non-preferred way of doing it.

>Remember the scsi layer is a layered concept, but also upside down: even
>though the transport class layers on top of the LLDD, it's the LLDD that
>drives that class, not the other way around. The same could be done with
>selected statistics; have the transport layer do the exporting to sysfs
>and all that stuff, but have the LLDD keep track of them.
>
That's one of the major points of my patch: Have the statistics library 
do the exporting to the user interface, not the LLDD.

Debugfs has been my initial choice instead of sysfs because I don't 
think sysfs appropriate for exporting histograms and stuff.
But whether debugfs is the right choice, or relayfs, or sysfs, or 
something else is another question, I'd like to find an answer for in 
this thread.

If you are interested in the user interface question, this is a sample 
of what some statistics currently look like in a debugfs file:

  latencies_scsi_write <=0 0
  latencies_scsi_write <=1 0
  latencies_scsi_write <=2 0
  latencies_scsi_write <=4 174
  latencies_scsi_write <=8 872
  latencies_scsi_write <=16 2555
  latencies_scsi_write <=32 2483
  ...
  latencies_scsi_write <=1024 1872
  latencies_scsi_write >1024 1637
 
  latencies_scsi_read <=0 0
  latencies_scsi_read <=1 0
  latencies_scsi_read <=2 0
  latencies_scsi_read <=4 57265
  latencies_scsi_read <=8 13610
  latencies_scsi_read <=16 1082
  latencies_scsi_read <=32 319
  latencies_scsi_read <=64 63
  ...
  latencies_scsi_read >1024 0

  ...
  util_qdio_outb [3097394.211992] 865 1 1.052 5
  util_qdio_outb [3097395.211992] 737 1 4.558 125
  util_qdio_outb [3097396.211992] 396 1 11.765 77
  util_qdio_outb [3097397.211992] 270 1 12.863 128
  util_qdio_outb [3097398.211992] 765 1 7.271 26
  util_qdio_outb [3097399.211992] 577 1 4.036 27
  ...

>(of course
>only for those that are relevant in this sense; if the transport class
>is the natural place to update, then it should be done there)
>  
>
yes

Martin

