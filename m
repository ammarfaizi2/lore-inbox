Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTKQTPU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 14:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbTKQTPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 14:15:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60564 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263584AbTKQTPP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 14:15:15 -0500
Date: Mon, 17 Nov 2003 19:15:13 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is initramfs freed after kernel is booted?
Message-ID: <20031117191513.GA24159@parcelfarce.linux.theplanet.co.uk>
References: <E1ALlQs-000769-00.arvidjaar-mail-ru@f7.mail.ru> <3FB90A6A.4050505@nortelnetworks.com> <20031117180312.GZ24159@parcelfarce.linux.theplanet.co.uk> <200311172133.59839.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311172133.59839.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 09:33:59PM +0300, Andrey Borzenkov wrote:
> On Monday 17 November 2003 21:03, viro@parcelfarce.linux.theplanet.co.uk 
> wrote:
> > On Mon, Nov 17, 2003 at 12:50:34PM -0500, Chris Friesen wrote:
> > > viro@parcelfarce.linux.theplanet.co.uk wrote:
> > > >On Mon, Nov 17, 2003 at 11:06:48AM -0500, Chris Friesen wrote:
> > > >>Anyone know why it overmounts rather than pivots?
> > > >
> > > >Because amount of extra code you lose that way takes more memory than
> > > >empty roots takes.
> > > >
> > > >Remove whatever files you don't need and be done with that.
> > >
> > > How do you remove files from the old rootfs after the new one has been
> > > mounted on top of it?
> >
> > You do that before ;-)
> 
> would the following work?
> 
> pivot_root . /initramfs
> cd /initramfs && rm -rf *

No.  pivot_root() will not move the absolute root of tree elsewhere.

> ?? doing it before is rather hard ... you apparently still need something to 
> execute your mounts :)

You do, but you can trivially call unlink() on the executable itself.  It
will be freed after it does exec() of final /sbin/init...

Alternatively, you could
mkdir /root
mount final root on /root

chdir("/root");
mount("/", "initramfs", NULL, MS_BIND, NULL);
mount(".", "/", NULL, MS_MOVE, NULL);
chroot(".");
execve("/sbin/init", ...)

and have init scripts do rm -rf /initramfs/*; umount /initramfs
