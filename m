Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261691AbSJAPKy>; Tue, 1 Oct 2002 11:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261692AbSJAPKy>; Tue, 1 Oct 2002 11:10:54 -0400
Received: from dsl-213-023-043-077.arcor-ip.net ([213.23.43.77]:18587 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261691AbSJAPKx>;
	Tue, 1 Oct 2002 11:10:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Richard.Zidlicky@stud.informatik.uni-erlangen.de, zippel@linux-m68k.org
Subject: Re: 2.4 mm trouble [possible lru race]
Date: Tue, 1 Oct 2002 17:12:21 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <200210011420.QAA13868@faui02b.informatik.uni-erlangen.de>
In-Reply-To: <200210011420.QAA13868@faui02b.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wOhB-0005uG-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 16:20, Richard.Zidlicky@stud.informatik.uni-erlangen.de wrote:
> > 
> > The theoretical lru race possibly spotted in the wild...
> > 
> > >
> > > Now I am wondering if that is just coincidence or why m68k hit that 
> > > error so reliably.. is it supposed to have any effect at all on
> > > UP?
> > 
> > Are you running UP+preempt?
> 
> no preempt or anything fancy, m68k vanila 2.4.19 (well almost).

I'm having real trouble spotting substantive change in the patch that
would affect a UP kernel.  I believe you when you say it fixes your
problem, but we don't know why, and it is worth making some effort to
find out why.

Ah wait, I see one candidate, would you like to try:

                 * the page as well.
                 */
                if (page->buffers) {
                        /* avoid to free a locked page */
-                       get_page(page);
                        spin_unlock(&pagemap_lru_lock);
+                       get_page(page);
 
and see if your bug comes back?  There are a couple of other changes
that could be considered substantive by stretching one's imagination
enough, but this is the leading candidate.

Oh wait, you could also try this, a little further down:

+                                       page_cache_release(page);
                                        spin_lock(&pagemap_lru_lock);
-                                       put_page_nofree(page);

By the way, the original patch you posted was reversed and your editor
apparently took the liberty of cleaning up some whitespace in the file.
Generally, we try do avoid patch chunks that just, e.g., change bogus
spaces to tabs, and save those for official whitespace patches.

-- 
Daniel
