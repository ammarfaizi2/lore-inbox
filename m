Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTKQSg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 13:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbTKQSg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 13:36:28 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:64154 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S263653AbTKQSg0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 13:36:26 -0500
Message-ID: <3FB91527.50007@softhome.net>
Date: Mon, 17 Nov 2003 19:36:23 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Q] jiffies overflow & timers.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    [ ver 2.4.18/22 ]

    [ I feel strongly that is FAQ - so any ptr(RTFM)!=0 apreciated. ]

    [ ldd2 covers this very sparsely - overflow case is not covered at 
all - just mentioned. Google - looks like I cannot find right keywords 
for this ... ]

    I'm trying to find correct solution for case of jiffies overflow and 
standard kernel timers (./kernel/timer.c).

    My module has to maintain list of timers. I cannot reuse directly 
struct timer_list - since it uses jiffies and jiffies do wrap on overflow.

    I decided to use struct timeval & do_gettimeofday(). But still I 
have to handle case when next timer to expire will happend after jiffies 
will overflow.

   So my question - how to detect that jiffies had overflown?

   Is the following code is sufficient?
   (Assuming that I will not try to set timer longer than (~0UL/(HZ)) 
seconds)

unsigned long
tv_get_next_expiring_jiffies( struct timeval *target_tv )
{
   struct timeval curr_tv, timeout;
   ulong dif_jif;

   do_gettimeofday( &curr_tv );

   /* timeout = curr_tv - target_tv */
   tv_sub( &timeout, &curr_tv, target_tv );

   dif_jif = tv_to_jiffies( &timeout );   /* assumption above. */

   if (jiffies > ~0UL - dif_jif) {
       /* will overflow
        * so wait for overflow, then just reschedule
        */
       return ~0UL;
   } else {
       /* will not */
       return jiffies + dif_jif;
   }
}

Is (~0UL) "safe harbour"? in other words - will this value reached? /me 
cannot find where jiffies is incremented... Dumd grep -r jiffies gives 
no results (no assignment, no taking of pointer, literally no matches in 
.S files - what I'm missing?) Because if this value will be reached and 
I will detect that jiffies == ~0UL I will have to "while(jiffies == 
~0UL);" wait for overflow.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|

