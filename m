Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266140AbTLaGfD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 01:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266142AbTLaGfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 01:35:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2244 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266140AbTLaGe7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 01:34:59 -0500
Message-ID: <3FF26DFF.3040909@pobox.com>
Date: Wed, 31 Dec 2003 01:34:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kthread_create
References: <20031231053032.255202C08B@lists.samba.org>
In-Reply-To: <20031231053032.255202C08B@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> For #2, if you really can't wait for keventd, perhaps your own
> workqueue is in order?

Way too wasteful, and doing so is working around a fundamental failing 
of workqueues:  keventd gives no guarantee that your scheduled work will 
be executed this week, this month, or this year :)

keventd is used by two competing classes of users:  those who want 
low-latency, quick execution in task context (Tux-ish), and those who 
just want to run something in task context, where they might sleep 
(perhaps for a long time).

So it would be nice to have thread pool semantics occasionally found in 
userspace:  if thread pool is full when new work is queued, 
_temporarily_ increase the pool size (or create a one-shot kthread). 
Sure you have kthread creation overhead, but at least you have a 
reasonable guarantee that your work won't wait 5-30 seconds or more 
before being performed.

	Jeff



