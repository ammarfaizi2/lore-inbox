Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVJOKZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVJOKZO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 06:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVJOKZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 06:25:14 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:56199 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1750703AbVJOKZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 06:25:12 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Marc Perkel <marc@perkel.com>
Subject: Re: Forcing an immediate reboot
Date: Sat, 15 Oct 2005 13:24:51 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <43505F86.1050701@perkel.com>
In-Reply-To: <43505F86.1050701@perkel.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zjNUDU8dcQbDVR3"
Message-Id: <200510151324.51597.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_zjNUDU8dcQbDVR3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 15 October 2005 04:46, Marc Perkel wrote:
> Is there any way to force an immediate reboot as if to push the reset 
> button in software? Got a remote server that i need to reboot and 
> shutdown isn't working.

See atttached
--
vda

--Boundary-00=_zjNUDU8dcQbDVR3
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="hardshutdown.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hardshutdown.c"

/* Including <unistd.h> makes sure that on a glibc system
   <features.h> is included, which again defines __GLIBC__ */

#include <unistd.h>
#include <stdio.h>	/* puts */
#include <time.h>	/* nanosleep */
#include <errno.h>

#include "linux_reboot.h" /* reboot magic */

#define USE_LIBC

#ifdef USE_LIBC

/* libc version */
#if defined __GLIBC__ && __GLIBC__ >= 2
#  include <sys/reboot.h>
#  define REBOOT(cmd) reboot(cmd)
#else
extern int reboot(int, int, int);
#  define REBOOT(cmd) reboot(LINUX_REBOOT_MAGIC1,LINUX_REBOOT_MAGIC2,(cmd))
#endif

int my_reboot(int cmd) {
	return REBOOT(cmd);
}

#else /* no USE_LIBC */

/* direct syscall version */
#include <linux/unistd.h>

#ifdef _syscall3
_syscall3(int,  reboot,  int,  magic, int, magic_too, int, cmd);
#else
/* Let us hope we have a 3-argument reboot here */
extern int reboot(int, int, int);
#endif

int my_reboot(int cmd) {
	return reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, cmd);
}

#endif


void do_reboot() {
	my_reboot(LINUX_REBOOT_CMD_RESTART);
}

void do_poweroff() {
	my_reboot(LINUX_REBOOT_CMD_POWER_OFF);
}

void do_halt() {
	my_reboot(LINUX_REBOOT_CMD_HALT);
}

void usage() {
	puts(
	    "Usage: hardshutdown -h|-r|-p [NN]\n"
	    "	NN - seconds to sleep before requested action"
	);
	exit(1);
}

enum action_t {
	SHUTDOWN,	// do nothing
	HALT,
	POWEROFF,
	REBOOT
};

int main(int argc, char *argv[]) {
	struct timespec t = {0,0};
	enum action_t action = SHUTDOWN;
	int c, i;
	char *prog, *ptr;

	//if(*argv[0] == '-') argv[0]++;	/* allow shutdown as login shell */
	prog = argv[0];
	if( (ptr=strrchr(prog,'/')) != 0 ) prog = ptr+1;

	/* All names (halt, reboot, shutdown)
	   refer to the same program with the same options,
	   only the defaults differ. */
	if(!strcmp("hardhalt", prog)) {
		action = HALT;
	} else if(!strcmp("hardpoweroff", prog)) {
		action = POWEROFF;
	} else if(!strcmp("hardreboot", prog)) {
		action = REBOOT;
	}
		
	for(c=1; c < argc; c++) {
		if(argv[c][0] >= '0' && argv[c][0] <= '9') {
			t.tv_sec = strtol(argv[c], NULL, 10);
			continue;
		}
		if(argv[c][0] != '-') {
			usage();
			return 1;
		}
		for(i=1; argv[c][i]; i++) {
			switch(argv[c][i]) {
			case 'h': 
				action = HALT;
				break;
			case 'p':
				action = POWEROFF;
				break;
			case 'r':
				action = REBOOT;
				break;
			default:
				usage();
				return 1;
			}
		}
	}

	if(action==SHUTDOWN) {
		usage();
		return 1;
	}

	chdir("/");
	while(nanosleep(&t,&t)<0)
		if(errno!=EINTR) break;

	switch(action) {
	case HALT:
		do_halt(); break;
	case POWEROFF:
		do_poweroff(); break;
	case REBOOT:
		do_reboot(); break;
	}
	return 1;
}

--Boundary-00=_zjNUDU8dcQbDVR3
Content-Type: text/x-objchdr;
  charset="iso-8859-1";
  name="linux_reboot.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux_reboot.h"

/*
 * Magic values required to use _reboot() system call.
 */

#define	LINUX_REBOOT_MAGIC1	0xfee1dead
#define	LINUX_REBOOT_MAGIC2	672274793
#define	LINUX_REBOOT_MAGIC2A	85072278
#define	LINUX_REBOOT_MAGIC2B	369367448


/*
 * Commands accepted by the _reboot() system call.
 *
 * RESTART     Restart system using default command and mode.
 * HALT        Stop OS and give system control to ROM monitor, if any.
 * CAD_ON      Ctrl-Alt-Del sequence causes RESTART command.
 * CAD_OFF     Ctrl-Alt-Del sequence sends SIGINT to init task.
 * POWER_OFF   Stop OS and remove all power from system, if possible.
 * RESTART2    Restart system using given command string.
 */

#define	LINUX_REBOOT_CMD_RESTART	0x01234567
#define	LINUX_REBOOT_CMD_HALT		0xCDEF0123
#define	LINUX_REBOOT_CMD_CAD_ON		0x89ABCDEF
#define	LINUX_REBOOT_CMD_CAD_OFF	0x00000000
#define	LINUX_REBOOT_CMD_POWER_OFF	0x4321FEDC
#define	LINUX_REBOOT_CMD_RESTART2	0xA1B2C3D4

--Boundary-00=_zjNUDU8dcQbDVR3
Content-Type: application/x-shellscript;
  name="mkdiet.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mkdiet.sh"

#!/bin/sh
diet gcc -o hardshutdown hardshutdown.c
elftrunc hardshutdown

--Boundary-00=_zjNUDU8dcQbDVR3--
