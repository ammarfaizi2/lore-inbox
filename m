Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSFTJLY>; Thu, 20 Jun 2002 05:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312681AbSFTJLX>; Thu, 20 Jun 2002 05:11:23 -0400
Received: from [213.77.11.170] ([213.77.11.170]:63758 "HELO
	poczta.warszawa.comarch.pl") by vger.kernel.org with SMTP
	id <S312619AbSFTJLV>; Thu, 20 Jun 2002 05:11:21 -0400
Date: Thu, 20 Jun 2002 11:12:09 +0200
From: =?ISO-8859-1?Q?Micha=B3?= =?ISO-8859-1?Q?Cie=B6lakiewicz?= 
	<Michal.Cieslakiewicz@comarch.pl>
To: linux-kernel@vger.kernel.org
Cc: Alan.Cox@linux.org, neilb@cse.unsw.edu.au
Subject: [2.2.21] nfsd crash & workaround
Message-Id: <20020620111209.0b55c5a4.Michal.Cieslakiewicz@comarch.pl>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

When accessing NFS (server on a Linux box running 2.2.21, client on Solaris 8) I've encountered a following problem: attempt to copy a not-so-small file (around 150MB) from cdrom leads to nfsd crash after some time (depends on transport and network load) with file being only partially copied. The crash occurs regardless of either of NFS version (v2,v3) or transport (UDP,TCP).
Cause this problem never happened to me on 2.2.20, I spent some time to eventually find a 'solution' which is as simple as using mm/vmscan.c from 2.2.20 (changing the position of a call to shrink_dcache_memory() in fact). I'm not a kernel hacker (not yet :) ) but looks like VM issue rather than NFS to me.
Below I post a standard lk bug report (assumig NFS v2 over UDP when not stated otherwise).

Regards
Michal

########

[1.] nfsd crash

[2.] Copying a large file from cdrom drive on a Linux NFS server running kernel 2.2.21 leads to nfsd crash. Crash occurs always, regardless of NFS settings (version, transport).

[3.] nfsd, kernel

[4.] /proc/version: 
     Linux version 2.2.21 (root@nbmic) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Tue Jun 18 15:03:18 CEST 2002

[5.1] ksymoops for NFS UDP v2:

WARNING: This version of ksymoops is obsolete.
WARNING: The current version can be obtained from ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops
Options used: -V (specified)
              -o /lib/modules/2.2.21/ (default)
              -k /proc/ksyms (default)
              -l /proc/modules (default)
              -m /boot/System.map-2.2.21 (specified)
              -c 1 (default)
Jun 18 16:19:25 nbmic kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000010
Jun 18 16:19:25 nbmic kernel: current->tss.cr3 = 00101000, %%cr3 = 00101000
Jun 18 16:19:25 nbmic kernel: *pde = 00000000
Jun 18 16:19:25 nbmic kernel: Oops: 0000
Jun 18 16:19:25 nbmic kernel: CPU:    0
Jun 18 16:19:25 nbmic kernel: EIP:    0010:[<c89c484c>]
Jun 18 16:19:25 nbmic kernel: EFLAGS: 00010246
Jun 18 16:19:25 nbmic kernel: eax: 00000000   ebx: 00000000   ecx: c7fb5610   edx: 00000010
Jun 18 16:19:25 nbmic kernel: esi: c6b64300   edi: c6b64280   ebp: c6b64100   esp: c4d6fe08
Jun 18 16:19:25 nbmic kernel: ds: 0018   es: 0018   ss: 0018
Jun 18 16:19:25 nbmic kernel: Process nfsd (pid: 386, process nr: 31, stackpage=c4d6f000)
Jun 18 16:19:25 nbmic kernel: Stack: c89c4bea c6b64280 c4e9a7e0 c70aa400 01000000 c4cbc000 c70aad34 c017539a
Jun 18 16:19:25 nbmic kernel:        c6b64100 00000000 c89c4e29 c70aac00 c4e9a7e0 00000001 c70aa400 c4cbc000
Jun 18 16:19:25 nbmic kernel:        c4e9a7e0 c4e9a7e0 c4e9a844 00000004 c70aa400 c89c5c74 c70aa400 c4e9a7e0
Jun 18 16:19:25 nbmic kernel: Call Trace: [<c017539a>] [<c0185aff>] [<c01129db>] [<c016ee63>] [<c016eee6>] [<c016adfe>] [<c0108b3f>]
Jun 18 16:19:25 nbmic kernel: Code: 8b 40 10 39 d0 74 1b 8d 58 c8 39 f3 75 0e 8b 5a 04 83 c3 c8
>>EIP: c89c484c <END_OF_CODE+49b20/????>
Trace: c017539a <ip_build_xmit+4a/30c>
Trace: c0185aff <inet_sendmsg+83/90>
Trace: c01129db <update_process_times+5b/64>
Trace: c016ee63 <qdisc_restart+13/6c>
Trace: c016eee6 <qdisc_run_queues+2a/5c>
Trace: c016adfe <net_bh+26/1dc>
Trace: c0108b3f <kernel_thread+23/30>
Code:  c89c484c <END_OF_CODE+49b20/????>       0000000000000000 <_EIP>: <===
Code:  c89c484c <END_OF_CODE+49b20/????>          0:    8b 40 10                mov    0x10(%eax),%eax <===
Code:  c89c484f <END_OF_CODE+49b23/????>          3:    39 d0                   cmp    %edx,%eax
Code:  c89c4851 <END_OF_CODE+49b25/????>          5:    74 1b                   je      c89c486e <END_OF_CODE+49b42/????>
Code:  c89c4853 <END_OF_CODE+49b27/????>          7:    8d 58 c8                lea    0xffffffc8(%eax),%ebx
Code:  c89c4856 <END_OF_CODE+49b2a/????>          a:    39 f3                   cmp    %esi,%ebx
Code:  c89c4858 <END_OF_CODE+49b2c/????>          c:    75 0e                   jne     c89c4868 <END_OF_CODE+49b3c/????>
Code:  c89c485a <END_OF_CODE+49b2e/????>          e:    8b 5a 04                mov    0x4(%edx),%ebx
Code:  c89c485d <END_OF_CODE+49b31/????>         11:    83 c3 c8                add    $0xffffffc8,%ebx
125 warnings and 2 errors issued.  Results may not be reliable.

[5.2] ksymoops for NFS TCP v3:

WARNING: This version of ksymoops is obsolete.
WARNING: The current version can be obtained from ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops
Options used: -V (specified)
              -o /lib/modules/2.2.21/ (default)
              -k /proc/ksyms (default)
              -l /proc/modules (default)
              -m /boot/System.map-2.2.21 (specified)
              -c 1 (default)
Jun 19 08:42:51 nbmic kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000010
Jun 19 08:42:51 nbmic kernel: current->tss.cr3 = 00101000, %%cr3 = 00101000
Jun 19 08:42:51 nbmic kernel: *pde = 00000000
Jun 19 08:42:51 nbmic kernel: Oops: 0000
Jun 19 08:42:51 nbmic kernel: CPU:    0
Jun 19 08:42:51 nbmic kernel: EIP:    0010:[<c89c484c>]
Jun 19 08:42:51 nbmic kernel: EFLAGS: 00010246
Jun 19 08:42:51 nbmic kernel: eax: 00000000   ebx: 00000000   ecx: c7fac798   edx: 00000010
Jun 19 08:42:51 nbmic kernel: esi: c6d004a0   edi: c6d00520   ebp: c6d005a0   esp: c4ef7df0
Jun 19 08:42:51 nbmic kernel: ds: 0018   es: 0018   ss: 0018
Jun 19 08:42:51 nbmic kernel: Process nfsd (pid: 398, process nr: 32, stackpage=c4ef7000)
Jun 19 08:42:51 nbmic kernel: Stack: c89c4bea c6d00520 c4ec4144 c7211200 01000000 c4e46800 c56ae334 c4dcd3c0
Jun 19 08:42:51 nbmic kernel:        c6d005a0 00000000 c89c4e29 c56ae200 c4ec4144 00000001 c7211200 c4e46800
Jun 19 08:42:51 nbmic kernel:        c4ec4144 c4ec4144 c4ec41a8 00000004 00007d78 c89c5c74 c7211200 c4ec4144
Jun 19 08:42:51 nbmic kernel: Call Trace: [<c01780a4>] [<c0185a64>] [<c0166baa>] [<c01859f0>] [<c0108b3f>]
Jun 19 08:42:51 nbmic kernel: Code: 8b 40 10 39 d0 74 1b 8d 58 c8 39 f3 75 0e 8b 5a 04 83 c3 c8
>>EIP: c89c484c <END_OF_CODE+44b20/????>
Trace: c01780a4 <tcp_recvmsg+4dc/4ec>
Trace: c0185a64 <inet_recvmsg+74/8c>
Trace: c0166baa <sock_recvmsg+42/b4>
Trace: c01859f0 <inet_recvmsg+0/8c>
Trace: c0108b3f <kernel_thread+23/30>
Code:  c89c484c <END_OF_CODE+44b20/????>       0000000000000000 <_EIP>: <===
Code:  c89c484c <END_OF_CODE+44b20/????>          0:    8b 40 10                mov    0x10(%eax),%eax <===
Code:  c89c484f <END_OF_CODE+44b23/????>          3:    39 d0                   cmp    %edx,%eax
Code:  c89c4851 <END_OF_CODE+44b25/????>          5:    74 1b                   je      c89c486e <END_OF_CODE+44b42/????>
Code:  c89c4853 <END_OF_CODE+44b27/????>          7:    8d 58 c8                lea    0xffffffc8(%eax),%ebx
Code:  c89c4856 <END_OF_CODE+44b2a/????>          a:    39 f3                   cmp    %esi,%ebx
Code:  c89c4858 <END_OF_CODE+44b2c/????>          c:    75 0e                   jne     c89c4868 <END_OF_CODE+44b3c/????>
Code:  c89c485a <END_OF_CODE+44b2e/????>          e:    8b 5a 04                mov    0x4(%edx),%ebx
Code:  c89c485d <END_OF_CODE+44b31/????>         11:    83 c3 c8                add    $0xffffffc8,%ebx
127 warnings and 2 errors issued.  Results may not be reliable.

[6.] server: 'mount' cdrom and 'exportfs' with defaults; client: 'mount' share and 'cp' a file from share to local filesystem

[7.1] ver_linux:

Linux nbmic 2.2.21 #1 Tue Jun 18 15:03:18 CEST 2002 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.27
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.33
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         nfsd irda_deflate irda af_packet snd-seq-midi snd-card-ymfpci snd-opl3 snd-hwdep snd-mpu401-uart xirc2ps_cs snd-rawmidi snd-seq-oss snd-seq-midi-event snd-seq snd-seq-device snd-pcm-oss snd-pcm-plugin snd-mixer-oss snd-ymfpci snd-pcm snd-timer snd-ac97-codec snd-mixer snd soundcore ds i82365 pcmcia_core i2c-dev i2c-piix4 adm1021 i2c-proc i2c-core lt_serial lt_modem toshiba floppy ufs smbfs nfs lockd sunrpc dummy usb-uhci usbcore ppp_deflate ppp slip slhc lp parport_pc parport nls_iso8859-2 nls_cp437

[7.2] /proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 1
cpu MHz         : 497.565
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 992.87

[7.3] /proc/modules:

nfsd                  182080   4
af_packet               6048   2 (autoclean)
xirc2ps_cs             13408   1
snd-seq-midi            3152   0 (autoclean) (unused)
snd-card-ymfpci         4672   0 (autoclean)
snd-opl3                4144   0 (autoclean) [snd-card-ymfpci]
snd-hwdep               2896   0 (autoclean) [snd-opl3]
snd-mpu401-uart         2144   0 (autoclean) [snd-card-ymfpci]
snd-rawmidi             8736   0 (autoclean) [snd-seq-midi snd-mpu401-uart]
snd-seq-oss            22656   0 (unused)
snd-seq-midi-event      2640   0 [snd-seq-midi snd-seq-oss]
snd-seq                36224   0 [snd-seq-midi snd-seq-oss snd-seq-midi-event]
snd-seq-device          3632   0 [snd-seq-midi snd-rawmidi snd-seq-oss snd-seq]
snd-pcm-oss            17248   0 (unused)
snd-pcm-plugin         14384   0 [snd-pcm-oss]
snd-mixer-oss           4160   0 [snd-pcm-oss]
snd-ymfpci             36112   0 [snd-card-ymfpci]
snd-pcm                28160   0 [snd-pcm-oss snd-pcm-plugin snd-ymfpci]
snd-timer               7760   0 [snd-opl3 snd-seq snd-pcm]
snd-ac97-codec         24448   0 [snd-ymfpci]
snd-mixer              22400   0 [snd-mixer-oss snd-ymfpci snd-ac97-codec]
snd                    33776   1 [snd-seq-midi snd-card-ymfpci snd-opl3 snd-hwdep snd-mpu401-uart snd-rawmidi snd-seq-oss snd-seq-midi-event snd-seq snd-seq-device snd-pcm-oss snd-pcm-plugin snd-mixer-oss snd-ymfpci snd-pcm snd-timer snd-ac97-codec snd-mixer]
soundcore               2384   8 [snd]
ds                      6256   2 [xirc2ps_cs]
i82365                 21040   2
pcmcia_core            38144   0 [xirc2ps_cs ds i82365]
i2c-dev                 3520   0 (unused)
i2c-piix4               3760   0 (unused)
adm1021                 5520   0 (unused)
i2c-proc                5584   0 [adm1021]
i2c-core               12736   0 [i2c-dev i2c-piix4 adm1021 i2c-proc]
lt_serial              17168   0 (unused)
lt_modem              314400   0 [lt_serial]
toshiba                 2400   0
floppy                 46192   0
ufs                    56592   0 (unused)
smbfs                  26592   0 (unused)
nfs                    72880   0 (unused)
lockd                  44368   1 [nfsd nfs]
sunrpc                 60704   1 [nfsd nfs lockd]
dummy                    960   0 (unused)
usb-uhci               19040   0 (unused)
usbcore                47824   0 [usb-uhci]
ppp_deflate            40960   0 (unused)
ppp                    20144   0 [ppp_deflate]
slip                    6048   0 (unused)
slhc                    4432   0 [ppp slip]
lp                      5232   0 (unused)
parport_pc              7472   1
parport                 7104   1 [lp parport_pc]
nls_iso8859-2           2928   2 (autoclean)
nls_cp437               3920   1 (autoclean)

[7.4] Not a SCSI system (neither native nor emulated).

[7.5] Linux kernel is generic 2.2.21 with ext3 v0.0.7a patch applied. One 128MB swap partition. ALSA and PCMCIA used. Machine is Toshiba Satellite Pro 4270 with 128MB RAM and 100Mbit Xircom (16bit) PCMCIA network card.

[8.] Workaround: changing the position of a call to shrink_dcache_memory() in mm/vmscan.c as it was in lk 2.2.20 eliminates the problem.
