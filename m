Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbUFXA04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUFXA04 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 20:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUFXA04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 20:26:56 -0400
Received: from holomorphy.com ([207.189.100.168]:28294 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263184AbUFXA0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 20:26:53 -0400
Date: Wed, 23 Jun 2004 17:26:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
Message-ID: <20040624002651.GL1552@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <0406231407.HbLbJbXaHbKbWa5aJb1a4aKb0a3aKb1a0a2aMbMbYa3aLbMb3aJbWaJbXaMbLb1a342@holomorphy.com> <20040623151659.70333c6d.akpm@osdl.org> <20040623223146.GG1552@holomorphy.com> <20040623153758.40e3a865.akpm@osdl.org> <20040623230730.GJ1552@holomorphy.com> <20040623163819.013c8585.akpm@osdl.org> <20040624000308.GK1552@holomorphy.com> <20040623171818.39b73d52.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623171818.39b73d52.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> It's a
>> judgment call as to whether it's beneficial in general, as it does
>> insulate userspace somewhat from needing to wait for slow IO being the
>> ostensible cause of the allocation failure.

On Wed, Jun 23, 2004 at 05:18:18PM -0700, Andrew Morton wrote:
> mm...  I can only see that happening if the IO system is retiring write
> requests at much less than 10/sec, which seems unlikely.  Still, that can
> be tuned around.

Then it sounds like the smaller fix below may be better for you.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> RedHat vendor kernels have removed the check entirely

On Wed, Jun 23, 2004 at 05:18:18PM -0700, Andrew Morton wrote:
> When telling us this sort of thing, please always specify the kernel version.
> I assume you're referring to a 2.6 kernel?  If so, some thwapping might be
> in order.

No, RHEL3. I'm not aware of any mm/oom_kill.c changes in any of the
Fedora snapshots.


-- wli

During stress testing at Oracle to determine the maximum number of
clients 2.6 can service, it was discovered that the failure mode of
excessive numbers of clients was kernel deadlock. The following patch
removes the check if (nr_swap_pages > 0) from out_of_memory() as this
heuristic fails to detect memory exhaustion due to pinned allocations,
directly causing the aforementioned deadlock.


===== mm/oom_kill.c 1.26 vs edited =====
--- 1.26/mm/oom_kill.c	Thu Jun  3 01:46:39 2004
+++ edited/mm/oom_kill.c	Wed Jun 23 17:22:22 2004
@@ -230,12 +230,6 @@
 	static unsigned long first, last, count, lastkill;
 	unsigned long now, since;
 
-	/*
-	 * Enough swap space left?  Not OOM.
-	 */
-	if (nr_swap_pages > 0)
-		return;
-
 	spin_lock(&oom_lock);
 	now = jiffies;
 	since = now - last;
