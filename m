Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLROra>; Mon, 18 Dec 2000 09:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129391AbQLROrK>; Mon, 18 Dec 2000 09:47:10 -0500
Received: from whiterose.net ([199.245.105.145]:4138 "EHLO whiterose.net")
	by vger.kernel.org with ESMTP id <S129260AbQLROrB>;
	Mon, 18 Dec 2000 09:47:01 -0500
Date: Mon, 18 Dec 2000 09:16:30 -0500 (EST)
From: M Sweger <mikesw@whiterose.net>
To: linux-kernel@vger.kernel.org, sfr@linuxcare.com
Subject: linux 2.2.19pre1 a problem with APM and powering off
Message-ID: <Pine.LNX.4.21.0012180914190.2441-100000@whiterose.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
      In linux 2.2.16 the poweroff command shutoff power to my Dell
Optiplex GX1 333mhz without problem. The kernel compile options were
	CONFIG_APM_REAL_MODE_POWER_OFF=y
	CONFIG_SMP=y


Shortly after 2.2.16 fixes were implemented for SMP support, and ever since
then I've had poweroff problems.

	Presently, I'm running linux 2.2.19pre1 and am playing around with
the configurations to see what will work. I listed my comments below
in ITEM A-C. Eventually, I did find a combination that worked at powering
off the Dell but it wasn't what I thought should happen.

A). PROBLEM -- need documentation:
	  In the i386 subdir, apm.c comments for the "apm=" options you specify
          what the valid parameters are, and mention that it is in the
          Documentation/Config.help file. However, *only* the apm=off
          option is mentioned in the Configure.help and not the others
	  under the title "Advanced Power Management BIOS support".
	  The "apm=" option is mentioned in kernel-parameters.txt,but
	  not the options.

          Suggest that the apm= option be updated in the Configure.help
	  for novices and that an apm.txt file for the Documentation
	  subdirectory be written that explains the various options, 
	  and how to use them on the kernel commandline along with the
	  various restrictions that it will work for i.e. SMP, non-SMP,
	  and dummy SMP etc. It should also mention when the apmd daemon
	  should be used, along with what the various battery codes mean
	  in English like text messages; whether it is displayed during
	  boot or in the /proc/apm file so that one doesn't have to dig
          into the code and try to find it.

	  SUGGESTION: In the apm.txt file create a matrix which shows
          the relationships of CONFIG_SMP and CONFIG_APM_REAL_MODE_POWER_OFF
          with respect to the apm= options vs. whether the PC shuts off or not.
	  I.E. for the no-power-off apm= option, it should override the
	  compiled in kernel options (haven't tested it though).
	  This will help one to see at a glance the "x's" in this matrix
	  as to what will happen.

          I think this will cut down on the questions to the kernel
	  mailing list and linuxcare about this topic.


QUESTION: Instead of having to activate the "debug" apm= option to get
          English-like status messages instead of codes, could you change
          it so /proc/apm and the syslogs always get English words?
          I'm thinking of something like what "cat /proc/cpuinfo" does..


 Listed below are two different configurations. The first with SMP support,
although I only have one processor, and am using REAL MODE power off.
The second is wihtout SMP support, but varies the REAL MODE option.


B). Here is my data with APM support (although I only have one cpu
    it will use dummy APIC emulation) and
    REAL mode APM, assuming BIOS is buggy.

     NOTE: when typing the poweroff or "halt -p" command I do get the
            "power down" message on kernel shutdown, but the computer
 	     won't power off.

     QUESTION: Shouldn't the kernel shutoff the computer in spite of
	       of SMP support being compiled in, since it should be 
	       smart enough to know that I only have one CPU by virtue
	       of it detecting and activating "dummy APIC emulation" and
	       thus ignore this "other dummy CPU" as non-existent when
	       it comes to powering off the computer?

	       Now I assume that when SMP support is compiled in, the
	       kernel can't handle which cpu initiated shutdown if done
	       simultaneouly (a race) and that this is why the kernel
	       won't turn computer power off.

Here is my kernel APM config setups.

CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=y

CONFIG_SMP=y

cat /proc/apm

1.13 1.2 0x03 0x01 0xff 0x80 -1% -1 ?

cat /proc/cmdline     ***NOTE: I use Dos Linux which uses loadlin v1.6.
			       The umsdos.bat contains the same info here.

root=/dev/sda6 rw init=auto console=ttyS2,9600 console=tty0 apm=debug,on,power-off BOOT_IMAGE=zimage

dmesg

Linux version 2.2.19pre1 (root@DosLinux) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #1 SMP Mon Dec 11 18:39:45 /etc/localtime 2000
mapped APIC to ffffe000 (002e6000)
Detected 331711 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 661.91 BogoMIPS
Memory: 127364k/131008k available (1508k kernel code, 416k reserved, 1620k data, 100k init)
Dentry hash table entries: 16384 (order 5, 128k)
Buffer cache hash table entries: 131072 (order 7, 512k)
Page cache hash table entries: 32768 (order 5, 128k)
VFS: Diskquotas version dquot_6.4.0 initialized
512K L2 cache (4 way)
CPU: L2 Cache: 512K
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
512K L2 cache (4 way)
CPU: L2 Cache: 512K
per-CPU timeslice cutoff: 99.92 usecs.
CPU0: Intel Pentium II (Deschutes) stepping 01
SMP motherboard not detected. Using dummy APIC emulation.
PCI: PCI BIOS revision 2.10 entry at 0xfcaee
PCI: Using configuration type 1
PCI: Probing PCI hardware


[snipped data not needed....}

scsi : detected 1 SCSI generic 1 SCSI disk total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 17783204 [8683 MB] [8.7 GB]
Partition check:
 sda: sda1 sda2 < sda5 sda6 sda7 >
 hdc: [PTBL] [621/64/63] hdc1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13)
apm: entry f000:f0fc cseg16 f000 dseg f000 cseg len ffff, dseg len ffff cseg16 len ffff
apm: Connection version 1.2
apm: AC on line, battery status unknown, battery life unknown
apm: battery flag 0x80, battery life unknown
UMSDOS 0.85i (compatibility level 0.4, fast msdos)
check_pseudo_root: mounted as root
check_pseudo_root: found //linux
check_pseudo_root: found sbin/init, enabling pseudo-root
UMSDOS: changed to alternate root


[snipped some here too til login prompt....]



C). PROBLEM: Now here is the data without SMP support and "not" 
    using REAL MODE which assumes the BIOS works. THIS WORKS and
    will shutoff my computer when the "poweroff" command is issued.

    HOWEVER, if REAL MODE POWER OFF is compiled in, which assumes
    one has a buggy BIOS, then it will "not" turn power off to the
    computer. This seems ironic, considering the reason one uses
    this is that the BIOS is assumed to be buggy, and thus it should
    "always" turn off the computer. In this case, the kernel code
    for this option is buggy instead of the BIOS which is assumed
    to be buggy. Thus, I believe the kernel code for this needs fixing!


Here is my kernel APM config setups.

CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=y
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

# CONFIG_SMP is not set

cat /proc/apm

1.13 1.2 0x03 0x01 0xff 0x80 -1% -1 ?


cat /proc/cmdline     ***NOTE: I use Dos Linux which uses loadlin v1.6.
			       The umsdos.bat contains the same info here.

root=/dev/sda6 rw init=auto console=ttyS2,9600 console=tty0 apm=debug,on,power-off BOOT_IMAGE=zimage

dmesg

Linux version 2.2.19pre1 (root@DosLinux) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #1 Fri Dec 15 16:57:21 /etc/localtime 2000
Detected 331711 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 661.91 BogoMIPS
Memory: 127500k/131008k available (1440k kernel code, 408k reserved, 1572k data, 88k init)
Dentry hash table entries: 16384 (order 5, 128k)
Buffer cache hash table entries: 131072 (order 7, 512k)
Page cache hash table entries: 32768 (order 5, 128k)
VFS: Diskquotas version dquot_6.4.0 initialized
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
512K L2 cache (4 way)
CPU: L2 Cache: 512K
CPU: Intel Pentium II (Deschutes) stepping 01
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfcaee
PCI: Using configuration type 1
PCI: Probing PCI hardware

[snipped unnecessary stuff..... ]

SCSI device sda: hdwr sector= 512 bytes. Sectors= 17783204 [8683 MB] [8.7 GB]
Partition check:
 sda: sda1 sda2 < sda5 sda6 sda7 >
 hdc: [PTBL] [621/64/63] hdc1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13)
apm: entry f000:f0fc cseg16 f000 dseg f000 cseg len ffff, dseg len ffff cseg16 len ffff
apm: Connection version 1.2
apm: AC on line, battery status unknown, battery life unknown
apm: battery flag 0x80, battery life unknown
UMSDOS 0.85i (compatibility level 0.4, fast msdos)
check_pseudo_root: mounted as root
check_pseudo_root: found //linux
check_pseudo_root: found sbin/init, enabling pseudo-root

[snipped stuff to login prompt.....]




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
