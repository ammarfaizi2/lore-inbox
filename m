Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287697AbSAXMjQ>; Thu, 24 Jan 2002 07:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287699AbSAXMjG>; Thu, 24 Jan 2002 07:39:06 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:6864 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S287697AbSAXMi6>;
	Thu, 24 Jan 2002 07:38:58 -0500
Message-ID: <3C504F37.9FF10EF0@in.ibm.com>
Date: Thu, 24 Jan 2002 13:15:19 -0500
From: Suparna Bhattacharya <suparna@in.ibm.com>
Organization: IBM
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb/mdb hardware breakpoints broken 2.4.17/18
In-Reply-To: <20020123140045.A17976@vger.timpanogas.org> <2504.1011851961@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Wed, 23 Jan 2002 14:00:45 -0700,
> "Jeff V. Merkey" <jmerkey@vger.timpanogas.org> wrote:
> >Please find a patch that corrects the problem with hardware
> >breakpoints not working with kdb.  I have noticed that gdb uses
> >inserted int3 (0xCC) breakpoints (as does kdb) for soft breakpoint
> >support, so this fix may not affect these programs.  It is not
> >clear why every signal handled is writing a 0 t the DR7 register.
> 
> Not a 0, it is %0, gcc asm parameter 0.  There used to be a bug in
> ptrace handling where db7 would get cleared in taps.c and would not get
> reinstated until one timeslice after the initial trap.  Fixed by James
> Cownie in June 2000 by reinstating db7 before passing the signal to
> user space.
> 
> The conflict with kdb is inherent in the lack of a kernel interface for
> assigning debug registers.  

As Bharata mentioned this sort of a thing is exactly what we use today 
in dprobes. Guess we could separate out that piece as a patch so you can
take a look. We had posted one long back on this list, but have now
cleaned
up and reorganized it a bit. In fact we've used this for a while for
preparing 
consolidated patches containing both dprobes and kdb, in a way that also
interoperates with gdb (we don't want our watchpoint settings to get
overwritten
on a context switch for example).


>gdb/ptrace always uses i386 db4-7 no matter
> what kdb is doing.  The kernel always uses db7, even if no tracing is
> being done.  If you want to use gdb/ptrace then restrict your kdb usage
> to db0-3, without gdb/ptrace kdb can use db0-6.
> 
> It would be nice to have a proper debug register function to
> automatically detect conflicts and tell one of the debuggers to go
> away.   However Linus "I don't want kernel debuggers" Torvalds does not
> care about this problem and I don't want the footprint of kdb to be any
> bigger than it has to be.  So kdb relies on the user to know which
> debug registers then can use.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
