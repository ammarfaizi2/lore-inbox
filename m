Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWB1SBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWB1SBK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWB1SBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:01:10 -0500
Received: from smtpout.mac.com ([17.250.248.86]:3302 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932322AbWB1SBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:01:08 -0500
X-PGP-Universal: processed;
	by AlPB on Tue, 28 Feb 2006 12:01:07 -0600
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: sg regression in 2.6.16-rc5
Date: Tue, 28 Feb 2006 11:54:59 -0600
To: linux-scsi@vger.kernel.org
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have encountered some kind of sg regression with kernel 2.6.16-rc5  
relative to 2.6.15. We have a small program that demonstrates the  
failure. On 2.6.15 it produces the output:

Alloced dataptr 0 -> 0xb7d07008
IOS: 0
ios 100

indicating that it did 100 operations successfully. On 2.6.16-rc5, it  
produces the output:

Alloced dataptr 0 -> 0xa7d10008
SG_IO ioctl error 12 Cannot allocate memory
ios 0

indicating that it did 0 operations successfully. This program is  
attempting to do 1MB reads on a SCSI device. We get the failure both  
on an aic79xx parallel SCSI and on aic94xx SAS. With both types of  
devices, it works fine on the 2.6.15 kernel. We have also seen this  
problem on the 2.6.16-rc4 kernel. In all cases we were running on an  
Intel Xeon-based system.

Below is the source for the program that was used to demonstrate this  
problem:

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sched.h>
#include <error.h>
#include <errno.h>
#include <string.h>
#include <scsi/sg.h>
#include <scsi/scsi.h>
#include <sys/ioctl.h>
#include <sys/epoll.h>
#include <ctype.h>


void dispsns(unsigned char cdb0, unsigned char *sense_buffer, int len)
{
     int i;
     unsigned int *dwptr;
     printf("sense:  cdb0 : %02hhX",cdb0);
     dwptr = (unsigned int *) &sense_buffer;
     for (i = 0; i < len ; i++) {

         if (!(i % 16)) {
             printf("\n%02hhX", sense_buffer[i]);
             continue;
         }
         if (!(i % 4))
             printf(" ");
         printf("%02hhX", sense_buffer[i]);
     }
     printf(" KEY: %02hhX ", sense_buffer[2] & 0x0f);
     printf("ASC: %02hhX ", sense_buffer[12]);
     printf("ASCQ: %02hhX\n", sense_buffer[13]);
}

/*
     sends the given io to the sg layer if there is only 1 SGL  
element first IO
     will be attmpeted.  Otherwise the SGL is sent
*/
int do_scsi_io(int sg_fd, unsigned char *cdb,int cdblen, sg_iovec_t  
*iovec,
     int dir, int datalen,int sglcount)
{
     unsigned char sense_buffer[32];

     sg_io_hdr_t io_hdr;
     memset(&io_hdr, 0, sizeof(sg_io_hdr_t));

     io_hdr.interface_id = 'S';
     io_hdr.cmd_len = cdblen;
     io_hdr.mx_sb_len = 32;
     io_hdr.dxfer_direction = dir;
     io_hdr.dxfer_len = datalen;
     if (sglcount > 1) {
         io_hdr.dxferp = iovec;
         io_hdr.iovec_count = sglcount;
     } else {
         io_hdr.flags |= SG_FLAG_DIRECT_IO;
         io_hdr.dxferp = iovec[0].iov_base;
         io_hdr.iovec_count = 0;
     }
     io_hdr.cmdp = cdb;
     io_hdr.sbp = sense_buffer;
     io_hdr.timeout = 10000;     /* 10000 millisecs == 10 seconds */
     memset(&sense_buffer, 0, 32);

     if (ioctl(sg_fd, SG_IO, &io_hdr) < 0) {
         printf("SG_IO ioctl error %d %s\n", errno, strerror(errno));
         return -1;
     }
     if ((io_hdr.info & SG_INFO_OK_MASK) == SG_INFO_OK) {
         return datalen - io_hdr.resid;
     } else {
         dispsns(cdb[0], sense_buffer, io_hdr.sb_len_wr);
         return -1;
     }
}

unsigned int IOLEN = 0x100000;
unsigned int SGLCOUNT =  1;
unsigned int LOOPCOUNT = 100;
int main(int argc, char *argv[])
{
     char devpath[80];
     int i;
     int handle;
     int ret;
     unsigned char readCmdBlk[10] = {0x28, 0, 0, 0, 0x00, 0, 0, 0 ,0,  
0};
     unsigned int blkcount;
     sg_iovec_t  iovectable[SGLCOUNT];
     void *dataptr[SGLCOUNT];
     void *dataptr2[SGLCOUNT];

     if (argc < 2) {
         printf("Error: no input parms\n");
         printf("  Usage: iotest /dev/sg<n>\n");
         return -1;
     }

     for (i = 0; i < SGLCOUNT; i++) {
         dataptr[i] = malloc((IOLEN/SGLCOUNT) + 0x2000);
         dataptr2[i] = dataptr[i];
         printf("Alloced dataptr %d -> %p \n", i, dataptr[i]);
     }

     for (i = 0; i < SGLCOUNT; i++)
         if (dataptr[i] == NULL) {
             printf("Unable to alloc memory \n");
             return -1;
         }
     for (i = 0; i < SGLCOUNT; i++) {
         iovectable[i].iov_base = dataptr2[i];
         iovectable[i].iov_len = IOLEN/SGLCOUNT;
     }
     strcpy(devpath, argv[1]);

     handle = open(devpath, O_RDWR);
     if (handle == -1) {
         printf(" Open of %s failed \n",devpath);
         for (i = 0; i < SGLCOUNT; i++)
             free(dataptr[i]);
         return -1;
     }
     blkcount = IOLEN /0x200;
     readCmdBlk[2] = 0; /*lba*/
     readCmdBlk[3] = 0; /*lba*/
     readCmdBlk[4] = 0; /*lba*/
     readCmdBlk[5] = 0; /*lba*/
     readCmdBlk[7] = (blkcount & 0xff00) >> 8; /*len*/
     readCmdBlk[8] = blkcount & 0xff; /*len*/

     for (i = 0; i < LOOPCOUNT; i++) {
         ret = do_scsi_io(handle, readCmdBlk, 10, iovectable,
                 SG_DXFER_FROM_DEV, IOLEN,SGLCOUNT);
         if (ret == -1)
             break;
         if ((i & 0xFF) == 0)
             printf(" IOS: %d \n", i);
     }
     printf("ios %d \n", i);
     for (i = 0; i < SGLCOUNT; i++)
            free(dataptr[i]);

     return 0;
}

-- 
Mark Rustad, MRustad@mac.com

