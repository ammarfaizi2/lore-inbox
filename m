Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265182AbTFRMOM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 08:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265188AbTFRMOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 08:14:12 -0400
Received: from pop.gmx.de ([213.165.64.20]:22725 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265182AbTFRMOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 08:14:07 -0400
Message-Id: <5.2.0.9.2.20030618141902.02773c18@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 18 Jun 2003 14:32:14 +0200
To: Helge Hafting <helgehaf@aitel.hist.no>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: O(1) scheduler starvation
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>, davidm@hpl.hp.com,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3EF05816.6050307@aitel.hist.no>
References: <5.2.0.9.2.20030618113653.0277d780@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:16 PM 6/18/2003 +0200, Helge Hafting wrote:
>Mike Galbraith wrote:
>>At 09:53 AM 6/18/2003 +0200, Felipe Alfaro Solana wrote:
>>
>>>Hi!
>>>
>>>I've been poking around and found the following link on O(1) scheduler
>>>starvation problems:
>>>
>>>http://www.hpl.hp.com/research/linux/kernel/o1-starve.php
>>>
>>>The web page contains a small test program which supposedly is able to
>>>make two processes starvate. However, I've been unable to reproduce what
>>>is described in the above link. In fact, the CPU usage ratio ranges
>>>between 60-40% or 70-30% in the worst cases.
>>
>>(you're talking about with my monotinic_clock() diff in your kernel right?)
>>If you examine the priorities vs cpu usage, therein lies a big fat bug.
>>I think the fundamental problem is that you can only execute in series, 
>>but can sleep in parallel, which makes for more sleep time existing than 
>>all execution time combined.
>
>Would dividing the sleep time by the number of sleepers fix this?
>Or is division a too heavy operation here?

That won't work.  You'd have to plunk it all into a pot, and divvy it up by 
%cpu usage or something.  I solved it the simple way.  I keep a smoothed 
run_avg (%cpu * 100), and use that as a sleep_avg limit... ie if you're 
run_avg is 9000 (you're eating 10% cpu), no sleep will push you into 
insanity land.  I still have the problem that tasks will seek their 
appropriate priority level and _stick_ there, so I probably need to add 
some decay. (which will no doubt open the next can-O-worms)

         -Mike 

