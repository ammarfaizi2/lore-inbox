Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpOX/KGf2ZWaLTDSiCYtQsXch/Q==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Mon, 05 Jan 2004 23:05:15 +0000
Message-ID: <041401c415a4$e6020b50$d100000a@sbs2003.local>
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Date: Mon, 29 Mar 2004 16:45:45 +0100
From: "Matthew Dobson" <colpatch@us.ibm.com>
Reply-To: <colpatch@us.ibm.com>
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: <Administrator@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <mbligh@aracnet.com>,
        "Andrew Morton" <akpm@osdl.org>,
        "Trivial Patch Monkey" <trivial@rustcorp.com.au>
Subject: Re: [TRIVIAL PATCH] Use valid node number when unmapping CPUs
References: <3FE74801.2010401@us.ibm.com> <3FE78F53.9090302@cyberone.com.au>
Content-Type: text/plain;
	format=flowed;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:45:48.0906 (UTC) FILETIME=[E847DCA0:01C415A4]

Nick Piggin wrote:
> 
> 
> Matthew Dobson wrote:
> 
>> The cpu_2_node array for i386 is initialized to 0 for each CPU, 
>> effectively mapping all CPUs to node 0 unless changed.  When we unmap 
>> CPUs, however, we stick a -1 in the array, mapping the CPU to an 
>> invalid node.  This really isn't helpful.  We should map the CPU to 
>> node 0, to make sure that callers of cpu_to_node() and friends aren't 
>> returned a bogus node number.  This trivial patch changes the 
>> unmapping code to place a 0 in the node mapping for removed CPUs.
>>
>> Cheers!
> 
> 
> 
> I'd prefer it got initialised to -1 for each cpu, and either set to -1
> or not touched during unmap.
 >
> 
> 0 is more bogus than the alternatives, isn't it? At least for the subset
> of CPUs not on node 0. Callers should be fixed.

Not really...  These macros are usually used for things like scheduling, 
memory placement and other decisions.  Right now the value doesn't have 
to be error-checked, because it is assumed to always return a valid 
node.  For these types of uses, it's far better to schedule/allocate 
something on the wrong node (ie: node 0) than on an invalid node (ie: 
node -1).  Having a possible negative value for this will break things 
when used as an array index (as it often is), and will force us to put 
tests to ensure it is a valid value before using it, and introduce 
possible races in the future (ie: imagine testing if CPU 17's node 
mapping is non-negative, simultaneously unmapping the CPU, then using 
the macro again to make a node decision.  You may get a negative value 
back, thus causing you to index way off the end of your array... BOOM). 
  If we stick with the convention that we always have a valid (even if 
not *correct*) value in these arrays, the worst we should get is poor 
performance, not breakage.

Cheers!

-Matt

