Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136471AbRAGVAv>; Sun, 7 Jan 2001 16:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136466AbRAGVAn>; Sun, 7 Jan 2001 16:00:43 -0500
Received: from thick.mail.pipex.net ([158.43.192.95]:40873 "HELO
	thick.mail.pipex.net") by vger.kernel.org with SMTP
	id <S136409AbRAGVAW>; Sun, 7 Jan 2001 16:00:22 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101072056.f07Ku6W00894@wittsend.ukgateway.net>
Subject: ISA-PNP /proc interface in 2.4.0 : 100% CPU!
To: perex@suze.cz, linux-kernel@vger.kernel.org
Date: Sun, 7 Jan 2001 20:56:06 +0000 (GMT)
Reply-To: rankinc@zip.com.au
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an old ISA-PNP soundcard whose driver doesn't currently use the
ISA-PNP services. I have therefore been activating this card by
writing to the /proc/isapnp interface. And in an idle moment, I tried
an "auto" instruction:

cat > /proc/isapnp << EOF
card 0 ENS3081
dev 0 ENS0000
auto
EOF

This operation didn't return and system CPU usage then climbed to
100%, although the box didn't lock up. Further investigations showed
that the problem happened when either the isapnp_config_activate() or
isapnp_config_deactivate() functions tried to acquire the
isapnp_cfg_mutex. This seemed to be because they tried to acquire the
mutex for the specific devfn (zero in this case), but the
isapnp_set_card() function has already acquired it using -1 instead.

Couldn't the isapnp_autoconfigure() function use isapnp_activate() and
isapnp_deactivate() instead of isapnp_info_device->activate() and
isapnp_info_device->deactivate()? The former don't try to acquire the
mutex, and are precisely what the "activate" and "deactivate" /proc
commands invoke anyway.

Cheers,
Chris

This is the output from /proc/isapnp:

Card 1 'ENS3081:ENSONIQ Soundscape' PnP version 1.0
  Logical device 0 'ENS0000:Unknown'
    Device is not active
    Active port 0x330,0x300
    Active IRQ 5 [0x2],9 [0x2]
    Active DMA 1,3
    Resources 0
      Priority preferred
      Port 0x330-0x330, align 0xf, size 0x10, 16-bit address decoding
      IRQ 5,7 High-Edge
      IRQ 2/9 High-Edge
      DMA 1 8-bit byte-count compatible
      DMA 0,3 8-bit byte-count compatible
      Alternate resources 0:1
        Priority acceptable
        Port 0x330-0x330, align 0xf, size 0x10, 16-bit address decoding
        IRQ 5,7,2/9 High-Edge
        IRQ 7,2/9,10 High-Edge
        DMA 1,3 8-bit byte-count compatible
        DMA 0,3 8-bit byte-count compatible
      Alternate resources 0:2
        Priority functional
        Port 0x330-0x330, align 0xf, size 0x10, 16-bit address decoding
        IRQ 5,7,2/9 High-Edge
        IRQ 7,2/9,10 High-Edge
        DMA 0,1,3 8-bit byte-count compatible
      Alternate resources 0:3
        Priority functional
        Port 0x350-0x350, align 0xf, size 0x10, 16-bit address decoding
        IRQ 5,7,2/9 High-Edge
        IRQ 7,2/9,10 High-Edge
        DMA 0,1,3 8-bit byte-count compatible
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
