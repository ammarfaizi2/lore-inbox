Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263434AbVBFDGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbVBFDGz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 22:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbVBFDGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 22:06:54 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:8626 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264248AbVBFDGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 22:06:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=K1ShX5baHTCCKh2/65xkoyEjh+5kYkgGQW4IhjlCoiBUd2UcImpbkL8TzKNY/JoW7MngtkBcftqNQBxfCSeZk1GQdBkxuiO08kvF5SUuDVHm2NuxtkoqF8aqcVLdi7oQJ5IMjnIuFnr2Oh4LwnGewSHjdCntgjvUDbfn7ezMAAk=
Message-ID: <58cb370e050205190469dcb967@mail.gmail.com>
Date: Sun, 6 Feb 2005 04:04:52 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2] ide: merge do_rw_taskfile() and flagged_taskfile() into do_taskfile()
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050206021331.GA25337@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050206021331.GA25337@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Feb 2005 11:13:31 +0900, Tejun Heo <tj@home-tj.org> wrote:
>  Hello, Bartlomiej.

Hi,

>  This is a new version of ide_do_taskfile.patch.  Compared to the
> original do_rw_task(), only one more 'if' is used in the hot path, so
> I think the performance issue can be ignored now.  Also, there's no
> userland visible change with this patch.  Everything should work just
> as it did with do_rw_taskfile()/flagged_taskfile().
> 
>  do_taskfile() is different from do_rw_taskfile() in that

Is there any gain in changing name to do_taskfile()?
 
>  - It uses task->data_phase to determine whether it's a DMA command
>    or not.

this is user-space visible change
(it is right thing to do, I just wanted to point the fact)

>  do_taskfile() is different from flagged_taskfile() in that
> 
>  - No (TASKFILE_MULTI_IN && !mult_count) check.  ide_taskfile_ioctl()
>    checks the same thing, so it doesn't change anything.

The check may be needed.  AFAIR drive->mult_count may change
before our taskfile request is started.

>  - No task->tf_out_flags handling.  ide_end_drive_cmd() ignores it
>    anyway, so, again, it doesn't change anything.

I guess you mean ->tf_in_flags?

>  So, what do you think?

This patch looks much better but could you move writing taskfile
registers to separate helpers (one for non-flagged and one for flagged)?

Probably splitting non-flagged taskfile load helper off do_rw_taskfile()
should be done in separate patch.  We can then use this helper in
ide-disk.c for __ide_do_rw_taskfile() (we can't do direct conversion
to do_rw_taskfile() yet for various reasons).

Thanks,
Bartlomiej
