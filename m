Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbSLQSWs>; Tue, 17 Dec 2002 13:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265266AbSLQSWr>; Tue, 17 Dec 2002 13:22:47 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:42932
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265230AbSLQSWq>; Tue, 17 Dec 2002 13:22:46 -0500
Message-ID: <3DFF6D4B.3060107@redhat.com>
Date: Tue, 17 Dec 2002 10:30:35 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Matti Aarnio <matti.aarnio@zmailer.org>, Hugh Dickins <hugh@veritas.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212170948380.2702-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212170948380.2702-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Uli, how about I just add one ne warchitecture-specific ELF AT flag, which
> is the "base of sysinfo page". Right now that page is all zeroes except
> for the system call trampoline at the beginning, but we might want to add
> other system information to the page in the future (it is readable, after
> all).
> 
> So we'd have an AT_SYSINFO entry, that with the current implementation
> would just get the value 0xfffff000. And then the glibc startup code could
> easily be backwards compatible with the suggestion I had in the previous
> email. Since we basically want to do an indirect jump anyway (because of
> the lack of absolute jumps in the instruction set), this looks like the
> natural way to do it.

Yes, I definitely think that a new AT_* value is at order and it's a
nice way to determine the address.

But it will eliminate the problem.  Remember: the x86 (unlike x86-64)
has no PC-relative data addressing mode.  I.e., in a DSO to find a
memory location with an address I need a base register which isn't
available anymore at the time the call is made.

You have to assume that all the registers, including %ebp, are used at
the time of the call.  This makes it impossible to find a memory
location in a DSO without text relocation (i.e., making parts of the
code writable, at least for a moment).  This is time consuming and not
resource friendly.

There is one way around this and maybe it is what should be done: we
have the TLS memory available.  And since this vsyscall stuff gets
introduced after the TLS is functional it is a possibility.

The address received in AT_SYSINFO is stored in a word in the TCB
(thread control block).  Then the code to call through this is a variant
of what I posted earlier

  movl $__NR_##name, %eax
  call *%gs:-__NR_##name+TCB_OFFSET(%eax)

In case the vsyscall stuff is not available we jump to something like

   int $0x80
   ret

The address of this code is the default value of the TCB word.


There is another thing we might want to consider.  The above code jump
to 0xfffff000 or whatever adddres is specified.  I.e., the
demultiplexing happens in the kernel.  Do we want to do this at
userlevel?  This would allow almost no-cost determination of those
syscalls which can be handled at userlevel (getpid, getppid, ...).

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

