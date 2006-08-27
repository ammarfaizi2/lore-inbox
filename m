Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWH0RpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWH0RpJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 13:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWH0RpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 13:45:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10988 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932207AbWH0RpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 13:45:07 -0400
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for i386.
From: Arjan van de Ven <arjan@infradead.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <44F1CC67.8040807@goop.org>
References: <20060827084417.918992193@goop.org>
	 <1156672071.3034.103.camel@laptopd505.fenrus.org>
	 <44F1CC67.8040807@goop.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 27 Aug 2006 19:44:23 +0200
Message-Id: <1156700663.3034.118.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-27 at 09:46 -0700, Jeremy Fitzhardinge wrote:
> Arjan van de Ven wrote:
> > this will be interesting; x86-64 has a nice instruction to help with
> > this; 32 bit does not... so far conventional wisdom has been that
> > without the instruction it's not going to be worth it.
> >   
> 
> Hm, swapgs may be quick, but it isn't very easy to use since it doesn't 
> stack, and so requires careful handling for recursive kernel entries, 
> which involves extra tests and conditional jumps.  I tried doing 
> something similar with my earlier patches, but it got all too messy.  
> Stacking %gs like the other registers turns out pretty cleanly.
> 
> > When you're benchmarking this please use multiple CPU generations from
> > different vendors; I suspect this is one of those things that vary
> > greatly between models
> >   
> 
> Hm, it seems to me that unless the existing %ds/%es register 
> save/restores are a significant part of the existing cost of going 
> through entry.S, 

iirc the %fs one is at least. But it has been a while since I've looked
at this part of the kernel via performance traces.

> adding %gs to the set shouldn't make too much 
> difference.  And I'm not sure about the relative cost of using a %gs 
> override vs. the normal current_task_info() masking, but I'm assuming 
> they're at worst equal, with the %gs override having a code-size advantage.

your worst case scenario would be if the segment override would make it
a "complex" instruction, so not parallel decodable. That'd mean it would
basically cost you 6 or 7 instruction slots that can't be filled...
while an and and such at least run nicely in parallel with other stuff.
I don't know which if any processors actually do this, but it's rare/new
enough that I'd not be surprised if there are some.



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

