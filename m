Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTKYXRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 18:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTKYXRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 18:17:19 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:36572 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S263464AbTKYXRR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 18:17:17 -0500
Message-ID: <3FC3E2F4.4080809@softhome.net>
Date: Wed, 26 Nov 2003 00:17:08 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
References: <3FC358B5.3000501@softhome.net> <Pine.LNX.4.53.0311251510310.6584@chaos>
In-Reply-To: <Pine.LNX.4.53.0311251510310.6584@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> 
> As documented, malloc() will never fail as long as there
> is still address space (not memory) available. This is
> the required nature of the over-commit strategy. This is
> necessary because many programs never even touch all the
> memory they allocate.
> 

   We are reading different mans? My man malloc(3) clearly states that 
malloc() can return NULL. (*)

   May I ask you one question? Did you were ever doing once graceful
failure of application under memory pressure? Looks like not.

   I can guess why sendmail allocates memory it never touches - memory
pools. There are situations where you really cannot fail - and memory
allocation failures are really nasty. Do you wanna to lose your e-mails? 
No? So then think twice, while implementing lazy allocators.

   So from my tests I see that by default Linux is not safe. You allocate
memory - malloc() != NULL. Then later you try to write to this memory
and you get killed by oom_killer. What is the point of this? Your
reasoning doesn't sound to me.

   Memory pools used by applications exactly to make grace error
handling under memory pressure - but it looks like this stuff under
Linux gets no testing at all. And default settings could make from
simple bug complete disaster.

 > You can turn OFF over-commit by doing:
 >
 > echo "2" >proc/sys/vm/overcommit_memory
 >
 > However, you will probably find that many programs fail
 > or seg-fault when normally they wouldn't. So, if you don't
 > mind restarting sendmail occasionally, then turn off over-commit.
 >

   I shall try overcommit_memory == 2 tomorrow and say what I see.

P.S. For example application I have ported right now to kernel space has
a limitiation - it must never ever allocate memory: memory consumption
is known, protocol just have no situation like ENOMEM - it _must_ fail
to initialize on start-up. No - not to being killed by oom_killer in
middle of processing. think carrier grade and/or just good programming
technics.

(*) Great optimization opportunities: remove from all programmes checks 
of the return value if malloc(). As by your words - why not?

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  Because the kernel depends on it existing. "init"          |_|*|_|
  literally _is_ special from a kernel standpoint,           |_|_|*|
  because its' the "reaper of zombies" (and, may I add,      |*|*|*|
  that would be a great name for a rock band).
                                 -- Linus Torvalds


