Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264172AbRFODWN>; Thu, 14 Jun 2001 23:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264196AbRFODVx>; Thu, 14 Jun 2001 23:21:53 -0400
Received: from chaos.analogic.com ([204.178.40.224]:29056 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264172AbRFODVq>; Thu, 14 Jun 2001 23:21:46 -0400
Date: Thu, 14 Jun 2001 23:21:35 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Roger Larsson <roger.larsson@norran.net>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP spin-locks
In-Reply-To: <200106142134.f5ELYGA19032@maild.telia.com>
Message-ID: <Pine.LNX.3.95.1010614223154.20486A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2001, Roger Larsson wrote:

> On Thursday 14 June 2001 23:05, you wrote:
> > On Thu, 14 Jun 2001, Roger Larsson wrote:
> > > Hi,
> > >
> > > Wait a minute...
> > >
> > > Spinlocks on a embedded system? Is it _really_ SMP?
> >
> > The embedded system is not SMP. However, there is definite
> > advantage to using an unmodified kernel that may/may-not
> > have been compiled for SMP. Of course spin-locks are used
> > to prevent interrupts from screwing up buffer pointers, etc.
> >
> 
> Not really - it prevents another processor entering the same code
> segment  (spin_lock_irqsave prevents both another processor and
> local interrupts).
> 
> An interrupt on UP can not wait on a spin lock - it will never be released
> since no other code than the interrupt spinning will be able to execute)

An interrupt on a UP system will never spin, nor will the IP from
another CPU because there isn't another CPU. A spin-lock, compiled
for UP is:

	pushf
	popl	some_register, currently EBX
	cli	; Clear the interrupts on the only CPU you have

	do_some_code_that_must_not_be_interrupted();

	pushl	same_register_as_above
	popf	; Restore interrupts if they were enabled


For SMP is:

	pushf
	popl	some_register
	cli	; Clear interrupts
	modify_a_memory_variable
x:	see_if_it_is_what_you_expect
	if_not_loop_to x

	do_some_code_that_must_not_be_interrupted();

	modify_the_memory_variable_back
	pushl	same_register_as_above
	popf


Since `cli` will only stop interrupts on the CPU that actually
fetches the instruction, another CPU can enter the code unless
it is forced to spin until the lock is released.

If this code is executed on a UP machine, the memory variable
will always become exactly as expected so it will never spin.
Therefore SMP code should be perfectly safe on a UP machine,
in fact must be perfectly safe, or it's broken.

The current spinlock code does work perfectly on a UP machine.
However, the large difference in performance shows that something
is quite less than optimum in the coding.

Spinlocks are machine dependent. A simple increment of a byte
memory variable, spinning if it's not 1 will do fine. Decrementing
this variable will release the lock. A `lock` prefix is not necessary
because  all Intel byte operations are atomic anyway. This assumes
that the lock was initialized to 0. It doesn't have to be. It
could be initialized to 0xaa (anything) and spin if it's not
0xab (or anything + 1).


> 
> SMP compiled kernel, but running on UP hardware - right?
> Then this _should not_ happen!
> 
> see linux/Documentation/spinlocks.txt
>

This, in fact, will happen. Machines booted from the network should
have SMP code so a SMP machine can use all its CPUs. This same
code, booted from the network, should have no measurable performance
penalty in UP machines.

Also, when you develop drivers on a workstation, test them on
a workstation, then upload everything to an embedded system, you
had better be executing the same code, kernel, drivers, et all,
or you are in a world of hurt. Many embedded systems don't have
any 'standard I/O' so you can't prove that it meets its specs
(exception handling, etc) on the target. You have to test that
logic elsewhere.

This workstation has two CPUs. All drivers are modules. It uses
initrd to install the ones for my SCSI disks, network, etc.

Script started on Thu Jun 14 23:13:10 2001
lsmod
Module                  Size  Used by
ramdisk                 4448   0 
loop                    8212   0  (autoclean)
ipx                    19248   0  (unused)
3c59x                  25020   1  (autoclean)
nls_cp437               4408   4  (autoclean)
BusLogic               38320   6 
sd_mod                 10932   6 
scsi_mod               59460   2  [BusLogic sd_mod]
# exit
exit

Script done on Thu Jun 14 23:13:45 2001

The same kernel, uploaded to an embedded system, also uses
initrd to load the machine-specific drivers. In this way, only
the drivers that are actually used, are loaded. The kernel remains
small. There is a slight performance penality for using modules,
but none other.

# telnet platinum
Trying 10.106.100.166...
Connected to platinum.analogic.com.
Escape character is '^]'.

  Enter "help" for commands

PLATINUM> sho modules

pcilynx                13468   1
raw1394                 7984   1
ieee1394               22984   0 [pcilynx raw1394]
rtc_drvr                2372   0
vxibus                 10660   6
gpib_drvr              19200   2
ramdisk                 4428   0
pcnet32se              15640   1

PLATINUM> exit
	Exit 

Connection closed by foreign host.
# exit
exit


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


