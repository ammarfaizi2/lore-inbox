Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbUK0Lzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUK0Lzv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 06:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbUK0Lzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 06:55:51 -0500
Received: from postman1.arcor-online.net ([151.189.20.156]:8430 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261193AbUK0LzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 06:55:21 -0500
Message-ID: <32942.192.168.0.2.1101549298.squirrel@192.168.0.10>
In-Reply-To: <33133.192.168.0.2.1101499190.squirrel@192.168.0.10>
References: <33133.192.168.0.2.1101499190.squirrel@192.168.0.10>
Date: Sat, 27 Nov 2004 10:54:58 +0100 (CET)
Subject: Re: Re: Is controlling DVD speeds via SET_STREAMING supported?
From: "Thomas Fritzsche" <tf@noto.de>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

I build a new version that addresse this issues.

Usage: speed -x <speed> <device>
(speed = 0 means reset to defaults)

Cheers,
 Thomas Fritzsche

http://noto.de/vdr/speed-1.0.c
-------------------------------------------------------
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

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/cdrom.h>


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
  char *device = "/dev/cdrom";
  int c,fd;
  int speed = 0;
  unsigned long rw_size;

  unsigned char buffer[28];

  struct cdrom_generic_command cgc;
  struct request_sense sense;
  extern char * optarg;

  while((c=getopt(argc,argv,"x:"))!=EOF) {
    switch(c) {
      case 'x': speed = atoi(optarg); break;
      default:
        printf("Usage: speed [-x speed] [device]");
        return -1;
    }
  }

  if (argc > optind) device = argv[optind];

  fd = open(device, O_RDONLY | O_NONBLOCK);
  if (fd < 0) {
    printf("Can't open device %s\n", device);
    return -1;
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
  cgc.quiet = 1;

  if(speed == 0) {
/* set Restore Drive Defaults */
    buffer[0] = 4;
  }

  buffer[8] = 0xff;
  buffer[9] = 0xff;
  buffer[10] = 0xff;
  buffer[11] = 0xff;

  rw_size = 177 * speed;

/* read size */
  buffer[12] = (rw_size >> 24) & 0xff;
  buffer[13] = (rw_size >> 16) & 0xff;
  buffer[14] = (rw_size >>  8) & 0xff;
  buffer[15] = rw_size & 0xff;

/* read time 1 sec. */
  buffer[18] = 0x03;
  buffer[19] = 0xE8;

/* write size */
  buffer[20] = (rw_size >> 24) & 0xff;
  buffer[21] = (rw_size >> 16) & 0xff;
  buffer[22] = (rw_size >>  8) & 0xff;
  buffer[23] = rw_size & 0xff;

/* write time 1 sec. */
  buffer[26] = 0x03;
  buffer[27] = 0xE8;

  if (ioctl(fd, CDROM_SEND_PACKET, &cgc) != 0)
    if (ioctl(fd, CDROM_SELECT_SPEED, speed) != 0) {
      dump_sense(cgc.cmd, cgc.sense);
      printf("ERROR.\n");
      return -1;
    }
  printf("OK...\n");
  return 0;
}
-------------------------------------------------------

> Hi Jens,
>
> absolute correct! I just tested it with speed = 1 yesterday night
> (quick&duty). This is just a code snap to show that it's possible to set
> the speed of a DVD drive this way.
>
> You also wrote about the "End LBA" field in your other mail.
> I set this to 0xffffffff but you think that this could be a problem if the
> device don't have this LBA. The spec only writes this:
> "The End LBA field is the last logical block for which the performance
> request is being made." So it should be standard conform if we set here a
> higher block number. Do you have experience with other (than NEC ND-3500)
> drive that don't support this?
>
> Using this high last block number would make sence, because it looks like
> this setting is still valid if the media is changed (other end block!?).
>
> Spec:
> "The performance setting is persistent and remains until a new descriptor
> is sent. The setting only applies to the extent
> identified by the Start and End LBA field. Only zero or one performance
> extents shall be valid at any time."
>
> What do you think?
>
> I also found out, that the Realtime-Streaming Feature is mandatory for all
> kinds of DVD-+R+-RW-RAM drives. So it might be sufficient to simply use
> SET STREAMING for DVD drives and SET SPEED for CD-R's. Isn't it?
>
> I will also enhance this tool by setting the RDD flag if the user selects
> speed = 0.
>
> Thanks and kind regards,
>  Thomas Fritzsche
>
>> I should have read this more closely... You need to fill the speed
> fields correctly:
>>
>> 	unsigned long read_size = 177 * speed;
>>
>> 	buffer[12] = (read_size >> 24) & 0xff;
>> 	buffer[13] = (read_size >> 16) & 0xff;
>> 	buffer[14] = (read_size >>  8) & 0xff;
>> 	buffer[15] = read_size & 0xff;
>>
>> Ditto for write size.
>>
>> --
>> Jens Axboe
>>
>>
>
>
>
>


