Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130511AbRA3P5x>; Tue, 30 Jan 2001 10:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129398AbRA3P5o>; Tue, 30 Jan 2001 10:57:44 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:16901 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S129390AbRA3P52>; Tue, 30 Jan 2001 10:57:28 -0500
Message-ID: <3A76E155.2030905@redhat.com>
Date: Tue, 30 Jan 2001 09:44:21 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: yodaiken@fsmlabs.com, Andrew Morton <andrewm@uow.edu.au>,
        Nigel Gamble <nigel@nrg.org>, linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <3A75A70C.4050205@redhat.com>  <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>, <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>; <20010128061428.A21416@hq.fsmlabs.com> <3A742A79.6AF39EEE@uow.edu.au> <3A74462A.80804@redhat.com> <20010129084410.B32652@hq.fsmlabs.com> <30672.980867280@redhat.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Woodhouse wrote:

> jadb@redhat.com said:
> 
>> (If you're running a program XIP from flash and a  RT interrupt leaves
>> the flash in a unreadable state, boom!).
> 
> 
> Bad example. I don't expect Linux to support writable XIP any time in the 
> near future. The only thing I envisage myself doing to help people who want 
> writable XIP is to take away their crackpipe.
> 

I wasn't thinking of running the kernel XIP from writable, but even 
trying to do that from the filesystem is a mess. If you're going to be 
that way about it...

/me hands over the crackpipe

> Until we get dual-port flash, of course.
> 
> The thing that really does concern me about the flash driver code is the
> fact that it often wants to wait for about 100µs. On machines with
> HZ==100, that sucks if you use udelay() and it sucks if you schedule(). So
> we end up dropping the spinlock (so at least bottom halves can run again)
> and calling:
> 
> static inline void cfi_udelay(int us)
> {
>         if (current->need_resched)
>                 schedule();
>         else
>                 udelay(us);
> }
> 

The locical answer is run with HZ=10000 so you get 100us intervals, 
right ;o). On systems with multiple hardware timers you could kick off a 
single event at 200us, couldn't you? I've done that before with the 
extra timer assigned exclusively to a resource. It's not a giant time 
slice, but at least you feel like you're allowing something to happen, 
right?

> 
> --
> dwmw2


-- 
Joe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
