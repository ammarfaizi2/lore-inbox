Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267687AbTA1Um3>; Tue, 28 Jan 2003 15:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267690AbTA1Um3>; Tue, 28 Jan 2003 15:42:29 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:52158 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267687AbTA1Um3>;
	Tue, 28 Jan 2003 15:42:29 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15926.60767.451098.218188@harpo.it.uu.se>
Date: Tue, 28 Jan 2003 21:51:43 +0100
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: two x86_64 fixes for 2.4.21-pre3
In-Reply-To: <20030124193721.GA24876@wotan.suse.de>
References: <15921.37163.139583.74988@harpo.it.uu.se>
	<20030124193721.GA24876@wotan.suse.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > On Fri, Jan 24, 2003 at 08:16:59PM +0100, Mikael Pettersson wrote:
...
 > > sleep[196] general protection rip:4003ebe5 rsp:ffffed20 error:0
 > > 
 > > (The system is vanilla RH8.0 with Athlon binaries, running under
...
 > Works for me on Simics with a SuSE 32bit userland.
 > 
 > You have to figure out what breaks on RedHat yourself.
 > 
 > We had some problems with the TLS register used on very new glibcs
 > (%gs), but they should be fixed now in the codedrop in 2.4.21pre3.

It looks as if %gs handling isn't quite right.

pthread_setcanceltype() SIGSEGVs in THREAD_SETMEM(self, p_canceltype, type).
The instruction that fails is "mov %dl,%gs:0x81", and %gs is zero.

RedHat linked /bin/sleep against libpthread.so, which (at least in the
glibc-2.2.93 used in RedHat 8.0) causes the nanosleep() system call
to be wrapped between a pair of pthread_setcanceltype() calls.
That's why /bin/sleep failed. Compile it yourself w/o -lpthread and it works.

Also: running gdb on a live process didn't work. I got "int3" errors in
the kernel's log, and gdb seemed to hang or loop somewhere. Postmortem
debugs of core files worked ok though.

/Mikael
