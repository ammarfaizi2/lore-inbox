Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262134AbSJVENw>; Tue, 22 Oct 2002 00:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262137AbSJVENw>; Tue, 22 Oct 2002 00:13:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6702 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262134AbSJVENu>; Tue, 22 Oct 2002 00:13:50 -0400
To: Andy Pfiffer <andyp@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: [Fastboot] [CFT] kexec syscall for 2.5.43 (linux booting linux)
References: <m1k7kfzffk.fsf@frodo.biederman.org>
	<1035241872.24994.21.camel@andyp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Oct 2002 22:18:00 -0600
In-Reply-To: <1035241872.24994.21.camel@andyp>
Message-ID: <m13cqzumx3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> On Fri, 2002-10-18 at 13:02, Eric W. Biederman wrote:
> 
> > In bug reports please include the serial console output of 
> > kexec kexec_test.  kexec_test exercises most of the interesting code
> > paths that are needed to load a kernel with lots of debugging print
> > statements, so hangs can easily be detected.
> 
> Hi again, Eric.
> 
> Thanks for sending out pointers to a fresh batch of code.
> 
> I applied your patch cleanly to 2.5.44, and tried it on one of the two
> "troublesome" systems that I have used in the past.  I had to make one
> unrelated change to the SCSI subsystem to fix a problem with a hang
> during an ordinary reboot.
> 
> Symptoms:
> kexec bzImage makes it all the way down to the indirect call at the very
> bottom of machine_kexec() before the system appears to hang.

Somehow I suspect it is getting farther and you just are not getting any feedback.

> Debugging output from "kexec kexec_test":
> # ./kexec ./kexec_test
> kexecing image
> kexec_test 1.1 starting...
> eax: 0E1FB007 ebx: 00001078 ecx: 00000000 edx: 00000000
> esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
> idt: 00000000 C0000000
> gdt: 00000000 C0000000
> Switching descriptors.
> Descriptors changed.
> In real mode.
> Interrupts enabled.
> Base memory size: 0277
> --> [ edited: long pause here ] <--
> Can not A20 line.
> E820 Memory Map.
> 000000000009DC00 @ 0000000000000000 type: 00000001
> 0000000000002400 @ 000000000009DC00 type: 00000002
> 0000000000020000 @ 00000000000E0000 type: 00000002
> 0000000027EED140 @ 0000000000100000 type: 00000001
> 0000000000010000 @ 0000000027FF0000 type: 00000002
> 0000000000002EC0 @ 0000000027FED140 type: 00000003
> 0000000001400000 @ 00000000FEC00000 type: 00000002
> E801  Memory size: 0009F800
> Mem88 Memory size: FFFF
> Testing for APM.
> APM test done.
> A20 enabled
> Interrupts disabled.
> In protected mode.
> Halting.

First it is not a problem that it took a long time trying to disable
the a20 line.  That just means it tried, and you have a system with
the a20 line permanently enabled.  Which by some measures is a bug,
and by others a feature.  But it does seem to be a feature of the
systems that are giving the most trouble at the moment.

The fact that kexec_test worked shows that the kexec code basically
worked, and that under the right circumstances most BIOS calls work.

Why it is hanging is currently a mystery to me.  Your system
also does not have APM support which is an interesting data point
and rules out a number of problems.

> What other information can I provide?

I think I need to see if kexec loads setup.S at a bad location.
Well it loads setup.S at 0x90000 which is the traditional location,
but it should not be a problem...

> Regards,
> Andy
> 
> ps: if it helps, the OSDL CGL tree has bootimg and linux-2.4.18, and
> that combination works (unless X is still running) on this system.

Have you tried booting that 2.4.18 kernel with kexec.  

Oh, wait as I recall bootimg simply copies the BIOS results
from the current kernel to the freshly booted kernel, so it skips
the BIOS calls altogether.  Which is both very handy, and trouble
some.


It may also be a device shutdown problem, as well.  memtest86
is the only candidate I can think of for testing that.  But 

My other question is does running mkelfImage-1.17 on your kernel
before you boot it help? 
ftp://ftp.lnxi.com/pub/src/mkelfImage/mkelfImage-1.17.tar.gz

It does the BIOS calls in a different order and that seems to help,
though I am still trying to track down why.

Eric
