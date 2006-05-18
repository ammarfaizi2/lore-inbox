Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWEREz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWEREz1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 00:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWEREz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 00:55:27 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:32598 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1750876AbWEREz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 00:55:26 -0400
X-IronPort-AV: i="4.05,139,1146466800"; 
   d="scan'208"; a="1808290484:sNHT30261636"
To: Dave Olson <olson@unixfolk.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 35 of 53] ipath - some interrelated stability and cleanliness fixes
X-Message-Flag: Warning: May contain useful information
References: <fa.2ho1QSA8Kf7L8EFqp3rLsB7NE9s@ifi.uio.no>
	<fa.yXZlqXBzNi9Gq/4Q6Wc9H6bw+lU@ifi.uio.no>
	<Pine.LNX.4.61.0605170944570.22323@osa.unixfolk.com>
	<ada4pzo5xti.fsf@cisco.com>
	<Pine.LNX.4.61.0605172113480.23165@osa.unixfolk.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 17 May 2006 21:55:21 -0700
In-Reply-To: <Pine.LNX.4.61.0605172113480.23165@osa.unixfolk.com> (Dave Olson's message of "Wed, 17 May 2006 21:13:59 -0700 (PDT)")
Message-ID: <adaac9g3pae.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 18 May 2006 04:55:21.0833 (UTC) FILETIME=[448A1D90:01C67A37]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Dave> We did discover one possible problem today, which is shared
    Dave> between our device code and the core openib code, and that's
    Dave> doing some memory freeing and accounting from a work thread
    Dave> (updating mm->locked_vm and cleaning up from earlier
    Dave> get_user_pages); the code in our driver was copied from the
    Dave> openib core code, it's not literally shared.

    Dave> I have a strong suspicion that at least sometimes, it's
    Dave> executing after the current->mm has gone away.  I'm looking
    Dave> at that more right now.

It doesn't seem likely to me.  In uverbs_mem.c,
ib_umem_release_on_close() does get_task_mm() and gives up if it can't
take a reference to the task's mm.  The mmput() doesn't happen until
ib_umem_account() runs in the work thread.

I do see obvious bugs in ipath_user_pages.c, though.  In
ipath_release_user_pages_on_close(), you have:

		mm = get_task_mm(current);
		if (!mm)
			goto bail;
	
		work = kmalloc(sizeof(*work), GFP_KERNEL);
		if (!work)
			goto bail_mm;
	
		goto bail;
	
		INIT_WORK(&work->work, user_pages_account, work);
		work->mm = mm;
		work->num_pages = num_pages;
	
	bail_mm:
		mmput(mm);
	bail:
		return;

So with the "goto bail" you skip the code which does something with
the work you allocate, which means that you leak not only the work
structure but also the reference to the task's mm that you took.

Even without the "goto bail" the code still wouldn't actually schedule
the work, so the work structure would be leaked, although you would do
mmput().

I'm not sure what you were trying to do here.c

 - R.
