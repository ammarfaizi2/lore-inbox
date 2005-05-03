Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVECOwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVECOwN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVECOtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:49:11 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:11707 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261642AbVECOon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:44:43 -0400
Date: Tue, 3 May 2005 20:28:35 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC PATCH] Dynamic sched domains (v0.5)
Message-ID: <20050503145835.GA9493@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050501190947.GA5204@in.ibm.com> <4275F665.1010101@yahoo.com.au> <20050502171619.GA4418@in.ibm.com> <4276B667.2050905@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4276B667.2050905@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >On Mon, May 02, 2005 at 07:44:05PM +1000, Nick Piggin wrote:
> 
> What are you protecting against, though? synchroinze_kernel can
> sleep, so local_irq_disable is probably the wrong thing to do as well.

Paul, any reason why code marked "####" (fn cpuset_rmdir) is under 
the dentry lock ??

	spin_lock(&cs->dentry->d_lock);
        parent = cs->parent;			####
        set_bit(CS_REMOVED, &cs->flags);	####
        if (is_cpu_exclusive(cs))
                update_cpu_domains(cs);
        list_del(&cs->sibling); /* delete my sibling from parent->children */
        if (list_empty(&parent->children))
                check_for_release(parent);
        d = dget(cs->dentry);			<----
        cs->dentry = NULL;			<----
        spin_unlock(&d->d_lock);


As far as I can see only the ones marked "<----" should be under the
dentry lock, considering the fact that it already holds the cpuset_sem
all the while.

I saw that calling update_cpu_domains with the dentry lock held,
causes it to oops with preempt turned on. (Scheduling while atomic)

	-Dinakar
