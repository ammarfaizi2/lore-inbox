Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130337AbQK1Eoj>; Mon, 27 Nov 2000 23:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130668AbQK1Eoa>; Mon, 27 Nov 2000 23:44:30 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:11017 "EHLO
        munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
        id <S130337AbQK1EoP>; Mon, 27 Nov 2000 23:44:15 -0500
Date: Mon, 27 Nov 2000 23:15:11 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andrea Arcangeli <andrea@suse.de>, kumon@flab.fujitsu.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001127231511.C17104@munchkin.spectacle-pond.org>
In-Reply-To: <20001128042850.A29908@athlon.random> <Pine.GSO.4.21.0011272234550.7352-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0011272234550.7352-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Nov 27, 2000 at 10:35:45PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 10:35:45PM -0500, Alexander Viro wrote:
> 
> 
> On Tue, 28 Nov 2000, Andrea Arcangeli wrote:
> 
> > On Tue, Nov 28, 2000 at 12:10:33PM +0900, kumon@flab.fujitsu.co.jp wrote:
> > > If you have two files:
> > > test1.c:
> > > int a,b,c;
> > > 
> > > test2.c:
> > > int a,c;
> > > 
> > > Which is _stronger_?
> > 
> > Those won't link together as they aren't declared static.
> 
> Try it. They _will_ link together.

This is a GCC extension (actually it is a pretty common UNIX extension, but the
official standard says you can only have one definition of a global variable).

Off the top of my head, here are some reasons variables could be put in
different orders:

   1)	The compilation system has the concept of a small data pointer, which
	is a register that is assumed by the compiler to point to a small
	region of memory (it is never allocated by the compiler and setup in
	the initialization modules).  The compiler decides to put some
	variables into the small data region and other variables outside of
	it.  Typically the choice is based on size of the variable.  Small data
	pointers are typically used when the machine has plenty of registers
	and it takes 2 or more instructions to build the address of a random
	variable in memory with load high/load low type instructions, and the
	small data pointer has the upper half already loaded, and uses special
	relocations to access the variable based off of the difference of a
	special symbol.

   2)	Even without a small data pointer, a compiler might decide to sort the
	variables emitted based on either size or number of accesses to take
	advantage of instructions with smaller offsets.

   3)	The above mentioned global, non-initialized variables (ie, the
	so-called 'common' variables).  Where the linker puts the variables
	into the bss section in any order it chooses.  For example, the VMS
	linker used to sort common variables alphabetically.

   4)	For static variables, the compilation system might decide to omit the
	variable until it sees a reference to the variable, and if the first
	variable is referenced in one function, and the second is referenced
	several functions later.

   5)	At some point in the future, on machines with many more registers than
	the normal 32, the linker might see all references to a variable, and
	decide to put it in a static register rather than memory.

   6)	A checkout compiler could randomly order things specifically to catch
	these type of errors (the problem with the normal checkout compilers
	that I'm aware of, is that the kernel uses structs to talk to real
	devices and interact with system calls with fixed layouts).

-- 
Michael Meissner, Red Hat, Inc.
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
