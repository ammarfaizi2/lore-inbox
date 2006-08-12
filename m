Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWHLCdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWHLCdI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 22:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWHLCdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 22:33:08 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:21645 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932471AbWHLCdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 22:33:07 -0400
Date: Fri, 11 Aug 2006 22:27:25 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: + espfix-code-cleanup.patch added to -mm tree
To: Stas Sergeev <stsp@aknet.ru>
Cc: Zachary Amsden <zach@vmware.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jan Beulich <jbeulich@novell.com>
Message-ID: <200608112230_MC3-1-C7D2-A98F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44CF474C.9070800@aknet.ru>

On Tue, 01 Aug 2006 16:21:32 +0400, Stas Sergeev wrote:

> >> -    .quad 0x0000920000000000    /* 0xd0 - ESPFIX 16-bit SS */
> >> +    .quad 0x00cf92000000ffff    /* 0xd0 - ESPFIX SS */

> > Seems a bit dangerous to allow access to full 4GB through this.  Can you 
> > tighten the limit any?  I suppose not, because the high bits in %esp 
> > really could be anything.  But it might be nice to try setting the limit 
> > to regs->esp + THREAD_SIZE.  Of course, this is not strictly necessary, 
> > just an extra paranoid protection mechanism.

> Since, when calculating the base, I do &-THREAD_SIZE, I guess the minimal
> safe limit is regs->esp + THREAD_SIZE*2... Well, may just I not do that please? :)
> For what, btw? There are no such a things for __KERNEL_DS or anything, so
> I just don't see the necessity.

It's really not that hard to get the limit:

        limit_in_bytes = new_esp | (THREAD_SIZE - 1)
        limit_in_pages = limit_in_bytes >> 12

And this will catch any bad accesses that assume zero-based pointers:

        kernel stack is at f7000000
        user stack is at   b7000000

        SS base =  40000000
        SS limit = b7001fff

All kernel pointers will be >c0000000 and will trap on access if they
try to use SS.  And it will work with any user/kernel split.

-- 
Chuck

