Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWJWPPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWJWPPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWJWPPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:15:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8111 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964921AbWJWPPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:15:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jakub Jelinek <jakub@redhat.com>, Mike Galbraith <efault@gmx.de>,
       Albert Cahalan <acahalan@gmail.com>,
       Bill Nottingham <notting@redhat.com>,
       Marco Roeland <marco.roeland@xs4all.nl>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFD][PATCH 2/2] sysctl:  Implement CTL_UNNUMBERED
References: <m13b9fxzs0.fsf@ebiederm.dsl.xmission.com>
	<m1y7r7wl2e.fsf@ebiederm.dsl.xmission.com>
	<837CA6CF-DA35-4AAF-8F92-0912B7D3166D@mac.com>
Date: Mon, 23 Oct 2006 09:12:20 -0600
In-Reply-To: <837CA6CF-DA35-4AAF-8F92-0912B7D3166D@mac.com> (Kyle Moffett's
	message of "Mon, 23 Oct 2006 06:28:15 -0400")
Message-ID: <m1iribvzfv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:

> On Oct 23, 2006, at 03:25:13, Eric W. Biederman wrote:
>> --- a/fs/lockd/svc.c
>> -/* Something that isn't CTL_ANY, CTL_NONE or a value that may  clash. */
>> -#define CTL_UNNUMBERED		-2
>> -
>
>> --- a/fs/nfs/sysctl.c
>> -/*
>> - * Something that isn't CTL_ANY, CTL_NONE or a value that may clash.
>> - * Use the same values as fs/lockd/svc.c
>> - */
>> -#define CTL_UNNUMBERED -2
>
>> +++ b/include/linux/sysctl.h
>>  #ifdef __KERNEL__
>>  #define CTL_ANY		-1	/* Matches any name */
>>  #define CTL_NONE	0
>> +#define CTL_UNNUMBERED CTL_NONE /* sysctl without a binary number */
>>  #endif
>
> This change looks totally broken.  Before this patch, CTL_UNNUMBERED  == -2, a
> number that isn't CTL_ANY, CTL_NONE, or a valid sysctl  number.  After this
> patch, CTL_UNNUMBERED == 0, or CTL_NONE.

Exactly.  The only reserved sysctl numbers we have are 0 and -1.

Until my previous patch there was on number you could place into the
sysctl table that meant we did not have a binary sysctl name.  0 was
the closest but since it terminated the table it is generally useless.
-2 was a hack attempting to implement that within in the confines of
the previous sysctl implementation.

Now that I have reserved ctl_name == 0 to explicitly mean no sysctl number
and require both ctl_name == 0 and procname == NULL to terminate a sysctl
table.  We can remove the hack that nfs had, because we actually have a clean
way of implementing it.

There are sysctl tables currently in existence that use -2 as the index
of a data entry so that was out.  Numbers around MIN_INT/MAX_INT are probably
still available to reserve for a new purpose globally but 0 seems perfectly
up to the job.

I kept the CTL_UNNUMBERED name because it seems a little clearer than CTL_NONE.

Eric
