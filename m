Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752015AbWFLO5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbWFLO5y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 10:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbWFLO5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 10:57:54 -0400
Received: from twin.jikos.cz ([213.151.79.26]:17321 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1752015AbWFLO5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 10:57:53 -0400
Date: Mon, 12 Jun 2006 16:57:50 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: TCSBRK(1) on pl2303 USB/serial returns prematurely
Message-ID: <20060612145750.GA19338@kestrel.barix.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
X-Stance: Goofy
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

TCSBRK(1) ioctl system call on pl2303 USB/serial converter on 2.6.16.19
returns prematurely. Additional 53ms delay is necessary to work this
around at speed of 57600. TCSBRK(1) is translation of the tcdrain()
function by glibc. With ordinary serial port the TCSBRK(1) seems to work
correctly.

The following program produces with pl2303 USB/serial converter
incorrect output as can be seen on video
ftp://atrey.karlin.mff.cuni.cz/pub/local/clock/out/wave.ogg

The output should be a block of characters 0xf0 at 57600 speed. The
actual output is a block of characters 0xf0 at 57600 followed by a block
of characters 0xf0 at 115200.

If the tcdrain is removed completely, then the wait time to work it
around is over 200ms. That means that TCSBRK(1) waits some time, but not
all the time.

The behaviour of tcdrain() calling TCSBRK(1) in this situation violates
POSIX.

See also pictures of the USB/serial dongle at
ftp://atrey.karlin.mff.cuni.cz/pub/local/clock/out/ (all the JPG files).

CL<

stest.c:
--------

/*
 *  Copyright (C) 2006 Barix AG Switzerland http://www.barix.com
 *
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or (at
 *  your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful, but
 *  WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
 *
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 */

#include <termios.h>
#include <unistd.h>
#include <sys/select.h>
#define _XOPEN_SOURCE 500
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <sys/time.h>
#include <time.h>

#include "main.h"

/* The informative messages (messages that are not associate with program
 * abort) are sent to stdout. Error messages (when the program aborts)
 * are sent to stderr. */

int port_handle; /* Serial port port_handle */
const unsigned char *fname;
speed_t speed=B57600;

int bootloader_handle=-1;
unsigned char bootloader_is_binary; /* Means that it is not in the sdb format.
                                     */
int config_handle=-1;
unsigned char * dlraw_filename=NULL;
unsigned long wait_us;

unsigned char erase_ee, erase_pf;
int new_device;
int erase_bootarea; /* If this is set, prior to flashing the data file,
			 the bootloader area (0xff0000 eith length of 0x10000)
			 is erased using the erase_pf command. */
unsigned char *datafiles; /* A data block with concatenated strings, in the
			     same order as they were on the command line. */
unsigned datafiles_size;

void my_tcgetattr(int port_handle, struct termios *t)
{
	if (tcgetattr(port_handle, t)<0){
		fprintf(stderr, PROGNAME": cannot get attributes of %s: ",
				fname);
		perror("");
		exit(-1);
	}
}

void my_usleep(unsigned long usec)
{
	struct timespec ts;

	ts.tv_sec=usec/1000000;
	ts.tv_nsec=1000*(usec%1000000);

resume:
	if (nanosleep(&ts, &ts)<0){
		if (errno==EINTR) goto resume;
		PERR("nanosleep failed");
	}
}

void my_tcsetattr(int port_handle, const struct termios *t)
{
	/* We are putting the tcdrain before the tcsetattr to make it
         * work even on platforms that don't support TCSADRAIN. */ 
retry_tcdrain:
	if (tcdrain(port_handle)<0){
		if (errno==EINTR||errno==EAGAIN) goto retry_tcdrain;

		fprintf(stderr, PROGNAME": cannot drain %s: ",
				fname);
		perror("");
		exit(-1);
	}

	/* If a printf is put here, it works, if not, it doesn't work.
         * My hypothesis is that tcdrain() on Cygwin waits only
         * for the software buffer(s) in the Windows system and not for the
         * hardware buffer in the 16550A chip, which has typically 16 bytes
         * (Winbond W83877). Transmission of 16 bytes (each 8 bits + 1 stop bit
         * + 1 start bit) at 57600 Baud takes 2778 usec. Let's use 12ms delay
         * to support up to 64-byte buffer even with some small reserve.
	 */
	my_usleep(wait_us); 

retry_tcsetattr:
	if (tcsetattr(port_handle, TCSADRAIN, t)<0){
		if (errno==EINTR||errno==EAGAIN) goto retry_tcsetattr;
		fprintf(stderr, PROGNAME": cannot set attributes on %s: ",
				fname);
		perror("");
		exit(-1);
	}
}

/* Sets the terminal speed to the global variable speed. */
void my_cfsetspeed(struct termios *t)
{
	if (cfsetispeed(t, speed)<0){
		PERR("cannot set input speed");
	}
	if (cfsetospeed(t, speed)<0){
		PERR("cannot set output speed");
	}
}

/* Sets the serial speed to the global variable speed. */
void set_speed(void)
{
	struct termios t;
	my_tcgetattr(port_handle, &t);
	my_cfsetspeed(&t);
	my_tcsetattr(port_handle, &t);
}

int my_open(const unsigned char *path, int flags)
{
	int fd;

again:
	fd=open(path, flags, S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH);
	if (fd<0){
		if (errno==EINTR||errno==EAGAIN) goto again;
		fprintf(stderr, PROGNAMEE "Cannot open file %s: ",
				path);
		perror("");
		exit(-1);
	}
	return fd;
}

void my_close(int fd)
{
retry:
	if (close(fd)<0){
		if (errno==EINTR) goto retry;
		PERR("Cannot close a file");
	}
}

/* Opens the serial port and sets all parameters necessary, including
 * the speed. */
void open_serial(void)
{
	struct termios t;

	port_handle=my_open(fname,O_RDWR|O_NONBLOCK|O_SYNC);
	memset(&t, 0, sizeof(t));
	t.c_iflag|=IGNBRK|IGNPAR;
	t.c_cflag|=CS8|CREAD|CLOCAL;
	t.c_lflag|=NOFLSH;
	my_cfsetspeed(&t); /* Set the speed to the global variable speed. */
	my_tcsetattr(port_handle, &t);
}

/* Waits until it's possible to write into that file descriptor */
void wait_for_write_available(int fd)
{
	int rv;
	fd_set writefds;

retry:
	FD_ZERO(&writefds);
	FD_SET(fd, &writefds);
	rv=select(fd+1, NULL, &writefds, NULL, NULL);
	if (rv<0){
		if (errno==EINTR) goto retry;
		PERR("Cannot wait for write using select");

	}
}

/* Never returns with a failure. Never writes a short block. */
void my_write(int fd, const unsigned char *buf, size_t len, unsigned char *fname)
{
	ssize_t rv;

	while(len){
		rv=write(fd, buf, len);
		if (rv<0){
      if (errno==EAGAIN){
        wait_for_write_available(fd);
        continue;
      }
			if (errno==EINTR) continue;
			fprintf(stderr,PROGNAME ": cannot write into %s: ",
					fname);
			perror("");
			exit(-1);
		}
		buf+=rv;
		len-=rv;
	}
}

/* If there are no data available, 0 is returned. Never returns a negative
 * value. */
ssize_t my_read_vulnerable(int fd, unsigned char *buf, size_t len, const
    unsigned char *filename)
{
	ssize_t rv;

again:
	rv=read(fd, buf, len);
	if (rv<0)
		switch(errno){
			case EINTR:
				goto again;
			case EAGAIN:
				return 0;
			default:
				fprintf(stderr,PROGNAME": cannot read from %s:",
						filename);
				perror("");
				exit(-1);
		}
	return rv;
}

/* Like my_read_vulnerable, but makes sure that a coming signal doesn't cause
 * partially read buffer. May return 0. Short count returned always indicates
 * end of file.
 */
ssize_t my_read(int fd, unsigned char *buf, size_t len, const unsigned char
		*filename)
{
	ssize_t total=0;
	ssize_t rv;

while(len){
	rv=my_read_vulnerable(fd, buf, len, filename);
	if (!rv) return total;
	total+=rv;
	buf+=rv;
	len-=rv;
	}
	return total;
}

unsigned char bootloader_buf[4096]; /* Common for both send_bootloader_sdb
                                       and send_bootloader_raw functions. Can
                                       be an arbitrary length */

void send_pattern(unsigned char pattern)
{
  int a;

  memset(bootloader_buf, pattern, sizeof(bootloader_buf));
  for (a=0;a<5;a++){
    my_write(port_handle, bootloader_buf, sizeof(bootloader_buf),
        "serial port");
  }
}

int main (int argc, char **argv)
{
  if (argc<3){
    fprintf(stderr,"Must have 2 arguments.\n");
    exit(-1);
  }
  fname=argv[1];
  wait_us=atol(argv[2]);
  open_serial();
  send_pattern(0xf0);
  speed=B115200;
  set_speed();
  //send_pattern(0x55);
  return (0);
}


main.h:
--------

#ifndef __MAIN_H_
#define __MAIN_H_

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

#define PROGNAME "load"

#define PROGNAMEE PROGNAME ": "
#define PERR(e) {fprintf(stderr,PROGNAME ": " e ": "); perror(""); exit(-1); }
#define ERR(e) {fprintf(stderr,PROGNAME ": " e "\n"); exit(-1); }
#define MAX(x,y) ((x)>(y)?(x):(y))
#define MIN(x,y) ((x)<(y)?(x):(y))

extern int port_handle;

extern void my_write(int port_handle, const unsigned char *buf, size_t len,
		unsigned char *filename);
extern ssize_t my_read(int fd, unsigned char *buf, size_t len, const
    unsigned char *filename);
extern void *mem_alloc(size_t size);
extern int check_reply(const unsigned char *template, unsigned len);
extern ssize_t my_must_read(int fd, unsigned char * buf, size_t size,
		unsigned char *context);

#endif /* __MAIN_H_ */
