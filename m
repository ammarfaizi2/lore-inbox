Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWH0I6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWH0I6V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 04:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWH0I6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 04:58:21 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:40359 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751344AbWH0I6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 04:58:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=cuurN5Ep0cadMuGNrGYLaQtMFIvUeZPBP2dXWlWKIAFjAFnMtkf3O6PzPXbx7NdMUT306OHCXKk+suQV5PVizj6bugf978zIWkj/7x8NKmy4CcucMIdO+rdsj9eR3BwGKFG4Lh5R/PovnsOFiZArWQ/ZeRrD2mu6fPjGcSqQrn0=  ;
Message-ID: <44F15E88.2090509@yahoo.com.au>
Date: Sun, 27 Aug 2006 18:57:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dipankar@in.ibm.com, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, ego@in.ibm.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, arjan@intel.linux.com, mingo@elte.hu,
       vatsa@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
References: <20060824102618.GA2395@in.ibm.com>	<20060824091704.cae2933c.akpm@osdl.org>	<20060825095008.GC22293@redhat.com>	<Pine.LNX.4.64.0608261404350.11811@g5.osdl.org>	<20060826150422.a1d492a7.akpm@osdl.org>	<20060827061155.GC22565@in.ibm.com>	<20060826234618.b9b2535a.akpm@osdl.org>	<20060827071116.GD22565@in.ibm.com> <20060827004213.4479e0df.akpm@osdl.org>
In-Reply-To: <20060827004213.4479e0df.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sun, 27 Aug 2006 12:41:16 +0530
> Dipankar Sarma <dipankar@in.ibm.com> wrote:

>>Is this too difficult for people to follow ?
> 
> 
> Apparently.  What's happening is that lock_cpu_hotplug() is seen as some
> amazing thing which will prevent an *event* from occurring.

It prevents the event from occurring as much as a lock taken in the
prepare notifier does, right? Or am I misunderstanding something?

> 
> There's an old saying "lock data, not code".  What data is being locked
> here?  It's the subsystem's per-cpu resources which we want to lock.  We
> shouldn't consider the lock as being some way of preventing an event from
> happening.

I agree. Where possible these things should be very simple either with
the per-cpu macros, or using local locking (versus one's notifier).

I think there can be some valid use of the hotplug lock when working
with cpumasks rather than individual CPUs (or if you simply want to
prevent a cpu from going down while programming hardware) and having a
new lock and new notifier is too heavyweight. Or do we want to move
away from the hotplug lock completely?

Hmm, so I don't know if I like the idea of a reentrant rwmutex for the
hotplug lock so it can be sprinkled everywhere... call it a refcount
or not it smells slightly BKLish (looks easy but it could be a
nightmare to audit).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
