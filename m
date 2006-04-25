Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWDYXOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWDYXOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 19:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWDYXOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 19:14:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:65153 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932303AbWDYXOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 19:14:01 -0400
Message-Id: <4t16i2$qee02@orsmga001.jf.intel.com>
X-IronPort-AV: i="4.04,154,1144047600"; 
   d="scan'208"; a="27736066:sNHT41982997"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, "Andrew Morton" <akpm@osdl.org>
Cc: "Daniel Walker" <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>,
       <hzhong@gmail.com>
Subject: RE: [PATCH] Profile likely/unlikely macros
Date: Tue, 25 Apr 2006 16:14:01 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZoWj8adMvMKtl6T1WaCUeAajoFYQAYn8sg
In-Reply-To: <444DF5B4.6030004@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Tuesday, April 25, 2006 3:11 AM
> Andrew Morton wrote:
> > Daniel Walker <dwalker@mvista.com> wrote:
> > 
> >> +	if (likeliness->type & LIKELY_UNSEEN) {
> >> +		if (atomic_dec_and_test(&likely_lock)) {
> >> +			if (likeliness->type & LIKELY_UNSEEN) {
> >> +				likeliness->type &= (~LIKELY_UNSEEN);
> >> +				likeliness->next = likeliness_head;
> >> +				likeliness_head = likeliness;
> >> +			}
> >> +		}
> >> +		atomic_inc(&likely_lock);
> > 
> > 
> > hm, good enough I guess.  It does need a comment explaining why we
> > don't just do spin_lock().
> 
> I guess it is so it can be used in NMIs and interrupts without turning
> interrupts off (so is somewhat lightweight).
> 
> But please Daniel, just use spinlocks and trylock. This is buggy because
> it doesn't get the required release consistency correct.


It looks to me that there is really no need to construct a linked list for
"unseen" likely/unlikely usage.  The information is already in the struct
"likeliness".  do_check_likely always increment one of the counter, so if
both count values are zero, you know it is "unseen" and can be skipped while
printing the profile.  So you can get rid of all that code by beefing up
seq_next().

- Ken
