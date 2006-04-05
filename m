Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWDENyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWDENyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 09:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWDENyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 09:54:46 -0400
Received: from mailserv.trstone.com ([12.109.59.11]:34273 "EHLO
	mailserv.trstone.com") by vger.kernel.org with ESMTP
	id S1750717AbWDENyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 09:54:45 -0400
Message-ID: <4433CC15.3070200@rosettastone.com>
Date: Wed, 05 Apr 2006 14:54:29 +0100
From: Brian Uhrain <buhrain@rosettastone.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060302)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: rth@twiddle.net, Alan Cox <alan@redhat.com>
Subject: PATCH: [Fwd: PROBLEM:  Kernel 2.6.16 fails to boot on API CS20]
Content-Type: multipart/mixed;
 boundary="------------090103010202040107000501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090103010202040107000501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

About two weeks ago I sent Richard Henderson the attached email 
detailing a problem with the 2.6.16 kernel booting on my dual processor 
Alpha system.  Today I was able to track down the problem to the call to 
  topology_cpu_callback() in drivers/base/topology.c--specifically, in 
that function the call to get_cpu_sysdev() is returning NULL.  I have 
tracked down the reason and created a small patch that solves the 
problem on my system.  Basically for the Alpha architecture, 
register_cpu is never being called, so get_cpu_sysdev() has nothing to 
return.  Using ppc_init() in arch/ppc/kernel/setup.c, I created a 
similiar function for the Alpha architecture that just registers the CPU 
devices.  Attached are two versions of the patch: one against 2.6.16.1 
and the other against 2.6.17-rc1.

Regards,
Brian Uhrain

--------------090103010202040107000501
Content-Type: text/plain;
 name="alpha-cpu-fix-2.6.16.1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alpha-cpu-fix-2.6.16.1.patch"

--- linux-2.6.16.1/arch/alpha/kernel/setup.c.old	2006-04-05 13:01:38.585051580 +0100
+++ linux-2.6.16.1/arch/alpha/kernel/setup.c	2006-04-05 13:02:24.412099456 +0100
@@ -24,6 +24,7 @@
 #include <linux/config.h>	/* CONFIG_ALPHA_LCA etc */
 #include <linux/mc146818rtc.h>
 #include <linux/console.h>
+#include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/string.h>
@@ -477,6 +478,22 @@
 #undef PFN_PHYS
 #undef PFN_MAX
 
+static struct cpu cpu_devices[NR_CPUS];
+
+int __init alpha_init(void)
+{
+	int i;
+
+	/* register CPU devices */
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i))
+			register_cpu(&cpu_devices[i], i, NULL);
+
+	return 0;
+}
+
+arch_initcall(alpha_init);
+
 void __init
 setup_arch(char **cmdline_p)
 {

--------------090103010202040107000501
Content-Type: text/plain;
 name="alpha-cpu-fix-2.6.17-rc1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alpha-cpu-fix-2.6.17-rc1.patch"

--- linux-2.6.17-rc1/arch/alpha/kernel/setup.c.old	2006-04-05 12:52:25.636715545 +0100
+++ linux-2.6.17-rc1/arch/alpha/kernel/setup.c	2006-04-05 12:53:01.645504167 +0100
@@ -24,6 +24,7 @@
 #include <linux/config.h>	/* CONFIG_ALPHA_LCA etc */
 #include <linux/mc146818rtc.h>
 #include <linux/console.h>
+#include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/string.h>
@@ -471,6 +472,21 @@
 	return 0;
 }
 
+static struct cpu cpu_devices[NR_CPUS];
+
+int __init alpha_init(void)
+{
+	int i;
+
+	/* register CPU devices */
+	for_each_possible_cpu(i)
+		register_cpu(&cpu_devices[i], i, NULL);
+
+	return 0;
+}
+
+arch_initcall(alpha_init);
+
 void __init
 setup_arch(char **cmdline_p)
 {

--------------090103010202040107000501
Content-Type: message/rfc822;
 name="PROBLEM:  Kernel 2.6.16 fails to boot on API CS20"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PROBLEM:  Kernel 2.6.16 fails to boot on API CS20"

Message-ID: <441FDA80.7000507@rosettastone.com>
Date: Tue, 21 Mar 2006 10:50:40 +0000
From: Brian Uhrain <buhrain@rosettastone.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060302)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rth@twiddle.net
Subject: PROBLEM:  Kernel 2.6.16 fails to boot on API CS20
Content-Type: multipart/mixed;
 boundary="------------040203080003010208080108"

This is a multi-part message in MIME format.
--------------040203080003010208080108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

When trying to boot a 2.6.16 kernel (kernel.org sources with the only 
patch being for Reiser4 FS support), the kernel dies on bootup on my 
dual-processor Alpha system, with the error "Unable to handle kernel 
paging request at virtual address 0000000000000058".  The system is an 
API CS20 with 2 833MHz 21264b processors and 1 GB of RAM (8 x 128 MB). I 
have attached all of the output from the serial console, including the 
error message, along with a gzipped version of the .config used to 
compile the kernel and the output of "lspci -vvv".  Looking at the 
kernel output prior to the kernel panic, I noticed it only activated one 
processor even though it probed two.

Here is the output of the ver_linux script:

mantheren:/usr/src/linux-2.6.16# sh ./scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux mantheren 2.6.15.6-mantheren #1 SMP Tue Mar 7 09:03:30 GMT 2006 
alpha unknown unknown GNU/Linux

Gnu C                  4.1.0
Gnu make               3.80
binutils               2.16.91.0.7
util-linux             2.13-pre7
mount                  2.13-pre7
module-init-tools      3.3-pre1
e2fsprogs              1.38
reiserfsprogs          3.6.19
reiser4progs           1.0.5
xfsprogs               2.7.3
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Kbd                    83:
Sh-utils               5.2.1
udev                   087
Modules Loaded         alim15x3 snd_usb_audio sg snd_pcm snd_timer 
snd_page_alloc generic snd_usb_lib snd_rawmidi snd_hwdep snd sr_mod 
cdrom ide_core soundcore e100 mii i2c_ali1535 i2c_ali15x3 zd1211 i2c_dev 
i2c_core


And of /proc/cpuinfo:
cpu                     : Alpha
cpu model               : EV68AL
cpu variation           : 7
cpu revision            : 0
cpu serial number       :
system type             : Tsunami
system variation        : Clipper
system revision         : 0
system serial number    :
cycle frequency [Hz]    : 833333333
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 44
max. addr. space #      : 255
BogoMIPS                : 1657.40
kernel unaligned acc    : 963348 (pc=fffffc0000447340,va=fffffc003f8ddff2)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : API CS20D 833 MHz
cpus detected           : 2
cpus active             : 2
cpu active mask         : 0000000000000003
L1 Icache               : 64K, 2-way, 64b line
L1 Dcache               : 64K, 2-way, 64b line
L2 cache                : 4096K, 1-way, 64b line
L3 cache                : n/a

If you need any other information or would like me to test anything, 
please let me know.

Regards,
Brian Uhrain

P.S.  The system is running a home-brew "distro" with everything 
compiled from scratch, and running a 2.6.15.6 kernel it has not given 
any problems even through recompiles of all of the installed software 
(glibc through firefox).

--------------040203080003010208080108
Content-Type: text/plain;
 name="alpha-crash.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alpha-crash.txt"

aboot> 2
aboot: loading compressed vmlinux-custom.gz...
aboot: zero-filling 132648 bytes at 0xfffffc0000764710
aboot: starting kernel vmlinux-custom.gz with arguments root=/dev/sda2 console=ttyS0 console=tty0
Linux version 2.6.16-mantheren (root@mantheren) (gcc version 4.1.0) #1 SMP Mon Mar 20 23:11:35 GMT 6
Booting on Tsunami variation Clipper using machine vector Clipper from SRM
Major Options: SMP EV67 LEGACY_START VERBOSE_MCHECK MAGIC_SYSRQ
Command line: root=/dev/sda2 console=ttyS0 console=tty0
memcluster 0, usage 1, start        0, end      256
memcluster 1, usage 0, start      256, end   130981
memcluster 2, usage 1, start   130981, end   131072
freeing pages 256:384
freeing pages 965:130981
reserving pages 965:967
4096K Bcache detected; load hit latency 18 cycles, load miss latency 164 cycles
SMP: 2 CPUs probed -- cpu_present_mask = 1
Built 1 zonelists
Kernel command line: root=/dev/sda2 console=ttyS0 console=tty0
PID hash table entries: 4096 (order: 12, 131072 bytes)
Using epoch = 2000
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
Memory: 1027944k/1047848k available (3258k kernel code, 17200k reserved, 395k data, 144k init)
Mount-cache hash table entries: 512
SMP starting up secondaries.
Brought up 1 CPUs
SMP: Total of 1 processors activated (1646.17 BogoMIPS).
migration_cost=0
NET: Registered protocol family 16
PCI quirk: region 7e20-7e3f claimed by ali7101 SMB
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
srm_env: version 0.0.5 loaded successfully
Loading Reiser4. See www.namesys.com for a description of Reiser4.
SGI XFS with large block/inode numbers, no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
rtc: SRM (post-2000) epoch (2000) detected
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Unable to handle kernel paging request at virtual address 0000000000000058
CPU 0 swapper(1): Oops 0
pc = [<fffffc00003cdbb8>]  ra = [<fffffc00006ee128>]  ps = 0000    Not tainted
pc is at sysfs_create_group+0x28/0x160
ra is at topology_cpu_callback+0x68/0xc0
v0 = 0000000000000000  t0 = 0000000000000000  t1 = 0000000000000001
t2 = 0000000000000001  t3 = fffffc003fd73170  t4 = fffffc003fd730c8
t5 = fffffc003fd730c8  t6 = 0000000000000002  t7 = fffffc0000244000
s0 = 0000000000000001  s1 = fffffc0000764828  s2 = fffffc0000722b00
s3 = fffffc000071f048  s4 = fffffc00006f4fb8  s5 = fffffc0000652b00
s6 = fffffc0000652b00
a0 = 0000000000000010  a1 = fffffc000071f048  a2 = 0000000000000000
a3 = 0000000000008080  a4 = 0000000000000004  a5 = 0000000000000000
t8 = 0000000000000001  t9 = fffffc000063c2a0  t10= fffffc00006f70c0
t11= 0000000000000004  pv = fffffc00003cdb90  at = 0000000000000000
gp = fffffc0000762b00  sp = fffffc0000247df8
Trace:
[<fffffc00003102b8>] init+0x198/0x5c0
[<fffffc0000311868>] kernel_thread+0x28/0x90

Code: b75e0000  47f1040c  b53e0008  b55e0010  b57e0018  e6000043 <a4300048> e4200041
Kernel panic - not syncing: Attempted to kill init!

--------------040203080003010208080108
Content-Type: application/gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
--------------040203080003010208080108
Content-Type: application/gzip;
 name="pci-devs.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="pci-devs.txt.gz"

H4sICNDYH0QCA3BjaS1kZXZzLnR4dADtmW1X4joQx1/Lp5iXemo1SVusHPUentzlLKxcKtwX
HF6ENmDOlranLa7sp78TyiJPKqJ7V72rFqpMpknm/0smIyEFYhwRcMpODZI0jPlQgBsGaRz6
vogLUMe/18OhdOEYnMmoL8Nk9rtluJRQAvl84/MPgLafxtzIHBU9HqUihv1Y3AKhB7m9cuay
ALXjKw0aYqRBaZw0eIJmGjiRcMsT1xe6+uif2teOBp1PRScIw0iHJo+rcayDk4ooksEQ76qt
lg6X2LrESnpuz0l5Ok4KUOaRlvVHg3bl8t5k7qNS7TjV+vlIeHI8govrYj+MUx3O5jeN2c1F
9oyzpnrL7dV5KgJ3UgBmWbBvMosECYxkcAimRab3/O7gEDvg3gioy0CAI38IoCS3VwtwjPE4
SguAvYcixOE4FR6kIdRaf4PBcnstMZRhAGQ6PRBhBxLgKdiEEOgm6OicWfne3I4W1DSF8UQZ
kVNmGspwP2/qfZkeQhAGehSLgUjdG973xcHMB/1y78JYdUG2cmErFzjLvC99mUqBc941SQ+a
4XcMd4MHKJ+RCFK4FXGinoOD27v0+RANm41q2f+GIXBq+EI1qDANiuO78jiOsck5GRWVzX6F
6IcVihfDy7gJU/Xmhr6no47moa4QZaxXA9U95VT45wTfXO6L8+yzXI6guk1UdzW9EXEg0iVl
q7j4UA5jnG+eqs7aGNyTY/v4FLrzFs04xCjiEDMt29gHZ9xPJijcUQGKvi954GK0xUiic2/s
IkNLTtvBtyD8HoAnbiUaYkzZ83HQX4iDvoSD9so4MELmOFCTvJCH/CIPyyJlU5Ea7HGRml+W
UFlGyp4jlTfvzdjykwghWz2JNtBF9S7iwVTsratG1p5m7bueTJS511u0X8HHc5+Nj/Y4Phri
gxfTMny0GT7a1viwBXwsxAe1h+SMIhQ0Wi9BVLyuwbVwb4LQx01BJEiVC60Os3H0Le4JHMMp
Rg2aravefDuA/SgOh7ocgJok9N5bpqpZVgJNA5yTuhxJJY4VigguwB+Xot3AMclmcDIxLsp5
o5SZ3XgEG3PzTrTCDWPbcZOfIroBHPYQOGzTzmO97Z3HOqJQkUnk88kLmHGE2ld4PDlYSKee
Cwv9v8Py17aw2DvBsgSB8RwI3pekT3A3qDlF6MfSGwqUcl0uJTsNahnGsXq1UJi16WyjeWlq
Dt2izz0Po1HrHOO3NtsRXOMjJFWveMYga7IY7CYLvJj+62VBiZJFpQpSQTfg7iZlWIydTo2y
mLOFLGDAN50Q9fe8PlkLGfF9QvzkHk7NBw+DZ3IYhLHwLh7cpNct2JMWxpMW5loGbf5MBWh+
fQHLv22lUlTqV1yQVUo7DlyfJ4kcSAxAtpJs0O0JJXR9ROX5fg7dZqPd+zUL2AIC+jtYwB5Q
LmXmpjMXXTOzf5oZrPe8JZD+ZmERWlA/xpurNRh/ag2PHZnszVkgm59EXlRsmPpYKOI9WHFg
Ly05sDdac9B3qDnMWFJ1u7ZTWlhpC9CpFZdOTofq6HQEnWub3akvaH/GpFO1onj2Wlijp0Dl
VysPynql9LDrEz5Q9omY7QSTxR7MGWYgmI+t7/YrnXyME+v1KmFkXZX0jyrfsipLq6o0nlJl
/iOokm2rSmXGcGnNtGcsaI/hPFS31t7Mz3//n73frrDyqsLMR5IIutWmntVU35P0/gVjXaY+
OB4AAA==
--------------040203080003010208080108--


--------------090103010202040107000501--
