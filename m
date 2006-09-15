Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWIOI7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWIOI7A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWIOI7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:59:00 -0400
Received: from aun.it.uu.se ([130.238.12.36]:30183 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750720AbWIOI67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:58:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17674.27416.420259.744117@alkaid.it.uu.se>
Date: Fri, 15 Sep 2006 10:58:00 +0200
From: Mikael Pettersson <mikpe@it.uu.se>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, acahalan@gmail.com, ak@suse.de,
       arjan@infradead.org, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@osdl.org,
       zach@vmware.com
Subject: Re: Assignment of GDT entries
In-Reply-To: <450A6238.9050404@goop.org>
References: <200609150755.k8F7tKUD005518@alkaid.it.uu.se>
	<450A6238.9050404@goop.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge writes:
 > Mikael Pettersson wrote:
 > > The i386 TLS API has three components:
 > >
 > > (1) set_thread_area(entry_number == -1):
 > >     allocates and sets up the first available TLS entry and
 > >     copies the chosen GDT index back to user-space
 > > (2) set_thread_area(6 <= entry_number && entry_number <= 8):
 > >     allocates and sets up the indicated GDT entry
 > > (3) get_thread_area(6 <= entry_number && entry_number <= 8):
 > >     retrieves the contents of the indicated GDT entry
 > >
 > > Only (1) works in x86-64's ia32 emulation, the other two fail
 > > with EINVAL because x86-64 only accepts GDT indices 12 to 14
 > > for TLS entries. glibc only uses (1).
 > >
 > > If you move the i386 TLS GDT entries to other indices then you
 > > break (2) and (3) also on i386.
 > >   
 > 
 > (2) and (3) are always OK if you pass it the result of (1) - ie to 
 > update or readback a previously allocated descriptor.  Neither is useful 
 > without having done (1) first.

In the real world a process' state is influenced by code I have little
control over, usually glibc and other libraries, and fork(). Using (3)
I can inspect parts of my process' state that I did not initialize myself.

 >  The fact that 32-on-32 and 32-on-64 
 > differ here means that nothing can (an apparently nothing does) depend 
 > on hardcoded knowledge of the TLS descriptor indicies anyway.

No, it means that x86-64's ia32 emulation was implemented by someone
who either didn't realize the difference, or didn't care (because
"only glibc matters").

 > > It's not difficult to design a better i386 TLS API that avoids
 > > requiring user-space to know the actual GDT indices (just use
 > > logical TLS indices and always copy the GDT index to user-space).
 > > but unfortunately that doesn't help us
 > >   
 > 
 > You still need the real indicies to construct a selector to put into a 
 > segment register - ie, actually do something useful.

Sure.

 >  Changing the API 
 > to use abstract "TLS indicies" would also require a call to return the 
 > "TLS base", which hardly seems like an improvement.

The TLS base can obviously be zero.

User-space asks to access TLS #n (for allocs #n can be -1).
The kernel maps that to GDT index #m.
The kernel stores #m in the user-space buffer.
User-space maps #m to a selector.

 > Also, there's no inherent reason why the TLS indicies should be 
 > contigious; it happens to be true, but there's nothing useful userspace 
 > can do with that knowledge.  Allowing them to be discontigious may be 
 > helpful, for example, in packing the most used TLS entries (ie #1) into 
 > a hot cache line, while putting the lesser-used ones elsewhere.  The 
 > current API could deal with this without needing to change.

I have said nothing that would prevent the use of sparse TLS GDT indices.

Look, I'm not saying the current API is perfect, far from it. But it does
have valid usage modes which are broken in x86-64's ia32 emulation, and
will break on i386 of you reallocate the TLS GDT indices. This is a fact.

This is why I'm asking that if you change things (thus breaking binary
compatibility even more), that a corrected API be placed in new syscalls.

That is, instead of forcing user-space to do

   uname
   if (version >= 2.6.N)
      call {set,get}_thread_area with new-style parameters
   else
      call {set,get}_thread_area with old-style parameters

it should do

   call new_{set,get}_thread_area with new-style parameters
   if (ENOSYS)
     call old_{set,get}_thread_area with old-style parameters

/Mikael
