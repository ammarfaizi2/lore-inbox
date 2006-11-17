Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933584AbWKQNIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933584AbWKQNIS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 08:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933585AbWKQNIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 08:08:18 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.16]:17740 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S933584AbWKQNIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 08:08:17 -0500
Subject: Re: Re : vm: weird behaviour when munmapping
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061117125046.22496.qmail@web23102.mail.ird.yahoo.com>
References: <20061117125046.22496.qmail@web23102.mail.ird.yahoo.com>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 14:05:42 +0100
Message-Id: <1163768742.5968.108.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 12:50 +0000, moreau francis wrote:
> Peter Zijlstra wrote:
> > 
> > http://lwn.net/Kernel/LDD3/
> > 
> > Chapter 15. Section 'Virtual Memory Areas'.
> > 
> > Basically; vm_ops->open() is not called on the first vma. With this
> > munmap() you split the area in two, and it so happens the new vma is the
> > lower one.
> > 
> 
> since I did "munmap(0x2aaae000, 1024)" I would say that the the new vma
> is the _upper_ one.
> 
> lower vma: 0x2aaae000 -> 0x2aaaf000
> upper vma: 0x2aaaf000 -> 0x2aab2000

that is the remaining VMA, not the new one; we trigger this code:

	/* Does it split the last one? */
	last = find_vma(mm, end);
	if (last && end > last->vm_start) {
		int error = split_vma(mm, last, end, 1);
		if (error)
			return error;
	}

So, since its the last VMA that needs to be split (there is only one),
the new VMA is constructed before the old one. Like so:

  AAAAAAAAAAAAAAAAAAAAA
  BBBBAAAAAAAAAAAAAAAAA

Then you proceed closing, in this case the new one: B.


