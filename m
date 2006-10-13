Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751747AbWJMQay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbWJMQay (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWJMQax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:30:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54186 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751745AbWJMQaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:30:52 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Chandru <chandru@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC]: Possible race condition on an SMP between proc_lookupfd and tasks on other cpus
References: <452CB67A.4070702@in.ibm.com>
	<m1hcy9ib95.fsf@ebiederm.dsl.xmission.com>
	<452F8364.9050803@in.ibm.com>
Date: Fri, 13 Oct 2006 10:29:08 -0600
In-Reply-To: <452F8364.9050803@in.ibm.com> (chandru@in.ibm.com's message of
	"Fri, 13 Oct 2006 17:45:32 +0530")
Message-ID: <m1hcy8gox7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandru <chandru@in.ibm.com> writes:

> Eric W. Biederman wrote:
>> You certain seem to be in one of the proc stress conditions so this
>> may not be a unique bug.
>>
>> Digging through the disassembly and figuring out which access you died
>> on would be interesting, so we could know with precision which part
>> of tid_fd_revalidate we are dying in.  My ppc64 isn't good enough especially
>> without the matching binaries to figure that out though.
>> All I know is that you are about 25 instructions into
>> tid_fd_revalidate.
>>
> From the disassembly in xmon, the code that failed while running was in
> fcheck_files() called from tid_fd_revalidate()

> Further the contents of 'struct files_struct *files' were all filled with
> '0x6b's.  I tried to look in to for which task the lookup was being done and the
> task seemed to be 'execve04'.  Also noticed that another cpu ( cpu #1)  was
> running on an execve code path ( do not have the state of the system right now
> to copy it's backtrace  :(  ).

Which kernel version did you say you were running.

This appears to be a case of calling put_files_struct without changing
the pointer in the task_struct.  So we are reading a stale pointer
in get_files_struct.

It looks like the patch below added fixed a bug that has the same symptoms
as what you are describing.  So I suspect this is fixed in linus's tree
already.

>commit 3b9b8ab65d8eed784b9164d03807cb2bda7b5cd6
>Author: Kirill Korotaev <dev@sw.ru>
>Date:   Fri Sep 29 02:00:05 2006 -0700
>
>    [PATCH] Fix unserialized task->files changing
>    
>    Fixed race on put_files_struct on exec with proc.  Restoring files on
>    current on error path may lead to proc having a pointer to already kfree-d
>    files_struct.
>    
>    ->files changing at exit.c and khtread.c are safe as exit_files() makes all
>    things under lock.
>    
>    Found during OpenVZ stress testing.
>    
>    [akpm@osdl.org: add export]
>    Signed-off-by: Pavel Emelianov <xemul@openvz.org>
>    Signed-off-by: Kirill Korotaev <dev@openvz.org>
>    Signed-off-by: Andrew Morton <akpm@osdl.org>
>    Signed-off-by: Linus Torvalds <torvalds@osdl.org>


Eric
