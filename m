Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVEKKAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVEKKAc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 06:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVEKKAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 06:00:32 -0400
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:3602 "EHLO
	smtp-vbr5.xs4all.nl") by vger.kernel.org with ESMTP id S261955AbVEKKAQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 06:00:16 -0400
Date: Wed, 11 May 2005 11:59:55 +0200
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Greg KH <gregkh@suse.de>, "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Roman Kagan <rkagan@mail.ru>
Subject: Re: [PATCH] Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050511115955.D7594@banaan.localdomain>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Greg KH <gregkh@suse.de>,
	"Alexander E. Patrakov" <patrakov@ums.usu.ru>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Roman Kagan <rkagan@mail.ru>
References: <20050510172447.GA11263@wonderland.linux.it> <20050510201355.GB3226@suse.de> <20050510203156.GA14979@wonderland.linux.it> <20050510205239.GA3634@suse.de> <20050510210823.GB15541@wonderland.linux.it> <20050510232207.A7594@banaan.localdomain> <20050511015509.B7594@banaan.localdomain> <1115770106.17201.21.camel@localhost.localdomain> <20050511031103.C7594@banaan.localdomain> <1115782753.17201.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1115782753.17201.54.camel@localhost.localdomain>; from rusty@rustcorp.com.au on Wed, May 11, 2005 at 01:39:13PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 01:39:13PM +1000, Rusty Russell wrote:
> On Wed, 2005-05-11 at 03:11 +0200, Erik van Konijnenburg wrote:
> > Here's an alternative approach that should cover these interests:
> > - add a keyword 'blacklist' to the configuration language,
> >   that will be interpreted after alias expansion, but before
> >   searching modules.dep.
> 
> This makes "blacklist X" equivalent to "install X /bin/true" right?  i.e
> "ignore it".

Except for output on --show-depends and total number of forks, yes.

Based on comments from Greg and Christian, it would be better to apply
blacklisting only to the result of alias expanding for kernel generated
module maps.  So:

	cat >> /etc/hotplug/blacklist.d/test <<//
	blacklist snd_rme96
	//

would apply to

	modprobe 'pci:v000010EEd00003FC0sv*sd*bc*sc*i*'

but not to

	modprobe snd_rme96

> > Advantages:
> > - it needs a lot less code
> > - distributions can decide whether blacklists work always,
> >   never, or only for the kernel simply by playing with which
> >   configuration file is used
> > - my initramfs builder does not have to be special cased
> >   to know that some install directives really are blacklist
> >   directives.
> 
> Well, a module mentioned in hotplug's blacklist file would be a pretty
> good candidate for exclusion from your initramfs builder.  Existing
> install commands are already trouble for initramfs building, since they
> can do arbitrary things...

Yep.  At the moment my initramfs builder aborts on such install directives,
because there's no correct way of handling them.  Since install isn't used
all that much and certainly not in boot-critical stuff, thats acceptable, 
but if we're going to use install for every blacklisted module,
that's a problem.

> How about I allow "--config=-" and hotplug can use the existing
> blacklists and 'sed'?

That would keep existing blacklist, which is good for Marco and 
for initramfs builders.

However, it would be bad for hotplug-ng: one of the strong points
is that it speeds booting by dropping loads of shell code, and
adding sed for blacklist processing does not fit well with that.

I'll take a stab at a patch that introduces the 'blacklist' keyword
to see if that reduces the code enough to make it acceptable.

Regards,
Erik


