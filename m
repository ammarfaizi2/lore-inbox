Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263297AbTJPXRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 19:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbTJPXRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 19:17:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6102 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263297AbTJPXRT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 19:17:19 -0400
Message-ID: <3F8F26F0.6080002@pobox.com>
Date: Thu, 16 Oct 2003 19:17:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Eli Billauer <eli_billauer@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [RFC] frandom - fast random generator module
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com> <20031016102020.A7000@schatzie.adilger.int> <3F8EC7D0.5000003@pobox.com> <20031016121825.D7000@schatzie.adilger.int>
In-Reply-To: <20031016121825.D7000@schatzie.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> On Oct 16, 2003  12:31 -0400, Jeff Garzik wrote:
> 
>>Andreas Dilger wrote:
>>
>>>Actually, there are several applications of low-cost RNG inside the kernel.
>>>
>>>For Lustre we need a low-cost RNG for generating opaque 64-bit handles in
>>>the kernel.  The use of get_random_bytes() showed up near the top of
>>>our profiles and we had to invent our own low-cost crappy PRNG instead (it's
>>>good enough for the time being, but when we start working on real security
>>>it won't be enough).
>>>
>>>The tcp sequence numbers probably do not need to be crypto-secure (I could
>>>of course be wrong on that ;-) and with GigE or 10GigE I imagine the number
>>>of packets being sent would put a strain on the current random pool.
>>
>>
>>We don't need "low cost RNG" and "high cost RNG" in the same kernel. 
>>That just begs a "reduce RNG cost" solution...  I think security experts 
>>can easily come up with arguments as to why creating your own "low-cost 
>>crappy PRNG" isn't needed -- you either need crypto-secure, or you 
>>don't.  If you don't, then you could just as easily create an ascending 
>>64-bit number for your opaque filehandle, or use a hash value, or some 
>>other solution that doesn't require an additional PRNG in the kernel.
> 
> 
> Hmm, so every part of the kernel that doesn't need crypto-secure RNG data
> (i.e. fast and relatively unique) should implement its own hash/PRNG then?
> It isn't a matter of unbreakable crypto, but the fact that we want relatively
> unique values that will not be the same on a reboot.  Currently we do just
> as you propose for our "crappy PRNG", which is "grab 8 bytes via
> get_random_bytes and increment", but that is a little _too_ easy to guess
> (although good enough for the time being).

If you care at all about it being easy to guess, then why bother with 
the crappy PRNG?  :)

If you _don't_ care about the numbers being easy to guess -- i.e. you 
simply want unique values -- then it doesn't seem like a PRNG is needed 
at all.  With a random number you have to deal with collisions between 
nodes choosing the same number coincidentally _anyway_, so why not just 
use sequence numbers?


>>For VIA CPUs, life is easy.  Use xstore insn and "You've got bytes!"  :)
> 
> 
> As you say, we could throw away even our crappy PRNG and get better data
> with a single opcode.  So you advocate we add CPU/arch-specific code into
> our filesystem?  How about we add a wrapper around all the different
> CPU-specific RNG codes and call it the "low cost RNG" which will be faster
> _and_ give better data than any explicitly-coded PRNG. ;-)  For our needs
> at least, the asm-generic code would be on the order of maybe 15 lines of C:

Let's see what pans out...  It sounds like the random driver has 
untapped performance potential, and could be made more SMP-friendly...

FWIW, for h/w RNGs, I prefer the model where a userspace daemon feeds 
the kernel entropy pool.  On most days, you will have full entropy 
buffers because 'xstore' generates random data much faster than most 
apps consume it.  But the userspace daemon can also throttle (nice to 
PM), validate the h/w RNG (ugly and costly to do in-kernel), and utilize 
a few processor-dependent features that increase xstore's throughput in 
userspace.

Then the problem simply becomes one of making sure you can copy entropy 
out of kernel memory buffers efficiently.

	Jeff



