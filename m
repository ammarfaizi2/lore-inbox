Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261957AbREQEOD>; Thu, 17 May 2001 00:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbREQENx>; Thu, 17 May 2001 00:13:53 -0400
Received: from ch-12-44-141-183.lcisp.com ([12.44.141.183]:34826 "EHLO
	debian-home") by vger.kernel.org with ESMTP id <S261957AbREQENs>;
	Thu, 17 May 2001 00:13:48 -0400
Date: Wed, 16 May 2001 23:13:46 -0500
To: linux-kernel@vger.kernel.org
Subject: Sound ioctl's
Message-ID: <20010516231346.A21018@debian-home.lcisp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: Gordon Sadler <gbsadler1@lcisp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Please CC replies as I'm not subscribed.
I seem to be having some problems with sound ioctl's.

I've attached a short c file that opens /dev/dsp, prints the fd, tries
to issue SNDCTL_DSP_NONBLOCK ioctl, then does the same with /dev/audio.

Both calls to ioctl for NONBLOCK yield Invalid Invalid argument.
I've searched the kernel source under drivers/sound/ to see if/where
this ioctl is defined. 

grep -rl SNDCTL_DSP_NONBLOCK drivers/sound/*
drivers/sound/audio.c
drivers/sound/cmpci.c
drivers/sound/cs4281/cs4281m.c
drivers/sound/cs46xx.c
drivers/sound/emu10k1/audio.c
drivers/sound/es1370.c
drivers/sound/es1371.c
drivers/sound/esssolo1.c
drivers/sound/i810_audio.c
drivers/sound/maestro.c
drivers/sound/maestro3.c
drivers/sound/msnd_pinnacle.c
drivers/sound/sonicvibes.c
drivers/sound/trident.c
drivers/sound/vwsnd.c
drivers/sound/ymfpci.c

Now I'm using a via chipset embedded sound.
lsmod
via82cxxx_audio        16496   0 (autoclean)
soundcore               3472   2 (autoclean) [via82cxxx_audio]
ac97_codec              8352   0 (autoclean) [via82cxxx_audio]

So none of the files that use SNDCTL_DSP_NONBLOCK were compiled for my
kernel. I came up with a question and 2 possible solutions.

Question:
  Are all ioctl's valid for all devices within a major block?

Solutions:
 1.  Turn on CONFIG_SOUND_OSS so sound.o is produced, however the
 Configure.help says, "...Say Y or M here (the module will be called
 sound.o) if you haven't found a driver for your sound card above, then
 pick your driver from the list below.
       
 2.  Determine a way to tell which ioctl's a particular driver supports.

Any ideas here?

-- 
Gordon Sadler


--82I3+IH0IqGh5yIs
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="test.c"

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <stdio.h>
#include <linux/soundcard.h>



int main()
{
  int fd, fd1, ver;
  if((fd=open("/dev/dsp",O_WRONLY))<0)
	  perror("open ");
  printf (" %d is fd...\n",fd);
  if (ioctl(fd, OSS_GETVERSION, &ver)<0)
	  perror("ioctl ");
  printf (" %x is version...\n",ver);
  if (ioctl(fd, SNDCTL_DSP_NONBLOCK, NULL)<0)
	  perror("ioctl ");
  close(fd);
  
  if((fd1=open("/dev/audio",O_WRONLY))<0)
	  perror("open ");
  printf (" %d is fd1...\n",fd);
  if (ioctl(fd1, SNDCTL_DSP_NONBLOCK, NULL)<0)
	  perror("ioctl ");
  close(fd1);
  return 0;
}
  

--82I3+IH0IqGh5yIs--
