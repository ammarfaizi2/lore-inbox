Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTISTHo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTISTHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:07:44 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:3968 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S261681AbTISTHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:07:42 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Rusty Russell <rusty@rustcorp.com.au>, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Make modules_install doesn't create /lib/modules/$version
Date: Fri, 19 Sep 2003 15:04:20 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20030919024455.834992C0F1@lists.samba.org>
In-Reply-To: <20030919024455.834992C0F1@lists.samba.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309191504.20535.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 September 2003 22:25, Rusty Russell wrote:
> In message <20030918091511.276309a6.rddunlap@osdl.org> you write:
> > On Thu, 18 Sep 2003 03:21:40 -0400 Rob Landley <rob@landley.net> wrote:
> > | I've installed -test3, -test4, and now -test5, and each time make
> > | modules_install died with the following error:
> > |
> > | Kernel: arch/i386/boot/bzImage is ready
> > | sh arch/i386/boot/install.sh 2.6.0-test5 arch/i386/boot/bzImage
> > | System.map "" /lib/modules/2.6.0-test5 is not a directory.
>
> Looks like arch/i386/boot/install.sh is calling ~/bin/installkernel or
> /sbin/installkernel, which is not creating the directory.
>
> Should depmod create the directory?  It can, of course, but AFAICT the
> old one didn't.
>
> Maybe a RedHat issue?
>
> Rusty.

Okay, I traced through all this.  The directory is never explicitly created; 
Red Hat's /sbin/installkernel calls /sbin/new-kernel-pkg, and deep in the 
bowels of that there's a call to depmod:

doDepmod() {
    [ -n "$verbose" ] && echo "running depmod for $version"
    depmod -ae -F /boot/System.map-$version $version
}

And I had the old depmod because rusty's modutils installed themselves in 
/usr/local/bin, and I fixed things up by hand (missing depmod).  I just did a 
reinstall of rusty's modutils with --prefix=/ and we'll see if that fixes 
things on the next kernel upgrade.

It's still kind of a nasty side effect if you ask me.  I thought depmod was 
run AFTER the modules were installed, not to create the directory for them to 
install into.  (My chances of figuring this one out on my own in a finite 
amount of time were pretty low.)

Rob

