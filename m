Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934541AbWKXKQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934541AbWKXKQK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 05:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934542AbWKXKQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 05:16:09 -0500
Received: from s1.mailresponder.info ([193.24.237.10]:2574 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S934541AbWKXKQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 05:16:07 -0500
Subject: Re: 'False' IO error when copying from cdrom drive
From: Mathieu Fluhr <mfluhr@nero.com>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061123231825.342a3237.vsu@altlinux.ru>
References: <1164311305.3013.25.camel@de-c-l-110.nero-de.internal>
	 <20061123231825.342a3237.vsu@altlinux.ru>
Content-Type: text/plain
Organization: Nero AG
Date: Fri, 24 Nov 2006 11:14:00 +0100
Message-Id: <1164363240.3010.16.camel@de-c-l-110.nero-de.internal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I understand the point. So this 0x1fffff is somehow a default
value right? (Humm why 0x1fffff by the way?)

But:
- when I open /dev/hdxx with the O_NONBLOCK flag, this is specially to
get a 'raw' access on the device. If I do not pass this flag, the open
syscall will fail if no media is in the device.

- when that mount command is used, the mount will fail if no medium is
inside. So wouldn't it be a good idea to recheck the toc at this time
(something like calling the .revalidate_disk function I mean) 

These are just suggestions... I am just really astonished that a single
user program can disturb the mount command with optical disc devices :D

Regards,
Mathieu

On Thu, 2006-11-23 at 23:18 +0300, Sergey Vlasov wrote:
> On Thu, 23 Nov 2006 20:48:25 +0100 Mathieu Fluhr wrote:
> 
> > I explain: First take this really simple program:
> > ----8<------------------------------------------------------------------
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> >
> >
> > int main(int argc, char **argv)
> > {
> >   if(argc < 2)
> >     return 0;
> >
> >   int iFD = open(argv[1], O_RDONLY | O_NONBLOCK);
> >   if(iFD == -1)
> >     perror("open");
> >
> >   while(1)
> >     sleep(1);
> >
> >   return 0;
> > }
> > ----8<-----------------------------------------------------------------
> [..]
> > Ok. Now take a full DVD (I tested DVD+R, +RW and -R), with more than
> > 4 300 000 000 bytes (very important :), and perform the following:
> >
> > 0. Open the tray of your recorder
> > 1. Launch this small program above, passing the recorder device file as
> >    argument and let it run in background.
> 
> At this time the following code in drivers/ide/ide-cd.c:cdrom_read_toc()
> is executed:
> 
> 	/* Try to get the total cdrom capacity and sector size. */
> 	stat = cdrom_read_capacity(drive, &toc->capacity, &sectors_per_frame,
> 				   sense);
> 	if (stat)
> 		toc->capacity = 0x1fffff;
> 
> 	set_capacity(info->disk, toc->capacity * sectors_per_frame);
> 
> Obviously, with the tray open cdrom_read_capacity() won't succeed,
> therefore toc->capacity will be set to 0x1fffff.
> 
> > 2. then put the disc in the device and mount it
> > 3. try to copy to whole content on the hard drive
> >
> > -> You will get an error like the following:
> >   > kernel: attempt to access beyond end of device
> >   > kernel: hdb: rw=0, want=8388612, limit=8388604
> 
> 0x1fffff * 2048/512 == 8388604
> 
> Your background program is keeping the device open, which prevents
> revalidation of capacity and other media information on subsequent
> device opens.
> 
> When HAL polls CD-ROM devices to detect newly inserted media, it does
> not keep the device open forever - instead, it opens and closes the
> device every time.  Your program should either do the same thing, or
> just depend on HAL events.

