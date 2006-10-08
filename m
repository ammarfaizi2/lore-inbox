Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWJHWVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWJHWVf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 18:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWJHWVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 18:21:35 -0400
Received: from h8922032063.dsl.speedlinq.nl ([89.220.32.63]:25063 "EHLO
	jumbo.lan") by vger.kernel.org with ESMTP id S1751505AbWJHWVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 18:21:33 -0400
Date: Mon, 9 Oct 2006 00:21:23 +0200
From: Dennis Bijwaard <dennis@bijwaard.demon.nl>
To: matthew@wil.cx
Cc: linux-kernel@vger.kernel.org
Subject: possible circular locking dependency detected, crash afterwards
Message-ID: <20061008222123.GA3602@jumbo.lan>
Reply-To: Dennis Bijwaard <d.j.a.bijwaard@alumnus.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Matthew,

Since your name is mentioned as maintainer of File locking, this is the
closest match I could find for a problem with semaphores. To be on the
safe side I CC'd the kernel list.

[1.] One line summary of the problem:

Possible circular locking dependency detected, hard crash soon after.

[2.] Full description of the problem/report:

I run windows program in wine (as normal user) in second X display and 
after some playing around in this program, the possible circular locking 
dependency is displayed. Strange thing is that they come from two different 
programs (in this case winevdm.exe and /module/snd_rtctimer. A previous 
time, the report was about dnetc (nothing to do with sound, but
distributed computing) and snd_rtctimer.

When I run wine with the windows program again and play around some
more, the screen freezes, the Sysrq keys do not work and I have to do a
hard reboot. Since I'm in graphical mode, I cannot see the console at
that point.

[3.] Keywords (i.e., modules, networking, kernel):

snd_rtctimer

[4.] Kernel version (from /proc/version):

Linux version 2.6.18 (dennis@jumbo) (gcc version 3.4.6) #3 SMP Sun Oct 8
22:02:52 CEST 2006

[5.] Most recent kernel version which did not have the bug:

I ran the same fine in 2.6.15.1, didn't try others.

[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

No oops. I do have dmesg output of the circular lock:

[  472.867925] kobject_uevent
[  472.867998] fill_kobj_path: path = '/block/loop0'
[  473.184688] kobject vcs8: registering. parent: vc, set: class_obj
[  473.185336] kobject_uevent
[  473.185353] fill_kobj_path: path = '/class/vc/vcs8'
[  473.185578] kobject vcsa8: registering. parent: vc, set: class_obj
[  473.186160] kobject_uevent
[  473.186177] fill_kobj_path: path = '/class/vc/vcsa8'
[  478.823193] mtrr: no MTRR for e3000000,800000 found
[  479.086529] mtrr: no MTRR for e3000000,800000 found
[  479.315102] agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
[  479.315929] agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
[  479.317933] agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[  479.333664] [drm] Initialized card for AGP DMA.
[  481.311907] mtrr: no MTRR for e3000000,800000 found
[  481.495983] agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
[  481.496809] agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
[  481.498852] agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[  481.517176] [drm] Initialized card for AGP DMA.
[  486.326602] kobject snd_rtctimer: registering. parent: <NULL>, set: module
[  486.327377] kobject_uevent
[  486.327395] fill_kobj_path: path = '/module/snd_rtctimer'
[  496.640101] 
[  496.640109] =======================================================
[  496.640127] [ INFO: possible circular locking dependency detected ]
[  496.640138] -------------------------------------------------------
[  496.640149] winevdm.exe/3547 is trying to acquire lock:
[  496.640161]  (&timer->lock){+...}, at: [<e08b7ec4>] snd_timer_interrupt+0x24/0x310 [snd_timer]
[  496.640234] 
[  496.640238] but task is already holding lock:
[  496.640247]  (rtc_task_lock){+...}, at: [<c0237ffb>] rtc_interrupt+0x12b/0x150
[  496.640296] 
[  496.640299] which lock already depends on the new lock.
[  496.640305] 
[  496.640314] 
[  496.640317] the existing dependency chain (in reverse order) is:
[  496.640328] 
[  496.640331] -> #1 (rtc_task_lock){+...}:
[  496.640348]        [<c013d41f>] check_prevs_add+0x6f/0xd0
[  496.640402]        [<c013ee0f>] __lock_acquire+0x5af/0xa10
[  496.640435]        [<c013f9f6>] lock_acquire+0x76/0x90
[  496.640467]        [<c0390f83>] _spin_lock_irqsave+0x43/0x60
[  496.640505]        [<c0238f44>] rtc_control+0x34/0x90
[  496.640537]        [<e0a5508a>] rtctimer_start+0x2a/0x50 [snd_rtctimer]
[  496.640575]        [<e08b7962>] snd_timer_start1+0x72/0x90 [snd_timer]
[  496.640622]        [<e08b7a53>] snd_timer_start+0x73/0xb0 [snd_timer]
[  496.640666]        [<e096b3b6>] snd_seq_timer_start+0x46/0x70 [snd_seq]
[  496.640752]        [<e0969e40>] snd_seq_queue_process_event+0xc0/0x130 [snd_seq]
[  496.640808]        [<e0969f03>] snd_seq_control_queue+0x53/0x90 [snd_seq]
[  496.640862]        [<e096b73f>] event_input_timer+0x1f/0x30 [snd_seq]
[  496.640916]        [<e0965c69>] snd_seq_deliver_single_event+0x189/0x190 [snd_seq]
[  496.640966]        [<e0965e55>] snd_seq_deliver_event+0x45/0x70 [snd_seq]
[  496.641014]        [<e096816d>] snd_seq_kernel_client_dispatch+0x6d/0x70 [snd_seq]
[  496.641067]        [<e098cecb>] send_timer_event+0x5b/0x70 [snd_seq_oss]
[  496.641129]        [<e098cf42>] snd_seq_oss_timer_start+0x62/0x90 [snd_seq_oss]
[  496.641175]        [<e0990578>] send_midi_event+0xb8/0xc0 [snd_seq_oss]
[  496.641222]        [<e0990388>] snd_seq_oss_midi_input+0x68/0x90 [snd_seq_oss]
[  496.641269]        [<e098e6ea>] snd_seq_oss_event_input+0x2a/0x90 [snd_seq_oss]
[  496.641316]        [<e0965c69>] snd_seq_deliver_single_event+0x189/0x190 [snd_seq]
[  496.641367]        [<e0965d23>] deliver_to_subscribers+0xb3/0x1a0 [snd_seq]
[  496.641415]        [<e0965e74>] snd_seq_deliver_event+0x64/0x70 [snd_seq]
[  496.641463]        [<e096816d>] snd_seq_kernel_client_dispatch+0x6d/0x70 [snd_seq]
[  496.641516]        [<e0951120>] dummy_input+0x70/0x80 [snd_seq_dummy]
[  496.641557]        [<e0965c69>] snd_seq_deliver_single_event+0x189/0x190 [snd_seq]
[  496.641607]        [<e0965e55>] snd_seq_deliver_event+0x45/0x70 [snd_seq]
[  496.641655]        [<e096816d>] snd_seq_kernel_client_dispatch+0x6d/0x70 [snd_seq]
[  496.641708]        [<e098eb00>] insert_queue+0xc0/0x130 [snd_seq_oss]
[  496.641756]        [<e098e97b>] snd_seq_oss_write+0x9b/0x160 [snd_seq_oss]
[  496.641802]        [<e098c0e9>] odev_write+0x29/0x30 [snd_seq_oss]
[  496.641846]        [<c016f578>] vfs_write+0x1c8/0x1d0
[  496.641887]        [<c016f64b>] sys_write+0x4b/0x80
[  496.641917]        [<c0102ffb>] syscall_call+0x7/0xb
[  496.641954] 
[  496.641958] -> #0 (&timer->lock){+...}:
[  496.641974]        [<c013d41f>] check_prevs_add+0x6f/0xd0
[  496.642009]        [<c013ee0f>] __lock_acquire+0x5af/0xa10
[  496.642040]        [<c013f9f6>] lock_acquire+0x76/0x90
[  496.642072]        [<c0390f83>] _spin_lock_irqsave+0x43/0x60
[  496.642104]        [<e08b7ec4>] snd_timer_interrupt+0x24/0x310 [snd_timer]
[  496.642153]        [<e0a550fa>] rtctimer_interrupt+0x1a/0x20 [snd_rtctimer]
[  496.642188]        [<c0238018>] rtc_interrupt+0x148/0x150
[  496.642221]        [<c014b871>] handle_IRQ_event+0x31/0x80
[  496.642268]        [<c014b95e>] __do_IRQ+0x9e/0x120
[  496.642299]        [<c01058d8>] do_IRQ+0x48/0xa0
[  496.642335]        [<c01039e9>] common_interrupt+0x25/0x2c
[  496.642366]        [<e08b7a5e>] snd_timer_start+0x7e/0xb0 [snd_timer]
[  496.642412]        [<e096b3b6>] snd_seq_timer_start+0x46/0x70 [snd_seq]
[  496.642471]        [<e0969e40>] snd_seq_queue_process_event+0xc0/0x130 [snd_seq]
[  496.642526]        [<e0969f03>] snd_seq_control_queue+0x53/0x90 [snd_seq]
[  496.642580]        [<e096b73f>] event_input_timer+0x1f/0x30 [snd_seq]
[  496.642634]        [<e0965c69>] snd_seq_deliver_single_event+0x189/0x190 [snd_seq]
[  496.642684]        [<e0965e55>] snd_seq_deliver_event+0x45/0x70 [snd_seq]
[  496.642732]        [<e096816d>] snd_seq_kernel_client_dispatch+0x6d/0x70 [snd_seq]
[  496.642784]        [<e098cecb>] send_timer_event+0x5b/0x70 [snd_seq_oss]
[  496.642833]        [<e098cf42>] snd_seq_oss_timer_start+0x62/0x90 [snd_seq_oss]
[  496.642879]        [<e0990578>] send_midi_event+0xb8/0xc0 [snd_seq_oss]
[  496.642926]        [<e0990388>] snd_seq_oss_midi_input+0x68/0x90 [snd_seq_oss]
[  496.642972]        [<e098e6ea>] snd_seq_oss_event_input+0x2a/0x90 [snd_seq_oss]
[  496.643018]        [<e0965c69>] snd_seq_deliver_single_event+0x189/0x190 [snd_seq]
[  496.643070]        [<e0965d23>] deliver_to_subscribers+0xb3/0x1a0 [snd_seq]
[  496.643118]        [<e0965e74>] snd_seq_deliver_event+0x64/0x70 [snd_seq]
[  496.643167]        [<e096816d>] snd_seq_kernel_client_dispatch+0x6d/0x70 [snd_seq]
[  496.643219]        [<e0951120>] dummy_input+0x70/0x80 [snd_seq_dummy]
[  496.643257]        [<e0965c69>] snd_seq_deliver_single_event+0x189/0x190 [snd_seq]
[  496.643307]        [<e0965e55>] snd_seq_deliver_event+0x45/0x70 [snd_seq]
[  496.643355]        [<e096816d>] snd_seq_kernel_client_dispatch+0x6d/0x70 [snd_seq]
[  496.643407]        [<e098eb00>] insert_queue+0xc0/0x130 [snd_seq_oss]
[  496.643456]        [<e098e97b>] snd_seq_oss_write+0x9b/0x160 [snd_seq_oss]
[  496.643502]        [<e098c0e9>] odev_write+0x29/0x30 [snd_seq_oss]
[  496.643545]        [<c016f578>] vfs_write+0x1c8/0x1d0
[  496.643578]        [<c016f64b>] sys_write+0x4b/0x80
[  496.643608]        [<c0102ffb>] syscall_call+0x7/0xb
[  496.643640] 
[  496.643644] other info that might help us debug this:
[  496.643650] 
[  496.643660] 2 locks held by winevdm.exe/3547:
[  496.643669]  #0:  (&grp->list_mutex){----}, at: [<e0965d9e>] deliver_to_subscribers+0x12e/0x1a0 [snd_seq]
[  496.643720]  #1:  (rtc_task_lock){+...}, at: [<c0237ffb>] rtc_interrupt+0x12b/0x150
[  496.643752] 
[  496.643755] stack backtrace:
[  496.643766]  [<c0103e58>] show_trace+0x28/0x30
[  496.643784]  [<c0103f94>] dump_stack+0x24/0x30
[  496.643801]  [<c013ca5c>] print_circular_bug_tail+0x7c/0x90
[  496.643823]  [<c013d18e>] check_prev_add+0x3e/0x260
[  496.643840]  [<c013d41f>] check_prevs_add+0x6f/0xd0
[  496.643857]  [<c013ee0f>] __lock_acquire+0x5af/0xa10
[  496.643874]  [<c013f9f6>] lock_acquire+0x76/0x90
[  496.643891]  [<c0390f83>] _spin_lock_irqsave+0x43/0x60
[  496.643909]  [<e08b7ec4>] snd_timer_interrupt+0x24/0x310 [snd_timer]
[  496.643944]  [<e0a550fa>] rtctimer_interrupt+0x1a/0x20 [snd_rtctimer]
[  496.643965]  [<c0238018>] rtc_interrupt+0x148/0x150
[  496.643984]  [<c014b871>] handle_IRQ_event+0x31/0x80
[  496.644005]  [<c014b95e>] __do_IRQ+0x9e/0x120
[  496.644021]  [<c01058d8>] do_IRQ+0x48/0xa0
[  496.644039]  [<c01039e9>] common_interrupt+0x25/0x2c
[  496.644055]  [<e08b7a5e>] snd_timer_start+0x7e/0xb0 [snd_timer]
[  496.644087]  [<e096b3b6>] snd_seq_timer_start+0x46/0x70 [snd_seq]
[  496.644132]  [<e0969e40>] snd_seq_queue_process_event+0xc0/0x130 [snd_seq]
[  496.644174]  [<e0969f03>] snd_seq_control_queue+0x53/0x90 [snd_seq]
[  496.644214]  [<e096b73f>] event_input_timer+0x1f/0x30 [snd_seq]
[  496.644254]  [<e0965c69>] snd_seq_deliver_single_event+0x189/0x190 [snd_seq]
[  496.644290]  [<e0965e55>] snd_seq_deliver_event+0x45/0x70 [snd_seq]
[  496.644324]  [<e096816d>] snd_seq_kernel_client_dispatch+0x6d/0x70 [snd_seq]
[  496.644363]  [<e098cecb>] send_timer_event+0x5b/0x70 [snd_seq_oss]
[  496.644398]  [<e098cf42>] snd_seq_oss_timer_start+0x62/0x90 [snd_seq_oss]
[  496.644430]  [<e0990578>] send_midi_event+0xb8/0xc0 [snd_seq_oss]
[  496.644462]  [<e0990388>] snd_seq_oss_midi_input+0x68/0x90 [snd_seq_oss]
[  496.644495]  [<e098e6ea>] snd_seq_oss_event_input+0x2a/0x90 [snd_seq_oss]
[  496.644527]  [<e0965c69>] snd_seq_deliver_single_event+0x189/0x190 [snd_seq]
[  496.644564]  [<e0965d23>] deliver_to_subscribers+0xb3/0x1a0 [snd_seq]
[  496.644598]  [<e0965e74>] snd_seq_deliver_event+0x64/0x70 [snd_seq]
[  496.644632]  [<e096816d>] snd_seq_kernel_client_dispatch+0x6d/0x70 [snd_seq]
[  496.644671]  [<e0951120>] dummy_input+0x70/0x80 [snd_seq_dummy]
[  496.644695]  [<e0965c69>] snd_seq_deliver_single_event+0x189/0x190 [snd_seq]
[  496.644731]  [<e0965e55>] snd_seq_deliver_event+0x45/0x70 [snd_seq]
[  496.644765]  [<e096816d>] snd_seq_kernel_client_dispatch+0x6d/0x70 [snd_seq]
[  496.644803]  [<e098eb00>] insert_queue+0xc0/0x130 [snd_seq_oss]
[  496.644837]  [<e098e97b>] snd_seq_oss_write+0x9b/0x160 [snd_seq_oss]
[  496.644870]  [<e098c0e9>] odev_write+0x29/0x30 [snd_seq_oss]
[  496.644899]  [<c016f578>] vfs_write+0x1c8/0x1d0
[  496.644919]  [<c016f64b>] sys_write+0x4b/0x80
[  496.644935]  [<c0102ffb>] syscall_call+0x7/0xb
[  503.809692] mtrr: no MTRR for e3000000,800000 found
[  503.835473] kobject_uevent
[  503.835509] fill_kobj_path: path = '/class/vc/vcs8'
[  503.840894] kobject vcs8: cleaning up
[  503.840936] kobject_uevent
[  503.840952] fill_kobj_path: path = '/class/vc/vcsa8'
[  503.842470] kobject vcsa8: cleaning up
[  503.940233] kobject_uevent
[  503.940257] fill_kobj_path: path = '/block/loop0'

[7.] A small shell script or example program which triggers the
     problem (if possible)

I can trigger it again with wine and the windows program "nijntje".

[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux jumbo 2.6.18 #3 SMP Sun Oct 8 22:02:52 CEST 2006 i686 pentium3
i386 GNU/Linux
 
Gnu C                  3.4.6
Gnu make               3.81
binutils               2.15.92.0.2
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.38
jfsutils               1.1.11
quota-tools            3.13.
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.3
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.97
udev                   097
Modules Loaded         snd_rtctimer isofs nfsd exportfs lockd sunrpc
ext3 jbd capability commoncap usblp parport_pc lp parport w83781d
hwmon_vid hwmon eeprom i2c_isa i2c_dev mga drm psmouse de4x5 de2104x
snd_seq_midi snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq
snd_pcm_oss snd_mixer_oss ppp_deflate zlib_deflate zlib_inflate
ppp_async crc_ccitt ppp_generic slip slhc videodev zd1201 v4l1_compat
v4l2_common firmware_class evdev pcspkr sg shpchp snd_ens1370 gameport
snd_rawmidi snd_seq_device snd_pcm snd_timer snd_ak4531_codec snd
intel_agp soundcore i2c_piix4 agpgart uhci_hcd i2c_core snd_page_alloc
pcnet32 ne2k_pci serio_raw 8390 mii

[8.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 501.164
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1005.63

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 3
cpu MHz		: 501.164
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1002.38

[8.3.] Module information (from /proc/modules):

snd_rtctimer 3596 0 - Live 0xe0a55000
isofs 33648 0 - Live 0xe0a83000
nfsd 223152 13 - Live 0xe0ab1000
exportfs 6144 1 nfsd, Live 0xe09c3000
lockd 61352 2 nfsd, Live 0xe0a0d000
sunrpc 143708 8 nfsd,lockd, Live 0xe0a30000
ext3 132152 14 - Live 0xe0a57000
jbd 57696 1 ext3, Live 0xe0a20000
capability 4360 0 - Live 0xe09a9000
commoncap 6400 1 capability, Live 0xe09a6000
usblp 13448 0 - Live 0xe09be000
parport_pc 26692 1 - Live 0xe0a05000
lp 11880 0 - Live 0xe09ba000
parport 34664 2 parport_pc,lp, Live 0xe09fb000
w83781d 34232 0 - Live 0xe09f1000
hwmon_vid 3968 1 w83781d, Live 0xe0956000
hwmon 3588 1 w83781d, Live 0xe0900000
eeprom 6808 0 - Live 0xe09a3000
i2c_isa 5000 1 w83781d, Live 0xe09a0000
i2c_dev 8964 0 - Live 0xe099c000
mga 61952 0 - Live 0xe09e0000
drm 65332 1 mga, Live 0xe09cf000
psmouse 40456 0 - Live 0xe0980000
de4x5 51248 0 - Live 0xe09ac000
de2104x 20104 0 - Live 0xe0996000
snd_seq_midi 7840 0 - Live 0xe0946000
snd_seq_dummy 3972 0 - Live 0xe0951000
snd_seq_oss 33680 0 - Live 0xe098c000
snd_seq_midi_event 7304 2 snd_seq_midi,snd_seq_oss, Live 0xe08b4000
snd_seq 51768 6 snd_seq_midi,snd_seq_dummy,snd_seq_oss,snd_seq_midi_event, Live 0xe0965000
snd_pcm_oss 45344 0 - Live 0xe0973000
snd_mixer_oss 17032 1 snd_pcm_oss, Live 0xe095f000
ppp_deflate 6016 0 - Live 0xe0943000
zlib_deflate 21656 1 ppp_deflate, Live 0xe0958000
zlib_inflate 14976 2 isofs,ppp_deflate, Live 0xe0935000
ppp_async 11032 0 - Live 0xe093f000
crc_ccitt 2944 1 ppp_async, Live 0xe08fe000
ppp_generic 26948 2 ppp_deflate,ppp_async, Live 0xe0949000
slip 12520 0 - Live 0xe093a000
slhc 6912 2 ppp_generic,slip, Live 0xe08af000
videodev 25376 0 - Live 0xe091f000
zd1201 22668 0 - Live 0xe092e000
v4l1_compat 14084 1 videodev, Live 0xe0906000
v4l2_common 22400 1 videodev, Live 0xe0927000
firmware_class 9216 1 zd1201, Live 0xe0866000
evdev 9472 0 - Live 0xe0902000
pcspkr 3712 0 - Live 0xe08b2000
sg 30372 0 - Live 0xe0916000
shpchp 37336 0 - Live 0xe090b000
snd_ens1370 18016 1 - Live 0xe08f8000
gameport 13848 1 snd_ens1370, Live 0xe08a3000
snd_rawmidi 21568 2 snd_seq_midi,snd_ens1370, Live 0xe08f1000
snd_seq_device 7956 5 snd_seq_midi,snd_seq_dummy,snd_seq_oss,snd_seq,snd_rawmidi, Live 0xe086e000
snd_pcm 76460 2 snd_pcm_oss,snd_ens1370, Live 0xe08cc000
snd_timer 22556 3 snd_rtctimer,snd_seq,snd_pcm, Live 0xe08b7000
snd_ak4531_codec 8840 1 snd_ens1370, Live 0xe089f000
snd 47524 12 snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_ens1370,snd_rawmidi,snd_seq_device,snd_pcm,snd_timer,snd_ak4531_codec, Live 0xe08bf000
intel_agp 21916 1 - Live 0xe08a8000
soundcore 8672 1 snd, Live 0xe089b000
i2c_piix4 8972 0 - Live 0xe088d000
agpgart 30488 2 drm,intel_agp, Live 0xe0892000
uhci_hcd 23828 0 - Live 0xe087b000
i2c_core 19088 5 w83781d,eeprom,i2c_isa,i2c_dev,i2c_piix4, Live 0xe0882000
snd_page_alloc 9224 2 snd_ens1370,snd_pcm, Live 0xe086a000
pcnet32 33412 0 - Live 0xe0871000
ne2k_pci 9952 0 - Live 0xe085e000
serio_raw 6916 0 - Live 0xe0858000
8390 9736 1 ne2k_pci, Live 0xe0862000
mii 6144 1 pcnet32, Live 0xe085b000
[8.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

[8.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host
bridge (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x1

00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP
bridge (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e1800000-e2bfffff
        Prefetchable memory behind bridge: e2f00000-e3ffffff
        Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:04.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:04.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev
01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]

00:04.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev
01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at d400 [size=32]

00:04.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:06.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891
        Subsystem: Adaptec 2940U2W SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (9750ns min, 6250ns max)
        Interrupt: pin A routed to IRQ 19
        BIST result: 00
        Region 0: I/O ports at d000 [disabled] [size=256]
        Region 1: Memory at e1000000 (64-bit, non-prefetchable)
[size=4K]
        [virtual] Expansion ROM at 30200000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Winbond Electronics Corp W89C940
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at b800 [size=32]

00:0a.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970
[PCnet32 LANCE] (rev 33)
        Subsystem: Hewlett-Packard Company Ethernet with LAN remote
power Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (6000ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at b400 [size=32]
        Region 1: Memory at e0800000 (32-bit, non-prefetchable)
[size=32]
        [virtual] Expansion ROM at 30000000 [disabled] [size=1M]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=220mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

00:0b.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970
[PCnet32 LANCE] (rev 33)
        Subsystem: Hewlett-Packard Company Ethernet with LAN remote
power Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (6000ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at b000 [size=32]
        Region 1: Memory at e0000000 (32-bit, non-prefetchable)
[size=32]
        [virtual] Expansion ROM at 30100000 [disabled] [size=1M]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=220mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

00:0c.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
        Subsystem: Unknown device 4942:4c4c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at a800 [size=64]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP
(rev 01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. MGA-G200 AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e3000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at e2000000 (32-bit, non-prefetchable)
[size=16K]
        Region 2: Memory at e1800000 (32-bit, non-prefetchable)
[size=8M]
        Expansion ROM at e2ff0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit-
FW- Rate=x1

[8.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-32TS   Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: QUANTUM  Model: VIKING II 4.5WLS Rev: 4110
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 12 Lun: 00
  Vendor: QUANTUM  Model: ATLAS IV 9 WLS   Rev: 0B0B
  Type:   Direct-Access                    ANSI SCSI revision: 03

[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Wine version 0.9.20.

$ cat /proc/locks 
1: POSIX  ADVISORY  WRITE 3218 08:07:16270 0 EOF
2: POSIX  ADVISORY  WRITE 3125 08:07:32554 0 EOF
3: POSIX  ADVISORY  WRITE 3122 08:07:16263 0 EOF
4: POSIX  ADVISORY  WRITE 3119 08:07:16262 0 EOF
5: FLOCK  ADVISORY  WRITE 3030 08:07:16250 0 EOF
6: FLOCK  ADVISORY  WRITE 3027 08:07:16248 0 EOF

# cat /proc/lockdep
all lock classes:
c1688d04 OPS:  297223 FD:    2 BD: 5322 ++..: &rq->rq_lock_key
c03f98d0 OPS:  124649 FD:    1 BD:   27 ++..: i8259A_lock
c06b57bc OPS:  305120 FD:    4 BD:   12 ++..: &irq_desc_lock_class
c03f9cd0 OPS:   12333 FD:    1 BD:    1 ....: i8253_lock
c0489494 OPS:  124259 FD:    5 BD:    1 ++..: xtime_lock
c03fd29c OPS:  124262 FD:    1 BD:    2 ++..: clocksource_lock
c03f9530 OPS:      28 FD:    3 BD:   18 +...: rtc_lock
c0409a9c OPS:  130747 FD:    2 BD:    5 ....: tty_ldisc_lock
c03fb8c8 OPS:     115 FD:    1 BD:    3 ----: resource_lock
c0504640 OPS:  205314 FD:    1 BD:  713 ++..: base_lock_keys + cpu
c04068f0 OPS:  119031 FD:    1 BD:    2 ....: vga_lock
c03fb6fc OPS:  447872 FD:    1 BD:    3 ....: logbuf_lock
c06b5808 OPS:   15900 FD:    1 BD: 3056 .+..: &zone->lock
c0402fd8 OPS:       2 FD:    1 BD:    1 --..: kclist_lock
c0400494 OPS:     486 FD:    9 BD:    8 --..: cache_chain_mutex
c06b61a4 OPS:   38710 FD:    3 BD: 1978 ++..: &parent->list_lock
c06b61d0 OPS:     881 FD:    1 BD:  183 ....: &on_slab_key
c06b61b8 OPS:     758 FD:    1 BD:  395 ....: &ptr->list_lock
c03fa548 OPS:     974 FD:    1 BD:   33 --..: call_lock
c03ffbe8 OPS:       4 FD:    1 BD:    1 --..: shrinker_rwsem
c0400b24 OPS:      61 FD:    1 BD:    1 ----: file_systems_lock
c0400558 OPS:    1131 FD:    7 BD:   29 --..: sb_lock
c0403368 OPS:       3 FD:   37 BD:    1 --..: &type->s_umount_key
c06b73d0 OPS:      31 FD:    1 BD:  120 ....: &idp->lock
c04005d0 OPS:      15 FD:    2 BD:   30 --..: unnamed_dev_lock
c0400a60 OPS:   70919 FD:    8 BD:  682 --..: inode_lock
c0490810 OPS:  309777 FD:   15 BD:  162 --..: dcache_lock
c06b6748 OPS: 1001052 FD:    2 BD:  398 --..: &dentry->d_lock
c06b62b4 OPS:      26 FD:    2 BD:   11 --..: &s->s_dquot.dqonoff_mutex
c0401150 OPS:      13 FD:    1 BD:   12 --..: dq_list_lock
c0403360 OPS:       3 FD:    1 BD:    2 --..: &type->s_lock_key
c06b6ab0 OPS:   15157 FD:  415 BD:   51 --..: &sysfs_inode_imutex_key
c0403968 OPS:       1 FD:   31 BD:    1 --..: &type->s_umount_key#2
c0489210 OPS:   22045 FD:   26 BD:   17 ..??: tasklist_lock
c03f7894 OPS:    1321 FD:    1 BD:    1 ----: old_style_rw_init
c0400668 OPS:     105 FD:  110 BD:    1 ----: &type->s_umount_key#3
c0401668 OPS:       2 FD:   37 BD:    1 --..: &type->s_umount_key#4
c0401660 OPS:       4 FD:    1 BD:    2 --..: &type->s_lock_key#2
c04025d0 OPS:   40328 FD:    4 BD:   26 --..: proc_subdir_lock
c04026e0 OPS:      74 FD:    1 BD:   47 ....: proc_inum_idr.lock
c04026fc OPS:     706 FD:    2 BD:   39 --..: proc_inum_lock
c0489510 OPS:    6968 FD:    1 BD:  214 ....: pidmap_lock
c03f7990 OPS:     838 FD:    1 BD:    2 --..: init_task.file_lock
c03f8844 OPS:       1 FD:    1 BD:    1 --..: init_task.alloc_lock
c03f8134 OPS:      35 FD:    2 BD:   18 ....: init_sighand.siglock
c04e2a1c OPS:  191560 FD:    1 BD:   11 --..: &newf->file_lock
c04e2a24 OPS:   30804 FD:    1 BD:   27 --..: &p->alloc_lock
c1690d04 OPS:  299253 FD:    1 BD: 8369 ++..: &rq->rq_lock_key#2
c03fa130 OPS:       3 FD:    1 BD:    6 +...: set_atomicity_lock
c03fac18 OPS:     317 FD:    2 BD:   13 +...: ioapic_lock
c03fac34 OPS:      15 FD:    1 BD:    1 ....: vector_lock
c0505230 OPS:  801327 FD:    7 BD: 2366 ++..: &q->lock
c04e2a34 OPS:  133192 FD:   17 BD:  198 ++..: &sighand->siglock
c03fb630 OPS:       1 FD:    1 BD:    1 ....: panic_notifier_list.lock
c03fd794 OPS:       1 FD:   54 BD:    1 --..: cpu_add_remove_lock
c04c4d48 OPS:       2 FD:   52 BD:    2 ..--: (cpu_chain).rwsem
c04e2a2c OPS:     142 FD:    4 BD:    1 ....: &p->pi_lock
c03fd7d4 OPS:       1 FD:    1 BD:    2 --..: cpu_bitmask_lock
c03ffd74 OPS:    1735 FD:    2 BD:   12 ----: vmlist_lock
c03f81b8 OPS:       4 FD:    1 BD:    1 --..: init_mm.page_table_lock
c0504648 OPS:  196014 FD:    1 BD:  626 ++..: base_lock_keys + cpu#2
c06b6894 OPS:  138258 FD:  751 BD:   10 --..: &inode->i_mutex
c06b6895 OPS:    8899 FD: 1135 BD:    3 --..: &inode->i_mutex/1
c03fcf10 OPS:   27118 FD:    1 BD:    1 -+..: &rcu_ctrlblk.lock
c03fcdf4 OPS:     137 FD:   51 BD:    6 --..: workqueue_mutex
c06b73dc OPS:    1141 FD:    1 BD:   46 --..: &k->list_lock
c0400754 OPS:    1219 FD:    1 BD:    1 ----: binfmt_lock
c0422528 OPS:       1 FD:   34 BD:    1 --..: &type->s_umount_key#5
c0422788 OPS:       6 FD:    1 BD:    1 --..: proto_list_lock
c0422484 OPS:       4 FD:    1 BD:    1 --..: net_family_lock
c04243b4 OPS:    2050 FD:    1 BD:    1 ..-?: nl_table_lock
c0424390 OPS:    1954 FD:    1 BD:   54 .+..: nl_table_wait.lock
c0423374 OPS:     250 FD: 1002 BD:    1 --..: rtnl_mutex
c0422cb4 OPS:     250 FD:    1 BD:    1 --..: net_todo_run_mutex
c0405670 OPS:    1788 FD:    1 BD:   52 --..: sequence_lock
c0504eb0 OPS:   12927 FD:    8 BD:  229 ++..: &cwq->lock
c04e2a14 OPS:  170125 FD:    1 BD:    1 ----: &fs->lock
c1689030 OPS:  111650 FD:    1 BD:  199 .+..: &base->lock_key
c040cbd0 OPS:       2 FD:    1 BD:   14 +...: sysrq_key_table_lock
c04006b4 OPS:      96 FD:    1 BD:    1 --..: chrdevs_lock
c03fc924 OPS:     207 FD:    5 BD:    3 --..: sysctl_lock
c06d0d84 OPS:    1286 FD:    8 BD:    6 --..: &k->k_lock
c041e8ac OPS:      15 FD:    4 BD:    2 ++..: hub_event_lock
c041e8d0 OPS:       8 FD:    3 BD:    3 +...: khubd_wait.lock
c0405d48 OPS:   13998 FD:    1 BD:    2 ----: pci_bus_sem
c041fcd4 OPS:       6 FD: 1536 BD:    1 --..: serio_mutex
c041fcf8 OPS:      16 FD:    4 BD:    2 ....: serio_event_lock
c041fd30 OPS:      18 FD:    3 BD:    3 ....: serio_wait.lock
c0405790 OPS:    2705 FD:    2 BD:  174 +...: pci_lock
c0422380 OPS:    2705 FD:    1 BD:  175 +...: pci_config_lock
c0424190 OPS:       3 FD:    1 BD:    1 --..: qdisc_mod_lock
c0424994 OPS:       2 FD:    1 BD:    1 --..: genl_mutex
c0400948 OPS:       1 FD:   31 BD:    1 --..: &type->s_umount_key#6
c0421e14 OPS:       1 FD:    1 BD:    1 --..: cpufreq_governor_mutex
c0425288 OPS:       4 FD:    1 BD:    1 -...: inet_proto_lock
c0427090 OPS:       3 FD:    1 BD:    1 -...: inetsw_lock
c0409490 OPS:   32503 FD:    1 BD:   45 ++..: &input_pool.lock
c0409690 OPS:    1993 FD:    2 BD:   11 .+..: &nonblocking_pool.lock
c04093b0 OPS:      68 FD:    1 BD:   12 .+..: random_write_wait.lock
c0422dd0 OPS:       1 FD:    1 BD:    1 --..: neigh_tbl_lock
c0422af0 OPS:       7 FD:    1 BD:    5 -...: ptype_lock
c0428ab4 OPS:       1 FD:    1 BD:    1 -...: xfrm_state_afinfo_lock
c04289ec OPS:       1 FD:    1 BD:    1 -...: xfrm_policy_afinfo_lock
c0490790 OPS:     562 FD:    1 BD:    6 --..: bdev_lock
c0425b10 OPS:       6 FD:    1 BD:    1 -...: raw_v4_lock
c06c9c40 OPS:     140 FD:    6 BD:    6 -+-+: &tbl->lock
c0425a10 OPS:       2 FD:    1 BD:    1 --..: tcp_cong_list_lock
c03fcad0 OPS:      59 FD:    1 BD:    1 .+..: uidhash_lock
c06b68c4 OPS:    1493 FD:   29 BD:   59 --..: &inode->inotify_mutex
c03fd668 OPS:       1 FD:   31 BD:    1 --..: &type->s_umount_key#7
c06b5810 OPS:  103140 FD:    1 BD:  390 ....: &zone->lru_lock
c03ffb5c OPS:     299 FD:    4 BD:    1 .+..: pdflush_lock
c04002a8 OPS:     107 FD:   76 BD:    1 ----: &type->s_umount_key#8
c0400fc8 OPS:       1 FD:   31 BD:    1 --..: &type->s_umount_key#9
c0401008 OPS:       1 FD:   31 BD:    1 --..: &type->s_umount_key#10
c0403448 OPS:       2 FD:   34 BD:    1 --..: &type->s_umount_key#11
c0403440 OPS:       4 FD:    1 BD:    2 --..: &type->s_lock_key#3
c04046c8 OPS:       1 FD:   38 BD:    1 --..: &type->s_umount_key#12
c04046c0 OPS:       1 FD:    1 BD:    2 --..: &type->s_lock_key#4
c0404a28 OPS:       1 FD:    1 BD:    1 --..: crypto_alg_sem
c0404bf0 OPS:      41 FD:    1 BD:    2 ....: elv_list_lock
c06b7524 OPS:     485 FD:    1 BD:    1 --..: &drv->dynids.lock
c04088e0 OPS:       1 FD:    1 BD:    1 --..: pnp_lock
c0409590 OPS:       3 FD:    1 BD:    1 ....: &blocking_pool.lock
c1691030 OPS:  121561 FD:    1 BD:  199 .+..: &base->lock_key#2
c0420670 OPS:       6 FD:    1 BD:    6 ....: input_devices_poll_wait.lock
c040cf34 OPS:       4 FD:  469 BD:    1 --..: port_mutex
c06bc4e8 OPS:      20 FD:  468 BD:    2 --..: &state->mutex
c06bc4f8 OPS:      77 FD:    1 BD:    7 +...: &port_lock_key
c03fde74 OPS:       6 FD:    8 BD:    3 --..: probing_active
c0404d34 OPS:     280 FD:    2 BD:    5 --..: block_subsys_lock
c040fee0 OPS:       7 FD:    2 BD:    1 ....: floppy_lock
c0410810 OPS:       1 FD:    1 BD:    1 ....: floppy_usage_lock
c03fd690 OPS:       5 FD:    1 BD:    1 +...: dma_spin_lock
c04106b8 OPS:       3 FD:    1 BD:    1 +...: floppy_hlt_lock
c0410610 OPS:       6 FD:    3 BD:    1 ....: command_done.lock
c04105d0 OPS:       4 FD:    3 BD:    1 ....: fdc_wait.lock
c0423f10 OPS:      10 FD:    5 BD:    2 -...: qdisc_tree_lock
c06c91bc OPS:     645 FD:    4 BD:   10 -+..: &dev->queue_lock
c0422b10 OPS:    1745 FD:    1 BD:    2 -.--: dev_base_lock
c04144f0 OPS:       4 FD:    3 BD:    1 ....: tune_lock
c0490990 OPS:    4875 FD:   29 BD:   21 ++..: ide_lock
c06b6310 OPS:     263 FD:  621 BD:    3 --..: &bdev->bd_mutex
c0417554 OPS:      47 FD:    1 BD:    8 --..: idedisk_ref_mutex
c06b68a4 OPS:  824126 FD:    5 BD:  892 ++..: &inode->i_data.tree_lock
c06b68b4 OPS:   55019 FD:    6 BD:  240 --..: &inode->i_data.private_lock
c06b73a4 OPS:   28452 FD:    1 BD:  192 ++..: &ret->lock
c041e3c8 OPS:       2 FD:    1 BD:    1 --..: cdrom_lock
c0417bf4 OPS:       1 FD:   10 BD:    1 --..: host_cmd_pool_mutex
c04185d4 OPS:       1 FD:    7 BD:    1 --..: global_host_template_mutex
c06c7960 OPS:   35507 FD:    5 BD:  172 ++..: &ahc->platform_data->spin_lock
c06c74cc OPS:   66113 FD:    6 BD:  168 .+..: &shost->default_lock
c06c74d4 OPS:      21 FD:  705 BD:    1 --..: &shost->scan_mutex
c06b6f6c OPS:  166076 FD:   26 BD:  170 .+..: &q->__queue_lock
c06c74ec OPS:   32934 FD:    1 BD:  171 .+..: &sdev->list_lock
c06c74c4 OPS:   16467 FD:    1 BD:    1 .+..: &shost->free_list_lock
c06b6f64 OPS:      31 FD:    1 BD:    2 --..: &q->sysfs_lock
c06b6f40 OPS:      31 FD:   54 BD:    2 --..: &eq->sysfs_lock
c06c7728 OPS:       3 FD:   53 BD:    2 --..: &spi_dv_mutex(starget)
c041dd80 OPS:      16 FD:    1 BD:    2 ....: sd_index_idr.lock
c041dd9c OPS:       2 FD:    2 BD:    1 --..: sd_index_lock
c041ddf4 OPS:     143 FD:    1 BD:    8 --..: sd_ref_mutex
c041e228 OPS:       1 FD:    1 BD:    1 --..: sr_index_lock
c0420490 OPS:   13400 FD:    1 BD:   13 ++..: i8042_lock
c0490690 OPS:   66573 FD:    1 BD:   29 --..: files_lock
c04216d8 OPS:       3 FD:    1 BD:    1 --..: pers_lock
c0422014 OPS:       1 FD:    1 BD:    1 --..: triggers_list_lock
c0421ff0 OPS:       1 FD:    1 BD:    1 ..--: leds_list_lock
c0423d18 OPS:       1 FD:    1 BD:    1 -...: llc_sap_list_lock
c0424a10 OPS:       1 FD:    1 BD:    1 --..: afinfo_lock
c0428b18 OPS:       1 FD:    1 BD:    1 -...: xfrm_km_lock
c0429470 OPS:      16 FD:    1 BD:    1 -.--: packet_sklist_lock
c042189c OPS:       2 FD:    1 BD:    1 --..: all_mddevs_lock
c0421bf4 OPS:       1 FD:  437 BD:    1 --..: disks_mutex
c0409a14 OPS:     471 FD: 1285 BD:    1 --..: tty_mutex
c06c83cc OPS:       3 FD: 1087 BD:    2 --..: &serio->drv_mutex
c06c83c4 OPS:    4618 FD:   41 BD:   13 ++..: &serio->lock
c06c84c5 OPS:      67 FD:   55 BD:    7 --..: &ps2dev->cmd_mutex/1
c06c86e4 OPS:       2 FD:    1 BD:    4 --..: &new->reconfig_mutex
c06b68e0 OPS:      79 FD:  775 BD:    2 ----: &namespace_sem
c0490910 OPS:  143005 FD:    8 BD:  177 --..: vfsmount_lock
c06b6311 OPS:     368 FD:   42 BD:    4 --..: &bdev->bd_mutex/1
c06b6318 OPS:      19 FD: 1211 BD:    1 --..: &bdev->bd_mount_mutex
c0403748 OPS:     122 FD:  156 BD:    2 ----: &type->s_umount_key#13
c06c84e0 OPS:      12 FD:    1 BD:    3 --..: &dev->mutex
c06b68bc OPS:   16212 FD:   19 BD:  153 --..: &inode->i_lock
c04006d0 OPS:    1651 FD:    1 BD:    1 --..: cdev_lock
c06ba638 OPS:   41260 FD:    1 BD:    6 ....: &tty->read_lock
c0409ad0 OPS:   63678 FD:    1 BD:    7 ....: tty_ldisc_wait.lock
c03fb2b8 OPS:     437 FD:    1 BD: 1988 ....: pgd_lock
c06b6acc OPS:   33082 FD:    1 BD:   78 ----: &ei->i_meta_lock
c04e29fc OPS:  766779 FD:  365 BD:    1 ----: &mm->mmap_sem
c04e2a04 OPS:   29859 FD:    1 BD:  137 --..: &mm->page_table_lock
c06b58a0 OPS:  908494 FD:   25 BD:   72 --..: __pte_lockptr(new)
c06b68ac OPS:  154418 FD:    3 BD:   66 --..: &inode->i_data.i_mmap_lock
c04e2a35 OPS:       1 FD:    1 BD:   19 ....: &sighand->siglock/1
c03fa52c OPS:     243 FD:    1 BD:   74 --..: tlbstate_lock
c03fcc88 OPS:    2035 FD:   27 BD:    1 ----: uts_sem
c06b58b4 OPS:  108007 FD:    2 BD:   70 --..: &anon_vma->lock
c0409370 OPS:   15817 FD:    1 BD:   35 ++..: random_read_wait.lock
c04009c4 OPS:    2743 FD:    1 BD:   62 ..++: fasync_lock
c0409af4 OPS:   17256 FD:    1 BD:    1 --..: redirect_lock
c06ba630 OPS:   20206 FD:   28 BD:    1 --..: &tty->atomic_write_lock
c06b6214 OPS:     158 FD:    1 BD:    1 --..: &fbc->lock
c04e29fd OPS:    2501 FD:   57 BD:    2 --..: &mm->mmap_sem/1
c06b58a1 OPS:   37776 FD:    1 BD:   73 --..: __pte_lockptr(new)/1
c0428d54 OPS:    5938 FD:    1 BD:    2 --..: unix_table_lock
c06c8fc8 OPS:   51976 FD:    1 BD:    2 -.--: af_callback_keys + sk->sk_family
c06d0d48 OPS:   33116 FD:   11 BD:    1 --..: &u->lock
c06d0d58 OPS:  126536 FD:    1 BD:    3 --..: &af_unix_sk_receive_queue_lock_key
c06c8ec8 OPS:    3448 FD:    1 BD:    1 -...: slock-AF_UNIX
c06c8dc8 OPS:    1724 FD:    1 BD:    1 --..: sk_lock-AF_UNIX
c03ffe50 OPS:     143 FD:    1 BD:    3 --..: swap_lock
c06b6954 OPS:    3843 FD: 1299 BD:    1 --..: &p->lock
c03ffeb4 OPS:      37 FD:   17 BD:    2 --..: swapon_mutex
c06b6312 OPS:      24 FD:    1 BD:    4 --..: &bdev->bd_mutex/2
c0403740 OPS:      19 FD:   48 BD:    3 --..: &type->s_lock_key#5
c06b6ad4 OPS:     132 FD:    1 BD:   76 --..: &bgl->locks[i].lock
c06b6adc OPS:      27 FD:    1 BD:   11 --..: &sbi->s_next_gen_lock
c06b689c OPS:    1042 FD:  317 BD:   62 --..: &inode->i_alloc_sem
c06b6190 OPS:    7078 FD:    1 BD:   91 --..: &sbinfo->stat_lock
c041f5c8 OPS:       2 FD:   34 BD:    3 --..: &type->s_umount_key#14
c041f5c0 OPS:       4 FD:    1 BD:    4 --..: &type->s_lock_key#6
c06d0d50 OPS:   40111 FD: 1187 BD:    1 --..: &u->readlock
c06c8f40 OPS:      50 FD:    1 BD:    1 -...: slock-AF_NETLINK
c06c8e40 OPS:      25 FD:    1 BD:    1 --..: sk_lock-AF_NETLINK
c06b6188 OPS:    6744 FD:    8 BD:   76 --..: &info->lock
c06b6984 OPS:       1 FD:   33 BD:    1 --..: &dev->up_mutex
c06b6970 OPS:       2 FD:   28 BD:   60 --..: &ih->mutex
c06b697c OPS:    1682 FD:    1 BD:    1 --..: &dev->ev_mutex
c04031a8 OPS:     417 FD:  416 BD:    2 ----: sysfs_rename_sem
c06c8d7c OPS:    4720 FD:    1 BD:   55 -+..: &list->lock
c06c9040 OPS:    1085 FD:    1 BD:    1 -.--: af_callback_keys + sk->sk_family#2
c06b62a4 OPS:      38 FD: 1154 BD:    1 --..: &s->s_vfs_rename_mutex
c06b6896 OPS:      76 FD:   18 BD:    5 --..: &inode->i_mutex/2
c0490894 OPS:      77 FD:    4 BD:  163 --..: rename_lock
c06b6749 OPS:     122 FD:    1 BD:  562 --..: &dentry->d_lock/1
c03fd834 OPS:     470 FD:  456 BD:    2 --..: module_mutex
c03fd274 OPS:      69 FD:   11 BD:    3 --..: kthread_stop_lock
c03fd888 OPS:      69 FD:    1 BD:    1 ..--: (module_notify_list).rwsem
c03fd7f0 OPS:   19654 FD:    1 BD:  121 ....: modlist_lock
e0879204 OPS:    1877 FD:    6 BD:   13 ++..: &lp->lock
c041eb74 OPS:       6 FD: 1709 BD:    1 --..: usb_bus_list_lock
c041f428 OPS:       5 FD: 1214 BD:    2 ..--: (usb_notifier_list).rwsem
c0400e64 OPS:       2 FD:    1 BD:    3 --..: pin_fs_lock
c041f630 OPS:       5 FD:    1 BD:    3 ....: deviceconndiscwq.lock
c06be4e0 OPS:   34855 FD:    1 BD:    8 ++..: &retval->lock
c041e890 OPS:      24 FD:    1 BD:    5 ....: device_state_lock
c041ebac OPS:     629 FD:    1 BD:    6 ++..: hcd_data_lock
c06c7e7c OPS:     161 FD:    1 BD:    9 ++..: &urb->lock
c06c7ea0 OPS:      12 FD:    1 BD:    2 --..: &new_driver->dynids.lock
e0880d00 OPS:    2949 FD:   16 BD:    6 ++..: &uhci->lock
e08c99b4 OPS:      48 FD:    8 BD:    2 --..: info_mutex
c041eb90 OPS:       6 FD:    2 BD:    2 .+..: hcd_root_hub_lock
c06c7e54 OPS:       7 FD:    1 BD:    9 ++..: &urb->lock#2
e0885f54 OPS:       4 FD:  445 BD:    1 --..: core_lists
e0885f80 OPS:      15 FD:    1 BD:    2 ....: i2c_adapter_idr.lock
c03fb2d8 OPS:    9248 FD:    2 BD:    1 ....: cpa_lock
e08c9bb4 OPS:       4 FD:    1 BD:   11 --..: strings
e08bc114 OPS:       9 FD:    5 BD:    5 --..: register_mutex
e08c9874 OPS:      26 FD:  424 BD:   14 --..: sound_mutex
c041e974 OPS:       3 FD:   32 BD:    1 --..: usb_address0_mutex
e08c9a88 OPS:       7 FD:    1 BD:    1 ----: snd_ioctl_rwsem
e08a5c34 OPS:       1 FD:    2 BD:    1 --..: gameport_mutex
e08a5c58 OPS:       1 FD:    1 BD:    2 ....: gameport_event_lock
e08a5c90 OPS:       1 FD:    1 BD:    1 ....: gameport_wait.lock
c041e274 OPS:       8 FD:    1 BD:    4 --..: sr_ref_mutex
c0417774 OPS:       8 FD:    1 BD:    4 --..: idecd_ref_mutex
e08c9934 OPS:       3 FD:    1 BD:    1 --..: snd_card_mutex
e091cb20 OPS:       7 FD:    2 BD:    1 ....: sg_dev_arr_lock
c04056d8 OPS:    3678 FD:    4 BD:   18 ....: (kernel_sem).wait.lock
e08ca664 OPS:    1189 FD:    5 BD:    4 ----: &card->controls_rwsem
e08ca66c OPS:     120 FD:    1 BD:    1 ..--: &card->ctl_files_rwlock
e086bdd4 OPS:       3 FD:    1 BD:    1 --..: list_mutex
e08f5d14 OPS:       6 FD:  847 BD:    9 --..: register_mutex#2
e08c9b74 OPS:      15 FD:  421 BD:   12 --..: sound_oss_mutex
e089caf0 OPS:      19 FD:    1 BD:   13 --..: sound_loader_lock
e086f8b4 OPS:      10 FD:    1 BD:    1 --..: ops_mutex
e08f3cab OPS:       2 FD: 2998 BD:    1 --..: (struct lock_class_key *)id
e08ddd14 OPS:       3 FD:  861 BD:    1 --..: register_mutex#3
c06c8ed0 OPS:    4181 FD:   45 BD:    3 -+..: slock-AF_INET
c06c8dd0 OPS:    2000 FD:   80 BD:    2 --..: sk_lock-AF_INET
c0426070 OPS:     690 FD:    1 BD:    4 -.-+: udp_hash_lock
c06c8fd0 OPS:     949 FD:    1 BD:    4 -.-+: af_callback_keys + sk->sk_family#3
c06c8a20 OPS:     482 FD:    1 BD:    1 ..-+: &trigger->leddev_list_lock
e0867c54 OPS:      20 FD:    3 BD:    1 --..: fw_lock
e0933880 OPS:     139 FD:    1 BD:    7 ++..: &urb->lock#3
c040ccb0 OPS:       3 FD:    4 BD:    1 +...: rtc_wait.lock
c040ccd8 OPS:       7 FD:    1 BD:   31 +...: rtc_task_lock
e094f2ec OPS:       2 FD:    1 BD:    1 --..: compressor_list_lock
e0970dd4 OPS:       5 FD:  427 BD:    3 --..: register_mutex#4
e0970d90 OPS:     446 FD:    1 BD:   11 ....: clients_lock
e09715c0 OPS:       8 FD:    2 BD:    4 --..: &client->ports_mutex
e09715b8 OPS:      64 FD:    1 BD:    5 ..--: &client->ports_lock
e0993a54 OPS:       4 FD: 1340 BD:    1 --..: register_mutex#5
e0971a24 OPS:      26 FD:  870 BD:    4 ----: &grp->list_mutex
e0993b84 OPS:      25 FD:    1 BD:    6 ....: register_lock
e0971a25 OPS:       8 FD:  855 BD:    5 --..: &grp->list_mutex/1
e0971a1c OPS:       8 FD:    1 BD:    6 ....: &grp->list_lock
e0991140 OPS:       1 FD:    1 BD:    1 --..: (struct lock_class_key *)id#2
e0947834 OPS:       1 FD: 2150 BD:    2 --..: register_mutex#6
e0988db4 OPS:       1 FD:  539 BD:    3 --..: psmouse_mutex
c03fa054 OPS:      16 FD:    3 BD:    5 --..: mtrr_mutex
e09def24 OPS:     342 FD:   17 BD:    4 --..: &dev->struct_mutex
e099d470 OPS:       1 FD:    1 BD:    2 --..: i2c_dev_array_lock
e0886a88 OPS:      27 FD:    1 BD:    2 --..: &adap->clist_lock
e0886a80 OPS:      27 FD:    3 BD:    2 --..: &adap->bus_lock
e09f9580 OPS:      16 FD:    1 BD:    1 --..: &data->lock
e09a1380 OPS:       1 FD:    1 BD:    1 --..: &isa_adapter.clist_lock
e0900780 OPS:      15 FD:    1 BD:    2 ....: hwmon_idr.lock
e090079c OPS:       1 FD:    2 BD:    1 --..: idr_lock
e0a02e84 OPS:       5 FD:    1 BD:    1 --..: full_list_lock
e0a0a598 OPS:       1 FD:    1 BD:    1 --..: ports_lock
e0a030e0 OPS:       8 FD:    1 BD:    2 --..: topology_lock
e0a03710 OPS:       5 FD:    1 BD:    2 --..: &tmp->pardevice_lock
e0a03700 OPS:      16 FD:    1 BD:    1 ....: &tmp->cad_lock
e0a03708 OPS:       2 FD:    1 BD:    1 --..: &tmp->waitlist_lock
e0a02ed4 OPS:       2 FD:  443 BD:    1 --..: registration_lock
e0a02e60 OPS:       1 FD:    1 BD:    2 ....: parportlist_lock
c0401124 OPS:       1 FD:    1 BD:    1 --..: mb_cache_spinlock
e0a76c88 OPS:     537 FD:  915 BD:    2 ----: &type->s_umount_key#15
e0a2e13c OPS:   64681 FD:   43 BD:   82 --..: &journal->j_state_lock
e0a2e11c OPS:      14 FD:   68 BD:    3 --..: &journal->j_barrier
e0a2e134 OPS:   23862 FD:   24 BD:  316 --..: &journal->j_list_lock
e0a2e100 OPS:   60332 FD:    8 BD:   83 --..: &transaction->t_handle_lock
e0a2e108 OPS:     987 FD:    1 BD:  231 --..: &journal->j_revoke_lock
e0a76c80 OPS:     520 FD:   35 BD:   78 --..: &type->s_lock_key#7
e0a77408 OPS:     724 FD:  117 BD:   76 --..: &ei->truncate_mutex
e0a77410 OPS:     654 FD:    1 BD:   90 --..: &bgl->locks[i].lock#2
c06b3360 OPS:     182 FD:    8 BD:    2 --..: &futex_queues[i].lock
e0a77418 OPS:     105 FD:    1 BD:   14 --..: &sbi->s_next_gen_lock#2
e0a77428 OPS:     436 FD:    1 BD:   77 --..: &sbi->s_rsv_window_lock
c0426968 OPS:       2 FD:   18 BD:    2 ..--: (inetaddr_chain).rwsem
c0427f10 OPS:     213 FD:    1 BD:    4 -.-?: fib_hash_lock
c0427ed8 OPS:      14 FD:    1 BD:    4 -...: fib_info_lock
c0424de4 OPS:      18 FD:    2 BD:    4 -...: rt_flush_lock
c06c91c4 OPS:     736 FD:   37 BD:    2 -+..: &dev->_xmit_lock
c06cb800 OPS:       2 FD:    1 BD:    2 -...: &in_dev->mc_list_lock
c06cb808 OPS:       2 FD:    1 BD:    2 -...: &in_dev->mc_tomb_lock
c06ca9d8 OPS:   16426 FD:   10 BD:    4 -+..: &rt_hash_locks[i]
c06c8f48 OPS:       6 FD:    1 BD:    1 -...: slock-AF_PACKET
c06c8e48 OPS:       3 FD:   13 BD:    1 --..: sk_lock-AF_PACKET
c06d0d78 OPS:       4 FD:    2 BD:    3 --..: &po->bind_lock
c06c8d94 OPS:     628 FD:    1 BD:    3 ----: &sk->sk_dst_lock
c06c9048 OPS:     653 FD:    1 BD:    1 ..-+: af_callback_keys + sk->sk_family#4
c06c9c30 OPS:     243 FD:    4 BD:    9 -+-+: &n->lock
c06c9c28 OPS:       1 FD:    1 BD:   10 .+..: &list->lock#2
c03fd010 OPS:       9 FD:    1 BD:    1 -+..: &rcu_bh_ctrlblk.lock
c0423588 OPS:       2 FD:    1 BD:    2 +...: lweventlist_lock
c06c9d64 OPS:       3 FD:    1 BD:    2 .+..: &list->lock#3
c06c9ec0 OPS:       3 FD:    1 BD:   11 ....: &list->lock#4
c06cafbc OPS:     103 FD:    5 BD:    7 -+..: &tcp_hashinfo.bhash[i].lock
c06c90c0 OPS:      34 FD:    1 BD:    7 -+..: &queue->syn_wait_lock
c0490b10 OPS:      35 FD:    1 BD:    3 -.-+: tcp_hashinfo.lhash_lock
c0490b30 OPS:      22 FD:    1 BD:    3 ....: tcp_hashinfo.lhash_wait.lock
c06c9f44 OPS:     168 FD:    8 BD:    2 --..: &nlk->cb_lock
c03fb650 OPS:     137 FD:    4 BD:    3 ....: log_wait.lock
c06c9c38 OPS:     636 FD:    1 BD:    1 ..-+: &hh->hh_lock
e0a4ed58 OPS:      34 FD:    1 BD:    1 --..: cache_list_lock
e0add448 OPS:       1 FD:   38 BD:    1 --..: &type->s_umount_key#16
e0add440 OPS:       1 FD:    1 BD:    2 --..: &type->s_lock_key#8
c0400e80 OPS:       1 FD:    1 BD:    1 --..: simple_transaction_lock
e0adf034 OPS:       5 FD:  778 BD:    1 --..: client_mutex
e0a4e930 OPS:      36 FD:    1 BD:    2 --..: rpc_sched_lock
e0a4e9b0 OPS:      54 FD:    1 BD:    2 --..: rpc_credcache_lock
e0a4fb8c OPS:      36 FD:   11 BD:    2 --..: &xprt->reserve_lock
e0a4fb84 OPS:     144 FD:   13 BD:    2 -+..: &xprt->transport_lock
e0a4fb98 OPS:     142 FD:   10 BD:    6 -+..: &queue->lock
e0a4e730 OPS:      18 FD:    1 BD:    2 ....: destroy_wait.lock
e0a4fba8 OPS:      40 FD:    8 BD:    2 -...: &serv->sv_lock
e0a1a794 OPS:       8 FD:  308 BD:    1 --..: nlmsvc_mutex
e0a1a7b4 OPS:       3 FD:    2 BD:    2 ....: (lockd_start_done).wait.lock
e0a4e914 OPS:       1 FD:   52 BD:    1 --..: rpciod_mutex
e0a4ede4 OPS:       6 FD:    1 BD:    1 --..: queue_lock
e0a4ee50 OPS:       3 FD:    1 BD:    1 ....: queue_wait.lock
c06b6ae4 OPS:       5 FD:    1 BD:   14 --..: &fbc->lock#2
c06b73e4 OPS:      28 FD:    2 BD:    2 ..--: &s->rwsem
c06bc508 OPS:      22 FD:    2 BD:    3 +...: &irq_lists[i].lock
c06cafb4 OPS:     481 FD:    1 BD:   14 -+-+: &tcp_hashinfo.ehash[i].lock
c06c8ed1 OPS:     421 FD:   80 BD:    1 -+..: slock-AF_INET/1
c06c82cc OPS:      48 FD:    1 BD:    1 ....: &ps->lock
c0425970 OPS:      40 FD:    3 BD:    2 -+..: tcp_death_row.death_lock
e0a77420 OPS:      19 FD:    1 BD:   77 --..: &fbc->lock#3
e08ca674 OPS:      55 FD:    1 BD:    1 --..: &card->files_lock
e08ca6a8 OPS:      28 FD:    8 BD:    3 --..: &ctl->read_lock
e08ca67c OPS:    1090 FD:   56 BD:    2 --..: &card->power_lock
e08a1280 OPS:     577 FD:    3 BD:    5 --..: &ak4531->reg_mutex
e08fc620 OPS:      20 FD:    1 BD:   20 ....: &ensoniq->reg_lock
c06b6b00 OPS:     143 FD:   39 BD:    2 --..: &ids->mutex
c06b6b08 OPS:     222 FD:    1 BD:    6 --..: &new->lock
c06ba628 OPS:    4352 FD:   43 BD:    1 --..: &tty->atomic_read_lock
c06d0d49 OPS:      87 FD:    1 BD:    2 --..: &u->lock/1
c0409d90 OPS:       8 FD:    3 BD:    1 ....: vt_activate_queue.lock
c06c869c OPS:       4 FD:   56 BD:    1 --..: &atkbd->event_mutex
c06b6204 OPS:     831 FD:    1 BD:  154 ..??: &f->f_owner.lock
e0adf050 OPS:       4 FD:    1 BD:    2 --..: recall_lock
c042524c OPS:       3 FD:    1 BD:    1 -+..: inet_peer_unused_lock
c06ba620 OPS:    2718 FD:    4 BD:   14 ++..: &tty->buf.lock
c0410214 OPS:       2 FD:    2 BD:    4 --..: open_lock
c0409a40 OPS:      16 FD:    1 BD:    1 ....: allocated_ptys.lock
c06c8540 OPS:    1361 FD:    1 BD:   14 ++..: &list->packet_lock
c06c8d84 OPS:       1 FD:    1 BD:    3 --..: &newsk->sk_dst_lock
c0404c54 OPS:      22 FD:    2 BD:  171 .+..: congestion_wqh[1].lock
e08b2730 OPS:      12 FD:    1 BD:    1 .+..: i8253_beep_lock
c06c0680 OPS:       6 FD:   41 BD:    6 --..: &lo->lo_ctl_mutex
e0a89c08 OPS:       2 FD:  127 BD:    2 --..: &type->s_umount_key#17
c06c0688 OPS:     934 FD:    1 BD:   13 ....: &lo->lo_lock
e09def1c OPS:      23 FD:    1 BD:    1 --..: &dev->count_lock
e09def2c OPS:       8 FD:    1 BD:    1 --..: &dev->ctxlist_mutex
e09def04 OPS:    1020 FD:    1 BD:    1 ++..: &dev->vbl_lock
c06b69b0 OPS:    8127 FD:   15 BD:    1 ----: &ep->sem
c06b69a8 OPS:   36820 FD:    3 BD: 2368 ....: &ep->lock
c06b620c OPS:      17 FD:    1 BD:    2 --..: &file->f_ep_lock
c0421d50 OPS:       4 FD:    1 BD:    2 ....: cpufreq_driver_lock
e09de5b0 OPS:       2 FD:    1 BD:    1 --..: lock
e08dea80 OPS:       4 FD:    1 BD:    1 --..: &pstr->oss.setup_mutex
e08dea98 OPS:       6 FD:   72 BD:    1 --..: &pcm->open_mutex
e08dde50 OPS:    1180 FD:    1 BD:    1 ....: snd_pcm_link_rwlock
e08dea88 OPS:    1180 FD:   13 BD:    6 ....: &substream->self_group.lock
e08dde88 OPS:       6 FD:   22 BD:    3 ..--: snd_pcm_link_rwsem
e08bc800 OPS:      13 FD:    5 BD:   12 +...: &timer->lock
e0971a14 OPS:       6 FD:    1 BD:    6 ....: &tmr->lock
e0970f64 OPS:      43 FD:    2 BD:    6 ....: queue_list_lock
e09719d0 OPS:       2 FD:   22 BD:    2 --..: &q->timer_mutex
e09719a8 OPS:       1 FD:    1 BD:    2 ....: &pool->lock
e08f6408 OPS:       3 FD:    3 BD:    6 --..: &rmidi->open_mutex
e08f6400 OPS:       2 FD:    1 BD:    6 ....: &runtime->lock
e08b5c80 OPS:       4 FD:    1 BD:    6 ....: &dev->lock
e0971a0c OPS:      10 FD:    1 BD:    6 ....: &f->lock
e0994388 OPS:       4 FD:    1 BD:    2 ....: &q->sync_lock
e09719c0 OPS:       5 FD:    1 BD:   11 ....: &q->owner_lock
e0994380 OPS:       1 FD:    1 BD:    5 ....: &q->lock#2

# cat /proc/lockdep_stats
 lock-classes:                          432 [max: 2048]
 direct dependencies:                  2322 [max: 8192]
 indirect dependencies:               38074
 all direct dependencies:             38232
 dependency chains:                    2336 [max: 8192]
 in-hardirq chains:                      53
 in-softirq chains:                     108
 in-process chains:                    2175
 stack-trace entries:                 59487 [max: 262144]
 combined max dependencies:        12807936
 hardirq-safe locks:                     46
 hardirq-unsafe locks:                  285
 softirq-safe locks:                     65
 softirq-unsafe locks:                  243
 irq-safe locks:                         80
 irq-unsafe locks:                      285
 hardirq-read-safe locks:                 3
 hardirq-read-unsafe locks:              47
 softirq-read-safe locks:                14
 softirq-read-unsafe locks:              38
 irq-read-safe locks:                    14
 irq-read-unsafe locks:                  47
 uncategorized locks:                    68
 unused locks:                            0
 max locking depth:                      10
 max recursion depth:                    12
 chain lookup misses:                  2336
 chain lookup hits:                 9428664
 cyclic checks:                    18553806
 cyclic-check recursions:          22419079
 find-mask forwards checks:         1515911
 find-mask forwards recursions:      434210
 find-mask backwards checks:      273732598
 find-mask backwards recursions:  258270369
 hardirq on events:                 9414950
 hardirq off events:                9414949
 redundant hardirq ons:             1407081
 redundant hardirq offs:            2745394
 softirq on events:                  289782
 softirq off events:                 289782
 redundant softirq ons:                   0
 redundant softirq offs:                  0
 debug_locks:                             0

$ cat /proc/schedstat 
version 12
timestamp 610398
cpu0 2 3 232 265 99200 398917 3671 173556 131535 660961 187924 395246
domain0 03 24691 24215 53 148093 483 3 0 24215 10892 10642 26 49543 242
0 0 10640 3753 3654 17 52534 89 0 0 3654 3 0 3 0 0 0 0 0 0 54510 471 0
cpu1 6 9 432 545 98367 380616 7637 158083 103570 664524 163176 372979
domain0 03 21127 20516 177 285942 499 3 0 20516 10985 10667 63 57983 281
3 0 10667 7739 7606 30 71233 106 0 1 7605 4 0 4 0 0 0 0 0 0 42021 557 0

[X.] Other notes, patches, fixes, workarounds:

-- 
Kind regards,
                Dennis
