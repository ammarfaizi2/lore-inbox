Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUG0ART@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUG0ART (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 20:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUG0ART
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 20:17:19 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:7625 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S266193AbUG0ARL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 20:17:11 -0400
Date: Tue, 27 Jul 2004 03:16:50 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: Robert Olsson <Robert.Olsson@data.slu.se>
cc: Francois Romieu <romieu@fr.zoreil.com>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <16645.34772.760879.146784@robur.slu.se>
Message-ID: <Pine.LNX.4.44.0407270304570.11416-100000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Checked: by miltrassassin
	at posti6.jyu.fi; Tue, 27 Jul 2004 03:16:53 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004, Robert Olsson wrote:

>>>  In summary: High softirq loads can totally kill userland. The reason is that 
>>>  do_softirq() is run from many places hard interrupts, local_bh_enable etc 
>>>  and bypasses the ksoftirqd protection. It just been discussed at OLS with
>>>  Andrea and Dipankar and others. Current RCU suffers from this problem as well.
>> Ok, this explanation makes sense and my point of view I think this is 
>> quite critical problem if you can "crash" linux kernel just sending enough 
>> packets to network interface for an example.
> 
>  Well the packets also has to create hard softirq loads in practice this means route
>  lookup or something else for normal traffic the RX_SOFIRQ is very well behaved
>  and schedules itself to give other softirq's a chance to run also I'll guess you 
>  have softirq's not only from the network. If you decrease your load a bit you come
>  to more nomal operation?

The system will be more responsive but won't ever come back to normal 
operation and if I use my computer just for some chatting/writing/browsing 
the ksoftirqd-problem won't ever happen. 

It is also very hard to reproduce with only high network load. I ran some 
test with 100Mbps load (RX and TX both) for 24hours without any problems 
but soon as I started to compile some stuff or doing something 
cpu-intensive the system would do crash-boom-bang.

>> I would be more than glad to help you in testing if you want to publish 
>> some patches. 
>  Well maybe we should start to verify that this problem. Alexey did a litte program 
>  doing gettimeofday to run to see how long user mode could be starved. Also note we 
>  add new source of softirq's. 

First run:

--
timestamp diff = 1, maxlat = 50963
timestamp diff = 0, maxlat = 50963
timestamp diff = 0, maxlat = 50963
timestamp diff = 1, maxlat = 50963
timestamp diff = 0, maxlat = 50963
timestamp diff = 0, maxlat = 50963
new maxlat = 124428
new maxlat = 511817
timestamp diff = 1, maxlat = 511817
new maxlat = 749913
new maxlat = 775142
**4581159
new maxlat = 4581159
**1704065
**1464153
timestamp diff = 1, maxlat = 4581159
**1448939
**1464013
**1021339
**1568588
**1861657
timestamp diff = 0, maxlat = 4581159
--

Second run:

--
timestamp diff = 0, maxlat = 832003
timestamp diff = 1, maxlat = 832003
timestamp diff = 0, maxlat = 832003
timestamp diff = 0, maxlat = 832003
timestamp diff = 0, maxlat = 832003
timestamp diff = 1, maxlat = 832003
**1793951
new maxlat = 1793951
timestamp diff = 0, maxlat = 1793951
**2579893
new maxlat = 2579893
timestamp diff = 0, maxlat = 2579893
timestamp diff = 0, maxlat = 2579893
timestamp diff = 0, maxlat = 2579893
**1004449
**3199625
new maxlat = 3199625
timestamp diff = 0, maxlat = 3199625
timestamp diff = 1, maxlat = 3199625
--

When the system has gone to this state you will have to wait quite a long 
time to receive a new line.

--
Pasi Sjöholm 

