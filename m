Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268119AbTBMW2R>; Thu, 13 Feb 2003 17:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268120AbTBMW2R>; Thu, 13 Feb 2003 17:28:17 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:15516 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S268119AbTBMW2P>;
	Thu, 13 Feb 2003 17:28:15 -0500
Date: Thu, 13 Feb 2003 14:29:58 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.60 and current bk oops in file_ra_state_init
Message-ID: <20030213142958.A16286@beaverton.ibm.com>
References: <20030213120445.A15070@beaverton.ibm.com> <20030213131344.086e154e.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030213131344.086e154e.akpm@digeo.com>; from akpm@digeo.com on Thu, Feb 13, 2003 at 01:13:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 01:13:44PM -0800, Andrew Morton wrote:
> Was this test frequently opening and closing device nodes, or does it just
> open them once and hold them?

Opens once only.

> Can you please prepare a testcase which I can use to reproduce this?

I have only been able to reproduce it on the qla2300 running the latest
qla2300 driver. So maybe it is a qla only problem (blah).

As per previous oops reports by wli and Martin, running with the qlogicisp
driver on the isp1020 gives an oops in isp1020_intr_handler :( 

I'm rebooting again.

I was running this program, simultaneously one per drive up to 25, so I
should have only one IO outstanding per disk (added the O_DIRECT):

#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>

int
main (int argc, char **argv)
{
	int	fd;
	int	loop_cnt;
	char	*dev_name;
	int	block_size = 512;
	char	buff[4096], *bufp;
	int	res;


	dev_name = argv[1];
	loop_cnt = atoi(argv[2]);
	fprintf(stderr, "Re-reading device %s with %d iterations\n",
		dev_name, loop_cnt);
	fd = open (dev_name, O_RDONLY | O_DIRECT);
	if (fd == -1) {
		perror("open");
		exit(1);
	}

	/* memset(buff, 'x', block_size); */
	bufp = (char*) ((int)(buff + 4096) & 0xfffff000);
	fprintf(stderr, "bufp is 0x%x; buff is 0x%x\n", bufp, buff);
	while (loop_cnt-- > 0) {
#ifdef NOTNOW
#endif
		res = read(fd, bufp, block_size);
		if (res != block_size) {
			fprintf(stderr, "Read only %d bytes of %d, cnt %d\n",
				res, block_size, loop_cnt);
			exit(1);
		}
		res = lseek(fd, 0, SEEK_SET);
		if (res == -1) {
			perror("lseek");
			exit(1);
		}
	}

	close(fd);
}

-- Patrick Mansfield
