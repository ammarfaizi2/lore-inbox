Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWFUKkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWFUKkp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWFUKkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:40:45 -0400
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:54702 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751237AbWFUKko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:40:44 -0400
Message-ID: <4499222A.5090403@bigpond.net.au>
Date: Wed, 21 Jun 2006 20:40:42 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Matt Helsley <matthltc@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       "John T. Kohl" <jtk@us.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jes Sorensen <jes@sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] [PATCH 00/11] Task watchers:  Introduction
References: <1150242721.21787.138.camel@stark>	 <20060619032453.2c19e32c.akpm@osdl.org> <1150878929.21787.956.camel@stark>	 <20060621020754.59dd42c6.akpm@osdl.org> <1150881185.21787.980.camel@stark>
In-Reply-To: <1150881185.21787.980.camel@stark>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 21 Jun 2006 10:40:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley wrote:
> On Wed, 2006-06-21 at 02:07 -0700, Andrew Morton wrote:
>> On Wed, 21 Jun 2006 01:35:29 -0700
>> Matt Helsley <matthltc@us.ibm.com> wrote:
>>
>>> On Mon, 2006-06-19 at 03:24 -0700, Andrew Morton wrote:
>>>> On Tue, 13 Jun 2006 16:52:01 -0700
>>>> Matt Helsley <matthltc@us.ibm.com> wrote:
>>>>
>>>>> Task watchers is a notifier chain that sends notifications to registered
>>>>> callers whenever a task forks, execs, changes its [re][ug]id, or exits.
>>>> Seems a reasonable objective - it'll certainly curtail (indeed, reverse)
>>>> the ongoing proliferation of little subsystem-specific hooks all over the
>>>> core code, will allow us to remove some #includes from core code and should
>>>> permit some more things to be loaded as modules.
>>>>
>>>> But I do wonder if it would have been better to have separate chains for
>>>> each of WATCH_TASK_INIT, WATCH_TASK_EXEC, WATCH_TASK_UID, WATCH_TASK_GID,
>>>> WATCH_TASK_EXIT.  That would reduce the number of elements which need to be
>>>> traversed at each event and would eliminate the need for demultiplexing at
>>>> each handler.
>>> 	It's a good idea, and should have the advantages you cited. My only
>>> concern is that each task watcher would have to (un)register multiple
>>> notifier blocks. I expect that in most cases there would only be two.
>> OK.
>>
>>> Also, if we apply this to per-task notifiers it would mean that we'd
>>> have a 6 raw notifier heads per-task.
>> hm, that's potentially a problem.
>>
>> It's a lock and a pointer.  72 bytes in the task_struct.  I guess we can
>> live with that.
> 
> Happily the per-task chains are raw so each should be just a pointer
> making the total 24 or 48 bytes (on 32 or 64-bit platforms
> respectively).
> 
>> An alternatve would be to dynamically allocate it, but that'll hurt code
>> which uses the feature, and will be fiddly.
>>
>> Perhaps six struct notifier_block *'s, which share a lock?  Dunno.
>>
>>> 	Would you like me to redo the patches as multiple chains?
>> Well, how about you see how it looks, decide whether this is worth
>> pursuing.
> 
> OK. Should be interesing.
> 
>> It's hard to predict the eventual typical length of these chains.
> 
> That's understandable.
> 
>>> Alternately,
>>> I could produce patches that apply on top of the current set.
>> It depends on how many of the existing patches are affected.  If it's just
>> one or two then an increment would be fine.  If it's everything then a new
>> patchset I guess.
> 
> It would affect most of them -- I'd need to change the bits that
> register a notifier block. So I'll make a separate series.

How about making WATCH_TASK_INIT and friends flags so that clients can 
then pass a mask (probably part of the notifier_block) that specifies 
which ones they wish to be notified of.  This would save unnecessary 
function calls.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
