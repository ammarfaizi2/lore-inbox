Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129060AbQKOXD2>; Wed, 15 Nov 2000 18:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129076AbQKOXDT>; Wed, 15 Nov 2000 18:03:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4996 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129060AbQKOXDD>; Wed, 15 Nov 2000 18:03:03 -0500
Date: Wed, 15 Nov 2000 17:32:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: James Stevenson <mistral@stev.org>
cc: mike@flyn.org, linux-kernel@vger.kernel.org
Subject: Re: EJECT ioctl fails on empty SCSI CD-ROM
In-Reply-To: <Pine.LNX.3.95.1001115151153.15581A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.95.1001115172740.17073A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2000, Richard B. Johnson wrote:

> On Wed, 15 Nov 2000, James Stevenson wrote:
> 
> > 
> > Hi
> > 
> > this is what i get on 2.2.17
> > 
> > open("/dev/scd1", O_RDONLY|O_NONBLOCK)  = 3
> > ioctl(3, CDROMEJECT, 0xbffffc78)        = 0
> > close(3)                                = 0
> > 
> > 
> > >
> > >Is this the expected behavior?  If so, I am curious to hear the rationale
> > >behind it.
> > 
> 
> Well the open fails with ENOMEDIUM (errno 123). This is hardly appropriate
> since you can't insert any "media" on some machines without a paperclip.
> 
> readlink("/dev/cdrom", "", 256)         = 9
> open("/dev/scd0", O_RDONLY)             = -1 ERRNO_123 (errno 123)
> 

Well, here is another 'eject'.


#include <stdio.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <linux/cdrom.h>

int main(int arg, char *argv[])
{
    int fd;
    if(((fd = open("/dev/cdrom", O_RDONLY|O_NONBLOCK)) > 0) ||
       (arg > 1) && ((fd = open(argv[1], O_RDONLY|O_NONBLOCK)) > 0))
    {
        if(ioctl(fd, CDROMEJECT, NULL))         /* If it failed */
        {
           (void)ioctl(fd, CDROMRESET, NULL);   /* Reset it */
           (void)ioctl(fd, CDROMEJECT, NULL);
        }
        (void)close(fd);
        exit(EXIT_SUCCESS);
    }
    perror("open");
    exit(EXIT_FAILURE);
}


If there is no media in the drive, it fails to eject (open the tray).

open("/dev/cdrom", O_RDONLY|O_NONBLOCK) = 3
ioctl(3, CDROMEJECT, 0)                 = 671088642 -> error = 0
ioctl(3, 0x5312, 0)                     = 0  CDROMRESET
ioctl(3, CDROMEJECT, 0)                 = 671088642
close(3)                                = 0
_exit(0)                                = ?


I don't see an ioctl for CDROMOPENTRAY so I suppose CDROMEJECT
is the correct ioctl.

The last time I used CDROMEJECT, (Linux 2.2.17), it worked if there
was no media.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
