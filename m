Return-Path: <linux-kernel-owner+w=401wt.eu-S965233AbXAGWen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965233AbXAGWen (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 17:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbXAGWem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 17:34:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60905 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965233AbXAGWel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 17:34:41 -0500
Subject: Re: 2.6.20-rc3-git4 oops on suspend: __drain_pages
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Christoph Lameter <clameter@sgi.com>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <84144f020701070833i19cbb179md5426ca4b4be371c@mail.gmail.com>
References: <459DB116.9070805@shaw.ca>
	 <Pine.LNX.4.64.0701051114200.28395@schroedinger.engr.sgi.com>
	 <200701052036.10647.rjw@sisk.pl>
	 <84144f020701070833i19cbb179md5426ca4b4be371c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 07 Jan 2007 20:34:10 -0200
Message-Id: <1168209251.11528.34.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Dom, 2007-01-07 às 18:33 +0200, Pekka Enberg escreveu:
> On Thu, 4 Jan 2007, Robert Hancock wrote:
> > > > Saw this oops on 2.6.20-rc3-git4 when attempting to suspend. This only
> > > > happened in 1 of 3 attempts.
> 
> On Friday, 5 January 2007 20:15, Christoph Lameter wrote:
> > > See the fix that I posted yesterday to linux-mm. Its now in Andrew's tree.
> 
> On 1/5/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > I can't find it in -mm.
> >
> > Could you please post it here?
> 
> I think it's this:
> 
> http://marc.theaimsgroup.com/?l=linux-mm&m=116793590117896&w=2

This fixed for me too with kernel 2.6.19.1. On my machine, every second
trial to unplug the second CPU core were generating OOPS, and breaking
hibernation. I've opened a bugzilla (#7786).

There is a remain stuff to be fixed, related to cpuhotplug: kernel with
debug options enabled shows that there is a circular locking dependency
(http://bugzilla.kernel.org/attachment.cgi?id=10020&action=view):

 =======================================================
[ INFO: possible circular locking dependency detected ]
2.6.19.1 #1
-------------------------------------------------------
stress/5670 is trying to acquire lock:
 (cpu_bitmask_lock){--..}, at: [<ffffffff8015af7d>] lock_cpu_hotplug+0x6d/0x80

but task is already holding lock:
 (workqueue_mutex){--..}, at: [<ffffffff8014962f>] workqueue_cpu_callback+0x16f/0x2d0

which lock already depends on the new lock.

This happens the first time I do:

echo 0 >/sys/devices/system/cpu/cpu1/online

on an AMD/64 dual core.

It would be interesting to have this patch also applied to -stable.

Cheers, 
Mauro.

