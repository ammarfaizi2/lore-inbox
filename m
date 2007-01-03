Return-Path: <linux-kernel-owner+w=401wt.eu-S1753054AbXACBq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbXACBq5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 20:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092AbXACBq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 20:46:57 -0500
Received: from smtp.osdl.org ([65.172.181.25]:56624 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030AbXACBq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 20:46:56 -0500
Date: Tue, 2 Jan 2007 17:43:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Adrian Bunk <bunk@stusta.de>,
       "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <200701022318.11680.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.64.0701021640110.4473@woody.osdl.org>
References: <200612201421.03514.s0348365@sms.ed.ac.uk>
 <200701022156.48919.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0701021408280.4473@woody.osdl.org>
 <200701022318.11680.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jan 2007, Alistair John Strachan wrote:
>
> eax: 00000008   ebx: 00000000   ecx: 00000008   edx: 00000000
> esi: f70f3e9c   edi: f7017c00   ebp: f70f3c1c   esp: f70f3c0c
>
> Code: 58 01 00 00 0f 4f c2 09 c1 89 c8 83 c8 08 85 db 0f 44 c8 8b 5d f4 89 c8 
> 8b 75 f8 8b 7d fc 89 ec 5d c3 89 ca 8b 46 6c 83 ca 10 3b <87> 68 01 00 00 0f 
> 45 ca eb b6 8d b6 00 00 00 00 55 b8 01 00 00
> EIP: [<c0156f60>] pipe_poll+0xa0/0xb0 SS:ESP 0068:f70f3c0c
> 
> Chuck observed that the kernel tries to reenter pipe_poll half way through an 
> instruction (c0156f5f->c0156f60); it's not a single-bit error but an 
> off-by-one.

It's not an off-by-one either (eg say we're taking an exception and 
screiwing up %eip by one somehow).

The code sequence in question is

	mov    %ecx,%edx
	mov    0x6c(%esi),%eax
	or     $0x10,%edx
	cmp    0x168(%edi),%eax		<--
	cmovne %edx,%ecx
	jmp    ...

and it's in the second byte of the "cmp".

And yes, it definitely entered there, because trying other random 
entry-points will have either invalid instructions or instructions that 
would fault due to NULL pointers. HOWEVER, it's also not as simple as 
"took an interrupt, and returned with %eip incremented by one", becasue 
your %edx is zero, so it won't have done that "or $10,%edx" and then some 
interrupt happened and screwed up just %eip.

So it's literally a random %eip, but since you say it's consistently in 
that function, it's not truly "random". There's something that triggers it 
just _there_.

However, that's a damn simple function. There's _nothing_ there. The 
particular code that is involved right there is literally

	if (!pipe->writers && filp->f_version != pipe->w_counter)
		mask |= POLLHUP;

and that's it.  There's not even anything half-way interesting around it, 
except for the "poll_wait()" call, but even that is about as common as
you can humanly get..

Looking at the register set and the stack, I see:

	Stack:	00000000
		00000000  <- saved %ebx (dunno, seems dead in caller)
		f70f3e9c  <- saved %esi (== pollfd in do_pollfd)
		f6e111c0  <- saved %edi	(== filp)
		f70f3fa4  <- outer EBP (looks reasonable) 
		c015d7f3  <- return address (do_sys_poll+0x253/0x480)

and the strange thing is that when the oops happens, it really looks like 
%esi _still_ contains the value it had originally (and that is saved on 
the stack). But afaik, from your disassembly, it should have been 
overwritten by the initial %eax, which should have had the same value as 
%edi on entry...

IOW, none of it really makes any sense. The stack frames look fine, so we 
_did_ enter at the beginning of the function (and it wasn't the *poll fn 
pointer that was corrupt.

> The suggestions I've had so far which I have not yet tried:
> 
> -	Select a different x86 CPU in the config.
> 		-	Unfortunately the C3-2 flags seem to simply tell GCC
> 			to schedule for ppro (like i686) and enabled MMX and SSE
> 		-	Probably useless

Actually, try this one. Try using something that doesn't like "cmov". 
Maybe the C3-2 simply has some internal cmov bugginess. 

		Linus
