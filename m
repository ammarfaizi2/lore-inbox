Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130804AbRACC3b>; Tue, 2 Jan 2001 21:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132050AbRACC3V>; Tue, 2 Jan 2001 21:29:21 -0500
Received: from cd168990-a.ctjams1.mb.wave.home.com ([24.108.112.42]:1408 "EHLO
	cd168990-a.ctjams1.mb.wave.home.com") by vger.kernel.org with ESMTP
	id <S130804AbRACC3L>; Tue, 2 Jan 2001 21:29:11 -0500
Date: Tue, 2 Jan 2001 19:57:58 -0600
From: Evan Thompson <evaner@bigfoot.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Additional info. for PCI VIA IDE crazyness.  Please read.
Message-ID: <20010102195758.A278@evaner.penguinpowered.com>
Reply-To: evaner@bigfoot.com
Mail-Followup-To: Evan Thompson <evaner@bigfoot.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010102102900.A328@evaner.penguinpowered.com> <Pine.LNX.4.10.10101021046330.25012-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101021046330.25012-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 02, 2001 at 10:56:27AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 02, 2001 at 10:56:27AM -0800, Linus Torvalds wrote:
> Anyway, I suspect that the "fe"/"ff" values are specified by MS (no way to
> know, as the docs are obviously NDA'd), which means that it would be
> interesting to hear whether the problem is fixed by something like this:
> 
> In the file arch/i386/kernel/pci-irq.c, around line 240, there's a
> function called pirq_via_get(). Right now it just does a
> "read_config_nybble()", and I'd ask you to add these two magic lines to
> the beginning of it:
> 
> 	if ((pirq & 0xf0) == 0xf0)
> 		return pirq & 0xf;
> 
> and please tell me if that changes/fixes the problem for you.

It seems to change the problem, but fixes it in most ways.  I can
give you a dmesg output if you want one.  That fixed the "confused
drive" errors and lets me boot, but now hdc and hdd are timing out
because of the reasons that they timed out in 2.2.

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 14

is what I get now.  I haven't tried this yet, but I'm assuming a simple
re-addition of 'ide1=0x170,0x376,15' to the kernel options should put
ide1 back on irq 15 where it belongs (I haven't rebooted yet because I
was just so excited that this works.  Geez your smart, Linus!)

> Oh, and could you pass me the output of /proc/pci while you're at it, so
> that I can match it up with your pirq table. That corrupted slot 4 entry
> still makes me go "Hmm..".

I've attached the output I got from doing cat /proc/pci from
2.4.0-prerelease.  Because of a subtle configuration difference between
the two, there is a few I/O differences and output differences (because
of the jump in kernel versions) from 2.2.18pre21 (I really should
upgrade to 2.2.18).

Thanks,
-- 
| Evan Thompson                    | ICQ:    2233067   |
| Freelance Computer Nerd          | AIM:    Evaner517 |
| evaner@bigfoot.com               | Yahoo!: evanat    |
| http://evaner.penguinpowered.com | MSN:    evaner517 |

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=forlinus2

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 1).
      Master Capable.  Latency=16.  
      Prefetchable 32 bit memory at 0xe8000000 [0xebffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 65).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      IRQ 14.
      Master Capable.  Latency=32.  
      I/O at 0x1f0 [0x1f7].
      I/O at 0x3f6 [0x3f6].
      I/O at 0x170 [0x177].
      I/O at 0x376 [0x376].
      I/O at 0xffa0 [0xffaf].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 2).
      IRQ 10.
      Master Capable.  Latency=64.  
      I/O at 0xdf00 [0xdf1f].
  Bus  0, device   7, function  3:
    Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 16).
  Bus  0, device   9, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS) (rev 0).
      IRQ 10.
      I/O at 0xde80 [0xde9f].
  Bus  1, device   0, function  0:
    VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 (rev 11).
      Master Capable.  Latency=64.  Min Gnt=2.
      Prefetchable 32 bit memory at 0xe7000000 [0xe77fffff].
      Non-prefetchable 32 bit memory at 0xefef0000 [0xefefffff].
      I/O at 0xcc80 [0xccff].

--r5Pyd7+fXNt84Ff3--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
