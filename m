Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131556AbQLZHe7>; Tue, 26 Dec 2000 02:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131620AbQLZHet>; Tue, 26 Dec 2000 02:34:49 -0500
Received: from johnson.mail.mindspring.net ([207.69.200.177]:47650 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S131556AbQLZHea>; Tue, 26 Dec 2000 02:34:30 -0500
Date: Mon, 25 Dec 2000 23:03:45 -0800
From: Paul Laufer <pelaufer@csupomona.edu>
To: Mike Galbraith <mikeg@wen-online.de>, Andreas Franck <afranck@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Fatal Oops on boot with 2.4.0testX and recent GCC snapshots
Message-ID: <20001225230345.A2622@hal9000.csupomona.edu>
Mail-Followup-To: Paul Laufer <pelaufer@csupomona.edu>,
	Mike Galbraith <mikeg@wen-online.de>,
	Andreas Franck <afranck@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <00122423490000.00575@dg1kfa.ampr.org> <Pine.Linu.4.10.10012250531020.560-100000@mikeg.weiden.de> <20001225204050.A1126@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.2i
In-Reply-To: <20001225204050.A1126@Marvin.DL8BCU.ampr.org>; from th@Marvin.DL8BCU.ampr.org on Mon, Dec 25, 2000 at 08:40:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 25, 2000 at 08:40:50PM +0000 or thereabouts, Thorsten Kranzkowski wrote:
> On Mon, Dec 25, 2000 at 06:09:35AM +0100, Mike Galbraith wrote:
> > I wouldn't (not going to here;) spend a lot of time on it.  The compiler
> > has problems.  It won't build glibc-2.2, and chokes horribly on ipchains.
> > 
> > int ipt_register_table(struct ipt_table *table)
> > {
> > 	int ret;
> > 	struct ipt_table_info *newinfo;
> > 	static struct ipt_table_info bootstrap
> > 		= { 0, 0, { 0 }, { 0 }, { } };
> >                                ^
> > ip_tables.c:1361: Internal compiler error in array_size_for_constructor, at varasm.c:4456
> 
> 
> Well, I  'fixed' this by changing above line to:
>  		= { 0, 0, { 0 }, { 0 }, };
> and repeating this change (deleting the braces) about 15 times in 2 or 3 other 
> files of iptables. (patch available on request)
> Of course gcc shouldn't die but issue a useful message if/when syntax rules
> may have changed.
> 
> Apart from that and a hand-edited arch/alpha/vmlinux.lds that got some 
> newlines wrong, the kernel compiled fine and is up for over a day now.
> Though this is not intel but alpha (ev4 / AXPpci33).
> 
> Marvin:~$ uname -a
> Linux Marvin 2.4.0-test13pre4-ac2 #13 Sun Dec 24 15:26:57 UTC 2000 alpha unknown
> Marvin:~$ uptime
>   8:19pm  up 1 day,  4:28,  4 users,  load average: 0.00, 0.00, 0.00
> Marvin:~$ gcc -v
> Reading specs from /usr/lib/gcc-lib/alpha-unknown-linux-gnu/2.97/specs
> Configured with: ../gcc-20001211/configure --enable-threads --enable-shared --prefix=/usr --enable-languages=c,c++
> gcc version 2.97 20001211 (experimental)
> 
> 
> I use iptables for masquerading my local ethernet and that works as expected
> so far.
> 
> Thorsten.

Its a problem with initializing a zero-length array. This is something
that gcc has never previously been documented to do, but it has worked
in the past (most of the time). Recently it has been decided (according
to traffic on gcc-bugs and gcc-patches lists) that gcc will handle
zero-length arrays as flexable-array-members per ISO C99 standard.
AFAIK, that means that if they are to be initialized, zero-length arrays
can only exist as the last element of a structure, and that the
structure must not be embeded within another structure.

The empty brackets that Thorsten removed were initializing the zero-length
array to empty, but gcc currently has this bit of code in varasm.c
(around line 4460):

  /* ??? I'm fairly certain if there were no elements, we shouldn't have
     created the constructor in the first place.  */
  if (max_index == NULL_TREE)
    abort ();

This abort() resulted in the "Internal compiler error" that Mike noticed
earlier.  Removing the empty brackets prevents gcc from trying to
initialize the zero length array and avoids this problem. However, this
can result in warning messages about missing initializers depending upon
the warning flags given to gcc, and seems like the wrong thing to do.
 
The best solution (IMHO) for this situation is to change gcc/varasm.c to
accept empty initializers, something like:

  /* ??? I'm fairly certain if there were no elements, we shouldn't have
     created the constructor in the first place.  */
  /* No, it can be useful to initialize the zero-length array with an
     empty initializer. */
  if (max_index == NULL_TREE)
    return 0;

The rest of netfilter will still not compile because in several other C
files the initialized zero-length arrays are nested several structures
deep. If we can convince the gcc folks to drop some of the ISO C99
restrictions on the use of zero-length arrays then all will be back to
normal (as Ulrich Drepper pointed out, the ISO committee in their
infinite wisdom does not always come up with a standard that is the best
solution in the real world).  But I am not sure if that is the best
solution. Perhaps it would be better to change the netfilter code. In
any event, the gcc documentation does not say anything about not being
able to initialize zero-length arrays to empty, so this is a bug and I'm
going to talk with the gcc folks.

-Paul Laufer
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
