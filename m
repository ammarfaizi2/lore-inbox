Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289556AbSCGB0p>; Wed, 6 Mar 2002 20:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289366AbSCGB0f>; Wed, 6 Mar 2002 20:26:35 -0500
Received: from mnh-1-01.mv.com ([207.22.10.33]:36620 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S289556AbSCGB00>;
	Wed, 6 Mar 2002 20:26:26 -0500
Message-Id: <200203070127.UAA05891@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Wed, 06 Mar 2002 18:20:27 EST."
             <20020306182026.F866@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Mar 2002 20:27:51 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bcrl@redhat.com said:
> Go back in the thread: I suggested making it an option that the user
> has to  turn on to allow his foot to be shot.

OK, this seems to be the relevant quote (and you seem to be referring to the
kernel build segfaults - correct me if I'm wrong):

bcrl@redhat.com said:
> a UML failing at startup  with out of memory is better than random
> segvs at some later point when the  system is under load.

I showed the kernel build segfaulting as an improvement over UML hanging, 
which is the alternative behavior.

The segfaults were caused by me implementing the simplest possible response
to alloc_pages returning unbacked pages, which is to return NULL to the 
caller.  This is actually wrong because in this failure case, it effectively
changes the semantics of GFP_USER, GFP_KERNEL, and the other blocking GFP_* 
allocations to GFP_ATOMIC.  And that's what forced UML to segfault the 
compilations.

A slightly fancier recovery would loop calling alloc_pages until it got a set
of already-backed pages (with some possible sleeping in alloc_pages in there).
That would preserve the blocking semantics of GFP_USER, GFP_KERNEL, et al,
and would have allowed the UML userspace (the kernel build) to continue working
as it should.

So, a slightly improved version of the patch (which I can write up if you're
interested in seeing it) would have allowed UML and its userspace to continue
running fine (albeit in less memory than it expected) in the presence of an
overcommited tmpfs.

				Jeff

