Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266708AbUG1Akl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266708AbUG1Akl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 20:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266712AbUG1Akl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 20:40:41 -0400
Received: from holomorphy.com ([207.189.100.168]:56199 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266708AbUG1Akj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 20:40:39 -0400
Date: Tue, 27 Jul 2004 17:40:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Owens <kaos@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] Allow x86_64 to reenable interrupts on contention
Message-ID: <20040728004030.GK2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Owens <kaos@sgi.com>, Andrew Morton <akpm@osdl.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <20040728001415.GI2334@holomorphy.com> <21964.1090974908@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21964.1090974908@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 17:14:15 -0700, 
>> There are also flash and similar absolute space footprints to consider.
>> Experiments seem to suggest that consolidating the lock sections and
>> other spinlock code can reduce kernel image size by as much as 220KB on
>> ia32 with no performance impact (rigorous benchmarks still in progress).

On Wed, Jul 28, 2004 at 10:35:08AM +1000, Keith Owens wrote:
> I consolidated the spinlock contention path to a single routine on
> ia64, with big space savings.  The problem with the ia64 consolidation
> was backtracing through a contended lock; the ia64 unwind API is not
> designed for code that is shared between multiple code paths but uses
> non-standard entry and exit conventions.  In the end, David Mosberger
> did a patch to gcc to do lightweight calls to the out of line
> contention code, just to get reliable backtraces.
> kdb has workarounds for backtracing through ia64 contended locks when
> the kernel is built with older versions of gcc.  gdb (and hence kgdb)
> has no idea about the special out of line code.  Mind you, the same is
> true right now with the out of line i386 code, you need special
> heuristics to backtrace the existing spinlock code reliably.  That will
> only get worse with Zwane's patch, interrupts can now occur in the out
> of line code.

It's good to know there is a precedent and that the backtrace issue has
been looked at on other architectures.


On Wed, Jul 28, 2004 at 10:35:08AM +1000, Keith Owens wrote:
> Are you are planning to consolidate the out of line code for i386?  Is
> there a patch (even work in progress) so I can start thinking about
> doing reliable backtraces?

The experiments were carried out using the standard calling convention.
We may investigate less standard calling conventions, but they should
actually already be there given __write_lock_failed/__read_lock_failed.
i.e. if reliable backtraces are going to be an issue they should
already be an issue for rwlocks.


-- wli
