Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVJ2KRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVJ2KRn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 06:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbVJ2KRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 06:17:43 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:63415
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750914AbVJ2KRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 06:17:42 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: /etc/mtab and per-process namespaces
Date: Sat, 29 Oct 2005 05:16:35 -0500
User-Agent: KMail/1.8
Cc: greg@enjellic.com, Mike Waychison <mikew@google.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, leimy2k@gmail.com
References: <200510221323.j9MDNimA009898@wind.enjellic.com> <1130544418.4902.47.camel@localhost>
In-Reply-To: <1130544418.4902.47.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510290516.37700.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 19:06, Ram Pai wrote:

> > Mike's comments are very apt.  The current situation with mount
> > support is untenable.  Even working on private development machines it
> > gets confusing as to what is or is not mounted in various
> > shells/processes.  The basic infra-structure is there with process
> > specific mount information (/proc/self/mounts) but mount and friends
> > are a bit problematic with respect to supporting this.

I fairly extensively rewrote busybox mount, and one of my goals was doing the 
best job with /proc/mounts (only) support that I could.  In some ways, 
busybox's mount is better (such as the fact it can autodetect when you're 
trying to mount a file and figure out it needs -o loop without being told).

If you want try the busybox version of mount/losetup/umount, I hope it does 
what you want and am willing to fix it if it doesn't.  (P.S.  To 
use /proc/mounts either configure it without /etc/mtab support or 
symlink /etc/mtab to /proc/mounts.)

> > I'm working on a namespace toolkit to address these issues.  I've got
> > a pretty basic tool, similar to sudo, which allows spawning processes
> > with a protected namespace.  I'm adding a configuration system which
> > allow systems administrators to define a setup of bind mounts which
> > are automatically executed before the user is given their shell.  I'm
> > also working up a PAM account module to go along with this.  I would
> > certainly be open to suggestions as to what else people would consider
> > useful in such a toolkit.
> >
> > I've been pondering the best way to take on the mount problem.
> > Current mount binaries seem to fall back to /proc/mounts if /etc/mtab
> > is not present.  All bets are off of course if the mount binary is
> > used for the bind mount since a new /etc/mtab is created.

Have you tried having /etc/mtab be a symlink to /proc/mounts?

> > I'm willing to whack on the mount binary a bit as part of this.  The
> > obvious solution is to teach mount to act differently if it is running
> > in a private namespace.  If anybody knows of a good way to detect this
> > I would be interested in knowing that.  In newns (the namespace sudo
> > tool) I'm setting an environment variable for mount to detect on but a
> > system level approach would be more generic.
>
> actually there is a hackish way for a process to figure out if it is  in
> a different namespace than the system namespace.
>
> ls /proc/1/root
>
> in a system namespace it will allow you to see the content.
> And in a per-process-namespace it will fail with permission denied.
>
> But I think we should figure out a cleaner way to decipher this,
> and that would start with clearly defining the requirements, I think.

The big thing I've never figured out how to do is make umount -a work in the 
presence of multiple namespaces.  (Should it just umount what it sees?  I 
don't know how to umount everything because I can't find everything...)

> RP

Rob
