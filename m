Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268817AbUHLWMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268817AbUHLWMQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268788AbUHLWMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:12:16 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:19442 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268817AbUHLWL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:11:56 -0400
Subject: Re: [RFC, PATCH] sys_revoke(), just a try. (was: Re: dynamic /dev
	security hole?)
From: Albert Cahalan <albert@users.sf.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michael Buesch <mbuesch@freenet.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Eric Lammerts <eric@lammerts.org>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       Greg KH <greg@kroah.com>
In-Reply-To: <1092340279.22362.6.camel@localhost.localdomain>
References: <20040808162115.GA7597@kroah.com>
	 <1092057570.5761.215.camel@cube> <200408111912.21469.mbuesch@freenet.de>
	 <200408121849.20227.mbuesch@freenet.de>
	 <1092340279.22362.6.camel@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1092339571.5759.767.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Aug 2004 15:39:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 15:51, Alan Cox wrote:
> On Iau, 2004-08-12 at 17:49, Michael Buesch wrote:
> > +static ssize_t revoke_read(struct file *filp,
> > +			   char *buf,
> > +			   size_t count,
> > +			   loff_t *ppos)
> > +{
> > +	return 0;
> > +}
> 
> -EIO I think but I'm not sure I remember the BSD behaviour in full
> 
> > +static int filp_revoke(struct file *filp, struct inode *inode)
> > +{
> 
> First problem here is that the handle might still be in use
> for mmap, so you'd need to undo mmaps on it.

Two other choices:

a. map anon memory over the old mapping
b. fail the revoke() call, perhaps with EBUSY

> A second is that 
> while you can ->flush() here you can't really close it until the
> file usage count hits zero. 
> 
> You are btw tackling a really really hard problem and its more likely
> the way to do this is to add revoke() methods to drivers and do it at
> the driver level - as the tty layer does with vhangup.

What about using a signal with enforced action?
(like SIGSTOP and SIGKILL) The user could still
install a handler, but only to know when revoke()
has taken action. I have a feeling that this would
be less trouble, since the losing process performs
action on its own data structures.

BTW, one must watch out for dup2() in another thread.


