Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267665AbSLFXxx>; Fri, 6 Dec 2002 18:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267666AbSLFXxx>; Fri, 6 Dec 2002 18:53:53 -0500
Received: from packet.digeo.com ([12.110.80.53]:57290 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267665AbSLFXxx>;
	Fri, 6 Dec 2002 18:53:53 -0500
Message-ID: <3DF13A54.927C04C1@digeo.com>
Date: Fri, 06 Dec 2002 16:01:24 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.50 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrea Arcangeli <andrea@suse.de>, Norman Gaywood <norm@turing.une.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
References: <20021206111326.B7232@turing.une.edu.au> <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <20021206222852.GF4335@dualathlon.random> <20021206232125.GR9882@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2002 00:01:24.0059 (UTC) FILETIME=[C7F1E2B0:01C29D83]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> ...
> A 16KB or 64KB kernel allocation unit would then annihilate

You want to be careful about this:

	CPU: L1 I cache: 16K, L1 D cache: 16K

Because instantiating a 16k page into user pagetables in
one hit means that it must all be zeroed.  With these large
pagesizes that means that the application is likely to get
100% L1 misses against the new page, whereas it currently
gets 100% hits.

I'd expect this performance dropoff to occur when going from 8k
to 16k.  By the time you get to 32k it would be quite bad.

One way to address this could be to find a way of making the
pages present, but still cause a fault on first access.  Then
have a special-case fastpath in the fault handler to really wipe
the page just before it is used.  I don't know how though - maybe
_PAGE_USER?

get_user_pages() would need attention too - you don't want to
allow the user to perform O_DIRECT writes of uninitialised
pages to their files...
