Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264902AbSJOVY4>; Tue, 15 Oct 2002 17:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbSJOVY4>; Tue, 15 Oct 2002 17:24:56 -0400
Received: from zero.aec.at ([193.170.194.10]:37906 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S264902AbSJOVYz>;
	Tue, 15 Oct 2002 17:24:55 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch] mmap-speedup-2.5.42-C3
References: <Pine.LNX.4.44.0210151438440.10496-100000@localhost.localdomain>
	<3DAC59F7.18678FA6@digeo.com>
From: Andi Kleen <ak@muc.de>
Date: 15 Oct 2002 23:30:34 +0200
In-Reply-To: <3DAC59F7.18678FA6@digeo.com>
Message-ID: <m3bs5vl79h.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> Yup.  We'd need to be able to perform a search based on "size of hole"
> rather than virtual address.  That really needs a whole new data structure
> and supporting search code, I think...  It also may have side effects
> to do with fragmentation of the virtual address space.

When you oprofile KDE startup you notice that a lot of time is spent in
get_unmapped_area too. The reason is that every KDE process links with
10-20 libraries and ends up with a 40-50 entry /proc/<pid>/maps.

Optimizing this case would be likely useful too, although I suspect
Ingo's last hit cache would already help somewhat.

When you add a funky data structure please trigger it on the number
of mappings at least. e.g. I bet a micro optimized (= uses prefetch) 
single linked list or even array will be always best for <= 10 entries,
which is still not that uncommon in the non KDE world.

Array would be attractive because you can trivially prefetch it,
but would eat more space per mm_struct. Assuming each process has at 
least 5 mappings the cost should be rather small though.

-Andi
