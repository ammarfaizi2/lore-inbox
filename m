Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTEQIdt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 04:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTEQIdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 04:33:49 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:1173 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S261311AbTEQIdr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 04:33:47 -0400
Date: Sat, 17 May 2003 10:46:12 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: David Gibson <david@gibson.dropbear.id.au>, Greg KH <greg@kroah.com>,
       Oliver Neukum <oliver@neukum.org>, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030517084612.GC3808@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <200305170155.15295.oliver@neukum.org> <20030517000338.GA17466@kroah.com> <20030517044459.GB13827@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030517044459.GB13827@zax>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 02:44:59PM +1000, David Gibson wrote:
> On Fri, May 16, 2003 at 05:03:38PM -0700, Greg Kroah-Hartman wrote:
> > On Sat, May 17, 2003 at 01:55:15AM +0200, Oliver Neukum wrote:
> > > 
> > > > > 	- echo 1 > /sysfs/class/firmware/dev_name/loading
> > > > > 	- cat whatever_fw > /sysfs/class/firmware/dev_name/data
> > > > > 	- echo 0 > /sysfs/class/firmware/dev_name/loading
> > > >
> > > > Nice, but can't you get rid of the loading file by just relying on
> > > > open() and close()?  Oh wait, sysfs doesn't pass that down to you, hm,
> > > > looks like you need that info.  But does the new binary interface in
> > > > sysfs that just got merged into the tree provide that info for you?
> > > 
> > > But what if the close() is due to irregular termination?
> > > If the script is killed, do you download half a firmware?
> > 
> > Good point.  Actually I don't think that the binary interface for sysfs
> > passes open and close down to the lower levels, so it's a moot point.
> > 
> > echo... works for me.
> 
> I think we'd be better off checking for this case by requiring the
> firmware to include a length field and adapting the binary interface
> so that we can see the open/close boundary.  The "loading" thing is
> pretty damn ugly.
 
 I did look for open/close first and finally added the 'loading' because
 I didn't have them.
 
 I don't thing it is so ugly, but if I could see open/close and the
 consensus is that 'loading' should go, I'll do it.
 
> Plus with the "loading" file, a interrupted load will just appear to
> be unterminated - and if the scripts run again they'll have to check
> that the loading file was 0 to start with - and if it isn't there's
> nothing they can do except wait for the dead load to time out.

 The script will not automatically run at least until the timeout is
 expired.

 But in case you are doing things by hand, how about:
 
	$ echo cancel > .../loading

	or if you want to keep the content numeric:

	$ echo -1 > .../loading

 This will also allow the regular script to just cancel the load in case
 of error, like if the firmware image is not available or a read error
 happened while reading it.

 I'll implement that and the other stuff that came out of Oliver's
 comments later today and post the new code.
 
> Better to catch the close, check the length, then return the firmware
> or throw the junk image away as appropriate.

 If 'loading' stays the above should fix your timeout issue, and if it
 goes, yes, that is probably the way to go.

 Thanks

 	Manuel
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
