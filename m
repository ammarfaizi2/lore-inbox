Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131616AbRBDLF7>; Sun, 4 Feb 2001 06:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131652AbRBDLFu>; Sun, 4 Feb 2001 06:05:50 -0500
Received: from ghost.btnet.cz ([62.80.85.74]:5892 "HELO ghost.btnet.cz")
	by vger.kernel.org with SMTP id <S131616AbRBDLFm>;
	Sun, 4 Feb 2001 06:05:42 -0500
Message-ID: <20010204120728.48319@ghost.btnet.cz>
Date: Sun, 4 Feb 2001 12:07:28 +0100
From: clock@ghost.btnet.cz
To: linux-kernel@vger.kernel.org
Subject: Inadmissible sound dropouts on 2.2.18
Reply-To: clock@atrey.karlin.mff.cuni.cz
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=6TrnltStXW4iwmi0
X-Mailer: Mutt 0.84
X-Echameleon: GRU Aquarium Khodinka Vatutinki KGB CIA Putin Suvorov Ladygin FBI NSA IRS whitewater arkanside MOSSAD MI5 ONI CID AK47 M16 C4 wackenhut terrorist task force 160 atomic nuclear Lybia plutonium fission uranium deuterium H-bomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii

I found that 2.2.18 probably rudely drops samples (lets ocassionally one sample
be played several times) on the Gravis Ultrasound output device. I use 2.2.18
and the native kernel drivers. I wrote this program that should produce a clean
sine tone. Instead I hear a sine interspaced with crackling. The crackling
repeats at 100Hz I guess. There runs nothing CPU-consuming. The sound process
takes 5% CPU. It's funny Linux drops sound samples just at 5% of CPU load. I
got AMD K6-2 3D 400Mhz at 400Mhz, 4*100MHz, running stably between 20-35 deg C
of case temperature. I got PCI / AGP board FIC VA-503+.  There are three serial
ports, none of them was transceiving at that time. There is one ISA NE2000 NIC
which was not sending any packets.  There is a ISA Gravis Ultrasound PnP. Two
IDE disks, one of them sleeping, the second spinning but nod reading/writing.
64MB of 100MHz DIMM SDRAM, which runs for years without problems. 1MB L2 cache.
AGP video card ATI. No X server running, no SVGAlib application running.  No
USB peripherals.

The crackling is not dependent on the buffer size you can set up in the C code.
The crackling is dependent on the frequency of the sine. It's clearly audible
(read: annoying) at 10kHz, audible at 1kHz, inaudible at 100Hz. So I think
they are sample dropouts - the card stops playing and repeats one sample until
kernel gets the breath and whips itself up to supply next audio data.

There are no custom changes in the drivers - no buffer tweaking, nothing. The
Gravis plays modules, midules and mp3 with nearly no problems (apart from when
Loreena Mc Kennith sings too high and too loud, I hear something that looks like
MP3 frames bounds, but I can't surely tell who's responsible for this - if the
Fraunhofer Institute or Linux Kernel)

root@ghost:/usr/src/linux# cat /proc/version
Linux version 2.2.18 (root@ghost) (gcc version 2.95.2.1 19991024 (release)) #14
Mon Jan 29 15:14:27 MET 2001

Clock


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=Makefile

CFLAGS=-O3 -Wall -fomit-frame-pointer
LDFLAGS=-s -lm

all: syncro beat

syncro: syncro.c

beat: beat.c

clean:
	rm -f *.o core syncro beat


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="beat.c"

#include <string.h>
#include <sys/soundcard.h>
#include <sys/ioctl.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <stdio.h>
#include <math.h>

unsigned char errmsg[256];
int r;
int dsp;
int bits=16;
int channels;
int blocksize;

float left=10000;
float right=10000;
double left_angle=0;
double right_angle=0;
unsigned char buffer[65536];

void hum(void)
{
	int a;
	int val;
	int remains;
	unsigned char *ptr;

	new_buffer:
	ptr=buffer;
	for (a=0;a<sizeof(buffer)/4;a++){
		val=32767*sin(left_angle);
		*ptr++=val&255;
		*ptr++=val>>8;
		val=32767*sin(right_angle);
		*ptr++=val&255;
		*ptr++=val>>8;
		left_angle+=2*M_PI/44100*left;
		if (left_angle>=2*M_PI) left_angle-=2*M_PI;
		right_angle+=2*M_PI/44100*right;
		if (right_angle>=2*M_PI) right_angle-=2*M_PI;
	}
	remains=sizeof(buffer);
	ptr=buffer;
	a2:
	if (!remains) goto new_buffer;
	val=write(dsp,ptr,remains);
	if (val>=0){
		remains-=val;
		ptr+=val;
		goto a2;
	}
	if (errno==EAGAIN||errno==EINTR) goto a2;
	perror("beat");
	exit(1);
}

/*-------------------------------MAIN---------------------------------------*/
int main(int argc, char **argv)
{
	int a;

again:
dsp=open("/dev/dsp",O_WRONLY);
if (dsp<0){
	if (errno==EINTR||errno==EAGAIN) goto again;
}

if (r){
	fprintf(stderr,"Can't open sound device.\n");
	exit(1);
}

r=ioctl(dsp,SNDCTL_DSP_RESET,NULL);
if (r){
	fprintf(stderr,"Can't reset sound device.\n");
	exit(1);
}

a=44100;
r=ioctl(dsp,SNDCTL_DSP_SPEED,&a);
if (r){
	fprintf(stderr,"Can't set 44100.\n");
	exit(1);
}

a=1;
r=ioctl(dsp,SNDCTL_DSP_STEREO,&a);
if (r){
	fprintf(stderr,"Can't set stereo.\n");
	exit(1);
}

a=16;
r=ioctl(dsp,SOUND_PCM_WRITE_BITS,&a);
if (r){
	fprintf(stderr,"Can't set 16bit.\n");
	exit(1);
}

r=ioctl(dsp,SNDCTL_DSP_GETBLKSIZE,&blocksize);
if (r){
	fprintf(stderr,"Can't get blocksize.\n");
	exit(1);
}

r=ioctl(dsp,SNDCTL_DSP_SYNC,NULL);
if (r){
	fprintf(stderr,"Can't sync device.\n");
	exit(1);
}

hum();

return 0;
	
	printf("Error setting up driver\n");
	return 1;
}

--6TrnltStXW4iwmi0--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
