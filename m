Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932719AbWCPUeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbWCPUeH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWCPUeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:34:07 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:28169 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932719AbWCPUeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:34:06 -0500
Date: Thu, 16 Mar 2006 21:34:00 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Mathis Ahrens <Mathis.Ahrens@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.16-rc6] CONFIG_LOCALVERSION_AUTO
Message-ID: <20060316203400.GA24008@mars.ravnborg.org>
References: <44179C77.1010902@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44179C77.1010902@gmx.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 05:47:51AM +0100, Mathis Ahrens wrote:
> 
> Hi all,
> 
> i just discovered this cute little feature, but had three
> minor issues while experimenting with it on 2.6.16-rc6:
> 
> 1.
> Semantics of LOCALVERSION are confusing and probably buggy.
> The Makefile states:
> 
> # Take the contents of any files called localversion* and the config
> # variable CONFIG_LOCALVERSION and append them to KERNELRELEASE.
> # LOCALVERSION from the command line override all of this
> 
> whereas my simplified view of current code is:
> 
> version = major + minor + patch + extra
> release = version + localver-full
> localver-full = localver + localver-auto
> localver = <concat all localversions*> + $CONFIG_LOCALVERSION
> localver-auto = $LOCALVERSION + <some -gxxxxxx>
> 
> LOCALVERSION does not seem to /override/ anything if specified on the
> command line, but rather (with CONFIG_LOCALVERSION_AUTO=y) gets
> /inserted/.
> 
> Also, with CONFIG_LOCALVERSION_AUTO=n, specifying LOCALVERSION
> on the command line currently does nothing at all. This is a regression
> from 2.6.15, I suppose.
This is a bug.
I will fix that for 2.6.17.


> 2.
> "make kernelrelease" does not imply "make .kernelrelease", it only
> does cat the file .kernelrelease (or shows an error if it's not there).
> 
> This leads to the following IMHO slightly irritating behaviour
> $ echo "LV1" > localversion
> $ make kernelrelease
> 2.6.16-rc6LV1
> $ echo "LV2" > localversion
> $ make kernelrelease
> 2.6.16-rc6LV1
> 
> Is there a reason for this?
make kernelrelase shall work in both a read-only environment and shall
avoid modifying files when run as another user.
So the simple measure was to error out only if .kernelrelease was
missing.

The trick here seems to print $(KERNELVERSION)$(localver-full)
but only if .kernelrelease is present.
On the other hand if .kernelrelase and $(KERNELVERSION)$(localver-full)
differ then what to print.
The kernelrelease of the kernel or how it is configured?

echo -sam > locelversion does NOT change the kernel.
The kernelrealse of the kernel is only changed after running 'make'.
And this is what we want to see - the kernelrelase of the kernel, not
what happes to be stored in a file after the kernel was compiled.

> 
> 3.
> The help of CONFIG_LOCALVERSION_AUTO reads:
> 
> Note: This requires Perl, and a git repository, but not necessarily
> the git or cogito tools to be installed.
> 
> Looking at scripts/setlocalversion, this does not seem to be correct
> anymore.

Thanks. Will be fixed.

	Sam
