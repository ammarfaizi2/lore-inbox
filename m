Return-Path: <linux-kernel-owner+w=401wt.eu-S1161421AbWLPUFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161421AbWLPUFL (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 15:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161455AbWLPUFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 15:05:10 -0500
Received: from shards.monkeyblade.net ([192.83.249.58]:51342 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161421AbWLPUFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 15:05:09 -0500
X-Greylist: delayed 2015 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 15:05:08 EST
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
From: "J.H." <warthog9@kernel.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, hpa@zytor.com,
       webmaster@kernel.org
In-Reply-To: <458434B0.4090506@oracle.com>
References: <20061214223718.GA3816@elf.ucw.cz>
	 <20061216094421.416a271e.randy.dunlap@oracle.com>
	 <20061216095702.3e6f1d1f.akpm@osdl.org>  <458434B0.4090506@oracle.com>
Content-Type: text/plain
Date: Sat, 16 Dec 2006 11:30:34 -0800
Message-Id: <1166297434.26330.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem has been hashed over quite a bit recently, and I would be
curious what you would consider the real problem after you see the
situation.

The root cause boils down to with git, gitweb and the normal mirroring
on the frontend machines our basic working set no longer stays resident
in memory, which is forcing more and more to actively go to disk causing
a much higher I/O load.  You have the added problem that one of the
frontend machines is getting hit harder than the other due to several
factors: various DNS servers not round robining, people explicitly
hitting [git|mirrors|www|etc]1 instead of 2 for whatever reason and
probably several other factors we aren't aware of.  This has caused the
average load on that machine to hover around 150-200 and if for whatever
reason we have to take one of the machines down the load on the
remaining machine will skyrocket to 2000+.  

Since it's apparent not everyone is aware of what we are doing, I'll
mention briefly some of the bigger points.

- We have contacted HP to see if we can get additional hardware, mind
you though this is a long term solution and will take time, but if our
request is approved it will double the number of machines kernel.org
runs.

- Gitweb is causing us no end of headache, there are (known to me
anyway) two different things happening on that.  I am looking at Jeff
Garzik's suggested caching mechanism as a temporary stop-gap, with an
eye more on doing a rather heavy re-write of gitweb itself to include
semi-intelligent caching.  I've already started in on the later - and I
just about have the caching layer put in.  But this is still at least a
week out before we could even remotely consider deploying it.

- We've cut back on the number of ftp and rsync users to the machines.
Basically we are cutting back where we can in an attempt to keep the
load from spiraling out of control, this helped a bit when we recently
had to take one of the machines down and instead of loads spiking into
the 2000+ range we peaked at about 500-600 I believe.

So we know the problem is there, and we are working on it - we are
getting e-mails about it if not daily than every other day or so.  If
there are suggestions we are willing to hear them - but the general
feeling with the admins is that we are probably hitting the biggest
problems already.

- John 'Warthog9' Hawley
Kernel.org Admin

On Sat, 2006-12-16 at 10:02 -0800, Randy Dunlap wrote:
> Andrew Morton wrote:
> > On Sat, 16 Dec 2006 09:44:21 -0800
> > Randy Dunlap <randy.dunlap@oracle.com> wrote:
> > 
> >> On Thu, 14 Dec 2006 23:37:18 +0100 Pavel Machek wrote:
> >>
> >>> Hi!
> >>>
> >>> pavel@amd:/data/pavel$ finger @www.kernel.org
> >>> [zeus-pub.kernel.org]
> >>> ...
> >>> The latest -mm patch to the stable Linux kernels is: 2.6.19-rc6-mm2
> >>> pavel@amd:/data/pavel$ head /data/l/linux-mm/Makefile
> >>> VERSION = 2
> >>> PATCHLEVEL = 6
> >>> SUBLEVEL = 19
> >>> EXTRAVERSION = -mm1
> >>> ...
> >>> pavel@amd:/data/pavel$
> >>>
> >>> AFAICT 2.6.19-mm1 is newer than 2.6.19-rc6-mm2, but kernel.org does
> >>> not understand that.
> >> Still true (not listed) for 2.6.20-rc1-mm1  :(
> >>
> >> Could someone explain what the problem is and what it would
> >> take to correct it?
> > 
> > 2.6.20-rc1-mm1 still hasn't propagated out to the servers (it's been 36
> > hours).  Presumably the front page non-update is a consequence of that.
> 
> Agreed on the latter part.  Can someone address the real problem???
> 

