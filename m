Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbTEQElf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 00:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbTEQEkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 00:40:40 -0400
Received: from dp.samba.org ([66.70.73.150]:51153 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261218AbTEQEkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 00:40:36 -0400
Date: Sat, 17 May 2003 14:44:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg KH <greg@kroah.com>
Cc: Oliver Neukum <oliver@neukum.org>, Manuel Estrada Sainz <ranty@debian.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030517044459.GB13827@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.org>,
	Manuel Estrada Sainz <ranty@debian.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Simon Kelley <simon@thekelleys.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
	Pavel Roskin <proski@gnu.org>
References: <200305170155.15295.oliver@neukum.org> <20030517000338.GA17466@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030517000338.GA17466@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 05:03:38PM -0700, Greg Kroah-Hartman wrote:
> On Sat, May 17, 2003 at 01:55:15AM +0200, Oliver Neukum wrote:
> > 
> > > > 	- echo 1 > /sysfs/class/firmware/dev_name/loading
> > > > 	- cat whatever_fw > /sysfs/class/firmware/dev_name/data
> > > > 	- echo 0 > /sysfs/class/firmware/dev_name/loading
> > >
> > > Nice, but can't you get rid of the loading file by just relying on
> > > open() and close()?  Oh wait, sysfs doesn't pass that down to you, hm,
> > > looks like you need that info.  But does the new binary interface in
> > > sysfs that just got merged into the tree provide that info for you?
> > 
> > But what if the close() is due to irregular termination?
> > If the script is killed, do you download half a firmware?
> 
> Good point.  Actually I don't think that the binary interface for sysfs
> passes open and close down to the lower levels, so it's a moot point.
> 
> echo... works for me.

I think we'd be better off checking for this case by requiring the
firmware to include a length field and adapting the binary interface
so that we can see the open/close boundary.  The "loading" thing is
pretty damn ugly.

Plus with the "loading" file, a interrupted load will just appear to
be unterminated - and if the scripts run again they'll have to check
that the loading file was 0 to start with - and if it isn't there's
nothing they can do except wait for the dead load to time out.

Better to catch the close, check the length, then return the firmware
or throw the junk image away as appropriate.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
