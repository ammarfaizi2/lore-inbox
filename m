Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVDNPqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVDNPqo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 11:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVDNPqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 11:46:44 -0400
Received: from kiwi.iasi.rdsnet.ro ([213.157.176.3]:29131 "EHLO
	mail.iasi.rdsnet.ro") by vger.kernel.org with ESMTP id S261454AbVDNPql
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 11:46:41 -0400
Date: Thu, 14 Apr 2005 18:46:38 +0300 (EEST)
From: Tarhon-Onu Victor <mituc@iasi.rdsnet.ro>
To: linux-kernel@vger.kernel.org
Subject: Re: ACPI/HT or Packet Scheduler BUG?
In-Reply-To: <Pine.LNX.4.61.0504121526550.4822@blackblue.iasi.rdsnet.ro>
Message-ID: <Pine.LNX.4.61.0504141840420.13546@blackblue.iasi.rdsnet.ro>
References: <Pine.LNX.4.61.0504081225510.27991@blackblue.iasi.rdsnet.ro>
 <Pine.LNX.4.61.0504121526550.4822@blackblue.iasi.rdsnet.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2005, Tarhon-Onu Victor wrote:

> 	So the problem should be looked in that changes to the pkt sched API, 
> the patch containing only those changes is at

 	The bug is in this portion of code from net/sched/sch_generic.c, 
in the qdisc_destroy() function:

==
      list_for_each_entry(cq, &cql, list)
           list_for_each_entry_safe(q, n, &qdisc->dev->qdisc_list, list)
                if (TC_H_MAJ(q->parent) == TC_H_MAJ(cq->handle)) {
                     if (q->ops->cl_ops == NULL)
                          list_del_init(&q->list);
                     else
                          list_move_tail(&q->list, &cql);
                }
      list_for_each_entry_safe(cq, n, &cql, list)
           list_del_init(&cq->list);
==

 	...and it happens when q->ops->cl_ops is NULL and 
list_del_init(&q->list) is executed.

 	The stuff from include/linux/list.h looks ok, it seems like one 
of those two iterations (list_for_each_entry() and 
list_for_each_entry_safe()) enters an endless loop when an element is 
removed from the list under some circumstances.

-- 
Tarhon-Onu Victor
Area Technical Coordinator
RDS Iasi - Network Operations Center
www.rdsnet.ro, www.rdstel.ro, www.rdslink.ro
Phone: +40-232-218385; Fax: +40-232-260099
..........................................................................
Privileged/Confidential Information may be contained in this message. If
you are not the addressee indicated in this message (or responsible for
delivery of the message to such person), you may not copy or deliver this
message to anyone. In such a case, you should destroy this message and
kindly notify the sender by reply e-mail.
