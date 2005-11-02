Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVKBBnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVKBBnf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 20:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVKBBnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 20:43:35 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15660
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S932154AbVKBBne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 20:43:34 -0500
Date: Wed, 2 Nov 2005 02:43:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Hugh Dickins <hugh@veritas.com>,
       akpm@osdl.org, dvhltc@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH] 2.6.14 patch for supporting madvise(MADV_FREE)
Message-ID: <20051102014321.GG24051@opteron.random>
References: <1130366995.23729.38.camel@localhost.localdomain> <20051028034616.GA14511@ccure.user-mode-linux.org> <43624F82.6080003@us.ibm.com> <20051028184235.GC8514@ccure.user-mode-linux.org> <1130544201.23729.167.camel@localhost.localdomain> <20051029025119.GA14998@ccure.user-mode-linux.org> <1130788176.24503.19.camel@localhost.localdomain> <20051101000509.GA11847@ccure.user-mode-linux.org> <1130894101.24503.64.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130894101.24503.64.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 05:15:01PM -0800, Badari Pulavarty wrote:
> Here is the patch to support madvise(MADV_FREE) - which frees 
> up the given range of pages and truncates the underlying backing 
> store. This basically provides "punch hole into file" functionality.
> Currently it supports ONLY shmfs/tmpfs - where we have short term 
> need. Other filesystems return -ENOSYS.

MADV_FREE as a name isn't right if we return -ENOSYS for anonymoys
memory.

MADV_FREE in other OS works _only_ on anonymous memory and returns
-EINVAL if used on filebacked vmas. Infact we probably should rename our
MADV_DONTNEED to MADV_FREE.

http://docs.sun.com/app/docs/doc/816-5168/6mbb3hrde?a=view

	"This value cannot be used on mappings that have underlying file objects."

Our MADV_DONTNEED exactly matches the MADV_FREE semantics, and it seems
the MADV_DONTNEED of other OS isn't destructive like ours. Except our
MADV_DONTNEED also works on filebacked mappings but it's destructive
only on anonymous memory.


I thought Andrew suggested MADV_REMOVE for the new feature.

This feature didn't exist in other OS yet AFIK, so a new MADV_name for
it makes sense. I'm not completely against extending MADV_FREE but then we
shouldn't return -ENOSYS on anonymous memory and we should do the same
thing MADV_DONTNEED does on anonymous memory. Probably a new name is
safer to avoid confusion (think an application running MADV_FREE and
expecting -EINVAL when used on filebacked mappings).

Thanks!
