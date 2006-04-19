Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWDSWS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWDSWS2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 18:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWDSWS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 18:18:28 -0400
Received: from snowski.convera.com ([67.133.116.244]:64130 "EHLO
	cbmail.convera.com") by vger.kernel.org with ESMTP id S1751076AbWDSWS1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 18:18:27 -0400
Message-ID: <4446B756.7080102@chocky.org>
Date: Wed, 19 Apr 2006 15:19:02 -0700
From: Peter Naulls <peter@chocky.org>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>  <20060419200001.fe2385f4.diegocg@gmail.com>  <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org> <1145481827.8440.30.camel@lade.trondhjem.org> <Pine.LNX.4.64.0604191433390.3701@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604191433390.3701@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Apr 2006 22:18:26.0240 (UTC) FILETIME=[2DC60400:01C663FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 19 Apr 2006, Trond Myklebust wrote:
>> Any chance this could be adapted to work with all those DMA (and RDMA)
>> engines that litter our motherboards? I'm thinking in particular of
>> stuff like the drm drivers, and userspace rdma.
> 
> Absolutely. Especially with "vmsplice()" (the not-yet-implemented "move 
> these user pages into a kernel buffer") it should be entirely possible to 
> set up an efficient zero-copy setup that does NOT have any of the problems 
> with aio and TLB shootdown etc.
> 
> Note that a driver would have to support the splice_in() and splice_out() 
> interfaces (which are basically just given the pipe buffers to do with as 
> they wish), and perhaps more importantly: note that you need specialized 
> apps that actually use splice() to do this.
> 
> That's the biggest downside by far, and is why I'm not 100% convinced 
> splice() usage will be all that wide-spread. If you look at sendfile(), 
> it's been available for a long time, and is actually even almost portable 
> across different OS's _and_ it is easy to use. But almost nobody actually 
> does. I suspect the only users are some apache mods, perhaps a ftp deamon 
> or two, and probably samba. And that's probably largely it.

I am.  I'm developing a distributed file system responsible for
transferring GBs of files around a network.  The biggest problem here
with the traditional send/recv/poll that was in use was heavy duty
CPU usage.  Maxing out the gigabit network eats about 60% CPU.  In
some simple experiments, sendfile reduced that to 10% or less 
(depending, there's a lot of variation in stuff that goes on).

One big problem I had is that sendfile is not symmetric (for quite
understable reasons), but that meant the overlying file system API
(it's a userspace library) has to undergo various changes to make
effective use of sendfile.  Doing so in a sensible manner proved
tricky, but not impossible

Anyway, CPU usage is still a big deal, which is why I'm interested
in these new zero-copy calls I've just caught up on the discussion
about.  And if I decide to use them, that means moving a whole
load of machines to 2.6.17 - some of which will be running 2.6.12
for at least a little while longer.  I guess I might be asking
for the opposite of this:

> So I'd expect this to be most useful for perhaps things like some HPC 
> apps, where you can have specialized libraries for data communication. And 
> servers, of course (but they might just continue to use the old 
> "sendfile()" interface, without even knowing that it's not sendfile() any 
> more, but just a wrapper around splice()).

i.e, a splice emulation, that happens to use sendfile when it can.

I very much appreciate the conceptual improvements that splice has
over sendfile, but can anyone give some examples significant CPU
savings that would not be possible using sendfile?









