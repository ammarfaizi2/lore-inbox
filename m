Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316585AbSHHIoq>; Thu, 8 Aug 2002 04:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317393AbSHHIoq>; Thu, 8 Aug 2002 04:44:46 -0400
Received: from [195.63.194.11] ([195.63.194.11]:55562 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316585AbSHHIop>; Thu, 8 Aug 2002 04:44:45 -0400
Message-ID: <3D522F0E.8040404@evision.ag>
Date: Thu, 08 Aug 2002 10:42:54 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: martin@dalecki.de, Andries.Brouwer@cwi.nl,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [bug, 2.5.29, (not IDE)] partition table (not) corruption?
References: <Pine.LNX.4.44.0208080935170.31228-100000@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Ingo Molnar napisa?:
> On Thu, 8 Aug 2002, Marcin Dalecki wrote:
> 
> 
>>>>LILO without "linear" or "lba32" is inherently broken: it will talk CHS
>>>>at boot time to the BIOS and hence needs a geometry and install time,
>>>>and nobody knows the geometry required. So, if LILO doesnt break, this
>>>>is pure coincidence.
>>>
>>>
>>>well, lilo without linear worked for like years on this box ...
>>
>>You have to take in to account that by creating a new kernel image
>>you are storing it sometimes after a long long time at perhaps maybe
>>another block group far away.  This is becouse ext2 suddenly may feel
>>like doing so...And surprisingly you have to teach lilo about the new
>>far away sectors becouse basic C/H/S addressing can't reach them
>>anylonger. Been there seen that frequently enough.
> 
> 
> this particular testbox has seen *thousands* of development kernels of all
> sizes, and i often have filled up the complete /boot partition. It is very
> unlikely that this harmless (and not too big) 2.5.29 kernel would have
> been the first one to trigger a 'wrong' CHS combination. Especially since
> 2.4 kernels with exactly the *same* bzImage (and same lilo) work just
> fine.

Well well having a look at lilo-s inwards I can the the following:

     if (ioctl(fd,HDIO_GETGEO,&hdprm) < 0)
                 die("geo_query_dev HDIO_GETGEO (dev 0x%04x): %s",device,
                   strerror(errno));
             geo->heads = hdprm.heads;
             geo->cylinders = hdprm.cylinders;
             geo->sectors = hdprm.sectors;
             geo->start = hdprm.start;
             if ((geo->device = bios_device(geo, device)) < 0)
                 geo->device = 0x80 + (MINOR(device) >> 6) +
                     (MAJOR(device) == MAJOR_HD ? 0 : 
last_dev(MAJOR_HD,64));

If you look at the boot messages from a kernel:

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
  hda: 78140160 sectors, CHS=77520/16/63, UDMA(33)
  hda: hda1 hda4

You can actually see the CHS info field.
Would you care to maybe compare them between 2.4 and 2.5 on the
system in question?

If they are not different, well, taking a look at the bios_device()
in lilo you can actually see that it doesn't know *anything* about
EZ disk or similar partition table tricks and therelike - this can be
definitively considered a bug *there*.

