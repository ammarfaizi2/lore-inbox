Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280317AbRJaRNC>; Wed, 31 Oct 2001 12:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280309AbRJaRLN>; Wed, 31 Oct 2001 12:11:13 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:28900 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280303AbRJaRKp>; Wed, 31 Oct 2001 12:10:45 -0500
Date: Wed, 31 Oct 2001 09:03:17 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] making the printk buffer bigger 
Message-ID: <3791617980.1004518997@[10.10.1.2]>
In-Reply-To: <Pine.GSO.3.96.1011031122155.10781A-100000@delta.ds2.pg.gda.pl>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I don't just want it for development, I believe in capturing my boot messages 
>> all the time. If they're not visible, why bother printing them?
> 
>  Assuming the code is correct at one stage, what do you need detailed
> debug data, for? 

I don't need detailed debug - I just don't like the way it looses half the boot
messages under the default configuration for every one of these machines
out there. Hence, I'd like to change the default config so that it works out
the box for people running these things. I'm not turning on extra debug, 
that's how it comes.
 
>> The correct solution is probably to either size it dynamically, or have a
>> seperate boot time buffer that we throw away afterwards. But for the 
>> sake of another 48Kb on machines with 2 - 16Gb of RAM, it's not worth
>> coding it, testing it, and risking the change.
> 
>  There are 4MB systems out there, too.  Sizing the buffer dynamically is
> probably OK.

But I suspect there aren't 4MB SMP systems, and there definately aren't
4Mb Multiquad Systems. Hence the #ifdef.

>  The MPS tables are tiny comparing to other stuff, I'm told.  

The MPS tables are tiny. The amount of stuff we print out from them is
large, especially if you have 16 or more processors. Look at mpparse.c:
MP_processor_info, for example. 8 IO APICs produces a lot of output too.
Here, I'll append a boot log from an 8 processor machine, and you can
see what I mean. Bear in mind that this is for a *small* machine, things
get rapidly worse as you grow the number of nodes.

> Switching them to KERN_DEBUG is a good idea at this stage; as 
> is probably undefining APIC_DEBUG.  

As I understand this problem (feel free to correct me) switching things
to KERN_DEBUG doesn't help - they'll still get logged in the buffer at
boot time. Undefining APIC debug *would* help - switches all the 
Dprintk's to be NULL.

> Anyway, I'm told APIC debug messages are small comparing to 
> ones output by certain other subsystems. 

Hmmm ... not convinced. Bear in mind that the mpparse stuff and
other subsystems use Dprintk too - as far as I can see that switches
off APIC_DEBUG whereever it's used. Perhaps that's part of the
problem. 

Log below. did a grep for "kernel" on messages to make this more
readable. And yes, I could easily strip out the "translation" messages,
but that's a tiny part of the problem. Main things seem to be processors
and IO APICs.

Oct 31 09:54:12 elm3b76 kernel: klogd 1.3-3, log source = /proc/kmsg started.
Oct 31 09:54:12 elm3b76 kernel: Inspecting /boot/System.map-2.4.13
Oct 31 09:54:12 elm3b76 kernel: Loaded 13043 symbols from /boot/System.map-2.4.13.
Oct 31 09:54:12 elm3b76 kernel: Symbols match kernel version 2.4.13.
Oct 31 09:54:12 elm3b76 kernel: No module symbols loaded.
Oct 31 09:54:12 elm3b76 kernel: Linux version 2.4.13 (root@elm3b76) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #2 SMP Wed Oct 31 09:36:44 PST 2001 
Oct 31 09:54:12 elm3b76 kernel: BIOS-provided physical RAM map: 
Oct 31 09:54:12 elm3b76 kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable) 
Oct 31 09:54:12 elm3b76 kernel:  BIOS-e820: 0000000000100000 - 0000000080000000 (usable) 
Oct 31 09:54:12 elm3b76 kernel:  BIOS-e820: 00000000fec00000 - 00000000fec09000 (reserved) 
Oct 31 09:54:12 elm3b76 kernel:  BIOS-e820: 00000000ffe80000 - 0000000100000000 (reserved) 
Oct 31 09:54:12 elm3b76 kernel: Warning only 896MB will be used. 
Oct 31 09:54:12 elm3b76 kernel: Use a HIGHMEM enabled kernel. 
Oct 31 09:54:12 elm3b76 kernel: found SMP MP-table at 000f6040 
Oct 31 09:54:12 elm3b76 kernel: hm, page 000f6000 reserved twice. 
Oct 31 09:54:12 elm3b76 kernel: hm, page 000f7000 reserved twice. 
Oct 31 09:54:12 elm3b76 kernel: On node 0 totalpages: 229376 
Oct 31 09:54:12 elm3b76 kernel: zone(0): 4096 pages. 
Oct 31 09:54:12 elm3b76 kernel: zone(1): 225280 pages. 
Oct 31 09:54:12 elm3b76 kernel: zone(2): 0 pages. 
Oct 31 09:54:12 elm3b76 kernel: Intel MultiProcessor Specification v1.4 
Oct 31 09:54:12 elm3b76 kernel:     Virtual Wire compatibility mode. 
Oct 31 09:54:12 elm3b76 kernel: OEM ID: IBM NUMA Product ID: SBB          APIC at: 0xFEC08000 
Oct 31 09:54:12 elm3b76 kernel: Processor #0 Pentium(tm) Pro APIC version 17 
Oct 31 09:54:12 elm3b76 kernel: Processor #4 Pentium(tm) Pro APIC version 17 
Oct 31 09:54:13 elm3b76 kernel: Processor #1 Pentium(tm) Pro APIC version 17 
Oct 31 09:54:13 elm3b76 kernel: Processor #2 Pentium(tm) Pro APIC version 17 
Oct 31 09:54:13 elm3b76 kernel: Processor #0 Pentium(tm) Pro APIC version 17 
Oct 31 09:54:13 elm3b76 kernel: Processor #4 Pentium(tm) Pro APIC version 17 
Oct 31 09:54:13 elm3b76 kernel: Processor #1 Pentium(tm) Pro APIC version 17 
Oct 31 09:54:13 elm3b76 kernel: Processor #2 Pentium(tm) Pro APIC version 17 
Oct 31 09:54:13 elm3b76 kernel: I/O APIC #13 Version 17 at 0xFE800000. 
Oct 31 09:54:13 elm3b76 kernel: I/O APIC #14 Version 17 at 0xFE801000. 
Oct 31 09:54:13 elm3b76 kernel: I/O APIC #15 Version 17 at 0xFE840000. 
Oct 31 09:54:13 elm3b76 kernel: I/O APIC #16 Version 17 at 0xFE841000. 
Oct 31 09:54:13 elm3b76 kernel: Processors: 8 
Oct 31 09:54:13 elm3b76 kernel: Kernel command line: BOOT_IMAGE=linux ro root=801 reboot=bios console=tty0 console=ttyS0,38400 
Oct 31 09:53:58 elm3b76 sysctl: error: 'kernel.sysrq' is an unknown key 
Oct 31 09:54:13 elm3b76 kernel: Initializing CPU#0 
Oct 31 09:54:13 elm3b76 kernel: Detected 495.129 MHz processor. 
Oct 31 09:54:13 elm3b76 kernel: Console: colour VGA+ 80x25 
Oct 31 09:53:58 elm3b76 rc.sysinit: Configuring kernel parameters succeeded 
Oct 31 09:54:13 elm3b76 kernel: Calibrating delay loop... 986.31 BogoMIPS 
Oct 31 09:54:13 elm3b76 kernel: Memory: 900960k/917504k available (907k kernel code, 16156k reserved, 263k data, 196k init, 0k highmem) 
Oct 31 09:54:14 elm3b76 kernel: Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes) 
Oct 31 09:54:14 elm3b76 kernel: Inode-cache hash table entries: 65536 (order: 7, 524288 bytes) 
Oct 31 09:54:14 elm3b76 kernel: Mount-cache hash table entries: 16384 (order: 5, 131072 bytes) 
Oct 31 09:54:14 elm3b76 kernel: Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes) 
Oct 31 09:54:14 elm3b76 kernel: Page-cache hash table entries: 262144 (order: 8, 1048576 bytes) 
Oct 31 09:54:14 elm3b76 kernel: CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0 
Oct 31 09:54:15 elm3b76 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Oct 31 09:54:15 elm3b76 kernel: CPU: L2 cache: 512K 
Oct 31 09:54:15 elm3b76 kernel: Intel machine check architecture supported. 
Oct 31 09:54:15 elm3b76 kernel: Intel machine check reporting enabled on CPU#0. 
Oct 31 09:54:15 elm3b76 kernel: CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000 
Oct 31 09:54:15 elm3b76 kernel: CPU serial number disabled. 
Oct 31 09:54:15 elm3b76 kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:16 elm3b76 kernel: CPU:             Common caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:16 elm3b76 kernel: Enabling fast FPU save and restore... done. 
Oct 31 09:54:16 elm3b76 kernel: Enabling unmasked SIMD FPU exception support... done. 
Oct 31 09:54:16 elm3b76 kernel: Checking 'hlt' instruction... OK. 
Oct 31 09:54:16 elm3b76 kernel: POSIX conformance testing by UNIFIX 
Oct 31 09:54:16 elm3b76 kernel: Cross quad port I/O vaddr 0xf8800000, len 00040000 
Oct 31 09:54:16 elm3b76 kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au) 
Oct 31 09:54:16 elm3b76 kernel: mtrr: detected mtrr type: Intel 
Oct 31 09:54:17 elm3b76 kernel: CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0 
Oct 31 09:54:09 elm3b76 sysctl: error: 'kernel.sysrq' is an unknown key 
Oct 31 09:54:17 elm3b76 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Oct 31 09:54:17 elm3b76 kernel: CPU: L2 cache: 512K 
Oct 31 09:54:17 elm3b76 kernel: Intel machine check reporting enabled on CPU#0. 
Oct 31 09:54:17 elm3b76 kernel: CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:17 elm3b76 kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:18 elm3b76 kernel: CPU:             Common caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:18 elm3b76 kernel: CPU0: Intel Pentium III (Katmai) stepping 03 
Oct 31 09:54:18 elm3b76 kernel: per-CPU timeslice cutoff: 1461.65 usecs. 
Oct 31 09:54:18 elm3b76 kernel: enabled ExtINT on CPU#0 
Oct 31 09:54:18 elm3b76 kernel: Leaving ESR disabled. 
Oct 31 09:54:19 elm3b76 kernel: Booting processor 1/2 eip 2000 
Oct 31 09:54:19 elm3b76 kernel: Initializing CPU#1 
Oct 31 09:54:19 elm3b76 kernel: masked ExtINT on CPU#1 
Oct 31 09:54:19 elm3b76 kernel: Leaving ESR disabled. 
Oct 31 09:54:19 elm3b76 kernel: Calibrating delay loop... 989.59 BogoMIPS 
Oct 31 09:54:19 elm3b76 kernel: CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0 
Oct 31 09:54:19 elm3b76 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Oct 31 09:54:19 elm3b76 kernel: CPU: L2 cache: 512K 
Oct 31 09:54:19 elm3b76 kernel: Intel machine check reporting enabled on CPU#1. 
Oct 31 09:54:19 elm3b76 kernel: CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000 
Oct 31 09:54:20 elm3b76 kernel: CPU serial number disabled. 
Oct 31 09:54:20 elm3b76 kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:20 elm3b76 kernel: CPU:             Common caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:20 elm3b76 kernel: CPU1: Intel Pentium III (Katmai) stepping 03 
Oct 31 09:54:20 elm3b76 kernel: Restoring NMI vector 
Oct 31 09:54:20 elm3b76 kernel: Booting processor 2/4 eip 2000 
Oct 31 09:54:20 elm3b76 kernel: Initializing CPU#2 
Oct 31 09:54:20 elm3b76 kernel: masked ExtINT on CPU#2 
Oct 31 09:54:20 elm3b76 kernel: Leaving ESR disabled. 
Oct 31 09:54:20 elm3b76 kernel: Calibrating delay loop... 989.59 BogoMIPS 
Oct 31 09:54:20 elm3b76 kernel: CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0 
Oct 31 09:54:20 elm3b76 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Oct 31 09:54:20 elm3b76 kernel: CPU: L2 cache: 512K 
Oct 31 09:54:20 elm3b76 kernel: Intel machine check reporting enabled on CPU#2. 
Oct 31 09:54:20 elm3b76 kernel: CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000 
Oct 31 09:54:20 elm3b76 kernel: CPU serial number disabled. 
Oct 31 09:54:20 elm3b76 kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:20 elm3b76 kernel: CPU:             Common caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:20 elm3b76 kernel: CPU2: Intel Pentium III (Katmai) stepping 03 
Oct 31 09:54:20 elm3b76 kernel: Restoring NMI vector 
Oct 31 09:54:21 elm3b76 kernel: Booting processor 3/8 eip 2000 
Oct 31 09:54:21 elm3b76 kernel: Initializing CPU#3 
Oct 31 09:54:21 elm3b76 kernel: masked ExtINT on CPU#3 
Oct 31 09:54:21 elm3b76 kernel: Leaving ESR disabled. 
Oct 31 09:54:21 elm3b76 kernel: Calibrating delay loop... 989.59 BogoMIPS 
Oct 31 09:54:21 elm3b76 kernel: CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0 
Oct 31 09:54:21 elm3b76 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Oct 31 09:54:21 elm3b76 kernel: CPU: L2 cache: 512K 
Oct 31 09:54:21 elm3b76 kernel: Intel machine check reporting enabled on CPU#3. 
Oct 31 09:54:21 elm3b76 kernel: CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000 
Oct 31 09:54:21 elm3b76 kernel: CPU serial number disabled. 
Oct 31 09:54:21 elm3b76 kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:21 elm3b76 kernel: CPU:             Common caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:21 elm3b76 kernel: CPU3: Intel Pentium III (Katmai) stepping 03 
Oct 31 09:54:21 elm3b76 kernel: Restoring NMI vector 
Oct 31 09:54:21 elm3b76 kernel: Booting processor 4/17 eip 2000 
Oct 31 09:54:21 elm3b76 kernel: Initializing CPU#4 
Oct 31 09:54:21 elm3b76 kernel: masked ExtINT on CPU#4 
Oct 31 09:54:21 elm3b76 kernel: Leaving ESR disabled. 
Oct 31 09:54:21 elm3b76 kernel: Calibrating delay loop... 986.31 BogoMIPS 
Oct 31 09:54:21 elm3b76 kernel: CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0 
Oct 31 09:54:21 elm3b76 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Oct 31 09:54:21 elm3b76 kernel: CPU: L2 cache: 512K 
Oct 31 09:54:21 elm3b76 kernel: Intel machine check reporting enabled on CPU#4. 
Oct 31 09:54:21 elm3b76 kernel: CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000 
Oct 31 09:54:21 elm3b76 kernel: CPU serial number disabled. 
Oct 31 09:54:21 elm3b76 kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:21 elm3b76 kernel: CPU:             Common caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:22 elm3b76 kernel: CPU4: Intel Pentium III (Katmai) stepping 03 
Oct 31 09:54:22 elm3b76 kernel: Restoring NMI vector 
Oct 31 09:54:22 elm3b76 kernel: Booting processor 5/18 eip 2000 
Oct 31 09:54:22 elm3b76 kernel: Initializing CPU#5 
Oct 31 09:54:22 elm3b76 kernel: masked ExtINT on CPU#5 
Oct 31 09:54:22 elm3b76 kernel: Leaving ESR disabled. 
Oct 31 09:54:22 elm3b76 kernel: Calibrating delay loop... 986.31 BogoMIPS 
Oct 31 09:54:22 elm3b76 kernel: CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0 
Oct 31 09:54:22 elm3b76 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Oct 31 09:54:22 elm3b76 kernel: CPU: L2 cache: 512K 
Oct 31 09:54:22 elm3b76 kernel: Intel machine check reporting enabled on CPU#5. 
Oct 31 09:54:22 elm3b76 kernel: CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000 
Oct 31 09:54:22 elm3b76 kernel: CPU serial number disabled. 
Oct 31 09:54:22 elm3b76 kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:22 elm3b76 kernel: CPU:             Common caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:22 elm3b76 kernel: CPU5: Intel Pentium III (Katmai) stepping 03 
Oct 31 09:54:22 elm3b76 kernel: Restoring NMI vector 
Oct 31 09:54:22 elm3b76 kernel: Booting processor 6/20 eip 2000 
Oct 31 09:54:22 elm3b76 kernel: Initializing CPU#6 
Oct 31 09:54:22 elm3b76 kernel: masked ExtINT on CPU#6 
Oct 31 09:54:22 elm3b76 kernel: Leaving ESR disabled. 
Oct 31 09:54:22 elm3b76 kernel: Calibrating delay loop... 986.31 BogoMIPS 
Oct 31 09:54:22 elm3b76 kernel: CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0 
Oct 31 09:54:23 elm3b76 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Oct 31 09:54:23 elm3b76 kernel: CPU: L2 cache: 512K 
Oct 31 09:54:23 elm3b76 kernel: Intel machine check reporting enabled on CPU#6. 
Oct 31 09:54:23 elm3b76 kernel: CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000 
Oct 31 09:54:23 elm3b76 kernel: CPU serial number disabled. 
Oct 31 09:54:23 elm3b76 kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:23 elm3b76 kernel: CPU:             Common caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:23 elm3b76 kernel: CPU6: Intel Pentium III (Katmai) stepping 03 
Oct 31 09:54:23 elm3b76 kernel: Restoring NMI vector 
Oct 31 09:54:23 elm3b76 kernel: Booting processor 7/24 eip 2000 
Oct 31 09:54:23 elm3b76 kernel: Initializing CPU#7 
Oct 31 09:54:23 elm3b76 kernel: masked ExtINT on CPU#7 
Oct 31 09:54:23 elm3b76 kernel: Leaving ESR disabled. 
Oct 31 09:54:23 elm3b76 kernel: Calibrating delay loop... 989.59 BogoMIPS 
Oct 31 09:54:23 elm3b76 kernel: CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0 
Oct 31 09:54:23 elm3b76 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Oct 31 09:54:23 elm3b76 kernel: CPU: L2 cache: 512K 
Oct 31 09:54:23 elm3b76 kernel: Intel machine check reporting enabled on CPU#7. 
Oct 31 09:54:23 elm3b76 kernel: CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000 
Oct 31 09:54:23 elm3b76 kernel: CPU serial number disabled. 
Oct 31 09:54:23 elm3b76 kernel: CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:23 elm3b76 kernel: CPU:             Common caps: 0383fbff 00000000 00000000 00000000 
Oct 31 09:54:23 elm3b76 kernel: CPU7: Intel Pentium III (Katmai) stepping 03 
Oct 31 09:54:23 elm3b76 kernel: Restoring NMI vector 
Oct 31 09:54:23 elm3b76 kernel: Total of 8 processors activated (7903.64 BogoMIPS). 
Oct 31 09:54:23 elm3b76 kernel: ENABLING IO-APIC IRQs 
Oct 31 09:54:23 elm3b76 kernel: Setting 13 in the phys_id_present_map 
Oct 31 09:54:23 elm3b76 kernel: ...changing IO-APIC physical APIC ID to 13 ... ok. 
Oct 31 09:54:23 elm3b76 kernel: Setting 14 in the phys_id_present_map 
Oct 31 09:54:24 elm3b76 kernel: ...changing IO-APIC physical APIC ID to 14 ... ok. 
Oct 31 09:54:24 elm3b76 kernel: BIOS bug, IO-APIC#2 ID is 15 in the MPC table!... 
Oct 31 09:54:24 elm3b76 kernel: ... fixing up to 14. (tell your hw vendor) 
Oct 31 09:54:24 elm3b76 kernel: BIOS bug, IO-APIC#2 ID 14 is already used!... 
Oct 31 09:54:24 elm3b76 kernel: ... fixing up to 4. (tell your hw vendor) 
Oct 31 09:54:24 elm3b76 kernel: ...changing IO-APIC physical APIC ID to 4 ... ok. 
Oct 31 09:54:24 elm3b76 kernel: BIOS bug, IO-APIC#3 ID is 16 in the MPC table!... 
Oct 31 09:54:24 elm3b76 kernel: ... fixing up to 13. (tell your hw vendor) 
Oct 31 09:54:24 elm3b76 kernel: BIOS bug, IO-APIC#3 ID 13 is already used!... 
Oct 31 09:54:24 elm3b76 kernel: ... fixing up to 5. (tell your hw vendor) 
Oct 31 09:54:24 elm3b76 kernel: ...changing IO-APIC physical APIC ID to 5 ... ok. 
Oct 31 09:54:24 elm3b76 kernel: init IO_APIC IRQs 
Oct 31 09:54:24 elm3b76 kernel:  IO-APIC (apicid-pin) 13-0, 14-0, 14-8, 14-18, 14-19, 14-20, 14-21, 14-22, 14-23, 4-0, 5-0, 5-8, 5-18, 5-19, 5-20, 5-21, 5-22, 5-23 not connected. 
Oct 31 09:54:24 elm3b76 kernel: ..TIMER: vector=0x31 pin1=2 pin2=0 
Oct 31 09:54:24 elm3b76 kernel: number of MP IRQ sources: 80. 
Oct 31 09:54:24 elm3b76 kernel: number of IO-APIC #13 registers: 24. 
Oct 31 09:54:24 elm3b76 kernel: number of IO-APIC #14 registers: 24. 
Oct 31 09:54:24 elm3b76 kernel: number of IO-APIC #4 registers: 24. 
Oct 31 09:54:24 elm3b76 kernel: number of IO-APIC #5 registers: 24. 
Oct 31 09:54:24 elm3b76 kernel: testing the IO APIC....................... 
Oct 31 09:54:24 elm3b76 kernel:  
Oct 31 09:54:24 elm3b76 kernel: IO APIC #13...... 
Oct 31 09:54:24 elm3b76 kernel: .... register #00: 0D000000 
Oct 31 09:54:24 elm3b76 kernel: .......    : physical APIC id: 0D 
Oct 31 09:54:24 elm3b76 kernel: .... register #01: 00170011 
Oct 31 09:54:24 elm3b76 kernel: .......     : max redirection entries: 0017 
Oct 31 09:54:24 elm3b76 kernel: .......     : IO APIC version: 0011 
Oct 31 09:54:24 elm3b76 kernel: .... register #02: 00000000 
Oct 31 09:54:24 elm3b76 kernel: .......     : arbitration: 00 
Oct 31 09:54:24 elm3b76 kernel: .... IRQ redirection table: 
Oct 31 09:54:24 elm3b76 kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:    
Oct 31 09:54:24 elm3b76 kernel:  00 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:24 elm3b76 kernel:  01 00F 0F  0    0    0   0   0    0    1    39 
Oct 31 09:54:24 elm3b76 kernel:  02 00F 0F  0    0    0   0   0    0    1    31 
Oct 31 09:54:25 elm3b76 kernel:  03 00F 0F  0    0    0   0   0    0    1    41 
Oct 31 09:54:25 elm3b76 kernel:  04 00F 0F  0    0    0   0   0    0    1    49 
Oct 31 09:54:25 elm3b76 kernel:  05 00F 0F  0    0    0   0   0    0    1    51 
Oct 31 09:54:25 elm3b76 kernel:  06 00F 0F  0    0    0   0   0    0    1    59 
Oct 31 09:54:25 elm3b76 kernel:  07 00F 0F  1    1    0   1   0    0    1    61 
Oct 31 09:54:25 elm3b76 kernel:  08 00F 0F  1    1    0   0   0    0    1    69 
Oct 31 09:54:25 elm3b76 kernel:  09 00F 0F  0    0    0   0   0    0    1    71 
Oct 31 09:54:25 elm3b76 kernel:  0a 00F 0F  0    0    0   0   0    0    1    79 
Oct 31 09:54:25 elm3b76 kernel:  0b 00F 0F  1    1    0   1   0    0    1    81 
Oct 31 09:54:25 elm3b76 kernel:  0c 00F 0F  0    0    0   0   0    0    1    89 
Oct 31 09:54:25 elm3b76 kernel:  0d 00F 0F  1    1    0   1   0    0    1    91 
Oct 31 09:54:25 elm3b76 kernel:  0e 00F 0F  0    0    0   0   0    0    1    99 
Oct 31 09:54:25 elm3b76 kernel:  0f 00F 0F  1    1    0   1   0    0    1    A1 
Oct 31 09:54:25 elm3b76 kernel:  10 00F 0F  1    1    0   1   0    0    1    A9 
Oct 31 09:54:25 elm3b76 kernel:  11 00F 0F  1    1    0   1   0    0    1    B1 
Oct 31 09:54:25 elm3b76 kernel:  12 00F 0F  1    1    0   1   0    0    1    B9 
Oct 31 09:54:25 elm3b76 kernel:  13 00F 0F  1    1    0   1   0    0    1    C1 
Oct 31 09:54:25 elm3b76 kernel:  14 00F 0F  1    1    0   1   0    0    1    C9 
Oct 31 09:54:25 elm3b76 kernel:  15 00F 0F  1    1    0   1   0    0    1    D1 
Oct 31 09:54:25 elm3b76 kernel:  16 00F 0F  1    1    0   1   0    0    1    D9 
Oct 31 09:54:25 elm3b76 kernel:  17 00F 0F  1    1    0   1   0    0    1    E1 
Oct 31 09:54:25 elm3b76 kernel:  
Oct 31 09:54:25 elm3b76 kernel: IO APIC #14...... 
Oct 31 09:54:25 elm3b76 kernel: .... register #00: 0E000000 
Oct 31 09:54:25 elm3b76 kernel: .......    : physical APIC id: 0E 
Oct 31 09:54:25 elm3b76 kernel: .... register #01: 00170011 
Oct 31 09:54:25 elm3b76 kernel: .......     : max redirection entries: 0017 
Oct 31 09:54:25 elm3b76 kernel: .......     : IO APIC version: 0011 
Oct 31 09:54:25 elm3b76 kernel: .... register #02: 0C000000 
Oct 31 09:54:25 elm3b76 kernel: .......     : arbitration: 0C 
Oct 31 09:54:25 elm3b76 kernel: .... IRQ redirection table: 
Oct 31 09:54:25 elm3b76 kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:    
Oct 31 09:54:25 elm3b76 kernel:  00 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:26 elm3b76 kernel:  01 00F 0F  1    1    0   1   0    0    1    E9 
Oct 31 09:54:26 elm3b76 kernel:  02 00F 0F  1    1    0   1   0    0    1    32 
Oct 31 09:54:26 elm3b76 kernel:  03 00F 0F  1    1    0   1   0    0    1    3A 
Oct 31 09:54:26 elm3b76 kernel:  04 00F 0F  1    1    0   1   0    0    1    42 
Oct 31 09:54:26 elm3b76 kernel:  05 00F 0F  1    1    0   1   0    0    1    4A 
Oct 31 09:54:26 elm3b76 kernel:  06 00F 0F  1    1    0   1   0    0    1    52 
Oct 31 09:54:26 elm3b76 kernel:  07 00F 0F  1    1    0   1   0    0    1    5A 
Oct 31 09:54:26 elm3b76 kernel:  08 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:26 elm3b76 kernel:  09 00F 0F  1    1    0   1   0    0    1    62 
Oct 31 09:54:26 elm3b76 kernel:  0a 00F 0F  1    1    0   1   0    0    1    6A 
Oct 31 09:54:26 elm3b76 kernel:  0b 00F 0F  1    1    0   1   0    0    1    72 
Oct 31 09:54:26 elm3b76 kernel:  0c 00F 0F  1    1    0   1   0    0    1    7A 
Oct 31 09:54:26 elm3b76 kernel:  0d 00F 0F  1    1    0   1   0    0    1    82 
Oct 31 09:54:26 elm3b76 kernel:  0e 00F 0F  1    1    0   1   0    0    1    8A 
Oct 31 09:54:26 elm3b76 kernel:  0f 00F 0F  1    1    0   1   0    0    1    92 
Oct 31 09:54:26 elm3b76 kernel:  10 00F 0F  1    1    0   1   0    0    1    9A 
Oct 31 09:54:26 elm3b76 kernel:  11 00F 0F  1    1    0   1   0    0    1    A2 
Oct 31 09:54:26 elm3b76 kernel:  12 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:26 elm3b76 kernel:  13 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:26 elm3b76 kernel:  14 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:26 elm3b76 kernel:  15 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:26 elm3b76 kernel:  16 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:26 elm3b76 kernel:  17 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:26 elm3b76 kernel:  
Oct 31 09:54:26 elm3b76 kernel: IO APIC #4...... 
Oct 31 09:54:26 elm3b76 kernel: .... register #00: 04000000 
Oct 31 09:54:26 elm3b76 kernel: .......    : physical APIC id: 04 
Oct 31 09:54:26 elm3b76 kernel: .... register #01: 00170011 
Oct 31 09:54:26 elm3b76 kernel: .......     : max redirection entries: 0017 
Oct 31 09:54:26 elm3b76 kernel: .......     : IO APIC version: 0011 
Oct 31 09:54:26 elm3b76 kernel: .... register #02: 00000000 
Oct 31 09:54:26 elm3b76 kernel: .......     : arbitration: 00 
Oct 31 09:54:26 elm3b76 kernel: .... IRQ redirection table: 
Oct 31 09:54:27 elm3b76 kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:    
Oct 31 09:54:27 elm3b76 kernel:  00 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:27 elm3b76 kernel:  01 00F 0F  0    0    0   0   0    0    1    39 
Oct 31 09:54:27 elm3b76 kernel:  02 00F 0F  0    0    0   0   0    0    1    31 
Oct 31 09:54:27 elm3b76 kernel:  03 00F 0F  0    0    0   0   0    0    1    41 
Oct 31 09:54:27 elm3b76 kernel:  04 00F 0F  0    0    0   0   0    0    1    49 
Oct 31 09:54:27 elm3b76 kernel:  05 00F 0F  0    0    0   0   0    0    1    51 
Oct 31 09:54:27 elm3b76 kernel:  06 00F 0F  0    0    0   0   0    0    1    59 
Oct 31 09:54:27 elm3b76 kernel:  07 00F 0F  1    1    0   1   0    0    1    AA 
Oct 31 09:54:27 elm3b76 kernel:  08 00F 0F  1    1    0   0   0    0    1    69 
Oct 31 09:54:27 elm3b76 kernel:  09 00F 0F  0    0    0   0   0    0    1    71 
Oct 31 09:54:27 elm3b76 kernel:  0a 00F 0F  0    0    0   0   0    0    1    79 
Oct 31 09:54:27 elm3b76 kernel:  0b 00F 0F  1    1    0   1   0    0    1    B2 
Oct 31 09:54:27 elm3b76 kernel:  0c 00F 0F  0    0    0   0   0    0    1    89 
Oct 31 09:54:27 elm3b76 kernel:  0d 00F 0F  1    1    0   1   0    0    1    BA 
Oct 31 09:54:27 elm3b76 kernel:  0e 00F 0F  0    0    0   0   0    0    1    99 
Oct 31 09:54:27 elm3b76 kernel:  0f 00F 0F  1    1    0   1   0    0    1    C2 
Oct 31 09:54:27 elm3b76 kernel:  10 00F 0F  1    1    0   1   0    0    1    CA 
Oct 31 09:54:27 elm3b76 kernel:  11 00F 0F  1    1    0   1   0    0    1    D2 
Oct 31 09:54:27 elm3b76 kernel:  12 00F 0F  1    1    0   1   0    0    1    DA 
Oct 31 09:54:27 elm3b76 kernel:  13 00F 0F  1    1    0   1   0    0    1    E2 
Oct 31 09:54:27 elm3b76 kernel:  14 00F 0F  1    1    0   1   0    0    1    EA 
Oct 31 09:54:27 elm3b76 kernel:  15 00F 0F  1    1    0   1   0    0    1    33 
Oct 31 09:54:27 elm3b76 kernel:  16 00F 0F  1    1    0   1   0    0    1    3B 
Oct 31 09:54:27 elm3b76 kernel:  17 00F 0F  1    1    0   1   0    0    1    43 
Oct 31 09:54:27 elm3b76 kernel:  
Oct 31 09:54:28 elm3b76 kernel: IO APIC #5...... 
Oct 31 09:54:28 elm3b76 kernel: .... register #00: 05000000 
Oct 31 09:54:28 elm3b76 kernel: .......    : physical APIC id: 05 
Oct 31 09:54:28 elm3b76 kernel: .... register #01: 00170011 
Oct 31 09:54:28 elm3b76 kernel: .......     : max redirection entries: 0017 
Oct 31 09:54:28 elm3b76 kernel: .......     : IO APIC version: 0011 
Oct 31 09:54:28 elm3b76 kernel: .... register #02: 07000000 
Oct 31 09:54:28 elm3b76 kernel: .......     : arbitration: 07 
Oct 31 09:54:28 elm3b76 kernel: .... IRQ redirection table: 
Oct 31 09:54:28 elm3b76 kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:    
Oct 31 09:54:28 elm3b76 kernel:  00 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:28 elm3b76 kernel:  01 00F 0F  1    1    0   1   0    0    1    4B 
Oct 31 09:54:28 elm3b76 kernel:  02 00F 0F  1    1    0   1   0    0    1    53 
Oct 31 09:54:28 elm3b76 kernel:  03 00F 0F  1    1    0   1   0    0    1    5B 
Oct 31 09:54:28 elm3b76 kernel:  04 00F 0F  1    1    0   1   0    0    1    63 
Oct 31 09:54:28 elm3b76 kernel:  05 00F 0F  1    1    0   1   0    0    1    6B 
Oct 31 09:54:28 elm3b76 kernel:  06 00F 0F  1    1    0   1   0    0    1    73 
Oct 31 09:54:28 elm3b76 kernel:  07 00F 0F  1    1    0   1   0    0    1    7B 
Oct 31 09:54:28 elm3b76 kernel:  08 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:28 elm3b76 kernel:  09 00F 0F  1    1    0   1   0    0    1    83 
Oct 31 09:54:28 elm3b76 kernel:  0a 00F 0F  1    1    0   1   0    0    1    8B 
Oct 31 09:54:28 elm3b76 kernel:  0b 00F 0F  1    1    0   1   0    0    1    93 
Oct 31 09:54:29 elm3b76 kernel:  0c 00F 0F  1    1    0   1   0    0    1    9B 
Oct 31 09:54:29 elm3b76 kernel:  0d 00F 0F  1    1    0   1   0    0    1    A3 
Oct 31 09:54:29 elm3b76 kernel:  0e 00F 0F  1    1    0   1   0    0    1    AB 
Oct 31 09:54:29 elm3b76 kernel:  0f 00F 0F  1    1    0   1   0    0    1    B3 
Oct 31 09:54:29 elm3b76 kernel:  10 00F 0F  1    1    0   1   0    0    1    BB 
Oct 31 09:54:29 elm3b76 kernel:  11 00F 0F  1    1    0   1   0    0    1    C3 
Oct 31 09:54:29 elm3b76 kernel:  12 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:29 elm3b76 kernel:  13 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:29 elm3b76 kernel:  14 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:29 elm3b76 kernel:  15 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:29 elm3b76 kernel:  16 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:29 elm3b76 kernel:  17 000 00  1    0    0   0   0    0    0    00 
Oct 31 09:54:29 elm3b76 kernel: IRQ to pin mappings: 
Oct 31 09:54:29 elm3b76 kernel: IRQ0 -> 0:2-> 2:2 
Oct 31 09:54:29 elm3b76 kernel: IRQ1 -> 0:1-> 2:1 
Oct 31 09:54:29 elm3b76 kernel: IRQ3 -> 0:3-> 2:3 
Oct 31 09:54:29 elm3b76 kernel: IRQ4 -> 0:4-> 2:4 
Oct 31 09:54:29 elm3b76 kernel: IRQ5 -> 0:5-> 2:5 
Oct 31 09:54:29 elm3b76 kernel: IRQ6 -> 0:6-> 2:6 
Oct 31 09:54:29 elm3b76 kernel: IRQ7 -> 0:7 
Oct 31 09:54:29 elm3b76 kernel: IRQ8 -> 0:8-> 2:8 
Oct 31 09:54:29 elm3b76 kernel: IRQ9 -> 0:9-> 2:9 
Oct 31 09:54:29 elm3b76 kernel: IRQ10 -> 0:10-> 2:10 
Oct 31 09:54:29 elm3b76 kernel: IRQ11 -> 0:11 
Oct 31 09:54:29 elm3b76 kernel: IRQ12 -> 0:12-> 2:12 
Oct 31 09:54:29 elm3b76 kernel: IRQ13 -> 0:13 
Oct 31 09:54:29 elm3b76 kernel: IRQ14 -> 0:14-> 2:14 
Oct 31 09:54:29 elm3b76 kernel: IRQ15 -> 0:15 
Oct 31 09:54:29 elm3b76 kernel: IRQ16 -> 0:16 
Oct 31 09:54:29 elm3b76 kernel: IRQ17 -> 0:17 
Oct 31 09:54:29 elm3b76 kernel: IRQ18 -> 0:18 
Oct 31 09:54:29 elm3b76 kernel: IRQ19 -> 0:19 
Oct 31 09:54:29 elm3b76 kernel: IRQ20 -> 0:20 
Oct 31 09:54:29 elm3b76 kernel: IRQ21 -> 0:21 
Oct 31 09:54:29 elm3b76 kernel: IRQ22 -> 0:22 
Oct 31 09:54:29 elm3b76 kernel: IRQ23 -> 0:23 
Oct 31 09:54:29 elm3b76 kernel: IRQ25 -> 1:1 
Oct 31 09:54:29 elm3b76 kernel: IRQ26 -> 1:2 
Oct 31 09:54:29 elm3b76 kernel: IRQ27 -> 1:3 
Oct 31 09:54:29 elm3b76 kernel: IRQ28 -> 1:4 
Oct 31 09:54:29 elm3b76 kernel: IRQ29 -> 1:5 
Oct 31 09:54:29 elm3b76 kernel: IRQ30 -> 1:6 
Oct 31 09:54:29 elm3b76 kernel: IRQ31 -> 1:7 
Oct 31 09:54:29 elm3b76 kernel: IRQ33 -> 1:9 
Oct 31 09:54:29 elm3b76 kernel: IRQ34 -> 1:10 
Oct 31 09:54:30 elm3b76 kernel: IRQ35 -> 1:11 
Oct 31 09:54:30 elm3b76 kernel: IRQ36 -> 1:12 
Oct 31 09:54:30 elm3b76 kernel: IRQ37 -> 1:13 
Oct 31 09:54:30 elm3b76 kernel: IRQ38 -> 1:14 
Oct 31 09:54:30 elm3b76 kernel: IRQ39 -> 1:15 
Oct 31 09:54:30 elm3b76 kernel: IRQ40 -> 1:16 
Oct 31 09:54:30 elm3b76 kernel: IRQ41 -> 1:17 
Oct 31 09:54:30 elm3b76 kernel: IRQ55 -> 2:7 
Oct 31 09:54:30 elm3b76 kernel: IRQ59 -> 2:11 
Oct 31 09:54:30 elm3b76 kernel: IRQ61 -> 2:13 
Oct 31 09:54:30 elm3b76 kernel: IRQ63 -> 2:15 
Oct 31 09:54:30 elm3b76 kernel: IRQ64 -> 2:16 
Oct 31 09:54:30 elm3b76 kernel: IRQ65 -> 2:17 
Oct 31 09:54:30 elm3b76 kernel: IRQ66 -> 2:18 
Oct 31 09:54:30 elm3b76 kernel: IRQ67 -> 2:19 
Oct 31 09:54:30 elm3b76 kernel: IRQ68 -> 2:20 
Oct 31 09:54:30 elm3b76 kernel: IRQ69 -> 2:21 
Oct 31 09:54:30 elm3b76 kernel: IRQ70 -> 2:22 
Oct 31 09:54:30 elm3b76 kernel: IRQ71 -> 2:23 
Oct 31 09:54:30 elm3b76 kernel: IRQ73 -> 3:1 
Oct 31 09:54:30 elm3b76 kernel: IRQ74 -> 3:2 
Oct 31 09:54:30 elm3b76 kernel: IRQ75 -> 3:3 
Oct 31 09:54:30 elm3b76 kernel: IRQ76 -> 3:4 
Oct 31 09:54:30 elm3b76 kernel: IRQ77 -> 3:5 
Oct 31 09:54:30 elm3b76 kernel: IRQ78 -> 3:6 
Oct 31 09:54:30 elm3b76 kernel: IRQ79 -> 3:7 
Oct 31 09:54:30 elm3b76 kernel: IRQ81 -> 3:9 
Oct 31 09:54:30 elm3b76 kernel: IRQ82 -> 3:10 
Oct 31 09:54:30 elm3b76 kernel: IRQ83 -> 3:11 
Oct 31 09:54:30 elm3b76 kernel: IRQ84 -> 3:12 
Oct 31 09:54:30 elm3b76 kernel: IRQ85 -> 3:13 
Oct 31 09:54:30 elm3b76 kernel: IRQ86 -> 3:14 
Oct 31 09:54:30 elm3b76 kernel: IRQ87 -> 3:15 
Oct 31 09:54:30 elm3b76 kernel: IRQ88 -> 3:16 
Oct 31 09:54:30 elm3b76 kernel: IRQ89 -> 3:17 
Oct 31 09:54:30 elm3b76 kernel: .................................... done. 
Oct 31 09:54:30 elm3b76 kernel: Using local APIC timer interrupts. 
Oct 31 09:54:30 elm3b76 kernel: calibrating APIC timer ... 
Oct 31 09:54:30 elm3b76 kernel: ..... CPU clock speed is 495.0917 MHz. 
Oct 31 09:54:31 elm3b76 kernel: ..... host bus clock speed is 90.0164 MHz. 
Oct 31 09:54:31 elm3b76 kernel: cpu: 0, clocks: 900164, slice: 100018 
Oct 31 09:54:31 elm3b76 kernel: CPU0<T0:900160,T1:800128,D:14,S:100018,C:900164> 
Oct 31 09:54:31 elm3b76 kernel: cpu: 1, clocks: 900164, slice: 100018 
Oct 31 09:54:31 elm3b76 kernel: cpu: 2, clocks: 900164, slice: 100018 
Oct 31 09:54:31 elm3b76 kernel: cpu: 3, clocks: 900164, slice: 100018 
Oct 31 09:54:31 elm3b76 kernel: cpu: 5, clocks: 900164, slice: 100018 
Oct 31 09:54:31 elm3b76 kernel: cpu: 6, clocks: 900164, slice: 100018 
Oct 31 09:54:31 elm3b76 kernel: cpu: 7, clocks: 900164, slice: 100018 
Oct 31 09:54:31 elm3b76 kernel: cpu: 4, clocks: 900164, slice: 100018 
Oct 31 09:54:31 elm3b76 kernel: CPU2<T0:900160,T1:600096,D:10,S:100018,C:900164> 
Oct 31 09:54:31 elm3b76 kernel: CPU3<T0:900160,T1:500080,D:8,S:100018,C:900164> 
Oct 31 09:54:31 elm3b76 kernel: CPU5<T0:900160,T1:300048,D:4,S:100018,C:900164> 
Oct 31 09:54:31 elm3b76 kernel: CPU7<T0:900160,T1:100016,D:0,S:100018,C:900164> 
Oct 31 09:54:31 elm3b76 kernel: CPU4<T0:900160,T1:400064,D:6,S:100018,C:900164> 
Oct 31 09:54:31 elm3b76 kernel: CPU6<T0:900160,T1:200032,D:2,S:100018,C:900164> 
Oct 31 09:54:31 elm3b76 kernel: CPU1<T0:900160,T1:700112,D:12,S:100018,C:900164> 
Oct 31 09:54:31 elm3b76 kernel: checking TSC synchronization across CPUs:  
Oct 31 09:54:31 elm3b76 kernel: BIOS BUG: CPU#0 improperly initialized, has 72087 usecs TSC skew! FIXED. 
Oct 31 09:54:31 elm3b76 kernel: BIOS BUG: CPU#1 improperly initialized, has 72088 usecs TSC skew! FIXED. 
Oct 31 09:54:31 elm3b76 kernel: BIOS BUG: CPU#2 improperly initialized, has 72087 usecs TSC skew! FIXED. 
Oct 31 09:54:31 elm3b76 kernel: BIOS BUG: CPU#3 improperly initialized, has 72088 usecs TSC skew! FIXED. 
Oct 31 09:54:31 elm3b76 kernel: BIOS BUG: CPU#4 improperly initialized, has -72086 usecs TSC skew! FIXED. 
Oct 31 09:54:31 elm3b76 kernel: BIOS BUG: CPU#5 improperly initialized, has -72086 usecs TSC skew! FIXED. 
Oct 31 09:54:31 elm3b76 kernel: BIOS BUG: CPU#6 improperly initialized, has -72087 usecs TSC skew! FIXED. 
Oct 31 09:54:31 elm3b76 kernel: BIOS BUG: CPU#7 improperly initialized, has -72090 usecs TSC skew! FIXED. 
Oct 31 09:54:31 elm3b76 kernel: Waiting on wait_init_idle (map = 0xfe) 
Oct 31 09:54:31 elm3b76 kernel: All processors have done init_idle 
Oct 31 09:54:32 elm3b76 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd231, last bus=2 
Oct 31 09:54:32 elm3b76 kernel: PCI: Using configuration type 1 
Oct 31 09:54:32 elm3b76 kernel: PCI: Probing PCI hardware 
Oct 31 09:54:32 elm3b76 kernel: PCI: Searching for i450NX host bridges on 00:10.0 
Oct 31 09:54:32 elm3b76 kernel: Unknown bridge resource 2: assuming transparent 
Oct 31 09:54:32 elm3b76 kernel: PCI->APIC IRQ transform: (B0,I10,P0) -> 23 
Oct 31 09:54:32 elm3b76 kernel: PCI: using PPB(B1,I12,P0) to get irq 40 
Oct 31 09:54:32 elm3b76 kernel: PCI->APIC IRQ transform: (B2,I4,P0) -> 40 
Oct 31 09:54:32 elm3b76 kernel: PCI: using PPB(B1,I12,P1) to get irq 39 
Oct 31 09:54:32 elm3b76 kernel: PCI->APIC IRQ transform: (B2,I5,P1) -> 39 
Oct 31 09:54:32 elm3b76 kernel: PCI: using PPB(B1,I12,P2) to get irq 38 
Oct 31 09:54:32 elm3b76 kernel: PCI->APIC IRQ transform: (B2,I6,P2) -> 38 
Oct 31 09:54:32 elm3b76 kernel: PCI: using PPB(B1,I12,P3) to get irq 37 
Oct 31 09:54:32 elm3b76 kernel: PCI->APIC IRQ transform: (B2,I7,P3) -> 37 
Oct 31 09:54:32 elm3b76 kernel: Linux NET4.0 for Linux 2.4 
Oct 31 09:54:32 elm3b76 kernel: Based upon Swansea University Computer Society NET3.039 
Oct 31 09:54:32 elm3b76 kernel: Starting kswapd 
Oct 31 09:54:32 elm3b76 kernel: pty: 256 Unix98 ptys configured 
Oct 31 09:54:32 elm3b76 kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled 
Oct 31 09:54:32 elm3b76 kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A 
Oct 31 09:54:32 elm3b76 kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A 
Oct 31 09:54:32 elm3b76 kernel: block: 128 slots per queue, batch=16 
Oct 31 09:54:32 elm3b76 kernel: starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com> 
Oct 31 09:54:32 elm3b76 kernel:  (unofficial 2.2/2.4 kernel port, version 1.03+LK1.3.4, August 14, 2001) 
Oct 31 09:54:32 elm3b76 kernel: eth0: Adaptec Starfire 6915 at 0xf8841000, 00:00:d1:ed:d0:79, IRQ 40. 
Oct 31 09:54:33 elm3b76 kernel: eth0: MII PHY found at address 1, status 0x7809 advertising 01e1. 
Oct 31 09:54:33 elm3b76 kernel: eth0: scatter-gather and hardware TCP cksumming disabled. 
Oct 31 09:54:33 elm3b76 kernel: eth1: Adaptec Starfire 6915 at 0xf88c2000, 00:00:d1:ed:d0:7a, IRQ 39. 
Oct 31 09:54:33 elm3b76 kernel: eth1: MII PHY found at address 1, status 0x7809 advertising 01e1. 
Oct 31 09:54:33 elm3b76 kernel: eth1: scatter-gather and hardware TCP cksumming disabled. 
Oct 31 09:54:33 elm3b76 kernel: eth2: Adaptec Starfire 6915 at 0xf8943000, 00:00:d1:ed:d0:7b, IRQ 38. 
Oct 31 09:54:33 elm3b76 kernel: eth2: MII PHY found at address 1, status 0x7809 advertising 01e1. 
Oct 31 09:54:33 elm3b76 kernel: eth2: scatter-gather and hardware TCP cksumming disabled. 
Oct 31 09:54:33 elm3b76 kernel: eth3: Adaptec Starfire 6915 at 0xf89c4000, 00:00:d1:ed:d0:7c, IRQ 37. 
Oct 31 09:54:33 elm3b76 kernel: eth3: MII PHY found at address 1, status 0x7809 advertising 01e1. 
Oct 31 09:54:33 elm3b76 kernel: eth3: scatter-gather and hardware TCP cksumming disabled. 
Oct 31 09:54:33 elm3b76 kernel: SCSI subsystem driver Revision: 1.00 
Oct 31 09:54:33 elm3b76 kernel: qlogicisp : new isp1020 revision ID (5) 
Oct 31 09:54:33 elm3b76 kernel: scsi0 : QLogic ISP1020 SCSI on PCI bus 00 device 50 irq 23 MEM base 0xf8a45000 
Oct 31 09:54:33 elm3b76 kernel:   Vendor: IBM       Model: DGHS18X           Rev: 0360 
Oct 31 09:54:33 elm3b76 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03 
Oct 31 09:54:33 elm3b76 kernel:   Vendor: IBM       Model: DGHS18X           Rev: 0360 
Oct 31 09:54:33 elm3b76 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03 
Oct 31 09:54:33 elm3b76 kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0 
Oct 31 09:54:33 elm3b76 kernel: Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0 
Oct 31 09:54:33 elm3b76 kernel: SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB) 
Oct 31 09:54:33 elm3b76 kernel: Partition check: 
Oct 31 09:54:33 elm3b76 kernel:  sda: sda1 sda2 sda3 
Oct 31 09:54:33 elm3b76 kernel: SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB) 
Oct 31 09:54:33 elm3b76 kernel:  sdb: unknown partition table 
Oct 31 09:54:33 elm3b76 kernel: NET4: Linux TCP/IP 1.0 for NET4.0 
Oct 31 09:54:33 elm3b76 kernel: IP Protocols: ICMP, UDP, TCP 
Oct 31 09:54:34 elm3b76 kernel: IP: routing cache hash table of 8192 buckets, 64Kbytes 
Oct 31 09:54:34 elm3b76 kernel: TCP: Hash tables configured (established 262144 bind 65536) 
Oct 31 09:54:34 elm3b76 kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0. 
Oct 31 09:54:34 elm3b76 kernel: VFS: Mounted root (ext2 filesystem) readonly. 
Oct 31 09:54:34 elm3b76 kernel: Freeing unused kernel memory: 196k freed 
Oct 31 09:54:34 elm3b76 kernel: Adding Swap: 2048276k swap-space (priority -1) 
Oct 31 09:54:34 elm3b76 kernel: eth0: Link is down 
Oct 31 09:54:34 elm3b76 kernel: eth0: Link is up, running at 100Mbit full-duplex 

