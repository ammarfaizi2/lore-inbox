Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270031AbRIBWgW>; Sun, 2 Sep 2001 18:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270101AbRIBWgM>; Sun, 2 Sep 2001 18:36:12 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:21925 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S270031AbRIBWf7>;
	Sun, 2 Sep 2001 18:35:59 -0400
Date: Sun, 02 Sep 2001 23:36:07 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: High order memory allocations (was Re: Memory Problem in
 2.4.10-pre2 / __alloc_pages failed)
Message-ID: <1045146040.999473767@[169.254.198.40]>
In-Reply-To: <1041110124.999469713@[169.254.198.40]>
In-Reply-To: <1041110124.999469713@[169.254.198.40]>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Next problem / idea:

memory_pressure sets the target for inactive_target (hence
free_target etc.)

However, if you do (say) and order 5 allocation, memory
pressure is only incremented by 1. This seems illogical,
especially given __alloc_pages does not loop via
try_again, on order>0 allocations (except
when freeshortage() is true) even if __GFP_WAIT
is set (I suspect because it just sits there for
ever). In practice, this means page_launder only
has one shot at freeing sufficient pages, and this
with a wrong inactive target. I propose something
like (whitespace broken - sorry):

--- mm/page_alloc.c.keep   Sun Sep  2 23:32:56 2001
+++ mm/page_alloc.c        Sun Sep  2 23:34:03 2001
@@ -141,8 +141,8 @@
         * since it's nothing important, but we do want to make sure
         * it never gets negative.
         */
-       if (memory_pressure > NR_CPUS)
-               memory_pressure--;
+       if (memory_pressure > (NR_CPUS << order))
+               memory_pressure-= 1<<order;
 }

 #define MARK_USED(index, order, area) \
@@ -288,7 +288,7 @@
        /*
         * Allocations put pressure on the VM subsystem.
         */
-       memory_pressure++;
+       memory_pressure+= 1<<order;

        /*
         * (If anyone calls gfp from interrupts nonatomically then it




--
Alex Bligh
