Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWDTWMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWDTWMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWDTWMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:12:05 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:39846 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S932072AbWDTWMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:12:03 -0400
Message-ID: <44480727.9010500@tlinx.org>
Date: Thu, 20 Apr 2006 15:11:51 -0700
From: "Linda A. Walsh" <law@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org,
       linux-kernel@vger.kernel.org, Tony Jones <tonyj@suse.de>
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export namespace	semaphore
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>	 <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com>	 <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil>	 <20060420124647.GD18604@sergelap.austin.ibm.com>	 <1145534735.3313.3.camel@moss-spartans.epoch.ncsc.mil>	 <20060420132128.GG18604@sergelap.austin.ibm.com> <1145537318.3313.40.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1145537318.3313.40.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephen Smalley wrote:
> But you don't really need the benchmarks - just look at the code, and
> think about the implications of allocating a page and calling d_path on
> every permission(9) call (on every component) plus from the separate
> hooks in the vfs_ helpers and further consider the impact of taking the
> dcache lock all the time there.  And look at the iterators being used in
> aa_perm_dentry as well as the truly fun ones in aa_link.  All because
> they are doing it from LSM hooks that were never intended to be used
> this way.
>   
---
    Agreed.  The LSM hooks as they stand now are unsuitable
for AppArmor for the same reason they were unsuitable for auditing.
Linux isn't serious about security.  If it was, it would have
the needed security calls.  They were written, developed and tested
and benchmarked.  Full auditing of every security relevant call
with full auditing turned on, had less than a 10% performance
hit doing a kernel build (while recording 5MBytes to disk/second
by the user-space audit daemon) -- that was using a 2x400MHz SMP
machine with 1 SCSI3 based disk (~30-35MB/s max transfer rate).
It was configurable at kernel build time to "totally go away" if
not used, to costing less than 1% (in the noise level) for compiled
in but turned off.

    The *current* accepted way to get pathnames going into system
calls is to trap the syscall vector as audit currently does --
a method subject to race conditions.  There is no way to implement
pathname-based security (or auditing) without providing hooks
in each of the relevant system calls after they have copied their
arguments from user space, safely into kernel space.  Decoding
the arguments (including copying them from user space) twice allows
for a window during which the user-space arguments can still be
changed by a user-level process.  You can't copy the arguments from
userspace, twice, and expect that the userspace memory will be
remain the same between the two "copies".

L


