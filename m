Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269968AbTGKNq0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 09:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbTGKNq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 09:46:26 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:8072 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S269968AbTGKNpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 09:45:00 -0400
Date: Fri, 11 Jul 2003 15:02:19 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5 'what to expect'
Message-ID: <20030711140219.GB16433@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the flood of testers as we approach 2.6pre,
I thought I'd give this doc another airing to be sure that it
isn't missing anything important.. (Plus I've been meaning to
post an update for a while, and 42 sounded like a good number).

		Dave



                     The post-halloween document. v0.42
                        (aka, 2.5 - what to expect)

                    Dave Jones <davej@codemonkey.org.uk>

                          (Updated as of 2.5.75)

This document explains some of the new functionality to be found in the 2.5
Linux kernel, some pitfalls you may encounter, and also points out some new
features which could really use testing.
Note, that "contact foo@bar.com" below also implies that you should also
cc: linux-kernel@vger.kernel.org.

Latest version of this document can always be found at
http://www.codemonkey.org.uk/post-halloween-2.5.txt

Thanks to many [far too many to list] people for valuable feedback.

Note, that this document is somewhat x86-centric, but most features
documented here affect all platforms anyway.

Spanish translation at:
http://www.terra.es/personal/diegocg/post-halloween-2.5.es.txt

Applying patches.
~~~~~~~~~~~~~~~~~
- In 2.4 and previous kernels, the recommended way to apply patches was
  to use a command line such as ...
  gzip -cd patchXX.gz | patch -p0
  In 2.5, Linus started adding an extra path element to the diffs,
  so using -p1 in the untarred 'to be patched' directory is necessary.


Known gotchas.
~~~~~~~~~~~~~~
Certain known bugs are being reported over and over. Here are the
workarounds.
- Blank screen after decompressing kernel?
  Make sure your .config has
  CONFIG_INPUT=y, CONFIG_VT=y, CONFIG_VGA_CONSOLE=y and CONFIG_VT_CONSOLE=y
  A lot of people have discovered that taking their .config from 2.4 and
  running make oldconfig to pick up new options leads to problems, notably
  with CONFIG_VT not being set.
- An additional bug biting some people is that NICs fail to receive packets
  (usually notable by a NIC not getting a DHCP lease for eg, despite being
   sent one by the server). Booting with "noapic" "acpi=off" or a combination
  of both fixes this for most people. Additional breakage reports should go
  to Jeff Garzik <jgarzik@pobox.com>
- (Possibly linked to above bug) VIA APIC routing is currently broken.
  boot with 'noapic'.
- Can't load any modules? You need updated tools (See modules section below).

Regressions.
~~~~~~~~~~~~
(Things not expected to work just yet)
- The hptraid/promise RAID drivers are currently non functional, and
  will probably be converted to use device-mapper.
- Some filesystems still need work (Intermezzo, UFS, HFS, HPFS..)
- A number of drivers don't compile currently due to them needing various
  work to convert them to the new APIs
- UMSDOS fs is currently missing, pending rewrite.
- The format of /proc/stat changed, which could break some
  applications that still depend on the old layout.
  Currently the only known application to break is the java 
  'DOTS' app. (http://bugme.osdl.org/show_bug.cgi?id=277)
- Some people seem to have trouble running rpm, most notably Red Hat 9 users.
  This is a known bug of rpm.
  Workaround: run "export LD_ASSUME_KERNEL=2.2.5", before running rpm.


Deprecated features.
~~~~~~~~~~~~~~~~~~~~
- khttpd is gone.
- Older Direct Rendering Manager (DRM) support (For XFree86 4.0)
  has been removed. Upgrade to XFree86 4.1.0 or higher.
- LVM1 has been removed. See Device-mapper below.
- boot time root= parsing changed.
  ramdisks are now ram<n> instead of rd<n> and cm206 is cm206cd (instead of
  cm206).
- The system call table is no longer exported. Any module that relied
  on this previously will no longer work.
- Soundmodem hamradio support has been removed. Its functionality
  has been superceded by a userspace replacement.
  http://www.baycom.org/~tom/ham/soundmodem
- Direct booting from floppy is no longer supported.
  You should now use a boot loader program instead.
- Callout tty devices (/dev/cua) have been deprecated since 2.1.90pre2.
  Support is now removed.

Modules.
~~~~~~~~
- The in-kernel module loader got reimplemented.
- You need replacement module utilities from
  http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
- A backwards compatible set of module utilities is also available
  from the same URL in RPM format.
- Debian sid users can 'apt-get install module-init-tools'
- Modules now free stuff marked with __init or __initdata.
- For Red Hat users, there's another pitfall in "/etc/rc.sysinit".
  During startup, the script sets up the binary used to dynamically load
  modules stored at "/proc/sys/kernel/modprobe". The initscript looks
  for "/proc/ksyms", but since it doesn't exist in 2.5 kernels, the
  binary used is "/sbin/true" instead.

  This, eventually, will keep modules from working. Red Hat users will
  have to patch the "/etc/rc.sysinit" script to set
  "/proc/sys/kernel/modprobe" to "/sbin/modprobe", even
  when "/proc/ksyms" doesn't exist.


Kernel build system.
~~~~~~~~~~~~~~~~~~~~
- The build system is much improved compared to 2.4.
  You should notice quicker builds, and less spontaneous rebuilds
  of files on subsequent builds from already built trees.
- There are new graphical config tools.
  "make xconfig" now requires the qt libraries.
  "make gconfig" uses gtk libraries.
- Make menuconfig/oldconfig has no user-visible changes other than speed,
  whilst numerous improvements have been made.
- Several new debug targets exist: 'allyesconfig' 'allnoconfig' 'allmodconfig'.
- Note: The new configuration system is not CML2 related.
- Also note: Whilst some ideas were taken from it, Keith Owens'
  kbuild-2.5 project was not integrated.
- "make" is now the preferred command, without a target; it does <arch-zimage>
  and modules.
- "make -jN" is now the preferred parallel-make execution.
  Do not bother to provide "MAKE=xxx"
- The build is now much less verbose.  If you want to see exactly what's
  going on, try "make V=1" or set KBUILD_VERBOSE=1 in your environment.
- 'make kernel/mm.o' will build the named file, provided a
  corresponding source exists. This also works for (non-composite)
  modules. (FIXME: broken for modules right now?)
- 'make kernel/' will compile all files in a subdirectory and below.
- There is no need to run 'make dep' at any stage.
- 'make help' provides a list of typical targets, including debugging targets.


IO subsystem.
~~~~~~~~~~~~~
- You should notice considerable throughput improvements over 2.4 due
  to much reworking of the block and the memory management layers.
- Report any regressions in this area to Jens Axboe <axboe@suse.de>
  and Andrew Morton <akpm@digeo.com>.
- Several different IO elevators are available to match different types
  of workload.  You can select which one to use with elvtune.
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
  16TB on 32-bit architectures, and up to 8EB on 64-bit architectures.
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
- The actual 'reverse mappings' part of Rik van Riel's rmap vm was merged.
  VM behaviour under certain loads should improve.
- VM misbehaviour should be reported to linux-mm@kvack.org
- The VM explicitly checks for sparse swapfiles, and aborts if one is found.
- /proc/sys/vm/swappiness defines the kernel's preference for pagecache over
  mapped memory. Setting it to 100 (percent) makes it treat both types of
  memory equally. Setting it to zero makes the kernel very much prefer to
  reclaim plain pagecache rather than mapped-into-pagetables memory.
- The bdflush() syscall is now officially deprecated. The syscall
  does nothing, and prints a stern warning to users. The functionality
  is replaced by the pdflush daemons.
- Due to various changes, swap files should be just as fast as swap partitions.


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
- Scheduler is now Hyperthreading SMP aware and will disperse processes
  over physically different CPUs, instead of just over logical CPUs.
- Robert Love wrote various utilities for changing behaviour of the
  scheduler (binding processes to CPUs etc). You can find these tools at
  http://tech9.net/rml/schedutils
- The behavior of sched_yield() changed a lot.  A task that uses
  this system call should now expect to sleep for possibly a very
  long time.  Tasks that do not really desire to give up the
  processor for a while should probably not make heavy use of this
  function.  Unfortunately, some GUI programs (like Open Office)
  do make excessive use of this call and under load their
  performance is poor.  It seems this new 2.5 behavior is optimal
  but some user-space applications may need fixing.
- The above applies to use of yield() in the kernel, too.
- 2.5 adds system calls for manipulating a task's processor
  affinity: sched_getaffinity() and sched_setaffinity()
- Regressions to mingo@redhat.com and rml@tech9.net
- Debian users who encounter effects such as skips in mp3
  playback, jerky mouse movement may want to stop the
  X server from renicing itself to -10
  You can alter this permanently with 'dpkg-reconfigure xserver-common';
  if you elect not to have /etc/X11/Xwrapper.config managed by debconf,
  simply edit it directly.
- Balancing of IRQs between multiple CPUs should be handled using the
  irqbalance (http://people.redhat.com/arjanv/irqbalance/) program.
- David Mosberger maintains a webpage containing some current 'known gotchas'
  of the O(1) scheduler at http://www.hpl.hp.com/research/linux/kernel/o1.php


PCI.
~~~~
- PCI domain support has been added.  For most people, this just means that
  all PCI slot names are extended with "0000:" on the front, but for people
  with bigger servers it means they're able to access all their PCI devices.
- More hotplug drivers have been added, including a fake PCI hotplug driver
  so people without specialised hardware can test hotplug features.


Fast userspace mutexes (Futexes).
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- Rusty Russell added functionality that allows userspace to have
  fast mutexes that only use syscalls when there is contention. Used by
  NPTL.
- Bert Hubert has written some documentation on this functionality
  at http://ds9a.nl/futex-manpages


epoll
~~~~~
Davide Libenzi wrote an event based poll replacement that got
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
  -  sys_clone() enhancements (CLONE_SETTLS, CLONE_PARENT_SETTID, CLONE_SETTID,
     CLONE_CLEARTID, CLONE_DETACHED)
  -  POSIX thread signals stuff (atomic signals, shared signals, etc.)
  -  Per-CPU GDT
  -  Threaded coredumping support
  -  sys_exit() speedups (O(1) exit)
  -  Generic, improved futexes, vcache
  -  New, threading related ptrace features
  -  exit/fork task cache
  -  /proc updates for threading
  -  API changes for threading.
- Users should notice a significant speedup in basic thread operations.
  This is true to a lesser extent even for old-threading userspace libraries 
  such as LinuxThreads.
- Regressions should go to Ingo Molnar <mingo@redhat.com> and
  phil-list@redhat.com.  Regressions could happen in the area of signal
  handling and related threading semantics, plus coredumping.
- Native Posix Threading Library (NPTL).
  Ulrich Drepper worked closely with Ingo on the threading enhancements, and
  developed a 1:1 model threading library. You can find out more about NPTL at
  http://people.redhat.com/drepper/nptl-design.pdf


Enhanced coredumping. 
~~~~~~~~~~~~~~~~~~~~~
- 2.5 offers you the ability to configure the way core files are
  named through a /proc/sys/kernel/core_pattern file.
  You can use various format identifiers in this name to affect
  how the core dump is named.

    %p - insert pid into filename
    %u - insert current uid into filename
    %g - insert current gid into filename
    %s - insert signal that caused the coredump into the filename
    %t - insert UNIX time that the coredump occurred into filename
    %h - insert hostname where the coredump happened into filename
    %e - insert coredumping executable name into filename

  You should ensure that the string does not exceed 64 bytes.
- Multithreaded processes can now dump core


Input layer.
~~~~~~~~~~~~
- Possibly the most visible change to the end user. If misconfigured,
  you'll find that your keyboard/mouse/other input device will no longer work.
  2.5 offers a much more flexible interface to devices such as keyboards.
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
- ALSA can emulate OSS interface using the snd_pcm_oss/snd_pcm_mixer
  modules, if your card produces nothing but silence, you may need to run
  alsamixer to unmute channels wich /dev/mixer doesn't see
- Note that the OSS drivers are also still functional, and still present.
  Many features/fixes that went into 2.4 are still not applied to these
  drivers, and it's still unclear if they will remain when 2.6/3.0 ships.
  The long term goal is to get everyone moved over to (the superior) ALSA.


AGP.
~~~~
- The agpgart driver got a long overdue cleanup which involved
  splitting it into an agpgart core, and per-chipset drivers.
  You may need to adjust your modules configuration to autoload
  the chipset drivers on loading the agpgart module.
- Generic AGP 3.0 support is now included.



Faster system calls.
~~~~~~~~~~~~~~~~~~~~
- Systems that support the SYSENTER extension (Basically Intel PPro and
  above, and AMD Athlons) now have a faster method of making the transition
  from userspace to kernelspace when a syscall is performed.
- Without an updated glibc, this will not be noticable.
- VMWare 4 users may get crashes due to this.
  Zwane Mwaikambo wrote a patch for a "nosysenter" option which is worth
  googling for if there isn't a vmware update available.
- Regressions to torvalds@transmeta.com and libc-alpha@redhat.com


procps.
~~~~~~~
- The 2.5 /proc filesystems changed some statistics, which confuse older
  versions of procps. Rik van Riel and Robert Love have been maintaining a
  version of procps during the 2.5 cycle which tracks changes to /proc which
  you can find at http://tech9.net/rml/procps/
- Alternatively, the procps by Albert Cahalan now supports the altered formats
  since v3.0.5  -- http://procps.sf.net/
- The /proc/meminfo format changed slightly which also broke gtop in strange
  ways. Likely this also broke some of the KDE/GNOME panel applets.


Framebuffer layer.
~~~~~~~~~~~~~~~~~~
- James Simmons has reworked the framebuffer/console layer considerably during
  2.5. Support for some cards is still lagging a little, but it should be
  functionally no different than previous incarnations.
- boot time arguments may have changed depending on your driver.
  an example of the change is..
    append = "video=radeon:1024x768-24@100"
  needs to become..
    append = "video=radeonfb:1024x768-24@100"
- Current userspace tools (fbset for eg) are not yet updated,
  and won't function as expected.
- The VESA framebuffer now enables MTRRs for the framebuffer memory range during
  initialisation (Note: PCI cards only).
  If you notice screen corruption, please report this, along with an lspci output,
  so your card can be blacklisted.
- Any problems should go to <jsimmons@infradead.org>


IDE.
~~~~
- The IDE code rewrite was subject to much criticism in early 2.5.x, which
  put off a lot of people from testing. This work was then subsequently
  dropped, and reverted back to a 2.4.18 IDE status.
  Since then additional work has occurred, but not to the extent
  of the first cleanup attempts.
- Known problems with the current IDE code. 
  o  Simplex IDE devices (eg Ali15x3) are missing DMA sometimes
  o  Serverworks OSB4 may panic on bad blocks or other non fatal errors
  o  PCMCIA IDE hangs on eject
  o  Most PCMCIA devices have unload races and may oops on eject
  o  Modular IDE does not yet work, modular IDE PCI modules sometimes
     oops on loading
  o  ide_scsi is completely broken in 2.5.x. Known problem. If you need it
     either use 2.4 or fix it 8)
- IDE disk geometry translators like OnTrack, EZ Partition, Disk Manager
  are no longer supported. The only way forward is to remove the translator
  from the drive, and start over.


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
  lack error handling. Those noticed so far are ncr53c8xxx, sym53c8xx and
  inia100
- large dev_t support allowing thousands of disks to be
  supported (was 128 or 256 in the 2.4 series)
- major code cleanup, initially to support the block layer (bio)
  improvements have led to:
   - better throughput (?) [less double handling of data]
   - per HBA locks (there was a single io_request_lock in
     the 2.4 series)
   - more flexible interface to HBA drivers
   - better hotplug support, especially for USB mass storage
     and ieee1394 sbp2 devices [well it's work_in_progress]
- improved error processing and scanning code (support for
  large, sparse lun spaces)
- lots of scsi driver "innards" available via sysfs


v4l2.
~~~~~
- The video4linux API finally got its long awaited cleanup.
- xawtv, bttv and most other existing v4l tools are also compatible
  with the new v4l2 layer. You should notice no loss in functionality.
- See http://bytesex.org/v4l/ for more information.


Quota reworking.
~~~~~~~~~~~~~~~~
The new quota system needs new tools. Supports 32 bit uids.
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
- Currently only 'open by device name' works in cdrecord.
  cdrecord -dev=/dev/hdX -inq
- More info at http://lwn.net/Articles/13538/ & http://lwn.net/Articles/13160/


USB:
~~~~
- Very little user visible changes, the only noticable 'major' change
  is that there is now only one UHCI driver. As noted elsewhere, usbdevfs 
  got renamed to usbfs.


Nanosecond stat:
~~~~~~~~~~~~~~~~
The stat64() syscall got changed to return jiffies granularity.
This allows make(1) to make better decisions on whether or not it
needs to recompile a file. Not all filesystems may support such precision.


Filesystems:
~~~~~~~~~~~~
A number of additional filesystems have made their way into 2.5.
Whilst these have had testing out of tree, the level of testing
after merging is unparalleled. Be wary of trusting data to immature
filesystems.  A number of new features and improvements have also
been made to the existing filesystems from 2.4.

Reports of stress testing with the various tools available would
be beneficial.


Generic VFS changes.
~~~~~~~~~~~~~~~~~~~~
- Since Linux 2.5.1 it is possible to atomically move a subtree to
  another place. The call is...
   mount --move olddir newdir
- Since 2.5.43, dmask=value sets the umask applied to directories only.
  The default is the umask of the current process.
  The fmask=value sets the umask applied to regular files only.
  Again, the default is the umask of the current process.


devfs.
~~~~~~
- devfs got somewhat stripped down and a lot of duplicate functionality
  got removed. You now need to enable CONFIG_DEVPTS_FS=y and mount
  the devpts filesystem in the same manner you would if you were not
  using devfs.


EXT2.
~~~~~
- 2.5.49 included an extension to ext2 which will cause it to not attach
  buffer_head structures to file or directory pagecache at all, ever.
  This is for the big highmem machines.  It is enabled via the `-o nobh'
  mount option.
- The ext2 filesystem is now using finer-grained locking which yields reduced
  context switch rates and higher throughput on large SMP machines.


EXT3.
~~~~~
- The ext3 filesystem has gained indexed directory support, which offers
  considerable performance gains when used on filesystems with directories
  containing large numbers of files.
- In order to use the htree feature, you need at least version 1.32 of
  e2fsprogs.
- Existing filesystems can be converted using the command

    tune2fs -O dir_index /dev/hdXXX

- The latest e2fsprogs can be found at
  http://prdownloads.sourceforge.net/e2fsprogs
- data=journal mode is currently broken.
- The ext2 and ext3 filesystems have new file allocations policies (the "Orlov
  allocator") which will place subdirectories closer together on-disk.  This
  tends to mean that operations which touch many files in a directory tree are
  much faster if that tree was created under a 2.5 kernel.


Reiserfs.
~~~~~~~~~
- Reiserfs now supports inode attributes such as immutable.


NFS.
~~~~
- Basic support has been added for NFSv4 (server and client)
- Additionally, kNFSD now supports transport over TCP.
  This experimental feature is also backported to 2.4.20
- Interoperability reports with other OS's would be useful.
- v1.0.3 of nfs-utils supports the newer 2.5 kernels change
  of kdev_t type. You can grab it at http://nfs.sourceforge.net
- Problems to nfs@lists.sourceforge.net


NTFS.
~~~~~
- A new, rewritten NTFS driver got merged during 2.5. It has the
  following main benefits over the old driver:
  - SMP and reentrant safe
  - support bigger than 4 kB cluster sizes
  - full support for sparse files on W2K/XP/W2K3
  - mmap() support
  - More stable, and much faster than the previous NTFS driver.
  - Still read-only, but with safe file overwrite support without changes
  to the file size
  - More information is available at http://linux-ntfs.sf.net


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
The various utilities for creating and manipulating XFS volumes can
be found on SGI's ftp server:
ftp://oss.sgi.com/projects/xfs/download/download/cmd_tars/xfsprogs-2.3.9.src.tar.gz


CIFS.
~~~~~
Support utilities and documentation for the common internet file system (CIFS)
can be found at http://us1.samba.org/samba/Linux_CIFS_client.html


FAT.
~~~~
CVF (Compressed VFAT) support has been removed. This means you
will no longer be able to access DriveSpace partitions.


HugeTLBfs.
~~~~~~~~~~
Files in this filesystem are backed by large pages if the CPU
supports them. See Documentation/vm/hugetlbpage.txt for more details.


Internal filesystems.
~~~~~~~~~~~~~~~~~~~~~
/proc/filesystems will contain several filesystems that are not
mountable in userspace, but are used internally by the kernel
to keep track of things. Amongst these filesystems are futexfs 
and eventpollfs


Oprofile.
~~~~~~~~~
A system wide performance profiler has been included in 2.5.
With this option compiled in, you'll get an oprofilefs filesystem
which you can mount, that the userspace utilities talk to.
You can find out more at http://oprofile.sourceforge.net/oprofile-2.5.html


util-linux.
~~~~~~~~~~~
- You need a fixed readprofile utility for 2.5. Present in util-linux as
  of 2.11z


Improved BIOS table support.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- Linux now supports various new BIOS extensions.


Simple boot flag support.
~~~~~~~~~~~~~~~~~~~~~~~~~
The SBF specification is an x86 BIOS extension that allows improved
system boot speeds. It does this by marking a CMOS field to say
"I booted okay, skip extensive POST next reboot".
Userspace tool is at http://www.codemonkey.org.uk/cruft/sbf.c
More info on SBF is at http://www.microsoft.com/hwdev/resources/specs/simp_bios.asp


EDD Support.
~~~~~~~~~~~~
- Support for BIOS Enhanced Disk Drive Services (EDD) was added,
  which exports information on what the BIOS thinks is the boot
  drive and other useful info to /sys/firmware/edd
- Matt Domsch is interested in hearing success/fails on this code
  with some simple tests decribed at http://domsch.com/linux/edd30/results.html


Intel IPMI support.
~~~~~~~~~~~~~~~~~~~
- IPMI is a standard for monitoring the hardware in a system.
- Project home page: http://openipmi.sourceforge.net
- Specification: http://www.intel.com/design/servers/ipmi/spec.htm


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
  to work around CPU bugs the O(1) scheduler exposes.
  You can find the relevant microcode tools at
  http://www.urbanmyth.org/microcode/
- Any regressions in both should go to mochel@osdl.org Cc: davej@suse.de


Extra tainting.
~~~~~~~~~~~~~~~
Running certain AMD processors in SMP boxes is out of spec, and will taint
the kernel with the 'S' flag.  Running 2 Athlon XPs for example may seem to
work fine, but may also introduce difficult to pin down bugs.
In time it's likely this tainting will be extended to cover other out of
spec cases.

Additionally, the new modules interface will taint the kernel if you try
to 'force' a module to load with insmod -f.


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
Intel's speedstep, and the Powernow! feature present in mobile AMD Athlons.
In addition to x86 variants, this framework also supports various ARM CPUs.
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
- This is backwards compatible with the LVM1 disk format.
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
- Do not use gcc 3.0.x on x86 due to a stack pointer handling bug.
- gcc 2.96 is not supported with CONFIG_FRAME_POINTER=y due to a stack
  pointer handling bug.
- gcc 3.2.2-5 as shipped by Red Hat generates incorrect code in the
  kmalloc optimisation introduced in 2.5.71
  See http://linus.bkbits.net:8080/linux-2.5/cset@1.1410


Security concerns.
~~~~~~~~~~~~~~~~~~
Several security issues solved in 2.4 may not yet be forward ported
to 2.5. For this reason 2.5.x kernels should not be tested on
untrusted systems.  Testing known 2.4 exploits and reporting results
is useful.


Networking.
~~~~~~~~~~~
- ebtables
  The bridging firewall code got merged. To manage these you'll
  need the ebtables tool available from
  http://users.pandora.be/bart.de.schuymer/ebtables/
  More on bridge-nf can be found at http://bridge.sourceforge.net
- Bridged packets can now be 'seen' by iptables.
- IPSec
  Linux finally has IPSec support in mainline.  Use the KAME tools port on
  ftp://ftp.inr.ac.ru/ip-routing/iputils-ss021109-try.tar.bz2
  For more info see http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-44/1127.html
  Also Bert Hubert has a howto at http://lartc.org/howto/lartc.ipsec.html
  Additionally, ipsec-utils is at http://sourceforge.net/projects/ipsec-tools
  Herbert Xu also has patches against FreeSWAN 2.00 to allow its userspace
  to use the 2.5 IPSec functionality. They can be downloaded from
  http://gondor.apana.org.au/~herbert/freeswan/
- Some applications may trigger the kernel to spit out warnings about
  'process xxx using obsolete setsockopt SO_BSDCOMPAT' .
  - Bind 9.2.2 checks for #ifdef SO_BSDCOMPAT in <asm/socket.h> correctly,
    so a recompile is all that is needed.
  - bind9-host from debian testing triggers, though the 'host' package doesn't.
  - process `snmpd' is using obsolete setsockopt SO_BSDCOMPAT
  - process `snmptrapd' is using obsolete setsockopt SO_BSDCOMPAT
  - ntop uses obsolete (PF_INET,SOCK_PACKET)
- Users of boxes with >1 NIC may find that for eg, eth0 and eth1 refer to
  the opposites of what they did in 2.4.   This is a bug that will be fixed
  before 2.6.0.  One option (or management workaround) for this is to use
  'nameif' to name Ethernet interfaces.  There is a HOWTO for doing this at
  <http://xenotime.net/linux/doc/network-interface-names.txt>
- Support for various new RFCs.
  - RFC3173 (IP Payload Compression).
- Linux reaches congestion collapse when subjected to heavy network load.
  NAPI fixes this amongst other things and therefore improving network
  performance.
  More info at http://www.cyberus.ca/~hadi/usenix-paper.tgz and
  ftp://robur.slu.se/pub/Linux/net-development/NAPI/


Crypto
~~~~~~
- A generic crypto API has been merged, offering support for various
  algorithms (HMAC,MD4,MD5,SHA-1,DES,Triple DES EDE, Blowfish)

- This functionality is used by IPSec and the crypto-loop.  It's possible
  that it will later also be available for use in userspace through a crypto
  device, possibly compatible with the OpenBSD crypto userspace.

- The in-kernel loopback device can now do crypto using the CryptoAPI.
  May need new userspace tools.

Deprecated.
~~~~~~~~~~~
- usbdevfs will be going away in 2.7. The same filesystem can
  be mounted as 'usbfs' in recent 2.4 kernels, and in 2.5.52
  and above, which is what the filesystem will furthermore be
  known as.
- elvtune is deprecated (as are the ioctl's it used).
  Instead, the io scheduler tunables are exported in sysfs (see below)
  in the /sys/block/<device>/iosched directory.
  Jens wrote a document explaining the tunables of the new scheduler at
  http://www.lib.uaa.alaska.edu/linux-kernel/archive/2002-Week-44/att-deadline-iosched.txt



Ports.
~~~~~~
- 2.5 features support for several new architectures.
  - x86-64 (AMD Hammer)
  - ppc64
  - UML (User mode Linux)
    See http://user-mode-linux.sf.net for more information.
  - uCLinux: m68k(w/o MMU), h8300 and v850.  sh also added a uCLinux option.
- The 64 bit s390x port got collapsed into a single port, appearing
  as a config option in the base s390 arch.
- In the opposite direction, arm26 was split out from arm.


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Revision history:
0.42 - CONFIG_LOG_BUF_SHIFT is now sanity checked by Kconfig
       Hyperthreading scheduler improvements.
	   ALSA OSS emulation.
	   32bit uids in new quota.
	   Not all filesystems support nanosecond stat.
	   Note that NTFS still isn't R/W
	   Mention CryptoLoop.
0.41 - V=0 is now default. Document V=1
       s/Redhat/Red Hat/ everywhere.
       Added vmware sysenter note.
       MTRR for vesafb
       Various grammar fixes.
       Selectable elevators.
       PCI domains
0.40 - Callout tty devices are removed.
       Added note about modules in Red Hat 9
0.39 - irqbalance note added.
       Added ntop, snmp tools obsolete messages.
       Added link to David Mosberger's O(1) page.
       Mention Herbert Xu's FreeSWAN patches.
       Add CONFIG_VGA_CONSOLE to the list of gotchas.
       Add note about 2.4 .config's to gotchas.
       Reword devpts note.
0.38 - Fixed URL to nameif
0.37 - devfs users now need to mount devpts.
       mention h8300 port.    
       mentioned NTFS rewrite.
0.36 - Include Doug Gilberts 'positive SCSI spin'.
       Mention NAPI.
       Reword the CPU bug workaround that the O(1) scheduler exposes.
       Added 'Known Gotchas' section
0.35 - Note about KDE panel applets.
       mount --move, dmask, fmask
       Removed note about oprofile utilities being underdeveloped.
       Mention ext2 locking, and ext2/ext3 orlov allocator.
0.34 - Remove people.redhat.com NPTL URLs on Ulrich Dreppers request.
       Added note about s390x going away.
       Various kbuild updates.
       Note about swap files.
       Added note about -p1 vs -p0
       Lots of typo fixes from Randy Dunlap.
       RPM from RH9 seems to have problems.
0.33 - Networking RFCs section added.
0.32 - Added Soundmodem userspace replacement URL.
0.31 - ext3 data=journal breakage noted.
0.30 - Athlon powernow is now supported.
0.29 - Mention NIC renumbering and ACPI/APIC NIC bugs. 
0.28 - SO_BSDCOMPAT obsolete messages, nfsutils.
0.27 - radeon -> radeonfb
0.26 - Added info about readprofile.
0.25 - Added cdrecord example. Added URL to Spanish translation.
0.1->0.24 - Unrecorded history

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Other Links.
http://www.kernelnewbies.org/status/
http://bugzilla.kernel.org/


-- 
 Dave Jones     http://www.codemonkey.org.uk
