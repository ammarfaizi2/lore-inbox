Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTLEO2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 09:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbTLEO2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 09:28:47 -0500
Received: from modeemi.modeemi.cs.tut.fi ([130.230.72.134]:15572 "EHLO
	modeemi.modeemi.cs.tut.fi") by vger.kernel.org with ESMTP
	id S264231AbTLEO2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 09:28:38 -0500
Date: Fri, 5 Dec 2003 16:28:35 +0200
From: Erkki Seppala <flux@modeemi.fi>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: ps gets hung before uptime of 3 days (2.6.0-test9,11)
Message-ID: <20031205142834.GA3362@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following the format in REPORTING-BUGS..

[1.] ps gets hung before uptime of 3 days (2.6.0-test9,11)

[2.] doing 'ps' hangs in a uninterruptible state (ctrl-c or ctrl-\
don't kill it). It doesn't do it initially, but after some time. The
same can be experienced by cat /proc/*/cmdline or ls /proc/*. ls -l
/proc works fine. Finding out the process id of the hanging process is
a little bit tricky.. But I did manage to find atleast one process
table entry which apparently causes this:

[16:14] dyton(pts/19):~% cd /proc
[16:14] dyton(pts/19):/proc% cd 3592
[16:14] dyton(pts/19):/proc/3592% echo *
attr auxv cmdline cwd environ exe fd maps mem mounts root stat statm status task wchan
[16:14] dyton(pts/19):/proc/3592% ls
[hang]

Operations that hang:
 cat cmdline
 cat environ
 ls -l exe
 cat maps
 cat stat
 cat statm
 cat status
 ls -l task/nnn (there are 3592 and 3593)

Operations that work:
 ls -l cwd (points to home directory)
 ls -l fd
 cat mounts
 ls -l root
 ls -l task
 cat wchan (says 'rwsem_down_read_failed')

kill -9 3592 doesn't do anything.

The output of magic-key-t is available at
http://www.modeemi.fi/~flux/tasks .

I assume it's due to this reason my load is 386.61, 382.80, 377.39.

Otherwise things work great ;).

[3.] keywords: procfs

[4.] kernel version: Linux version 2.6.0-test11-dyton17 (root@dyton) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Mon Dec 1 12:56:47 EET 2003

[5.] No oops

[6.] No idea how to reproduce; however this has appeared multiple
times. It appeared already with test9, after which I upgraded to
test11. Test8 appeared to work ok in this regard.

[7.1.] 

sh scripts/ver_linux outputs the following:

Linux dyton 2.6.0-test11-dyton17 #1 SMP Mon Dec 1 12:56:47 EET 2003 i686 GNU/Linux
 
Gnu C                  3.3.2 (I used 2.95.4 to compile the kernel)
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre3
e2fsprogs              1.35-WIP
xfsprogs               2.5.11
PPP                    2.4.2b3
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         nfsd exportfs btaudio usbmouse hid snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd uhci_hcd ohci_hcd ehci_hcd parport_pc lp parport 8250 serial_core softdog netlink_dev tun tuner tvaudio msp3400 bttv video_buf i2c_algo_bit btcx_risc i2c_core v4l2_common videodev soundcore nfs lockd sunrpc e1000 scan

[7.2.] 
This is a Dual Athlon-system.

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) MP 1900+
stepping	: 2
cpu MHz		: 1600.668
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 3145.72

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 1600.668
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 3194.88

[7.3.] Modules:

nfsd 101552 8 - Live 0xe0c3a000
exportfs 7296 1 nfsd, Live 0xe0bec000
btaudio 17552 0 - Live 0xe0c16000
usbmouse 6016 0 - Live 0xe0b4c000
hid 33216 0 - Live 0xe0c0c000
snd_seq_midi 8992 0 - Live 0xe0b48000
snd_emu10k1_synth 8320 0 - Live 0xe0b19000
snd_emux_synth 36736 1 snd_emu10k1_synth, Live 0xe0c02000
snd_seq_virmidi 8192 1 snd_emux_synth, Live 0xe0aa2000
snd_seq_midi_emul 8320 1 snd_emux_synth, Live 0xe0ad7000
snd_seq_oss 35328 0 - Live 0xe0bf8000
snd_seq_midi_event 8448 3 snd_seq_midi,snd_seq_virmidi,snd_seq_oss, Live 0xe0ad3000
snd_seq 57328 8 snd_seq_midi,snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_oss,snd_seq_midi_event, Live 0xe0bcc000
snd_pcm_oss 54148 0 - Live 0xe0bdd000
snd_mixer_oss 18048 1 snd_pcm_oss, Live 0xe0ab7000
snd_emu10k1 87172 5 snd_emu10k1_synth, Live 0xe0b51000
snd_rawmidi 24576 3 snd_seq_midi,snd_seq_virmidi,snd_emu10k1, Live 0xe0b01000
snd_pcm 97536 4 snd_pcm_oss,snd_emu10k1, Live 0xe0b1e000
snd_timer 25088 2 snd_seq,snd_pcm, Live 0xe0af9000
snd_seq_device 8708 7 snd_seq_midi,snd_emu10k1_synth,snd_emux_synth,snd_seq_oss,snd_seq,snd_emu10k1,snd_rawmidi, Live 0xe0acb000
snd_ac97_codec 49796 1 snd_emu10k1, Live 0xe0aeb000
snd_page_alloc 12548 2 snd_emu10k1,snd_pcm, Live 0xe0abd000
snd_util_mem 5120 2 snd_emux_synth,snd_emu10k1, Live 0xe0aa5000
snd_hwdep 9984 1 snd_emu10k1, Live 0xe0985000
snd 53508 22 snd_seq_midi,snd_emux_synth,snd_seq_virmidi,snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep, Live 0xe0adc000
uhci_hcd 32136 0 - Live 0xe0ac2000
ohci_hcd 18176 0 - Live 0xe0ab1000
ehci_hcd 23680 0 - Live 0xe0aaa000
parport_pc 39712 1 - Live 0xe0995000
lp 11072 0 - Live 0xe0948000
parport 42944 2 parport_pc,lp, Live 0xe0989000
8250 20224 2 - Live 0xe0975000
serial_core 22912 1 8250, Live 0xe096e000
softdog 5380 1 - Live 0xe0920000
netlink_dev 4512 0 - Live 0xe091d000
tun 10112 0 - Live 0xe093f000
tuner 15236 0 - Live 0xe093a000
tvaudio 22016 0 - Live 0xe0933000
msp3400 23056 0 - Live 0xe092c000
bttv 134048 1 - Live 0xe094c000
video_buf 22400 1 bttv, Live 0xe0925000
i2c_algo_bit 10504 1 bttv, Live 0xe0824000
btcx_risc 5380 1 bttv, Live 0xe08e7000
i2c_core 24836 5 tuner,tvaudio,msp3400,bttv,i2c_algo_bit, Live 0xe08f0000
v4l2_common 5376 1 bttv, Live 0xe082c000
videodev 10240 2 bttv, Live 0xe0828000
soundcore 9792 3 btaudio,snd,bttv, Live 0xe081d000
nfs 98604 3 - Live 0xe0836000
lockd 67664 3 nfsd,nfs, Live 0xe08d5000
sunrpc 132804 11 nfsd,nfs,lockd, Live 0xe08fb000
e1000 82432 0 - Live 0xe089e000
scanner 22656 0 - Live 0xe082f000
usbkbd 7680 0 - Live 0xe0821000
usbcore 109396 9 usbmouse,hid,uhci_hcd,ohci_hcd,ehci_hcd,scanner,usbkbd, Live 0xe0882000
aic7xxx 194860 0 - Live 0xe0851000

[7.4.-6.] I decided to skip IO/PCI/SCSI-details as they doesn't seem
relevant to me. This information is of course available on request.

[7.7.] I'm not using preemptive scheduling, which has been under some
stability issues?

# grep -i preem /boot/config-`uname -r`
# CONFIG_PREEMPT is not set

The machine's most intensive activity is capturing (scheduled) and
playing back video.

[X]

I'm willing to try patches, the machine isn't mission critical in any
way ;). (Well, I like to keep my data..)

Dmesg has some output regarding 3ware, bttv and rpc, but they don't
seem relevant. This is twice in the log:

init_special_inode: bogus i_mode (70136)

but it looks like an old message..

-- 
  _____________________________________________________________________
     / __// /__ ____  __               http://www.modeemi.fi/~flux/\   \
    / /_ / // // /\ \/ /                                            \  /
   /_/  /_/ \___/ /_/\_\@modeemi.fi                                  \/
