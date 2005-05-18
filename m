Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVERXBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVERXBg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 19:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVERXBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 19:01:35 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:2801 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S262352AbVERXB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 19:01:29 -0400
Date: Thu, 19 May 2005 01:00:06 +0200
From: Per Svennerbrandt <per.svennerbrandt@lbi.se>
To: Per Liden <per@fukt.bth.se>, Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050518230006.GA3011@tsiryulnik>
Mail-Followup-To: Per Liden <per@fukt.bth.se>, Greg KH <greg@kroah.com>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050506212227.GA24066@kroah.com> <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se> <20050509211323.GB5297@tsiryulnik> <Pine.LNX.4.63.0505102351300.8637@1-1-2-5a.f.sth.bostream.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: =?ISO-8859-1?Q?=20=1B?=
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0505102351300.8637@1-1-2-5a.f.sth.bostream.se>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Per Liden (per@fukt.bth.se) wrote:
> On Mon, 9 May 2005, Per Svennerbrandt wrote:
> 
> > * Per Liden (per@fukt.bth.se) wrote:
> > > On Fri, 6 May 2005, Greg KH wrote:
> > > 
> > > [...]
> > > > Now, with the 2.6.12-rc3 kernel, and a patch for module-init-tools, the
> > > > USB hotplug program can be written with a simple one line shell script:
> > > > 	modprobe $MODALIAS
> > > 
> > > Nice, but why not just convert all this to a call to 
> > > request_module($MODALIAS)? Seems to me like the natural thing to do.
> > 
> > I actually have a pretty hackish proof-of-consept patch that does
> > basicly that, and have been running it on my systems for the past five
> > months or so, if anybody's interested.
> 
> Ah! Please post the patches.

Ok, so I finally decided that it's probably silly of me to hold of a
working patch just because I wanted my first submission to the kernel
to somehow be a marvellous example of ellegancy and not just some 
quick hack that I threw toghether as a personal proof-of-consept.

> > Along with it I also have a patch witch exports the module aliases for
> > PCI and USB devices through sysfs. With it the "coldplugging" of a
> > system (module wise) can be reduced to pretty much:
> > 
> > #!/bin/sh
> > 
> > for DEV in /sys/bus/{pci,usb}/devices/*; do
> > 	modprobe `cat $DEV/modalias`
> > done
> 
> Nice! This is really what coldplugging _should_ look like. Hmm, maybe 
> even coldplug the system by request_module()'ing those as well at some 
> stage?

Well, the code already generates all the requests necessary. :) The only
problem now of course beeing that it generates those at a "stage" ;) when
userspace usually isn't ready to fullfill those.

I'm currently thinking about maybe making all the requests sleep on a
waitqueue untill the root filesystem becomes availible, shoudn't be too
hard if I remember the code correctly... Could potentialy end up using 
a lot of resourses though.

And, yeah, I know this could all be done quite easily with scripts in a
initrd or similar, but that is in fact *exactly* what I'm trying to
avoid here, to reduce complexity and keep thinks as simple as they 
possibly can be. I'm not proposing this as a generic solution for
everyone, rather the opposite in fact. I do however beleve there to be
enough demand out there for this particular kind of "special case" to
warrant (optional) support for it in the mainline kernel.

> > (And I actually run exactly that on my laptop, and it works surpricingly
> > well. (Largly due to the fact that the usb-controller is always attached
> > below the pci-bus of course, but it really wouldn't take that much work 
> > to make it do the right thing even without relying on any specific 
> > ordering/topology))
> > 
> > With the above in place my system does all the module-loading that I
> > care about automaticly, and most importantly does so without relying
> > on an /etc/hotplug/ dir with everything and it's grandma in it (or at
> > least thousands of lines of shellscripting).
> 
> This is exactly what I'm looking for as well.

For example, I see absolutely no need for a fullblown hotplug system 
on my minimalst-userspace router/firewall. I just want the kernel to
be able to load the right modules, on demand, as it boots (and perhaps
when I plug in a usb flashdrive, every third, or so, year).

> > But since the request_modalias() thing seemed as such an obvious thing
> > to do I have been reluctant to submit it fearing that I must have missed
> > some fundamental flaw in it or you guys would have implemented it that 
> > way a long time ago? (at least since Rusty rewrote the module
> > loader). Was I wrong*?
> > 
> > Greg, Rusty, what do you think?
> 
> I'd like to get a better understanding of that as well. Why invent a 
> second on demand module loader when we have kmod? The current approach 
> feels like a step back to something very similar to the old kerneld.
> 
> /Per L
 
Sorry for the delay, patches to follow.

/ Per Svennerbrandt
