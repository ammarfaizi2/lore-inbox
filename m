Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315430AbSFEOJJ>; Wed, 5 Jun 2002 10:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSFEOJI>; Wed, 5 Jun 2002 10:09:08 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:33236 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S315430AbSFEOJH>; Wed, 5 Jun 2002 10:09:07 -0400
Message-ID: <3CFE1B78.9010406@antefacto.com>
Date: Wed, 05 Jun 2002 15:08:56 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        sopwith@redhat.com, otaylor@redhat.com
Subject: Re: Need help tracing regular write activity in 5 s interval
In-Reply-To: <20020602135501.GA2548@merlin.emma.line.org> <3CFCA2B0.4060501@antefacto.com> <20020604120434.GA1386@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sure it will :-)

However this it just masking the "problem", and I don't
think it's "buggy CDROM drives" as I've tried 3 different
machines with the following drives:

SAMSUNG DVD-ROM SD-612
TOSHIBA DVD-ROM SD-C2402
CREATIVE CD5233E

and they all show the same problem. I.E. logs filling with
"VFS: Disk change detected on device ide1(22,0)".

magicdev essentially does:

while (1) {
     cd = open ("/dev/cdrom", O_RDONLY|O_NONBLOCK);
     if (ioctl (cd, CDROM_DRIVE_STATUS, CDSL_CURRENT) == CDS_DISC_OK) {
         /* do stuff */
     }
     close(cd);
     sleep(2);
}

Note, it's the open() that causes the check_media_changed(),
so why does this always return true? Is there a way you
can turn it it off? echoing [01] to /proc/sys/dev/cdrom/check_media
made no difference.

Also related, why does the LED flash on every ATA command?
Is this controlled by the drive or ide controller?
Are you telling me that windows would flash the LED every so often
to automount CDs?

thanks,
Padraig.

Erik Andersen wrote:
> On Tue Jun 04, 2002 at 12:21:20PM +0100, Padraig Brady wrote:
> 
>>As an aside, Nautilus (1.0.4) does stuff every 2 seconds
>>(checking is there a CD inserted) that causes the disk LED to flash.
>>The same action also causes the kernel (2.4.13) to fill up the ring
>>buffer with: "VFS: Disk change detected on device ide1(22,0)".
> 
> 
> This should fix the symptom...
> 
> --- linux/fs/block_dev.c.orig	Tue Jun  4 06:03:44 2002
> +++ linux/fs/block_dev.c	Tue Jun  4 06:03:44 2002
> @@ -582,8 +582,11 @@
>  	if (!bdops->check_media_change(dev))
>  		return 0;
>  
> +	#if 0
> +	/* Polling buggy CD-ROM drives can fill the logs.  Make it shutup. */
>  	printk(KERN_DEBUG "VFS: Disk change detected on device %s\n",
>  		bdevname(dev));
> +	#endif
>  
>  	sb = get_super(dev);
>  	if (sb && invalidate_inodes(sb))
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--



