Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292664AbSBURgI>; Thu, 21 Feb 2002 12:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292665AbSBURf7>; Thu, 21 Feb 2002 12:35:59 -0500
Received: from smtp-2.llnl.gov ([128.115.250.82]:40909 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id <S292664AbSBURfr>;
	Thu, 21 Feb 2002 12:35:47 -0500
Date: Thu, 21 Feb 2002 09:35:40 -0800 (PST)
From: "Tom Epperly" <tepperly@llnl.gov>
X-X-Sender: epperly@tux06.llnl.gov
To: linux-kernel@vger.kernel.org
Subject: RH7.2 running 2.4.9-21-SMP (dual Xeon's) yields "Illegal instructions"
 during builds
Message-ID: <Pine.LNX.4.44.0202210810070.19681-100000@tux06.llnl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting intermittent "Illegal instruction" errors during builds
of the software I am developing, and it appears to be kernel
related. I have been investigating this problem for several weeks, and
I have exhausted all the means of investigation known to me (detailed
below). There is evidence to suggest it is not a RAM problem or a
random hardware problem (see below). I can "solve" the problem by
running the non-SMP kernel and ignoring the second processor, but this
is not a particularly satisfying solution.  I am wondering if someone
can suggest some additional things I can do to understand and fix this
problem.  I would appreciate if you could CC me on replies.

EVIDENCE OF THE PROBLEM
=======================

Here is an excerpt from the make log to show the effects of the problem:

make[2]: Entering directory
`/home/epperly/tmp/nightly_qc/cronjobs/tom-linux-gcc2.96/babel/doc/talks'
rm -rf .libs _libs
rm -f *.lo
make[2]: Leaving directory
`/home/epperly/tmp/nightly_qc/cronjobs/tom-linux-gcc2.96/babel/doc/talks'
Making clean in papers
make[1]: *** [clean-recursive] Illegal instruction
make[1]: Leaving directory
`/home/epperly/tmp/nightly_qc/cronjobs/tom-linux-gcc2.96/babel/doc'
make: *** [clean-recursive] Error 1
****** make clean failed ******

Sometimes, the build runs to completion and succeeds.  When it fails, it
fails in a different spot each time. It doesn't always list "Illegal
instruction" as the error.  Here is another error message I've seen:

make[3]: *** [installcheck-local] Error 132

I could show you a lot more examples, but they don't seem to indicate more 
than the examples I've shown here.  The package we build can be downloaded 
here: http://www.llnl.gov/casc/components/docs/babel-0.6.3.tar.gz
The build uses the autotools suite, Sun's JDK 1.3.1_02, gcc, g++, g77, and 
Python.

On one occasion, random processes started dying on the machine. I had to 
reboot to recover.

The failure rate of our nightly build is between 20-40%.  These failures
exclude any that relate to things we can trace back to our coding
mistakes. The nightly builds do a sequence of configure, build and
regression testing.

MACHINE DETAILS
===============

HARDWARE	Dell Precision Workstation 530
PROCESSORS	Dual Intel Xeon Processors 1500MHz
RAM		512MB ECC RAM
O/S		RH 7.2 (upgraded from 7.1) running RH's 2.4.9-21 SMP 

$ /sbin/lsmod
Module                  Size  Used by
nfsd                   71232   8 (autoclean)
autofs                 11556   1 (autoclean)
nfs                    79840   3 (autoclean)
lockd                  53184   1 (autoclean) [nfsd nfs]
sunrpc                 64816   1 (autoclean) [nfsd nfs lockd]
3c59x                  26504   1
usb-uhci               21668   0 (unused)
usbcore                51808   1 [usb-uhci]
aic7xxx               114624   6
sd_mod                 11900   6
scsi_mod               98584   2 [aic7xxx sd_mod]

An identical machine has the same intermittent problems that my box does.

WHAT I HAVE ALREADY TRIED
=========================

1. Upgrade to from an earlier kernel to RH 2.4.9-21 SMP

   The new kernel didn't change anything.

2. Ran Dell's memory checker on the RAM for an hour. It checked out
   fine.

   The fact that another machine next door has the exact same problems 
   suggests that it isn't a random hardware problem unless they both came 
   from the same bad batch.

3. Open my case to vent additional heat.

   Someone suggested that the CPUs might be overheating and that opening
   the case might solve the problem.  It didn't solve the problem. My
   machine is in a well air conditioned room, and it didn't seem 
   excessively hot when I opened the case.  I haven't overclocked the
   machine or anything like that.

4. Disable X11 server and reboot to avoid loading nVIDIA kernel module.

   This may have lowered the frequency of problems, but it did not 
   eliminate the problem. Our nightly build still failed roughly
   20% of the time with "Illegal instruction" errors or other
   unexplainable failures.

5. Run the non-SMP 2.4.9-21 effectively turning off the second processor 
   (X11 still disabled)

   This seems to have "solved" the problem.  I've run over 22 nightly 
   builds, two at a time, on the system without a single failure.
   Running with just one processor is better than running an unstable
   two processor system, but it seems like I should be able to figure
   out how to have a stable two processor system.

I have not tried compiling my own kernel because I don't have root on this
machine yet. I work in an environment where they try to centralize machine
administration, so I need special permission to get root.  There is also a
desire to stick with generic RH software components. Going through the
process above is part of what I've done to justify getting root, so I can
try installing a more recent kernel.

Do you agree that this is likely to be a kernel problem?  Is upgrading
the kernel my best course of action?

Here is what I get when running the non-SMP kernel. 
$ uname -a
Linux tux06.llnl.gov 2.4.9-21 #1 Thu Jan 17 14:16:30 EST 
2002 i686 unknown
$ cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 0
model name	: Intel(R) Xeon(TM) CPU 1500MHz
stepping	: 10
cpu MHz		: 1495.463
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 2981.88

Thanks in advance,

Tom

--
------------------------------------------------------------------------
Tom Epperly
Center for Applied Scientific Computing   Phone: 925-424-3159
Lawrence Livermore National Laboratory      Fax: 925-424-2477
L-661, P.O. Box 808, Livermore, CA 94551  Email: tepperly@llnl.gov
------------------------------------------------------------------------

