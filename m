Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVDCLfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVDCLfg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 07:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVDCLfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 07:35:36 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:47589 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261682AbVDCLf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 07:35:26 -0400
To: Yum Rayan <yum.rayan@gmail.com>
Cc: linux-kernel@vger.kernel.org, mvw@planets.elm.net
Subject: Re: [PATCH] Reduce stack usage in acct.c
References: <df35dfeb05033023394170d6cc@mail.gmail.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sun, 03 Apr 2005 13:35:19 +0200
In-Reply-To: <df35dfeb05033023394170d6cc@mail.gmail.com> (Yum Rayan's
 message of "Wed, 30 Mar 2005 23:39:40 -0800")
Message-ID: <877jjkf5zc.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yum Rayan <yum.rayan@gmail.com> writes:

> Attempt to reduce stack usage in acct.c (linux-2.6.12-rc1-mm3). Stack
> usage was noted using checkstack.pl. Specifically:
>
> Before patch
> ------------
> check_free_space - 128
>
> After patch
> -----------
> check_free_space - 36
>
> Signed-off-by: Yum Rayan <yum.rayan@gmail.com>
>
> --- a/kernel/acct.c	2005-03-25 22:11:06.000000000 -0800
> +++ b/kernel/acct.c	2005-03-30 15:33:05.000000000 -0800
> @@ -103,30 +103,32 @@
>   */
>  static int check_free_space(struct file *file)
>  {
> -	struct kstatfs sbuf;
> -	int res;
> -	int act;
> -	sector_t resume;
> -	sector_t suspend;
> +	struct kstatfs *sbuf = NULL;
> +	int res, act;
> +	sector_t resume, suspend;

I can't see how you expect to save 128-36=92 bytes here. You replace
sizeof(struct kstatfs)=64 with sizeof(struct kstatfs*)=4, which would
be a saving of 60 bytes. But the call to kmalloc()/kfree() reduces
your stack saving further, not to mention the runtime penalty,
introduced by allocating dynamic memory.

Regards, Olaf.
