Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267096AbUBMQT0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267097AbUBMQTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:19:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25478 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267096AbUBMQSh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:18:37 -0500
Date: Fri, 13 Feb 2004 16:18:34 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Giuliano Pochini <pochini@shiny.it>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       linux kernel <linux-kernel@vger.kernel.org>,
       Michael Frank <mhf@linuxmail.org>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
Message-ID: <20040213161834.GC8858@parcelfarce.linux.theplanet.co.uk>
References: <20040213124232.B2871@pclin040.win.tue.nl> <XFMail.20040213145513.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20040213145513.pochini@shiny.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 02:55:13PM +0100, Giuliano Pochini wrote:
> I propose to change "hard limit" to "soft limit" to avoid things like this:
> 
>                                 rc=idefloppy_begin_format(drive, inode,
>                                                               file,
>                                                               (int *)arg);

To avoid such things, we'd better
	a) note that idefloppy_begin_format() ignores its second and third
arguments and thus shouldn't have them at all (done in 2.6)
	b) note that we are within
			if (...) {
				...
				return -EBUSY;
			} else {
				...
				our call
				...
			}
and thus can trim one indent level. (done in 2.6)
	c) note that we are within
		{
			idefloppy_floppy_t *floppy = drive->driver_data;
			...
			our call
			...
		}
and compound operator is needed only to because of that declaration.  At
the same time, we already have
	idefloppy_floppy_t *floppy = drive->driver_data;
in the beginning of function and neither drive nor drive->driver_data can
change between those declarations.  IOW, declaration in the compound
statement can be dropped and statement itself - opened.  (done in 2.6)
	d) note that it's static, so "idefloppy_" prefix is plain and simple
idiocy.
	e) note that
		rc = begin_format(drive, (int *)arg);
fits on the line just fine and is far more readable than crap above, with or
without linewrap.


Next example, please?

While we are at it,
                        if (drive->usage > 1) {
                                /* Don't format if someone is using the disk */
several lines above is broken by design -
	fd = open("/dev/hdc", O_RDWR);
	if (fork() == 0)
		write(fd, big_buffer, sizeof(big_buffer);
	else
		ioctl(fd, IDEFLOPPY_IOCTL_FORMAT_START, &args);
	exit(0);
will cheerfully pass that check and start format while the drive is very much
in use.  Driver (and hardware) will not be happy.

ioctl(2) - Just Say No...
