Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbVKCKTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbVKCKTs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 05:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVKCKTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 05:19:48 -0500
Received: from gate.terreactive.ch ([212.90.202.121]:64871 "HELO
	toe-A.terreactive.ch") by vger.kernel.org with SMTP id S964791AbVKCKTr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 05:19:47 -0500
Message-ID: <4369E43A.2080800@drugphish.ch>
Date: Thu, 03 Nov 2005 11:19:38 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: .
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Grant Coady <gcoady@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.32-rc2
References: <20051031175704.GA619@logos.cnet> <4366E9AA.4040001@gmail.com> <20051101074959.GQ22601@alpha.home.local> <20051101063402.GA3311@logos.cnet> <4367C95D.3050108@drugphish.ch> <20051102002821.GC13557@alpha.home.local> <43689CCF.1060102@drugphish.ch> <20051102122950.GB15515@alpha.home.local>
In-Reply-To: <20051102122950.GB15515@alpha.home.local>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>CONFIG_ACPI=y
>>CONFIG_ACPI_BOOT=y
>>CONFIG_ACPI_BUS=y
>>CONFIG_ACPI_INTERPRETER=y
>>CONFIG_ACPI_EC=y
>>CONFIG_ACPI_POWER=y
>>CONFIG_ACPI_PCI=y
>>CONFIG_ACPI_MMCONFIG=y
>>CONFIG_ACPI_SLEEP=y
>>CONFIG_ACPI_SYSTEM=y
> 
> But this is purely x86-related, I won't have it on sparc.

Indeed ;).

>>CONFIG_IP_VS=m
>>CONFIG_IP_VS_DEBUG=y
>>CONFIG_IP_VS_TAB_BITS=12
>>CONFIG_IP_VS_RR=m
>>CONFIG_IP_VS_WRR=m
>>CONFIG_IP_VS_LC=m
>>CONFIG_IP_VS_WLC=m
>>CONFIG_IP_VS_LBLC=m
>>CONFIG_IP_VS_LBLCR=m
>>CONFIG_IP_VS_DH=m
>>CONFIG_IP_VS_SH=m
>>CONFIG_IP_VS_SED=m
>>CONFIG_IP_VS_NQ=m
>>CONFIG_IP_VS_HPRIO=m
>>CONFIG_IP_VS_FTP=m
>>
>>One issue is a possible C99'ism in the last IPVS patch. If you find
>>time, please have a 2.95.x compiler installed.
>  
> You mean that it's a build issue ? I first thought that you got erroneous
> behaviour.

Yes, the erroneous stuff I'm tracking down and it looks like I've found
it (actually, Julian Anastasov fixed it):

diff -ur v2.4.32-rc2/linux/net/ipv4/ipvs/ip_vs_core.c
linux/net/ipv4/ipvs/ip_vs_core.c
--- v2.4.32-rc2/linux/net/ipv4/ipvs/ip_vs_core.c	2005-11-03
01:20:02.000000000 +0200
+++ linux/net/ipv4/ipvs/ip_vs_core.c	2005-11-03 01:22:36.347895544 +0200
@@ -1111,11 +1111,10 @@
 		if (sysctl_ip_vs_expire_nodest_conn) {
 			/* try to expire the connection immediately */
 			ip_vs_conn_expire_now(cp);
-		} else {
-			/* don't restart its timer, and silently
-			   drop the packet. */
-			__ip_vs_conn_put(cp);
 		}
+		/* don't restart its timer, and silently
+		   drop the packet. */
+		__ip_vs_conn_put(cp);
 		return NF_DROP;
 	}

I will send a proper signed-off and acked-by patch against rc2 after
some more stress testing. So, please hold off releasing until then. I'm
done testing this piece of code by tomorrow noon (GMT+1).

What I wasn't sure is if the latest patches still compiled on 2.95.x
gcc. That's the only thing I wanted you to test. I cannot ask you to run
fully fledged LVS tests, as this requires quite some setup time.

> How could I stress it ? what ipvs config, what type of traffic ? I'm used
> to stress-test firewalls and load-balancers, but there is a wide choice of
> possibilities, and all cannot be explored in a short timeframe.

You would need to test IPVS on a SMP box using persistent setup and 0
port feature and the expire_nodest_conn proc-fs entry set to 1. Hit the
LB with 100Mbit/s traffic balancing it on 2-3 RS and reload the
configuration using ipvsadm, _but_ without rmmod'ing the ip_vs_* kernel
modules. Set the persistency timeout low (60 secs) and the
timeout_finwait to 10*HZ. You need 2 clients which connect over a Linux
router to a LVS_DR setup, one needs to be router through and the other
should be NAT'd on the Linux router using a NAT pool to simulate 100's
of clients. This way you have the slashdot-hype and the AOL proxy boost
hitting your LB and generating loaded persistency templates which will
then hit the code in question, wenn the internal timer expires. You need
to grep for NONE in ipvsadm -L -n -c to get the template entries. You
must stop the client connecting directly through the Linux router after
you reloaded the LB setup and then you observe the persistent template
created for this client until the timer expires. Then you start it again
and with luck you should see the abberant behaviour of a missed
__ip_vs_conn_put(cp) :). I am pretty sure you do not want to go through
this setup. I have it here and I'm stress testing all possible
combinations of this szenario.

Thanks for your help, Willy.

A bientôt,
Roberto Nibali, ratz
-- 
-------------------------------------------------------------
addr://Kasinostrasse 30, CH-5001 Aarau tel://++41 62 823 9355
http://www.terreactive.com             fax://++41 62 823 9356
-------------------------------------------------------------
terreActive AG                       Wir sichern Ihren Erfolg
-------------------------------------------------------------
