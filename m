Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265110AbSKFODD>; Wed, 6 Nov 2002 09:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265279AbSKFODC>; Wed, 6 Nov 2002 09:03:02 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:49341 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265110AbSKFOCy>;
	Wed, 6 Nov 2002 09:02:54 -0500
Date: Wed, 6 Nov 2002 14:08:44 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: yet another update to the post-halloween doc.
Message-ID: <20021106140844.GA5463@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few more updates, corrections & changes.


                     The post-halloween document. v0.10
                        (aka, 2.5 - what to expect)

                    Dave Jones <davej@codemonkey.org.uk>

This document explains some of the new functionality to be found in the 2.5
Linux kernel, some pitfalls you may encounter, and also points out some new
features which could really use testing.
Note, that "contact foo@bar.com" below also implies that you should also
cc: linux-kernel@vger.kernel.org.

Latest version of this document can always be found at
http://www.codemonkey.org.uk/post-halloween-2.5.txt

Thanks to Andrew Morton, Alan Cox, Alan Willis and others for valuable feedback.


Regressions:
~~~~~~~~~~~~
(Things not expected to work just yet)
- The hptraid/promise RAID drivers are currently non functional, and
  will probably be converted to use device-mapper.
- Some filesystems still need work (Intermezzo, UFS, HFS, HPFS..)
- A number of network card drivers don't compile currently due to
  them needing work to convert them to the new DMA API, and fix to
  work around removals of sti()/cli() functions.


Deprecated features:
~~~~~~~~~~~~~~~~~~~~
- khttpd is gone.
- Older Direct Rendering Manager (DRM) support (For XFree86 4.0)
  has been removed. Upgrade to XFree86 4.1.0 or higher.
- LVM1 has been removed. See Device-mapper below.
- boot time root= parsing changed.
  ramdisks now have ram<n> isntead of rd<n> and cm206 - cm206cd (instead of cm206).


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


VM Changes
~~~~~~~~~~
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


Kernel preemption.
~~~~~~~~~~~~~~~~~~
- The much talked about preemption patches made it into 2.5.
  With this included you should notice much lower latencies especially
  in demanding multimedia applications. 
- Note, there are still cases where preemption must be temporarily disabled
  where we do not.  If you get "xxx exited with preempt count=n" messages
  in syslog, don't panic, these are non fatal, but are somewhat unclean.
- Report such cases (and any other preemption related problems) to
  rml@tech9.net


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


Input layer
~~~~~~~~~~~
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


PnP layer
~~~~~~~~~
- Support for plug and play devices such as early ISAPnP cards has
  improved a lot in the 2.5 kernel. You should no longer need to
  futz with userspace tools to configure IRQ's and the likes.
- This code is very young, and needs more work, but is more
  actively maintained than the previous ISAPnP work.
- Report any regressions in plug & play functionality to
  Adam Belay <ambx1@neo.rr.com>


ALSA
~~~~
- The advanced linux sound architecture got merged into 2.5.
  This offers considerably improved functionality over the
  older OSS drivers, but requires new userspace tools.
- Several distros have shipped ALSA for some time, so you
  may already have the necessary tools. If not, you can find them
  at http://www.alsa-project.org/
- Note that the OSS drivers are also still functional, and
  still present. Many features/fixes that went into 2.4 are still not
  applied to these drivers, and it's still unclear if they will
  remain when 2.6/3.0 ships. The long term goal is to get everyone
  moved over to (the superior) ALSA.


procps
~~~~~~
- The 2.5 /proc filesystems changed some statistics, which confuse
  older versions of procps. Rik van Riel and Robert Love have
  been maintaining a version of procps during the 2.5 cycle which
  tracks changes to /proc which you can find at http://tech9.net/rml/procps/
- Alternatively, the original procps by Albert Cahalan now supports
  the altered formats since v3.0.5, but lags behind the bleeding edge
  version maintained by Rik and Robert. -- http://procps.sf.net/
- The /proc/meminfo format changed slightly which also broke
  gtop in strange ways.


Framebuffer layer
~~~~~~~~~~~~~~~~~
James Simmons has reworked the framebuffer/console layer
considerably during 2.5. Support for some cards is still
lagging a little, but it should be functionally no different
than previous incarnations.


IDE
~~~
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


IDE TCQ
~~~~~~~
- Tagged command queueing for IDE devices has been included.
- Not all combinations of controllers & devices may like this,
  so handle with care.
  READ AS: ** Don't use IDE TCQ on any data you value.

- If you didn't choose the "TCQ on by default" option, you can enable
  it by using the command

    echo "using_tcq:32" > /proc/ide/hdX/settings

  (replacing 32 with 0 disables TCQ again).

- Report success/failure stories to Jens Axboe <axboe@suse.de> with
  inclusion of hdparm -i /dev/hdX, and lspci output.


SCSI
~~~~
- Various SCSI drivers still need work, and don't even compile.
- Various drivers currently lack error handling.
  These drivers will cause warnings during compilation due to
  missing abort: & reset: functions.
- Note, that some drivers have had these members removed, but still
  lack error handling. Those noticed so far are ncr53c8xxx, sym53c8xx and inia100


v4l2
~~~~
- The video4linux API finally got its long awaited cleanup.
- xawtv, bttv and most other existing v4l tools are also compatable
  with the new v4l2 layer. You should notice no loss in functionality.
- See http://bytesex.org/v4l/ for more information.


Quota reworking
~~~~~~~~~~~~~~~
The new quota system needs new tools.
ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/utils/alpha/quota-3.05-pre1.tar.gz


CD Recording
~~~~~~~~~~~~
- Jens Axboe added the ability to use DMA for writing CDs on
  ATAPI devices. Writing CDs should be much faster than it
  was in 2.4, and also less prone to buffer underruns and the like.
- Updated cdrecord in rpm and tar.gz can be found at
  *.kernel.org/pub/linux/kernel/people/axboe/tools/
- With the above tools, you also no longer need ide-scsi
  in order to use an IDE CD writer.
- Ripping audio tracks off of CDs now also uses DMA and should
  be notably faster. You can also find an updated cdda2wav
  at the same location.
- Send good/bad reports of audio extraction with cdda2wav
  and burning with cdrecord to Jens Axboe <axboe@suse.de>
- More info at http://lwn.net/Articles/13538/ & http://lwn.net/Articles/13160/


Filesystems:
~~~~~~~~~~~~
A number of additional filesystems have made their way into 2.5.
Whilst these have had testing out of tree, the level of testing
after merging is unparalleled. Be wary of trusting data to immature
filesystems.  A number of new features and improvements have also
been made to the existing filesystems from 2.4.

Reports of stress testing with the various tools available would
be beneficial.

NFS
~~~
- Basic support has been added for NFSv4 (server and client)
- Additionally, kNFSD now supports transport over TCP.
- Reports of interoperability with other OS's would be useful.
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

XFS
~~~
The SGI XFS filesystem has been merged, and has a number of userspace
features. Users are encouraged to read http://oss.sgi.com/projects/xfs
for more information.
The various utilties for creating and manipulating XFS volumes can
be found on SGI's ftp server..
ftp://oss.sgi.com/projects/xfs/download/download/cmd_tars/xfsprogs-2.2.2.src.tar.gz

CIFS
~~~~
Support utilities and documentation for the common internet file system (CIFS)
can be found at http://us1.samba.org/samba/Linux_CIFS_client.html


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


Background polling of MCE
~~~~~~~~~~~~~~~~~~~~~~~~~
The machine check handler has been extended so that it regularly polls
for any problems on AMD Athlon systems.  This may result in machine check
exceptions occuring more frequently than they did in 2.4 on out of spec
systems (Overclocking/poor cooling/underated PSU etc..).


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


Ports.
~~~~~~
- 2.5 features support for several new architectures.
  - x86-64 (AMD Hammer)
    in-tree isn't up to date with ftp.x86-64.org
  - ppc64
  - UML (User mode Linux)
    See http://user-mode-linux.sf.net for more information.
  - uCLinux. 68k(w/o MMU) and v850 platforms.
  - Several in-tree ports are lagging behind their out-of-tree variants.


TODO.
~~~~~
- Crypto
  FIXME: userspace?
- IPSec
  FIXME: userspace?
- IPv6
  FIXME: userspace?
- Reiser4 ?
  http://www.namesys.com/snapshots/2002.10.29/reiser4progs-0.1.0.tar.gz
- POSIX ACLs
  FIXME: userspace?
- Provide more info other new filesystems..
  - futexfs
  - eventpollfs
  - hugetlbfs

Need checking.
~~~~~~~~~~~~~~
- Someone reported evolution locks up when calender/tasks/contacts is selected.
  http://lists.ximian.com/archives/public/evolution-hackers/2002-March/004292.html
  reports this as an evolution/ORBit problem.  Did it get fixed ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
