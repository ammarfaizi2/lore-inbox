Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270014AbTGaWf6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270092AbTGaWf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:35:58 -0400
Received: from holomorphy.com ([66.224.33.161]:59353 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270014AbTGaWf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:35:56 -0400
Date: Thu, 31 Jul 2003 15:37:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Panic on 2.6.0-test1-mm1
Message-ID: <20030731223710.GI15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <5110000.1059489420@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5110000.1059489420@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 07:37:00AM -0700, Martin J. Bligh wrote:
> The big box had this on the console ... looks like it was doing a
> compile at the time ... sorry, only just noticed it after returning
> from OLS, so don't have more context (2.6.0-test1-mm1).
> kernel BUG at include/linux/list.h:149!
> invalid operand: 0000 [#1]
> SMP 
> CPU:    3
> EIP:    0060:[<c0117f98>]    Not tainted VLI
> EFLAGS: 00010083
> EIP is at pgd_dtor+0x64/0x8c

This is on PAE, so you're in far deeper trouble than I could have caused:

        pgd_cache = kmem_cache_create("pgd",
                                PTRS_PER_PGD*sizeof(pgd_t),
                                0,
                                SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN,
                                pgd_ctor,
                                PTRS_PER_PMD == 1 ? pgd_dtor : NULL);

You've applied mingo's patch, which needs to check for PAE in certain
places like the above. Backing out highpmd didn't make this easier, it
just gave you performance problems because now all your pmd's are stuck
on node 0 and another side-effect of those changes is that you're now
pounding pgd_lock on 16x+ boxen. You could back out the preconstruction
altogether, if you're hellbent on backing out everyone else's patches
until your code has nothing to merge against.


-- wli
