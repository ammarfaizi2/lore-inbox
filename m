Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265962AbRGJIsQ>; Tue, 10 Jul 2001 04:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265948AbRGJIsH>; Tue, 10 Jul 2001 04:48:07 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:49938 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S265958AbRGJIsA>;
	Tue, 10 Jul 2001 04:48:00 -0400
Date: Tue, 10 Jul 2001 10:47:58 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: IDE bus problems
To: testers-list@redhat.com, linux-kernel@vger.kernel.org
Message-id: <3B4AC13E.8AD30AC5@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I discovered some problems with IDE subsystem in linux :

[root@localhost /root]# scsireset/idereset  /dev/hdd # basically an ioctl(hdd,HDIO_DRIVE_RESET); program source below
hdd: DMA disabled
scsireset : ioctl succesful
hdd: ide_set_handler: handler not null; old=c01884a0, new=d08162f0
bug: kernel timer added twice at c01883c8.

Excerpt from my System map :
c0188370 T ide_set_handler
c01883d0 T current_capacity
c0188400 T ide_geninit
c01884a0 t atapi_reset_pollfunc
c0188570 t reset_pollfunc

Is this a bug ?

It doesn't do much of resetting anyway: I tried to mount a blank
CD-RW in my CD-ROM unit ( /dev/hdd , HW details below ) and the unit
locked up. The LED kept on blinking and the drive didn't respond
any more ( "eject /dev/hdd" failed , for example ). I sent
a HDIO_DRIVE_RESET to it with my program , but nothing happened.
A ctrl-alt-del (reboot) fixed it.
( I also loaded ide-scsi and sent an ioctl("/dev/sg1",SG_SCSI_RESET,SCSI_RESET_DEVICE)
and it didn't do anything either. I also tried xxx_RESET_{HOST,BUS} )

Another thing : 
- in short : after issuing "idereset /dev/hdd" the ide1
channel becomes extremely slow, like one packet per minute.

- long version : 
I issued "idereset /dev/hdd" a few minutes ago.
When I'm writing this line both CD units on ide1 are "dead".
There is a "eject -t /dev/hdc" ( tray is currently open )
command and a "mount /dev/hdd /mnt/cdrom1" command in "execution". 
Both are blocked for several minutes now.
Oh, the tray just closed on hdc and the "eject" command finished.
a few seconds pass ( cca. 20 )
/dev/hdd just spun up the CD, "mount ..." is still blocked.
and after another 30 seconds it finished too.
I am doing a "ls -R /dev/cdrom1" now. It prints a few files and
then waits so long that the drive spins down !

Seems as if all IDE traffic on ide1 is going in extreme slow motion.
ide0 behaves normally. ( I have a single hard drive there , hda )

Nothing weird in the logs or on console.

System details :
kernel 2.4.3-12 ( from redhat )
MSI K7T Pro2A motherboard ( VIA KT133, 686b )
hdc is an Acer 1208A CD-RW drive
hdd is a Teac CD532E-B CDROM unit

--------------
source of idereset.c :


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
//#include <scsi/sg.h>

void print_usage(FILE * out_file)
{
   fprintf(out_file,"idereset " IDERESET_VERSION "\nArgument error.Usage :\n");
   fprintf(out_file,"idereset /dev/hdX\n");
}

int main (int argc,char ** argv)
{
//   unsigned long int reset_type; /* the arg for the SG_SCSI_RESET ioctl */
   int device_fd;                /* file descriptor for the device file */
   
   /* evaluate reset type */
   if ( argc !=2 )
     {   
        print_usage(stderr);
        return 1;
     }
   /*
   if(!strcmp("DEVICE",argv[2]))
     reset_type = SG_SCSI_RESET_DEVICE;
   else if(!strcmp("BUS",argv[2]))
     reset_type = SG_SCSI_RESET_BUS;
   else if(!strcmp("HOST",argv[2]))
     reset_type = SG_SCSI_RESET_HOST;
   else
     {
        print_usage(stderr);
        return 1;
     }
   */
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
