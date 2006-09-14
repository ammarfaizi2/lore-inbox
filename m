Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWINRAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWINRAp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWINRAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:00:45 -0400
Received: from mail.kingsoft.net ([211.152.52.46]:42949 "HELO
	mail.kingsoft.net") by vger.kernel.org with SMTP id S1750717AbWINP4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:56:20 -0400
From: =?gb2312?B?TGltZW5nIFvA7sPIXQ==?= <avlimeng@kingsoft.net>
To: <linux-kernel@vger.kernel.org>
Cc: =?gb2312?B?J73wyb25+dChu6gn?= <guoxiaohua@kingsoft.com>,
       <limeng@kingsoft.com>
Subject: UDP Questions
Date: Thu, 14 Sep 2006 23:56:02 +0800
Message-ID: <000f01c6d816$4e9cb210$c953fea9@liibook>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AcbYFkcpLqVxzLBNRkCSRXJ8injAuw==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
	I have a very puzzled question. When I test the limits of my network
adapters, I send many small UDP packets and compute the average packets sent
per second. Use those codes, I get the result: 75000 packets per second.
(All my sockets has set to unblock)
	//////
	socket = socket(AF_INET, SOCK_DGRAM, .....)
	bind....
	time = time(NULL);
	while (1)
	{
	sendto(socket, "", 1, 0, dstaddr, addrlen);
	count++;
}
time = time(NULL) - time;
avg = count / time; // here, I get avg = 75000
//////

This result can't satisfy me, so I add another network adapter, and try the
code blow:

//////
	socket1 = socket(AF_INET, SOCK_DGRAM, .....)
	socket2 = socket(AF_INET, SOCK_DGRAM, .....)
	bind socket1.network adapter1...
	bind socket2 network adapter2
	time = time(NULL);
	while (1)
	{
	sendto(socket1, "", 1, 0, dstaddr1, addrlen);
	sendto(socket2, "", 1, 0, dstaddr2, addrlen);
	count += 2;
}
time = time(NULL) - time;
avg = count / time; 
///////////////////

But I get the result is also 75000 packet per second, WHY?

Then I find a technique name bond, and then I configure my server's two
network adapters into a dev bond0. And then I test again with the first
paragraph of the code, then I get result 150000 packets per second. So I
want to know how bond can increate the speed of network adapters (use my own
code to send with the two network adapters at the same time is not helpful),
then I open the kernel code, and then find such code:
bond_main.c  L3861:
		if (IS_UP(slave->dev) &&
		    (slave->link == BOND_LINK_UP) &&
		    (slave->state == BOND_STATE_ACTIVE)) {
			res = bond_dev_queue_xmit(bond, skb, slave->dev);

			write_lock(&bond->curr_slave_lock);
			bond->curr_active_slave = slave->next;
			write_unlock(&bond->curr_slave_lock);

			break;
		}
It look like that when send a packet to bond dev, bond use current slave and
send packet, then change current slave to next. What is the essence
different between the bond and my code (use two network adapters)?

Any suggestions?

xixi

