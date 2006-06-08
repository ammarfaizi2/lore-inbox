Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWFHFAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWFHFAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 01:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWFHFAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 01:00:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61888 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751183AbWFHFAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 01:00:53 -0400
Date: Thu, 8 Jun 2006 01:00:47 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6-mm1
Message-ID: <20060608050047.GB16729@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060607104724.c5d3d730.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060607104724.c5d3d730.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 10:47:24AM -0700, Andrew Morton wrote:
 > 
 > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/
 > 
 > - Many more lockdep updates

Needs more.

====================================
[ BUG: possible deadlock detected! ]
------------------------------------
nfsd/11429 is trying to acquire lock:
 (&inode->i_mutex){--..}, at: [<c032286a>] mutex_lock+0x21/0x24

but task is already holding lock:
 (&inode->i_mutex){--..}, at: [<c032286a>] mutex_lock+0x21/0x24

which could potentially lead to deadlocks!

other info that might help us debug this:
2 locks held by nfsd/11429:
 #0:  (hash_sem){----}, at: [<d10d0364>] exp_readlock+0x0/0x3e [nfsd]
 #1:  (&inode->i_mutex){--..}, at: [<c032286a>] mutex_lock+0x21/0x24

stack backtrace:
 [<c0104966>] show_trace_log_lvl+0x54/0xfd
 [<c0104f1a>] show_trace+0xd/0x10
 [<c010502f>] dump_stack+0x19/0x1b
 [<c013b2d4>] __lockdep_acquire+0x8f6/0x912
 [<c013b346>] lockdep_acquire+0x56/0x6f
 [<c03226cf>] __mutex_lock_slowpath+0xae/0x228
 [<c032286a>] mutex_lock+0x21/0x24
 [<d10cdb64>] nfsd_setattr+0x2d3/0x49f [nfsd]
 [<d10ceecd>] nfsd_create_v3+0x319/0x4aa [nfsd]
 [<d10d413e>] nfsd3_proc_create+0x125/0x135 [nfsd]
 [<d10ca0d4>] nfsd_dispatch+0xc0/0x178 [nfsd]
 [<d0ee89e9>] svc_process+0x38d/0x5d5 [sunrpc]
 [<d10ca581>] nfsd+0x18b/0x302 [nfsd]
 [<c0102005>] kernel_thread_helper+0x5/0xb


It's too close to bedtime for me, and on a cursory examination,
I don't even see where nfsd_setattr touches a mutex.

This was triggered by a simple 'touch foo' over an nfs v3 mount.

		Dave

-- 
http://www.codemonkey.org.uk
