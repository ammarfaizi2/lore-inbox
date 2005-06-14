Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVFNXYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVFNXYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 19:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVFNXYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 19:24:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23692 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261418AbVFNXXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 19:23:07 -0400
Date: Tue, 14 Jun 2005 16:23:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: christoph <christoph@scalex86.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Move some variables into the "most_readonly" section??
Message-Id: <20050614162354.6aabe57e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0506141551350.3676@ScMPusgw>
References: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw>
	<20050608131839.GP23831@wotan.suse.de>
	<Pine.LNX.4.62.0506141551350.3676@ScMPusgw>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christoph <christoph@scalex86.org> wrote:
>
> On Wed, 8 Jun 2005, Andi Kleen wrote:
> 
> > However this means __cacheline_aligned_mostly_readonly doesnt make much
> > sense since there is no need for alignment in read only. How about
> > replacing it with a __mostly_readonly that doesnt align and remove
> > __cacheline_aligned_mostly_readonly? 
> 
> Hmm. No.

Think so.  If an object is in its own cacheline then it won't be pingponged
around by writes to unrelated nearby objects.

> The bigger cpu maps may benefit from cacheline alignment for 
> even for read access.

A tiny bit, because the bitmaps might straddle one more cacheline than they
strictly need to.

> Here is a patch that introduces __mostly_readonly in 
> addition to __cacheline_aligned_mostly_readonly:

I think readmostliness and alignment are mostly-unrelated concepts and
should have separate tag thingies.  IOW,
__cacheline_aligned_mostly_readonly goes away and to handle things like the
cpu maps we do:

char foo[8] __cacheline_aligned _mostly_readonly = { whatever };


(I shall now go away and quietly tear my hair out.  Those mostly-readonly
patches caused a mountain of grief:

optimise-storage-of-read-mostly-variables.patch
optimise-storage-of-read-mostly-variables-fix.patch
optimise-storage-of-read-mostly-variables-x86_64-fix.patch
optimise-storage-of-read-mostly-variables-x86_64-fix-fix.patch
optimise-storage-of-read-mostly-variables-x86_64-fix-fix-fix.patch
move-some-more-structures-into-mostly_readonly-and-readonly.patch
kexec-x86_64-optimise-storage-of-read-mostly-variables-x86_64-fix.patch

Once this is sorted I'll drop the lot and we start from a clean slate).
