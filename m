Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314554AbSEYN16>; Sat, 25 May 2002 09:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314557AbSEYN15>; Sat, 25 May 2002 09:27:57 -0400
Received: from zeus.kernel.org ([204.152.189.113]:29080 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S314554AbSEYN15>;
	Sat, 25 May 2002 09:27:57 -0400
Date: Sat, 25 May 2002 15:26:44 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: linux-kernel@vger.kernel.org
Subject: SB16: 2.4.18 lockup on odd-numbered 16bit sound input
Message-ID: <20020525132644.GA3095@andi.hausnetz>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

yesterday I installed a program on Wine, when suddenly my 2.4.18 froze.
What the !#$%^%&* !?

Well, I did some Wine tracing (especially sound driver),
but that didn't help a lot.
Then I added some printk's to my SB16 driver. That helped.
Turned out that Wine sent an *odd* number of bytes for a *16bit* output
device.
This resulted in the kernel happily playing these bytes until it reached
1 byte, at which time the hardware driver (SB16) decided to not use
this byte, as 16bit output needs 2 bytes/sample, of course.
This led to eternal looping in drivers/sound/audio.c/audio_write(), as c
never reached 0
-> deadlock !

At first I thought that what needs to be done is to check in the
        while (c)
        {
                if ((err = DMAbuf_getwrbuffer(dev, &dma_buf, &buf_size, !!(file->f_flags & O_NONBLOCK))) < 0)
                {
...
        }
loop in audio_write() whether c actually is sufficiently large
for yet another sample to be played.
This could be done e.g. by deducing the current sample size from the
audio_devs[dev]->devc->bits value (AFMT_S16_LE, ...).

and doing
        while (c >= current_sample_size)
instead.

This is ugly, though, since I guess that audio_write() was intended
to be completely independent of any format issues (i.e. simply dispatch
the arriving data to the proper hardware sound driver and completely ignore
any formats).

Fixing the hardware driver's copy_user to completely accept odd-numbered
input would probably be better. OTOH this would lead to the hardware driver
simply discarding the odd remainder, which would be bad in case the program
intends to send another odd-numbered amount of bytes next time to properly
complete the incomplete write() last time.

Maybe the best way would be to tell audio_write() via return value that
the sound driver doesn't accept data any more, and then return the actual
byte count processed, not just directly use "count" as the return value.

So to summarize, AFAICS we have three ways to make it happen:
a) abort the loop in audio_write() in case insufficient remainders exist
b) fix hardware driver's copy_user to completely accept odd input,
   probably by discarding odd remainders
c) actively tell the loop that copy_user finished processing data and
   eventually return incomplete byte counts

Both a) and b) would discard remainders.
c) would rely on the user program properly resending the unprocessed byte
within the next write()
(and we all know this won't happen in 60% of all cases :)

I think the main question that this revolves around is what to do with
odd-numbered/misaligned write() input in case of multi-byte audio formats.
Should the kernel
1) discard odd remainders
2) tell the user program by returning incomplete counts that it discarded it
3) buffer unprocessable remainders for use in the next write()
?

1) is probably the right answer, but I wouldn't know whether that's the
expected behaviour.
3) is rather unacceptable, I guess.

Again, what should be done to properly handle odd-numbered input ?
Given that 2.6.x will include ALSA anyway, I'm really tempted to simply
discard odd remainders as a quick interim solution.

Thanks for any suggestions !

-- 
Andreas Mohr                        Stauferstr. 6, D-71272 Renningen, Germany
