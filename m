Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVBXCFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVBXCFN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVBXCFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:05:13 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:32205 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S261751AbVBXCE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:04:58 -0500
Date: Thu, 24 Feb 2005 03:05:38 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: linux-os <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org, theant@nodivisions.com
Subject: Re: uninterruptible sleep lockups
In-Reply-To: <Pine.LNX.4.61.0502230815380.5548@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0502240127500.14927@be1.lrz>
References: <fa.duv6ag6.p5mth0@ifi.uio.no> <fa.irk349q.1c3si2o@ifi.uio.no>
 <E1D3ksD-0001NH-MI@be1.7eggert.dyndns.org> <Pine.LNX.4.61.0502230815380.5548@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005, linux-os wrote:
> On Wed, 23 Feb 2005, Bodo Eggert wrote:
> > linux-os <linux-os@analogic.com> wrote:

> >> You don't seem to understand. A process that's stuck in 'D' state
> >> shows a SEVERE error, usually with a hardware driver.
> >
> > Or a network filesystem mount to a no longer existing server or share.
> 
> But that's a whole different problem. That's a systemic problem
> of "fail-over". Network file-systems really need to interface
> with an intermediate virtual device that can isolate failed
> systems and make them look "perfect" to individual machines.
> 
> If you don't do this, then as soon as somebody trips over a
> wire, your database is trashed. I'm surprised that NFS, PCNFS,
> SMB, etc., actually work as well as everybody seems to
> think they do. Until the architectural problem is resolved,
> there are still going to be hung processes, trashed databases,
> etc.

You don't run databases over a network filesystem unless you're begging
for trouble. For the other common purposes you'll usurally get a more
stable behaviour, since the failure on the client won't prevent the server
from properly writing the metadata or flushing the cache.

> > How to clean up the stuck processes: (This requires a MMU)
> > Add an error path to each syscall (or create some generic error paths) and
> > keep the original stack frame. On errors, you can "longjump" (not exactly,
> > but similar) to the error path after copying the memory. The semaphore will
> > not be taken, and the code depending on the semaphore will not be executed.
> >
> 
> Again, you are attacking the symptom. The problem could be resolved
> by using a local disk (or a disk file) for the immediate I/O and
> the I/O to the file-servers could occur whenever they are available.

a) There are systems without local storage.

b) It won't help while stat()ing a non-cached object.

c) This would involve race conditions for e.g. two disconnected nodes on
   reconnect. AFAI can see, this race can be solved by:
 c1) The final transaction must be delayed until it's ACKed or 
     NACKed. This may delay the D-State for some seconds, but not enough.
 c2) The server will have to keep track of the clients and need to be told
     when a user left for a trip to the south pole without unmounting. 
     Very undesirable.
 c3) Ignoring. Very, very undesireable.
 c4) Requiring explicit transaction handling by the applications.  
     Interesting, but not in the near future.

d) This won't allow synchronous updates without falling back to classic 
   handling.

e) The users will update some files, get a positive reply and shut down
   their PCs before the changes can be commited to the server. If the
   server will not come back or the client is not rebooted within
   reasonable time, this will cause silent data loss.

f) This will require reliable identification of the network server.

g) I'm not only thinking of NFS/..., allthough I used it as _the_ example. 
   E.g. if you see your IDE drive failing, you'll want to declare it dead
   instead of waiting $num_of_sectors times five minutes until the kernel
   decides to give up.


I agree that most D-states are problems that need to be fixed instead of
being worked-around, but sometimes you can't fix the problem without
access to the crystal-ball-device. Therefore all devices that can block
will need a manual override (with different probability), and the
processes that were stuck will need a way to recover or be stuck forever.

Obvoiusly the system is healthy enough to do some important and
uninterruptible work after those errors occured, so having them stuck will
be OK for now. Instead, the next task might be freeing the file
descriptors preventing you from unmounting your removable media or network
share or allowing really-forced umount.

-- 
Top 100 things you don't want the sysadmin to say:
54. Uh huh......"nu -k $USER".. no problem....sure thing...
