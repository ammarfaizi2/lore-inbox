Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756330AbWKROlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756330AbWKROlP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 09:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756331AbWKROlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 09:41:15 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:61422 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1756329AbWKROlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 09:41:14 -0500
From: Christian <christiand59@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Sluggish system responsiveness on I/O
Date: Sat, 18 Nov 2006 15:40:47 +0100
User-Agent: KMail/1.9.5
References: <200611181412.29144.christiand59@web.de> <200611181425.17024.prakash@punnoor.de>
In-Reply-To: <200611181425.17024.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611181540.47563.christiand59@web.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:176b6e6b41629db5898eee8167b5e3a0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 18. November 2006 14:25 schrieb Prakash Punnoor:
> Am Samstag 18 November 2006 14:12 schrieb Christian:
> > So I tried to nice the make and see what happens:
> >
> > nice 5 make -j4: Seems to make no difference. Heavy stuttering in
> > glxgears and et
> > nice 10 make -j4: Somewhat better but still unusable with et
> >
> > everything above nice 15 is usable. nice 19 has full interactivity, that
> > means you can't make out a difference between no load and kernel compile
> > while playing enemy-territory.
> >
> > I suspect that it has something to do with the priority boost for I/O
> > hogs. But if this is a "general" scheduler problem, then why aren't more
> > people complaining about this?
>
> I complained about this a year ago, but not much has changed. :-( It gets
> esp bad if you copy GB size files (the writes are the problemmakers, less
> the reads) - no matter which io scheduler I use, though using deadline
> seems to lessen the impact a little bit. And I don't find it acceptable to
> have to play around with nice to get a responsible desktop, esp when one is
> using a GUI.
>
> Cheers,

Ah yes, you put me on the right track! So we can say that we are actually 
talking about two different classes of problems here.

The first class is process scheduler related. An I/O intensive process which 
is CPU intensive at the same time gets such a high priority boost, that it 
harms multimedia interactivity. This leads to short interruptions 
("stuttering") in multimedia apps eg. glxgears.

The second problem is (CFQ) I/O scheduler related. Multiple readers get a 
fairly nice sharing of I/O bandwidth but as soon as you introduce a single 
writer, this writer harms the readers very much.

The first problem can be mitigated by using nice. Since that is why we have 
nice at all. You can also use another scheduling class like SCHED_BATCH.

The second problem is much more pressuring for the average desktop user.
While multiple readers are running, you click on the kmenu and it loads slower 
than normal. This is what you expect from sharing bandwidth with same I/O 
nice level processes. The I/O bandwidth is shared equally. If you want a fast 
desktop renice the streaming readers with ionice. Distros could also ionice 
the desktop processes like kicker with a low nice level. The real problem for 
desktop "interactivity" is when you are running streaming writers and then 
trigger short reads eg. with the kmenu. It happens that the read request gets 
starved for about a minute(!!) or even more. 

Some use-cases:
glxgears with heavy read I/O: no problems
glxgears with heavy write I/O: no problems

glxgears with a "read,compute" load: stuttering due to priority boost

kmenu with several readers: slightly slower, equally shared bandwith. Ability 
to use ionice
kmenu with several writers: unusable

So I think the major problem here is the starvation of short reads while 
running multiple streaming writers. That deffinitely needs to be adressed. 
This would be the last real problem that I see with a fully maxed out Linux 
machine. Linux now has one of the best process and I/O schedulers I have ever 
seen. Thanks to the great work of Jens Axboe and all the other nice people. 
If this last wart would be attacked than I would consider Linux for total 
World domination ;-)

-Christian
