Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267225AbSLKRJA>; Wed, 11 Dec 2002 12:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267230AbSLKRJA>; Wed, 11 Dec 2002 12:09:00 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:1921 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267225AbSLKRIo>;
	Wed, 11 Dec 2002 12:08:44 -0500
Date: Wed, 11 Dec 2002 17:25:59 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5 Changes doc update.
Message-ID: <20021211172559.GA8613@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By popular (Well, 2 people) request (and various recent
repeated questions already answered here), here's another update
to the document I wrote detailing the various changes worth
knowing about if you are an end-user/tester of 2.5

		Dave



                     The post-halloween document. v0.19
                        (aka, 2.5 - what to expect)

                    Dave Jones <davej@codemonkey.org.uk>

                          (Updated as of 2.5.48)

This document explains some of the new functionality to be found in the 2.5
Linux kernel, some pitfalls you may encounter, and also points out some new
features which could really use testing.
Note, that "contact foo@bar.com" below also implies that you should also
cc: linux-kernel@vger.kernel.org.

Latest version of this document can always be found at
http://www.codemonkey.org.uk/post-halloween-2.5.txt

Thanks to Andrew Morton, Alan Cox, Alan Willis, Ingo Molnar, Robert Love
and many others for valuable feedback.

Note, that this document is somewhat x86-centric, but most features
documented here affect all platforms anyway.


Regressions.
~~~~~~~~~~~~
(Things not expected to work just yet)
- The hptraid/promise RAID drivers are currently non functional, and
  will probably be converted to use device-mapper.
- Some filesystems still need work (Intermezzo, UFS, HFS, HPFS..)
- A number of drivers don't compile currently due to them needing various
  work to convert them to the new APIs


Deprecated features.
~~~~~~~~~~~~~~~~~~~~
- khttpd is gone.
- Older Direct Rendering Manager (DRM) support (For XFree86 4.0)
  has been removed. Upgrade to XFree86 4.1.0 or higher.
- LVM1 has been removed. See Device-mapper below.
- boot time root= parsing changed.
  ramdisks now have ram<n> isntead of rd<n> and cm206 - cm206cd (instead of cm206).


Modules.
~~~~~~~~
- The in-kernel module loader got reimplemented.
- You need replacement module utilities from
  http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
- A backwards compatable set of module utilities is available
  including v0.7 of the new-style utils in source RPM format from
  http://www.kernel.org/pub/linux/kernel/people/rusty/modules/modutils-2.4.21-5.src.rpm


Kernel build system.
~~~~~~~~~~~~~~~~~~~~
- Versus 2.4, the build system has been much improved.
  You should notice quicker builds, and less spontaneous rebuilds
  of files on subsequent builds from already built trees.
- make xconfig now requires the qt libraries.
- Make menuconfig/oldconfig has no user-visible changes other than speed,
  whilst numerous improvements have been made.
- Several new debug targets exist: 'allyesconfig' 'allnoconfig' 'allmodconfig'.
- For infomation: The above improvements are not CML2 / kbuild-2.5 related.


IO subsystem.
~~~~~~~~~~~~~
- You should notice considerable throughput improvements over 2.4 due
  to much reworking of the block and the memory management layers.
- Report any regressions in this area to Jens Axboe <axboe@suse.de>
  and Andrew Morton <akpm@digeo.com>.
- Assorted changes throughout the block layer meant various block
  device drivers had a large scale cleanup whilst being updated to
  newer APIs.
- The size and alignment of O_DIRECT file IO requests now matches that
  of the device, not the filesystem.  Typically this means that you
  can perform O_DIRECT IO with 512-byte granularity rather than 4k.

  But if you rely upon this, your application will not work on 2.4 kernels
  and will not work on some devices.


Enormous block size support.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- Thanks to work done by Peter Chubb, block devices can now access up to
  16TB on 32-bit architectures, and up to 8EB on 64bit architectures.
- To use the new BLKGETSZ64 ioctls, you'll need updated file-utils.
  (Currently only jfsutils 1.0.20 has this change, patches for other
   filesystems are still pending merging)


POSIX ACLs & Extended attributes.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- Userspace tools available at http://acl.bestbits.at


VM Changes.
~~~~~~~~~~~
- Version zero swap partitions are no longer supported (everything is
  using v1 now anyway - rerun mkswap if in doubt).
  Linux 2.0.x requires v0 swap space, Linux v2.1.117 and later
  support v1.  mkswap(8) can format swap space in either format.
- The bdflush() system call is still there and still just causes
  the calling process to exit.  This strangeness is presumably there
  to support people whose initscripts are trying to start the obsolete
  'update' daemon. It's likely this will become deprecated and usage of
  this will start logging messages to syslog.
- The actual 'reverse mappings' part of Rik van Riel's rmap vm was merged.
  VM behaviour under certain loads should improve.
- VM misbehaviour should be reported to linux-mm@kvack.org
- The VM explicitly checks for sparse swapfiles, and aborts if one is found.
- /proc/sys/vm/swappiness defines the kernel's preference for pagecache over
   mapped memory. Setting it to 100 (percent) makes it treat both types of
   memory equally. Setting it to zero makes the kernel very much prefer to
   reclaim plain pagecache rather than mapped-into-pagetables memory.


Kernel preemption.
~~~~~~~~~~~~~~~~~~
- The much talked about preemption patches made it into 2.5.
  With this included you should notice much lower latencies especially
  in demanding multimedia applications. 
- Note, there are still cases where preemption must be temporarily disabled
  where we do not. These areas occur in places where per-CPU data is used.
- If you get "xxx exited with preempt count=n" messages in syslog,
  don't panic, these are non fatal, but are somewhat unclean.
  (Something is taking a lock, and exiting without unlocking)
- If you DO notice high latency with kernel preemption enabled in
  a specific code path, please report that to Andrew Morton <akpm@digeo.com>
  and Robert Love <rml@tech9.net>.
  The report should be something like "the latency in my xyz application
  hits xxx ms when I do foo but is normally yyy" where foo is an action
  like "unlink a huge directory tree".


Process scheduler improvements.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- Another much talked about feature. Ingo Molnar reworked the process
  scheduler to use an O(1) algorithm.  In operation, you should notice
  no changes with low loads, and increased scalability with large numbers
  of processes, especially on large SMP systems.
- Robert Love wrote various utilities for changing behaviour of the
  scheduler (binding processes to CPUs etc). You can find these tools at
  http://tech9.net/rml/schedutils
- Regressions to mingo@redhat.com and rml@tech9.net


Fast userspace mutexes (Futexes).
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- Rusty Russell added functionality that allows userspace to have
  fast mutexes that only use syscalls when there is contention.


epoll
~~~~~
Davide Libenzi wrote an edge triggered poll replacement that got
included in 2.5.  More info available at
http://www.xmailserver.org/linux-patches/nio-improve.html
http://lwn.net/Articles/13587/


Threading improvements.
~~~~~~~~~~~~~~~~~~~~~~~
- Ingo Molnar put a lot of work into threading improvements during 2.5.
  Some of the features of this work are:
  -  Generic pid allocator (arbitrary number of PIDs with no slowdown,
     unified pidhash).
  -  Thread Local Storage syscalls
  -  sys_clone() enhancements (CLONE_SETTLS, CLONE_SETTID, CLONE_CLEARTID,
     CLONE_DETACHED)
  -  POSIX thread signals stuff (atomic signals, shared signals, etc.)
  -  Per-CPU GDT
  -  Threaded coredumping support
  -  sys_exit() speedups (O(1) exit)
  -  Generic, improved futexes, vcache
  -  New, threading related ptrace features
  -  exit/fork task cache
  -  /proc updates for threading
  -  API changes for threading.
- Users should notice is a significant speedup in basic thread
  operations - this is true even for old-threading userspace libraries such
  as LinuxThreads.
- Regressions should go to Ingo Molnar <mingo@redhat.com> and phil-list@redhat.com.
  Regressions could happen in the area of signal handling and related threading
  semantics, plus coredumping.
- Native Posix Threading Library (NPTL).
  Ulrich Drepper worked closely with Ingo on the threading enhancements, and
  developed a 1:1 model threading library. You can find NPTL at
  ftp://people.redhat.com/drepper/nptl/


Enhanced coredump naming.
~~~~~~~~~~~~~~~~~~~~~~~~~
2.5 offers you the ability to configure the way core files are
named through a /proc/sys/kernel/core_pattern file.
You can use various format identifiers in this name to affect
how the core dump is named.

	%p - insert pid into filename
	%u - insert current uid into filename
	%g - insert current gid into filename
	%s - insert signal that caused the coredump into the filename
	%t - insert UNIX time that the coredump occured into filename
	%h - insert hostname where the coredump happened into filename
	%e - insert coredumping executable name into filename

You should ensure that the string does not exceed 64 bytes.


Input layer.
~~~~~~~~~~~~
- Possibly the most visible change to the end user. If misconfigured,
  you'll find that your keyboard/mouse/other input device will no longer work.
  2.5 offers a much more flexable interface to devices such as keyboards.
- The downside is more confusing options.
  In the "Input device support" menu, be sure to enable at least the following.

                    --- Input I/O drivers
                    < > Serial i/o support
                    < >   i8042 PC Keyboard controller
                    [ ] Keyboards
                    [ ] Mice

  (Also choose the relevant keyboard/mouse from the list)

- If you find your keyboard/mouse still don't work, edit the file
  drivers/input/serio/i8042.c, and replace the #undef DEBUG
  with a #define DEBUG

  When you boot, you should now see a lot more debugging information.
  Forward this information to Vojtech Pavlik <vojtech@suse.cz>

- If you use a KVM switcher, and experience problems, booting with the boot
  time argument 'psmouse_noext' should fix your problems.
- Users of multimedia keys without X will see changes in how the kernel
  handles those keys. People who customize keymaps or keycodes in 2.4
  may need to make some changes in 2.5


PnP layer.
~~~~~~~~~~
- Support for plug and play devices such as early ISAPnP cards has improved a
  lot in the 2.5 kernel. The new code behaves more closely to the code
  handling PCI devices (probe, remove etc callbacks), and also merges
  PnP BIOS access code.
- Report any regressions in plug & play functionality to
  Adam Belay <ambx1@neo.rr.com>


ALSA.
~~~~~
- The advanced linux sound architecture got merged into 2.5.
  This offers considerably improved functionality over the older OSS drivers,
  but requires new userspace tools.
- Several distros have shipped ALSA for some time, so you may already have the
  necessary tools. If not, you can find them at http://www.alsa-project.org/
- Note that the OSS drivers are also still functional, and still present.
  Many features/fixes that went into 2.4 are still not applied to these
  drivers, and it's still unclear if they will remain when 2.6/3.0 ships.
  The long term goal is to get everyone moved over to (the superior) ALSA.


procps.
~~~~~~~
- The 2.5 /proc filesystems changed some statistics, which confuse older
  versions of procps. Rik van Riel and Robert Love have been maintaining a
  version of procps during the 2.5 cycle which tracks changes to /proc which
  you can find at http://tech9.net/rml/procps/
- Alternatively, the procps by Albert Cahalan now supports the altered formats
  since v3.0.5, but lags behind the bleeding edge version maintained by Rik
  and Robert. -- http://procps.sf.net/
- The /proc/meminfo format changed slightly which also broke gtop in strange
  ways.


Framebuffer layer.
~~~~~~~~~~~~~~~~~~
- James Simmons has reworked the framebuffer/console layer considerably during
  2.5. Support for some cards is still lagging a little, but it should be
  functionally no different than previous incarnations.
- Any problems should go to <jsimmons@infradead.org>


IDE.
~~~~
- The IDE code was subject to much criticism in early 2.5.x, which
  put off a lot of people from testing. This work was then subsequently
  dropped, and reverted back to a 2.4.18 IDE status.
  Since then additional work has occured, but not to the extent
  of the first cleanup attempts.
- Known problems with the current IDE code. 
  o  Simplex IDE devices (eg Ali15x3) are missing DMA sometimes
  o  Serverworks OSB4 may panic on bad blocks or other non fatal errors
  o  PCMCIA IDE hangs on eject
  o  Most PCMCIA devices have unload races and may oops on eject
  o  Modular IDE does not yet work, modular IDE PCI modules sometimes
     oops on loading
  o  Silicon Image controllers give really bad performance currently.


IDE TCQ.
~~~~~~~~
- Tagged command queueing for IDE devices has been included.
- Not all combinations of controllers & devices may like this,
  so handle with care.
  READ AS: ** Don't use IDE TCQ on any data you value.
  It's likely bad combinations will be blacklisted as and when discovered.

- If you didn't choose the "TCQ on by default" option, you can enable
  it by using the command

    echo "using_tcq:32" > /proc/ide/hdX/settings

  (replacing 32 with 0 disables TCQ again).

- Report success/failure stories to Jens Axboe <axboe@suse.de> with
  inclusion of hdparm -i /dev/hdX, and lspci output.


SCSI.
~~~~~
- Various SCSI drivers still need work, and don't even compile.
- Various drivers currently lack error handling.
  These drivers will cause warnings during compilation due to
  missing abort: & reset: functions.
- Note, that some drivers have had these members removed, but still
  lack error handling. Those noticed so far are ncr53c8xxx, sym53c8xx and inia100


v4l2.
~~~~~
- The video4linux API finally got its long awaited cleanup.
- xawtv, bttv and most other existing v4l tools are also compatable
  with the new v4l2 layer. You should notice no loss in functionality.
- See http://bytesex.org/v4l/ for more information.


Quota reworking.
~~~~~~~~~~~~~~~~
The new quota system needs new tools.
http://www.sf.net/projects/linuxquota/


CD Recording.
~~~~~~~~~~~~~
- Jens Axboe added the ability to use DMA for writing CDs on
  ATAPI devices. Writing CDs should be much faster than it
  was in 2.4, and also less prone to buffer underruns and the like.
- Updated cdrecord in rpm and tar.gz can be found at
  *.kernel.org/pub/linux/kernel/people/axboe/tools/
- With the above tools, you also no longer need ide-scsi in order to use
  an IDE CD writer.
- Ripping audio tracks off of CDs now also uses DMA and should be
  notably faster. You can also find an updated cdda2wav at the same location.
- Send good/bad reports of audio extraction with cdda2wav and burning with
  the modified cdrecord to Jens Axboe <axboe@suse.de>
- More info at http://lwn.net/Articles/13538/ & http://lwn.net/Articles/13160/


USB:
~~~~
- Very little user visible changes, the only noticable 'major' change
  is that there is now only one UHCI driver.


Nanosecond stat:
~~~~~~~~~~~~~~~~
The stat64() syscall got changed to return jiffies granularity.
This allows make(1) to make better decisions on whether or not it
needs to recompile a file.


Filesystems:
~~~~~~~~~~~~
A number of additional filesystems have made their way into 2.5.
Whilst these have had testing out of tree, the level of testing
after merging is unparalleled. Be wary of trusting data to immature
filesystems.  A number of new features and improvements have also
been made to the existing filesystems from 2.4.

Reports of stress testing with the various tools available would
be beneficial.

EXT2.
~~~~~
- 2.5.49 included an extension to ext2 which will cause it to not attach
  buffer_head structures to file or directory pagecache at all, ever.
  This is for the big highmem machines.  It is enabled via the `-o nobh'
  mount option.

EXT3.
~~~~~
- The ext3 filesystem has gained indexed directory support, which offers
  considerable performance gains when used on filesystems with directories
  containing large numbers of files.
- In order to use the htree feature, you need at least version 1.32 of e2fsprogs.
- Existing filesystems can be converted using the command

    tune2fs -O dir_index /dev/hdXXX

- The latest e2fsprogs can be found at http://prdownloads.sourceforge.net/e2fsprogs

NFS.
~~~~
- Basic support has been added for NFSv4 (server and client)
- Additionally, kNFSD now supports transport over TCP.
  This experimental feature is also backported to 2.4.20
- Interoperability reports with other OS's would be useful.
- Problems to nfs@lists.sourceforge.net

sysfs.
~~~~~~
In simple terms, the sysfs filesystem is a saner way for
drivers to export their innards than /proc.
This filesystem is always compiled in, and can be mounted
just like another virtual filesystem. No userspace tools
beyond cat and echo are needed.

	mount -t sysfs none /sys

See Documentation/filesystems/sysfs.txt for more info.

JFS.
~~~~
IBM's JFS got merged during 2.5. (And backported to 2.4.20, but
it was still a new feature here first. You can read more about JFS at
http://www-124.ibm.com/developerworks/oss/jfs/index.html

XFS.
~~~~
The SGI XFS filesystem has been merged, and has a number of userspace
features. Users are encouraged to read http://oss.sgi.com/projects/xfs
for more information.
The various utilties for creating and manipulating XFS volumes can
be found on SGI's ftp server..
ftp://oss.sgi.com/projects/xfs/download/download/cmd_tars/xfsprogs-2.2.2.src.tar.gz

CIFS.
~~~~~
Support utilities and documentation for the common internet file system (CIFS)
can be found at http://us1.samba.org/samba/Linux_CIFS_client.html

Internal filesystems.
~~~~~~~~~~~~~~~~~~~~~
/proc/filesystems will contain several filesystems that are not
mountable in userspace, but are used internally by the kernel
to keep track of things. These filesystems are futexfs, eventpollfs
and hugetlbfs


Oprofile.
~~~~~~~~~
A system wide performance profiler has been included in 2.5.
With this option compiled in, you'll get an oprofilefs filesystem
which you can mount, that the userspace utilities talk to.
The userspace utilities for this are very young, and still being developed.
You can find out more at http://oprofile.sourceforge.net/oprofile-2.5.html


Simple boot flag support.
~~~~~~~~~~~~~~~~~~~~~~~~~
The SBF specification is an x86 BIOS extension that allows improved
system boot speeds. It does this by marking a CMOS field to say
"I booted okay, skip extensive POST next reboot".
Userspace tool is at http://www.codemonkey.org.uk/cruft/sbf.c
More info on SBF is at http://www.microsoft.com/hwdev/resources/specs/simp_bios.asp


x86 CPU detection.
~~~~~~~~~~~~~~~~~~
- The CPU detection code got a pretty hefty shake up. To be certain your
  CPU has all relevant workarounds applied, be sure to check that it was
  detected correctly. cat /proc/cpuinfo will tell what the kernel thinks it is.
- Likewise, the x86 MTRR driver got a considerable makeover.
  Check that XFree86 sets up MTRRs in the same way it did in 2.4
  (Failures will get logged in /var/log/XFree86.log)
- Early PII Xeon processors and possibly other early PII processors
  require microcode updates either from the BIOS or the microcode driver
  to handle the O(1) scheduler reliably.
  You can find the relevant microcode tools at http://www.urbanmyth.org/microcode/
- Any regressions in both should go to mochel@osdl.org Cc: davej@suse.de


Extra tainting.
~~~~~~~~~~~~~~~
Running certain AMD processors in SMP boxes is out of spec, and will taint
the kernel with the 'S' flag.  Running 2 Athlon XPs for example may seem to
work fine, but may also introduce difficult to pin down bugs.
In time it's likely this tainting will be extended to cover other out of
spec cases.

Additionally, the new modules interface will taint the kernel if you try
to 'force' a module to unload with rmmod -f.


Power management.
~~~~~~~~~~~~~~~~~
- 2.5 contains a more up to date snapshot of the ACPI driver. Should
  you experience any problems booting, try booting with the argument
  "acpi=off" to rule out any ACPI interaction. ACPI has a much more involved
  role in bringing the system up in 2.5 than it did in 2.4
- The old "acpismp=force" boot option is now obsolete, and will be ignored
  due to the old "mini ACPI" parser being removed.
- software suspend is still in development, and in need of more work.
  It is unlikely to work as expected currently.


CPU frequency scaling.
~~~~~~~~~~~~~~~~~~~~~~
Certain processors have the facility to scale their voltage/clockspeed.
2.5 introduces an interface to this feature, see Documentation/cpufreq
for more information. This functionality also covers features like
Intel's speedstep, and will be extended in time to cover the Powernow
feature present in mobile Athlons.  In addition to x86 variants, this
framework also supports various ARM CPUs.
You can find a userspace daemon that monitors battery life and
adjusts accordingly at: http://www.staikos.net/~staikos/cpufreqd/


Background polling of MCE.
~~~~~~~~~~~~~~~~~~~~~~~~~~
The machine check handler has been extended so that it regularly polls
for any problems on AMD Athlon, and Intel Pentium 4 systems.
This may result in machine check exceptions occuring more frequently
than they did in 2.4 on out of spec systems (Overclocking/inadequate
cooling/underated PSU etc..).


LVM2 - DeviceMapper.
~~~~~~~~~~~~~~~~~~~~
The LVM1 code got removed wholesale, and replaced with a much better
designed 'device mapper'.
- This is backwards compatable with the LVM1 disk format.
- Device mapper does require new tools to manage volumes however.
  You can get these from ftp://ftp.sistina.com/pub/LVM2/tools/


Debugging options.
~~~~~~~~~~~~~~~~~~
During the stabilising period, it's likely that the debugging options
in the kernel hacking menu will trigger quite a few problems.
Please report any of these problems to linux-kernel@vger.kernel.org
rather than just disabling the relevant CONFIG_ options.

Merging of kksymoops means that the kernel will now spit out
automatically decoded oopses (no more feeding them to ksymoops).
For this reason, you should always enable the option in the
kernel hacking menu labelled "Load all symbols for debugging/kksymoops".

Testing with CONFIG_PREEMPT will also increase the amount of debug
code that gets enabled in the kernel. Kernel preemption gives us
the ability to do a whole slew of debugging checks like sleeping
with locks held, scheduling while atomic, exiting with locks held, etc.
		

Compiler issues.
~~~~~~~~~~~~~~~~
- The recommended compiler (for x86) is still 2.95.3.
- When compiled with a modern gcc (Ie gcc 3.x), 2.5 will use additional
  optimisations that 2.4 didn't. This may shake out compiler bugs that
  2.4 didn't expose.
- Do not use gcc 3.0.x due to a stack pointer handling bug.


Security concerns.
~~~~~~~~~~~~~~~~~~
Several security issues solved in 2.4 are yet to be forward ported
to 2.5. For this reason 2.5.x kernels should not be tested on
untrusted systems.  Testing known 2.4 exploits and reporting results
is useful.


Networking.
~~~~~~~~~~~
- ebtables
  The bridging firewall code got merged. To manage these you'll need the ebtables
  tool available from http://users.pandora.be/bart.de.schuymer/ebtables/
  More on bridge-nf can be found at http://bridge.sourceforge.net
- Bridged packets can now be 'seen' by iptables.
- IPSec
  Linux finally has IPSec support in mainline.
  Use the KAME tools port on ftp://ftp.inr.ac.ru/ip-routing/ipsec/
  racoon won't compile, you don't need it yet.
  For more info see http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-44/1127.html
  Also Bert Hubert has a howto at http://lartc.org/howto/lartc.ipsec.html


CryptoAPI.
~~~~~~~~~~
- A generic crypto API has been merged, offering support for various
  algorithms (HMAC,MD4,MD5,SHA-1,DES,Triple DES EDE, Blowfish)
- This functionality is currently only used by IPSec, but will later
  be extended to be used by other parts of the kernel. It's possible
  that it will later also be available for use in userspace through
  a crypto device, possibly compatable with the OpenBSD crypto userspace.


Ports.
~~~~~~
- 2.5 features support for several new architectures.
  - x86-64 (AMD Hammer)
    in-tree isn't up to date with ftp.x86-64.org
  - ppc64
  - UML (User mode Linux)
    See http://user-mode-linux.sf.net for more information.
  - uCLinux. 68k(w/o MMU) and v850.
  - Several in-tree ports are lagging behind their out-of-tree variants.


TODO.
~~~~~
- IPv6
  FIXME: userspace?
- AIO
  FIXME: Anything to add ?


Need checking.
~~~~~~~~~~~~~~
- Someone reported evolution locks up when calender/tasks/contacts is selected.
  Further digging has revealed a change to the getpeername syscall changed
  behaviour. See http://lists.ximian.com/archives/public/evolution-hackers/2002-October/005218.html
  for a patch to ORBit.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Everything below this line isn't included yet. It may feature in Linus'
bitkeeper tree ready for the next release, or maybe in -ac, -mm etc
or may not happen. Time will tell..


Deprecated. (FIXME: Included in -mm)
~~~~~~~~~~~
- elvtune is deprecated (as are the ioctl's it used).
  FIXME: not yet in mainline.
  Instead, the io scheduler tunables are exported in sysfs (see below)
  in the /sys/block/<device>/iosched directory.
  Jens wrote a document explaining the tunables of the new scheduler at
  http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-44/att-deadline-iosched.txt


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
