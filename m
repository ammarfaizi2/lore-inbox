Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131624AbQKYSsu>; Sat, 25 Nov 2000 13:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131600AbQKYSsa>; Sat, 25 Nov 2000 13:48:30 -0500
Received: from sneaker.sch.bme.hu ([152.66.226.5]:24082 "EHLO
        sneaker.sch.bme.hu") by vger.kernel.org with ESMTP
        id <S131430AbQKYSsZ>; Sat, 25 Nov 2000 13:48:25 -0500
Date: Sat, 25 Nov 2000 19:18:22 +0100 (CET)
From: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
Reply-To: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: crashing kernels
Message-ID: <Pine.LNX.3.96.1001124183828.385A-100000@sneaker.sch.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.]
Kernels 2.2.14, 2.2.17, 2.4.0-test11 crash with various errors
(I know this is too simple, but this is what I could say in one line)

[2.]
We're running a quite bussy site, and updateing our servers hardware quite
often. Since a while ago we're expecting many troubles, that usually end
with crash (that means, we need to press the hw-reset to reboot).

We've run the kernel 2.2.14 for a long while, but after replacing the
mainboard, and the ethernet cards the module eepro100 (wich actually
benn compiled into the kernel, and not as a module) always gave the
errors:

eth0: Transmit timed out: status 0050  0090 at 134704418/134704432 
eth0: Trying to restart the transmitter...

In these cases we couldn't do anything than restarting the system
(yeah, I know is a quite window$ solution, but ifconfig eth0 down/up
didn't help neither) by pressing ctrl-alt-del. This problem occoured
almost every day once.

Ok, we thought maybe the driver isn't correct yet, and whenever we were a
little out-of-date with the kernel 2.2.14, so we decided to try a newer
one, first the 2.2.16. This kernel didn't last long, because it also
crashed with error like:
Oct  1 23:09:17 luna kernel: eth0: can't fill rx buffer (force 1)!
Oct  1 23:09:17 luna kernel: eth0: Tx ring dump,  Tx queue 6270428 /
6270428:
Oct  1 23:09:17 luna kernel: eth0:     0 200ca000.
Oct  1 23:09:17 luna kernel: eth0:     1 000ca000.
Oct  1 23:09:17 luna kernel: eth0:     2 000ca000.
Oct  1 23:09:17 luna kernel: eth0:     3 000ca000.
Oct  1 23:09:17 luna kernel: eth0:     4 000ca000.
Oct  1 23:09:17 luna kernel: eth0:     5 000ca000.
Oct  1 23:09:17 luna kernel: eth0:     6 000ca000.
Oct  1 23:09:17 luna kernel: eth0:     7 000ca000.
Oct  1 23:09:17 luna kernel: eth0:     8 200ca000.
Oct  1 23:09:17 luna kernel: eth0:     9 000ca000.
Oct  1 23:09:17 luna kernel: eth0:    10 000ca000.
Oct  1 23:09:17 luna kernel: eth0: Printing Rx ring (next to receive into
427603
9, dirty index 4

 but in these cases there wasn't any possibility for a clean reboot. We
don't like much the fsck, so let's try the 2.2.17. Also the same troubles,
like above. We also tried to increase the TX_RING_SIZE, and RX_RING_SIZE
values, but this dind't help neither.

We got the informations, that these Intel Ether Express Pro cards have
some bugs, so we got another driver from the Intel, called e100, and
decided to go back to the good old 2.2.14 Kernel, and tried this module.
Wow, new type of error messages:

kernel: e100 - Intel(R) 82559 Fast Ethernet LAN on Motherboard 
kernel: eth0:  Mem:0xf4102000  IRQ:21  Speed:100 Mbps Dx:Full
kernel: Hardware receive checksums enabled
...
kernel: eth0: rx_srv: no buffers left!!!

Ok, the modul supported to change the buffer sizes, we tried to increase
them, but didn't help.

After some askabout we decided to throw out the EtherExpress Pro's, and to
change to something, that other people use. We couldn't do that totally,
because on of these cards is integrated to the mainboard, so we couldn't
get rid of that.

We also needed to do some changes (change the Mylex card to a Mylex
AcceleRAID 352) so we changed one of the EtherExpresses to a 3Com Tornado
at the same time. Like the kernel sais, it's a:
kernel: eth0: 3Com 3c905C Tornado at 0x2800, 00:01:02:b7:94:4b, IRQ 18
kernel:   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
kernel:   MII transceiver found at address 24, status 782d.
kernel:   Enabling bus-master transmits and whole-frame receives.

We needed to change to the kernel 2.2.17 again, because this is the
onlyone that supports the Mylex 352.

This was the point where everything went down. We have 1Gb ram in the
computer, but sometimes we run out to the swap. This usually lead to a
server crash: you had a ping, but none of the ports answared. On the
console, and in the kern.log we got these kind of errors:
Nov 20 01:06:47 luna kernel: VM: do_try_to_free_pages failed for apache...
You could change the console, but nothing gave a reply. Such things
happened before with other kernels, but there we simply pulled down the
ethernet, the apache processes exited after some mins, and I could log in
to the console. But with the 2.2.17 it doesn't help anymore, only thing
could do: reset :( Then of course 2-3 hours of fsck... nice...
We tried to increase the amount of swap. (originally we had just 256MB, we
increased this to 1.7GB) Same shit happened again, and usually really
fast: often while I've been working on the computer once my ssh stoped,
and by then was too late...
I've checked the kernel source, and saw that the vmscan.c was changed
since the 2.2.14 until the 2.2.17. Ok, maybe the author made some
mistake... But we couldn't go back to oldier kernels (because of the Mylex
card) so the only possibility is to go forward: we compiled the
2.4.0-test11 kernel. It could be usefull also because of the khttpd, at
least we could free up some memory used by the apache.

The kernel compiled and the system booted up. The first three-four hours
were without errors, it also seemed to be a little faster. When the number
of the apaches begun to grow,  I've decided to try the khttpd. I've
configured it, and started up at the port 8090 (8080's been used by
another apache). Coll it worked. I've Redirected some of the queryes from
the apache to the khttpd. This worked fine too. Well after a while it's
been a little slow (on the fast localnet it took also like 3-4 seconds
until the port got opened) but it was working, and the memory usage went
down. The only scary thing was, that the ping of the server got worst, the
packet lost was growing since I've used the khttpd. Ok I thought it's not
so bad, the next day I'll see the statistics and decide wether to use the
khttpd or not, now I could go to sleep... Of course at the night the whole
thing crashed: black screen, no console, no keyboard leds, nothing, just
hardware reset and fsck. 
I thought that the khttpd is guilty, I won't use it anymore. Next morning
it crashed again, now without khttpd, without high load, without high
memory usage, just the 3Com driver said:
kernel: eth0: Interrupt posted but not delivered -- IRQ blocked by another
device?
kernel:   Flags; bus-master 1, full 0; dirty 112(0) current 112(0).
kernel:   Transmit list 00000000 vs. f20ac200.
kernel:   0: @f20ac200  length 80000036 status 00010036
kernel:   1: @f20ac210  length 80000182 status 00010182
kernel:   2: @f20ac220  length 80000036 status 00010036
kernel:   3: @f20ac230  length 8000004a status 0001004a
kernel:   4: @f20ac240  length 80000337 status 00010337
kernel:   5: @f20ac250  length 80000036 status 00010036
kernel:   6: @f20ac260  length 800005ea status 000105ea
kernel:   7: @f20ac270  length 800005d3 status 000105d3
kernel:   8: @f20ac280  length 80000042 status 00010042
kernel:   9: @f20ac290  length 800005ea status 000105ea
kernel:   10: @f20ac2a0  length 800005e2 status 000105e2
kernel:   11: @f20ac2b0  length 800005ea status 000105ea
kernel:   12: @f20ac2c0  length 800005ea status 000105ea
kernel:   13: @f20ac2d0  length 8000024e status 0001024e
kernel:   14: @f20ac2e0  length 800005ea status 800105ea
kernel:   15: @f20ac2f0  length 80000042 status 80010042
luna kernel: eth0: Resetting the Tx ring pointer.

This wasn't quite bad, rmmod, insmod helped. Some hours later again the
black crash - but no high load again. In the afternoon crash again. In the
nights again... etc...

We tried almost everything with the hw:
changed the network cards,
changed the mainboard,
changed the mylex card,
currently we're on our work to change the memory, but it isn't easy to
find another 1Gb, this hour in the weekend...

[3.]
kernel, eepro100, e100, khttpd

[4.]
[5.]
-

[6.]
We tryied to trigger always the problems, but couldn't find any :(

[7.]
[7.1]
Software (the 2.4.0 kernel)
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux luna 2.4.0-test11 #2 SMP Thu Nov 23 16:27:38 CET 2000 i686 unknown
Kernel modules         2.3.11
Gnu C                  2.95.2
Gnu Make               3.79
Binutils               2.9.5.0.46
Linux C Library        2.1.95
Dynamic linker         ldd (GNU libc) 2.1.95
Procps                 2.0.6
Mount                  2.10f
Net-tools              2.05
Kbd                    0.99
Sh-utils               2.0i
Modules Loaded         eepro100 3c59x

[7.2]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 1
cpu MHz         : 596.000928
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1189.48

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 1
cpu MHz         : 596.000928
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1192.76

[7.3]
modules:
eepro100               17076   1
3c59x                  22900   1

[7.4]
Scsi:
Attached devices: none
(usually... somtimes one hard drive, but we removed it since we're
experiencing the problems)
[7.5]
/proc/meminfo:
total:    used:    free:  shared: buffers:  cached:
Mem:  1053315072 1049874432  3440640        0 20615168 566947840
Swap: 1784807424        0 1784807424
MemTotal:      1028628 kB
MemFree:          3360 kB
MemShared:           0 kB
Buffers:         20132 kB
Cached:         553660 kB
Active:         263572 kB
Inact_dirty:    302560 kB
Inact_clean:      7660 kB
Inact_target:     6296 kB
HighTotal:      131008 kB
HighFree:         1484 kB
LowTotal:       897620 kB
LowFree:          1876 kB
SwapTotal:     1742976 kB
SwapFree:      1742976 kB

/proc/partitions:
major minor  #blocks  name

   3     0   40020624 hda
   3     1    2048256 hda1
   3     2     498015 hda2
   3     3     498015 hda3
   3     4          1 hda4
   3     5     497983 hda5
  48     0  143302656 rd/c0d0
  48     1    5124703 rd/c0d0p1
  48     2    5124735 rd/c0d0p2
  48     3  133050330 rd/c0d0p3
  48     8  143441920 rd/c0d1
  48     9    2000061 rd/c0d1p1
  48    10    2996122 rd/c0d1p2
  48    11     249007 rd/c0d1p3
  48    12          1 rd/c0d1p4
  48    13     995998 rd/c0d1p5
  48    14  137195068 rd/c0d1p6

/proc/swaps:
Filename                        Type            Size    Used    Priority
/dev/rd/c0d1p3                  partition       248996  0       100
/dev/hda2                       partition       498004  0       3
/dev/hda3                       partition       498004  0       2
/dev/hda5                       partition       497972  0       1

/proc/rd/c0/initial_status:
***** DAC960 RAID Driver Version 2.4.8 of 19 August 2000 *****
Copyright 1998-2000 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring Mylex AcceleRAID 352 PCI RAID Controller
  Firmware Version: 6.00-01, Channels: 2, Memory Size: 32MB
  PCI Bus: 0, Device: 13, Function: 1, I/O Address: Unassigned
  PCI Address: 0xF4106000 mapped at 0xF8800000, IRQ Channel: 17
  Controller Queue Depth: 512, Maximum Blocks per Command: 2048
  Driver Queue Depth: 511, Scatter/Gather Limit: 128 of 257 Segments
  Physical Devices:
    0:0  Vendor: QUANTUM   Model: ATLAS_V_36_SCA    Revision: 0200
         Wide Synchronous at 80 MB/sec
         Serial Number: 143009450931
         Disk Status: Online, 71720960 blocks
         Errors - Parity: 0, Soft: 0, Hard: 0, Misc: 1
                  Timeouts: 0, Retries: 0, Aborts: 0, Predicted: 0
    0:1  Vendor: QUANTUM   Model: ATLAS_V_36_SCA    Revision: 0200
         Wide Synchronous at 80 MB/sec
         Serial Number: 143009354185
         Disk Status: Online, 71720960 blocks
         Errors - Parity: 0, Soft: 0, Hard: 0, Misc: 1
                  Timeouts: 0, Retries: 0, Aborts: 0, Predicted: 0
    0:2  Vendor: QUANTUM   Model: ATLAS_V_36_SCA    Revision: 0200
         Wide Synchronous at 80 MB/sec
         Serial Number: 143009452126
         Disk Status: Online, 71720960 blocks
         Errors - Parity: 0, Soft: 0, Hard: 0, Misc: 1
                  Timeouts: 0, Retries: 0, Aborts: 0, Predicted: 0
    0:3  Vendor: QUANTUM   Model: ATLAS_V_36_SCA    Revision: 0200
         Wide Synchronous at 80 MB/sec
         Serial Number: 143009355037
         Disk Status: Online, 71720960 blocks
         Errors - Parity: 0, Soft: 0, Hard: 0, Misc: 1
                  Timeouts: 0, Retries: 0, Aborts: 0, Predicted: 0
    0:4  Vendor: QUANTUM   Model: ATLAS_V_36_SCA    Revision: 0200
         Wide Synchronous at 80 MB/sec
         Serial Number: 143009451877
         Disk Status: Online, 71720960 blocks
         Errors - Parity: 0, Soft: 0, Hard: 0, Misc: 1
                  Timeouts: 0, Retries: 0, Aborts: 0, Predicted: 0
    0:6  Vendor: ESG-SHV   Model: SCA HSBP M13      Revision: 0.02
         Asynchronous
    0:7  Vendor: MYLEX     Model: AcceleRAID 352    Revision: 0600
         Wide Synchronous at 160 MB/sec
         Serial Number:   
    1:0  Vendor: IBM       Model: DDYS-T36950M      Revision: S80D
         Wide Synchronous at 40 MB/sec
         Serial Number:         5FL8X278
         Disk Status: Online, 71651328 blocks
         Errors - Parity: 0, Soft: 0, Hard: 0, Misc: 1
                  Timeouts: 0, Retries: 0, Aborts: 0, Predicted: 0
    1:1  Vendor: QUANTUM   Model: ATLAS_V_36_SCA    Revision: 0230
         Wide Synchronous at 40 MB/sec
         Serial Number: 143026950130
         Disk Status: Online, 71688192 blocks
         Errors - Parity: 0, Soft: 0, Hard: 0, Misc: 1
                  Timeouts: 0, Retries: 0, Aborts: 0, Predicted: 0
    1:2  Vendor: IBM       Model: DDYS-T36950M      Revision: S80D
         Wide Synchronous at 40 MB/sec
         Serial Number:         5FL8Y122
         Disk Status: Online, 71651328 blocks
         Errors - Parity: 0, Soft: 0, Hard: 0, Misc: 1
                  Timeouts: 0, Retries: 0, Aborts: 0, Predicted: 0
    1:3  Vendor: IBM       Model: DDYS-T36950M      Revision: S80D
         Wide Synchronous at 40 MB/sec
         Serial Number:         5FL8R057
         Disk Status: Online, 71651328 blocks
         Errors - Parity: 0, Soft: 0, Hard: 0, Misc: 1
                  Timeouts: 0, Retries: 0, Aborts: 0, Predicted: 0
    1:4  Vendor: IBM       Model: DDYS-T36950M      Revision: S80D
         Wide Synchronous at 40 MB/sec
         Serial Number:         5FL8P717
         Disk Status: Online, 71651328 blocks
         Errors - Parity: 0, Soft: 0, Hard: 0, Misc: 1
                  Timeouts: 0, Retries: 0, Aborts: 0, Predicted: 0
    1:6  Vendor: ESG-SHV   Model: SCA HSBP M13      Revision: 0.02
         Asynchronous
    1:7  Vendor: MYLEX     Model: AcceleRAID 352    Revision: 0600
         Wide Synchronous at 160 MB/sec
         Serial Number:   
  Logical Drives:
    /dev/rd/c0d0: RAID-5, Online, 286605312 blocks
                  Logical Device Initialized, BIOS Geometry: 255/63
                  Stripe Size: 64KB, Segment Size: 8KB
                  Read Cache Disabled, Write Cache Disabled
    /dev/rd/c0d1: RAID-5, Online, 286883840 blocks
                  Logical Device Initialized, BIOS Geometry: 255/63
                  Stripe Size: 64KB, Segment Size: 8KB
                  Read Cache Disabled, Write Cache Disabled



[8.]
Our server is used mainly as a web server. It has a heave load, and
because of this we needed to do some little modifications:
at the /etc/initscript we we did a ulimit -u 2048 so that the users could
have more than 256 processes. This was inportant for the apache, currently
the 1100 paralell apache processes aren't enough sometimes neither.
Also for this we had to change at the include/linux/tasks.h the NR_TASKS
to 2048 and the MAX_TASKS_PER_USER to NR_TASKS-512 (note: this
second one didn't help, to have more processes per user just the ulimit)
Because sometimes the kernel ran out of the open files, we also increase
at the boot time the file-max, inode-max and the super-max at
the /proc/sys/fs directory.
These modifications may seem weird at the first look, but don't forget,
that we have a plenty of ram, and the CPU usage stays usually around
30-40% even at the highest load (ok, just in case we don't need to use
the swap, but we try to avoid that when is possible)

[9.]
Ok I know this is a quite long for a bug report, but I hope it helps more
to find the problem if I tell everything since the begin. Please don't say
solutions like: use another computer too, split up your system, etc,
because we're working on that too. Any other ideas, hints, questions
are welcome. The main problem is that the computer crashes every 3-4
hours, and in the last days it spent more time on the fsck than on
working.

If You need some more detailed help, log files, etc, I'd be happy for
help.

Thanx in advantage

Attila Nagy

+--------------------------------------------+
| Attila Nagy                                |
|   mailto:mrbig@sneaker.sch.bme.hu          |
+--------------------------------------------+



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
