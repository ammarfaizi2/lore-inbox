Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263748AbUCXPk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 10:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbUCXPk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 10:40:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33958 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263748AbUCXPkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 10:40:25 -0500
Subject: Re: [RFC,PATCH] dnotify: enhance or replace?
From: Alexander Larsson <alexl@redhat.com>
To: rudi@lambda-computing.de
Cc: linux-kernel@vger.kernel.org, ttb@tentacle.dhs.org, jamie@shareable.org,
       tridge@samba.org, viro@parcelfarce.linux.theplanet.co.uk,
       torvalds@osdl.org
In-Reply-To: <4061986E.6020208@gamemakers.de>
References: <4061986E.6020208@gamemakers.de>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1080142815.8108.90.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 24 Mar 2004 16:40:15 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-24 at 15:17, Rüdiger Klaehn wrote:
> Hi all,
> 
> I have been working on a dnotify enhancement to let it work recursively 
> and to store information about what exactly has changed.
> 
> My current code can be found here:
> <http://www.lambda-computing.com/~rudi/dnotify/>
> 
>  From reading the list, I got the impression that there is a general 
> consensus that the current dnotify mechanism is less than optimal, and 
> that something should be done about it. Is that correct?
> 
> My current implementation enhances the dnotify mechanism, but is 
> backwards compatible to the old mechanism. This is obviously the least 
> intrusive approach, but it is also less than optimal. For example it 
> still requires an open file handle to watch for changes in a tree, so it 
> will create problems when unmounting a device.
> 
> In an offline discussion, the issue came up wether it would not be 
> better to replace dnotify with a completely new mechanism like e.g. a 
> special netlink socket. Since most userspace programs (e.g. KDE and 
> gnome) do not use dnotify directly, but through the fam daemon, the 
> required changes in user space applications would not be that great.
> 
> So what is your take on this? Enhance or replace?
> 
> best regards,
> 
> Rüdiger
> 
> p.s.: I cc'ed everybody who I think might be interested in a dnotify 
> enhancement/replacement.

I think everyone agrees that dnotify is a POS that needs replacement,
however coming up with a good new API and implementation seems to be
hard (or at least uninteresting to kernel developers). 

I for sure would welcome a sane file change notification API, i.e. one
that doesn't require the use of signals. However, I don't really care
about recursive monitors, and I'm actually unsure if you really want the
DN_EXTENDED functionallity in the kernel. It seems like a great way to
make the kernel use a lot of unswappable memory, unless you limit the
event queues, and if you do that you need to stat all files in userspace
anyway so you can correctly handle queue overflows.

I think the most important properties for a good dnotify replacement is:

* Don't use signals or any other global resource that makes it
impossible to use the API in a library thats supposed to be used by all
sorts of applications.

* Get sane semantics. i.e. if a hardlink changes notify a file change in
all directories the file is in. (This is hard though, it needs backlinks
from the inodes to the directories, at least for the directories with a
monitor, something i guess we don't have today.)

* Some way to get an event when the last open fd to the file is closed
after a file change. This means you won't get hundreds of write events
for a single file change. (Of course, you won't catch writes to e.g.
logs which aren't closed, so this has to be optional. But for a desktop,
this is often what you want.)

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Alexander Larsson                                            Red Hat, Inc 
                   alexl@redhat.com    alla@lysator.liu.se 
He's a time-tossed guerilla cowboy who knows the secret of the alien invasion. 
She's a cosmopolitan mutant mercenary living on borrowed time. They fight 
crime! 

