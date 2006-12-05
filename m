Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937518AbWLEMFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937518AbWLEMFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 07:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759995AbWLEMFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 07:05:22 -0500
Received: from smtp-out.google.com ([216.239.33.17]:18979 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758593AbWLEMFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 07:05:21 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=xRyu7X1txDtzh3imXdLaIBqvl1Ed5X0pKMDSM+3ETy0KWN65rTQYkzbKJVksk2Ew9
	Zn3SA/Zucz9zoTE3UmWQQ==
Message-ID: <6599ad830612050404s1f08df2eid62601138c71699@mail.gmail.com>
Date: Tue, 5 Dec 2006 04:04:56 -0800
From: "Paul Menage" <menage@google.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [Patch 1/3] Miscellaneous container fixes
Cc: vatsa@in.ibm.com, akpm@osdl.org, sekharan@us.ibm.com, dev@sw.ru,
       xemul@sw.ru, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, mbligh@google.com, winget@google.com,
       rohitseth@google.com, devel@openvz.org, mingo@elte.hu,
       nickpiggin@yahoo.com.au, dipankar@in.ibm.com, balbir@in.ibm.com
In-Reply-To: <20061201123134.106da1c2.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061123120848.051048000@menage.corp.google.com>
	 <20061123123414.641150000@menage.corp.google.com>
	 <20061201164632.GA26550@in.ibm.com>
	 <6599ad830612010925w17f56643n8c92f179ea28b828@mail.gmail.com>
	 <20061201123134.106da1c2.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/06, Paul Jackson <pj@sgi.com> wrote:
> Read the comment in kernel/cpuset.c for the routine cpuset_destroy().
> It explains that update_flag() is called where it is (turning off
> the cpu_exclusive flag, if it was set), to avoid the calling sequence:
>
>   cpuset_destroy->update_flag->update_cpu_domains->lock_cpu_hotplug
>
> while holding the callback_mutex, as that could ABBA deadlock with the
> CPU hotplug code.

This particular race is gone in the -mm2 kernel since cpus_exclusive
no longer drives sched_domains - can we assume that this will be
reaching mainline some time soon?

>
> But with this container based rewrite of cpusets, it now seems that
> cpuset_destroy -is- called holding the callback_mutex (though I don't
> see any mention of that in the cpuset_destroy comment ;), so it would

And in fact I explicitly documented it as only holding manage_mutex,
not callback_mutex in Documentation/containers.txt. I think maybe this
slipped in during the multi-hierarchy rewrite. :-(

Looking at the various *_destroy() functions in the container
subsystems in my patch set, I think that it should be OK to call the
destructors prior to taking callback_mutex for the unlinking of the
container from its parents.

>
> I also notice that the comment for container_lock() in the file
> kernel/container.c only mentions its use in the oom code.  That is
> no longer the only, or even primary, user of this lock routine.
> The kernel/cpuset.c code uses it frequently (without comment ;),
> and I wouldn't be surprised to see other future controllers calling
> container_lock() as well.

As was pointed out by Chandra Seetharaman, it would be nice if we
could avoid having all the container subsystems relying on
callback_mutex for their locking needs - particularly since that's
likely to be acquired at performance-sensitive times.

The cpu_acct and beancounters subsystems that I included in my patch
set both use their own per-container locks for synchronization, so
it's not completely necessary to use the central locks. There's
probably a happy medium between "one big lock" and "way too many small
locks".

Paul
