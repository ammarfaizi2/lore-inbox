Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVEZTPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVEZTPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 15:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVEZTPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 15:15:43 -0400
Received: from aun.it.uu.se ([130.238.12.36]:61635 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261697AbVEZTPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 15:15:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17046.8270.55088.771900@alkaid.it.uu.se>
Date: Thu, 26 May 2005 21:15:26 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1
In-Reply-To: <20050526130402.GN5691@g5.random>
References: <20050525134933.5c22234a.akpm@osdl.org>
	<17045.36727.602005.757948@alkaid.it.uu.se>
	<20050526130402.GN5691@g5.random>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:
 > Speed is not an issue, cr4 would never be tweaked unless you use
 > seccomp, the cr4 flip is in an extreme slow path.
 > 
 > I think there are two ways to solve this race:
 > 
 > 1) why don't we read the cr4 from the cpu? would movl %%cr4, %%eax
 > generate a general protection fault? Can the cr4 be read in ring 0?
 > Why to read it from memory if we've that information in the cpu already?

Yes the kernel can read cr4. I believe the best solution is to modify
__flush_tlb_global() to read cr4's current value and mix it in when
toggling CR4.PGE and uploading mmu_cr4_features.
(But please make it conditional on CONFIG_SECCOMP.)

The code called from __switch_to() would have to set or clear cr4
locally only. That's easy using write_cr4() and read_cr4().

/Mikael
