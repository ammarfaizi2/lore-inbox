Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWF2UBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWF2UBR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWF2UBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:01:17 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:5355 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932360AbWF2UBQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:01:16 -0400
Message-ID: <44A43187.3090307@watson.ibm.com>
Date: Thu, 29 Jun 2006 16:01:11 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: pj@sgi.com, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org, hadi@cyberus.ca,
       netdev@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
References: <44892610.6040001@watson.ibm.com>	<449999D1.7000403@engr.sgi.com>	<44999A98.8030406@engr.sgi.com>	<44999F5A.2080809@watson.ibm.com>	<4499D7CD.1020303@engr.sgi.com>	<449C2181.6000007@watson.ibm.com>	<20060623141926.b28a5fc0.akpm@osdl.org>	<449C6620.1020203@engr.sgi.com>	<20060623164743.c894c314.akpm@osdl.org>	<449CAA78.4080902@watson.ibm.com>	<20060623213912.96056b02.akpm@osdl.org>	<449CD4B3.8020300@watson.ibm.com>	<44A01A50.1050403@sgi.com>	<20060626105548.edef4c64.akpm@osdl.org>	<44A020CD.30903@watson.ibm.com>	<20060626111249.7aece36e.akpm@osdl.org>	<44A026ED.8080903@sgi.com>	<20060626113959.839d72bc.akpm@osdl.org>	<44A2F50D.8030306@engr.sgi.com>	<20060628145341.529a61ab.akpm@osdl.org>	<44A2FC72.9090407@engr.sgi.com>	<20060629014050.d3bf0be4.pj@sgi.com>	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>	<20060629094408.360ac157.pj@sgi.com>	<20060629110107.2e56310b.akpm@osdl.org>	<44A425A7.2060900@watson.ibm.com> <20060629123338.0d355297.akpm@osdl.org>
In-Reply-To: <20060629123338.0d355297.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Thu, 29 Jun 2006 15:10:31 -0400
>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
>  
>
>>>I agree, and I'm viewing this as blocking the taskstats merge.  Because if
>>>this _is_ a problem then it's a big one because fixing it will be
>>>intrusive, and might well involve userspace-visible changes.
>>> 
>>>
>>>      
>>>
>>First off, just a reminder that this is inherently a netlink flow 
>>control issue...which was being exacerbated
>>earlier by taskstats decision to send per-tgid data (no longer the case).
>>
>>But I'd like to know whats our target here ? How many messages per 
>>second do we want to be able to be sent
>>and received without risking any loss of data ? Netlink will lose 
>>messages at a high enough rate so the design point
>>will need to be known a bit.
>>
>>For statistics type usage of the genetlink/netlink, I would have thought 
>>that userspace, provided it is reliably informed
>>about the loss of data through ENOBUFS, could take measures to just 
>>account for the missing data and carry on ?
>>    
>>
>
>Could be so.  But we need to understand how significant the impact of this
>will be in practice.
>
>We could find, once this is deployed is real production environments on
>large machines that the data loss is sufficiently common and sufficiently
>serious that the feature needs a lot of rework.
>
>Now there's always a risk of that sort of thing happening with all
>features, but it's usually not this evident so early in the development
>process.  We need to get a better understanding of the risk before
>proceeding too far.
>  
>
Ok.

I suppose we should first determine what number of tasks can be 
forked/exited at a sustained rate
on these m/c's and that would be one upper bound.

Paul, Chris, Jay,
What total exit rate would be a good upper bound ? How much memory do 
these 1024 CPU machines
have (in high end configurations, not just based on 64-bit 
addressability) and how many tasks can actually be
forked/exited in such a machine ?

>And there's always a 100% reliable fix for this: throttling.  Make the
>sender of the messages block until the consumer can catch up.  In some
>situations, that is what people will want to be able to do.  
>
Is this really an option for taskstats ? Allowing exits to get throttled 
? I suppose its one way
but seems like overkill for something like stats.

>I suspect a
>good implementation would be to run a collection daemon on each CPU and
>make the delivery be cpu-local.  That's sounding more like relayfs than
>netlink.
>  
>
Yup...per-cpu, high speed delivery is looking like relayfs alright.

One option that we've not explored in detail is the "dump" functionality 
of genetlink which allows
kernel space to keep getting called with skb's to fill until its done. 
How much buffering that affords us
in the face of a slow user is not known. But if we're discussing large 
exit rates happening in a burst, not
a sustained way, that may be one way out.

Jamal,
any thoughts on the flow control capabilities of netlink that apply here 
? Usage of the connection is to
supply statistics data to userspace.

--Shailabh

