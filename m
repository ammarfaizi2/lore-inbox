Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVK1NkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVK1NkO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 08:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVK1NkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 08:40:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46767 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932099AbVK1NkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 08:40:13 -0500
To: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH & RFC] kdump and stack overflows
References: <1133183463.2327.96.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 28 Nov 2005 06:39:16 -0700
In-Reply-To: <1133183463.2327.96.camel@localhost.localdomain> (Fernando Luis
 Vazquez Cao's message of "Mon, 28 Nov 2005 22:11:03 +0900")
Message-ID: <m1lkz8gad7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Luis Vazquez Cao <fernando@intellilink.co.jp> writes:

> Hi,
>
> I have observed that kdump's reboot path to the second kernel is not
> stack overflow safe.
>
> On the event of a stack overflow critical data that usually resides at
> the bottom of the stack is likely to be stomped and, consequently, its
> use should be avoided.
>
> In particular, in the i386 and IA64 architectures the macro
> smp_processor_id ultimately makes use of the "cpu" member of struct
> thread_info which resides at the bottom of the stack (see code snips
> below). x86_64, on the other hand, is not affected by this problem
> because it benefits from the PDA infrastructure.

I agree this is something that we should handle if we can.
>
> To circumvent this problem I suggest implementing
> "safe_smp_processor_id()" (it already exists on x86_64) for i386 and
> IA64 and use it as a replacement to smp_processor_id in the reboot path
> to the dump capture kernel. A possible implementation for i386 is
> attached below.
>
> I would appreciante comments on this.

The patch looks like a good one to express the idea, but it is a
bad one to push upstream.

safe_smp_processor_id has a printk in it.

mm/fault.c has related code that really should go into a separate
patch.

For crash_nmi_callback I don't feel very comfortable about
dropping the cpu parameter.  I suspect you want to move
the call safe_smp_process_id to do_nmi (which is current
calling smp_processor_id).  Basically the whole nmi path needs a stack
overflow audit.  I believe we have a separate interrupt stack that
should help but..

Eric
