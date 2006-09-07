Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbWIGSFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbWIGSFv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 14:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbWIGSFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 14:05:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24212 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161040AbWIGSFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:05:48 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] proc: Make the generation of the self symlink table driven.
References: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com>
	<20060907101512.3e3a9604.akpm@osdl.org>
Date: Thu, 07 Sep 2006 12:04:58 -0600
In-Reply-To: <20060907101512.3e3a9604.akpm@osdl.org> (Andrew Morton's message
	of "Thu, 7 Sep 2006 10:15:12 -0700")
Message-ID: <m1hczjr1rp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Wed, 06 Sep 2006 10:23:00 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> 
>> This patch generalizes the concept of files in /proc that are
>> related to processes but live in the root directory of /proc
>> 
>> Ideally this would reuse infrastructure from the rest of the
>> process specific parts of proc but unfortunately
>> security_task_to_inode must not be called on files that
>> are not strictly per process.  security_task_to_inode
>> really needs to be reexamined as the security label can
>> change in important places that we are not currently
>> catching, but I'm not certain that simplifies this problem.
>> 
>> By at least matching the structure of the rest of proc
>> we get more idiom reuse and it becomes easier to spot problems
>> in the way things are put together.
>> 
>> Later things like /proc/mounts are likely to be moved into
>> proc_base as well.  If union mounts are ever supported
>> we may be able to make /proc a union mount, and properly
>> split it into 2 filesystems.
>> 
>> ..
>>
>>  /*
>> + * proc base
>> + *
>> + * These are the directory entries in the root directory of /proc
>> + * that properly belong to the /proc filesystem, as they describe
>> + * describe something that is process related.
>> + */
>> +static struct pid_entry proc_base_stuff[] = {
>> +	NOD(PROC_TGID_INO, 	"self", S_IFLNK|S_IRWXUGO,
>> +		&proc_self_inode_operations, NULL, {}),
>> +	{}
>> +};
>
> We could save a bunch of bytes here.
>
>> +	/* Lookup the directory entry */
>> +	for (p = proc_base_stuff; p->name; p++) {
>
> By using ARRAY_SIZE here.
>
>> +	for (; nr < (ARRAY_SIZE(proc_base_stuff) - 1); filp->f_pos++, nr++) {
>
> like that does.

Agreed.   The problem is that I loose consistency with the other proc
lookup methods.  If it wasn't for the call to security_task_inode I could use
proc_pident_lookup.  Getting some common helpers is still a direction
I want to pursue,  though not as much as I want to kill the hard
coded inode numbers.

Now maybe that means I need to remove the trailing empty entry on
all of the struct pid_entry candidates.

Another part of it is that I would like to convert from an array
of pid_entries into a linked list, eventually so I can have subsystems
that register their proc entries instead of having code that is riddled
with ifdefs.

Eric
