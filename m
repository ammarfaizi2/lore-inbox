Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVEKBL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVEKBL7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 21:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVEKBL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 21:11:59 -0400
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:56848 "EHLO
	smtp-vbr8.xs4all.nl") by vger.kernel.org with ESMTP id S261868AbVEKBL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 21:11:28 -0400
Date: Wed, 11 May 2005 03:11:03 +0200
From: Erik van Konijnenburg <ekonijn@xs4all.nl>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Greg KH <gregkh@suse.de>, "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Roman Kagan <rkagan@mail.ru>
Subject: Re: [PATCH] Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050511031103.C7594@banaan.localdomain>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Greg KH <gregkh@suse.de>,
	"Alexander E. Patrakov" <patrakov@ums.usu.ru>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Roman Kagan <rkagan@mail.ru>
References: <20050510094339.GC6346@wonderland.linux.it> <4280AFF4.6080108@ums.usu.ru> <20050510172447.GA11263@wonderland.linux.it> <20050510201355.GB3226@suse.de> <20050510203156.GA14979@wonderland.linux.it> <20050510205239.GA3634@suse.de> <20050510210823.GB15541@wonderland.linux.it> <20050510232207.A7594@banaan.localdomain> <20050511015509.B7594@banaan.localdomain> <1115770106.17201.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1115770106.17201.21.camel@localhost.localdomain>; from rusty@rustcorp.com.au on Wed, May 11, 2005 at 10:08:25AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 10:08:25AM +1000, Rusty Russell wrote:
> On Wed, 2005-05-11 at 01:55 +0200, Erik van Konijnenburg wrote:
> > Hi,
> > 
> > Patch against module-init-tools-3.2-pre4 to ignore modules
> > listed in /etc/hotplug/blacklist or blacklist.d (recursively).
> 
> That's a lot of code to make a module impossible to install, and I think
> it kind of misses the point.  Surely a non-hotplug "modprobe
> blacklisted-module" should work?
> 
> If we define the first install to override included install commands,
> and hotplug uses --config=<blacklistfile>, I think we have a better
> solution.

Lets see:
- You want less code (for good reason, it really is a lot more
  than the equivalent in perl)
- Marco wants the blacklist only to work when invoked via kernel,
  and needs only /etc/hotplug/blacklist.d.
- Marco wants the blacklist to apply after alias expansion
  rather than before.
- I want to avoid install commands whenever possible.
  The reason is that for building an initramfs, I need to interpret
  modprobe output and decide what goes on the image.  For 'insmod'
  that's easy; but I don't know of a way to interpret install
  command lines and deciding *reliably* what executables and libraries
  need to go on the image.  (incidentally, this is a use case
  where blacklist interpretation is desirable, even though modprobe
  is not invoked by the kernel)

Here's an alternative approach that should cover these interests:
- add a keyword 'blacklist' to the configuration language,
  that will be interpreted after alias expansion, but before
  searching modules.dep.

Advantages:
- it needs a lot less code
- distributions can decide whether blacklists work always,
  never, or only for the kernel simply by playing with which
  configuration file is used
- my initramfs builder does not have to be special cased
  to know that some install directives really are blacklist
  directives.

If this approach seems workable to you, I plan to build something
like this tomorrow.

> > * tested only with -n, -v and --showdeps, not in live use.
> 
> I'm going to start bundling the testsuite with the source, to encourage
> people to actually use it: it's not that hard...

That's a hint I guess ...  OK, next patch will go through the suite.

Regards,
Erik
