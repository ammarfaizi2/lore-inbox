Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292508AbSCDQ4Z>; Mon, 4 Mar 2002 11:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292511AbSCDQ4Q>; Mon, 4 Mar 2002 11:56:16 -0500
Received: from ns.suse.de ([213.95.15.193]:46601 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292508AbSCDQ4E>;
	Mon, 4 Mar 2002 11:56:04 -0500
Date: Mon, 4 Mar 2002 17:56:03 +0100
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Raising an disabled tasklet / VC/KBD initialization bug.
Message-ID: <20020304175603.A17963@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo,

I just ran into the following situation on x86-64 on 2.4.17. I think
2.5 has the same problem. 

For some reason vc_init executed in init order after kbd_init
(they are both indirectly called via __initcall so it can happen) 
vc_init does a tasklet_schedule for the keyboard tasklet in 
set_leds.  The keyboard tasklet had not been enabled yet because kbd_init
didn't execute.
Result was an raised tasklet that wasn't enabled.  schedule was called
and ran the softirqs.  tasklet_action always tried to execute it, but 
returned on the non zero count. The tasklet was still active. ksoftirqd
noticed that and executed do_softirq again -> endless loop. 

For now I just removed the set_leds() call in reset_terminal to work around
it. The real fix would be either to add an mechanism to support raising
of disabled tasklets properly or make sure kbd_init and vc_init have defined
init order and the first always executes before the second. 

Comments? 

-Andi

