Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292952AbSCIVkY>; Sat, 9 Mar 2002 16:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292954AbSCIVkP>; Sat, 9 Mar 2002 16:40:15 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:49421 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S292952AbSCIVj5>;
	Sat, 9 Mar 2002 16:39:57 -0500
Date: Sat, 9 Mar 2002 22:03:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dalecki@evision-ventures.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Suspend support for IDE
Message-ID: <20020309210319.GA691@elf.ucw.cz>
In-Reply-To: <20020308180204.GA7035@elf.ucw.cz> <E16jPEs-00073F-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16jPEs-00073F-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +	while (HWGROUP(drive)->handler)
> > +		schedule();
> 
> You need to yield. Remember the process might be hard real time and blocking
> your real work from occuring. while(foo) schedule() is always a bug

The process calling this is kernel thread doing powermangment; we have
it under full control. yield() is probably more intuitive, through.

> > +static int idedisk_resume(struct device *dev, u32 level)
> > +{
> > +	ide_drive_t *drive = dev->driver_data;
> > +	if (!drive->blocked)
> > +		panic("ide: Resume but not suspended?\n");
> > +	drive->blocked = 0;
> > +}
> 
> Also remember you must perform the sequences to wake up the drive and
> restore the controller logic (and of course in the right order). Newer
> disks won't just wake up when fed a random command (eg ibm
> microdrives)

Wake from S3 or S4 should look like power-up from disks perspective. I
should need no commands to do that.

Restoring right UDMA mode... Well, I'll need to do that,
probably. (What I have there is just enough to prevent disk
corruption. I'm still likely to see some bus resets, but no longer
data loose, I believe.)

> The suspend order similarly is important - finish the current
> command,

The while loop above should make sure no command is happening just
now, right?

> then flush the disk cache, then when it completes you can tell the
> drive

Disks that need cache flush are broken, anyway -- they lied us on
command completion -- right?

> to power down. 

Why should I tell the drive to power down? It is going to loose its
power, anyway (I believe in both S3 and S4).

> On some systems you want to drop it back to PIO0 non DMA
> before the powerdown or S4BIOS restore from disk will fail.


S4BIOS is not on my list just now; agreed it would be better.

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
