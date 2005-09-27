Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVI0QOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVI0QOX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVI0QOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:14:22 -0400
Received: from ns2.masterasp.com ([217.75.228.66]:42174 "HELO
	powy.masterasp.com") by vger.kernel.org with SMTP id S964859AbVI0QOW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:14:22 -0400
Message-ID: <20050927161759.20229.qmail@powy.masterasp.com>
From: jordi@baylina.org
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Idea for packet classification.
Date: Tue, 27 Sep 2005 18:17:59 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The idea is to create a set of iptables TARGETS that classifies the packets. 

When a packet is classified, a classification / Values is associated with 
the packet. 

This classifications can then be used on an iptable filter rule, in a 
routing table selection rule or in a tc classification filter. 


For example: 

#iptables –A INPUT –j CLS user --classifier tcfilter --filtername u32 
…
#iptables –A INPUT –j CLS quota_plan --classifier hash --table 
user_to_quota --input cls user
#iptables –A INPUT –j CLS tos --classifier tos 

#iptables –A FORWARD –p tcp –port 5343 –cls quota_plan=1 –j DROP 


So in this example when a packet arrives, the source address is taken and 
translated directly to a user, and the packet is marked with the userid. 
I.e. The packed has an associated classification user = 23 

In the second line a hash table classifies the packet. The user is taken 
from input and a quota plan is taken as an output. 

So after the second rule, the packet has associated 2 classifications:
	user=23
	quota_plan=2 

The 3rd line classifies the packet by TOS so the packet has 3 
classifications
	User=23
	Quota_plan=2
	Tos=0 

Once a packet is classified, those classifications can be used in a filter 
rule or can be used in a routing rule or in a traffic shaping queue 
classification. 

A packet can have many classifications
Those classifications can be used any time in the packet live. 

In the 4th line in th example, the rule drops all tcp packets with port 5343 
and had been classified as quota_plan 

The 1st line in the rule uses a tc filter wrapper to classify the packet. 

This idea would be an extesion of the MARK target. 

I am planning to make a patch to implement a couple of functions to insert 
classifications to the sk_buff structure and to  consult classifications of 
a sk_buff.
Do you believe that it is interesting or are you planning to do packet 
classifications in another way and doing that I would lose the time. 

Thank you, 

Jordi 


