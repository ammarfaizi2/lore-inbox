Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVKKAAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVKKAAI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 19:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVKKAAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 19:00:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45483 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932230AbVKKAAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 19:00:05 -0500
Date: Thu, 10 Nov 2005 16:00:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: hch@lst.de, linux-kernel@vger.kernel.org, wli@holomorphy.com,
       davem@davemloft.net
Subject: Re: [PATCH] use ptrace_get_task_struct in various places
Message-Id: <20051110160001.6cee5bed.akpm@osdl.org>
In-Reply-To: <20051110232711.GA18831@lst.de>
References: <20051108053049.GA9422@lst.de>
	<20051107221149.08aa0820.akpm@osdl.org>
	<20051110232711.GA18831@lst.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
> > In arch/ia64/ia32/sys_ia32.c this patch will cause PTRACE_TRACEME requests
> > to be handled by ptrace_request()
> 
> you mean ptrace_get_task_struct?

No, I was referring to this code:

asmlinkage long
sys32_ptrace (int request, pid_t pid, unsigned int addr, unsigned int data)
{
	struct task_struct *child;
	unsigned int value, tmp;
	long i, ret;

	lock_kernel();
	if (request == PTRACE_TRACEME) {
		ret = sys_ptrace(request, pid, addr, data);
		goto out;
	}

Your patch removes the PTRACE_TRACEME special-case.  Consequently
sys32_ptrace() will fall all the way down to the default: case of the
switch statement and will use ptrace_request() instead.  And
ptrace_request() doesn't handle PTRACE_TRACEME, so I think it's busted.

