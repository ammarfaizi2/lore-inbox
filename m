Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWDZUVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWDZUVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWDZUVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:21:47 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:57785 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964863AbWDZUVq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:21:46 -0400
Subject: Re: Linux 2.6.17-rc2 - notifier chain problem?
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Alan Stern <stern@rowland.harvard.edu>,
       herbert@13thfloor.at, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com
In-Reply-To: <20060426122926.A31482@unix-os.sc.intel.com>
References: <Pine.LNX.4.44L0.0604261144010.6376-100000@iolanthe.rowland.org>
	 <1146075534.24650.11.camel@linuxchandra>
	 <20060426114348.51e8e978.akpm@osdl.org>
	 <20060426122926.A31482@unix-os.sc.intel.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 26 Apr 2006 13:21:33 -0700
Message-Id: <1146082893.24650.27.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 12:29 -0700, Ashok Raj wrote:
> On Wed, Apr 26, 2006 at 11:43:48AM -0700, Andrew Morton wrote:
> > Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> > Ashok's the one who has spent most time with this.  Basically _everything_
> > to do with register_cpu_notifier() and all the things which call it should
> > be __cpuinit and should be tossed away during boot on non-cpu-hotplug
> > kernels.
> > 
> > But there are a few nasty problems with that which made us give up.
> 
> I think we got to a reasonable start, until i got busy with other things
> and didnt complete it all the way to be ready to submit. There were many files
> that got affected, so we thought may be could take smaller steps.
> 
> for the above xfs, if you want to avoid the ifdef CONFIG_HOTPLUG_CPU
> you could choose to use the hotcpu_notifier() which is null macro when 
> CONFIG_HOTPLUG_CPU=n

No, they can't use the hotcpu_notifier, because they want to hold on to
their notifier block (as they attach it with each mount data structure).

But, it is not a major issue. Changes to xfs to adhere to the model
being discussed is very small.

> 
> The problem we ran into was some of the startup code depends on the notifier
> call chain for smp bringup, hence we couldn't nuke it similar to 
> hotcpu_notifier().

I do not understand the problem. If everybody that uses
register_cpu_notifier() starts using __cpuinit and __cpuinitdata (or the
devinit siblings), then the notifier mechanism will not be any different
than what they are now, right ? (both in hotplug cpu and non-hotplug cpu
case) Or am i missing something ?
 
> 
> so we ended up calling that function for early risers as 
> early_register_cpu_notifier(), and all functions/data with __cpuinit etc to
> overcome that issue.
> 
> I will try to pursue to again when i get a chance.

I made patches that removes all init stuff from all the usages of
notifier_blocks, and i _think_ it is on its way to 2.6.17. The question
is, should it go in or not ?

May be the right answer is it should not and xfs should fix their
register_cpu_notifier() usage. 

chandra 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


