Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288733AbSBDH6t>; Mon, 4 Feb 2002 02:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288736AbSBDH6k>; Mon, 4 Feb 2002 02:58:40 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28164 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288733AbSBDH6X>;
	Mon, 4 Feb 2002 02:58:23 -0500
Date: Mon, 4 Feb 2002 08:57:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Erik Andersen <andersen@codepoet.org>,
        "Calin A. Culianu" <calin@ajvar.org>, linux-kernel@vger.kernel.org
Subject: Re: Asynchronous CDROM Events in Userland
Message-ID: <20020204085712.O29553@suse.de>
In-Reply-To: <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu> <20020204070414.GA19268@codepoet.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20020204070414.GA19268@codepoet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 04 2002, Erik Andersen wrote:
> Jens Axboe and I wrote a little test app a year or two ago to check
> for whether drives supported asynchronous mode.  We found it to be
> unsupported on 100% of the drives we tested (and we tested quite a
> few)...

Yep, _no_ drives to date support queued event notification. However, a
polled approach is really not too bad -- it simply means that we'll push
it to user space instead. I've written a small utility for reference.

-- 
Jens Axboe


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cd_poll.c"

/*
 * simple media event poller for cdroms implementing the GET_EVENT
 * interface
 *
 * Copyright (C) 2001 Jens Axboe <axboe@suse.de>
 */
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/ioctl.h>

#include <linux/cdrom.h>

#define INIT_CGC(cgc)	memset((cgc), 0, sizeof(struct cdrom_generic_command))

void dump_cgc(struct cdrom_generic_command *cgc)
{
	struct request_sense *sense = cgc->sense;
	int i;

	printf("cdb: ");
	for (i = 0; i < 12; i++)
		printf("%02x ", cgc->cmd[i]);
	printf("\n");

	printf("buffer (%d): ", cgc->buflen);
	for (i = 0; i < cgc->buflen; i++)
		printf("%02x ", cgc->buffer[i]);
	printf("\n");

	if (!sense)
		return;

	printf("sense: %02x.%02x.%02x\n", sense->sense_key, sense->asc, sense->ascq);
}

int wait_cmd(int fd, struct cdrom_generic_command *cgc, void *buffer,
	     int len, int ddir, int timeout)
{
	struct request_sense sense;
	int ret;

	memset(&sense, 0, sizeof(sense));

	cgc->timeout = timeout;
	cgc->buffer = buffer;
	cgc->buflen = len;
	cgc->data_direction = ddir;
	cgc->sense = &sense;
	cgc->quiet = 1;

	ret = ioctl(fd, CDROM_SEND_PACKET, cgc);
	if (ret == -1) {
		perror("ioctl");
		dump_cgc(cgc);
	}

	return ret;
}

int get_media_event(int fd)
{
	struct cdrom_generic_command cgc;
	unsigned char buffer[8];
	int ret;

	INIT_CGC(&cgc);
	memset(buffer, 0, sizeof(buffer));

	cgc.cmd[0] = GPCMD_GET_EVENT_STATUS_NOTIFICATION;
	cgc.cmd[1] = 1;
	cgc.cmd[4] = 16;
	cgc.cmd[8] = sizeof(buffer);

	ret = wait_cmd(fd, &cgc, buffer, sizeof(buffer), CGC_DATA_READ, 600);
	if (ret < 0) {
		perror("GET_EVENT");
		return ret;
	}

	return buffer[4] & 0xf;
}

int poll_events(int fd)
{
	int event, quit, first;

	quit = 0;
	first = 1;
	do {
		event = get_media_event(fd);
		if (event < 0)
			break;

		switch (event) {
			case 0:
				if (first)
					printf("no media change\n");
				break;
			case 1:
				printf("eject request\n");
				break;
			case 2:
				printf("new media\n");
				break;
			case 3:
				printf("media removal\n");
				break;
			case 4:
				printf("media change\n");
				break;
			default:
				printf("unknown media event (%d)\n", event);
				break;
		}

		first = 0;

		if (event)
			continue;

		sleep(2);

	} while (!quit);

	return event;
}

int main(int argc, char *argv[])
{
	int fd;

	fd = open("/dev/cdrom", O_RDONLY | O_NONBLOCK);
	if (fd == -1) {
		perror("open");
		return 1;
	}

	return poll_events(fd);
}


--C7zPtVaVf+AK4Oqc--
