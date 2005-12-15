Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbVLOLZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbVLOLZS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 06:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbVLOLZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 06:25:18 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:4789 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1422646AbVLOLZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 06:25:16 -0500
Message-ID: <43A1524E.70200@de.ibm.com>
Date: Thu, 15 Dec 2005 12:23:58 +0100
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-scsi@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch 6/6] statistics infrastructure - exploitation: zfcp
References: <43A044E6.7060403@de.ibm.com>	 <20051214165900.GA26580@infradead.org>  <43A0E8E7.1060706@de.ibm.com> <1134632229.16486.3.camel@laptopd505.fenrus.org>
In-Reply-To: <1134632229.16486.3.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Thu, 2005-12-15 at 04:54 +0100, Martin Peschke wrote:
>  
>
>>Christoph Hellwig wrote:
>>
>>    
>>
>>>>+	atomic_t		read_num;
>>>>+	atomic_t		write_num;
>>>>+	struct statistic_interface	*stat_if;
>>>>+	struct statistic		*stat_sizes_scsi_write;
>>>>+	struct statistic		*stat_sizes_scsi_read;
>>>>+	struct statistic		*stat_sizes_scsi_nodata;
>>>>+	struct statistic		*stat_sizes_scsi_nofit;
>>>>+	struct statistic		*stat_sizes_scsi_nomem;
>>>>+	struct statistic		*stat_sizes_timedout_write;
>>>>+	struct statistic		*stat_sizes_timedout_read;
>>>>+	struct statistic		*stat_sizes_timedout_nodata;
>>>>+	struct statistic		*stat_latencies_scsi_write;
>>>>+	struct statistic		*stat_latencies_scsi_read;
>>>>+	struct statistic		*stat_latencies_scsi_nodata;
>>>>+	struct statistic		*stat_pending_scsi_write;
>>>>+	struct statistic		*stat_pending_scsi_read;
>>>>+	struct statistic		*stat_erp;
>>>>+	struct statistic		*stat_eh_reset;
>>>>   
>>>>
>>>>        
>>>>
>>>NACK.  pretty much all of this is generic and doesn't belong into an LLDD.
>>>We already had this statistics things with emulex and they added various
>>>bits to the core in response.
>>>
>>>
>>> 
>>>
>>>      
>>>
>>Agreed. It's not necessarily up to LLDDs to keep track of request sizes, 
>>request latencies, I/O queue utilization, and error recovery conditions 
>>by means of statistics. This could or maybe should be done in a more 
>>central spot.
>>
>>With regard to latencies, it might make some difference, though, how 
>>many layers are in between that cause additional delays. Then the 
>>question is which latency one wants to measure.
>>    
>>
>
>even if the LLDD measures these, the stats belong a level up, so that
>all LLDD's export the same. I think you got half of Christophs point,
>but not this last bit: even when it's the LLDD that needs to measure the
>stat, it still shouldn't be LLDD specific, and thus defined one if not
>two layers up. 
>
>  
>

Ah, I see. It makes sense to avoid multiple places where to look for 
latencies, for example.
Several ways to accomplish this come to mind:

Given the idea of struct statistic, the lower layer driver could use a 
given pointer to an upper layer's struct statistic in order to call 
statistic_inc(stat, x).

The lower layer driver could call an upper layer driver's function to 
have the upper layer update a statistic. This causes a proliferation of 
such functions (one upper layer function per statistic class). Since 
control goes back and force between upper and lower layer drivers 
anyway, adding another call  to the backchain doesn't seem to be the 
most efficient way. Not sure an addional indirect function call to the 
layer actually owning a particular statistic could be avoided in any 
case (depends on interface between the two layers).

The lower layer driver could temporarily store some measurement data in 
the data structure passed between those two; the upper layer driver 
picks it up later and calls whatever statistic library routine is 
appropriate. Requires additional bytes and one store/retrieve operation 
more than the struct statistic idea.

