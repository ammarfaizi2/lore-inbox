Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbVBVAkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVBVAkR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 19:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVBVAkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 19:40:17 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:36259 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262185AbVBVAju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 19:39:50 -0500
Subject: [RFC] logdev debugging memory device for tough to debug areas
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 21 Feb 2005 19:39:44 -0500
Message-Id: <1109032784.32648.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've created a tracing tool several years ago for my master's thesis
against the 2.2 kernel and onto the 2.4 kernel. I'm currently using this
in the 2.6 kernel to debug some customizations against Ingo's RT kernel.

What this is, is basically a device that allocates a large number of
single pages to be used in conjunction as a ring buffer. The number of
pages defaults to 256 (1 meg for 4k pages) but this can be changed
through config.

This utility was made to debug large number of packets being
transferred, as well as how the scheduler was handling them. So it had
to be able to work very fast and in any kernel context (process or
interrupt). So I came up with this utility and it has been very helpful
over the years in debugging kernels that I've worked on.  Now I feel
like I should share this, so I'm now posting it out to everyone to get
some feedback from other kernel developers. Its good for any type of
debugging, and not just scheduling or packets. 

As I've mentioned, this is something that I wrote and rewrote through
the years and has been through 2.2, 2.4 and now the 2.6 kernel. I've
tried to clean it up as I went, but there might be relics from years
past still in the code, as well as some bugs :-)

I'm putting the code and the patch on my website at:

http://www.kihontech.com/logdev/

The tar ball contains userland tools to read the device, and the patch
is against the 2.6.10 kernel.

I'll post the README here so you don't need to download it to have a
better look. 

If anyone out there thinks this is a helpful patch, let myself and the
rest of the world know, and maybe we can get it into the mainline.
Otherwise it will sit lonely on my server forever :(


Oh, and everything is under GPL version 2 license (of course).



               LOGDEV device and utilities.

	     Copyright: Steven Rostedt, Kihon Technologies Inc. 2005


Introduction:
====================

The logdev device is an add on to the Linux Kernel.  It is useful where
printk is not. For example in the scheduler, debugging the console
itself or network traffic, or simply anything else that can happen
hundreds of times a second. 

The advantage that logdev has is that it is built into the kernel 
and uses memory to store information to be reviewed at a later time.
The memory used is an array of single pages (for most archs 4k). The
array is just an array of pointers to those pages.  These pages are
allocated when the driver is loaded, either as a module or built in,
and then no more allocation is required of the device. This allows
recording to take place in any context (process or interrupt). 
Spinlocks are used to keep this SMP and preemption safe.

The memory is used as a ring buffer that can store anything that a
developer would like.  There's some built in routines that are
useful. Especially for what kinds of things that were mentioned 
earlier.

There are really two parts to the logdev device.  If you plan on
using it as either a module or a device, you must compile in the
LOGDEV_HOOKS.  This creates hooks for the module when it's loaded
such that macros can be used to call the module.  If the LOGDEV is
compiled into the kernel, then the calls are just made directly to
the logdev device and it doesn't go through the hooks.



Application Programming Interface (API):
=========================================

Here's some of the things that can be used with this device whether
it was compiled in or inserted as a module.


  LOGSWITCH(prev,next)

      This is patched into the scheduler just before switch_to, to
      see what and when processes are being scheduled in and out.
      Here's an example of the retrieved output from this:

      sec: 1109013989:238322  CPU:0 (syslogd:1828) -->> (swapper:0)
      sec: 1109013989:318253  CPU:0 (swapper:0) -->> (ntpd:2003)
      sec: 1109013989:318294  CPU:0 (ntpd:2003) -->> (swapper:0)
      sec: 1109013989:515641  CPU:0 (swapper:0) -->> (sshd:2129)
      sec: 1109013989:515752  CPU:0 (sshd:2129) -->> (bash:2134)
      sec: 1109013989:515823  CPU:0 (bash:2134) -->> (sshd:2129)
      sec: 1109013989:515960  CPU:0 (sshd:2129) -->> (swapper:0)


      The seconds are from do_gettimeofday, seconds followed by microseconds.

  LOGPKT(skb,direction)

      This may be added somewhere in the networking code to see what
      packets are going through a location.  The direction is just an integer
      to determine the direction of the packet if it is used in both
      incoming and outgoing packet code. 

      Here's an example of the retrieved output when this was placed
      in net/ipv4/ip_input.c:ip_rcv_finish as LOGPKT(skb,0);

      sec: 1109016309:002573  CPU:0 192.168.23.9:36448 <== 192.168.23.88:22 seq:4168259885 ack:4168180295 (---PA-) len:48 win:2372 end_seq:4168259933
      sec: 1109016309:002976  CPU:0 192.168.23.9:36448 <== 192.168.23.88:22 seq:4168259933 ack:4168180343 (----A-) len:0 win:2372 end_seq:4168259933
      sec: 1109016309:065440  CPU:0 192.168.23.9:36448 <== 192.168.23.88:22 seq:4168259933 ack:4168180343 (---PA-) len:48 win:2372 end_seq:4168259981
      sec: 1109016309:065848  CPU:0 192.168.23.9:36448 <== 192.168.23.88:22 seq:4168259981 ack:4168180391 (----A-) len:0 win:2372 end_seq:4168259981
      
      Here we see the packets time, cpu it arrived on (this was run on
      a UP so it would always be zero), the source ip and port, the 
      direction was received (don't get confused that the arrow points
      to the source, it just means it was received... this may be changed
      in the future), and it also shows the destination, sequence number,
      ack number, flags, length of packet, window size and the end sequence.


  LOGPRINT(x,...)

      This acts just like a printk, except that the output is written
      to the logdev device and not to output. So you can put any type
      of prints that you would usually do with printk in this, in 
      areas of the kernel that would just show too much data over the 
      console, and then retrieve it later.


  LOGTPRINT(x,...)

      This acts just like LOGPRINT but it also prepends the time stamp
      before the print in case you are interested in the timings of 
      some code.  This simplifies doing it yourself.


  LOGDUMP()
  LOGDUMPNET()

     These two macros are best used (but not necessarily) in the 
     oops section of the kernel.  I usually place these in the 
     kernel panic code and/or the kernel page fault code on a kernel
     access of a bad address.

     The first one dumps what it can from the logdev device to the
     console (using printk), and the later uses the netconsole code
     to dump to the network.  But to use the later you must set up
     the logdev device like you would set up the netconsole device.
     You could just use netconsole and LOGDUMP() to achieve the same
     effect, but I thought it was fun to put it in anyway.

     I've also thought about putting this into the sysreq key, to
     cause the dump.


The /proc system
=======================

   The logdev module adds a few items into the proc filesystem


   /proc/logdev

      This just shows the status of the logdev device, with the following:

    Logdev:
      len:    256
      size:   7244
      start:  2
      end:    3
      corrupted:0

      Entries:
        0:        4095 :     4095     size: 0
        1:        4095 :     4095     size: 0
        2:        3218 :     3217     size: 4095
        3:           0 :     3149     size: 3149

	.
	.
	.

     Here it shows that the number of pages is 256 used.
     The amount of bytes stored in the device is indicated by size.
     The ring buffer starts at array location 2 and ends at 3.
     The ring buffer still has integrity wrt. keeping it's records straight.
     And the list of what's in the pages that is stored.
     The first two start and stop at 4095, and are empty.
     Page 2 starts at 3218 and stops at 3217 so it's size is 4095
       (note that we are missing a byte to differentiate between a full
       and empty page).
     And the list goes on.


  /proc/logdev_minor
 
     The logdev device is registered as a miscellaneous device with
     a dynmic minor. Don't worry, the utilities use this to create the
     device for you.

  /proc/logdev_print

     This must be set to 1 (or just non-zero) to allow for the LOGPRINT
     and LOGTPRINT to write to the logdev buffer.  The default state
     is set by CONFIG_LOGDEV_PRINT_ENABLED, which itself is defaulted to
     yes.

  /proc/logdev_switch

     When this is set to 1 (or just non-zero) it triggers the recording
     of the context switches in the scheduler.

  /proc/logdev_level

     This is not directly used by the logdev device, but it allows for
     developers to trigger certain tracings written to the logdev device
     with different numbers assigned to the logdev_level. 

  Note: All the above are set as atomic_t variables.


  

The Utilities:
=====================


  The logdev device would not be very valuable if you could not
  get the data out from it.  So I have also provided a few utilities
  to retrieve the data. 

  mklogdev  - creates a /dev/logdev entry from the /proc/logdev_minor.
     It deletes /dev/logdev if it is already there but contains 
     a wrong minor. I don't have udev (don't care for it), so if
     someone has a better method as well, let me know.

  logread - reads /dev/logdev and dumps out what it knows about. 
     Basically, if you don't make your own records, and use just 
     what was given by the logdev device, it will print out everything.

  logwrite - writes to the logdev device from userland makeing it look
     like a LOGPRINT. You can just write to the device from userland
     with a cat > /dev/logdev, but this corrupts the device, and 
     may have logread miss some data.

  Note: both logread and logwrite will automatically create the /dev/logdev
      device, so you don't need to use mklogdev before using either of the
      above two.

  libdumplog.a - this is a library that contains the functions used
    by the above utilities such that you can write your own readers.

  All of the above is under GPL so you can look at the code if 
  you want to know more. They are quite simple.



The Ring Buffer:
========================

   The Ring Buffer of the logdev device is made up of an array of
   descriptors that represents each page that was allocated to
   the device. This allows for each page to be allocated separately
   and not to waste a large continuous allocation. This lets the 
   kernel memory management get the best allocated memory for the 
   device and keeps the device from being too much of a hog.

   Each descriptor keeps track of the first and last 
   entry on the page. So in fact, each page in of itself is also
   a ring buffer.  When the page is full, then the logdev device
   continues onto the next page.  When the logdev device, itself, becomes
   full, then it starts to overwrite what was written earliest to the
   device.  If the device is not corrupted (that is, only the 
   logdev device records, or LOGDEV_CUSTOM was used), then it 
   removes the entire earliest records until there's enough room to
   place the next record. If the device is flagged as corrupted, then
   it only removes just enough to fit what it is writing.

   Corruption sounds really bad, when here it is not. It just means that
   a search for the next record is required using magic ids of the 
   record to find them. It doesn't really mean that the logdev device
   itself is corrupt. In fact, as soon as the logdev device becomes empty,
   it then clears the corrupt flag, and starts fresh again.
   So you may never ever notice if the logdev device is corrupt or not.



Thanks,

-- Steve

