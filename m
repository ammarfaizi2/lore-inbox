Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755091AbWKQNv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091AbWKQNv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 08:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755095AbWKQNvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 08:51:25 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.16]:37216 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1755091AbWKQNvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 08:51:25 -0500
Subject: Re: Re : vm: weird behaviour when munmapping
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061117134325.62026.qmail@web23114.mail.ird.yahoo.com>
References: <20061117134325.62026.qmail@web23114.mail.ird.yahoo.com>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 14:48:50 +0100
Message-Id: <1163771330.5968.115.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 13:43 +0000, moreau francis wrote:
> Peter Zijlstra wrote:
> > On Fri, 2006-11-17 at 12:50 +0000, moreau francis wrote:
> >>
> >> lower vma: 0x2aaae000 -> 0x2aaaf000
> >> upper vma: 0x2aaaf000 -> 0x2aab2000
> > 
> > that is the remaining VMA, not the new one; we trigger this code:
> > 
> >     /* Does it split the last one? */
> >     last = find_vma(mm, end);
> >     if (last && end > last->vm_start) {
> >         int error = split_vma(mm, last, end, 1);
> >         if (error)
> >             return error;
> >     }
> > 
> > So, since its the last VMA that needs to be split (there is only one),
> > the new VMA is constructed before the old one. Like so:
> > 
> >   AAAAAAAAAAAAAAAAAAAAA
> >   BBBBAAAAAAAAAAAAAAAAA
> > 
> > Then you proceed closing, in this case the new one: B.
> 
> Sorry but I don't understand why B is said to be the new one. OK
> I can see why from the bit of code you pointed out but from a
> logical point of view (ok maybe be me only) I'm unmapping 'BBBB'
> segment, so 'BBBB' is going to be destroyed and therefore A is
> the new one. Thereferore I would expect close(B), open(A)...
> 
> no ?

No indeed. You seem confused with remaining and new. 

It has one VMA (A) it needs to split that into two pieces, it happens to
do it like (B,A') where A' is the old VMA object with new a start
address, and B is a new VMA object.

If you'd unmapped the tail end of your region you'd then see a close of
A' but you happen to unmap the head so you'll see B closed.

vm_ops->open() is called on new VMA objects, in this scenario B is the
only new object created. A -> A' is not creating a new object just
modifying an old one.

