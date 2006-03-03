Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWCDAAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWCDAAQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 19:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWCDAAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 19:00:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11197 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751766AbWCDAAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 19:00:14 -0500
Date: Fri, 3 Mar 2006 15:59:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: bunk@stusta.de, ".geert"@linux-m68k.org, zippel@linux-m68k.org,
       linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: 2.6.16-rc regression: m68k CONFIG_RMW_INSNS=n compile broken
Message-Id: <20060303155913.2e299736.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603031515321.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
	<20060303230149.GB9295@stusta.de>
	<Pine.LNX.4.64.0603031515321.22647@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Sat, 4 Mar 2006, Adrian Bunk wrote:
> > 
> > It seems the problem is that in the CONFIG_RMW_INSNS=n case, there's no 
> > cmpxchg #define in include/asm-m68k/system.h required for the 
> > atomic_add_unless #define in include/asm-m68k/atomic.h.
> 
> Hmm. It seems like it never has been there.. Do you know what brought this 
> on? Was it Nick's RCU changes from "rcuref_dec_and_test()" to 
> "atomic_dec_and_test()" and friends? 
> 
> Judging by your error messages, I _think_ it's the "atomic_inc_not_zero()" 
> that gets expanded to a cmpxchg() that simply doesn't exist on m68k and 
> never has.
> 
> I guess we've never depended on cmpxchg before. Or am I missing something?
> 

Yes, we now require cmpxchg of all architectures.

It's pretty simple to fix - just use local_irq_save().  We can steal the code
from include/asm-m68knommu/system.h.
