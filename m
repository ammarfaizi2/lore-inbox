Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbSJ3RFw>; Wed, 30 Oct 2002 12:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbSJ3RFw>; Wed, 30 Oct 2002 12:05:52 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:39891 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264748AbSJ3RFr>;
	Wed, 30 Oct 2002 12:05:47 -0500
Date: Wed, 30 Oct 2002 17:11:49 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: post-halloween 0.2
Message-ID: <20021030171149.GA15007@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I updated the list of various things that wannabe testers might hit.
If theres something I missed let me know, and I'll get it right
next time round..

		Dave




                     The post-halloween document. v0.2
                        (aka, 2.5 - what to expect)

                    Dave Jones <davej@codemonkey.org.uk>

This document explains some of the new functionality to be found in the 2.5
Linux kernel, some pitfalls you may encounter, and also points out some new
features which could really use testing.
Note, that "contact foo@bar.com" below also implies that you should also
cc: linux-kernel@vger.kernel.org.

Latest version of this document can always be found at
http://www.codemonkey.org.uk/post-halloween-2.5.txt


Regressions:
~~~~~~~~~~~~
(Things not expected to work just yet)
- The hptraid/promise RAID drivers are currently non functional.
- Various SCSI drivers still need work, and don't even compile.
- software suspend is still in development, and in need of more work.
  It is unlikely to work as expected currently.
- Some filesystems still need work (Coda, Intermezzo).

Deprecated features:
~~~~~~~~~~~~~~~~~~~~
- khttpd is gone.
- Older Direct Rendering Manager (DRM) support (For XFree86 4.0)
  has been removed. Upgrade to XFree86 4.1.0 or higher.


IO subsystem.
~~~~~~~~~~~~~
You should notice considerable throughput improvements over 2.4 due
to much reworking of the block and the memory management layers.
Report any regressions in this area to Jens Axboe <axboe@suse.de>
and Andrew Morton <akpm@digeo.com>.

Assorted changes throughout the block layer meant various block
device drivers had a large scale cleanup whilst being updated to
newer APIs.


Kernel preemption.
~~~~~~~~~~~~~~~~~~
The much talked about preemption patches made it into 2.5.
With this included you should notice much lower latencies especially
in demanding multimedia applications. 
Note, there are still cases where preemption must be temporarily disabled
where we do not.  If you get "xxx exited with preempt count=n" messages
in syslog, don't panic, these are non fatal, but are somewhat unclean.
Report such cases (and any other preemption related problems) to
rml@tech9.net


O(1) Scheduling improvements.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Another much talked about feature. Ingo Molnar reworked the process
scheduler to use an O(1) algorithm.  In operation, you should notice
no changes with low loads, and increased scalability with large numbers
of processes, especially on large SMP systems. Regressions to mingo@redhat.com


Input layer
~~~~~~~~~~~
Possibly the most visible change to the end user. If misconfigured,
you'll find that your keyboard/mouse/other input device will no longer work.
2.5 offers a much more flexable interface to devices such as keyboards.
The downside is more confusing options.
In the "Input device support" menu, be sure to enable at least the following.

                    --- Input I/O drivers
                    < > Serial i/o support
                    < >   i8042 PC Keyboard controller
                    [ ] Keyboards
                    [ ] Mice

(Also choose the relevant keyboard/mouse from the list)

If you find your keyboard/mouse still don't work, edit the file
drivers/input/serio/i8042.c, and replace the #undef DEBUG
with a #define DEBUG

When you boot, you should now see a lot more debugging information.
Forward this information to Vojtech Pavlik <vojtech@suse.cz>

If you use a KVM switcher, and experience problems, booting
with the boot time argument 'psmouse_noext' should fix your
problems.


PnP layer
~~~~~~~~~
Support for plug and play devices such as early ISAPNP cards has
improved a lot in the 2.5 kernel. You should no longer need to
futz with userspace tools to configure IRQ's and the likes.
Report any regressions in plug & play functionality to
Adam Belay <ambx1@neo.rr.com>


ALSA
~~~~
The advanced linux sound architecture got merged into 2.5.
This offers considerably improved functionality over the
older OSS drivers, but requires new userspace tools.
Several distros have shipped ALSA for some time, so you
may already have the necessary tools. If not, you can find them
at http://www.alsa-project.org/
(Note that the OSS drivers are also still functional, and
 still present)


procps
~~~~~~
The 2.5 /proc filesystems exports more statistics, which confuse
older versions of procps. Rik van Riel and Robert Love have
been maintaining a forked version of procps during the 2.5 cycle,
which you can find at http://tech9.net/rml/procps/



Framebuffer layer
~~~~~~~~~~~~~~~~~
James Simmons has reworked the framebuffer/console layer
considerably during 2.5. Support for some cards is still
lagging a little, but it should be functionally no different
than previous incarnations.


IDE
~~~
The IDE code was subject to much criticism in early 2.5.x, which
put off a lot of people from testing. This work was then subsequently
dropped, and reverted back to a 2.4.18 IDE status.
(Since then additional work has occured, but not to the extent
 of the first cleanup attempts).
Additional work on the ATA code is happening in 2.4-ac, and pending
merging to 2.5


IDE TCQ
~~~~~~~
Tagged command queueing for IDE devices has been included.
Not all devices may like this, so handle with care.
If you didn't choose the "TCQ on by default" option,
you can enable it by using the command

echo "using_tcq:32" > /proc/ide/hdX/settings
(replacing 32 with 0 disables TCQ again).
Report success/failure stories to Jens Axboe <axboe@suse.de> with
inclusion of hdparm -i /dev/hdX


v4l2
~~~~
The video4linux API finally got its long awaited cleanup.
xawtv, bttv and most other existing v4l tools are also compatable
with the new v4l2 layer. You should notice no loss in functionality.
http://bytesex.org/v4l/


Quota reworking
~~~~~~~~~~~~~~~
The new quota system needs new tools.
ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/utils/alpha/quota-3.05-pre1.tar.gz


CD Recording
~~~~~~~~~~~~
Jens Axboe added the ability to use DMA for writing CDs on
ATAPI devices. Writing CDs should be much faster than it
was in 2.4, and also less prone to buffer underruns and the like.
Updated cdrecord in rpm and tar.gz can be found at
*.kernel.org/pub/linux/kernel/people/axboe/tools/

With the above tools, you also no longer need ide-scsi
in order to use an IDE CD writer.

Ripping audio tracks off of CDs now also uses DMA and should
be notably faster. You can also find an updated cdda2wav
at the same location.

Send good/bad reports of audio extraction with cdda2wav
and burning with cdrecord to Jens Axboe <axboe@suse.de>

More info at http://lwn.net/Articles/13538/ & http://lwn.net/Articles/13160/


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
Support has been added for NFSv4 (server and client), and additionally,
NFS over TCP. Reports of interoperability with other OS's would be useful.

driverfs
~~~~~~~~
In simple terms, the driverfs filesystem is a saner way for
drivers to export their innards than /proc.
This filesystem is always compiled in, and can be mounted
just like another virtual filesystem. No userspace tools
beyond cat and echo are needed.

	mount -t driverfs none /sys

*NB*, at some point the name of this filesystem will be changing to sysfs.
See Documentation/filesystems/sysfs.txt for more info.

XFS
~~~
The SGI XFS filesystem has been merged, and has a number of userspace
features. Users are encouraged to read http://oss.sgi.com/project
for more information.
The various utilties for creating and manipulating XFS volumes can
be found on SGI's ftp server..
ftp://oss.sgi.com/projects/xfs/download/download/cmd_tars/xfsprogs-2.2.2.src.tar.gz

CIFS
~~~~
Support utilities and documentation for the common internet file system (CIFS)
can be found at http://us1.samba.org/samba/Linux_CIFS_client.html

EXT3 Htree support.
~~~~~~~~~~~~~~~~~~~
The ext3 filesystem has gained indexed directory support, which offers
considerable performance gains when used on filesystems with large directories.
In order to use the htree feature, you need at least version 1.29 of e2fsprogs.
Existing filesystems can be converted using the command "tune2fs -O dir_index /dev/hdXXX"
The latest e2fsprogs can be found at http://prdownloads.sourceforge.net/e2fsprogs


Oprofile.
~~~~~~~~~
A system wide performance profiler has been included in 2.5.
The userspace utilities for this are very young, and still being developed.
You can find out more at http://oprofile.sourceforge.net/oprofile-2.5.html


Simple boot flag support.
~~~~~~~~~~~~~~~~~~~~~~~~~
The SBF specification is an x86 BIOS extension that allows improved
system boot speeds. It does this by marking a CMOS field to say
"I booted okay, skip extensive POST next reboot".
Userspace tool is at http://www.codemonkey.org.uk/cruft/sbf-0.3.c
More info on SBF is at http://www.microsoft.com/hwdev/resources/specs/simp_bios.asp


x86 CPU detection.
~~~~~~~~~~~~~~~~~~
The CPU detection code got a pretty hefty shake up. To be certain your
CPU has all relevant workarounds applied, be sure to check that it was
detected correctly. cat /proc/cpuinfo will tell what the kernel thinks it is.
Likewise, the x86 MTRR driver got a considerable makeover.
Any regressions in both should go to mochel@osdl.org


Extra tainting.
~~~~~~~~~~~~~~~
Running certain AMD processors in SMP boxes is out of spec, and will taint
the kernel with the 'S' flag.  Running 2 Athlon XPs for example may seem to
work fine, but may also introduce difficult to pin down bugs.
In time it's likely this tainting will be extended to cover other out of
spec cases.


Power management.
~~~~~~~~~~~~~~~~~
2.5 contains a more up to date snapshot of the ACPI driver. Should
you experience any problems booting, try booting with the argument
"acpi=off" to rule out any ACPI interaction. ACPI has a much more involved
role in bringing the system up in 2.5 than it did in 2.4
The old "acpismp=force" boot option is now obsolete, and will be ignored
due to the old "mini ACPI" parser being removed.


CPU frequency scaling.
~~~~~~~~~~~~~~~~~~~~~~
Certain processors have the facility to scale their voltage/clockspeed.
2.5 introduces an interface to this feature, see Documentation/cpufreq
for more information. This functionality also covers features like
Intel's speedstep, and will be extended in time to cover the Powernow
feature present in mobile Athlons.


Background polling of MCE
~~~~~~~~~~~~~~~~~~~~~~~~~
The machine check handler has been extended so that it regularly polls
for any problems on AMD Athlon systems.  This may result in machine check
exceptions occuring more frequently than they did in 2.4 on out of spec
systems (Overclocking/poor cooling/underated PSU etc..).


LVM2 - DeviceMapper.
~~~~~~~~~~~~~~~~~~~~
The LVM code got a massive overhaul (read as: replacement).
This means new tools are needed to manage the device mapper.
You can get these from ftp://ftp.sistina.com/pub/LVM2/tools/


Debugging options.
~~~~~~~~~~~~~~~~~~
During the stabilising period, it's likely that the debugging options
in the kernel hacking menu will trigger quite a few problems.
Please report any of these problems to linux-kernel@vger.kernel.org
rather than just disabling the relevant CONFIG_ options.

TODO
~~~~
- Reiser4 ?
  http://www.namesys.com/snapshots/2002.10.29/reiser4progs-0.1.0.tar.gz
- ipsec ?
- ebtables
- compilers
  When compiled with a modern gcc (Ie gcc 3.x), 2.5 will use additional
  optimisations that 2.4 didn't. This may shake out compiler bugs that
  2.4 didn't expose. The recommended compiler is still 2.95.3.
- boot time root= parsing changed.
 ramdisks now have ram<n> isntead of rd<n> and cm206 - cm206cd (instead of cm206).


-- 
| Dave Jones.        http://www.codemonkey.org.uk
