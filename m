Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWINQAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWINQAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 12:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWINQAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 12:00:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:62111 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750933AbWINQAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 12:00:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HBeviyvyiwiWG0Dbo+Kj2nyf9iNKcV6oBvvG8KX6whqqP90DGHnOTWxlpYBohTiGD2Lu7qrOtymuNeTMwrS4DxGwqJ8NgCyQ0WU8ETWB0gln8QzVrivWjQ1klSLZR27sTV9aWb0TPWU9WUCBeuxjf0vUsmqYoE183KFntDtKYdk=
Message-ID: <a885b78b0609140900x385c9453n9ef25a936524dff7@mail.gmail.com>
Date: Fri, 15 Sep 2006 00:00:49 +0800
From: "xixi lii" <xixi.limeng@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: UDP question.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
I have a very puzzled question. When I test the limits of my network
adapters, I send many small UDP packets and compute the average
packets sent per second. Use those codes, I get the result: 75000
packets per second.
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
avg = count / time; // here, I get avg = 75000 //////

This result can't satisfy me, so I add another network adapter, and
try the code blow:

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

Then I find a technique name bond, and then I configure my server's
two network adapters into a dev bond0. And then I test again with the
first paragraph of the code, then I get result 150000 packets per
second. So I want to know how bond can increate the speed of network
adapters (use my own code to send with the two network adapters at the
same time is not helpful), then I open the kernel code, and then find
such code:
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
It look like that when send a packet to bond dev, bond use current
slave and send packet, then change current slave to next. What is the
essence different between the bond and my code (use two network
adapters)?

Any suggestions?

xixi
