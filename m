Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBOTHg>; Thu, 15 Feb 2001 14:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRBOTH0>; Thu, 15 Feb 2001 14:07:26 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:33295 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129066AbRBOTHN>;
	Thu, 15 Feb 2001 14:07:13 -0500
Date: Thu, 15 Feb 2001 20:07:01 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Kanoj Sarcar <kanoj@google.engr.sgi.com>, Ben LaHaise <bcrl@redhat.com>,
        linux-mm@kvack.org, mingo@redhat.com, alan@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
Message-ID: <20010215200701.A2474@pcep-jamie.cern.ch>
In-Reply-To: <200102151823.KAA00802@google.engr.sgi.com> <3A8C254F.17334682@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A8C254F.17334682@colorfullife.com>; from manfred@colorfullife.com on Thu, Feb 15, 2001 at 07:51:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> Is the sequence
> << lock;
> read pte
> pte |= dirty
> write pte
> >> end lock;
> or
> << lock;
> read pte
> if (!present(pte))
> 	do_page_fault();
> pte |= dirty
> write pte.
> >> end lock;

or more generally

<< lock;
read pte
if (!present(pte) || !writable(pte))
	do_page_fault();
pte |= dirty
write pte.
>> end lock;

Not to mention, does it guarantee to use the newly read physical
address, does it check the superviser permission again, does it use the
new PAT/CD/WT attributes?

I can vaguely imagine some COW optimisation where the pte is updated to
be writable with the new page's address, and there is no need to flush
other processor TLBs because they will do so when they first write to
the page.  (But of course you have to be careful synchronising with
other uses of the shared page prior to the eventual TLB flush).

-- Jamie
