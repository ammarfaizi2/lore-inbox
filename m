Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbUK1P2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbUK1P2E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 10:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbUK1P2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 10:28:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10647 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261493AbUK1P16
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 10:27:58 -0500
Date: Sun, 28 Nov 2004 15:27:56 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Tomas Carnecky <tom@dbservice.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, ecki-news2004-05@lina.inka.de,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with ioctl command TCGETS
Message-ID: <20041128152756.GL26051@parcelfarce.linux.theplanet.co.uk>
References: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net> <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu> <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk> <E1CYODw-0001jf-00@dorka.pomaz.szeredi.hu> <20041128124847.GA26051@parcelfarce.linux.theplanet.co.uk> <E1CYOXh-0001nn-00@dorka.pomaz.szeredi.hu> <20041128130319.GB26051@parcelfarce.linux.theplanet.co.uk> <41A9E0FB.8030001@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A9E0FB.8030001@dbservice.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 03:30:19PM +0100, Tomas Carnecky wrote:
> You mean.. like nvidia?
> /dev/nvidiactl
> /dev/nvidia0
> /dev/nvidia1
> /dev/nvidia2
> and do read/write on /dev/nvidiactl (instead on ioctl)?

Really depends on situation - in some cases that's the obvious clean
variant, in some you might want something more specific.  Usually
it helps to ask "what object am I working with?" and see if it gives
a reasonable picture.  Note, BTW, that your example (eject) actually
demonstrates what kind of ugliness can be created by piling everything
together - the logics around "it's currently used, do not eject and
return -EBUSY" is broken and unfixable in all cdrom drivers.  Broken
exactly because we need to open device itself to issue eject request.
Think what happens if we get
	fd = open("/dev/cdrom", 0);
	if (fork()) {
		read a lot from that sucker
	} else {
		sleep for a while
		ioctl(fd, CDROMEJECT, 0);
	}
>From the driver point of view, we have only one opener.  There's no way
to tell how many processes might have file descriptors that point to
what we'd opened back then.  So we either need to keep track of all
changes in descriptor tables and provide exclusion between that and
ioctls (have fun) or admit that driver might be hit with eject in the
middle of IO, all logics along the lines of "it's opened by somebody,
no eject for us" nonwithstanding.

And then there are horrors like cciss special-casing the open of 1st disk
on a controller (even if there's none) so that we could talk to controller
itself (in particular, tell it to go look for disks that might be attached
to it now).  It gets very ugly; same for RAID array creation, same for
loop device setup and races around it, etc.
