Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289142AbSAJDlC>; Wed, 9 Jan 2002 22:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289137AbSAJDkx>; Wed, 9 Jan 2002 22:40:53 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:9688 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S289136AbSAJDkg>;
	Wed, 9 Jan 2002 22:40:36 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15421.3378.64452.787305@napali.hpl.hp.com>
Date: Wed, 9 Jan 2002 19:40:34 -0800
To: paulus@samba.org
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Re: can we make anonymous memory non-EXECUTABLE?
In-Reply-To: <15420.59542.885935.297683@argo.ozlabs.ibm.com>
In-Reply-To: <200201080025.QAA26731@napali.hpl.hp.com>
	<15420.59542.885935.297683@argo.ozlabs.ibm.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 10 Jan 2002 12:04:22 +1100 (EST), Paul Mackerras <paulus@samba.org> said:

  Paul> David Mosberger writes:
  >> The traditional intended behavior of Linux is that anonymous
  >> memory has the EXECUTE permission turned on.  The reason I say
  >> "intended" behavior is that there appears to be an old bug in the
  >> kernel in this respect.  Specifically, the ELF data section is
  >> normally mapped with READ+WRITE permission (no EXECUTE
  >> permission).  The initial break

  Paul> The permissions come from the ELF program header, so if your
  Paul> data section is mapped without execute permission, then I
  Paul> would see that as a binutils issue rather than a kernel issue.

Yes, that's one (among many other possible) solution.

  >> What I'm wondering: how do others feel about this issue?  Since
  >> x86 wont be affected by this, I'm especially interested in the
  >> opinion of the maintainers of non-x86 platforms.

  Paul> I think that if you have per-page execute permission, you
  Paul> should mark dirty pages as non-executable and flush if the
  Paul> user process tries to execute from them - which sounds like
  Paul> what you are doing already.  With that there is no performance
  Paul> advantage to having anonymous memory being non-executable.

That's what we do on ia64 also.  There is a performance penalty though
for programs that *do* generate code dynamically (in the form of
additional page faults).  I don't think it's a huge issue, but like I
said earlier: if there is a simple solution that gets rid of the
problem entirely, I'd prefer that.

  Paul> BTW, where do you put your sigreturn trampoline?  On PPC we
  Paul> put it on the stack, as on ia32.  If you do too, and you make
  Paul> the stack non-executable then clearly you will need to find
  Paul> somewhere else for it.

On ia64, we simply map the trampoline in the kernel's gate page.  This
is a special page that can be executed by user level, but not read or
written (in the future, we may use this page for system calls, too).
No dynamic code generation needed for this (indeed, we even share the
TLB entry across all processes ;-).

Wouldn't it be better to use the sa_restorer approach on PPC like x86
and Alpha (and probably others) do?  That would avoid dynamic code
generation.

  Paul> As to whether it is better from a security point of view to
  Paul> make anonymous memory non-executable, it probably is.  I guess
  Paul> you have the opportunity on ia64 to do that since there aren't
  Paul> a lot of ia64 machines around yet.  If you want to do that,
  Paul> now is the time to do it and find whatever bugs there are in
  Paul> glibc relating to that.

Yes, my thinking exactly.

  Paul> Whatever you decide won't have much impact on PPC since very
  Paul> few PowerPC chips support per-page execute permission.

Right.  I hope it's fair to say that the principle could/should be:

	- applications must use mprotect() to ensure malloc'd memory
	  is executable

	- Linux platforms *may* choose to enforce this by making
	  sbrk() memory not EXECUTABLE by default

This way, we can turn of execute permission on ia64 and the other
platforms have the choice whether to follow suite or to leave things
as they are.

Thanks,

	--david
