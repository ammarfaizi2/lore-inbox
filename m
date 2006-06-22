Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161223AbWFVT5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbWFVT5W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161228AbWFVT5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:57:21 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:23962 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161223AbWFVT5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:57:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=PXMO7ycmTT30XgsfjHVWMX6HkDkBjMABFqfEaYMdwUei/kwfXAIlSyRYc6OuegMizaiEXtqlVh3c+bNJaBiWM1hJM6la8daUhwMKDz0QxlRE739p9qdJMfpMekS0VXDfd9vqj6VEnJZD29t21TY8pMj8e0q3lATKBfHiKleCB94=  ;
Message-ID: <449AF61C.9040807@yahoo.com.au>
Date: Fri, 23 Jun 2006 05:57:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Pavel Machek <pavel@suse.cz>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, clameter@sgi.com,
       ntl@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com, ak@suse.de, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com> <20060621225609.db34df34.akpm@osdl.org> <20060622150848.GL16029@localdomain> <20060622084513.4717835e.rdunlap@xenotime.net> <Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com> <20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com> <20060622092422.256d6692.rdunlap@xenotime.net> <20060622182231.GC4193@elf.ucw.cz> <Pine.LNX.4.64.0606221938410.17581@blonde.wat.veritas.com> <449AEF29.9070300@yahoo.com.au> <Pine.LNX.4.64.0606222030290.23611@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0606222030290.23611@blonde.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Fri, 23 Jun 2006, Nick Piggin wrote:
> 
>>Hugh Dickins wrote:
>>
>>>I'd expect tasks bound to the unplugged cpu simply not to be run
>>>until "that" cpu is plugged back in.
>>
>>Yes, I don't see why swsusp tasks would need to be migrated and
>>run. OTOH, this would require more swsusp special casing, but
>>apparently that's encouraged ;)
> 
> 
> No, I wasn't meaning any swsusp special casing at all.
> 
> I was just using Pavel's swsusp-related mail as the hook to raise
> the point that had been haunting me with every earlier mail on
> this subject, mails I'd already deleted.
> 
> Pavel seemed to imply overriding the requested affinity for tasks
> (in preferring #1 migration), I doubted he really wanted that.

No, but it is currently the only way to do it.

What I had thought you meant was to disallow cpu unplugging,
except with the special case to allow it from swsusp when
suspending the system.

> 
> 
>>>With proviso that it should be possible to "kill -9" such a task
>>>i.e. it be allowed to run in kernel on a wrong cpu just to exit.
>>>
>>>Presumably this is difficult, because unplugging a cpu will also
>>>remove infrastructure which would, for example, allow "ps" to show
>>>such tasks.  Perhaps such infrastructure should remain so long as
>>>there are tasks there.
>>
>>They'll be in the global tasklist, so there should be no reason why
>>they couldn't be migrated over to an online CPU with taskset. Shouldn't
>>require any rewrites, IIRC.
> 
> 
> I was afraid that "for_each_online_cpu"-type scans would skip over
> the unplugged cpus, in such a way that the homeless tasks might be
> awkwardly invisible in some contexts.  If no such problem, fine.

The management stuff tends to go via the pid hashes or the global
tasklist rather than the runqueues. But you might be right that
there would be some corner cases.

> 
> 
>>But after swsusp comes back up, it will be bringing up the same number
>>of CPUs as went down, won't it? So you shouldn't get into that
>>situation where you'd need to kill stuff, should you?
> 
> 
> I wasn't meaning "kill -9" for the swsusp case, but for the general
> unplug cpu case.  We have a number of homeless tasks, which the admin
> might want to run again when "the" cpu is plugged back in; or might
> want to kill off without having to plug a cpu back in.

Possible maybe... I presumed that would lead to a nightmare of
resource deadlocks (think mutexes). I'd hoped it could still
be useful for the swsusp case where everything gets turned off
at once, though. But I could be wrong...

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
