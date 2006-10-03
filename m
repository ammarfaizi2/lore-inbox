Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWJCPto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWJCPto (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWJCPto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:49:44 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:46310 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030221AbWJCPto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:49:44 -0400
Message-ID: <452285FD.7010909@us.ibm.com>
Date: Tue, 03 Oct 2006 10:47:09 -0500
From: "Jose R. Santos" <jrs@us.ibm.com>
Reply-To: jrs@us.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Irfan Habib <irfan.habib@gmail.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>,
       SystemTAP <systemtap@sources.redhat.com>
Subject: Re: Fwd: Any way to find the network usage by a process?
References: <3420082f0610030114o5b44b8ak7797483e02002614@mail.gmail.com> <3420082f0610030114o4c6998en907bccce81d28c59@mail.gmail.com>
In-Reply-To: <3420082f0610030114o4c6998en907bccce81d28c59@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Irfan Habib wrote:
> Hi,
>
> Is there any method either kernel or user level which tells me which
> process is generating how much traffic from a machine. For example if
> some process is flooding the network, then I would like to know which
> process (PID ideally), is generating the most traffic.
>
>   

A while ago I did a SystemTap script to solve a problem similar to 
this.  It's been siting in my system for a while collecting dust and you 
currently don't need the embedded C code since the networking.stp tapset 
has all this script needs(and more), but I should point you in the right 
direction.

This worked a couple of months ago but it is currently untested.  Hope 
it helps.

-JRS


global ifstats, ifdevs, execname

%{
#include<linux/skbuff.h>
#include<linux/netdevice.h>
%}

probe kernel.function("dev_queue_xmit")
{
        execname[pid()] = execname()
        name=skb_to_name($skb)
        ifdevs[name] = name
        ifstats[pid(),name] <<< 1
}

function skb_to_name:string (skbuff:long)
%{
        struct sk_buff *skbuff = (struct sk_buff *)((long)THIS->skbuff);
        struct net_device *netdev = skbuff->dev;
        sprintf (THIS->__retvalue, "%s" , netdev->name);
%}

probe timer.ms(5000)
{
        exit()
}

probe end {
        foreach( pid in execname) {
                if (pid == 0) continue
                printf("%15s[%5d] ->\t", execname[pid],pid)
                foreach( ifname in ifdevs) {
                        printf("[%s:%7d] \t", ifname, 
@count(ifstats[pid, ifname]))
                }
                print("\n")
        }
        print("\n")
}

