Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVAUPMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVAUPMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 10:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVAUPMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 10:12:25 -0500
Received: from ns.suse.de ([195.135.220.2]:45220 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262382AbVAUPMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 10:12:22 -0500
Date: Fri, 21 Jan 2005 16:12:18 +0100
From: Andi Kleen <ak@suse.de>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix put_user under mmap_sem in sys_get_mempolicy()
Message-ID: <20050121151218.GA21389@wotan.suse.de>
References: <41F116DB.3BA37CEB@tv-sign.ru> <20050121142908.GA3487@wotan.suse.de> <41F12773.AAC62D5C@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F12773.AAC62D5C@tv-sign.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 07:01:55PM +0300, Oleg Nesterov wrote:
> Andi Kleen wrote:
> >
> > I suppose this simpler patch has the same effect (also untested).
> >
> > 	if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
> > 		return -EINVAL;
> >@@ -502,6 +502,10 @@
> > 			pol = vma->vm_ops->get_policy(vma, addr);
> > 		else
> > 			pol = vma->vm_policy;
> >+		pol2 = mpol_copy(pol);
> >+		up_read(&mm->mmap_sem);
> >+		if (IS_ERR(pol2)) 
> >+			return PTR_ERR(pol2);
> >
> 
> I don't think so. With MPOL_F_ADDR|MPOL_F_NODE sys_get_mempolicy
> calls lookup_node()->get_user_pages() few lines below, so we can't
> up_read(&mm->mmap_sem) here.

True.

> 
> > It's hard to figure out what your patch actually does because
> > of all the gratious white space changes.
> 
> For your convenience here is the code with the patch applied.

Looks reasonable. 

-Andi

P.S.: Again if you really care about these class of deadlocks take a look at
tasklist_lock.

