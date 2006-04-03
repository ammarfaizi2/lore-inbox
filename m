Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWDCXcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWDCXcz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 19:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWDCXcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:32:55 -0400
Received: from mx1.suse.de ([195.135.220.2]:13791 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964946AbWDCXcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:32:54 -0400
From: Neil Brown <neilb@suse.de>
To: Mike Hearn <mike@plan99.net>
Date: Tue, 4 Apr 2006 09:30:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17457.45106.775055.392371@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add a /proc/self/exedir link
In-Reply-To: message from Mike Hearn on Tuesday April 4
References: <4431A93A.2010702@plan99.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday April 4, mike@plan99.net wrote:
> 
> To clarify, I'm proposing this patch for eventual mainline inclusion.
> 
> It adds a simple bit of API - a symlink in /proc/pid - which makes it 
> easy to build relocatable software:
> 
>    ./configure --prefix=/proc/self/exedir/..
> 
> This is useful for a variety of purposes:
> 
> * Distributing programs that are runnable from CD or USB key (useful for
>    Linux magazine cover disks)
> 
> * Binary packages that can be installed anywhere, for instance, to your
>    home directory
> 
> * Network admins can more easily place programs on network mounts
> 
> I'm sure you can think of others. You can patch software to be 
> relocatable today, but it's awkward and error prone. A simple patch can 
> allow us to get it "for free" on any UNIX software that uses the 
> idiomatic autotools build system.
> 
> So .... does anybody have any objections to this? Would you like to see 
> it go in? Speak now or forever hold your peace! :)

It strikes me that this is very fragile.  If the application calls
anything out of /bin or /usr/bin etc passing a path name which works
for the application, it will break for the helper.
It also requires all binaries use by the application to live in the
same directory.  This would be OK  for some applications, but not for
everything.

It sounds to me like you want a private, inherited, name space, and
Linux provides those via CLONE_NEWNS, however you probably need root
access to make that work, which isn't ideal.

I think you'd have move luck (ab)using an environment variable.
Make
   /proc/self/env_prefix
be a symlink pointing to whatever the "PREFIX" environment variable
stores.
Then you just need a little shell wrapper around the app with
something like
   path=`readlink /proc/$$/fd/255`
   export PREFIX=`dirname $path`
   exec $PREFIX/$APPLICATION

and build the application with
   ./configure --prefix=/proc/self/env_prefix

I'm not saying this is a "nice" solution, but I think it is no worse
than /proc/self/exedir/, and it should be more robust.

NeilBrown
