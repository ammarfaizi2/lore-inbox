Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbTIPQV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 12:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbTIPQV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 12:21:27 -0400
Received: from ns.suse.de ([195.135.220.2]:18903 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261972AbTIPQVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 12:21:10 -0400
Date: Tue, 16 Sep 2003 18:21:09 +0200
From: Stefan Reinauer <stepan@openbios.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [announce] OpenBIOS Forth Kernel V1.0 released
Message-ID: <20030916162109.GA2559@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux community,

After some months of development I am happy to announce the new
OpenBIOS forth kernel "BeginAgain".

It is available from the OpenBIOS CVS in the directory "kernel/" 
or at http://www.openbios.org/bin/kernel-1.0.tar.bz2

Find more information on OpenBIOS, a free and portable 
IEEE 1275-1994 (Open Firmware) implementation, at 
http://www.openbios.org/

Features
--------
- indirect-threaded forth engine
- openfirmware user interface
- small and portable
- easily enhancable

Platform Notes
--------------

Currently targets for X86 PCs and AMD64 exist. The OpenBIOS forth
kernel was developed using gcc on Linux systems. Minor changes might
be necessary in non-linux/gcc build environments.

Design Goals
------------

The design goals of "BeginAgain" were:

  1) Portability
  2) Maintainability
  3) Small Size

----------------------------------------------------------------------
  
1) Portability

   BeginAgain, with minimal changes, will work on new systems.  There
   is support for X86 and AMD64 at the moment. Implementing support
   for new systems only requires adaptions to the start code and
   system abstraction.  The current code has been developed using gcc
   3.x, but no explicit GCCisms are used.  Since gcc is the most
   widely spread compiler, it should be a good base for easily porting
   OpenBIOS to new platforms.

2) Maintainability
  
   The code is split into several parts:

    _________________________________________
   |                                         |
   |            Forth dictionary             |
   |_________________________________________|
   
           ^                         |    forth code
   ________|_________________________|_________
           |                         |   
           |                         v    native code
    _____________         ___________________
   |             |       |                   |
   |  Scheduler  | ----> |  primitive words  |
   |_____________|       |___________________|
           ^                         ^
           |                         |
	   |                         |
    _____________         ____________________
   |             |       |                    |
-->|  Startup    |       | system abstraction |
   |_____________|       |____________________|


   Platform dependent part
   -----------------------
   
   a) After taking control the "scheduler", in forth context called
      "inner interpreter, reads the forth dictionary, a list of nested
      word definitions that are built using primitive words.
   
   b) These primitive words are written in C, so they take advantage
      of the compiler's ability to optimize code. They represent the
      minimum set of forth words that are needed to define all language
      constructs, including the Open Firmware system.

   c) The startup code is probably the most platform sensitive code.
      It's task is simple - get the scheduler up and running and
      provide a dictionary to execute. OpenBIOS provides multiple boot
      targets per platform. For example, on x86 it is possible to run
      the kernel either from Grub or LinuxBIOS.  An additional target
      (available on all platforms) allows running the code from a Unix
      shell.
   
   d) The system abstraction part ought to be kept as small as
      possible. The primary words provide an interface for
      non-memory-mapped IO, and there's a small builtin console due to
      the fact that OpenBIOS has no device tree and/or drivers at the
      moment.


   Once these platform dependent parts are in place, they can be used
   to create an indirect-threaded dictionary file. This dictionary
   file contains a platform abstracted version of forth code that
   currently depends on the endianness and pointer (cell) size of the
   target platform. 
   To keep the forth dictionary and the native code strictly seperate
   the unix hosted version of the kernel has a small builtin
   interpreter able to bootstrap all of the base system including a
   forth written interpreter, which represents part of the
   openfirmware user interface. 
   In a second stage the advanced forth written interpreter is used to
   extend the bootstrap dictionary with additional features. As an
   example, ANS forth wordlist support is added, which will be used in
   the device tree code.
   Currently the OpenBIOS dictionary contains a nearly complete
   implementation of the Open Firmware user interface. It passes the
   Hayes ANS Forth test suite that is run when OpenBIOS is built,
   writing it's output to the file forth.html.
   
   Since the machine is abstracted as early and completly as possible,
   porting OpenBIOS to a new platform requires only minor efforts.

   
3) Small size

   The less code that needs to be adopted when porting OpenBIOS to a
   new platform, the quicker new ports can happen. Therefore the
   OpenBIOS kernel is really small. Here is a sample:
     
            size in   |   x86   |   amd64
             bytes    | gcc 3.3 | gcc 3.3.1
     -----------------+---------+----------------		     
     multiboot kernel |  6724   |     15464
     -----------------+---------+---------------- 
     LinuxBIOS kernel |  7016   |     15896
     -----------------+---------+----------------
     LinuxBIOS kernel |         |
     inc. dictionary  | 27048   |     52920
     --------------------------------------------
  
     
Installation and usage
----------------------

Run "make" to compile all binaries and dictionaries required to run
the OpenBIOS kernel
  $ make
Per default all binaries will be placed in the directory obj-{platform}.

Then you can execute the kernel from a shell, by giving the command
  $ make run

To boot LinuxBIOS from GRUB, copy openbios.multiboot and
openfirmware.dict to /boot, then add a new entry to your 
menu.lst config file which looks like this:

-------------------- 8< --------------------
  title openbios
    kernel (hd0,2)/boot/openbios.multiboot
    module (hd0,2)/boot/openfirmware.dict
-------------------- 8< --------------------

(hd0,2) is the equivalent to the Linux partition /dev/hda3
 
OpenBIOS can be used as a payload to LinuxBIOS (www.linuxbios.org) or
booted in EtherBoot (www.etherboot.org). The simplest way is to use
the kernel that includes the full dictionary: openbios.full

Bug reports
-----------

Any trouble, bugs etc. should be reported to the openbios mailinglist
<openbios@lists.openbios.org> 

Further Development
-------------------

BeginAgain is pretty much complete now. Expect only bugfixes and
optimizations in the future. Interpretation mode versions of most loop
constructs should be included although they are not really needed to
get more development going. The next steps in writing an Open Firmware
implementation is to complete the Device and Client Interfaces. These
two parts are needed to set up a device tree, initialize hardware, and
boot the operating system.  Once there is a device tree and some basic
device interface functions it will be possible to run fcode drivers
for device initialization in OpenBIOS, using the FCode evaluator that
resides in the OpenBIOS CVS directory forth/evaluator/.

 Regards,
     Stefan 

