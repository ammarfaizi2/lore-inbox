Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265028AbSJWOkL>; Wed, 23 Oct 2002 10:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265029AbSJWOkL>; Wed, 23 Oct 2002 10:40:11 -0400
Received: from host179.debill.org ([64.245.56.179]:17857 "EHLO mail.debill.org")
	by vger.kernel.org with ESMTP id <S265028AbSJWOkJ>;
	Wed, 23 Oct 2002 10:40:09 -0400
Date: Wed, 23 Oct 2002 09:46:20 -0500
To: Chris Newland <chris.newland@emorphia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 fs corruption
Message-ID: <20021023144620.GB1317@debill.org>
References: <20021022220737.GA32539@debill.org> <OAEPKDBINGEGKPCJJAJDGELEHJAA.chris.newland@emorphia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OAEPKDBINGEGKPCJJAJDGELEHJAA.chris.newland@emorphia.com>
User-Agent: Mutt/1.3.28i
From: erik@debill.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 11:19:37AM +0100, Chris Newland wrote:
> Hi Erik,
> 
> Does your motherboard use the 760MPX chipset?
> 
> I used to get DMA related lockups on my MSI K7D-Master (760MPX, Dual 1900+)
> until I heard about the erratum in the 768 southbridge (see attached mail).
> From your dmesg it looks like you are using a USB trackball. Switching from
> USB to PS2 mouse fixed the problem for me.

That'd be my exact motherboard.  It's been quite stable for months
(with my beloved trackball plugged into the USB port), but I'll give
it a shot.

Both you and the errata mention lockups.  In my case the system
certainly didn't lock up - existing shell sessions still responded
(and generated new and interesting error messages).

Hmmm...  on second thought, I suspect this was the first time it put
the IDE bus in anything like UDMA 66.  2.5.44 had the Viper driver,
where 2.4.18 was just punting and running in UDMA 33.

I'll go stick a ps/2 mouse on the bugger and run w/ 2.5.44 for the
next day or so and see if it goes belly up again.


Erik




> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of erik@debill.org
> > Sent: 22 October 2002 23:08
> > To: linux-kernel@vger.kernel.org
> > Subject: 2.5.44 fs corruption
> >
> >
> > I have a happy little dual athlon desktop (Athlon MP1600+ processors -
> > should be rated for SMP use, no funny stuff), which has been running
> > nicely for months.  I installed 2.5.44 on it last night, and it seemed
> > to work fine.
> >
> > This morning when I went to use it I was greeted by a screen full of
> > "eth0: transmit timed out" (eth0 being an Intel EtherExpress Pro 100
> > using the eepro100 driver).  Trying to run commands (like sudo, dmesg,
> > ping) I got a lot of "unable to execute binary file foo" and IDE
> > errors complaining about attempts to read past the end of the device.
> > I was unable to do a graceful reboot, and had to hit the reset button.
> >
> > Upon reboot my root fs (ext2 under 2.4, but I loaded ext3 under
> > 2.5...) came up corrupted.  Fortunately it didn't seem to hit anything
> > important (I'll be reinstalling shortly).  None of the other
> > filesystems (all reiserfs or NFS) had problems.
> >
> > After repairing the fs I've tried a couple reboots into 2.5.44 to see
> > if corruption happens immediately - with no luck.  Looks like
> > something corrupted kernel memory overnight, and ended up stepping on
> > my filesystem along the way.
> >
> > I've got an nVidia video card, but I don't use the binary only module.
> > 2.4.18 actually thinks it finds a Radeon.
> >
> > dmesg from one of the later boots and .config included below.
> >
> >
> > Erik
> 
> <dmesg snipped>

> From: linux-kernel-owner@vger.kernel.org on behalf of Jan Kasprzak
> [kas@informatics.muni.cz]
> Sent: 25 September 2002 14:24
> To: linux-kernel@vger.kernel.org
> Cc: Mark Hahn; kernel@street-vision.com; Petr Konecny; Bruno A. Crespo;
> Denis Vlasenko; Alan Cox
> Subject: AMD 768 erratum 10 (solved: AMD 760MPX DMA lockup)
> 
> 	Hello, all!
> 
> two weeks ago I've posted to the LKML the following message:
> 
> [...]
> : my dual athlon box is unstable in some situations. I can consistently
> : lock it up by running the following code:
> : 
> : fd = open("/dev/hda3", O_RDWR);
> : for (i=0; i<1024*1024; i++) {
> :         read(fd, buffer, 8192);
> :         lseek(fd, -8192, SEEK_CUR);
> :         write(fd, buffer, 8192);
> : }
> [...]
> 
> 	I think I have been hit by AMD 768 southbridge erratum number 10.
> After plugging in the PS/2 mouse, the server is able to run 10 iterations
> of bonnie++ without any problem (w/o PS/2 mouse it locks up in first
> or second iterations).
> 
> 	I want to ask everyone who replied to me that the above code
> works for him on the 760MPX-based system to re-run the above code
> (or run bonnie++ benchmark several times in a loop), but _without_
> the PS/2 mouse connected?
> 
> 	Since this is an official AMD errata, we should have a work-around
> for this, or at least the big fat warning during boot, when the 768
> southbridge is detected - something like the following:
> 
> WARNING: Using the system with AMD 768 southbridge without the PS/2
> WARNING: mouse plugged in can cause instabilities. See the AMD 768 erratum #10
> 
> 	The AMD 768 Revision Guide is at the following URL:
> 
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/24472.pdf
> 
> the erratum #10 is described on page 7 (pstotext output, manually edited):
> 
> : 10	Multiprocessor System May Hang While in FULL APIC Mode
> : 	and IOAPIC Interrupt is Masked
> : 
> : Products Affected. B1, B2
> : 
> : Normal Specified Operation. The AMD-768 peripheral bus controller is
> : designed to support FULL APIC mode in multiprocessor systems for system
> : management events. If an interrupt is masked in the APIC controller of
> : the AMD-768, then the corresponding interrupt message should not be
> : sent to the processor via the 3-wire APIC bus.
> : 
> : Non-conformance. The AMD-768 peripheral bus controller will send an
> : interrupt message via the 3-wire APIC bus regardless if the interrupt
> : is masked or not.
> : 
> : Potential Effect on System. Since the processor had previously masked
> : the APIC interrupt, it is not expecting to receive future APIC messages
> : for the masked interrupt. The APIC controller will continuously send
> : the interrupt message via the 3-wire bus until a processor accepts the
> : message, causing the system to hang.
> : 
> : A system hang has been observed when executing a server shutdown
> : command in Novell Netware versions 5.0 or 5.1 while using a serial
> : mouse. During the server shutdown sequence, software writes an invalid
> : CPU ID to the IOAPIC redirection table, and the system does not
> : complete the shutdown.
> : 
> : Note: No failure has been observed when using a PS/2 mouse.
> : 
> : Suggested Workaround. None.
> : 
> : Resolution Status: No fix planned.
> 
> 
> -- 
> | Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
> | GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
> | http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> |----------- If you want the holes in your knowledge showing up -----------|
> |----------- try teaching someone.                  -- Alan Cox -----------|
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
If somebody sues you, you change the algorithm or you just hire a
hit-man to whack the stupid git.

                              -Linus Torvalds
                              (talking about software patents)



I understand everything perfectly.  Not my fault you guys don't know
what you're saying.
