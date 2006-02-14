Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030556AbWBNS7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030556AbWBNS7c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030583AbWBNS7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:59:32 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:51460 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1030556AbWBNS7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:59:31 -0500
Date: Tue, 14 Feb 2006 19:59:25 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, davidsen@tmr.com,
       nix@esperi.org.uk, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060214185925.GB51709@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Greg KH <greg@kroah.com>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>, davidsen@tmr.com,
	nix@esperi.org.uk, linux-kernel@vger.kernel.org, axboe@suse.de
References: <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <43F0891E.nailKUSCGC52G@burner> <20060213154921.GA22597@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213154921.GA22597@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 07:49:21AM -0800, Greg KH wrote:
> On Mon, Feb 13, 2006 at 02:26:54PM +0100, Joerg Schilling wrote:
> > Greg KH <greg@kroah.com> wrote:
> > 
> > > On Fri, Feb 10, 2006 at 04:06:39PM -0500, Bill Davidsen wrote:
> > > > 
> > > > The kernel could provide a list of devices by category. It doesn't have 
> > > > to name them, run scripts, give descriptions, or paint them blue. Just a 
> > > > list of all block devices, tapes, by major/minor and category (ie. 
> > > > block, optical, floppy) would give the application layer a chance to do 
> > > > it's own interpretation.
> > >
> > > It does so today in sysfs, that is what it is there for.
> > 
> > Do you really whant libscg to open _every_ non-directory file under /sys?
> 
> Of course not.  Here's one line of bash that gets you the major:minor
> file of every block device in the system:
> 	block_devices="$(echo /sys/block/*/dev /sys/block/*/*/dev)"

Of course, that's entirely useless if you're not root.

So what you _really_ have to do is to call udevinfo -e.  If that
fails, call udevinfo -d, that's the old name for the option which got
changed along the way.  The result is blocks of text lines separated
by blank lines, text lines of the form:

I: value

Where I is a one-letter uppercase identifier, and value a value.

If you get E: entries, you're lucky.  All cdroms have a E: ID_CDROM=1
entry, but these entries appeared late.  Otherwise, the best bet is to
scan the S: entries for something matching /cdrom/.  When you have a
bloc of lines, get the N: entry, that's the node name, and prepend it
with the result of udevinfo -r (usually /dev/, but that's not
mandatory).  That will give you the device node path to open (don't
forget O_EXCL to avoid Hal stomping all over you), which you can then
use SG_IO with.

If udevinfo is not available, you'll have to try opening all /dev/hd*,
/dev/sr*, /dev/scd*, /dev/sg*, /dev/cdr* and /dev/dvd* (don't stop at
the first -EANYTHING though, otherwise you'll miss some).  Then you
can poke the device carefully with SG_IO.

  OG.
