Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129399AbRA2SGI>; Mon, 29 Jan 2001 13:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129759AbRA2SF6>; Mon, 29 Jan 2001 13:05:58 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:22282 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S129101AbRA2SFu>; Mon, 29 Jan 2001 13:05:50 -0500
Message-ID: <3A75B058.30807@redhat.com>
Date: Mon, 29 Jan 2001 12:03:04 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Andrew Morton <andrewm@uow.edu.au>, Nigel Gamble <nigel@nrg.org>,
        linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>, <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>; <20010128061428.A21416@hq.fsmlabs.com> <3A742A79.6AF39EEE@uow.edu.au> <3A74462A.80804@redhat.com> <20010129084410.B32652@hq.fsmlabs.com> <3A75A70C.4050205@redhat.com> <20010129103810.D3037@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



yodaiken@fsmlabs.com wrote:

> On Mon, Jan 29, 2001 at 11:23:24AM -0600, Joe deBlaquiere wrote:
> 
>> while (!done)
>> {
>> 	done = check_done();
>> }
>> 
>> when you can have:
>> 
>> while (!done)
>> {
>> 	yield();
>> 	done = check_done();
>> }
> 
> 
> But there is a reason for the first: time. 
> 
> while(!read_pci_condition); // usually finishes in 10us
> 
> versus
> 
> while(!read_pci_condition)yield(); // usually finishes in 1millisecond
> 
> can have a nasty impact on system performance. 
> 
>       

So perhaps you check need_resched first, but it all boils down to how 
many 10 us delays you're going to take. If you start taking too many 
you're just gratuitously sucking the V+ line without meaningful results. 
It all really depends on how much you actually expect to wait. There is 
unfortunately no way at the present to quantify all these delays and 
tune the system to the performance requirement. You could try something 
like (no, i didn't compile this, so don't expect it to work) :

#define EXPECTED_TIMEOUT(x,y)	( (x) > CONFIG_DRIVER_TIMEOUT_MAX ? (y) : (0) )

while (!done)
{
	EXPECTED_TIMEOUT(50,yield());
	done = check_done();
}

to tune these delays in or out of the kernel based on a kernel config 
parameter. If you are willing to tolerate a longer delay the driver 
itself can run faster, whereas if you force the system to yield, then 
this favors the other threads. (I'm not advocating we litter the entire 
kernel with gobs of nested macros either, just that there should be some 
way to do it right).

> 
>> being preemptive and being cooperative aren't mutually exclusive.
>> 
>> Borrowing your sports car / delivery van metaphor, I'm thinking we could 
>> come up with something along the lines of a BMW 750iL... room for six 
>> and still plenty of uumph.
> 
> 
> Not a cheap vehicle.  Linux is pretty snappy on an AMD SC420  or
> a M860 and 5 meg of memory. And it scales to a quad xeon well. Don't
> try that with IRIX.  
> So to push my tired metaphor even further beyond
> the bounds, a delivery van that needs jet fuel and uses two lanes, 
> won't do well in the delivery business no matter how well it 
> accelerates.

So how about we just put a knob on the dash and make it scale from 
delivery van to sports car based on the needs of one particular system. 
I realize there will be boundaries, but that's what you and I have jobs, 
to solve the boudary cases. The more flexible the kernel is, the easier 
it is to adapt to the extremes.

--
Joe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
