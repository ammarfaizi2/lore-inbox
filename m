Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292560AbSCDRfm>; Mon, 4 Mar 2002 12:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292601AbSCDRff>; Mon, 4 Mar 2002 12:35:35 -0500
Received: from www.transvirtual.com ([206.14.214.140]:49934 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S292560AbSCDRfZ>; Mon, 4 Mar 2002 12:35:25 -0500
Date: Mon, 4 Mar 2002 09:35:14 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Raising an disabled tasklet / VC/KBD initialization bug.
In-Reply-To: <20020304175603.A17963@wotan.suse.de>
Message-ID: <Pine.LNX.4.10.10203040928490.20983-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For some reason vc_init executed in init order after kbd_init
> (they are both indirectly called via __initcall so it can happen) 
> vc_init does a tasklet_schedule for the keyboard tasklet in 
> set_leds.  The keyboard tasklet had not been enabled yet because kbd_init
> didn't execute.
> Result was an raised tasklet that wasn't enabled.  schedule was called
> and ran the softirqs.  tasklet_action always tried to execute it, but 
> returned on the non zero count. The tasklet was still active. ksoftirqd
> noticed that and executed do_softirq again -> endless loop. 

Really good spotting. 

> For now I just removed the set_leds() call in reset_terminal to work around
> it. The real fix would be either to add an mechanism to support raising
> of disabled tasklets properly or make sure kbd_init and vc_init have defined
> init order and the first always executes before the second. 

I'm working on a fix right now. As gor calling kbd_init before vc_init
that is a bad idea as all keyboard drivers are being moved over to the
input api. Plus the console system will soon support hotplug of devices.
The proper fix is to test the kam flag in struct vc_data. Will send a
patch to be included in the dave jones tree.



