Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWFSPlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWFSPlf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWFSPlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:41:35 -0400
Received: from rtr.ca ([64.26.128.89]:25779 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964773AbWFSPle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:41:34 -0400
Message-ID: <4496C5AC.3030809@rtr.ca>
Date: Mon, 19 Jun 2006 11:41:32 -0400
From: Mark Lord <tigerdirect@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Johannes Stezenbach <js@linuxtv.org>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       p.lundkvist@telia.com, linux-kernel@vger.kernel.org, rjw@sisk.pl,
       Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH] Page writeback broken after resume: wb_timer lost
References: <20060520130326.GA6092@localhost> <20060520103728.6f3b3798.akpm@osdl.org> <20060520225018.GC8490@elf.ucw.cz> <20060520171244.4399bc54.akpm@osdl.org> <20060616212410.GA6821@linuxtv.org>
In-Reply-To: <20060616212410.GA6821@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach wrote:
> On Sat, May 20, 2006, Andrew Morton wrote:
>> From: Andrew Morton <akpm@osdl.org>
>>
>> pdflush is carefully designed to ensure that all wakeups have some
>> corresponding work to do - if a woken-up pdflush thread discovers that it
>> hasn't been given any work to do then this is considered an error.
>>
>> That all broke when swsusp came along - because a timer-delivered wakeup to a
>> frozen pdflush thread will just get lost.  This causes the pdflush thread to
>> get lost as well: the writeback timer is supposed to be re-armed by pdflush in
>> process context, but pdflush doesn't execute the callout which does this.
>>
>> Fix that up by ignoring the return value from try_to_freeze(): jsut proceed,
>> see if we have any work pending and only go back to sleep if that is not the
>> case.
>>
>>
>> Signed-off-by: Andrew Morton <akpm@osdl.org>
> 
> 
> I've tested this patch for about a week now, by applying it to
> the 2.6.17-rc3 kernel on my laptop, which I've been using
> for more than a month now. This patch seems to cure the
> mysterious symptoms reported in February:
> 
> http://lkml.org/lkml/2006/2/6/167
> http://lkml.org/lkml/2006/2/6/170
> http://lkml.org/lkml/2006/2/13/424
> etc.
> 
> Actually I didn't remember to check "Dirty:" in /proc/meminfo,
> but when I "sync"ed at the end of my workday, just prior to
> swsupending it, sync returned immediately. with unpatched
> 2.6.17-rc3, sync would take half a minute. Maybe Mark can give
> this patch a spin to check if it cures his problem, too.
> (I still use vmware, so vmware was not the culprit.)

I just gave it a try here.  With or without a suspend/resume cycle after boot,
the "sync" time is much quicker.  But the Dirty count in /proc/meminfo
still shows very huge (eg. 600MB) values that never really get smaller
until I type "sync".  But that subsequent "sync" only takes a couple
of seconds now, rather than 10-20 seconds like before.

Dunno what that all means -- I'm still keeping my little daemon around
to do periodic "sync" calls for safety.

Cheers
