Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129162AbQJ3XjY>; Mon, 30 Oct 2000 18:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129822AbQJ3XjO>; Mon, 30 Oct 2000 18:39:14 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:3599 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129162AbQJ3XjE>;
	Mon, 30 Oct 2000 18:39:04 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7 
In-Reply-To: Your message of "Mon, 30 Oct 2000 15:15:57 -0800."
             <Pine.LNX.4.10.10010301508360.1085-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Oct 2000 10:38:57 +1100
Message-ID: <12109.972949137@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000 15:15:57 -0800 (PST), 
Linus Torvalds <torvalds@transmeta.com> wrote:
>I'm saying that EVERYTHING should be order-critical.

We (almost) agree about that, we are arguing about implementation
details.  The existing implementation relies on the order that objects
are declared.  In almost all cases there are no documented reasons for
the existing order, people who know about the link order problems are
scared to change declaration orders.  OTOH, relying on declaration
order is error prone, people who do not know about the side effects of
declaration order try to change it and sometimes it works, sometimes it
breaks.

kbuild 2.5 splits link order into three categories.  Those that must
come first, in the order they are specified - LINK_FIRST.  Those that
must come last, in the order they are specified - LINK_LAST.
Everything else, in no defined order.  This solves the documentation
problem, use of LINK_FIRST and LINK_LAST is explicit and the reasons
for the order will be documented, or else!  Declaration order is then
irrelevant, it can be any order that makes sense to the developers.
The end effect if the same, LINK_FIRST/LAST is a better implementation.

>It is NEVER acceptable to change the order of object files.

It is NEVER acceptable to change the order of object files, but only
for those files where the developer has explicitly said what the order
must be.  In the case of USB, the developers say usb.o must be first,
the rest can be in any order.

>Then we change the meaning of OX_OBJS, and instead of saying
>
>	ALL_O = $(OX_OBJS) $(O_OBJS)
>
>we just say
>
>	ALL_O = $(O_OBJS)
>
>and the meaning of $OX_OBJS is the _subset_ of object file that have
>SYMTAB objects.

We do not have an automatic way of detecting SYMTAB objects, OX_OBJS is
the only way that 2.4 kbuild can tell if an source has SYMTAB or not.
I could change Rules.make to grep the sources and work out what the
flags should be but that is messy and affects all of 2.4 kbuild.

>This should all work pretty much as-is, with som every simple
>modifications to existing old-style Makefiles, and with some even simpler
>modifications to the new-style ones. In fact, it should remove pretty much
>all the ugly games that new-style files do.

Let me get this straight.  I provide a minimal patch that helps
document link order, is compatible with kbuild 2.5 and only affects
usb.  But you want me to change the meaning of OX_OBJS, add grep to
Rules.make, edit all the old style Makefiles, change all the
bolierplate code in new style makefiles, in short to hit all of 2.4
kbuild.  Why?

>And it should make all this FIRST/LAST object file mockery a total
>non-issue, because the whole concept turns out to be completely
>unnecessary.

Only if you think that documentation is unncessary.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
