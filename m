Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316129AbSEZObL>; Sun, 26 May 2002 10:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316130AbSEZObL>; Sun, 26 May 2002 10:31:11 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:31672 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316129AbSEZObK>; Sun, 26 May 2002 10:31:10 -0400
Date: Sun, 26 May 2002 16:30:55 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: linux-kernel@vger.kernel.org
Cc: eric.pouech@wanadoo.fr
Subject: SNDCTL_DSP_GETOSPACE bug for SB16 (was: SB16: 2.4.18 lockup on odd-numbered 16bit sound input)
Message-ID: <20020526143055.GA22909@andi.hausnetz>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[following up on my mail yesterday]

Hi all,

write()ing an odd number of bytes to a SB16 when using format
AFMT_S16_LE completely froze my system on 2.4.18.
By making sure that drivers/sound/sb_audio.c/sb16_copy_from_user()
discards the remainder of odd-numbered byte inputs, I was able to
correct this.

However digging deeper, I found that Wine sent odd-numbered amounts of
bytes to the Soundblaster due to SNDCTL_DSP_GETOSPACE returning odd
counts.
This happens because SNDCTL_DSP_GETOSPACE strictly returns the amount
of memory available in the DSP (DMA memory).
BUT: the SB16 driver does a 16bit -> 8bit conversion for AFMT_S16_LE
input data !!
Thus the amount of bytes you are able to immediately write() to the
driver is *twice* the "bytes" count of SNDCTL_DSP_GETOSPACE, since the
SB16 driver converts two input bytes into 1 DSP byte.

IMHO this is a bug of the SNDCTL_DSP_GETOSPACE bytes value in case of
the SB16 driver.
The various docus for SNDCTL_DSP_GETOSPACE that I found always said that
"bytes" is the amount of bytes you can write() to the driver without
blocking, so this would hint at a SNDCTL_DSP_GETOSPACE bug for SB16.

Or should instead the application program (here: Wine) figure out somehow
that in fact two bytes sent get converted to 1 byte in the sound driver ?
I don't think so.

How should the kernel driver (drivers/sound/audio.c/dma_ioctl())
get modified to handle the input byte count properly ?
Can someone show me an easy way, or should I modify the driver management
structs somewhat to let SNDCTL_DSP_GETOSPACE have an easy check for this
condition ?

BTW: the odd-numbered input happened because:

SB16: I've got 1988 bytes avail
Wine: ok, sending 1988 bytes
SB16: I've got 994 bytes avail
Wine: ok, sending 994 bytes
SB16: I've got 497 bytes avail
Wine: ok, sending 497 bytes
SB16: *BOOM*

What Wine should have sent instead is 1988*2==3976 bytes, of course,
as SNDCTL_DSP_GETOSPACE returned the buggy "real input/2" return value
due to the reasons above...
As Wine always sent one half of the data that it could have sent,
the return value always was one half of the previous "available" value,
thus leading to an odd 497 value.

It's about time for ALSA, methinks...
(provided that one doesn't have even worse bugs ;-)

-- 
Andreas Mohr                        Stauferstr. 6, D-71272 Renningen, Germany
