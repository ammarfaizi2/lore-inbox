Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVG0SRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVG0SRA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVG0SRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:17:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11414 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261352AbVG0SQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:16:58 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/23] reboot-fixes
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<20050727025923.7baa38c9.akpm@osdl.org>
	<m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com>
	<20050727104123.7938477a.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 27 Jul 2005 12:15:59 -0600
In-Reply-To: <20050727104123.7938477a.akpm@osdl.org> (Andrew Morton's
 message of "Wed, 27 Jul 2005 10:41:23 -0700")
Message-ID: <m18xzs9ktc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
>>
>> Andrew Morton <akpm@osdl.org> writes:
>> 
>>  > My fairly ordinary x86 test box gets stuck during reboot on the
>>  > wait_for_completion() in ide_do_drive_cmd():
>> 
>>  Hmm. The only thing I can think of is someone started adding calls
>>  to device_suspend() before device_shutdown().  Not understanding
>>  where it was a good idea I made certain the calls were in there
>>  consistently.  
>> 
>>  Andrew can you remove the call to device_suspend from kernel_restart
>>  and see if this still happens?
>
> yup, that fixes it.
>
> --- devel/kernel/sys.c~a	2005-07-27 10:36:06.000000000 -0700
> +++ devel-akpm/kernel/sys.c	2005-07-27 10:36:26.000000000 -0700
> @@ -371,7 +371,6 @@ void kernel_restart(char *cmd)
>  {
>  	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
>  	system_state = SYSTEM_RESTART;
> -	device_suspend(PMSG_FREEZE);
>  	device_shutdown();
>  	if (!cmd) {
>  		printk(KERN_EMERG "Restarting system.\n");
> _
>
>
> Presumably it unfixes Pavel's patch?

Good question.  I'm not certain if Pavel intended to add
device_suspend(PMSG_FREEZE) to the reboot path.  It was
there in only one instance.  Pavel comments talk only about
the suspend path.

My gut feel is the device_suspend calls are the right direction
as it allows us to remove code from the drivers and possible
kill device_shutdown completely. 

But this close to 2.6.13 I'm not certain what the correct solution
is.  With this we have had issues with both ide and the e1000.
But those are among the few drivers that do anything in either
device_shutdown() or the reboot_notifier.

The e1000 has been fixed. Can we fix the ide driver?

Looking at it more closely the code is confusing because
FREEZE and SUSPEND are actually the same message, and in
addition to what shutdown does they place the device in
a low power state.  That worries me because last I checked
the e1000 driver could not bring itself out of the low power
state.  

Are the semantic differences to great to make this interesting?

Is this additional suspend what is causing some of the oddball
power off bug reports?

My gut feel is that device_suspend(PMSG_FREEZE) should be
removed from kernel_restart until is a different message
from PMSG_SUSPEND at which point it should be equivalent
to device_shutdown and we can remove that case.

We really need to get a consistent set of requirements
for the device driver authors so they have a chance of
catching up.

Eric
