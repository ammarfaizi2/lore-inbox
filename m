Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272172AbRHWKRP>; Thu, 23 Aug 2001 06:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272070AbRHWKRG>; Thu, 23 Aug 2001 06:17:06 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:37650 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S271944AbRHWKQz>;
	Thu, 23 Aug 2001 06:16:55 -0400
Date: Thu, 23 Aug 2001 12:17:05 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: [BUG] HDIO_DRIVE_RESET ioctl is buggy
To: david.balazic@uni-mb.si,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        andre@linux-ide.org, axboe@suse.de
Message-id: <3B84D821.C2D157D1@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The HDIO_DRIVE_RESET ioctl implementation in ide.c is broken :

linux-2.4.8-ac8 , hdd is a Teac CD532E-B CDROM drive

( it is the same for several latest linux versions )

[root@localhost scsireset]# ./idereset /dev/hdd # source of iderest below , it just sends the ioctl
hdd: DMA disabled
idereset : ioctl succesful # this is from my idereset program , the rest are kernel messages
hdd: ide_set_handler: handler not null; old=c017e9a0, new=e08ce2f0
bug: kernel timer added twice at c017e8e8.


relevant System.map parts :

c017e800 T ide_end_request
c017e890 T ide_set_handler
c017e8f0 T current_capacity
c017e920 T ide_geninit
c017e9a0 t atapi_reset_pollfunc
c017ea70 t reset_pollfunc
c017ebd0 t check_dma_crc

part of  `ksymoops -s all.map` :

e08ce240 t cdrom_start_read     [ide-cd]
e08ce2f0 t cdrom_pc_intr        [ide-cd]
e08ce4b0 t cdrom_do_pc_continuation     [ide-cd]

source if idereset.c :

/*************************
 * idereset - reset an ide device
 * 
 * Usage : idereset /dev/hdX
 * 
 */

#define IDERESET_VERSION "v0.1"


#include <string.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <unistd.h>
#include <linux/hdreg.h>

void print_usage(FILE * out_file)
{
   fprintf(out_file,"idereset " IDERESET_VERSION "\nArgument error.Usage :\n");
   fprintf(out_file,"idereset /dev/hdX\n");
}

int main (int argc,char ** argv)
{
   int device_fd;                /* file descriptor for the device file */
   
   if ( argc !=2 )
     {   
        print_usage(stderr);
        return 1;
     }
/* open device */
   device_fd=open(argv[1], O_RDONLY | O_NONBLOCK);
   if ( device_fd == -1 )
     {
        perror(argv[1]);
        return 1;
     }
   /* ioctl */
   if(ioctl( device_fd, HDIO_DRIVE_RESET , NULL))
     perror(argv[1]);
   else
     printf("idereset : ioctl succesful\n");
   
   close(device_fd);
   
   return 0;
}
-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
