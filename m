Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261442AbTCJUui>; Mon, 10 Mar 2003 15:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbTCJUuh>; Mon, 10 Mar 2003 15:50:37 -0500
Received: from ns.suse.de ([213.95.15.193]:28167 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261442AbTCJUuh>;
	Mon, 10 Mar 2003 15:50:37 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [BK-2.5] Move "used FPU status" into new non-atomic thread_info->status  field.
References: <20030310.105659.57012503.davem@redhat.com.suse.lists.linux.kernel> <Pine.LNX.4.44.0303101119220.2240-100000@home.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 10 Mar 2003 22:01:17 +0100
In-Reply-To: Linus Torvalds's message of "10 Mar 2003 20:32:59 +0100"
Message-ID: <p737kb7542q.fsf@amdsimf.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> (Now, in _practice_ all processes on the machine tends to use the same
> rounding and exception control, so the "random" state wasn't actually very
> random, and would not lead to problems. It's a security issue, though).

Oh it does. Together with Marcus Meissner I just tracked down a 32bit
emulation problem on x86-64 with Wine today. The program running in
Wine would randomly crash on a flds with an floating point exception.  

Turned out the 32bit ptrace unlazy FPU path shared two lines too many
with with the 32bit signal FPU saving path and was resetting the
used_fpu flag. Result was that the FPU state of the child could be
reinitialized in some circumstances on ptrace accesses.  Wine actually
does use ptrace between the Wine server and the emulated process for
some complicated calls. It did one unlucky ptrace and then the FPCR was
at the linux defaults again - program crashed.

-Andi
