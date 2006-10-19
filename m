Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946393AbWJSTKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946393AbWJSTKT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946392AbWJSTKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:10:19 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:23833 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1946391AbWJSTKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:10:17 -0400
Message-ID: <4537CD94.2070706@qumranet.com>
Date: Thu, 19 Oct 2006 21:10:12 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Anthony Liguori <aliguori@us.ibm.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Stoffel <john@stoffel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com>	 <17719.35854.477605.398170@smtp.charter.net> <1161269405.17335.80.camel@localhost.localdomain> <4537C8B3.5050501@us.ibm.com>
In-Reply-To: <4537C8B3.5050501@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2006 19:10:17.0080 (UTC) FILETIME=[36812780:01C6F3B2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Liguori wrote:
>
> ioctls are probably wrong here though.  Ideally, you would want to be 
> able to support an SMP guest.  This means you need to have two virtual 
> processors executing in kernel space.  If you use ioctls, it forces 
> you to have two separate threads in userspace.  This would be hard for 
> something like QEMU which is currently single threaded (and not at all 
> thread safe).
>

Since we're using the Linux scheduler, we need a task per virtual cpu 
anyway, so a thread per vcpu is not a problem.


> If you used a read/write interface, you could poll for any number of 
> processors and handle IO emulation in a single userspace thread (which 
> seems closer to how hardware really works anyway).
>

We can still do that by having the thread write an I/O request to 
hardware service thread, and read back the response.  However that will 
not be too good for scheduling.  For now the smp plan is to slap a 
single lock on the qemu device model, and later fine-grain the locking 
on individual devices as necessary.

Qemu's transition to aio will probably help in reducing the amount of 
work done under lock.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

