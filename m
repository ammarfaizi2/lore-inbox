Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310518AbSCPSIN>; Sat, 16 Mar 2002 13:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310517AbSCPSIE>; Sat, 16 Mar 2002 13:08:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310516AbSCPSHu>; Sat, 16 Mar 2002 13:07:50 -0500
Date: Sat, 16 Mar 2002 10:06:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <15507.12988.581489.554212@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0203160953420.31850-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Mar 2002, Paul Mackerras wrote:
> 
> > But more importantly than that, the whole point really is that the page
> > table tree as far as Linux is concerned is nothing but an _abstraction_
> > of the VM mapping hardware. It so happens that a tree format is the only
> > sane format to keep full VM information that works well with real loads.
> 
> Is that still true when we get to wanting to support a full 64-bit
> address space?

Yup.

We'll end up (probably five years from now) re-doing the thing to allow 
four levels (so a tired old x86 would fold _two_ levels instead of just 
one, but I bet they'll still be the majority), simply because with three 
levels you reasonably reach only about 41 bits of VM space.

With four levels you get 50+ bits of VM space, and since the kernel etc 
wants a few bits, we're just in the right range.

>		  Given that we can already tolerate losing PTEs for
> resident pages from the page tables quite happily (since they can be
> reconstructed from the information in the vm_area_structs and the page
> cache)

Wrong. Look again. The most common case of all (anonymous pages) can NOT 
be reconstructed.

You're making the same mistake IBM did originally.

If it needs reconstructing, it's a TLB. 

And if it is a TLB, then it shouldn't be so damn big in the first place, 
because then you get horrible overhead for flushing.

A in-memory TLB is fine, but it should be understood that that is _all_
that it is. You can make the in-memory TLB be a tree if you want to, but
if it depends on reconstructing then the tree is pointless - you might as
well use something that isn't able to hold the whole address space in the 
first place.

And a big TLB (whether tree-based or hased or whatever) is bad if it is so 
big that building it up and tearing it down takes a noticeable amount of 
time. Which it obviously does on PPC64 - numbers talk.

What IBM should do is 

 - face up to their hashes being so big that building them up is a real 
   performance problem. It was ok for long-running fortran and database 
   programs, but it _sucks_ for any other load.

 - make a nice big on-chip L2 TLB to make their legacy stuff happy (the
   same legacy stuff that is so slow at filling the TLB in software that
   they needed the humungous hashtables in the first place).

Repeat after me: there are TLB's (reconstructive caches) and there are 
page tables (real VM information). Get them straight.

		Linus

