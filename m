Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264752AbTFLNgZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 09:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264761AbTFLNgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 09:36:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:60043 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264752AbTFLNgX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 09:36:23 -0400
Date: Thu, 12 Jun 2003 19:22:54 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@transmeta.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.70-bk16: nfs crash
Message-ID: <20030612135254.GA2482@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030612125630.GA19842@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612125630.GA19842@butterfly.hjsoft.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 12:57:26PM +0000, John M Flinchbaugh wrote:
> running 2.5.70-bk16, i got this error and hang.  sysrq worked for
> reboot, etc.
> 
> it apparently crashed when it mounted an nfs export from a 2.4.18 box,
> and tried to mv a file.  i doubt it matters, but the nic is an
> orinoco_cs wireless card.  thanks.
> 
> Jun 12 02:00:04 density kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
> Jun 12 02:00:04 density kernel: printing eip:
> Jun 12 02:00:04 density kernel: c0169ef1
> Jun 12 02:00:04 density kernel: *pde = 00000000
> Jun 12 02:00:04 density kernel: Oops: 0002 [#1]
> Jun 12 02:00:04 density kernel: CPU:    0
> Jun 12 02:00:04 density kernel: EIP:    0060:[<c0169ef1>]    Not tainted
> Jun 12 02:00:04 density kernel: EFLAGS: 00010246
> Jun 12 02:00:04 density kernel: EIP is at d_move+0x51/0x250
> Jun 12 02:00:04 density kernel: eax: 00000000   ebx: cd5e6960   ecx: cd5e69d0   edx: 00000000

I am not supprised at all by this, I can see two csets in Linus' tree 
that will definitely break dcache -

1. http://linux.bkbits.net:8080/linux-2.5/cset@1.1215.104.2?nav=index.html|ChangeSet@-2d

__d_drop() *must not* initialize d_hash fields. Lockfree lookup depends on
that. If __d_drop() needs to be allowed on an unhashed dentry, the right
thing to do would be to check for DCACHE_UNHASHED before unhashing. I will
submit a patch a little later to do this.


2. http://linux.bkbits.net:8080/linux-2.5/cset@1.1215.104.1?nav=index.html|ChangeSet@-2d

hlist poison patch is broken. list_del_rcu() and hlist_del_rcu() 
*must not* re-initialize the pointers. Maneesh submitted a patch
earlier today that corrects this -

http://marc.theaimsgroup.com/?l=linux-kernel&m=105541206017154&w=2


Thanks
Dipankar
