Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbUJZSG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbUJZSG3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 14:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUJZSFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 14:05:33 -0400
Received: from mail.autoweb.net ([198.172.237.26]:785 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261438AbUJZSEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 14:04:44 -0400
Date: Tue, 26 Oct 2004 14:04:09 -0400
From: Ryan Anderson <ryan@michonline.com>
To: David Vrabel <dvrabel@arcom.com>, Linus Torvalds <torvalds@osdl.org>,
       Len Brown <len.brown@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Versioning of tree
Message-ID: <20041026180408.GI10638@michonline.com>
Mail-Followup-To: David Vrabel <dvrabel@arcom.com>,
	Linus Torvalds <torvalds@osdl.org>, Len Brown <len.brown@intel.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1098254970.3223.6.camel@gaston> <1098256951.26595.4296.camel@d845pe> <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org> <20041025234736.GF10638@michonline.com> <417E39AE.5020209@arcom.com> <20041026122632.GH10638@michonline.com> <20041026190815.GA8338@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026190815.GA8338@mars.ravnborg.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 09:08:15PM +0200, Sam Ravnborg wrote:
> On Tue, Oct 26, 2004 at 08:26:33AM -0400, Ryan Anderson wrote:
> > On Tue, Oct 26, 2004 at 12:49:02PM +0100, David Vrabel wrote:
> > > Ryan Anderson wrote:
> > > >
> > > >Well, here's a patch that adds -BKxxxxxxxx to LOCALVERSION when a
> > > >top-level BitKeeper tree is detected.
> > > >[...]
> > > > LOCALVERSION = $(subst $(space),, \
> > > > 	       $(shell cat /dev/null $(localversion-files)) \
> > > >+	       $(subst ",,$(localversion-bk)) \
> > > 
> > > Surely there's no need for this?  Can't the script spit out an 
> > > appropriate localversion* file instead?
> > 
> > It can, and yes, my first version used that method.
> > 
> > Except it never worked.  I was able to generate the file before
> > include/linux/version.h was rebuilt, but failed to get it picked up in
> > that.  I'm not really sure why.
> 
> The $(wildcard ...) function was executed before you created the file.

Right.  I was unable to find a way to force the script to be run before
the $(wildcard) function was run - but, I don't claim to truly
understand what's going on in the Makefile.

> If we shall retreive the version from a SCM then as you already do
> must hide it in a script.
> I want the script only to be executed when we actually ask kbuild to
> build a kernel - so it has to be part of the prepare rule set.

By this, do you include targets such as *config?
The Debian tool used for generating Debian kernels determines the
version after doing a "make oldconfig", I believe, stores that away and
gets confused later when it doesn't match what it's actually building.
(Oh, and aside - it knows about localversion* and CONFIG_LOCALVERSION
for about 2-3 weeks, so a tweak to how the version is calculated
shouldn't be horrible to get picked up.)

> Furthermore I like to avoid a dependency on perl for a basic kernel.

I thought perl was already used somewhere intrinsically during a build.

> Can you retreive the version from bk using a simple shell script?

Sure.  The major problem then is figuing out what to do with the key
that you get.  My first inclination was to take a key like:
	ryan@michonline.com[ryan]|ChangeSet|20041026060927|60419
and simply use a hash on it, then take a substring of the hash to get a
semi-random string that can be deterministically generated.
I used Perl simply because I know of a fairly well-distributed module
that provides that functionality (i.e, Digest::MD5, part of the
distribution of 5.6 and 5.8).

Obviously, something like md5sum could do the job with a temp file.
Since I *thought* there was already a dependency on Perl, I was avoiding
that.

I was planning on a followup version that would add a CONFIG variable,
i.e, CONFIG_LOCALVERSION_AUTO, that drove this whole additional step, and
at the same time, to work out a similar method to do this for CVS.


-- 

Ryan Anderson
  sometimes Pug Majere
