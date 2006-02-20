Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWBTJGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWBTJGI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 04:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWBTJGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 04:06:08 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52949 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932383AbWBTJGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 04:06:06 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, B.Steinbrink@gmx.de, viro@ftp.linux.org.uk
Subject: Re: + daemonize-detach-from-current-namespace.patch added to -mm
 tree
References: <200602200438.k1K4ct5n013388@shell0.pdx.osdl.net>
	<1140425218.2979.14.camel@laptopd505.fenrus.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 20 Feb 2006 02:04:27 -0700
In-Reply-To: <1140425218.2979.14.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Mon, 20 Feb 2006 09:46:57 +0100")
Message-ID: <m1ek1ymmec.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

>> diff -puN kernel/exit.c~daemonize-detach-from-current-namespace kernel/exit.c
>> --- devel/kernel/exit.c~daemonize-detach-from-current-namespace 2006-02-19
> 20:36:58.000000000 -0800
>> +++ devel-akpm/kernel/exit.c	2006-02-19 20:36:58.000000000 -0800
>> @@ -360,6 +360,9 @@ void daemonize(const char *name, ...)
>>  	fs = init_task.fs;
>>  	current->fs = fs;
>>  	atomic_inc(&fs->count);
>> +	exit_namespace(current);
>> +	current->namespace = init_task.namespace;
>> +	get_namespace(current->namespace);
>>   	exit_files(current);
>
> not that it'll matter much here, but this is normally the wrong order of
> refcounting ;) First take the count, then start using it ;)

Well what would need in a general case situation here would be task_lock,
for the two tasks.  Having that as long as all of the operations happened
under the lock it wouldn't matter.  In this case the init_task is known
not to change, and no one else should be messing with current.

I am beginning to suspect that we will want to fix kernel_thread so it
creates copies of the init_task rather than copies of whatever random
user space process we happen to be a member of at the time.  With an
enhanced kernel_thread this problem could more easily avoided, as
we add additional namespaces to the kernel.

The problem with a kernel thread running in a private namespace like this
is that you can't kill the kernel thread and when it is the last user
of a private namespace.  So you can never free up your mounts etc.

As for this patch in particular matching the style that is already there for
a bug fix seems to make a lot of sense :)

Eric
