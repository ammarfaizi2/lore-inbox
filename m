Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbTESQ5U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 12:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTESQ5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 12:57:20 -0400
Received: from client80-83-46-147.abo.net2000.ch ([80.83.46.147]:25306 "EHLO
	shakotay.alphanet.ch") by vger.kernel.org with ESMTP
	id S261437AbTESQ5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 12:57:14 -0400
Date: Mon, 19 May 2003 19:02:54 +0200
To: linux-kernel@vger.kernel.org
Subject: Support of Digital Dream Epsilon 1.3
Message-ID: <20030519170254.GA1731@defian.alphanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: schaefer@alphanet.ch (Marc SCHAEFER)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had problems locating success stories about this numeric photo camera,
the Digital Dream Epsilon 1.3 camera.

and I have some skills in writing user-space SCSI drivers.

The problem: access the data within the camera, through USB.
Unfortunately, it looks the usb-storage module fails to detect it
properly. It's probably the MODE SENSE command which fails.

Thus I implemented, using the SCSI_IOCTL_SEND_COMMAND a very simple raw
reader which just transfers the data. It only uses 0x28 (READ 10 bytes)
since the 0x08 is not implemented. You could probably reverse this as
required to also write to the engine, if required (0x2A).

Some day maybe someone can add fixes to the SCSI sd layer for this
special device (no MODE SENSE, no 6-bytes READ), but meanwhile this
quick user-space hack is probably enough for many people.

Tested on Debian GNU/Linux 3.0r1, with compiled 2.4.20 + debian-5
patch on an Acer TravelMate 722TX laptop.

/* NOTES
 *    - gcc -g -Wall commands.c -o cmd
 *    - OFFSET=0
 *      while ! mount a -o loop,offset=$OFFSET /mnt
 *      do
 *         OFFSET=$(($OFFSET + 512))
 *      done
 *      echo $OFFSET # 29184 here.
 *    - Disable USB debugging.
 * BUGS
 * TODO
 */
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <ctype.h>

/* We use the IOCTL SEND_COMMAND() interface instead of the sg interface */
#include <scsi/scsi.h>
#include <scsi/scsi_ioctl.h>

/* BUGS */
typedef struct sdata {
    unsigned int inlen;     /* Length of data written to device */
    unsigned int outlen;    /* Length of data read from device */
    unsigned char cmd[2048];   /* SCSI command (6 <= x <= 16) */
                            /* Data read from device starts here (repl. cmd) */
                            /* On error, sense buffer starts here */
                            /* Data written to device starts here */
                            /* Size minimum OMAX_SB_LEN for sense */
} scsi_cmd_t;

#include <linux/hdreg.h>
#include <linux/fs.h>

typedef int fd_t;

static void dump_data(unsigned char *buffer, unsigned int len);
static void dump_raw_data(unsigned char *buffer, unsigned int len);

int main(int argc, char **argv) {
#if 1
   fd_t sd = open("/dev/sda", O_RDWR);
#define DEV_BLOCK_SIZE 512 /* not always! should ask the device! */
#else
   fd_t sd = open("/dev/scd0", O_RDONLY);
#define DEV_BLOCK_SIZE 2048 /* not always! should ask the device! */
#endif
   if (sd != -1) {
      struct hd_geometry hdg;
      long size;
      scsi_cmd_t scsi_cmd;
      unsigned long int lba = 0;

      if (ioctl(sd, HDIO_GETGEO, &hdg)) {
         perror("ioctl() 1");
      }
      else {
         fprintf(stderr,
                 "Geometry:\n   %d %d %d %d\n",
		 (unsigned int) hdg.heads,
		 (unsigned int) hdg.sectors,
		 (unsigned int) hdg.cylinders,
		 (unsigned int) hdg.start);
      }

      if (ioctl(sd, BLKGETSIZE, &size)) {
         perror("ioctl() 2");
      }
      else {
         fprintf(stderr, "Size: %ld\n", size);
      }

      scsi_cmd.inlen = 0;
      scsi_cmd.outlen = 40;
      scsi_cmd.cmd[0] = 0x12; /* INQUIRY */
      scsi_cmd.cmd[1] = 0;
      scsi_cmd.cmd[2] = 0;
      scsi_cmd.cmd[3] = 0;
      scsi_cmd.cmd[4] = 40;
      scsi_cmd.cmd[5] = 0;

      if (ioctl(sd, SCSI_IOCTL_SEND_COMMAND, &scsi_cmd)) {
         perror("ioctl() 2");
      }
      else {
         dump_data(&scsi_cmd.cmd[0], scsi_cmd.outlen);
      }

      for (lba = 0; lba < size; lba++) {
	 scsi_cmd.inlen = 0;
	 scsi_cmd.outlen = DEV_BLOCK_SIZE;
	 scsi_cmd.cmd[0] = 0x28; /* READ, 10 bytes */
	 scsi_cmd.cmd[1] = 0;
	 scsi_cmd.cmd[2] = (lba >> 24) & 0xFF;
	 scsi_cmd.cmd[3] = (lba >> 16) & 0xFF;
	 scsi_cmd.cmd[4] = (lba >> 8) & 0xFF;
	 scsi_cmd.cmd[5] = lba & 0xFF;
	 scsi_cmd.cmd[6] = 0;
	 scsi_cmd.cmd[7] = 0;
	 scsi_cmd.cmd[8] = 1; /* 1 block == DEV_BLOCK_SIZE bytes */
	 scsi_cmd.cmd[9] = 0;

	 if (ioctl(sd, SCSI_IOCTL_SEND_COMMAND, &scsi_cmd)) {
	    perror("ioctl() 2");
	 }
	 else {
	    dump_raw_data(&scsi_cmd.cmd[0], scsi_cmd.outlen);
	 }
      }

      if (close(sd)) {
         perror("close()");
         return 1;
      }
      return 0;
   }
   else {
      perror("open()");
      return 1;
   }
}

static void dump_data(unsigned char *buffer, unsigned int len) {
   unsigned int i = 0;

   while (i < len) {
      fprintf(stderr, "0x%2.2x ", buffer[i]);

      i++;

      if ((i % 16) == 0) {
         fprintf(stderr, "\n");
      }
   }

   fprintf(stderr, "\n");

   i = 0;

   while (i < len) {
      if (isascii(buffer[i])) {
         fprintf(stderr, "%c", buffer[i]);
      }

      i++;

      if ((i % 40) == 0) {
         fprintf(stderr, "\n");
      }
   }
}

static void dump_raw_data(unsigned char *buffer, unsigned int len) {
   fwrite(buffer, len, 1, stdout);
}

