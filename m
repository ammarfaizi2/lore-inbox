Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbTETFNZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 01:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTETFNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 01:13:25 -0400
Received: from dp.samba.org ([66.70.73.150]:47039 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263570AbTETFNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 01:13:23 -0400
Date: Tue, 20 May 2003 15:21:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030520052158.GD5248@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Manuel Estrada Sainz <ranty@debian.org>, Greg KH <greg@kroah.com>,
	Oliver Neukum <oliver@neukum.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Simon Kelley <simon@thekelleys.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
	Pavel Roskin <proski@gnu.org>
References: <20030517090705.GA16092@zax> <20030517103037.GA17576@ranty.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030517103037.GA17576@ranty.ddts.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 12:30:37PM +0200, Manuel Estrada Sainz wrote:
> On Sat, May 17, 2003 at 07:07:05PM +1000, David Gibson wrote:
> > On Sat, May 17, 2003 at 10:46:12AM +0200, Manuel Estrada Sainz wrote:
> > > On Sat, May 17, 2003 at 02:44:59PM +1000, David Gibson wrote:
> > > > On Fri, May 16, 2003 at 05:03:38PM -0700, Greg Kroah-Hartman wrote:
> > > > > On Sat, May 17, 2003 at 01:55:15AM +0200, Oliver Neukum wrote:
> > > > > > 
> [snip]
> > >  But in case you are doing things by hand, how about:
> > >  
> > > 	$ echo cancel > .../loading
> > > 
> > > 	or if you want to keep the content numeric:
> > > 
> > > 	$ echo -1 > .../loading
> > > 
> > >  This will also allow the regular script to just cancel the load in case
> > >  of error, like if the firmware image is not available or a read error
> > >  happened while reading it.
> > > 
> > >  I'll implement that and the other stuff that came out of Oliver's
> > >  comments later today and post the new code.
> > >  
> > > > Better to catch the close, check the length, then return the firmware
> > > > or throw the junk image away as appropriate.
> > > 
> > >  If 'loading' stays the above should fix your timeout issue, and if it
> > >  goes, yes, that is probably the way to go.
> > 
> > How about combining these two ideas: instead of "loading" and "data"
> > we have "size" and "data".  First you write the size, then the data -
> > the driver accepts it once it gets the expected number of bytes.
> > Writing a new size throws away any partial image that's there, and
> > restarts the upload.  Writing 0 cancels the upload entirely, and the
> > driver will presumably fail to initialize (or maybe use a default
> > image if it has one).
> 
>  I just thought this over. This makes more requirements for the userspace
>  scripts, they will need some way to get the size of the image: stat, or
>  ls and some crude regex.
> 
>  And we can have the same effect with loading/data:
> 
>  echo 1 > .../loading:
>  	Will start a load, discarding any previous partial load.
>  echo 0 > .../loading:
>  	Will conclude the load and handle the data to the driver code.
>  echo -1 > .../loading:
> 	Will conclude the load with an error and the driver won't get
> 	any firmware, failing or using firmware in some flash if
> 	available.
> 
>  This way, the script also won't have to check the value of 'loading'.
> 
>  How does that sound?

Hrm... it still seems a bit icky to me, but I'm not really sure why.
I think it would be a bit better if you called it "control" or
something instead of "loading".  "loading" seems to imply a boolean,
which this isn't anymore.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
