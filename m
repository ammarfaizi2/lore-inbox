Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264274AbUENJVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbUENJVu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 05:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbUENJVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 05:21:50 -0400
Received: from nile.gnat.com ([205.232.38.5]:26098 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S264274AbUENJVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 05:21:42 -0400
From: Paul Hilfinger <hilfingr@gnat.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: sigwait in inferior process interacts badly with ptrace
Message-Id: <20040514092141.93B4BF2E1B@nile.gnat.com>
Date: Fri, 14 May 2004 05:21:41 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Apologies in advance for clumsiness in this report.  I have not submitted
 a Linux kernel bug report before].


[1.] One line summary of the problem:    

     sigwait in inferior process interacts badly with ptrace


[2.] Full description of the problem/report:

     As of kernel version 2.4.21, the interaction of sigwait in
     the inferior with ptrace (at least as used by GDB) has changed. 
     (A) We observed that in a non-threaded program, when the
         inferior was waiting at a sigwait, GDB would NOT 
         notice signals sent to the inferior (although the 
         inferior would correctly respond to them).
     (B) We observed that in a pthreaded program, an inferior
         waiting on sigwait would incorrectly continue from that
         sigwait with an EINTR error code (which sigwait is not
         supposed to return) even in response to the 'run' 
         command in GDB.

[3.] Keywords (i.e., modules, networking, kernel):

     Kernel, signals, ptrace, sigwait

[4.] Kernel version (from /proc/version):

    Linux version 2.4.21-9.ELsmp (bhcompile@stripples.devel.redhat.com) (gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-26)) #1 SMP Thu Jan 8 17:08:56 EST 2004


[6.] A small shell script or sample program which triggers the
     problem (if possible)

For problem (A) under 2 above, compile the following with

    gcc -o foo -g ...

Then run under a recent GDB (precise version seems to be irrelevant), and
send the inferior process a SIGUSR1 from another shell.  The inferior
responds, but GDB (which has ptraced the inferior and is waitpid'ing on
it) does not notice the signal.

#include <stdio.h>
#include <signal.h>

int
main (void)
{
  sigset_t blocked;
  sigset_t waitFor;

  sigfillset (&blocked);
  sigprocmask (SIG_BLOCK, &blocked, NULL);

  sigemptyset (&waitFor);
  sigaddset (&waitFor, SIGUSR1);
  sigaddset (&waitFor, SIGINT);

  while (1) {
    int rsig, status;
    rsig = 0;
    status = sigwait (&waitFor, &rsig);
    fprintf (stderr, "Waiting for %d, received %d, status %d\n", SIGUSR1,
	     rsig, status);
    if (rsig == SIGINT)
      exit (0);
  }

}

---------------

For problem (B) under 2 above, compile the following with 

    gcc -o foo -g ... -lpthread

and try to run the program under GDB.  foo's call to sigwait will return
with EINTR (which it does not do otherwise).  Presumably, this is in response
to ptrace calls issued from within GDB.  


#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <pthread.h>

void*
signal_wait (void *sig0)
{
  int sig = (int) sig0;
  sigset_t waitFor;
  sigemptyset (&waitFor);
  sigaddset (&waitFor, sig);
  
  while (1) {
    int rsig, status;
    rsig = 0;
    status = sigwait (&waitFor, &rsig);
    fprintf (stderr, "Waiting for %d, received %d, status %d\n", sig,
	     rsig, status);
  }
  return NULL;
}

int
main (void)
{
  pthread_t thr1, thr2;
  sigset_t blocked;

  sigemptyset (&blocked);
  sigaddset (&blocked, SIGUSR1);
  sigaddset (&blocked, SIGUSR2);

  sigprocmask (SIG_BLOCK, &blocked, NULL);

  pthread_create (&thr1, NULL, signal_wait, (void*) SIGUSR1);
  pthread_create (&thr2, NULL, signal_wait, (void*) SIGUSR2);

  while (1)
    sleep (10);

  return 0;
}

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

    Gnu C                  3.2.3
    Gnu make               3.79.1
    binutils               2.14.90.0.4
    util-linux             2.11y
    mount                  2.11y
    module-init-tools      writing
    e2fsprogs              1.32
    jfsutils               1.1.2
    pcmcia-cs              3.1.31
    quota-tools            3.09.
    PPP                    2.4.1
    isdn4k-utils           3.1pre4
    nfs-utils              1.0.5
    Linux C Library        2.3.2
    Dynamic linker (ldd)   2.3.2
    Procps                 2.0.13
    Net-tools              1.60
    Kbd                    1.08
    Sh-utils               4.5.3
    Modules Loaded         i810_audio ac97_codec soundcore ide-cd cdrom nfsd parport_pc lp parport nfs lockd sunrpc e1000 ipt_REJECT iptable_filter ip_tables sg microcode loop keybdev mousedev hid input ehci-hcd usb-uhci usbcore ext3 jbd lvm-mod ata_piix libata sd_mod scsi_mod


[7.2.] Processor information (from /proc/cpuinfo):
    processor	: 0
    vendor_id	: GenuineIntel
    cpu family	: 15
    model		: 2
    model name	: Intel(R) Pentium(R) 4 CPU 3.20GHz
    stepping	: 9
    cpu MHz		: 3192.064
    cache size	: 512 KB
    physical id	: 0
    siblings	: 2
    runqueue	: 0
    fdiv_bug	: no
    hlt_bug		: no
    f00f_bug	: no
    coma_bug	: no
    fpu		: yes
    fpu_exception	: yes
    cpuid level	: 2
    wp		: yes
    flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
    bogomips	: 6370.09

    processor	: 1
    vendor_id	: GenuineIntel
    cpu family	: 15
    model		: 2
    model name	: Intel(R) Pentium(R) 4 CPU 3.20GHz
    stepping	: 9
    cpu MHz		: 3192.064
    cache size	: 512 KB
    physical id	: 0
    siblings	: 2
    runqueue	: 0
    fdiv_bug	: no
    hlt_bug		: no
    f00f_bug	: no
    coma_bug	: no
    fpu		: yes
    fpu_exception	: yes
    cpuid level	: 2
    wp		: yes
    flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
    bogomips	: 6383.20

[X.] Other notes, patches, fixes, workarounds:

I have received a report, which I have not personally confirmed, that
a 2.6.0-pre kernel has the same behavior.



Paul Hilfinger
Ada Core Technologies, Inc.
