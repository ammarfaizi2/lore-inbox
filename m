Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVBAWBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVBAWBz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVBAWBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:01:55 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:10924 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262137AbVBAWB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:01:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=UvTmr5QE4YK+oqW9kIWWXFlBeAfwkvksUFpZIwR3CJoFtzIzCuDrJT8+SGc4aBIZ03TNLmpgST1OdU2YfYwnRVjdpAM5AqRMyKllaGGu+VC3tAKgvfOi31al85gG/GozZDK+UYps4ixgozCTPWvqk7ev8Sf+rx/2UYnQj1vZ2Vs=
Message-ID: <e3e2b9de050201140154962b5d@mail.gmail.com>
Date: Tue, 1 Feb 2005 17:01:28 -0500
From: Li Lang <lilang2004@gmail.com>
Reply-To: Li Lang <lilang2004@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux kernel 2.4.21 I/O subsystem bug report
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have no idea to whom to send this report. Sorry if I sent this to
the wrong person.

Bug report

SG_IO sg_io_hdr bug (possibly)
I send a scsi read command 0x28 to a scsi generic device with a very
low timeout value (10 milliseconds). The I/O was aborted successfully
according to the syslog message but there was no indication of the
abort happening in the output status of sg_io_hdr.

Linux kernel 2.4.21

test progrem source code:

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>

#include <scsi/sg.h>

#define DATA_SIZE 512 * 100 /* 100 block */ 

main(argc, argv)
int argc;
char **argv;
{
  int k = 0, fd, rc;
  int request = 0;
  FILE *fileP = NULL;
  unsigned char buffer[DATA_SIZE];
  unsigned char cmd[10];
  unsigned int randomLba = 0;
  sg_io_hdr_t scsiControl;

  if (argc < 2) {
    printf("diskabrt usage:\n");
    printf("   diskabrt <devpath>\n\n");
    return -1;
  }

  memset(&scsiControl, 0, sizeof(sg_io_hdr_t));
  memset(&cmd[0], 0, 10);
  request = SG_IO;

  scsiControl.interface_id = 'S';
  scsiControl.dxfer_direction = SG_DXFER_FROM_DEV;
  scsiControl.cmd_len = 10;
  scsiControl.dxfer_len = DATA_SIZE;
  scsiControl.dxferp = (void *) &buffer[0];
  scsiControl.cmdp = &cmd[0];
  scsiControl.timeout = 10; /* in millisec */
  cmd[0] = 0x28;
  cmd[7] = 0x00;
  cmd[8] = 0x64;
 

  fd = open(argv[1], O_RDWR | O_NDELAY);
  if(fd == -1) {
    printf("Error opening %s\n", argv[1]);
    return -2;
  }

  if((ioctl(fd, SG_GET_VERSION_NUM, &k) < 0)) {
    printf("SG_GET_VERSION_NUM failed with errno = %d\n", errno);
    return -3;
  }

  printf("SG driver version = %d\n", k);

  randomLba = 0x942c99;
  cmd[2] = (unsigned char) ((randomLba & 0xff000000) >> 24);
  cmd[3] = (unsigned char) ((randomLba & 0x00ff0000) >> 16);
  cmd[4] = (unsigned char) ((randomLba & 0x0000ff00) >> 8);
  cmd[5] = (unsigned char) ((randomLba & 0x000000ff));

  if( (rc = ioctl(fd, request, &scsiControl)) < 0 )
  {
    printf("SCSI READ failed with errno = %d, rc = %d\n", errno, rc);
    printf("cdb_status = 0x%x\n", scsiControl.status);
    return -3;
  }

  if (rc == 0) {
    printf("SCSI READ successful\n");
    printf("status = 0x%x\n", scsiControl.status);
    printf("info = 0x%x\n", scsiControl.info);
    printf("masked_status = 0x%x\n", scsiControl.masked_status);
    printf("host_status = 0x%x\n", scsiControl.host_status);
    printf("driver_status = 0x%x\n", scsiControl.driver_status);
    printf("Time to complete the command: %d ms\n", scsiControl.duration);
  }

  close(fd);

  return 0;
}

The output is:

SG driver version = 30125
SCSI READ successful
status = 0x0
info = 0x0
masked_status = 0x0
host_status = 0x0
driver_status = 0x0
Time to complete the command: 20 ms



Here is the /var/log/messages output:

Feb  1 15:33:50 lqam3018 kernel: scsi0:0:0:0: Attempting to queue an
ABORT message
Feb  1 15:33:50 lqam3018 kernel: CDB: 0x28 0x0 0x0 0x94 0x2c 0x99 0x0
0x0 0x64 0x0
Feb  1 15:33:50 lqam3018 kernel: scsi0: At time of recovery, card was not paused
Feb  1 15:33:50 lqam3018 kernel: >>>>>>>>>>>>>>>>>> Dump Card State
Begins <<<<<<<<<<<<<<<<<
Feb  1 15:33:50 lqam3018 kernel: scsi0: Dumping Card State while idle,
at SEQADDR 0x8
Feb  1 15:33:50 lqam3018 kernel: Card was paused
Feb  1 15:33:50 lqam3018 kernel: ACCUM = 0x4, SINDEX = 0x64, DINDEX =
0x65, ARG_2 = 0x8
Feb  1 15:33:50 lqam3018 kernel: HCNT = 0x0 SCBPTR = 0x5
Feb  1 15:33:50 lqam3018 kernel: SCSIPHASE[0x0] SCSISIGI[0x0]
ERROR[0x0] SCSIBUSL[0x0]
Feb  1 15:33:50 lqam3018 kernel: LASTPHASE[0x1] SCSISEQ[0x12]
SBLKCTL[0xa] SCSIRATE[0x0]
Feb  1 15:33:50 lqam3018 kernel: SEQCTL[0x10] SEQ_FLAGS[0xc0]
SSTAT0[0x0] SSTAT1[0x8]
Feb  1 15:33:50 lqam3018 kernel: SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x8]
SIMODE1[0xa4]
Feb  1 15:33:50 lqam3018 kernel: SXFRCTL0[0x80] DFCNTRL[0x0] DFSTATUS[0x89]
Feb  1 15:33:50 lqam3018 kernel: STACK: 0xe1 0x163 0x178 0x3
Feb  1 15:33:50 lqam3018 kernel: SCB count = 36
Feb  1 15:33:50 lqam3018 kernel: Kernel NEXTQSCB = 24
Feb  1 15:33:50 lqam3018 kernel: Card NEXTQSCB = 24
Feb  1 15:33:50 lqam3018 kernel: QINFIFO entries:
Feb  1 15:33:50 lqam3018 kernel: Waiting Queue entries:
Feb  1 15:33:50 lqam3018 kernel: Disconnected Queue entries: 5:35
Feb  1 15:33:50 lqam3018 kernel: QOUTFIFO entries:
Feb  1 15:33:50 lqam3018 kernel: Sequencer Free SCB List: 14 20 21 17
16 29 18 6 31 13 22 8 4 19 3 0 28 25 2 27
26 15 11 10 12 23 7 9 24 1 30
Feb  1 15:33:51 lqam3018 kernel: Sequencer SCB Info:
Feb  1 15:33:51 lqam3018 kernel:   0 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:   1 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:   2 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:   3 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:   4 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:   5 SCB_CONTROL[0x64] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0x23]
Feb  1 15:33:51 lqam3018 kernel:   6 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:   7 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:   8 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:   9 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  10 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  11 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  12 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  13 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  14 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  15 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  16 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  17 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  18 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  19 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  20 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  21 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  22 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  23 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  24 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  25 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  26 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  27 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  28 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  29 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  30 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel:  31 SCB_CONTROL[0xe0] SCB_SCSIID[0x7]
SCB_LUN[0x0] SCB_TAG[0xff]
Feb  1 15:33:51 lqam3018 kernel: Pending list:
Feb  1 15:33:51 lqam3018 kernel:  35 SCB_CONTROL[0x60] SCB_SCSIID[0x7]
SCB_LUN[0x0]
Feb  1 15:33:51 lqam3018 kernel: Kernel Free SCB list: 4 18 6 19 14 29
7 16 21 34 15 28 23 13 25 10 0 33 11 9
17 2 22 8 1 3 26 20 12 27 5 32 31 30
Feb  1 15:33:51 lqam3018 kernel: DevQ(0:0:0): 0 waiting
Feb  1 15:33:51 lqam3018 kernel: DevQ(0:6:0): 0 waiting
Feb  1 15:33:51 lqam3018 kernel:
Feb  1 15:33:51 lqam3018 kernel: <<<<<<<<<<<<<<<<< Dump Card State
Ends >>>>>>>>>>>>>>>>>>
Feb  1 15:33:51 lqam3018 kernel: (scsi0:A:0:0): Device is
disconnected, re-queuing SCB
Feb  1 15:33:51 lqam3018 kernel: Recovery code sleeping
Feb  1 15:33:51 lqam3018 kernel: (scsi0:A:0:0): Abort Tag Message Sent
Feb  1 15:33:51 lqam3018 kernel: (scsi0:A:0:0): SCB 35 - Abort Tag Completed.
Feb  1 15:33:52 lqam3018 kernel: Recovery SCB completes
Feb  1 15:33:52 lqam3018 kernel: Recovery code awake
Feb  1 15:33:52 lqam3018 kernel: aic7xxx_abort returns 0x2002
