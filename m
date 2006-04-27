Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWD0Vd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWD0Vd5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 17:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbWD0Vd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 17:33:57 -0400
Received: from smtp-3.llnl.gov ([128.115.41.83]:4786 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S1751693AbWD0Vd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 17:33:56 -0400
From: Dave Peterson <dsp@llnl.gov>
To: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 1/2 (repost)] mm: serialize OOM kill operations
Date: Thu, 27 Apr 2006 14:32:56 -0700
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com,
       nickpiggin@yahoo.com.au, ak@suse.de
References: <200604271308.10080.dsp@llnl.gov> <20060427134442.639a6d19.pj@sgi.com> <20060427140921.249a00b0.akpm@osdl.org>
In-Reply-To: <20060427140921.249a00b0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604271432.56803.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 14:09, Andrew Morton wrote:
> Paul Jackson <pj@sgi.com> wrote:
> > Adding a 'oom_notify' bitfield after the existing 'dumpable'
> > bitfield in mm_struct would save that slot:
> >
> >         unsigned dumpable:2;
> > 	unsigned oom_notify:1;
>
> Note that these will occupy the same machine word.  So they'll need
> locking.  (Good luck trying to demonstrate the race though!)

Taking a quick look at the code, I think a race could happen like this:
Task A is executing a system call handler such as sys_setgid(),
sys_setuid(), etc. that assigns a value to the 'dumpable' field (i.e.
current->mm->dumpable = suid_dumpable; ).  At the same time the OOM
killer decides to shoot task A.  The following sequence of events could
take place:

    1.  Task A reads the machine word containing 'dumpable' into a
        register and modifies the value in the register so that
        'dumpable' is set to the desired value.

    2.  Task B, which is executing the OOM killer code, has decided to
        shoot task A.  B reads the machine word containing 'dumpable'
        into a register, sets the bit corresponding to 'oom_notify',
        and writes the machine word back to memory.

    3.  Task A writes its machine word back to memory, which wipes out
        the setting of the 'oom_notify' bit by task B.  Now the OOM
        kill operation will never terminate, and all future OOM kill
        operations will be prevented.

I guess it would be kind of nice if we had some sort of primitive for
atomically modifying multiple bits within a machine word.
Oh well :-/
