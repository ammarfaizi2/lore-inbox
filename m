Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261875AbSJQIpK>; Thu, 17 Oct 2002 04:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbSJQIpK>; Thu, 17 Oct 2002 04:45:10 -0400
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:57098 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S261875AbSJQIpJ>; Thu, 17 Oct 2002 04:45:09 -0400
Date: Thu, 17 Oct 2002 09:50:45 +0100
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] Device-mapper submission 6/7
Message-ID: <20021017085045.GA2651@fib011235813.fsnet.co.uk>
References: <20021015175858.GA28170@fib011235813.fsnet.co.uk> <3DAC5B47.7020206@pobox.com> <20021015214420.GA28738@fib011235813.fsnet.co.uk> <3DAD75AE.7010405@pobox.com> <20021016152047.GA11422@fib011235813.fsnet.co.uk> <3DAD8CC9.9020302@pobox.com> <20021017080552.GA2418@fib011235813.fsnet.co.uk> <m3fzv5pj23.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3fzv5pj23.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 10:26:44AM +0200, Andi Kleen wrote:
> Joe Thornber <joe@fib011235813.fsnet.co.uk> writes:
> 
> > Is there anyone out there who is going to argue against using an fs
> > interface when I submit it ?  Speak now or forever hold your peace !
> > 
> > If dm now misses the feature freeze deadline due to this extra work,
> > is it going to be possible to still place it in 2.5 at a later date ?
> > (dm with an ioctl interface is better than no dm at all).
> 
> How would the fs based interface work ? 
> 
> plan9 style echo 'rename foo bla' > /dmfs/command would seem ugly to me
> (just look at the horrible parser code for that in mtrr.c) 
> 
> doing it fully as fs objects (mv /dmfs/volume1 /dmfs/volume2 for rename)
> could likely get complicated and it's doubtful that VFS semantics completely
> map to DM volumes.

I'll describe what Steve Whitehouse had working before:

Each directory would represent a single device, the name of the
directory names the device (so yes, a mv renames the device).  Inside
each directory are a collection of files:

TABLE - People just cat the table to here to load a mapping.  They can
read it to get the mapping back.

INFO - General information about the device, is it suspended, how many
people have it open etc.

STATUS - One line of information per target, people can poll on this
file in order to block until something 'interesting' happens (eg, an
initial mirror sync completes, a snapshot uses up another 5% of
space).

The thing I'm not sure about is how to map the supend/resume semantics
onto the fs.  It is tempting to bind suspend to an writeable open of
the TABLE file, and resume to the closing of the device.  However that
means that closing the device both indicates the end of the table and
a resume, I'm not sure that is good enough, eg, if the table is bogus
we don't neccessarily want to automatically resume the old table.  So
this leads us to start thinking about a sepearate SUSPENDED file that
we write a 1 or 0 to, yuck.

> Unless you have a clear and simple way to handle these issues I would
> suggest to stay with simple ioctls. They look clean enough.

Linus, any chance you could indicate the preferred direction ?

- Joe
