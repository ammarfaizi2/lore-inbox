Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262948AbVD2UoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbVD2UoO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbVD2UoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:44:04 -0400
Received: from pat.uio.no ([129.240.130.16]:55427 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262963AbVD2Umy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:42:54 -0400
Subject: Re: which ioctls matter across filesystems
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Robert Love <rml@novell.com>
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1114805033.6682.150.camel@betsy>
References: <42728964.8000501@austin.rr.com>
	 <1114804426.12692.49.camel@lade.trondhjem.org>
	 <1114805033.6682.150.camel@betsy>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 16:42:40 -0400
Message-Id: <1114807360.12692.77.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.506, required 12,
	autolearn=disabled, AWL 1.49, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 29.04.2005 Klokka 16:03 (-0400) skreiv Robert Love:
> On Fri, 2005-04-29 at 15:53 -0400, Trond Myklebust wrote:
> 
> > We are discussing the equivalent of dnotify as a potential candidate for
> > the first minor version of NFSv4, but not inotify.
> > The purpose of our dnotify implementation is address the needs of things
> > like file browsers that don't really care about synchronous notification
> > of changes, but that do currently cause a lot of unnecessary traffic on
> > the wire due to constantly polling stat() and doing readdir() updates.
> > The jury is still out as to whether or not the callbacks actually do
> > reduce on-the-wire traffic, though, so we may drop it.
> 
> What about inotify makes it insufficient for your needs?

Nothing, if you are just tracking changes that are made by local
processes.

For remote filesystems like CIFS and NFS, however, there may be
applications that want to monitor changes that are made directly on the
server by other clients. In the above paragraph, I'm therefore referring
to a debate about whether or not adding officially sanctioned NFSv4
protocol support for something like dnotify/inotify makes sense.

The problem is that having the server call back a bunch of clients every
time a file changes does not really scale too well. The current
dnotify-like proposal therefore specifies that notification is not
synchronous (i.e. there may be a delay of several seconds), and that the
server may want to group several notifications into a single callback.
(if interested, you can view the current proposal on
http://www.ietf.org/internet-drafts/draft-ietf-nfsv4-directory-delegation-01.txt)


> > What kind of real-world applications exist out there that need inotify
> > functionality, and what sort of requirements do they have (in particular
> > w.r.t. the notification mechanism)?
> 
> A few worksets:
> 
> 	- Current users, such as FAM and Samba, that need simple file
> 	  change notification
> 	- Random applications that want to watch a file or two
> 	- The Linux desktop
> 	- Real-time live-updating indexing systems, such as Beagle,
> 	  that compete with f.e. Apple's Spotlight.

Right, but I assume that most of the use-cases (with possible exception
of FAM) do not really involve tracking changes made by other NFS
clients. Although I imagine in particular that the real-time indexing
system workload trying to run on several clients and tracking the same
files at the same time might be a lot of fun...

I'm therefore asking whether or not there is a killer-app out there that
we need to support and that does want to track changes made by other
clients. File browsers are more or less the only thing that come to
mind.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

