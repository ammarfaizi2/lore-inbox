Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131188AbQKACgV>; Tue, 31 Oct 2000 21:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131141AbQKACgL>; Tue, 31 Oct 2000 21:36:11 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:40201 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131189AbQKACfy>;
	Tue, 31 Oct 2000 21:35:54 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Russell King <rmk@arm.linux.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7 
In-Reply-To: Your message of "Tue, 31 Oct 2000 09:31:09 -0800."
             <Pine.LNX.4.10.10010310930110.6866-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 01 Nov 2000 13:35:46 +1100
Message-ID: <21820.973046146@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000 09:31:09 -0800 (PST), 
Linus Torvalds <torvalds@transmeta.com> wrote:
>On Wed, 1 Nov 2000, Keith Owens wrote:
>>
>> LINK_FIRST is processed in the order it is specified, so a.o will be
>> linked before z.o when both are present.  See the patch.
>
>So why don't you do the same thing for obj-y, then?
>
>Why can't you do
>
>	LINK_FIRST=$(obj-y)
>
>and be done with it?

You are assuming that every object in obj-y has a link order
requirement.  This is *not* true.  To use your own example

  O_OBJS is all objects.
  OX_OBJS is the subset of O_OBJS that have SYMTABS.
  LINK_FIRST is the subset of O_OBJS that have link order dependencies
  and must be linked first if present.
  LINK_LAST is the subset of O_OBJS that have link order dependencies
  and must be linked last if present.

You see - OX_OBJS, LINK_FIRST, LINK_LAST are subset indicators which
modify the set of O_OBJS.

>You need to have 
>	LINK_FIRST1
>	LINK_FIRST2
>	LINK_FIRST3
>	...
>etc to get the proper ordering.

No.  LINK_FIRST := $(LINK_FIRST1) $(LINK_FIRST2) $(LINK_FIRST3)
The existing declaration order is a linear list so LINK_FIRST can
always be a linear list, no need for multiple lists.  If you really did
need multiple LINK_FIRSTn entries than the existing single order would
not be good enough either.

In almost all cases, LINK_FIRST will be one or two objects, LINK_LAST
will be zero, one or two objects.  The rest of the objects will have no
link order dependencies.  Some Makefiles already sort their obj-y list
because they have _zero_ link order requirements, they have no problems.

Look at the possible cases :-

* No link order requirements.  Do not specify LINK_FIRST/LAST.

  Object A must precede B, C must precede D, no other dependencies, in
  particular A and C can be in any order, B and D can be in any order.
    LINK_FIRST := A.o C.o
  or 
    LINK_FIRST := C.o A.o
  You do not specify _all_ the ordering, just the ones that must come
  first.  The rest of the order drops out automatically.

* Card foo is supported by drivers baz, bar, foop.  Try baz last.
  LINK_LAST := baz.o.
  You do not specify _all_ the ordering, just the ones that must come
  last.  The rest of the order drops out automatically.

* SCSI.  This is poorly documented (one of the problems that LINK_xxx
  will solve) but AFAIK the requirements are
    buslogic must be before aha1542
    NCR53c406a must be before qlogic
    st, sd_mod, sr_mod, sg must be after all drivers.
  LINK_FIRST := BusLogic.o NCR53c406a.o
  LINK_LAST  := st.o sd_mod.o sr_mod.o sg.o 

>In many other cases, like SCSI, we need almost _total_ ordering. For such
>a case, theer is no "first" or "last" - there is a well-specific ORDER.

I refuse to believe that SCSI needs a total order.  There are only a
few inter driver problems that require the probe to run in a specific
order.  The rest of the drivers can run in any order.

If all of the 82 config options in SCSI really need to be in that exact
order, where is it documented and why do they need to be in that order?
Having a single fixed probe order to handle machines with mutiple types
of SCSI cards is not a good enough reason.  People with multiple SCSI
cards already change the order of scsi entries to get the probe order
that suits them, LINK_FIRST will make that even easier.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
