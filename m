Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVFJV7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVFJV7t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 17:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVFJV7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 17:59:48 -0400
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:9863 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S261258AbVFJV7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 17:59:44 -0400
Message-ID: <42AA0D03.2090505@lifl.fr>
Date: Fri, 10 Jun 2005 23:58:27 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: linux-kernel@vger.kernel.org, bhuey@lnxw.com, andrea@suse.de,
       tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
References: <42A714B7.8010105@lifl.fr> <20050609022041.GG1295@us.ibm.com>
In-Reply-To: <20050609022041.GG1295@us.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@lifl.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06/09/2005 04:20 AM, Paul E. McKenney wrote/a écrit:
 >>Concerning the QoS, we have been able to obtain hard realtime, at least
 >>very firm real-time. Tests were conducted over 8 hours on IA-64 and x86
 >>and gave respectively 105µs and 40µs of maximum latency. Not as good as
 >>you have mentioned but mostly of the same order :-)
 >
 >
 > Quite impressive!  So, does this qualify as "ruby hard", or is it only
 > "metal hard"?  ;-)
Well, you have to consider that this is still full Linux running. All 
the best we can do is to not make it crash or hung more than the vanilla 
kernel, it's still vulnerable to any bug of any driver :-/ In addition, 
I highly doubt this approach can ever have an implementation were the 
maximum latency is theoritically proven. The best we have is just 
measurements of the system running with high loads during very long time.

 >
 > The service measured was process scheduling, right?
Yes, on IA64, from the hardware IRQ fireing to process scheduling (on 
x86 it's from kernel IRQ handling to process scheduling).

 >>Concerning the "e. fault isolation", on our implementation, holding a
 >>lock, mutex or semaphore will automatically migrate the task, therefore
 >>it's not a problem. Of course, some parts of the kernel that cannot be
 >>migrated might take a lock, namely the scheduler. For the scheduler, we
 >>modified most of the data structures requiring a lock so that they can
 >>be accessed locklessly (it's the hardest part of the implementation).
 >
 >
 > Are the non-migrateable portions of the scheduler small enough that
 > one could do a worst-case timing analysis?  Preferably aided by some
 > automation...
Well, ARTiS only modifies the schedule() function but there is probably 
too much possible interaction to really be able to prove anything (the 
fact that it's a SMP system doesn't help!).


 > One approach would be to mark the migrated task so that it returns
 > to the realtime CPU as soon as it completes the realtime-unsafe
 > operation.
We use a different approach: keep (small) statistics of the task doing 
often lock and the one that are more "computational". Then we migrate in 
priority the tasks that don't do locks. Your suggestion could be used 
at the same time but it might not be so efficient anymore. Additionally, 
in the current implementation, it's not so easy to know when a task 
which is running can go back to a RT CPU.



 > Another approach is to insert a virtualization layer (think in terms of
 > a very cut-down variant of Xen) that tells the OS that there are two 
CPUs.
 > This layer then gives realtime service to one, but not to the other.
 > That way, the OS thinks that it has two CPUs, and can still do the
 > migration tricks despite having only one real CPU.
Simulation of an SMP on a UP? This sounds quite heavy but it might be 
interesting to try :-)


 >
 > Anyway, interesting approach!
Thanks,

Eric
