Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272335AbTGYVeh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272337AbTGYVeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 17:34:37 -0400
Received: from dup-200-42-139-10.prima.net.ar ([200.42.139.10]:7552 "EHLO hal")
	by vger.kernel.org with ESMTP id S272335AbTGYVec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 17:34:32 -0400
Subject: Sound recording problems
From: Pablo Baena <pbaena@uol.com.ar>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-dVm8NL2SFIcS9xu8SKBU"
Message-Id: <1059158899.1116.29.camel@hal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 25 Jul 2003 18:48:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dVm8NL2SFIcS9xu8SKBU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi! I tried the linux-sound list without luck, so I try this list. I'm
having recording troubles with my computer. I say my computer, because
I've already tried 3 different sound cards, and 2 kernels, with strange
results.

I'll focus on my actual configuration, so I can debug the problem. I
have a SB16 Awe ISA, and I tried the OSS drivers with 2.6.0-test1.
I have a VIAC686 motherboard, with a K7 650Mhz processor.

The sample program I attach, do record the sound. Please notice the
commented snip that doesn't work, it is stopping a lot of programs from
working.

Also, if I try doing a 

cat /dev/dsp > bla.raw

the result file is full of 7F's (doesn't hear anything).
This is just a sample of the problems I have with lots of other
recording programs.

Can you help me debug this? What should I do? What information should I
reunite?

Please reply to my own address, since I'm not subscribed to the list.

TIA!!
-- 
Whip it, baby. Whip it right. Whip it, baby. Whip it all night!

--=-dVm8NL2SFIcS9xu8SKBU
Content-Disposition: attachment; filename=nrec.c
Content-Type: text/x-c; name=nrec.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

// Stolen from nuvrec: http://mars.tuwien.ac.at/~roman/nuppelvideo/
#include <sys/soundcard.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <signal.h>

int ostr=0;
long audio_buffer_size=0;

static void sighandler(int i)
{
  if (ostr) {
    close(ostr);
  }
  printf ("\n");
  exit(0);
}

int main (int argc, char** argv) {
	int afmt, afd, frag, channels, rate, blocksize, trigger, lastread;
	char audiodevice[] = "/dev/dsp";
	unsigned char* buffer;

	ostr=open(argv[1],O_WRONLY|O_CREAT, 0644);

	if (ostr==-1) return(-1);

	if (-1 == (afd = open(audiodevice, O_RDONLY))) {
		fprintf(stderr, "\n%s\n", "Cannot open DSP, exiting");
		exit(1);
	}

	signal(SIGINT, sighandler); // install sighaendler
                                                                               
	ioctl(afd, SNDCTL_DSP_RESET, 0);
                                                                               
	frag=(8<<16)|(10);//8 buffers, 1024 bytes each
	ioctl(afd, SNDCTL_DSP_SETFRAGMENT, &frag);

	afmt = AFMT_S16_LE;
	ioctl(afd, SNDCTL_DSP_SETFMT, &afmt);
	if (afmt != AFMT_S16_LE) {
		fprintf(stderr, "\n%s\n", "Can't get 16 bit DSP, exiting");
		exit;
	}

	channels = 2;
	ioctl(afd, SNDCTL_DSP_CHANNELS, &channels);
                                                                                
	// sample rate 
	rate = 44100;
	ioctl(afd, SNDCTL_DSP_SPEED,    &rate);

	if (-1 == ioctl(afd, SNDCTL_DSP_GETBLKSIZE,  &blocksize)) {
		fprintf(stderr, "\n%s\n", "Can't get DSP blocksize, exiting");
		exit;
	}

	blocksize*=4;  // allways read 4*blocksize
	audio_buffer_size = blocksize;

// This doesn't work!! Throws: Resource temporarily unavailable!
// when reading.
	// trigger record 
	trigger = ~PCM_ENABLE_INPUT;
	ioctl(afd,SNDCTL_DSP_SETTRIGGER,&trigger);
                                                                               
	trigger = PCM_ENABLE_INPUT;
	ioctl(afd,SNDCTL_DSP_SETTRIGGER,&trigger);
//

	buffer = (char *)malloc(audio_buffer_size);

	while(1) {
		if (audio_buffer_size != (lastread = read(afd,buffer,audio_buffer_size))) 
		{
			fprintf(stderr, "only read %d from %ld bytes from '%s'\n", lastread, audio_buffer_size,
				audiodevice);
			perror("read /dev*audiodevice");
			if (lastread == -1)
				exit (1);
		}
		else {
			fprintf(stderr, ".");
			write(ostr, buffer, audio_buffer_size);
		}
	}
}                                                                                

--=-dVm8NL2SFIcS9xu8SKBU--

