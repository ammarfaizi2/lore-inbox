Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261596AbSJ2F7O>; Tue, 29 Oct 2002 00:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261597AbSJ2F7O>; Tue, 29 Oct 2002 00:59:14 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:13203 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261596AbSJ2F7N>;
	Tue, 29 Oct 2002 00:59:13 -0500
Date: Tue, 29 Oct 2002 11:41:33 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Mingming Cao <cmm@us.ibm.com>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]updated ipc lock patch
Message-ID: <20021029114133.B30576@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20021029013059.A13287@dikhow> <20021028222738.3316B2C4D9@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021028222738.3316B2C4D9@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Oct 29, 2002 at 08:41:19AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 08:41:19AM +1100, Rusty Russell wrote:
> 	If all current uses are embedded, can we remove the "void
> *arg" and reduce the size of struct rcu_head by 25%?  Users can always
> embed it in their own struct which has a "void *arg", but if that's
> the uncommon case, it'd be nice to slim it a little.

All current cases are not embedded, synchronize_kernel() needs
"arg" :-)

> 
> 	It'd also be nice to change the double linked list to a single
> too: as far as I can tell the only issue is the list_add_tail in
> call_rcu(): how important is this ordering?  It can be done by keeping
> a head as well as a tail pointer if required.

I can't see how the ordering of the RCU updates matter, so we can 
trivially change things internally without affecting the interface. 

That said, I disagree about the bloat issue, I don't see a problem there, 
atleast not yet. All the uses that I have seen so far, the additional "prev"
pointer is a very small fraction of the total memory allocated for
the objects. And it is certainly not an issue with IPC - just look
at the values for SHMMNI, SEMMNI etc.

> We must be looking at different variants of the patch.  This one does:
> IPC_RMID -> freeary() -> ipc_rcu_free -> kmalloc.
> 

Grr... I thought Mingming's patch modified only IPC common code
and was looking at the mm6 tree directly. My earlier suggestion
is valid only if RCU head allocation is limited to grow_ary(). Otherwise,
rcu_head should be embedded.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
