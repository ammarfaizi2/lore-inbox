Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287793AbSAXNTI>; Thu, 24 Jan 2002 08:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287794AbSAXNSw>; Thu, 24 Jan 2002 08:18:52 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:38414 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S287793AbSAXNSi>; Thu, 24 Jan 2002 08:18:38 -0500
Date: Thu, 24 Jan 2002 14:18:35 +0100
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 OOPS in tty code.
Message-ID: <20020124141835.B31324@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <009101c1a2cf$704da030$0801a8c0@Stev.org>; from mail-lists@stev.org on Mon, Jan 21, 2002 at 11:00:36PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Sorry for the late rpely. I have a bit complicated acces to mail.

Here are some traces for the OOPS. I added following suggested patch:
--- linux-2.4.18-pre4/drivers/char/tty_io.c     Tue Jan 15 15:08:24 2002
+++ linux-akpm-1/drivers/char/tty_io.c  Mon Jan 21 15:23:32 2002
@@ -1266,8 +1266,14 @@ static void release_dev(struct file * fi
        /*
         * Make sure that the tty's task queue isn't activated.
         */
+       if (test_bit(TTY_DONT_FLIP, &tty->flags))
+               BUG();
        run_task_queue(&tq_timer);
+       if (tty->flip.tqueue.sync)
+               BUG();
        flush_scheduled_tasks();
+       if (tty->flip.tqueue.sync)
+               BUG();
and none of the bugs was triggered.

I also added printks to some functions to print argument values on entry (and
return from alloc_tty_struct). For every call to function tty_flip_buffer_push
I added a breakpoint to print full backrtrace.

This is backtrace in actual segfault:
Breakpoint 1, panic (fmt=0xa0146420 "Kernel mode fault at addr 0x%lx, ip 0x%lx") at panic.c:45
45      {
(gdb) bt
#0  panic (fmt=0xa0146420 "Kernel mode fault at addr 0x%lx, ip 0x%lx") at panic.c:45
#1  0xa00c578c in segv (address=0, ip=2684428006, is_write=0, is_user=0) at trap_kern.c:94
#2  0xa00c63ea in segv_handler (sig=11, sc=0xa0893ae0, usermode=0) at trap_user.c:369
#3  0xa00c6575 in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 2693587200, esi = 2693348808, ebp = 2693348816, esp = 2693348792, ebx = 0, edx = 0, ecx = 2693348576, eax = 0, trapno = 14, err = 4, eip = 2684428006, cs = 35, __csh = 0, eflags = 2163219, esp_at_signal = 2693348792, ss = 43, __ssh = 0, fpstate = 0xa0893b38, oldmask = 134217728, cr2 = 0}) at trap_user.c:428
#4  <signal handler called>
#5  __run_task_queue (list=0xa0169330) at softirq.c:352
#6  0xa00701d9 in release_dev (filp=0xa25d7340) at /usr/home/bulb/umlinux/include/linux/tqueue.h:122
#7  0xa0070629 in tty_release (inode=0xa08d1080, filp=0xa25d7340) at tty_io.c:1440
#8  0xa002aa25 in fput (file=0xa25d7340) at file_table.c:113
#9  0xa0029ac7 in filp_close (filp=0xa25d7340, id=0xa0171840) at open.c:838
#10 0xa0029b1c in sys_close (fd=0) at open.c:862
#11 0xa00c4575 in execute_syscall (regs={regs = {0, 2048, 1, 0, 2684353436, 2684353084, 4294967258, 43, 43, 0, 0, 6, 1074649757, 35, 2097799, 2684353040, 43}}) at syscall_kern.c:326
#12 0xa00c4671 in syscall_handler (unused=0x0) at syscall_user.c:70

I attach output on console (including debuging printks - each is first line
in named function except for alloc_tty_struct, where it's the last one.
The debugger output contains backtraces of all entries to tty_flip_buffer_push
for the same session. In the session I just waited for the shell to start
(it's started directly from inittab) and then quickly typed halt and <CR>.

The um-kernel was compiled with attached config. The host kernel was 2.4.13-ac8.
inittab, rc and rcS scripts used in the session are included. All binaries
(including /sbin/halt) are copied from debian (unstable) installation (last
updated about a month ago).

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Description: output_on_console
Content-Disposition: attachment; filename=output

Linux version 2.4.17-5um (bulb@vagabond) (gcc version 2.95.4 20011006 (Debian prerelease)) #13 St led 23 13:47:27 CET 2002
On node 0 totalpages: 8192
zone(0): 0 pages.
zone(1): 8192 pages.
zone(2): 0 pages.
Kernel command line: eth0=tuntap,,fe:fd:0:0:0:1,192.168.1.254 umid=schizofrenia ubd1=./swap_dev mem=32M debug root=/dev/ubd0
Calibrating delay loop... 25.39 BogoMIPS
Memory: 32244k available
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
devfs: v1.7 (20011216) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
block: 64 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Netdevice 0 : TUN/TAP backend - IP = 192.168.1.254 ether = fe:fd:0:0:0:1
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Initializing stdio console driver
Initializing software serial port version 1
mconsole initialized on /tmp/uml/schizofrenia/mconsole
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
DBG: alloc_tty_struct() = a08ce000
DBG: initialize_tty_struct(tty = a08ce000)
DBG: release_mem(tty = a08ce000, idx = 0)
DBG: free_tty_struct(tty = a08ce000)
DBG: alloc_tty_struct() = a08ce000
DBG: initialize_tty_struct(tty = a08ce000)
DBG: release_mem(tty = a08ce000, idx = 0)
DBG: free_tty_struct(tty = a08ce000)
DBG: alloc_tty_struct() = a08ce000
DBG: initialize_tty_struct(tty = a08ce000)
INIT: DBG: release_mem(tty = a08ce000, idx = 0)
DBG: free_tty_struct(tty = a08ce000)
DBG: alloc_tty_struct() = a08ce000
DBG: initialize_tty_struct(tty = a08ce000)
version 2.84 bootingDBG: release_mem(tty = a08ce000, idx = 0)
DBG: free_tty_struct(tty = a08ce000)
DBG: alloc_tty_struct() = a08ce000
DBG: initialize_tty_struct(tty = a08ce000)

DBG: release_mem(tty = a08ce000, idx = 0)
DBG: free_tty_struct(tty = a08ce000)
DBG: alloc_tty_struct() = a08ce000
DBG: initialize_tty_struct(tty = a08ce000)
Adding Swap: 32760k swap-space (priority -1)
* insmod tun
insmod: a module named tun already exists
Using /lib/modules/2.4.13-ac8/kernel/drivers/net/tun.o
* ifconfig tap0 192.168.1.254 netmask 255.255.255.255 up
* bash -c echo 1 > /proc/sys/net/ipv4/ip_forward
* route add -host 192.168.1.253 dev tap0
* bash -c echo 1 > /proc/sys/net/ipv4/conf/tap0/proxy_arp
* arp -Ds 192.168.1.253 eth0 pub
* route del -host 192.168.1.253 dev tap0
* bash -c echo 0 > /proc/sys/net/ipv4/conf/tap0/proxy_arp
* arp -i eth0 -d 192.168.1.253 pub
* route add -host 192.168.1.253 dev tap0
* bash -c echo 1 > /proc/sys/net/ipv4/conf/tap0/proxy_arp
mke2fs 1.25 (20-Sep-2001)
mount: proc already mounted on /proc
/dev/rd/0 on /tmp type ext2 (rw)
lockdsvc: Function not implemented
192.168.1.2:/home/bulb/c/dfs on /dfs type nfs (ro,addr=192.168.1.2)
192.168.1.2:/home/bulb/uml on /uml type nfs (ro,addr=192.168.1.2)
DBG: release_mem(tty = a08ce000, idx = 0)
DBG: free_tty_struct(tty = a08ce000)
DBG: alloc_tty_struct() = a08ce000
DBG: initialize_tty_struct(tty = a08ce000)
DBG: release_mem(tty = a08ce000, idx = 0)
DBG: free_tty_struct(tty = a08ce000)
DBG: alloc_tty_struct() = a08ce000
DBG: initialize_tty_struct(tty = a08ce000)
DBG: release_mem(tty = a08ce000, idx = 0)
DBG: free_tty_struct(tty = a08ce000)
DBG: alloc_tty_struct() = a08ce000
DBG: initialize_tty_struct(tty = a08ce000)
INIT: DBG: release_mem(tty = a08ce000, idx = 0)
DBG: free_tty_struct(tty = a08ce000)
DBG: alloc_tty_struct() = a08ce000
DBG: initialize_tty_struct(tty = a08ce000)
Entering runlevel: 2DBG: release_mem(tty = a08ce000, idx = 0)
DBG: free_tty_struct(tty = a08ce000)
DBG: alloc_tty_struct() = a08ce000
DBG: initialize_tty_struct(tty = a08ce000)

DBG: release_mem(tty = a08ce000, idx = 0)
DBG: free_tty_struct(tty = a08ce000)
DBG: alloc_tty_struct() = a08ce000
DBG: initialize_tty_struct(tty = a08ce000)
DBG: release_mem(tty = a08ce000, idx = 0)
DBG: free_tty_struct(tty = a08ce000)
DBG: alloc_tty_struct() = a08ce000
DBG: initialize_tty_struct(tty = a08ce000)
DBG: alloc_tty_struct() = a25de000
DBG: initialize_tty_struct(tty = a25de000)
DBG: release_mem(tty = a08ce000, idx = 0)
DBG: free_tty_struct(tty = a08ce000)
DBG: tty_flip_buffer_push(tty = a08ce000) low latency
DBG: flush_to_ldisc(tty = a08ce000) REQUEUE
DBG: tty_flip_buffer_push(tty = a08ce000) low latency
DBG: flush_to_ldisc(tty = a08ce000) REQUEUE
DBG: tty_flip_buffer_push(tty = a25de000) QUEUEING!
DBG: tty_flip_buffer_push(tty = a08ce000) low latency
DBG: flush_to_ldisc(tty = a08ce000) REQUEUE
DBG: tty_flip_buffer_push(tty = a08ce000) low latency
DBG: flush_to_ldisc(tty = a08ce000) REQUEUE
DBG: tty_flip_buffer_push(tty = a25de000) QUEUEING!
DBG: flush_to_ldisc(tty = a08ce000) REQUEUE
DBG: flush_to_ldisc(tty = a25de000) FLUSH
DBG: alloc_tty_struct() = a08ce000
DBG: initialize_tty_struct(tty = a08ce000)
DBG: flush_to_ldisc(tty = a08ce000) FLUSH
Kernel panic: Kernel mode fault at addr 0x0, ip 0xa0011ee6


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Description: debugger_output
Content-Disposition: attachment; filename=debugger

GNU gdb 5.1

0xa00d2071 in kill () at af_unix.c:1790
1790    }
Breakpoint 1 at 0xa000d017: file panic.c, line 45.
Breakpoint 2 at 0xa00c740e: file user_util.c, line 159.
Breakpoint 3 at 0xa00035a7: file init/main.c, line 553.

Breakpoint 3, start_kernel () at init/main.c:553
553             printk(linux_banner);
(gdb) b tty_flip_buffer_push 
Breakpoint 4 at 0xa007158c: file tty_io.c, line 1980.
(gdb) comm
Type commands for when breakpoint 4 is hit, one per line.
End with a line saying just "end".
>bt
>c
>end
(gdb) c
Continuing.

Breakpoint 4, tty_flip_buffer_push (tty=0xa08ce000) at tty_io.c:1980
1980    {
#0  tty_flip_buffer_push (tty=0xa08ce000) at tty_io.c:1980
#1  0xa00cf88c in chan_interrupt (chans=0xa01746c8, tty=0xa08ce000) at chan_kern.c:304
#2  0xa00c9a7a in console_interrupt (irq=2, dev=0xa01746c0, unused=0xa0167b70) at stdio_console.c:95
#3  0xa00c1b67 in handle_IRQ_event (irq=2, regs=0xa0167b70, action=0xa08844c0) at irq.c:152
#4  0xa00c1d1e in do_IRQ (irq=2, user_mode=0) at irq.c:317
#5  0xa00c23bb in sigio_handler (sig=29, sc=0xa0167c00, usermode=0) at irq_user.c:66
#6  0xa00c648c in irq_handler (sig=29, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 2685812736, esi = 2685812736, ebp = 2685828864, esp = 2685828820, ebx = 2685828856, edx = 2685812736, ecx = 2685828856, eax = 4294967292, trapno = 1, err = 0, eip = 2685288305, cs = 35, __csh = 0, eflags = 2097811, esp_at_signal = 2685828820, ss = 43, __ssh = 0, fpstate = 0xa0167c58, oldmask = 0, cr2 = 0}) at trap_user.c:404
#7  <signal handler called>
#8  0xa00e3f71 in nanosleep () at af_unix.c:1790
#9  0xa00c4d88 in idle_sleep (secs=10) at time.c:108
#10 0xa00c8339 in cpu_idle () at process_kern.c:465
#11 0xa000a491 in rest_init () at init/main.c:536
#12 0xa00036b7 in start_kernel () at init/main.c:623
#13 0xa00c69d7 in start_kernel_proc (unused=0x0) at um_arch.c:130
#14 0xa00c5dcb in signal_tramp (arg=0xa00c6998) at trap_user.c:83

Breakpoint 4, tty_flip_buffer_push (tty=0xa08ce000) at tty_io.c:1980
1980    {
#0  tty_flip_buffer_push (tty=0xa08ce000) at tty_io.c:1980
#1  0xa00cf88c in chan_interrupt (chans=0xa01746c8, tty=0xa08ce000) at chan_kern.c:304
#2  0xa00c9a7a in console_interrupt (irq=2, dev=0xa01746c0, unused=0xa0167b70) at stdio_console.c:95
#3  0xa00c1b67 in handle_IRQ_event (irq=2, regs=0xa0167b70, action=0xa08844c0) at irq.c:152
#4  0xa00c1d1e in do_IRQ (irq=2, user_mode=0) at irq.c:317
#5  0xa00c23bb in sigio_handler (sig=29, sc=0xa0167c00, usermode=0) at irq_user.c:66
#6  0xa00c648c in irq_handler (sig=29, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 2685812736, esi = 2685812736, ebp = 2685828864, esp = 2685828820, ebx = 2685828856, edx = 2685812736, ecx = 2685828856, eax = 4294967292, trapno = 1, err = 0, eip = 2685288305, cs = 35, __csh = 0, eflags = 2097811, esp_at_signal = 2685828820, ss = 43, __ssh = 0, fpstate = 0xa0167c58, oldmask = 0, cr2 = 0}) at trap_user.c:404
#7  <signal handler called>
#8  0xa00e3f71 in nanosleep () at af_unix.c:1790
#9  0xa00c4d88 in idle_sleep (secs=10) at time.c:108
#10 0xa00c8339 in cpu_idle () at process_kern.c:465
#11 0xa000a491 in rest_init () at init/main.c:536
#12 0xa00036b7 in start_kernel () at init/main.c:623
#13 0xa00c69d7 in start_kernel_proc (unused=0x0) at um_arch.c:130
#14 0xa00c5dcb in signal_tramp (arg=0xa00c6998) at trap_user.c:83

Breakpoint 4, tty_flip_buffer_push (tty=0xa25de000) at tty_io.c:1980
1980    {
#0  tty_flip_buffer_push (tty=0xa25de000) at tty_io.c:1980
#1  0xa00cf88c in chan_interrupt (chans=0xa01746f4, tty=0xa25de000) at chan_kern.c:304
#2  0xa00c9a7a in console_interrupt (irq=2, dev=0xa01746ec, unused=0xa0167b70) at stdio_console.c:95
#3  0xa00c1b67 in handle_IRQ_event (irq=2, regs=0xa0167b70, action=0xa08844c0) at irq.c:152
#4  0xa00c1d1e in do_IRQ (irq=2, user_mode=0) at irq.c:317
#5  0xa00c23bb in sigio_handler (sig=29, sc=0xa0167c00, usermode=0) at irq_user.c:66
#6  0xa00c648c in irq_handler (sig=29, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 2685812736, esi = 2685812736, ebp = 2685828864, esp = 2685828820, ebx = 2685828856, edx = 2685812736, ecx = 2685828856, eax = 4294967292, trapno = 1, err = 0, eip = 2685288305, cs = 35, __csh = 0, eflags = 2097811, esp_at_signal = 2685828820, ss = 43, __ssh = 0, fpstate = 0xa0167c58, oldmask = 0, cr2 = 0}) at trap_user.c:404
#7  <signal handler called>
#8  0xa00e3f71 in nanosleep () at af_unix.c:1790
#9  0xa00c4d88 in idle_sleep (secs=10) at time.c:108
#10 0xa00c8339 in cpu_idle () at process_kern.c:465
#11 0xa000a491 in rest_init () at init/main.c:536
#12 0xa00036b7 in start_kernel () at init/main.c:623
#13 0xa00c69d7 in start_kernel_proc (unused=0x0) at um_arch.c:130
#14 0xa00c5dcb in signal_tramp (arg=0xa00c6998) at trap_user.c:83

Breakpoint 4, tty_flip_buffer_push (tty=0xa08ce000) at tty_io.c:1980
1980    {
#0  tty_flip_buffer_push (tty=0xa08ce000) at tty_io.c:1980
#1  0xa00cf88c in chan_interrupt (chans=0xa01746c8, tty=0xa08ce000) at chan_kern.c:304
#2  0xa00c9a7a in console_interrupt (irq=2, dev=0xa01746c0, unused=0xa01676d0) at stdio_console.c:95
#3  0xa00c1b67 in handle_IRQ_event (irq=2, regs=0xa01676d0, action=0xa08844c0) at irq.c:152
#4  0xa00c1d1e in do_IRQ (irq=2, user_mode=0) at irq.c:317
#5  0xa00c23bb in sigio_handler (sig=29, sc=0xa0167760, usermode=0) at irq_user.c:66
#6  0xa00c648c in irq_handler (sig=29, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 1, esi = 8, ebp = 2685827668, esp = 2685827640, ebx = 1, edx = 0, ecx = 2685827716, eax = 0, trapno = 1, err = 0, eip = 2685214708, cs = 35, __csh = 0, eflags = 2097734, esp_at_signal = 2685827640, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 0, cr2 = 0}) at trap_user.c:404
#7  <signal handler called>
#8  0xa00d1ff4 in sigprocmask () at af_unix.c:1790
#9  0xa00c38a9 in change_signals (type=1) at signal_user.c:174
#10 0xa00c38f4 in unblock_signals () at signal_user.c:185
#11 0xa0011a7f in do_softirq () at softirq.c:84
#12 0xa00c1d50 in do_IRQ (irq=2, user_mode=0) at irq.c:334
#13 0xa00c23bb in sigio_handler (sig=29, sc=0xa0167c00, usermode=0) at irq_user.c:66
#14 0xa00c648c in irq_handler (sig=29, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 2685812736, esi = 2685812736, ebp = 2685828864, esp = 2685828820, ebx = 2685828856, edx = 2685812736, ecx = 2685828856, eax = 4294967292, trapno = 1, err = 0, eip = 2685288305, cs = 35, __csh = 0, eflags = 2097811, esp_at_signal = 2685828820, ss = 43, __ssh = 0, fpstate = 0xa0167c58, oldmask = 0, cr2 = 0}) at trap_user.c:404
#15 <signal handler called>
#16 0xa00e3f71 in nanosleep () at af_unix.c:1790
#17 0xa00c4d88 in idle_sleep (secs=10) at time.c:108
#18 0xa00c8339 in cpu_idle () at process_kern.c:465
#19 0xa000a491 in rest_init () at init/main.c:536
#20 0xa00036b7 in start_kernel () at init/main.c:623
#21 0xa00c69d7 in start_kernel_proc (unused=0x0) at um_arch.c:130
#22 0xa00c5dcb in signal_tramp (arg=0xa00c6998) at trap_user.c:83

Breakpoint 4, tty_flip_buffer_push (tty=0xa08ce000) at tty_io.c:1980
1980    {
#0  tty_flip_buffer_push (tty=0xa08ce000) at tty_io.c:1980
#1  0xa00cf88c in chan_interrupt (chans=0xa01746c8, tty=0xa08ce000) at chan_kern.c:304
#2  0xa00c9a7a in console_interrupt (irq=2, dev=0xa01746c0, unused=0xa01676d0) at stdio_console.c:95
#3  0xa00c1b67 in handle_IRQ_event (irq=2, regs=0xa01676d0, action=0xa08844c0) at irq.c:152
#4  0xa00c1d1e in do_IRQ (irq=2, user_mode=0) at irq.c:317
#5  0xa00c23bb in sigio_handler (sig=29, sc=0xa0167760, usermode=0) at irq_user.c:66
#6  0xa00c648c in irq_handler (sig=29, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 1, esi = 8, ebp = 2685827668, esp = 2685827640, ebx = 1, edx = 0, ecx = 2685827716, eax = 0, trapno = 1, err = 0, eip = 2685214708, cs = 35, __csh = 0, eflags = 2097734, esp_at_signal = 2685827640, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 0, cr2 = 0}) at trap_user.c:404
#7  <signal handler called>
#8  0xa00d1ff4 in sigprocmask () at af_unix.c:1790
#9  0xa00c38a9 in change_signals (type=1) at signal_user.c:174
#10 0xa00c38f4 in unblock_signals () at signal_user.c:185
#11 0xa0011a7f in do_softirq () at softirq.c:84
#12 0xa00c1d50 in do_IRQ (irq=2, user_mode=0) at irq.c:334
#13 0xa00c23bb in sigio_handler (sig=29, sc=0xa0167c00, usermode=0) at irq_user.c:66
#14 0xa00c648c in irq_handler (sig=29, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 2685812736, esi = 2685812736, ebp = 2685828864, esp = 2685828820, ebx = 2685828856, edx = 2685812736, ecx = 2685828856, eax = 4294967292, trapno = 1, err = 0, eip = 2685288305, cs = 35, __csh = 0, eflags = 2097811, esp_at_signal = 2685828820, ss = 43, __ssh = 0, fpstate = 0xa0167c58, oldmask = 0, cr2 = 0}) at trap_user.c:404
#15 <signal handler called>
#16 0xa00e3f71 in nanosleep () at af_unix.c:1790
#17 0xa00c4d88 in idle_sleep (secs=10) at time.c:108
#18 0xa00c8339 in cpu_idle () at process_kern.c:465
#19 0xa000a491 in rest_init () at init/main.c:536
#20 0xa00036b7 in start_kernel () at init/main.c:623
#21 0xa00c69d7 in start_kernel_proc (unused=0x0) at um_arch.c:130
#22 0xa00c5dcb in signal_tramp (arg=0xa00c6998) at trap_user.c:83

Breakpoint 4, tty_flip_buffer_push (tty=0xa25de000) at tty_io.c:1980
1980    {
#0  tty_flip_buffer_push (tty=0xa25de000) at tty_io.c:1980
#1  0xa00cf88c in chan_interrupt (chans=0xa01746f4, tty=0xa25de000) at chan_kern.c:304
#2  0xa00c9a7a in console_interrupt (irq=2, dev=0xa01746ec, unused=0xa01676d0) at stdio_console.c:95
#3  0xa00c1b67 in handle_IRQ_event (irq=2, regs=0xa01676d0, action=0xa08844c0) at irq.c:152
#4  0xa00c1d1e in do_IRQ (irq=2, user_mode=0) at irq.c:317
#5  0xa00c23bb in sigio_handler (sig=29, sc=0xa0167760, usermode=0) at irq_user.c:66
#6  0xa00c648c in irq_handler (sig=29, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 1, esi = 8, ebp = 2685827668, esp = 2685827640, ebx = 1, edx = 0, ecx = 2685827716, eax = 0, trapno = 1, err = 0, eip = 2685214708, cs = 35, __csh = 0, eflags = 2097734, esp_at_signal = 2685827640, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 0, cr2 = 0}) at trap_user.c:404
#7  <signal handler called>
#8  0xa00d1ff4 in sigprocmask () at af_unix.c:1790
#9  0xa00c38a9 in change_signals (type=1) at signal_user.c:174
#10 0xa00c38f4 in unblock_signals () at signal_user.c:185
#11 0xa0011a7f in do_softirq () at softirq.c:84
#12 0xa00c1d50 in do_IRQ (irq=2, user_mode=0) at irq.c:334
#13 0xa00c23bb in sigio_handler (sig=29, sc=0xa0167c00, usermode=0) at irq_user.c:66
#14 0xa00c648c in irq_handler (sig=29, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 2685812736, esi = 2685812736, ebp = 2685828864, esp = 2685828820, ebx = 2685828856, edx = 2685812736, ecx = 2685828856, eax = 4294967292, trapno = 1, err = 0, eip = 2685288305, cs = 35, __csh = 0, eflags = 2097811, esp_at_signal = 2685828820, ss = 43, __ssh = 0, fpstate = 0xa0167c58, oldmask = 0, cr2 = 0}) at trap_user.c:404
#15 <signal handler called>
#16 0xa00e3f71 in nanosleep () at af_unix.c:1790
#17 0xa00c4d88 in idle_sleep (secs=10) at time.c:108
#18 0xa00c8339 in cpu_idle () at process_kern.c:465
#19 0xa000a491 in rest_init () at init/main.c:536
#20 0xa00036b7 in start_kernel () at init/main.c:623
#21 0xa00c69d7 in start_kernel_proc (unused=0x0) at um_arch.c:130
#22 0xa00c5dcb in signal_tramp (arg=0xa00c6998) at trap_user.c:83

Breakpoint 1, panic (fmt=0xa0146420 "Kernel mode fault at addr 0x%lx, ip 0x%lx") at panic.c:45
45      {
(gdb) bt
#0  panic (fmt=0xa0146420 "Kernel mode fault at addr 0x%lx, ip 0x%lx") at panic.c:45
#1  0xa00c578c in segv (address=0, ip=2684428006, is_write=0, is_user=0) at trap_kern.c:94
#2  0xa00c63ea in segv_handler (sig=11, sc=0xa0893ae0, usermode=0) at trap_user.c:369
#3  0xa00c6575 in sig_handler (sig=11, sc={gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 2693587200, esi = 2693348808, ebp = 2693348816, esp = 2693348792, ebx = 0, edx = 0, ecx = 2693348576, eax = 0, trapno = 14, err = 4, eip = 2684428006, cs = 35, __csh = 0, eflags = 2163219, esp_at_signal = 2693348792, ss = 43, __ssh = 0, fpstate = 0xa0893b38, oldmask = 134217728, cr2 = 0}) at trap_user.c:428
#4  <signal handler called>
#5  __run_task_queue (list=0xa0169330) at softirq.c:352
#6  0xa00701d9 in release_dev (filp=0xa25d7340) at /usr/home/bulb/umlinux/include/linux/tqueue.h:122
#7  0xa0070629 in tty_release (inode=0xa08d1080, filp=0xa25d7340) at tty_io.c:1440
#8  0xa002aa25 in fput (file=0xa25d7340) at file_table.c:113
#9  0xa0029ac7 in filp_close (filp=0xa25d7340, id=0xa0171840) at open.c:838
#10 0xa0029b1c in sys_close (fd=0) at open.c:862
#11 0xa00c4575 in execute_syscall (regs={regs = {0, 2048, 1, 0, 2684353436, 2684353084, 4294967258, 43, 43, 0, 0, 6, 1074649757, 35, 2097799, 2684353040, 43}}) at syscall_kern.c:326
#12 0xa00c4671 in syscall_handler (unused=0x0) at syscall_user.c:70
(gdb) c
Continuing.
[here it printed the last message on console and stopped]


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_USERMODE=y
# CONFIG_ISA is not set
# CONFIG_SBUS is not set
# CONFIG_PCI is not set
CONFIG_UID16=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General Setup
#
CONFIG_STDIO_CONSOLE=y
CONFIG_NET=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_SSL=y
# CONFIG_HOSTFS is not set
CONFIG_MCONSOLE=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_HOST_2G_2G is not set
# CONFIG_SMP is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_KMOD=y

#
# Devices
#
CONFIG_BLK_DEV_UBD=y
# CONFIG_BLK_DEV_UBD_SYNC is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_MMAPPER is not set

#
# Networking options
#
# CONFIG_PACKET is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network device support
#
CONFIG_UML_NET=y
CONFIG_UML_NET_ETHERTAP=y
CONFIG_UML_NET_TUNTAP=y
# CONFIG_UML_NET_SLIP is not set
# CONFIG_UML_NET_DAEMON is not set
# CONFIG_UML_NET_MCAST is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_TMPFS is not set
# CONFIG_RAMFS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set
# CONFIG_ZLIB_FS_INFLATE is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_SMB_NLS is not set
# CONFIG_NLS is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUGSYM=y
CONFIG_PT_PROXY=y
# CONFIG_GPROF is not set
# CONFIG_GCOV is not set

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=inittab

# /etc/inittab: init(8) configuration.
# $Id: inittab,v 1.8 1998/05/10 10:37:50 miquels Exp $

# The default runlevel.
id:2:initdefault:

# Boot-time system configuration/initialization script.
# This is run first except when booting in emergency (-b) mode.
si::sysinit:/etc/init.d/rcS

# What to do in single-user mode.
~~:S:wait:/bin/bash

# /etc/init.d executes the S and K scripts upon change
# of runlevel.
#
# Runlevel 0 is halt.
# Runlevel 1 is single-user.
# Runlevels 2-5 are multi-user.
# Runlevel 6 is reboot.

l0:0:wait:/etc/init.d/rc 0
l1:1:wait:/etc/init.d/rc 1
l2:2:wait:/etc/init.d/rc 2
l3:3:wait:/etc/init.d/rc 3
l4:4:wait:/etc/init.d/rc 4
l5:5:wait:/etc/init.d/rc 5
l6:6:wait:/etc/init.d/rc 6
# Normally not reached, but fallthrough in case of emergency.
z6:6:respawn:/bin/bash

# What to do when CTRL-ALT-DEL is pressed.
ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now

# Action on special keypress (ALT-UpArrow).
kb::kbrequest:/bin/echo "Keyboard Request--edit /etc/inittab to let this work."

# What to do when the power fails/returns.

# /sbin/getty invocations for the runlevels.
#
# The "id" field MUST be the same as the last
# characters of the device (after "tty").
#
# Format:
#  <id>:<runlevels>:<action>:<process>
#0:2345:respawn:/bin/bash -login
1:2345:respawn:/bin/bash -login </dev/ttys/1 >/dev/ttys/1 2>/dev/ttys/1
#2:2345:respawn:/bin/bash -login </dev/ttys/2 >/dev/ttys/2 2>/dev/ttys/2
#c:2345:respawn:/bin/bash -login <>2>neco


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=rc

#! /bin/sh

umnt () {
	sync;
	echo umounting...
	umount -a -t noproc,nodevfs
	mount / -n -o remount,ro
	echo done
}

PATH=/sbin:/bin:/usr/bin
  case "$1" in
	6)
		umnt;
		reboot -d -f -i
		;;
	0)
		umnt;
		halt -d -f -i -p -h
		;;
  esac

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=rcS

#! /bin/sh
PATH=/bin:/sbin
mount /proc
swapon -a
ifconfig lo 127.0.0.1
ifconfig eth0 192.168.1.253 netmask 255.255.255.255 up
route add -host 192.168.1.254 eth0
route add default gw 192.168.1.254 eth0
mke2fs -q /dev/rd/0
mount -avt nonfs
/sbin/portmap
/sbin/rpc.statd
/sbin/rpc.lockd
mount -avt nfs

--i9LlY+UWpKt15+FH--
