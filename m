Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWERX6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWERX6k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWERX6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:58:40 -0400
Received: from mail.unixshell.com ([207.210.106.37]:25025 "EHLO
	mail.unixshell.com") by vger.kernel.org with ESMTP id S1751232AbWERX6k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:58:40 -0400
Message-ID: <446D0A0D.5090608@tektonic.net>
Date: Thu, 18 May 2006 19:58:05 -0400
From: Matt Ayres <matta@tektonic.net>
Organization: TekTonic
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Patrick McHardy <kaber@trash.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: Panic in ipt_do_table with 2.6.16.13-xen
References: <4468BE70.7030802@tektonic.net> <4468D613.20309@trash.net>	<44691669.4080903@tektonic.net>	<Pine.LNX.4.64.0605152331140.10964@d.namei>	<4469D84F.8080709@tektonic.net> <Pine.LNX.4.64.0605161127030.16379@d.namei>
In-Reply-To: <Pine.LNX.4.64.0605161127030.16379@d.namei>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



James Morris wrote:
> On Tue, 16 May 2006, Matt Ayres wrote:
> 
>>>> My ruleset is pretty bland.  2 rules in the raw table to tell the system
>>>> to
>>>> only track my forwarded ports, 2 rules in the nat table for forwarding
>>>> (intercepting) 2 ports, and then in the FORWARD tables 2 rules per VM to
>>>> just
>>>> account traffic.
>>> Can you try using a different NIC?
>>>
>> This happens on 30 different hosts.  Using the same kernel I get varying
>> uptime of "hasn't crashed since the upgrade to 2.6.16" to "crashes every day".
>> All are Tyan S2882D boards w/ integrated Tigon3.  The trace I posted to this
>> thread indicate tg3, but in many other traces I have the trace doesn't include
>> any driver calls.  They all panic in ipt_do_table.  I would have pasted the
>> others, but I didn't save the System.map for either of them and they are all
>> pretty similar.
> 
> I'm trying to suggest eliminating this driver & possible interaction with 
> Xen network changes as a cause.  If you can find a different type of NIC 
> to plug in and use, or even try and change all of the params for the tg3 
> with ethtool, it'll help.
> 

Hi,

Thank you for the assistance. Which parameters do you suggest changing? 
  TSO/flow control off?

Here is my ruleset for those interested:

# iptables -t raw -L -v
Chain OUTPUT (policy ACCEPT 27441 packets, 4832K bytes)
  pkts bytes target     prot opt in     out     source 
destination

Chain PREROUTING (policy ACCEPT 195M packets, 156G bytes)
  pkts bytes target     prot opt in     out     source 
destination
1332K  144M NOTRACK   !tcp  --  any    any     anywhere 
anywhere
    54  5293 ACCEPT     tcp  --  any    any     anywhere 
anywhere            tcp dpt:7373
  4564  223K ACCEPT     tcp  --  any    any     anywhere 
anywhere            tcp dpt:7322
  194M  156G NOTRACK    tcp  --  any    any     anywhere 
anywhere            tcp dpt:!7373
  194M  156G NOTRACK    tcp  --  any    any     anywhere 
anywhere            tcp dpt:!7322

# iptables -t nat -L -v
Chain OUTPUT (policy ACCEPT 2114 packets, 155K bytes)
  pkts bytes target     prot opt in     out     source 
destination

Chain POSTROUTING (policy ACCEPT 2114 packets, 155K bytes)
  pkts bytes target     prot opt in     out     source 
destination

Chain PREROUTING (policy ACCEPT 0 packets, 0 bytes)
  pkts bytes target     prot opt in     out     source 
destination
     6   344 DNAT       tcp  --  eth0   any     anywhere 
anywhere            tcp dpt:7373 to:host.ip.address:443
     8   408 DNAT       tcp  --  eth0   any     anywhere 
anywhere            tcp dpt:7322 to:host.ip.address:22


iptables -L -v just shows 2 rules per Virtual Machine for accounting. 
This averages about 100 rules in the FORWARD chain.  Example:

# iptables -L -v
Chain FORWARD (policy ACCEPT 195M packets, 156G bytes)
  pkts bytes target     prot opt in     out     source 
destination
     0     0            all  --  any    any     xx.xx.xx.xx 
  anywhere
     0     0            all  --  any    any     anywhere 
xx.xx.xx.xx
