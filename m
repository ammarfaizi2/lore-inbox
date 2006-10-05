Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWJEX20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWJEX20 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 19:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWJEX20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 19:28:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:30849 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751456AbWJEX2Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 19:28:25 -0400
Message-ID: <4525950A.8020009@us.ibm.com>
Date: Thu, 05 Oct 2006 16:28:10 -0700
From: Mike Mason <mmlnx@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: "Frank Ch. Eigler" <fche@redhat.com>
CC: jrs@us.ibm.com, Irfan Habib <irfan.habib@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       SystemTAP <systemtap@sources.redhat.com>
Subject: Re: Fwd: Any way to find the network usage by a process?
References: <3420082f0610030114o5b44b8ak7797483e02002614@mail.gmail.com>	<3420082f0610030114o4c6998en907bccce81d28c59@mail.gmail.com>	<452285FD.7010909@us.ibm.com> <45241F7A.5050501@us.ibm.com> <y0m3ba2jw4w.fsf@ton.toronto.redhat.com>
In-Reply-To: <y0m3ba2jw4w.fsf@ton.toronto.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Ch. Eigler wrote:
> Mike Mason <mmlnx@us.ibm.com> writes:
> 
>> Here's a variation of Jose's script that uses the networking tapset
>> and prints top-like output for transmits and receives.  [...]
> 
> Thanks for posting it to the systemtap wiki.
> 
> Some minor style suggestions follow:
> 
>> [...]
>>          ifxmit_p[pid(), dev_name] ++
>>          ifxmit_b[pid(), dev_name] += length
> 
> These could be collapsed into a single statistics-aggregate array: 
> #          ifxmit[pid(), dev_name] <<< length
> Then the printing routine would use @count(ifxmit[...]) and @sum(ifxmit[...])
> to extract the two values.  Same of course for ifrecv.

I tried that and got the following output:

   PID   UID DEV     XMIT_PK RECV_PK XMIT_KB RECV_KB COMMAND
     0     0 eth0          9      10     486     672 swapper
ERROR: empty aggregate near identifier 'execname' at nettop.stp:35:4
WARNING: Number of errors: 1, skipped probes: 0

Apparently using @sum on empty aggregates isn't allowed. I expected 0's to 
be returned. The only way to avoid the error is use @sum only if @count > 
0, which makes the printf too complex in my opinion.

> 
>>          execname[pid()] = execname()
>>          user[pid()] = uid()
>>          ifdevs[pid(), dev_name] = dev_name
> 
> Calling pid() so many times is worse than calling it once and caching
> the result in a local variable ("p = pid()").  

Agreed.  I'll change that.

> 
> The way that the script tracks pid-to-uid and pid-to-execname mappings
> is not bad, though if that part were moved to new probes on fork or
> exec, it would allow the network-related probes to run concurrently on
> an SMP without fighting over locks.

But that would only catch processes created after the script starts, correct?

- Mike

> 
> 
> - FChE

