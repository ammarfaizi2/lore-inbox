Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSJYJqv>; Fri, 25 Oct 2002 05:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261345AbSJYJqv>; Fri, 25 Oct 2002 05:46:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24771 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261344AbSJYJqn>;
	Fri, 25 Oct 2002 05:46:43 -0400
Date: Fri, 25 Oct 2002 11:52:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org
Subject: Re: VM BUG, set_page_dirty() buggy?
Message-ID: <20021025095245.GL4153@suse.de>
References: <20021025094715.GF12628@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <20021025094715.GF12628@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 25 2002, Jens Axboe wrote:
> I've attached oread in its simplicity. System being tested here is a
> dual P3-800MHz, not using preempt (never do). It doesn't matter if the
> input is on /dev/sda or ide disk, scsi cdrom, or atapi cdrom. It behaves
> the same way, data is lost.

Well here it is...

-- 
Jens Axboe


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oread.c"

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>

#ifndef O_DIRECT
#define O_DIRECT	040000
#endif

#define READ_SIZE	(65536)
#define ALIGN(buf)	(char *) (((unsigned long) (buf) + 4095) & ~(4095))

int main(int argc, char *argv[])
{
	char *buffer, *ptr;
	int fd_in, fd_out, ret;

	if (argc < 3) {
		printf("%s: <infile> <outfile>\n", argv[0]);
		return 1;
	}

	printf("%s: infile: %s -> outfile %s\n", argv[0],argv[1],argv[2]);

	fd_in = open(argv[1], O_RDONLY | O_DIRECT);
	if (fd_in == -1) {
		perror("open infile");
		return 2;
	}

	fd_out = open(argv[2], O_WRONLY | O_CREAT | O_TRUNC, 0644);
	if (fd_out == -1) {
		perror("open outfile");
		return 3;
	}

	ptr = malloc(READ_SIZE + 4095);
	buffer = ALIGN(ptr);

	do {
		ret = read(fd_in, buffer, READ_SIZE);
		if (!ret)
			break;
		else if (ret < 0) {
			perror("read infile");
			break;
		}
		write(fd_out, buffer, ret);
	} while (1);

	free(ptr);
	close(fd_in); close(fd_out);
	return 0;
}

--8w3uRX/HFJGApMzv--
