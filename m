Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286625AbRLUWKN>; Fri, 21 Dec 2001 17:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286626AbRLUWKE>; Fri, 21 Dec 2001 17:10:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53255 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286625AbRLUWJv>; Fri, 21 Dec 2001 17:09:51 -0500
Message-ID: <3C23B308.9080800@zytor.com>
Date: Fri, 21 Dec 2001 14:09:12 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: robert@schwebel.de
CC: Linux Kernel List <linux-kernel@vger.kernel.org>, linux-embedded@waste.org,
        rkaiser@sysgo.de
Subject: Re: AMD SC410 boot problems with recent kernels
In-Reply-To: <Pine.LNX.4.33.0112212154100.10528-200000@callisto.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:

> Hi,
> 
> As I reported some days ago in
> 
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=100876129529834&q=raw
> 
> there are boot problems with new kernels on AMD SC410 processors.


"On one particular SC410 board."


> Symptom
> is that the machine reboots right in the middle of the initialisation of
> the serial port (indeed, right in the middle of a printk message).
> 
> In the meantime I've tracked down the problem, but cannot fully find the
> origin. Here are some facts:
> 
> - The problem came in in 2.4.15. Linus has merged in some changes to
>   the boot code by H. Peter Anvin (which basically are a Good Thing(TM)).
>   They affect arch/i386/boot/setup.S.
> 
> - I could narrow it down to the A20 gate routines. My machine's BIOS
>   doesn't seem to have the appropiate routine, so the algorithm falls
>   back to using the keyboard controller method (which was also used
>   in the old code).
> 
> - The problem seems to come from the code that waits for A20 gate to
>   be _really_ enabled (shortly after a20_kbc:).
> 
> Attached is a experimental patch which demonstrates the problem: in line
> 687 you can change with a jump to "old_wait" or "new_wait" which routine
> shall be used. With the old one the machine starts, with the new one it
> reboots.
> 
> I must say I do not really understand what the problem is. First I thought
> that maybe the loop counter overruns, but it doesn't seem to happen. I
> have written the counter value to a port with LEDs and it seems to contain
> "1" when the waiting loop detects the successful A20 switch.
> 
> Any idea would be helpful...
> 


The loop counter you're outputting is the 2nd byte of the loop counter,
which really isn't interesting; what probably makes more sense to output
is the value of %dx in your code.

I would like to suggest making the following changes and try them out:

a) Change A20_TEST_LOOPS to something like 32768 in the new kernel code.

b) Add a "call delay" between the movw and the cmpw in your old_loop
   and see if it suddenly breaks;

c) Check what your %dx value is (if it's nonzero, there might be an
   issue.)

d) Once again, please complain to your motherboard/BIOS vendor and tell
   them to implement int 15h, ax=2401h.

e) Add a strictly serializing instruction sequence, such as:

	pushw %dx
	smsw %dx
	lmsw %dx
	popw %dx		

   ... where the "call delay" call is in a20_test.

	-hpa

