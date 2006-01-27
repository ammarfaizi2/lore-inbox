Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWA0VHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWA0VHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 16:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWA0VHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 16:07:25 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:29455 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932500AbWA0VHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 16:07:25 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <hyc@symas.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Date: Fri, 27 Jan 2006 13:05:46 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEHJJLAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <43DA7ED9.4090802@symas.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 27 Jan 2006 13:02:30 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 27 Jan 2006 13:03:58 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> David Schwartz wrote:
> > 	We don't agree on what the specification says.
> >
> >
> >> Why do you suppose that is?
> >>
> >
> > 	Why do I suppose what? I find the specification perfectly
> clear and your
> > reading of it incredibly strained for the three reasons I stated.
> >

> Oddly enough, you said
> http://groups.google.com/group/comp.programming.threads/msg/28b58e
> 91886a3602?hl=en&
> "Unfortunately, it sounds reasonable"  so I can't lend credence to your
> stating that my reading is incredibly strained. The fact that
> LinuxThreads historically adhered to my reading of it lends more weight
> to my argument. The fact that people accepted this interpretation for so
> many years lends further weight. In light of this, it is your current
> interpretation that is incredibly strained, and I would say, broken.

	After collecting other opinions from comp.programming.threads, and being
unable to find other people who considered it reasonable, I've changed my
opinion. I was far too generous and deferential before.

	The more I consider it, the more absurd I find it. POSIX and SuS were so
careful not to dictate scheduler policy (or even hint at any notion of
fairness) that to argue that they intended to prohibit a thread from
releasing and reacquiring a mutex while another thread was blocked on it is
not tenable.

	You are essentially arguing that they intended to prohibit the most natural
and highest performing implementation. This is totally inconsistent with
POSIX's overall design intention to provide the lightest and
highest-performing primitives and allow users to add features with overhead
if they needed those features and could tolerate the overhead.

> You have essentially created a tri-state mutex. (Locked, unlocked, and
> sort-of-unlocked-but-really-reserved.) That may be a good and useful
> thing in its own right, but it should not be the default behavior.

	Huh?

	I'm suggesting the most natural implementation: When a thread tries to
acquire a mutex, it is blocked if a higher-priority thread is already
waiting for a mutex. When a thread releases a mutex, the highest-priority
thread waiting for the mutex is woken (but not necessarily guaranteed the
mutex, the mutex is simply marked available). When a thread tries to acquire
a mutex, it gets it unless a higher-priority thread is already registered as
wanting it. When a thread tries to acquire a mutex, it loops until it
acquires it and on each iteration blocks if the mutex is taken or a
higher-priority thread is waiting for it, otherwise it takes the mutex.

	A thread that is descheduled should never get priority over a thread that
is already running (unless a scheduling priority mechanism requires it).

	DS


