Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbTD2PHv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 11:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTD2PHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 11:07:51 -0400
Received: from ns.suse.de ([213.95.15.193]:20232 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262029AbTD2PHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 11:07:50 -0400
To: joe briggs <jbriggs@briggsmedia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: software reset
References: <200304291037.13598.jbriggs@briggsmedia.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 Apr 2003 17:19:51 +0200
In-Reply-To: <200304291037.13598.jbriggs@briggsmedia.com.suse.lists.linux.kernel>
Message-ID: <p73vfwx2uw8.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

joe briggs <jbriggs@briggsmedia.com> writes:

> Can anyone tell me how to absolutely force a reset on a i386?  Specifically, 
> is there a system call that will call the assembly instruction to assert the 
> RESET bus line? I try to use the "reboot(LINUX_REBOOT_CMD_RESTART,0,0,NULL)" 
> call, but it will not always work.  Occassionally, I experience a "missed 
> interrupt" on a Promise IDE controller, and while I can telnet into the 
> system, I can't reset it.  Any help greatly appreciated!  Since these systems 
> are 1000's of miles away, the need to remotely reset it paramont.

The most reliable way is to force a triple fault; load zero into
the IDT register and then trigger an exception. The linux kernel 
does that in fact for reboot and so far I haven't seen any machine failing
to reset yet.

-Andi

If you don't trust reboot you can use something like (untested!).
Compile with -c and load with insmod. I'm pretty sure it will reset
your box.

#define MODULE 1
#define __KERNEL__ 1
#include <linux/module.h>

int init_module(void)
{ 
        static struct { 
                short limit;
                unsigned ptr;
        } desc = { 64000, 0 }; 

        asm volatile("lidt %0" : "m" (desc)); 
        asm volatile("movl %0,%%esp ; int $3" : "g" (0)); 
} 

