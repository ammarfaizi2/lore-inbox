Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUHOMzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUHOMzj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 08:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266670AbUHOMzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 08:55:39 -0400
Received: from viefep13-int.chello.at ([213.46.255.15]:43572 "EHLO
	viefep13-int.chello.at") by vger.kernel.org with ESMTP
	id S266674AbUHOMzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 08:55:18 -0400
Date: Sun, 15 Aug 2004 15:06:35 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: [Panic] 2.6.8 and ingress scheduling
Message-ID: <20040815130635.GA3703@lazy.shacknet.nu>
References: <20040814175233.GA3617@lazy.shacknet.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20040814175233.GA3617@lazy.shacknet.nu>
User-Agent: Mutt/1.5.6+20040803i
From: lkml@lazy.shacknet.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hello again,

> the last line (filter add) in the "wondershaper" script does sth. to the
> kernel, that lets it panic on receiving network packets.

actually, the last _two_ commands set up the kernel for panic. please
see attached script; running should produce this console message:

HTB init, kernel part version 3.17
Ingress scheduler: Classifier actions prefered over netfilter

shortly then, the kernel will panic (ifconfig shows up to 500KiB RX before).

with vga selection enabled, and a long;) piece of paper, this is produced:
(omissions marked [...] - these numbers are very hard to not misread)


Unable to handle kernel NULL pointer dereference at virtual address 0000000d
 printing eip:
c02080f60
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: [...]
[...]
 Call Trace:
 ip_rcv_finish
 ing_hook
 nf_iterate
 ip_rcv_finish
 ip_rcv_finish
 ing_hook_slow
 ip_rcv_finish
 ip_rcv
 ip_rcv_finish
 netif_receive
 rtl8139_rx
 rtl8139_poll
 net_rx_action
 __do_softirq
 do_IRQ
 common_interrupt
 default_idle
 cpu_idle
 start_kernel
 unknown_bootoption
Code: 8b 43 0c 39 f0 74 43 3d 00 03 00 00 74 3c 8b 1b 85 db 75 ec
 <0>Kernel panic : Fatal exception in interrupt
In interrupt handler - not syncing

eof.

another time, running iptraf, identical Oops, but first line reads:

Unable to handle kernel paging request at virtual address 000a0f0d
[...]
EIP is at ingress_enqueue+0x20/0x90
[...]

the traffic shaping of upstream packets does not panic the kernel; I
also tried a different timer source, to no success.

regards,

peter

attached: output of shaper status, output of lsmod, minimal shaper script.

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="wshaper.status.txt"

qdisc pfifo_fast 0: [Unknown qdisc, optlen=20] 
 Sent 50124 bytes 582 pkts (dropped 0, overlimits 0) 

qdisc ingress ffff: ---------------- 
 Sent 66193 bytes 575 pkts (dropped 0, overlimits 0) 


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lsmod.txt"

Module                  Size  Used by
snd_via82xx            23204  - 
snd_mpu401_uart         5608  - 
ehci_hcd               25260  - 
uhci_hcd               28568  - 
usbcore               100292  - 
snd_bt87x              10952  - 
tuner                  18680  - 
bttv                  145196  - 
video_buf              16844  - 
i2c_algo_bit            8720  - 
v4l2_common             4712  - 
btcx_risc               3664  - 
videodev                6720  - 
snd_ens1371            18760  - 
snd_rawmidi            19300  - 
snd_seq_device          6256  - 
snd_pcm_oss            48360  - 
snd_mixer_oss          16904  - 
snd_pcm                81704  - 
snd_page_alloc          8752  - 
snd_timer              19628  - 
snd_ac97_codec         65548  - 
snd                    43684  - 
soundcore               6560  - 
8139too                19912  - 
ohci1394               30764  - 
ieee1394               91732  - 
w83627hf               27436  - 
eeprom                  6064  - 
i2c_sensor              2152  - 
i2c_isa                 1480  - 
i2c_viapro              5780  - 
i2c_core               18328  - 
ide_cd                 37824  - 
cdrom                  36892  - 
loop                   11888  - 

--VS++wcV0S1rZb1Fb
Content-Type: application/x-sh
Content-Disposition: attachment; filename="ingress-shaper.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A#set -x=0A=0A=0ADOWNLINK=3D1000=0ADEV=3Deth0=0A=0A# attach in=
gress policer:=0A=0Atc qdisc add dev $DEV handle ffff: ingress=0A=0A# filte=
r *everything* to it (0.0.0.0/0), drop everything that's=0A# coming in too =
fast:=0A=0Atc filter add dev $DEV parent ffff: protocol ip prio 50 u32 matc=
h ip src \=0A   0.0.0.0/0 police rate ${DOWNLINK}kbit burst 10k drop flowid=
 :1=0A=0Aecho ' done'=0A
--VS++wcV0S1rZb1Fb--
