Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932692AbVJ0XVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbVJ0XVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 19:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbVJ0XVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 19:21:19 -0400
Received: from mail02.solnet.ch ([212.101.4.136]:12501 "EHLO mail02.solnet.ch")
	by vger.kernel.org with ESMTP id S932692AbVJ0XVT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 19:21:19 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc5-mm1 - ide-cs broken!
Date: Fri, 28 Oct 2005 01:18:18 +0200
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <20051024014838.0dd491bb.akpm@osdl.org> <200510272331.58445.damir.perisa@solnet.ch> <20051027150355.035dbbe5.akpm@osdl.org>
In-Reply-To: <20051027150355.035dbbe5.akpm@osdl.org>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?iso-8859-1?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/?=
 =?iso-8859-1?q?iPOv8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B?=
 =?iso-8859-1?q?2=7Cl6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?iso-8859-1?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?iso-8859-1?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200510280118.18661.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Friday 28 October 2005 00:03, Andrew Morton a écrit :
 | Damir Perisa <damir.perisa@solnet.ch> wrote:
 | > isn't anybody else using ide-cs? i feel lonely!
 |
 | That's called "stunned silence".

ah ... then it's ok ;-)

 | | [...]
 |
 | I'd have thought this was basically impossible.  It's saying that
 | drivers/pcmcia/ds.c isn't present.  What's the setting of
 | CONFIG_PCMCIA in your .config?
 
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_PCMCIA_IOCTL=y
CONFIG_PCMCIA_PROBE=y
all other PCMCIA are modules ( =m)

 | Perhaps the modprobe dependencies are screwed up.  Try modprobing
 | pcmcia.o by hand before inserting the card?

[17194333.620000] cs: memory probe 0xf0000000-0xf80fffff: excluding 
0xf0000000-0xf87fffff
[17194333.644000] pcmcia: Detected deprecated PCMCIA ioctl usage.
[17194333.644000] pcmcia: This interface will soon be removed from the 
kernel; please expect breakage unless you upgrade to new tools.
[17194333.644000] pcmcia: see 
http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for 
details.
[17194334.032000] Probing IDE interface ide2...
[17194334.320000] hde: 1024MB Flash Card, CFA DISK drive
[17194334.992000] ide2 at 0x4100-0x4107,0x410e on irq 3
[17194334.992000] hde: max request size: 128KiB
[17194334.992000] hde: 2001888 sectors (1024 MB) w/1KiB Cache, 
CHS=1986/16/63
[17194334.992000] hde: cache flushes not supported
[17194334.992000]  hde: hde1
[17194335.004000] ide-cs: hde: Vcc = 3.3, Vpp = 0.0
[17194335.224000]  hde: hde1
[17194335.632000]  hde: hde1
[17194335.736000]  hde: hde1
[17194335.744000]  hde: hde1
... ("hde: hde1" repeating)...

ok, now the situation is less lethal, but still no proper ide-cs working. 
there are no unknown symbols now, but the other output in dmesg is the 
same. especially, the loop to output "hde: hde1" is here, but if i remove 
the card, it stops and the system is still responsible. 

i checked something i forgot to check before... is the hde device seen 
in /sys somewhere, when the card is plugged in. the answer is yes!:

/sys/block/hde/hde1/

presents itself fully normal like other ide drives. in 
/sys/block/hde/hde1/sample.sh 
i found "mknod /dev/hde1 b 33 1" and tried to run it. successfully!
the result is: in dmesg, the "hde: hde1" output loop stopped and my card 
is working again!!! 

so the trouble seems not only (or not at all) related to the kernel but 
(also) to udev (i use 071), hotplug (mine is 2004_09_23), pcmciautils 
(010) or something else.

can somebody tell me, what state of this process (discovering device, 
loading needed modules, udev creating node under /dev) is the output 
"hde: hde1" to dmesg and how can it be possible that it loops? 

it seems that this chain of processing is stuck somewhere and needs a 
execution of the command to create the node under /dev by hand to finish.

please anybody around with more experience with this systems help or 
suggest where to search.

thank you in advance + greetings,
Damir

-- 
Penicillin doesn't kill bacteria. Technically, it keeps it from 
reproducing.
