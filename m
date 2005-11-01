Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbVKAABi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVKAABi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 19:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbVKAABi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 19:01:38 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:10917 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964905AbVKAABh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 19:01:37 -0500
Subject: Re: /etc/mtab and per-process namespaces
From: Ram Pai <linuxram@us.ibm.com>
To: Rob Landley <rob@landley.net>
Cc: greg@enjellic.com, Mike Waychison <mikew@google.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, leimy2k@gmail.com
In-Reply-To: <200510311727.27145.rob@landley.net>
References: <200510221323.j9MDNimA009898@wind.enjellic.com>
	 <200510290516.37700.rob@landley.net> <1130785899.4773.19.camel@localhost>
	 <200510311727.27145.rob@landley.net>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1130803283.4773.40.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 31 Oct 2005 16:01:23 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-31 at 15:27, Rob Landley wrote:
> On Monday 31 October 2005 13:11, Ram Pai wrote:
> > > The big thing I've never figured out how to do is make umount -a work in
> > > the presence of multiple namespaces.  (Should it just umount what it
> > > sees?  I don't know how to umount everything because I can't find
> > > everything...)
> >
> > Yes you won't find everything, since some of them are in a different
> > namespaces. Instead unmount whatever you see.  Or use /proc/mounts
> > to unmount whatever is there in its namespace.
> 
> But /proc/mounts is a symlink to self/mounts, and self is a symlink to $PID, 
> so after burrowing through the symlinks you wind up looking 
> at /proc/$PID/mounts.
> 
> My concern is that if I have init, as root, try to perform a umount -a, it 
> _still_ won't get the mounts belonging to child processes with a separate 
> namespace.  There's no "global view" of mounts available anywhere.

and having a "global view" is a debatable issue. What you are asking for
is a way for a process to be able to access all the mounts irrespective
of which namespace it belongs to. 

I think 'umount -a' semantics has to be refined and made as 'unmount all
the mounts belonging its namespace'. And if you agree with the
semantics, than unmouting whatever is found in /proc/mounts would
suffice.


> 
> On the other hand, if we fork a child process with its own namespace, the 
> child performs a private mount, and then we kill that child process, does 
> that hidden mount get umounted cleanly via refcounting?  (Or does it leak?)  

yes all the mounts in the namespace will get cleaned up if no processes
have access to that namespace.

> 
> If killing the processes umounts their private mounts, all init has to do is 
> make sure all child processes are dead before doing a umount -a on what's 
> left.  (Then, of course, there's FUSE.  Does killing the FUSE helper prevent 
> the mount from being umounted?)

Again as I said above, 'umount -a' has just to restrict itself to its
own namespace.

RP
> 
> It's a bit conceptually persnickety, so far...
> 
> Rob

