Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbUK3Or7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbUK3Or7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 09:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbUK3Or6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 09:47:58 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:65436 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262095AbUK3Or4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 09:47:56 -0500
Subject: Re: [RFC] relinquish_fs() syscall
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041130141204.GE63669@gaz.sfgoth.com>
References: <20041129114331.GA33900@gaz.sfgoth.com>
	 <1101729087.20223.14.camel@localhost.localdomain>
	 <20041129135559.GC33900@gaz.sfgoth.com>
	 <1101741440.20225.22.camel@localhost.localdomain>
	 <20041130132744.GB63669@gaz.sfgoth.com>
	 <1101822273.2640.52.camel@laptop.fenrus.org>
	 <20041130141204.GE63669@gaz.sfgoth.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101822206.25617.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 13:43:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-30 at 14:12, Mitchell Blank Jr wrote:
> > iirc there are anonymous unix sockets...
> 
> Ah, I see now -- the sun_path[0]=='\0' code.  I'll have to take a look
> at that; probably just need to add a check to prevent jailed processes
> from using those sockets (since they're supposed to be in a "null"
> namespace)  Will investigate later this week.

You would probably want a "private" AF_UNIX namespace too. The fact its
a single namespace for "anonymous" AF_UNIX and the \0 trick is used is
really legacy unix compatibility. Having multiple such namespaces is
certainly
doable. It's the same problem as the shared memory, semaphore and
message
queue objects have because they fall out of the filesystem namespace.
Posix
has fixed these but very few apps use the new forms.

> 
> It looks like this is also a weakness in code that currently uses
> chroot("/var/empty")  It's not the end of the world since it still
> requires a cooperating unjailed process on the same host as the jailed
> one to pass in a fd which is quite an obstacle in most scenarios.  Still,
> it's something that should be protected against.

Also you need to look at fchdir(). If I accidentally pass you a file
handle to a directory (or maybe to a file in reiser4 world ?) you can
fchdir() out of the chroot.

Alan

