Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263874AbRFHGUJ>; Fri, 8 Jun 2001 02:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263877AbRFHGUA>; Fri, 8 Jun 2001 02:20:00 -0400
Received: from fe3.rdc-kc.rr.com ([24.94.163.50]:7955 "EHLO mail3.kc.rr.com")
	by vger.kernel.org with ESMTP id <S263874AbRFHGTq>;
	Fri, 8 Jun 2001 02:19:46 -0400
To: Pavel Kankovsky <peak@argo.troja.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PTRACE_ATTACH breaks wait4()
In-Reply-To: <20010607223921.D94.0@argo.troja.mff.cuni.cz>
From: Mike Coleman <mkc@mathdogs.com>
Date: 08 Jun 2001 01:19:31 -0500
In-Reply-To: <20010607223921.D94.0@argo.troja.mff.cuni.cz>
Message-ID: <87u21ro5n0.fsf@mathdogs.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Kankovsky <peak@argo.troja.mff.cuni.cz> writes:
> Let A be a process and B its child. When another process, let's call
> it C, does ptrace(PTRACE_ATTACH) on B, wait4(pid of B, ...) will always
> return ECHILD when invoked from A after B has been attached to C because
> wait4() does not take children traced by other processes into account.
> The problem was observed on 2.2.19. I suppose it exists in 2.4 as well.

I bet it does, too.  Personally I think ptrace needs to be replaced (see my
semi-rant from December below).

Does anyone see any reason why something along the lines of a Solaris-like
proc interface wouldn't be better?  If I write up a minimal spec, would people
read it and poke holes in it?  (Or maybe someone else is itching to do this?)

--Mike


>From December:

   My limited mental abilities notwithstanding, I think this is one more
   reason to ditch ptrace for a better method of process tracing/control.
   It's served up to this point, but ptrace has a fundamental flaw, which is
   that it tries to do a lot of interprocess signalling and interlocking in an
   in-band way, doing process reparenting to try to take advantage of existing
   code.  In the end this seems to be resulting in an inscrutable, flaky mess.

   What would a better process tracing facility be like?  One key feature is
   utter transparency.  That is, it should be impossible for traced processes
   or other processes that interact with them to be aware of whether or not
   tracing is going on.  This means that there should be no difference between
   the way a process behaves under tracing versus how it would behave if it
   weren't being traced, which is a key to faithful tracing/debugging and
   avoiding the Heisenbug effect.  (There does need to be some interface via
   which information about tracing itself can be observed, but it should be
   hidden from the target processes.)

   It would also be nice to have something accessible via devices in the proc
   filesystem.  Maybe something like Solaris' "proc" debugging interface would
   be a starting point:

      http://docs.sun.com:80/ab2/coll.40.6/REFMAN4/@Ab2PageView/42351?Ab2Lang=C&Ab2Enc=iso-8859-1

-- 
Mike Coleman, mkc@mathdogs.com
  http://www.mathdogs.com -- problem solving, expert software development
