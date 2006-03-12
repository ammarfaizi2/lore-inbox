Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751927AbWCLXkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbWCLXkb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 18:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbWCLXkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 18:40:31 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49586 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751927AbWCLXka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 18:40:30 -0500
To: Kurt Garloff <garloff@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] KERN_SETUID_DUMPABLE in /proc/sys/fs/
References: <20060310155738.GL5766@tpkurt.garloff.de>
	<20060310145605.08bf2a67.akpm@osdl.org>
	<1142061816.3055.6.camel@laptopd505.fenrus.org>
	<20060310234155.685456cd.akpm@osdl.org>
	<1142063254.3055.9.camel@laptopd505.fenrus.org>
	<20060310235103.4e9c9457.akpm@osdl.org>
	<1142064294.3055.13.camel@laptopd505.fenrus.org>
	<m1r757xqoc.fsf@ebiederm.dsl.xmission.com>
	<20060312223256.GE3028@tpkurt.garloff.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 12 Mar 2006 16:39:24 -0700
In-Reply-To: <20060312223256.GE3028@tpkurt.garloff.de> (Kurt Garloff's
 message of "Sun, 12 Mar 2006 23:32:56 +0100")
Message-ID: <m1d5grqllf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff <garloff@suse.de> writes:

> Hi Arjan, Eric,
>
> On Sun, Mar 12, 2006 at 03:07:47PM -0700, Eric W. Biederman wrote:
>> Arjan van de Ven <arjan@infradead.org> writes:
>> 
>> > diff -purN linux-2.6.16-rc5/include/linux/sysctl.h
>> > linux-2.6.16-rc5-setuid/include/linux/sysctl.h
>> > --- linux-2.6.16-rc5/include/linux/sysctl.h 2006-02-27 09:13:31.000000000
> +0100
>> > +++ linux-2.6.16-rc5-setuid/include/linux/sysctl.h 2006-03-11
> 09:02:13.000000000
>> > +0100
>> > @@ -144,7 +144,6 @@ enum
>> >  	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
>> >  	KERN_BOOTLOADER_TYPE=67, /* int: boot loader type */
>> >  	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
>> > -	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
>> >  	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
>> >  	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI
>> > sleep */
>> >  };
>> > @@ -759,6 +758,9 @@ enum
>> >  	FS_AIO_NR=18,	/* current system-wide number of aio requests */
>> >  	FS_AIO_MAX_NR=19, /* system-wide maximum number of aio requests */
>> >  	FS_INOTIFY=20,	/* inotify submenu */
>> > + /* Note: the following got misplaced but this mistake is
>> > +			   now part of the ABI */
>> > +	FS_SETUID_DUMPABLE=21, /* int: behaviour of dumps for setuid core */
>
> OK, this is the other possibility. It'll leave a hole in the KERN_
> sysctl numbering, but that's not a problem AFAICT.
> I would however at least annotate with FIXME and make a note that it's
> gonna change in 2.7.

Making the variable show up in two places is reasonable.
Removing it from it's current location is not, as there are currently
no technical reasons to make the change.

Unless something dramatic shows up 2.7 isn't going to happen.
If you want something like that to happen use:
Documentation/feature-removal-schedule.txt


> It's hard to tell how many people depend on suid_dumpable being at the
> wrong location. The fact nobody noticed it being placed wrongly would
> make me suspect it's not widely used yet (it only got introduced
> 2005-06-23 by Alan Cox). So I would prefer to move it to the correct
> location now rather than in 2.7. By the time 2.7 comes, we may have so
> many users, we may not want to correct this any more at all.

Don't move it just add it to the correct location.  But also leave
it at it's old location.  Then put something in
Documentation/feature-removal-schedule.txt that says in six months or
so it will be gone, from the bad location.

>> This must be number 69 here.  Or else we break the sys_sysctl ABI.
>
> I don't think we break anything we want to maintain. 
> Kernel-internal defines? 

That 69 is not kernel internal it is exported to user space,
which is why changing that is wrong.

> OK to change when going from 2.6.15 to 2.6.16 IMVHO. No module
> compiled for 2.6.15 will work with 2.6.16 anyway.

No because it isn't kernel internal.  Which is why I mentioned
sys_sysctl.  It uses that 69 as part of the path to that variable.

Eric
