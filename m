Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWBSCeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWBSCeP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 21:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWBSCeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 21:34:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29123 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750738AbWBSCeO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 21:34:14 -0500
To: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
Cc: herbert@13thfloor.at, akpm@osdl.org, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: kjournald keeps reference to namespace
References: <20060218013547.GA32706@MAIL.13thfloor.at>
	<20060218133647.GA9332@atjola.homenet>
	<20060218163227.GA23344@atjola.homenet>
	<20060218171243.GA23640@atjola.homenet>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 18 Feb 2006 19:32:41 -0700
In-Reply-To: <20060218171243.GA23640@atjola.homenet> (
 =?iso-8859-1?q?Bj=F6rn_Steinbrink's_message_of?= "Sat, 18 Feb 2006 18:12:43
 +0100")
Message-ID: <m1mzgom62e.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Björn Steinbrink <B.Steinbrink@gmx.de> writes:

> On 2006.02.18 17:32:27 +0100, Björn Steinbrink wrote:
>> > In daemonize() a new thread gets cleaned up and 'merged' with init_task.
>> > The current fs_struct is handled there, but not the current namespace.
>> > The following patch adds the namespace part.
>> > 
>> > Signed-off-by: Björn Steinbrink <B.Steinbrink@gmx.de>
>> > ---
>> 
>> Oops, forgot the increment the namespace usage count...
>
> Ok, this time with the get_namespace wrapper, thanks to Eric Biederman
> for pointing that out to me.

Acked-by: Eric Biederman <ebiederm@xmission.com>

Note we can't ever count on using our parents namespace because
we already have called exit_fs(), which is the only way to the
namespace from a process.

> ---
>
>
> diff -NurpP --minimal linux-2.6.16-rc4/kernel/exit.c
> linux-2.6.16-rc4-ns/kernel/exit.c
> --- linux-2.6.16-rc4/kernel/exit.c	2006-02-18 13:59:59.000000000 +0100
> +++ linux-2.6.16-rc4-ns/kernel/exit.c	2006-02-18 17:57:21.000000000 +0100
> @@ -360,6 +360,9 @@ void daemonize(const char *name, ...)
>  	fs = init_task.fs;
>  	current->fs = fs;
>  	atomic_inc(&fs->count);
> +	exit_namespace(current);
> +	current->namespace = init_task.namespace;
> +	get_namespace(current->namespace);
>   	exit_files(current);
>  	current->files = init_task.files;
>  	atomic_inc(&current->files->count);
