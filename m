Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpPJPKv1bVq7HTzaWjDCgwQDFiA==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Tue, 06 Jan 2004 00:50:05 +0000
Message-ID: <045201c415a4$f24f9c60$d100000a@sbs2003.local>
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Date: Mon, 29 Mar 2004 16:46:05 +0100
From: "Nick Piggin" <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: <Administrator@smtp.paston.co.uk>
Cc: <linux-kernel@vger.kernel.org>, <mbligh@aracnet.com>,
        "Andrew Morton" <akpm@osdl.org>,
        "Trivial Patch Monkey" <trivial@rustcorp.com.au>
Subject: Re: [TRIVIAL PATCH] Use valid node number when unmapping CPUs
References: <3FE74801.2010401@us.ibm.com> <3FE78F53.9090302@cyberone.com.au> <3FF9EABF.7050906@us.ibm.com>
In-Reply-To: <3FF9EABF.7050906@us.ibm.com>
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:46:06.0156 (UTC) FILETIME=[F29000C0:01C415A4]



Matthew Dobson wrote:

> Nick Piggin wrote:
>
>>
>>
>> Matthew Dobson wrote:
>>
>>> The cpu_2_node array for i386 is initialized to 0 for each CPU, 
>>> effectively mapping all CPUs to node 0 unless changed.  When we 
>>> unmap CPUs, however, we stick a -1 in the array, mapping the CPU to 
>>> an invalid node.  This really isn't helpful.  We should map the CPU 
>>> to node 0, to make sure that callers of cpu_to_node() and friends 
>>> aren't returned a bogus node number.  This trivial patch changes the 
>>> unmapping code to place a 0 in the node mapping for removed CPUs.
>>>
>>> Cheers!
>>
>>
>>
>>
>> I'd prefer it got initialised to -1 for each cpu, and either set to -1
>> or not touched during unmap.
>
> >
>
>>
>> 0 is more bogus than the alternatives, isn't it? At least for the subset
>> of CPUs not on node 0. Callers should be fixed.
>
>
> Not really...  These macros are usually used for things like 
> scheduling, memory placement and other decisions.  Right now the value 
> doesn't have to be error-checked, because it is assumed to always 
> return a valid node.  For these types of uses, it's far better to 
> schedule/allocate something on the wrong node (ie: node 0) than on an 
> invalid node (ie: node -1).  Having a possible negative value for this 
> will break things when used as an array index (as it often is), and 
> will force us to put tests to ensure it is a valid value before using 
> it, and introduce possible races in the future (ie: imagine testing if 
> CPU 17's node mapping is non-negative, simultaneously unmapping the 
> CPU, then using the macro again to make a node decision.  You may get 
> a negative value back, thus causing you to index way off the end of 
> your array... BOOM).  If we stick with the convention that we always 
> have a valid (even if not *correct*) value in these arrays, the worst 
> we should get is poor performance, not breakage.


OK, then keep the correct node number. No need to change it to node 0.
Having the value not change at all (1) gives you the correct information
at all times, and (2) eliminates the remaining race possibilities.


