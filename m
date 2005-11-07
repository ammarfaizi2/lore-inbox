Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVKGO2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVKGO2c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 09:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbVKGO2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 09:28:32 -0500
Received: from fmr24.intel.com ([143.183.121.16]:64660 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S964828AbVKGO2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 09:28:31 -0500
Date: Mon, 7 Nov 2005 06:27:39 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: Ashok Raj <ashok.raj@intel.com>, akpm@osdl.org, linux@brodo.de,
       davej@redhat.com, zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: [patch 4/4] create and destroy cpufreq sysfs entries based on cpu notifiers.
Message-ID: <20051107062738.A1197@unix-os.sc.intel.com>
References: <20051021203818.753754000@araj-sfield> <20051021204327.843400000@araj-sfield> <20051107114144.GH7806@otto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051107114144.GH7806@otto>; from ntl@pobox.com on Mon, Nov 07, 2005 at 05:41:44AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 05:41:44AM -0600, Nathan Lynch wrote:
> > 
> > Primary goal was to just make these directories appear/disapper dynamically.
> 
> I see this patch series has already been merged, but in light of the
> issues that it has caused[1], and the hack that Andrew is carrying to
> deal with them[2], could we revisit the original justification for
> these changes?

Agreed, the patch wasnt clean, just a sde effect that i didnt 
want to make very many changes in a subsystem to have to validate 
if the changes were extensive. So i took some shortcuts that made it 
ugly and now those reworks. (saying that is like beating the dead horse)

the problem isnt creating and destroyoing sysfs files, we need to put the 
cpu going away to the lowst possible freq state to save power etc which
was the code path that caused trouble.

> 
> Why is it important that cpufreq-related files in sysfs be added and
> removed as cpus go online and offline?  I see that the information
> that these entries provide can be derived only when the cpu is online,
> is that the primary justification?

There are just not for informational purposes, there are some files
that get created for control as well, say to set a cpu frequency.

Sure  you can do cpu_online() to each step, but iam sure that kind of looks
ugly workaround. There is no reason for them to exist when the cpu is offline.

The data also gets populated upfront at creation time. say if i start
with maxcpus=2, in a 4 cpu system, only 2 online cpus get their
cpufreq entries get created. since these are sysfs subdriver, when 
the sysfs entrries are created, the subdriver _add functions get called
for all present cpus, but the _add only succeeds for online cpus.

now we could re-organize all of that to just create the entries
and collect the data each time rather than just create them
when its possible, and remove them when not necessary anymore. 


the orign of the patch fiasco was since the lock was smack in the 
lowest function, that had about 14 different places it got called from.
So if i need to move the lock to higher caller, we need to properly
analyze which ones are truly higher level functions in cpufreq.

I wasnt motivated to that, not having understood the entire cpufreq mechanics
tried to solve the symtom instead.

> 
> Would it be undesirable for the cpufreq drivers to create their
> entries under all cpu sysdevs at init time, regardless of whether the
> cpus are online?  The "show" methods for entries attached to offline
> cpus could be made to return "Unavailable" or some equivalent.
> 
> I'm not terribly familiar with x86 or cpufreq, so forgive me if I'm
> missing something obvious.

Hope this helps.
> 
-- 
Cheers,
Ashok Raj
- Open Source Technology Center
