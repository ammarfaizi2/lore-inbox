Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262940AbUKYAfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbUKYAfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 19:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbUKYAcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 19:32:51 -0500
Received: from postman2.arcor-online.net ([151.189.20.157]:62416 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S262990AbUKYA1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 19:27:52 -0500
Message-ID: <33356.192.168.0.2.1101334593.squirrel@192.168.0.10>
Date: Wed, 24 Nov 2004 23:16:33 +0100 (CET)
Subject: Re: Re: Is controlling DVD speeds via SET_STREAMING supported?
From: "Thomas Fritzsche" <tf@noto.de>
To: linux-kernel@vger.kernel.org
Cc: david@2gen.com, axboe@suse.de
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I had the same problem with my DVD+-RW NEC-ND 3500 (NEC-support told me
that they didn't support linux :-( ). After googling I couldn't find an
answer. Because I didn't know anything about ide-cd (yesterday ;-))  I
read in this spec about the SET STREAMING command:
ftp://ftp.avc-pioneer.com/Mtfuji_4/Spec/Fuji4r10.pdf
If you also read the newer Specs (Mtfuji_5) then you'll find out that the
"SET CD SPEED" command is "only applicable to CD-R/RW logical units".
It looks like older DVD-Drives also support this command, but newer do not
support this for DVD+-R. But there is also the SET STREAMING command as
Jens Axboe described on this list. Not all devices support this feature
but my NEC-CD 3500 does (as I found out ;-) / my Teac-CD-RW does not)

I wrote a little programm to test this SET STREAMING command (quick &
dirty). In my opinion it would make sence to also enhance the kernel
function cdrom_select_speed (linux/drivers/ide/ide-cd.c), so that this
function works also for "newer" DVD-drives.
(!first check for the Realtime-Streaming-Feature and then use the right
command to set the speed). Because DVD+-RW Drives will be faster (AND
LOUDER!!) very soon it would be nice to have this in the kernel.

Thanks and regards,
 Thomas Fritzsche

PS.: I'm not subscribed to LKML please CC me If you would like to discuss
this issue.

-----------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/cdrom.h>

/*
 * speed - use SET STREAMING command to set the speed of DVD-drives
 *
 *
 * Copyright (c) 2004	Thomas Fritzsche <tf@noto.de>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */

void dump_sense(unsigned char *cdb, struct request_sense *sense)
{
  int i;

  printf("Command failed: ");

  for (i=0; i<12; i++)
    printf("%02x ", cdb[i]);

    if (sense) {
      printf(" - sense: %02x.%02x.%02x\n", sense->sense_key, sense->asc,
              sense->ascq);
    } else {
      printf(", no sense\n");
    }
}

int main(int argc, char *argv[])
{
  int fd = open("/dev/hdc", O_RDONLY | O_NONBLOCK);
  int c;
  int speed = 0;
  unsigned char buffer[28];

  struct cdrom_generic_command cgc;
  struct request_sense sense;
  extern char * optarg;

  while((c=getopt(argc,argv,"x:"))!=EOF) {
    switch(c) {
      case 'x': speed = atoi(optarg); break;
      default:
        printf("Usage: speed -x <speed>");
        exit(-1);
    }
  }

  memset(&cgc, 0, sizeof(cgc));
  memset(&sense, 0, sizeof(sense));
  memset(&buffer, 0, sizeof(buffer));

 /* SET STREAMING command */
  cgc.cmd[0] = 0xb6;
 /* 28 byte parameter list length */
  cgc.cmd[10] = 28;

  cgc.sense = &sense;
  cgc.buffer = buffer;
  cgc.buflen = sizeof(buffer);
  cgc.data_direction = CGC_DATA_WRITE;

  buffer[8] = 0xff;
  buffer[9] = 0xff;
  buffer[10] = 0xff;
  buffer[11] = 0xff;

  buffer[15] = 177*speed;
  buffer[18] = 0x03;
  buffer[19] = 0xE8;

  buffer[23] = 177*speed;
  buffer[26] = 0x03;
  buffer[27] = 0xE8;



  if (ioctl(fd, CDROM_SEND_PACKET, &cgc) == 0) {
    printf("OK\n");
    return 0;
  } else
  {
    printf("error!\n");
    dump_sense(cgc.cmd, cgc.sense);
    return -1;
  }
}


-----------------------------------------

----------------------------------------------------------
Date	Sun, 21 Nov 2004 00:50:32 +0100
From	David Härdeman <>
Subject	Re: Is controlling DVD speeds via SET_STREAMING supported?

On Sat, Nov 20, 2004 at 09:19:45PM +0100, Jens Axboe wrote:
>On Sat, Nov 20 2004, David Härdeman wrote:
>> So, my question is, is this implemented in the kernel and are there any
>> userspace tools to set the playback speed?
>
>I don't know of any, but it is trival to write using SG_IO (or just
>CDROM_SEND_PACKET for this simple use, since only a trivial amount of
>data involved). If you are not sure how to do it, let me know and I can
>easily write one in minutes.

If you could write up a quick-n-dirty tool, it would be great! Based
on that I could hopefully write a patch later for one of the common
tools (eg. hdparm or setcd).

Re¸
David

