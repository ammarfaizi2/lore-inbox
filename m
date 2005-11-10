Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVKJA14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVKJA14 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbVKJA14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:27:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:28824 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751111AbVKJA1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:27:55 -0500
Date: Wed, 9 Nov 2005 18:27:47 -0600
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: "J.A. Magallon" <jamagallon@able.es>, Kyle Moffett <mrmacman_g4@mac.com>,
       Douglas McNaught <doug@mcnaught.org>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: typedefs and structs
Message-ID: <20051110002746.GW19593@austin.ibm.com>
References: <20051108232327.GA19593@austin.ibm.com> <B68D1F72-F433-4E94-B755-98808482809D@mac.com> <20051109003048.GK19593@austin.ibm.com> <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local> <20051109004808.GM19593@austin.ibm.com> <19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com> <20051109111640.757f399a@werewolf.auna.net> <Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net> <20051109192028.GP19593@austin.ibm.com> <Pine.LNX.4.58.0511091339090.31338@shell3.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0511091339090.31338@shell3.speakeasy.net>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 01:43:10PM -0800, Vadim Lobanov was heard to remark:
> On Wed, 9 Nov 2005, linas wrote:
> 
> > I guess the real point that I'd wanted to make, and seems
> > to have gotten lost, was that by avoiding using pointers,
> > you end up designing code in a very different way, and you
> > can find out that often/usually, you don't need structs
> > filled with a zoo of pointers.
> >
> > Minimizing pointers is good: less ref counting is needed,
> > fewer mallocs are needed, fewer locks are needed
> > (because of local/private scope!!), and null pointer
> > deref errors are less likely.
> >
> > There are even performance implications: on modern CPU's
> > there's a very long pipeline to memory (hundreds of cycles
> > for a cache miss! Really! Worse if you have run out of
> > TLB entries!). So walking a long linked list chasing
> > pointers can really really hurt performance.
> >
> > By using refs instead of pointers, it helps you focus
> > on the issue of "do I really need to store this pointer
> > somewhere? Will I really need it later, or can I be done
> > with it now?".
> >
> > I don't know if the idea of "using fewer pointers" can
> > actually be carried out in the kernel. For starters,
> > the stack is way too short to be able to put much on it.
> 
> I really see the two issues at hand as being very much orthogonal to
> each other.

Yes. I accidentally linked them, see below.

> Namely, you put data on the stack when you need it in the local
> 'context' only, whereas you put data globally when it needs to be
> available globally. 

Yes. But there's some flexibility.

> The C++ references are nothing more than syntactic
> sugar (and we all know what they say about that and semicolons) for
> pointers,
 
Yes.

> and so I don't see how they would affect the choices at all.
> Choosing where the data goes should be done according to the data's
> lifetime, not the specifics of how functions are declared.

My apologies for linking the idea of references to fewer pointers.
They're not linked, except in how I discovered them.

I once had a project (that used threads, so it was "kernel-like",
in that race conditions had to be dealt with).  One day, for the 
the hell of it, I decided to create a struct and keep it on the 
stack, instead of mallocing it.  Since this struct was accessed 
only by a few small, well-defined routines that did not keep any 
pointers to it, this worked just fine. And skipping the malloc/free
felt good, so I liked it.

Then I thought that maybe I could push the idea, see how far I 
could go. Well, of course, the code was filled with various 
objects, all of which *seemed* to be (or seemed to need to be) 
long-lifetime objects. And they all stored pointers to one-another,
since they all needed to get access to one-another at various points,
for various reasons. 

Well, I really wanted to alloc objects on stack, and so that forced
me to think about how to get rid of pointers (since a pointer to 
an object on stack is deadly). And that forced me to think about
lifetime. And some of this thinking was quite hard.  But encouraged
by some modest success at first, I found that I was able to 
eliminate almost all the pointers, and almost all the mallocs 
(maybe several dozen of each, scattered accross maybe several dozen
structs). And I was flabbergasted, since the resulting program
actually got smaller in the process, and faster. And the 
null-pointer derefs vanished. 

Now, maybe this was specific to the project, and can't be replicated
elsewhere.  But this was a communcations daemon: it basically 
was a pool of threads, each thread handling a long-lived,
stateful "session" of requests and responses from some remote server,
and so while its not the kernel, that's a reasonably complex thing. 

I'm not crazy enough to suggest that one could do the same thing 
in the Linux kernel, since one probably can't, but now that we're 
here and all, it does make me wonder.  FWIW, the two designs of
the commo daemon were radically different; things that were sliced 
one way got reworked to flow and be handled in a completely 
different order.  You can't just get rid of pointers with some 
trivial restructuring; you have to figure out how not to need them.

--linas
