Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRC0H7Y>; Tue, 27 Mar 2001 02:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130770AbRC0H7R>; Tue, 27 Mar 2001 02:59:17 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:43272 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S130768AbRC0H7I>; Tue, 27 Mar 2001 02:59:08 -0500
Message-ID: <3AC04810.223A829E@idb.hist.no>
Date: Tue, 27 Mar 2001 09:58:08 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <E14gEkJ-0003aF-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > >How do you return an out of memory error to a C program that is out of memory
> > >due to a stack growth fault. There is actually not a language construct for it
> > SIGSEGV.
> > Stack overflow for a language like C using standard implementation techniques
> > is the same as a page fault while accessing a page for which there is no backing
> > store. SIGSEGV is the logical choice, and the one I'd expect on other Unices.
> 
> Guess again. You are expanding the stack because you have no room left on it.
> You take a fault. You want to report a SIGSEGV. Now where are you
> going to put the stack frame ?
> 
> SIGSEGV in combination with a preallocated alternate stack maybe, but then you
> still need to recover. C++ you can maybe do it with exception handling but
> C doesnt really have the structure and longjmp just doesnt cut it.

Seems to me a guard page would do the trick.  Make the last page of the
stack
non-overcommitable and marked not present.  Maybe non-swappable too in
case
nothing else can be swapped out for some reason.
(Yes, that wastes a page per process)
Whenever we hit the guard page, try expanding the stack.  
If it works - fine.  If not - make the guard page present _and_ deliver
the SIGSEGV using this last page of stack.  No complicated alternate
stack construct, just report OOM one page in advance.

OOM is still possible if the program don't handle SIGSEGV well.
But a smart program now have the option of doing emergency deallocations
and/or dump its precious intermediate results to file.

Helge Hafting
