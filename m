Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbRFZOe4>; Tue, 26 Jun 2001 10:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265011AbRFZOeh>; Tue, 26 Jun 2001 10:34:37 -0400
Received: from authsrv.nacamar.de ([194.162.162.197]:13838 "HELO
	dialup.nacamar.de") by vger.kernel.org with SMTP id <S264956AbRFZOeT>;
	Tue, 26 Jun 2001 10:34:19 -0400
From: "Hugo Mildenberger" <Hugo.Mildenberger@topmail.de>
To: <linux-kernel@vger.kernel.org>
Subject: Questionable SIGSEGV signal handling bug concerning siginfo.si_addr on i386-linux 2.4.2
Date: Tue, 26 Jun 2001 16:24:21 +0200
Message-ID: <DIEOJPFHFLBDHJJOIGOHGELNCAAA.Hugo.Mildenberger@topmail.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear friends,

I'm working on a library, which is able to map (at least synchronous) kernel
signals to c++ exceptions in a way, that c++ exception handlers can
determine reason and location of failure in a very detailed manner. Within
that context, I detected a surprising difference in the behaviour of my test
programs, depending on if they have been compiled by gcc-2.9.2 or gcc-3.0.
When I compiled the program with gcc-3.0, siginfo.si_addr contained an
address, which was always by a value of +4 too large when compared to the
original invalid pointer value (e.g.0x1238 versus 0x1234 or 0x4 versus 0x0).
By contrast, the gcc-2.9.2 compiled program behaved correctly.

That symptom, as I thought, may have been caused by a subtile processor bug,
which depends on register usage or instruction ordering. And I tracked it
down to the following difference in offending instructions (both are located
in the same routine of my test program and causing the expected SIGSEGV,
suppose eax would contain a value of 0x1234):

->gcc-2.95.2:  807c38a:       dd 00         fldl   (%eax)
->gcc-3.0:     806e457:       8b 70 04      mov    0x4(%eax),%esi

siginfo.si_addr contained a correct value in the first case, but an offset
of +4 compared to the original eax value in the second case. So it may be
really a kind of processor bug (if not a feature): eax will be copied for a
slow, but parallel running memory access, while eax itself is incremented
fast. When the MPU detects the illegal access, the processor denunciates its
register eax as containing an illegal adress, and the kernel gadgetry then
propagates the contents of eax into siginfo.si_addr...  But this is wrong,
or at least eax is propagated too late.

Thats what I thought until know. But surprise, surprise: As I examined the
contents of eax located within the ucontext structure, that value was
correct! It was the orignal (but invalid) pointer value. Only
siginfo.si_addr was wrong.

Therefore I think that it is reasonable to report this somewhat strange
behaviour as a kernel bug. It is eventually located within
arch/i386/kernel/entry.S, where some sparsely documented fiddling is done
with ORIG_EAX and EAX. It would be nice if some real ix86 experts could
comment about this - and also how exactly the ix86 processors propagate an
invalid address or operand in case of trapping.


Regards,

Hugo Mildenberger (milden@dialup.nacamar.de)


My kernel version is:Linux 2.4.2 i686 unknown. The kernel headers are
matching my kernel version…

Output of cat /proc/cpuinfo:
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz	: 645.212
cache size	: 256 KB
fdiv_bug	: no
hlt_bug	: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36
mmx fxsr sse
bogomips	: 1287.78

