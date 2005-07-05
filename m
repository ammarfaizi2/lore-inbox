Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVGEOe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVGEOe4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 10:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVGEOdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 10:33:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13751 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261873AbVGEOUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 10:20:12 -0400
Date: Tue, 5 Jul 2005 16:21:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: =?iso-8859-1?Q?Andr=E9?= Tomt <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
Message-ID: <20050705142122.GY1444@suse.de>
References: <42C9C56D.7040701@tomt.net> <42CA5A84.1060005@rainbow-software.org> <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org> <20050705104208.GA20620@suse.de> <42CA7EA9.1010409@rainbow-software.org> <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <42CAAC7D.2050604@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 05 2005, Ondrej Zary wrote:
> Jens Axboe wrote:
> >On Tue, 2005-07-05 at 15:02 +0200, Ondrej Zary wrote:
> >
> >>>Ok, looks alright for both. Your machine is quite slow, perhaps that is
> >>>showing the slower performance. Can you try and make HZ 100 in 2.6 and
> >>>test again? 2.6.13-recent has it as a config option, otherwise edit
> >>>include/asm/param.h appropriately.
> >>>
> >>
> >>I forgot to write that my 2.6.12 kernel is already compiled with HZ 100 
> >>(it makes the system more responsive).
> >>I've just tried 2.6.8.1 with HZ 1000 and there is no difference in HDD 
> >>performance comparing to 2.6.12.
> >
> >
> >OK, interesting. You could try and boot with profile=2 and do
> >
> ># readprofile -r
> ># dd if=/dev/hda of=/dev/null bs=128k 
> ># readprofile > prof_output
> >
> >for each kernel and post it here, so we can see if anything sticks out.
> >
> Here are the profiles (used dd with count=4096) from 2.4.26 and 2.6.12 
> (nothing from 2.6.8.1 because I don't have the .map file anymore).

Looks interesting, 2.6 spends oodles of times copying to user space.
Lets check if raw reads perform ok, please try and time this app in 2.4
and 2.6 as well.

# gcc -Wall -O2 -o oread oread.c
# time ./oread /dev/hda

-- 
Jens Axboe


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oread.c"

#include <stdio.h>
#include <unistd.h>
#define __USE_GNU
#include <fcntl.h>
#include <stdlib.h>

#define BS		(131072)
#define BLOCKS		(4096)
#define ALIGN(buf)	(char *) (((unsigned long) (buf) + 4095) & ~(4095))

int main(int argc, char *argv[])
{
	char *buffer;
	int fd, i;

	if (argc < 2) {
		printf("%s: <device>\n", argv[0]);
		return 1;
	}

	fd = open(argv[1], O_RDONLY | O_DIRECT);
	if (fd == -1) {
		perror("open");
		return 2;
	}

	buffer = ALIGN(malloc(BS + 4095));

	for (i = 0; i < BLOCKS; i++) {
		int ret = read(fd, buffer, BS);

		if (!ret)
			break;
		else if (ret < 0) {
			perror("read infile");
			break;
		}
	}

	return 0;
}

--5vNYLRcllDrimb99--
