Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263295AbVFYCvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbVFYCvp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 22:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbVFYCvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 22:51:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48588 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263295AbVFYCvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 22:51:25 -0400
Date: Sat, 25 Jun 2005 04:51:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, raybry@engr.sgi.com,
       torvalds@osdl.org
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing usable for other purposes
Message-ID: <20050625025122.GC22393@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506241316370.30503@graphe.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The process freezing used by software suspend currently relies on modifying
> current->flags from outside of the processes context. This makes freezing and
> unfreezing SMP unsafe since a process may change the flags at any time without
> locking. The following patch introduces a new atomic_t field in task_struct
> to allow SMP safe freezing and unfreezing.
> 
> It provides a simple API for process freezing:
> 
> frozen(process)		Check for frozen process
> freezing(process)	Check if a process is being frozen
> freeze(process)		Tell a process to freeze (go to refrigerator)
> thaw_process(process)	Restart process
> 
> I only know that this boots correctly since I have no system that can do 
> suspend. But Ray needs an effective means of process suspension for 
> his process migration patches.

Any i386 or x86-64 machine can do suspend... It should be easy to get
some notebook... [What kind of hardware are you working on normally?]

> Some of the code may still need to be moved around from kernel/power/* to 
> kernel/*.
> 
> But is this the correct way to fix this?

It includes whitespace changes and most of patch is nice cleanup that
should probably go in separately. (Hint hint :-). 

Previous code had important property: try_to_freeze was optimized away
in !CONFIG_PM case. Please keep that.

Best way is to introduce macros and cleanup the code to use the
macros, without actually changing any object code. That can go in very
fast. Then we can switch to atomic_t ... yeah I think that's
neccessary, but I'd like cleanups first.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
