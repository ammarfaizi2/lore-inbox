Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269878AbRHWSQW>; Thu, 23 Aug 2001 14:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269868AbRHWSQD>; Thu, 23 Aug 2001 14:16:03 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:58895 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269718AbRHWSP7>; Thu, 23 Aug 2001 14:15:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Stephan von Krawczynski <skraw@ithnet.com>, jlnance@intrex.net
Subject: Re: 2.4.9 VM/VMA subsystem works much better
Date: Thu, 23 Aug 2001 20:22:39 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20010822195810.75425.qmail@web10902.mail.yahoo.com> <20010823031202Z16066-32383+935@humbolt.nl.linux.org> <20010823122958.36fbd525.skraw@ithnet.com>
In-Reply-To: <20010823122958.36fbd525.skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010823181611Z16190-32384+412@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 23, 2001 12:29 pm, Stephan von Krawczynski wrote:
> Daniel Phillips <phillips@bonn-fries.net> wrote:
> 
> > On August 22, 2001 09:58 pm, Brad Chapman wrote:
> > > Everyone,
> > > 
> > > 	Just a note: the VMA sanity patch which went in to 2.4.9
> > > has improved Mozilla's performance considerably. I did a rough
> > > calculation based on startup time and found that Mozilla started
> > > approximately 10%-12% faster on 2.4.9 then 2.4.8. Plus, I've
> > > found that swapping is actually starting to work again, although
> > > it still tends to stick at certain times.
> > > 
> > > 	Great job everyone.
> > 
> > Make sure you have my SetPageReferenced patch in, swap is borked without 
> > it.
> 
> Can you send me the patches you think should cure a straight 2.4.9 for
> re-testing (probably the one from Marcelo Tosatti, too).
> I am from the old school: don't believe what you can't test. :-)

I took the liberty of cc'ing this to the list.  This patch fixes a severe 
swap thrashing problem that was introduced by the use-once patch in 2.4.8.  I 
explained the details elsewhere.  Other than the swap problem (which was just 
an oversight, not a design error) the use-once strategy seems to be working 
fine.  My own anecdotal evidence: before, dpkg --config -a on this box was 
effectively a DoS, now I barely notice it while I'm running other 
applications.

There should be a similar hole in pagemap_nopage affecting memmapped files, 
but nobody has reported it yet.  I presume this is because it's a lot harder 
to trigger.  I'll supply a patch after I've looked at it a little more.

--- ../2.4.9.clean/mm/memory.c	Mon Aug 13 19:16:41 2001
+++ ./mm/memory.c	Sun Aug 19 21:35:26 2001
@@ -1119,6 +1119,7 @@
 			 */
 			return pte_same(*page_table, orig_pte) ? -1 : 1;
 		}
+		SetPageReferenced(page);
 	}
 
 	/*

