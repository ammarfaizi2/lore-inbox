Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbTE1SnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 14:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbTE1SnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 14:43:13 -0400
Received: from rzcomm7.rz.tu-bs.de ([134.169.9.53]:62412 "EHLO
	rzcomm7.rz.tu-bs.de") by vger.kernel.org with ESMTP id S264830AbTE1SnE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 14:43:04 -0400
Date: Wed, 28 May 2003 20:56:15 +0200
From: Torsten Wolf <t.wolf@tu-bs.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 - kernel BUG at page_alloc.c:102!
Message-ID: <20030528185615.GA1796@b147.apm.etc.tu-bs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt http://www.mutt.org/
Organization: TU Braunschweig
X-Editor: Vim http://www.vim.org/
X-OpenPGP-Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xEE27B69C
X-Fingerprint: 24EE 9FD9 5333 0206 541F  4602 C6A4 5F61 EE27 B69C
X-Uptime: 19:36:50 up 2 min,  4 users,  load average: 0.77, 0.38, 0.14
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

since I use 2.4.20 (debian source package on Debian testing)
occasionally the following pops up in my syslog:

kernel: kernel BUG at page_alloc.c:102!
kernel: invalid operand: 0000
kernel: CPU:    0
kernel: EIP:    0010:[<c0133bc3>]    Tainted: PF
kernel: EFLAGS: 00013282
kernel: eax: c19be26c   ebx: c10cb690   ecx: 00000000   edx: f6eb3464
kernel: esi: c10cb690   edi: 00000000   ebp: c02c7f00   esp: f7ef5f0c
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process kswapd (pid: 4, stackpage=f7ef5000)
kernel: Stack: 00003282 00000003 f11c14c0 f11c14c0 f11c14c0 c10cb690
c013f312 f11c14c0 
kernel: f6eb3464 c10cb690 00008471 c02c7f00 c0133009 c10cb690 000001d0
f7ef4000 
kernel: 00000200 000001d0 00000016 00000020 000001d0 00000020 00000006
c01331e1 
kernel: Call Trace:    [<c013f312>] [<c0133009>] [<c01331e1>]
[<c0133256>] [<c0133384>]
kernel: [<c01333e9>] [<c013351d>] [<c0105000>] [<c01072be>] [<c0133480>]
kernel: 
kernel: Code: 0f 0b 66 00 db cc 28 c0 89 d8 2b 05 50 51 34 c0 c1 f8 04
69

This happens both under load (bzip my backup) and in idle periods. The
system seems to be totally functional after this. Google gave several
results, where people described the same issue, also with 2.4.20.
Unfortunately the rare answers were not helpful. What makes the kernel
tainted are vmware's modules (however, vmware was not running when the
bug happened) and perhaps Intels e100 driver. lsmod yields the
following:

Module                  Size  Used by    Tainted: PF 
vmnet                  19744   6 
vmmon                  19252   0  (unused)
parport_pc             27656   1  (autoclean)
lp                      6720   0  (autoclean)
parport                25600   1  (autoclean) [parport_pc lp]
snd-seq-midi            4064   0  (autoclean) (unused)
snd-emu10k1-synth       4860   0  (autoclean) (unused)
snd-emux-synth         28060   0  (autoclean) [snd-emu10k1-synth]
snd-seq-midi-emul       5024   0  (autoclean) [snd-emux-synth]
snd-seq-virmidi         3320   0  (autoclean) [snd-emux-synth]
snd-seq-oss            29056   0  (unused)
snd-seq-midi-event      3048   0  [snd-seq-midi snd-seq-virmidi
snd-seq-oss]
snd-seq                37296   2  [snd-seq-midi snd-emux-synth
snd-seq-midi-emul snd-seq-virmidi snd-seq-oss snd-seq-midi-event]
snd-pcm-oss            38980   0  (unused)
snd-mixer-oss          13656   1  [snd-pcm-oss]
snd-emu10k1            71124   1  [snd-emu10k1-synth]
snd-pcm                59424   0  [snd-pcm-oss snd-emu10k1]
snd-timer              14568   0  [snd-seq snd-pcm]
snd-hwdep               5248   0  [snd-emu10k1]
snd-util-mem            1264   0  [snd-emux-synth snd-emu10k1]
snd-page-alloc          4860   0  [snd-emu10k1 snd-pcm]
snd-rawmidi            13472   0  [snd-seq-midi snd-seq-virmidi
snd-emu10k1]
snd-seq-device          4272   0  [snd-seq-midi snd-emu10k1-synth
snd-emux-synth snd-seq-oss snd-seq snd-emu10k1 snd-rawmidi]
snd-ac97-codec         37088   0  [snd-emu10k1]
snd                    30308   0  [snd-seq-midi snd-emux-synth
snd-seq-virmidi snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss
snd-mixer-oss snd-emu10k1 snd-pcm snd-timer snd-hwdep snd-util-mem
snd-rawmidi snd-seq-device snd-ac97-codec]
tuner                  10048   1  (autoclean)
tvaudio                12668   0  (autoclean) (unused)
msp3400                16684   1  (autoclean)
bttv                   67840   2  (autoclean)
soundcore               3844  10  (autoclean) [snd bttv]
i2c-algo-bit            7560   1  (autoclean) [bttv]
lirc_i2c                3392   1  (autoclean)
lirc_dev                8064   1  (autoclean) [lirc_i2c]
ipt_REJECT              3000   4  (autoclean)
ipt_state                568 185  (autoclean)
ipt_LOG                 3416   1  (autoclean)
ipt_limit                888   1  (autoclean)
iptable_filter          1740   1  (autoclean)
ip_tables              11896   5  [ipt_REJECT ipt_state ipt_LOG
ipt_limit iptable_filter]
e100                   67736   1  (autoclean)
ip_conntrack_ftp        4112   0  (unused)
ip_conntrack           18944   2  [ipt_state ip_conntrack_ftp]
w83781d                19216   0 
i2c-isa                 1096   0  (unused)
i2c-proc                7184   0  [w83781d]
i2c-core               13508   0  [tuner tvaudio msp3400 bttv
i2c-algo-bit lirc_i2c w83781d i2c-isa i2c-proc]
mousedev                4244   1 
hid                    13896   0  (unused)
usb-uhci               23148   0  (unused)
usbcore                61600   1  [hid usb-uhci]

Is this a known issue with 2.4.20 and thus(?) removed in 2.4.21? Is this
a grave error after which one should reboot as fast as possible, or can
the machine stay up?

Thanks in advance!

Best wishes
Torsten
