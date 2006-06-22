Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbWFVT1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWFVT1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbWFVT1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:27:44 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:21675 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932626AbWFVT1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:27:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=igOdkhZKl9IU1bvmbZpBop/eN5V1FNiEUo0yguIXldydWkZrFDX+/9PCn9ks/sxNQuKBGHwjRFeu34wx8OENmTSBSS/MOR1TiK0JXra2p7LR3mBL4sFOHuAkTxslocPl0CncDwAEeBMghGYSDm+iYVAFyPvuvLvrGI2wG8+VK0s=  ;
Message-ID: <449AEF29.9070300@yahoo.com.au>
Date: Fri, 23 Jun 2006 05:27:37 +1000
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
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com> <20060621225609.db34df34.akpm@osdl.org> <20060622150848.GL16029@localdomain> <20060622084513.4717835e.rdunlap@xenotime.net> <Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com> <20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com> <20060622092422.256d6692.rdunlap@xenotime.net> <20060622182231.GC4193@elf.ucw.cz> <Pine.LNX.4.64.0606221938410.17581@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0606221938410.17581@blonde.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Thu, 22 Jun 2006, Pavel Machek wrote:
> 
>>>>Hm..
>>>>Then, there is several ways to manage this sitation.
>>>>
>>>>1. migrate all even if it's not allowed by users
>>
>>That's what I'd prefer... as swsusp uses cpu hotplug. All the other
>>options are bad... admin will probably not realize suspend involves
>>cpu unplugs..
>>
>>
>>>>2. kill mis-configured tasks.
>>>>3. stop ...
>>>>4. cancel cpu-hot-removal.
> 
> 
> I'm very reluctant to expose my ignorance by joining this thread;
> but what I'd naively expect would, I think, suit swsusp also -
> you don't really want tasks to be migrated when resuming?

No. And problem with force migrating things is that we lose the
cpus_allowed mask that has been carefully configured.

For this reason, I'm also in favour of #4, however we would need
a solution for swsusp.

> 
> I'd expect tasks bound to the unplugged cpu simply not to be run
> until "that" cpu is plugged back in.

Yes, I don't see why swsusp tasks would need to be migrated and
run. OTOH, this would require more swsusp special casing, but
apparently that's encouraged ;)

> 
> With proviso that it should be possible to "kill -9" such a task
> i.e. it be allowed to run in kernel on a wrong cpu just to exit.
> 
> Presumably this is difficult, because unplugging a cpu will also
> remove infrastructure which would, for example, allow "ps" to show
> such tasks.  Perhaps such infrastructure should remain so long as
> there are tasks there.

They'll be in the global tasklist, so there should be no reason why
they couldn't be migrated over to an online CPU with taskset. Shouldn't
require any rewrites, IIRC.

But after swsusp comes back up, it will be bringing up the same number
of CPUs as went down, won't it? So you shouldn't get into that
situation where you'd need to kill stuff, should you?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
