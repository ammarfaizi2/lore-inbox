Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbTEQKR4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 06:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbTEQKR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 06:17:56 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:59285 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S261392AbTEQKRy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 06:17:54 -0400
Date: Sat, 17 May 2003 12:30:37 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: David Gibson <david@gibson.dropbear.id.au>, Greg KH <greg@kroah.com>,
       Oliver Neukum <oliver@neukum.org>, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030517103037.GA17576@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <200305170155.15295.oliver@neukum.org> <20030517000338.GA17466@kroah.com> <20030517044459.GB13827@zax> <20030517084612.GC3808@ranty.ddts.net> <20030517090705.GA16092@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030517090705.GA16092@zax>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 07:07:05PM +1000, David Gibson wrote:
> On Sat, May 17, 2003 at 10:46:12AM +0200, Manuel Estrada Sainz wrote:
> > On Sat, May 17, 2003 at 02:44:59PM +1000, David Gibson wrote:
> > > On Fri, May 16, 2003 at 05:03:38PM -0700, Greg Kroah-Hartman wrote:
> > > > On Sat, May 17, 2003 at 01:55:15AM +0200, Oliver Neukum wrote:
> > > > > 
[snip]
> >  But in case you are doing things by hand, how about:
> >  
> > 	$ echo cancel > .../loading
> > 
> > 	or if you want to keep the content numeric:
> > 
> > 	$ echo -1 > .../loading
> > 
> >  This will also allow the regular script to just cancel the load in case
> >  of error, like if the firmware image is not available or a read error
> >  happened while reading it.
> > 
> >  I'll implement that and the other stuff that came out of Oliver's
> >  comments later today and post the new code.
> >  
> > > Better to catch the close, check the length, then return the firmware
> > > or throw the junk image away as appropriate.
> > 
> >  If 'loading' stays the above should fix your timeout issue, and if it
> >  goes, yes, that is probably the way to go.
> 
> How about combining these two ideas: instead of "loading" and "data"
> we have "size" and "data".  First you write the size, then the data -
> the driver accepts it once it gets the expected number of bytes.
> Writing a new size throws away any partial image that's there, and
> restarts the upload.  Writing 0 cancels the upload entirely, and the
> driver will presumably fail to initialize (or maybe use a default
> image if it has one).

 I just thought this over. This makes more requirements for the userspace
 scripts, they will need some way to get the size of the image: stat, or
 ls and some crude regex.

 And we can have the same effect with loading/data:

 echo 1 > .../loading:
 	Will start a load, discarding any previous partial load.
 echo 0 > .../loading:
 	Will conclude the load and handle the data to the driver code.
 echo -1 > .../loading:
	Will conclude the load with an error and the driver won't get
	any firmware, failing or using firmware in some flash if
	available.

 This way, the script also won't have to check the value of 'loading'.

 How does that sound?

 Thanks

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
