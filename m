Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbUK1OHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbUK1OHq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 09:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUK1OHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 09:07:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37519 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261473AbUK1OFy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 09:05:54 -0500
Date: Sun, 28 Nov 2004 14:05:52 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Tomas Carnecky <tom@dbservice.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, ecki-news2004-05@lina.inka.de,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with ioctl command TCGETS
Message-ID: <20041128140552.GD26051@parcelfarce.linux.theplanet.co.uk>
References: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net> <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu> <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk> <E1CYODw-0001jf-00@dorka.pomaz.szeredi.hu> <20041128124847.GA26051@parcelfarce.linux.theplanet.co.uk> <E1CYOXh-0001nn-00@dorka.pomaz.szeredi.hu> <41A9D093.4090908@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A9D093.4090908@dbservice.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 02:20:19PM +0100, Tomas Carnecky wrote:
> But then you'd have to open another file :(

Correct, but not necessary on sysfs.

> And what about somethink like:
> cdrom_fd = open("/dev/cdrom", O_RDWR)
> cdrom_param_fd = get_param_fd(cdrom_fd) /* a new syscall */
> Now read/write to this param fd.
> And two new entries in the struct file_operations:
> write_param([same args as write])
> read_param([same args as read])

That assumes that there is any sort of uniform semantics for these
operations.  There isn't.  Moreover, you are insisting on pushing
all of them into the same channel; not a good idea since the set
of things done with ioctls tends to consist of several unrelated
classes, often coming from a bunch of unrelated subsystems.

There is no mechanical replacement for ioctl(); the nature of its
problems is that we have a random mix of unrelated operations bumped
into one pile.

Take a look at e.g. networking ioctls.  Most of them openly ignores the
descriptor used to issue an ioctl - more often then not the first thing
they do is to peek into the passed data structure and go looking for
the real object we are going to operate upon; e.g. find an interface by
name.  Of course it's bogus; any sane modification of that API would
have the object selected by the opened file we are passing to it.

And no, we have no chance in hell to rewrite all userland code that
uses these suckers, so we are stuck with them for all forseeable future.
UCB folks had no taste, film at 11...

For more or less common (read: implemented by more than a couple of drivers)
ioctls we have to keep them anyway; for the stuff where we really stand
a chance of doing some kind of changes (including the new operations) we
can bloody well do splitup by files that would match the nature of operations.
Which leaves the "get me secondary channel by fd" kind of operations
without any uses.
