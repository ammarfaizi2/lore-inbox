Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132765AbRDQQ65>; Tue, 17 Apr 2001 12:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132764AbRDQQ6g>; Tue, 17 Apr 2001 12:58:36 -0400
Received: from mail.gci.com ([205.140.80.57]:46094 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S132762AbRDQQ5R>;
	Tue, 17 Apr 2001 12:57:17 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA3150446DA18@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        Ian Stirling <root@mauve.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: RE: IP Acounting Idea for 2.5
Date: Tue, 17 Apr 2001 08:57:10 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard continues with:
> Leif Sawyer <lsawyer@gci.com>:
>>> Ian Stirling [mailto:root@mauve.demon.co.uk]
>>>> Manfred Bartz responded to
>>>>> Russell King <rmk@arm.linux.org.uk> who writes:
>>>>>
>>>>> You just illustrated my point.  While there is a 
>>>>> reset capability people will use it and accounting/
>>>>> logging programs will get wrong data.  Resetable
>>>>> counters might be a minor convenience when debugging
>>>>> but the price is unreliable programs and the loss of the 
>>>>> ability of several programs to use the same counters.
>>>> 
>>>> You of course, are commenting from the fact that your 
>>>> applications are stupid, written poorly, and cannot handle
>>>> 'wrapped' data.  Take MRTG
>>>> <snip>
>>>> Similarly, if my InPackets are at 102345 at one read, and 
>>>> 2345 the next read, and I know that my counter is 32 bits,
>>>> then I know i've wrapped and can do
>>> 
>>> I think the point being made is that if InPackets are at 
>>> 102345 at one read, and 2345 the next, and you know it's
>>> a 32 bit counter, it's completely unreliable to assume that
>>> you have in fact recieved 4294867295 packets, if the counter
>>> can be zeroed. You can say nothing other than at least 2345
>>> packets, at most 2345+n*2^32 have been got since you last
>>> checked.
>> 
>> Ah, yes.. I seem to have misplaced a bit of text in my reply.
>> 
>> The continuation of thought:
>> 
>> How the application derives the status of a wrapped counter or
>> a zero'ed counter is dependant on the device being monitored.
>> 
>> Yes, you have to know what your interface is capable of 
>> (maxbytes/sec) so that you can do a simple calculation where:
>> 
>> maximum_throughput = maxbytes_sec * (time_now - time_last_read)
>> 
>> and if your previous good counter + the maximum throughput wraps
>> the counter, you have a good chance that you've simply wrapped.
>> 
>> If not, then you can assume that your counters were cleared 
>> at some point, log the data you've got, and keep moving forward.
> 
> And that introduces errors in measurement. It also depends on 
> how frequently an uncontroled process is clearing the counters.
> You may never be able to get a valid measurement.

This is true.  Which is why application programmers need to write
code as if they are not the only [ab]users of data.

Which brings me back to my point.

Don't force the kernel to uphold your local application requirements
of stable counters.

Enforce it in the userspace portion of the code.

<subtopic>
Yes, you could extend the proc filesystem (ugh) with a flag that could
be read by the ip[chains|tables] user app to determine if clearing flags
were allowed.  Then a simple

echo 1 > /proc/sys/net/ipv4/counters_locked

or some such cruft.  But I don't see this extension making into the
standard kernel at this time.  It just seems to be wasteful.
</subtopic>

If you (at your site) really need this type of functionality, it's
pretty darn simple to write a wrapper to ip[tables|chains] which
silently (or not so) drops the option to clear the counters before
calling the real version.

Besides, what would be gained in making the counters RO, if they were
cleared every time the module was loaded/unloaded?


