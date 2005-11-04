Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161105AbVKDIuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161105AbVKDIuu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 03:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbVKDIut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 03:50:49 -0500
Received: from gate.terreactive.ch ([212.90.202.121]:16824 "HELO
	toe-A.terreactive.ch") by vger.kernel.org with SMTP
	id S1161105AbVKDIut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 03:50:49 -0500
Message-ID: <436B20DA.5010400@drugphish.ch>
Date: Fri, 04 Nov 2005 09:50:34 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: .
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Grant Coady <gcoady@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.32-rc2
References: <20051031175704.GA619@logos.cnet> <4366E9AA.4040001@gmail.com> <20051101074959.GQ22601@alpha.home.local> <20051101063402.GA3311@logos.cnet> <4367C95D.3050108@drugphish.ch> <20051102002821.GC13557@alpha.home.local> <43689CCF.1060102@drugphish.ch> <20051102122950.GB15515@alpha.home.local> <4369E43A.2080800@drugphish.ch> <20051104000909.GA22017@alpha.home.local>
In-Reply-To: <20051104000909.GA22017@alpha.home.local>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salut Willy,

>>I will send a proper signed-off and acked-by patch against rc2 after
>>some more stress testing. So, please hold off releasing until then. I'm
>>done testing this piece of code by tomorrow noon (GMT+1).
> 
> OK, fine. I'll merge it into next -hf (probably within a few days). Please
> insist loudly if you consider it important to fix quickly because it's a
> real regression, as I don't want to have people wait for long if one hotfix
> causes trouble.

It is absolutely needed. Without it, people will really experience a
long term problem with hanging templates in IPVS, manifesting itself
depending on time and hardware configuration. So I insist that you merge
this patch _NOW_ :).

I'm checking another issue with an asymmetric reference counting which
is not a bug per se (so far) but could serve you with a plate of
unwelcome surprises in the long run as well. This, however is
post-2.4.32 material because I need a couple of 1000s test runs to check
all invariants and configurations.

> OK, if it was your only concern, then I can say that it compiles and
> runs on x86.

Perfect, thanks.

>>You would need to test IPVS on a SMP box using persistent setup and 0
>>port feature and the expire_nodest_conn proc-fs entry set to 1. Hit the
>>LB with 100Mbit/s traffic balancing it on 2-3 RS and reload the
>>configuration using ipvsadm, _but_ without rmmod'ing the ip_vs_* kernel
>>modules. Set the persistency timeout low (60 secs) and the
>>timeout_finwait to 10*HZ. You need 2 clients which connect over a Linux
>>router to a LVS_DR setup, one needs to be router through and the other
>>should be NAT'd on the Linux router using a NAT pool to simulate 100's
>>of clients. This way you have the slashdot-hype and the AOL proxy boost
>>hitting your LB and generating loaded persistency templates which will
>>then hit the code in question, wenn the internal timer expires. You need
>>to grep for NONE in ipvsadm -L -n -c to get the template entries. You
>>must stop the client connecting directly through the Linux router after
>>you reloaded the LB setup and then you observe the persistent template
>>created for this client until the timer expires. Then you start it again
>>and with luck you should see the abberant behaviour of a missed
>>__ip_vs_conn_put(cp) :). I am pretty sure you do not want to go through
>>this setup. I have it here and I'm stress testing all possible
>>combinations of this szenario.
>
> Of course this is not the easiest setup just to chase a bug down. But with
> such an explanation, a good manual on IPVS, and a lot of spare time, it
> could be done if it was the only solution. But I'm not willing to spend
> so much time on this yet :-)

I understand. It took me one week to set this up. Reading the code alone
only made me suspicious.

Have a nice day,
Roberto Nibali, ratz
-- 
-------------------------------------------------------------
addr://Kasinostrasse 30, CH-5001 Aarau tel://++41 62 823 9355
http://www.terreactive.com             fax://++41 62 823 9356
-------------------------------------------------------------
terreActive AG                       Wir sichern Ihren Erfolg
-------------------------------------------------------------
