Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVETQe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVETQe6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 12:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVETQe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 12:34:58 -0400
Received: from rost.dti.supsi.ch ([193.5.152.238]:18817 "EHLO
	rost.dti.supsi.ch") by vger.kernel.org with ESMTP id S261403AbVETQek
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 12:34:40 -0400
Date: Fri, 20 May 2005 18:34:37 +0200 (CEST)
From: Marco Rogantini <marco.rogantini@supsi.ch>
X-X-Sender: rogantin@rost.dti.supsi.ch
To: "Richard B. Johnson" <linux-os@analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen regen buffer at 0x00b8000
In-Reply-To: <Pine.LNX.4.61.0505201123140.5107@chaos.analogic.com>
Message-ID: <Pine.LNX.4.62.0505201819040.16866@rost.dti.supsi.ch>
References: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com>
 <20050520141434.GZ2417@lug-owl.de> <Pine.LNX.4.62.0505201639170.14709@rost.dti.supsi.ch>
 <Pine.LNX.4.61.0505201123140.5107@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2005, Richard B. Johnson wrote:

> Why can't I consistantly write to the VGA screen regen buffer
> and have it appear on the screen????

I wrote the following little program and understood the effect you are
seeing...

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <fcntl.h>
#include <errno.h>
#include <time.h>
#include <sys/mman.h>


#define SCREEN 0x000b8000
#define ATTRIB 0x1700

int main (int argc, char **argv) {

 	int fd;
 	void *va;
 	size_t page_size = getpagesize();
 	unsigned short c = ATTRIB | '0';
 	int i;

 	fd = open("/dev/mem", O_RDWR | O_SYNC);
 	if (!fd) {
 		perror("open");
 		exit(1);
 	}

 	va = mmap(0, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,
 			fd, SCREEN);
 	if (va == (void *) -1) {
 		perror ("mmap");
 		exit(1);
 	}

 	/* first column of second line of the hardware buffer */
 	va += 160;

 	/* printing ascii '0' to '9' */
 	for (i = 0; i < 10; i++) {
 		*((unsigned short *) va) = c;
 		c += 1;
 		sleep(1);
 	}

 	return 0;
}


Do you remember that the linux console uses hardware buffers for
its scrolling capabilities (shift-pgup and shift-pgdown)?

When you hit enter to run your program the display line you are
addressing in your program has gone off by one so it is out of visual.

To see your line you must go to the begginning of the buffer in the
console (shift-pgup until at the top) since you write to the first
line in the hardware buffer.

Hope this helps

 	-marco
