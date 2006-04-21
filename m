Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWDUSR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWDUSR0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 14:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWDUSR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 14:17:26 -0400
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62]:60076 "HELO
	smtp008.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750730AbWDUSRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 14:17:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=TqoTRfvhlEfp5Td2+fsWhur2KCWzei+cJnyTEd74lT4JEbE6rAQb52bHjSiCWz3ShnnOlMtSHtxodLv9tkWf9UbbekDD597obilXmES7ehRTi76CksUvaKOUGbaBFp5Toq4GAPYVmN9mlec0csU0tMShoRJBlq+b0Dp2fWPv3Hs=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Date: Fri, 21 Apr 2006 20:16:34 +0200
User-Agent: KMail/1.8.3
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <20060420090514.GA9452@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060420090514.GA9452@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604212016.36859.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 April 2006 11:05, Heiko Carstens wrote:
> > Add PTRACE_SYSCALL_MASK, which allows system calls to be selectively
> > traced.  It takes a bitmask and a length.  A system call is traced
> > if its bit is one.  Otherwise, it executes normally, and is
> > invisible to the ptracing parent.
> > [...]
> > +int set_syscall_mask(struct task_struct *child, char __user *mask,
> > +		     unsigned long len)
> > +{
> > +	int i, n = (NR_syscalls + 7) / 8;
> > +	char c;
> > +
> > +	if(len > n){
> > +		for(i = NR_syscalls; i < len * 8; i++){
> > +			get_user(c, &mask[i / 8]);
> > +			if(!(c & (1 << (i % 8)))){
> > +				printk("Out of range syscall at %d\n", i);
> > +				return -EINVAL;
> > +			}
> > +		}
> > +
> > +		len = n;
> > +	}
>
> Since it's quite likely that len > n will be true (e.g. after installing
> the latest version of your debug tool) it would be better to silently
> ignore all bits not within the range of NR_syscalls.

For strace -e what you say is reasonable, since it will set only a few bits to 
1 (the ones for the requested syscalls) and everything else to 0. Also, 
there's a problem for this case since the host will 1-extend the mask, so an 
old strace would trace some unwanted and unknown syscalls. I.e. we want here 
to 0-extend the mask and only maybe complain for bits set to 1.

For UML, instead, it's important to set that some peculiar syscalls are not 
traced, that the mask is 1-extended and that errors are reported.

So, I suggest a "flags" parameter for this. Sadly, we're using the ptrace() 
syscall and there's no 5th argument normally, we could either use it (IIRC 
some calls use the 5th regs indeed), or pass as "data" a struct with flags 
and the mask.

The flags could be:

MASK_DEFAULT_TRACE (set the default to 1 for remaining bits)
MASK_DEFAULT_IGNORE (set the default to 0 for remaining bits)
MASK_STRICT_VERIFY (return -EINVAL for bits exceeding NR_syscalls and set 
differently than the default).

probably with a reasonable prefix to avoid namespace pollution (something like 
"PT_SC_-").

> There is no point in flooding the console.

This one is at all correct - that printk is only meaningful for debug.

> The tracing process won't see 
> any of the non existant syscalls it requested to see anyway.

No, you misunderstood the code, it does the opposite very different - the loop 
will detect the syscalls that the process wanted to ignore but don't exist. 
For the UML case, it needs it must trace that syscall and execute it on his 
own rather than rely on the host performing it.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Bolletta salata? Passa a Yahoo! Messenger with Voice 
http://it.messenger.yahoo.com
