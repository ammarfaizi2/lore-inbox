Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290272AbSAXF7u>; Thu, 24 Jan 2002 00:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290270AbSAXF7k>; Thu, 24 Jan 2002 00:59:40 -0500
Received: from rj.SGI.COM ([204.94.215.100]:11751 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S290267AbSAXF7a>;
	Thu, 24 Jan 2002 00:59:30 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb/mdb hardware breakpoints broken 2.4.17/18 
In-Reply-To: Your message of "Wed, 23 Jan 2002 14:00:45 PDT."
             <20020123140045.A17976@vger.timpanogas.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 24 Jan 2002 16:59:21 +1100
Message-ID: <2504.1011851961@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002 14:00:45 -0700, 
"Jeff V. Merkey" <jmerkey@vger.timpanogas.org> wrote:
>Please find a patch that corrects the problem with hardware 
>breakpoints not working with kdb.  I have noticed that gdb uses 
>inserted int3 (0xCC) breakpoints (as does kdb) for soft breakpoint
>support, so this fix may not affect these programs.  It is not 
>clear why every signal handled is writing a 0 t the DR7 register.

Not a 0, it is %0, gcc asm parameter 0.  There used to be a bug in
ptrace handling where db7 would get cleared in taps.c and would not get
reinstated until one timeslice after the initial trap.  Fixed by James
Cownie in June 2000 by reinstating db7 before passing the signal to
user space.

The conflict with kdb is inherent in the lack of a kernel interface for
assigning debug registers.  gdb/ptrace always uses i386 db4-7 no matter
what kdb is doing.  The kernel always uses db7, even if no tracing is
being done.  If you want to use gdb/ptrace then restrict your kdb usage
to db0-3, without gdb/ptrace kdb can use db0-6.

It would be nice to have a proper debug register function to
automatically detect conflicts and tell one of the debuggers to go
away.   However Linus "I don't want kernel debuggers" Torvalds does not
care about this problem and I don't want the footprint of kdb to be any
bigger than it has to be.  So kdb relies on the user to know which
debug registers then can use.

