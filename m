Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130083AbQK3QaH>; Thu, 30 Nov 2000 11:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129183AbQK3Q35>; Thu, 30 Nov 2000 11:29:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33285 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129226AbQK3Q3l>;
        Thu, 30 Nov 2000 11:29:41 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011301500.eAUF0o905978@flint.arm.linux.org.uk>
Subject: Re: [PATCH] New user space serial port driver
To: R.E.Wolff@bitwizard.nl (Rogier Wolff)
Date: Thu, 30 Nov 2000 15:00:50 +0000 (GMT)
Cc: tigran@veritas.com (Tigran Aivazian),
        patrick@bitwizard.nl (Patrick van de Lageweg),
        wolff@bitwizard.nl (Rogier Wolff),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <200011300947.KAA27728@cave.bitwizard.nl> from "Rogier Wolff" at Nov 30, 2000 10:47:34 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff writes:
> > > +static struct termios    * ussp_termios[USSP_MAX_PORTS];
> > > +static struct termios    * ussp_termios_locked[USSP_MAX_PORTS];
> 
> this SHOULD mean that these are first initialized before use. 
> 
> If you think they can be used before first being initialized by the
> code, then that's a bug, and I'll look into it.

Ah, but they are initialised before use, by arch/*/kernel/head.S.
Therefore no bug exists.

Are all these people who are saying "we should explicitly initialise
these variables" going to go through all user-space programs and fix
all those "bugs" which are there apparantly lying dormant as well?
I think they should.  If not, then I'll scream pot black. ;) Exactly
the same arguments apply there as in the kernel.  In fact even more
so - user space relies on the kernel to pass zeroed pages to user
space.  What if clear_page() doesn't work properly?

I hasten to point out that Andries Brower's example about a week ago
doesn't really work too well.  The quoted code was something along the
lines of:

/* case 1 */

static int foo = 0;

int bar()
{
	... code that relies on foo to initially be zero  ...
}

There were several arguments put forward.  One of them was that the
following would be the same:

/* case 2 */

int bar()
{
	int foo = 0;
	... same code ...
}

These two are obviously not identical.  The code will behave differently
in both cases if bar() is more than once.  The first will see the result
of calling bar() the first time.  The second case will always see foo as
zero.

However, as far as code and functionality is concerned, the first
case is identical declaring foo as:

/* case 3 */

static int foo; /* = 0 */

It contains the same documentary evidence as well, so there is no possible
argument that can be put forward to say that case 1 and case 3 do not 
functionally behave the same *provided that head.S initialises BSS and we
compile with -fno-common to ensure that we catch duplicate declarations*.

The only difference between case 1 and case 3 is that case 3 uses less
file size.

Now, I'd ask the people who had the "documentation" argument, is case 3
acceptable to you?

Big note: I'm not interested in hearing from people who try to argue that
using the BSS is a bug.  Mails with this content will be sent to /dev/null.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
