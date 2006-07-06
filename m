Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWGFSRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWGFSRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWGFSRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:17:08 -0400
Received: from relay02.pair.com ([209.68.5.16]:37906 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1750732AbWGFSRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:17:07 -0400
X-pair-Authenticated: 71.197.50.189
Date: Thu, 6 Jul 2006 13:16:54 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: "linux-os \\\\(Dick Johnson\\\\)" <linux-os@analogic.com>
cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0607061259050.6431@turbotaz.ourhouse>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org>
 <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu>
 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu>
 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
 <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
 <Pine.LNX.4.64.0607060856080.12404@g5.osdl.org> <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
 <Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006, linux-os \(Dick Johnson\) wrote:

>
> On Thu, 6 Jul 2006, Linus Torvalds wrote:
>
>>
>>
>> On Thu, 6 Jul 2006, Linus Torvalds wrote:
>>>
>>> Any other use of "volatile" is almost certainly a bug, or just useless.
>>
>> Side note: it's also totally possible that a volatiles _hides_ a bug, ie
>> removing the volatile ends up having bad effects, but that's because the
>> software itself isn't actually following the rules (or, more commonly, the
>> rules are broken, and somebody added "volatile" to hide the problem).
>>
>> That's not just a theoretical notion, btw. We had _tons_ of these kinds of
>> "volatile"s in the original old networking code. They were _all_ wrong.
>> Every single one.
>>
>> 			Linus
>>
>
> Linus, you may have been reading too many novels.
>
> If I have some code that does:
>
> extern int spinner;
>
> funct(){
>     while(spinner)
>         ;
>
> The 'C' compiler has no choice but to actually make that memory access
> and read the variable because the variable is in another module (a.k.a.
> file).
>
> However, if I have the same code, but the variable is visible during
> compile time, i.e.,
>
> int spinner=0;
>
> funct(){
>     while(spinner)
>         ;
>
> ... the compiler may eliminate that code altogether because it
> 'knows' that spinner is FALSE, having initialized it to zero
> itself.
>
> Since spinner is global in scope, somebody surely could have
> changed it before funct() was even called, but the current gcc
> 'C' compiler doesn't care and may optimize it away entirely. To
> prevent this, you must declare the variable volatile. To do
> otherwise is a bug.

No. The compiler can only optimize away that loop if spinner is provably 
const. Otherwise, _all_ non-const global variables would need to be 
declared 'volatile' because (as you imply) the compiler could forever assume their 
initial state has not changed.

Try it. Examine the -s. The loop is always present for me, even with -O3. 
Now, you'll notice that without a barrier, the value first loaded into the register
is never reloaded, making an infinite loop. But we know the compiler makes 
such optimizations, which is why we tell the compiler that the value 
should not be cached across the magic (barrier()) line.

> Reading between the lines of your text, you are trying to say
> that object 'spinner' should remain an integer, but any access
> should be cast, like:
>
> funct() {
>     while((volatile)spinner)
>         ;
>
> This is just a matter of style. It substitutes a number of casts
> for a simple declaration. That said, I think that the current
> implementation of 'volatile' is broken because the compiler
> seems to believe that the variable has moved! It recalculates
> the address of the variable as well as accessing its value.
> This is what makes the code generation problematical.
>

Thanks,
Chase
