Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318955AbSHMHVZ>; Tue, 13 Aug 2002 03:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318957AbSHMHVZ>; Tue, 13 Aug 2002 03:21:25 -0400
Received: from [62.40.73.125] ([62.40.73.125]:28339 "HELO Router")
	by vger.kernel.org with SMTP id <S318955AbSHMHVY>;
	Tue, 13 Aug 2002 03:21:24 -0400
Date: Tue, 13 Aug 2002 09:24:52 +0200
From: Jan Hudec <bulb@ucw.cz>
To: "Woodruff, Robert J" <woody@co.intel.com>
Cc: "'daniel sheltraw'" <l5gibson@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel to user-space communication
Message-ID: <20020813072451.GA26847@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	"Woodruff, Robert J" <woody@co.intel.com>,
	'daniel sheltraw' <l5gibson@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <D9223EB959A5D511A98F00508B68C20C0BFB80E7@orsmsx108.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9223EB959A5D511A98F00508B68C20C0BFB80E7@orsmsx108.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 10:52:45AM -0700, Woodruff, Robert J wrote:
> There are a couple of techniques one can use.
> First, you can set up a piece of memory that is shared
> between the kernel and the user process and when the 
> interrupt occurs, set a flag in memory. The user process
> can poll the memory to see if an interrupt happened.
> 
> Coarse, you might not want to waist CPU polling all day,
> so you could use signals (like SIGUSR1) to block, and have the 
> kernel send the signal when the interrupt occurs. Only problem
> with signals is that they are not stackable.

You don't waste CPU polling all day! The name 'poll' seems to imply
that, but it does not use CPU wile waiting (what it does is looks if
event is already pending and add current to wait queue on each
descriptor - the function that makes data available then wakes it up).
And it's a whole lot faster than signals. Signal setup is slower than
context switch.

> Another technique is to implement the concept of a wait object,
> you write a simple driver that manages these. The user process
> does an ioctl to the wait object driver when it wants to wait for 
> an interrupt. The ioctl sleeps if the interrupt has not occurred.
> The kernel then calls wakeup when the interrupt 
> happens and the ioctl completes. 
> We implemented a mechanism like this for InfiniBand,
> which allows user level I/O to the hardware and we needed a way to
> signal I/O completions (interrupts) to the user process. 
> If you are interested
> in an example, take a look at the early reference InfiniBand code
> at http://sourceforge.net/projects/infiniband.

Which is _exactly_ what poll does, just more work! (because you have to
write things poll_wait would do for you and you have to be very
careful).

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
