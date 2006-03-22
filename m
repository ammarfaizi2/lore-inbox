Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWCVAaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWCVAaO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWCVAaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:30:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53969 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751253AbWCVAaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:30:11 -0500
Date: Tue, 21 Mar 2006 16:32:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bernd Schmidt <bernds_cb1@t-online.de>
Cc: luke.adi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2]Blackfin archtecture patche for 2.6.16
Message-Id: <20060321163228.34bf21ad.akpm@osdl.org>
In-Reply-To: <44209009.1010405@t-online.de>
References: <489ecd0c0603200200va747a68k187651930a3f0a51@mail.gmail.com>
	<20060321031457.69fa0892.akpm@osdl.org>
	<44209009.1010405@t-online.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schmidt <bernds_cb1@t-online.de> wrote:
>
> Luke is probably still asleep at this time of night, so I'll try to 
> answer what I can...
> 
> Andrew Morton wrote:
> > "Luke Yang" <luke.adi@gmail.com> wrote:
> >>    This is the Blackfin archtecture patch for kernel 2.6.16.
> > 
> > - We don't want to be putting 44000 lines of new code in the kernel and
> >   then have it rot.  Who will support this in the long-term?  What
> >   resources are behind it?  IOW: what can you say to convince us that it
> >   won't rot?
> 
> We're a team inside Analog Devices who are maintaining a GNU toolchain, 
> uClinux kernel, and user space apps for the Blackfin.  All of this is 
> available on our blackfin.uclinux.org site.  We do not expect to go away 
> anytime soon.

OK.  Thanks for the contributions.

> ...
> >   We'd need to see some sort of authorisation from the original authors
> >   for the inclusion of their code.  Preferably in the form of
> >   Signed-off-by:s.  
> 
> I'll pass that along to the right people.  Would a "Signed-off-by: 
> Analog Devices" (similar to our FSF copyright assignments) be ok or does 
> it have to be individuals?  I believe the port actually predates the 
> involvement of most of the people working on it now.

I think names of individuals would be preferred - the Signed-off-by: is
often used when hunting down maintainers/developers to bug about problems. 
Although as it's a single megapatch, that's less useful in this case.

If we go with the single signed-off-by: I guess it would be best if that
was a person within AD who is in a position to authorise the merge.  If you
say that person is yourself or Luke then fine.

> > - Do you really need to support old_mmap()?
> 
>  From what I can tell, no we don't, although we'll have to make a small 
> change to our uClibc.  (A lot of this code got copied from the m68k port 
> initially... that may explain a few things).
> 
> > - Too much use of open-coded `volatile'.  The objective should be to have
> >   zero occurrences in .c files.  And volatile sometimes creates suspicion
> >   even when it's used in .h files.
> 
> Are you referring to the ones in 
> include/asm-blackfin/mach-bf533/cdefBF532.h?  These are memory-mapped 
> hardware registers (MMRs); do you have any better suggestions how to 
> access these?  That file actually comes from our in-house Visual DSP 
> compiler, and while there may be better ways of accessing the register 
> than those macros, there is something to be said for being able to drop 
> in a replacement if future chips have different addresses for these 
> registers.
> 
> The Blackfin has a lot of peripherals sitting on the same die as the 
> core, and they're all accessed through MMRs.

readl/writel and friends would be the preferred way of accessing
memory-mapped registers.  If that doesn't work then at least you should
wrap the volatile cast into a single inlined function somewhere so it's not
splattered everywhere.  That way the code is more pleasing to read and we
eliminate the risk that someone forgets to add the cast.

