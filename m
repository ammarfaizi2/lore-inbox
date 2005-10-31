Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbVJaX14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbVJaX14 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 18:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVJaX14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 18:27:56 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:11741
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750981AbVJaX1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 18:27:55 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Ram Pai <linuxram@us.ibm.com>
Subject: Re: /etc/mtab and per-process namespaces
Date: Mon, 31 Oct 2005 17:27:26 -0600
User-Agent: KMail/1.8
Cc: greg@enjellic.com, Mike Waychison <mikew@google.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, leimy2k@gmail.com
References: <200510221323.j9MDNimA009898@wind.enjellic.com> <200510290516.37700.rob@landley.net> <1130785899.4773.19.camel@localhost>
In-Reply-To: <1130785899.4773.19.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510311727.27145.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 13:11, Ram Pai wrote:
> > The big thing I've never figured out how to do is make umount -a work in
> > the presence of multiple namespaces.  (Should it just umount what it
> > sees?  I don't know how to umount everything because I can't find
> > everything...)
>
> Yes you won't find everything, since some of them are in a different
> namespaces. Instead unmount whatever you see.  Or use /proc/mounts
> to unmount whatever is there in its namespace.

But /proc/mounts is a symlink to self/mounts, and self is a symlink to $PID, 
so after burrowing through the symlinks you wind up looking 
at /proc/$PID/mounts.

My concern is that if I have init, as root, try to perform a umount -a, it 
_still_ won't get the mounts belonging to child processes with a separate 
namespace.  There's no "global view" of mounts available anywhere.

On the other hand, if we fork a child process with its own namespace, the 
child performs a private mount, and then we kill that child process, does 
that hidden mount get umounted cleanly via refcounting?  (Or does it leak?)  

If killing the processes umounts their private mounts, all init has to do is 
make sure all child processes are dead before doing a umount -a on what's 
left.  (Then, of course, there's FUSE.  Does killing the FUSE helper prevent 
the mount from being umounted?)

It's a bit conceptually persnickety, so far...

Rob
