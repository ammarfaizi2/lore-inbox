Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264119AbUESIpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbUESIpz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 04:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbUESIpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 04:45:54 -0400
Received: from portal.beam.ltd.uk ([62.49.82.227]:5007 "EHLO beam.beamnet")
	by vger.kernel.org with ESMTP id S264119AbUESIpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 04:45:33 -0400
Message-ID: <40AB1EA7.8080104@beam.ltd.uk>
Date: Wed, 19 May 2004 09:45:27 +0100
From: Terry Barnaby <terry1@beam.ltd.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: davids@webmaster.com
CC: Mike Black <mblack@csi-inc.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with mlockall() and Threads: memory usage
References: <MDEHLPKNGKAHNMBLJOLKEEIJMBAA.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEIJMBAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

We do want improved latency, but with reasonable memory usage. This is
a soft real-time system. At the moment the memory usage is far too high in
our application.

With 20 threads runing the system will lock 160MBytes of memory just for stack
space (8 MBytes each), although the application probably only needs 2MByte in
total.
We can reduce the maximum stack size per thread, but then if a thread
increases its stack size beyond this the application will crash with a
segment fault, not good ...

For our use, mapping in physical memory as required for a growing stack would be
a good compromise between latency and memory usage. Once the system has run the
worker threads for a short time all of the needed stack memory will be locked in
and latency will be controlled. If a thread needs more memory for stack in a particular
instance, there will be a latency hit but this would be acceptable and
much better than a crash.

Terry

David Schwartz wrote:
>>Thanks for that.
>>I have done some more investigating, and on my system (Standard RedHat 9)
>>the stack ulimit is set to 8192 KBytes. So it appears that the thread
>>library/kernel threads pre-allocates, and writes to, 8129 KBytes
>>of stack per
>>thread and so then mlockall() locks all of this in memory.
>>
>>Should'nt the Thread library grow the stack rather than
>>preallocate it all even
>>with mlockall() like malloc ?
> 
> 
> 	I thought you wanted improved latency. Surely having to find a page for you
> when your stack grows will add unpredictable latency. So, no, the thread
> library should reserve the stack when 'mlockall(MCL_FUTURE)' is specified.
> 
> 	I do agree that having an 'initial stack size' in additional to a 'maximum
> stack size' would be a good idea. The former good for application that are
> concerned about physical memory usage and the latter for applications
> concerned about virtual memory usage.
> 
> 	DS
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Dr Terry Barnaby                     BEAM Ltd
Phone: +44 1454 324512               Northavon Business Center, Dean Rd
Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software
                       "Tandems are twice the fun !"
