Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267691AbSLTC3O>; Thu, 19 Dec 2002 21:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267700AbSLTC3O>; Thu, 19 Dec 2002 21:29:14 -0500
Received: from mnh-1-04.mv.com ([207.22.10.36]:4613 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S267691AbSLTC3M>;
	Thu, 19 Dec 2002 21:29:12 -0500
Message-Id: <200212200241.VAA04202@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org
cc: Jeremy Fitzhardinge <jeremy@goop.org>, Julian Seward <jseward@acm.org>
Subject: Valgrind meets UML
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 19 Dec 2002 21:41:43 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After some hacking on valgrind (and help from Jeremy Fitzhardinge and Julian 
Seward), I got it to run the kernel, in the form of UML.  

I don't have a long list of bugs to report because I'm still trying to drive
the noise level down by teaching valgrind about how the kernel does business.

As a result, I have some questions that I'd appreciate advice on.

You teach it things by putting declarations in the code about what level of
access is permitted for a region of memory.  So, 

	VALGRIND_MAKE_WRITABLE(ptr, len);
	VALGRIND_MAKE_READABLE(ptr, len);

tells valgrind that the region [ ptr, ptr + len ) is open for business, and
	
	VALGRIND_MAKE_NOACCESS(ptr, len);

tells it that it's not.

First question - is sticking something (not necessarily the VALGRIND_* things)
in the code acceptable?  I personally don't see a problem with it, although
I would do something like BUFFER_RW(ptr, len), which would expand into the 
first pair of declarations if CONFIG_VALGRIND was enabled, and nothing if it's
not.

Which leads to the next question - where to put CONFIG_VALGRIND?  UML is the
only form of the kernel which valgrind will deal with any time soon, so it's
reasonable for it to be in the UML config only.  However, the memory access
declarations are going to be sprinkled around generic code, so that suggests
putting it in the generic config someplace, just conditional on UML (which 
suggests putting it back in the UML-only config :-).  

I think there would also need to be a CONFIG_VALGRIND_INCLUDE which points
to wherever the valgrind headers are installed.

I would also appreciate suggestions on what sort of memory access state table
to implement, and where best to put the declarations.  What I'm not clear
on is what sort of access a buffer should have when it's in the care of
the allocator (i.e. it's free).  If the allocator sticks information 
temporarily in the buffer, then that needs to be stated.

There are also some non-obvious places where this could be used.  
- VALGRIND_MAKE_READABLE could be used to enforce read-only data when an rwlock
is taken for reading
- it could also be used whenever there's an interface that hands out read-only
objects, and writing them is done under that interface.

So, it's not only the memory allocators that can make use of this.  We'll get
the best use of this if other subsystem maintainers figure out what rules
they have and whether valgrind can be used to enforce them.

				Jeff

