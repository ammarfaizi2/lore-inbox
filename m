Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271207AbRHPHq5>; Thu, 16 Aug 2001 03:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271513AbRHPHqs>; Thu, 16 Aug 2001 03:46:48 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:15368 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S271207AbRHPHqg>;
	Thu, 16 Aug 2001 03:46:36 -0400
Date: Thu, 16 Aug 2001 09:46:38 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: [BUG] HDIO_DRIVE_RESET ioctl is buggy
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3B7B7A5E.2C1EAF1A@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.4.8-ac2 , hdc is an ACER 1208A CD-RW

it is the same for several latest linux versions :

[root@localhost scsireset]# ./idereset /dev/hdc
hdc: DMA disabled
idereset : ioctl succesful
hdc: ide_set_handler: handler not null; old=c0184340, new=e0887354
bug: kernel timer added twice at c0184251.

source if idereset.c :

/*************************
 * idereset - reset an ide device
 * 
 * Usage : idereset /dev/hdX
 * 
 * 
 * Copyright 2001 David Balazic
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
