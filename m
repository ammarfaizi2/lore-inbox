Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWGKPGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWGKPGh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWGKPGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:06:37 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:57036 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751275AbWGKPGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:06:36 -0400
Message-ID: <44B3BE71.3050803@fr.ibm.com>
Date: Tue, 11 Jul 2006 17:06:25 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Pavel Emelianov <xemul@openvz.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 7/7] forbid the use of the unshare syscall on ipc
 namespaces
References: <20060711075051.382004000@localhost.localdomain> <20060711075433.856729000@localhost.localdomain> <44B3B16D.8050100@sw.ru>
In-Reply-To: <44B3B16D.8050100@sw.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:

> This patch looks as an overkill for me.

it's a standalone patch. It can be dropped. I think there is some value to
it as we already agree

> If you really care about things you describe, you can forbid unsharing
> in cases:
> 
> 1.
>        undo_list = tsk->sysvsem.undo_list;
>        if (undo_list)
>                REFUSE_UNSHARE;
> 2. vma exists with vma->vm_ops == &shm_vm_ops;
> 3. file opened with f_op == &shm_file_operations

and there are also the netlink sockets mq_notify.

OK, so we agree that ipc namespaces cannot be unshared without extra
checks. I like the firewall approach : it's not safe, don't allow it. Which
is what the patch is doing : we can't unshare ipc namespace safely so let's
just forbid it :

	if (unshare_flags & CLONE_NEWIPC)
		goto bad_unshare_out;

simple, nop ? :)

> I also dislike exec() operation for such sort of things since you can
> have no executable at hands due to changed fs namespace.

what do you mean ? fs namespace doesn't change bc you need it to load the
new process image/interpreter.

C.
