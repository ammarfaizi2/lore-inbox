Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTFZNGs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 09:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbTFZNGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 09:06:48 -0400
Received: from mail.convergence.de ([212.84.236.4]:5264 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261566AbTFZNGh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 09:06:37 -0400
Date: Thu, 26 Jun 2003 15:20:34 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Michael Hunold <hunold@convergence.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Marcus Metzler <mocm@metzlerbros.de>, Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DVB Include files
Message-ID: <20030626132034.GE29671@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Christoph Hellwig <hch@infradead.org>,
	Michael Hunold <hunold@convergence.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Marcus Metzler <mocm@metzlerbros.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EFAAC69.6090709@convergence.de> <20030626092444.A26890@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030626092444.A26890@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 26, 2003 at 09:24:44AM +0100, Christoph Hellwig wrote:
> On Thu, Jun 26, 2003 at 10:18:49AM +0200, Michael Hunold wrote:
> > In include/linux/dvb we have the headers that are shared between user
> > applications and the kernel driver. As I said above, these are stable and
> > never change for the v3 api.

Actually the last (backwards compatible) change to the v3 API
was just about two months ago. The last really incompatible change
was more than a year ago, if you don't count the change to the
previously unused/unusable VIDEO_GET_EVENT ioctl three months ago.

Meanwhile we have begun working on a "v4" DVB API, which will
have many incompatible changes. This changes are necessary to support
advanced features of newer set-top-box chips sets which are not
yet used in DVB PCI-cards or USB-boxes. I doubt there will
be a publicly available driver with this API this year, as there isn't
any code yet, just some conceptual work. Anyway, v3 will be stable
because v4 exists.

> > In an ideal world, these header files would
> > be included in your glibc distribution at /usr/include/linux/dvb
> > Currently, you must copy them by hand or create a symlink, because there
> > hasn't been an official kernel with the dvb driver subsystem yet.
> 
> And that's the whole point.  In fact I hear exactly that problem from a
> friend at SuSE who maintained an (inofficial?) dvb package.  He packaged
> the kernel driver but of course it's not part of the official SuSE kernel
> and even more so the kernel headers package that is created with the
> kernel package but doesn't change during the lifetime of the glibc
> package.  Now he's not allowed to just write into /usr/include/linux/
> either because that directory is owned by the kernel headers package.
> 
> Please just get over it and put a copy of the headers into /usr/include/dvb,
> this makes life easier for everyone.

Three things:

1. glibc has nothing to do with driver ioctls (exceptions exist for
   "standard" drivers, e.g. tty handling); important for glibc is that
   the system call interface does not change, so the files in
   /usr/include/linux and /usr/include/asm must match glibc.
   OTOH ioctl definitions for drivers must match the driver that is
   currently in use. If the ioctl definitions change, binary
   compatiblity is broken (bad), but source compatiblity can be
   maintained if the driver API header files are updated. If they are
   not updated, source compatiblity is also broken (really bad).

2. It seems to me that /usr/include/linux is the place where almost all
   drivers put their ioctl API definitions (input.h, rtc.h, nvram.h,
   matroxfb.h, etc.). So it seemed the right place for the DVB API
   is /usr/include/linux/dvb/. I thought this is the Linux way.

3. Consequently applications use e.g. #include <linux/dvb/frontend.h>,
   and to maintain application source compatibility this include path must
   not be changed. Distributions could put the API headers in
   /usr/include/dvb/linux/dvb/ and compile applications with
   -I/usr/include/dvb.

I think it is a fundamental problem that driver ioctl definitions
(relatively frequent changes for many drivers) are mixed with low
level kernel ABI definitions (few changes). Maybe it would be better to
separate all driver APIs in linux/include/drivers/ and symlink
that to /usr/include/drivers/, while /usr/include/{linux,asm} can
match glibc.


Johannes
