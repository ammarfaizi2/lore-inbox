Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265813AbUFSEZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265813AbUFSEZy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 00:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUFSEZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 00:25:54 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:51946 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265813AbUFSEZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 00:25:44 -0400
Subject: Re: Atomic operation for physically moving a page (for memory
	defragmentation)
From: Dave Hansen <haveblue@us.ibm.com>
To: Ashwin Rao <ashwin_s_rao@yahoo.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20040619031536.61508.qmail@web10902.mail.yahoo.com>
References: <20040619031536.61508.qmail@web10902.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1087619137.4921.93.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 21:25:38 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 20:15, Ashwin Rao wrote:
> The problem is the memory fragmentation. The code i am
> writing is for the memory defragmentation as proposed
> by Daniel Phillips, my project partner Alok mooley has
> given mailed a simple prototype in the mid of feb.

Ahhh....  *That* code :)  Do you have an updated version you'd like to
share?  I'm curious how you integrated the suggestions from February.  

> > (*) Yes, I know the BKL isn't something you want to
> > grab if you can help it.
> 
> Isnt it a bad idea to take the BKL, the performance of
> SMP systems will drastically be hampered.

Only during a defragment operation.  Are you planning to run the system
under constant defragmentation?

> > However, if we're on an unlikely error path or
> > similar and other options aren't suitable...
> 
> Maintaining atomicity in uniprocessor systems is easy
> by preempt_enable and preempt_disable during the
> operation. This implementation cannot be used for SMP
> systems. 
> Now during the time a page is copied/updatede if a
> page is accessed the copied contents become invalid,
> as updation is not done. Also during updation a
> similar situation might arise.
> The problem we are facing is to maintain the atomicity
> of this operation on SMP boxes.

I think what you really want to do is keep anybody else from making a
new pte to the page, once you've invalidated all of the existing ones,
right?

Holding a lock_page() should do the trick.  Anybody that goes any pulls
the page out of the page cache has to do a lock_page() and check
page->mapping before they can establish a pte to it, so you can stop
that.  Since you're invalidating page->mapping before you move the page
(you *are* doing this, right?), it will end up working itself out.  

-- Dave

