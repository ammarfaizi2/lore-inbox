Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSGAP4s>; Mon, 1 Jul 2002 11:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSGAP4r>; Mon, 1 Jul 2002 11:56:47 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:33527 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S315690AbSGAP4o>;
	Mon, 1 Jul 2002 11:56:44 -0400
Date: Mon, 1 Jul 2002 17:59:10 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lilo/raid?
Message-ID: <20020701155910.GA21471@win.tue.nl>
References: <200207011604.58253.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207011604.58253.roy@karlsbakk.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 04:04:58PM +0200, Roy Sigurd Karlsbakk wrote:

> still - sorry if this is OT - I'm just too close to tear my hair or head off 
> or something
> 
> The documentation everywhere, including the lilo 22.3.1 sample conf ffile 
> tells me "use boot = /dev/md0", but lilo, when run, just tells me 
> 
> Fatal: Filesystem would be destroyed by LILO boot sector: /dev/md0
> 
> Please help

But (i) why don't you ask the maintainer of LILO,
(ii) why don't you read the source?

If I grep for "Filesystem would be destroyed" in the LILO sources
I find it in lilo-22.3.1/bsect.c:

    ireloc = part_nowrite(boot_dev);
    if (ireloc>1) {
        die("Filesystem would be destroyed by LILO boot sector: %s", boot_dev);
    }

So, some routine part_nowrite() returned a value larger than 1.
This routine lives in partition.c and does

int part_nowrite(char* device)
{
    int fd;
    BOOT_SECTOR bs;

    int ret=0;  /* say ok, unless we recognize a problem partition */

    if ((fd = open(device, O_RDONLY)) < 0) pdie("part_nowrite check:");
    if (read(fd, bs.sector, sizeof(bs)) != SECTOR_SIZE) pdie("part_nowrite: rea\
d:");

/* check for XFS */
    if (!strncmp("XFSB", bs.sector, 4)) ret=2;

/* check for NTFS */
    else if (   !strncmp("NTFS", bs.par_d.system, 4)
                || strstr(bs.sector,"NTLDR")  ) ret=2;

/* check for SWAP -- last check, as 'bs' is overwritten */
    else if (*(long*)bs.sector == 0xFFFFFFFEUL) {
        if (lseek(fd, (PAGE_SIZE)-SECTOR_SIZE, SEEK_SET) != (PAGE_SIZE)-SECTOR_\
SIZE)
            pdie("part_nowrite lseek:");
        if (SECTOR_SIZE != read(fd, bs.sector, sizeof(bs)) ) pdie("part_nowrite\
 swap check:");
        if (!strncmp(bs.sector+SECTOR_SIZE-10,"SWAPSPACE2",10)
            || !strncmp(bs.sector+SECTOR_SIZE-10,"SWAP-SPACE",10) ) ret=2;
    }

/* check for override (-F) command line flag */
    if (ret==2 && force_fs) {
        fprintf(errstd, "WARNING: '-F' override used. Filesystem on  %s  may be\
 destroyed.\n", device);
        ret=0;
    }

    return ret;
}

So, it looks like (1) you can use the -F flag and lilo will go ahead anyway,
(2) lilo thinks it recognizes XFS or NTFS or swap space on the boot sector
of your device.

It must be easy for you to investigate what you have in reality, and
determine whether there is any potential problem.

Andries
