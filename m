Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbVHAKSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVHAKSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 06:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVHAKQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 06:16:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42977 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262147AbVHAKPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 06:15:33 -0400
Date: Mon, 1 Aug 2005 12:15:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Roland McGrath <roland@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
Message-ID: <20050801101547.GA5016@elte.hu>
References: <20050801032258.A465C180EC0@magilla.sf.frob.com> <42EDDB82.1040900@yahoo.com.au> <20050801091956.GA3950@elte.hu> <42EDEAFE.1090600@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EDEAFE.1090600@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Ingo Molnar wrote:
> >* Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> >>Feedback please, anyone.
> >
> >
> >it looks good to me, but wouldnt it be simpler (in terms of patch and 
> >architecture impact) to always retry the follow_page() in 
> >get_user_pages(), in case of a minor fault? The sequence of minor faults 
> 
> I believe this can break some things. Hugh posted an example in his 
> recent post to linux-mm (ptrace setting a breakpoint in read-only 
> text). I think?

Hugh's posting said:

 "it's trying to avoid an endless loop of finding the pte not writable 
  when ptrace is modifying a page which the user is currently protected 
  against writing to (setting a breakpoint in readonly text, perhaps?)"

i'm wondering, why should that case generate an infinite fault? The 
first write access should copy the shared-library page into a private 
page and map it into the task's MM, writable. If this make-writable 
operation races with a read access then we return a minor fault and the 
page is still readonly, but retrying the write should then break up the 
COW protection and generate a writable page, and a subsequent 
follow_page() success. If the page cannot be made writable, shouldnt the 
vma flags reflect this fact by not having the VM_MAYWRITE flag, and 
hence get_user_pages() should have returned with -EFAULT earlier?

in other words, can a named MAP_PRIVATE vma with VM_MAYWRITE set ever be 
non-COW-break-able and thus have the potential to induce an infinite 
loop?

	Ingo
