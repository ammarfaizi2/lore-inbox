Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWH3Nzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWH3Nzw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 09:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWH3Nzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 09:55:52 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:65126 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751056AbWH3Nzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 09:55:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=bVSuxzYaPpbhjCI4n/sRx3mimxnjoUIkou31YqfX2/Q0bgL6Z2XXBN8pnqIY0kYmXqcRss2N/bc1+9779rda1z/ETMUPVY/Z5h38HQWC+BnEQfm3NoZJB87aZOqtRd7vupzk1ymcTw6batZ6l9IJCnmJHpZWj+FUHH+WNFtqXls=
Message-ID: <44F598EA.3010700@gmail.com>
Date: Wed, 30 Aug 2006 21:55:54 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: zab@zabbo.net
CC: linux-kernel@vger.kernel.org, linux-aio@kvack.org, akpm@osdl.org
Subject: Re: [2.6.18-rc* PATCH RFC]: Correct ambiguous errno of aio
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/06, *Zach Brown* <zab@zabbo.net <mailto:zab@zabbo.net>> wrote:


    Sorry, we shouldn't merge this patch in its current form.

    > In the current implementation of AIO, for the operation IOCB_CMD_FDSYNC
    > and IOCB_CMD_FSYNC, the returned errno is -EINVAL although the kernel
    > does know them, I think the correct errno should be -EOPNOTSUPP which
    > means they aren't be implemented or supported.

    Like it or not, the sys_io_submit() interface returns -EINVAL when the
    file descriptor doesn't support the requested command. Changing the
    binary interface is a big deal and should not be done lightly. What is
    the motivation for making this change?


When I run ltp aio test case, for the operation OCB_CMD_FDSYNC and
IOCB_CMD_FSYNC, io_submit returns -1 and errno is EINVAL, perror's
output is "Invalid arguments", from the user's perspective, the
arguments are valid
and the kernel also know it and progress the process to file operation
of the
filesystem actually, so I think ENOTSUP is more appropriate. Note
ENOTSUP in
the user space corresponds to EOPNOTSUPP in the kernel mode. For ENOTSUP,
perror's output is "Function isn't implemented", obviously, it is a
reasonable explanation
about the execution error and not ambiguous.

    Even if we decided to, we'd want to do it for all the commands. This
    patch only addresses F{D,}SYNC. All the other commands would still
    return -EINVAL if the descriptor doesn't have the corresponding ->aio_
    method, leaving userspace do deal with more complexity.


What you said is true, but I want to know if my idea is right.
- Show quoted text -

    > -static ssize_t aio_fdsync(struct kiocb *iocb)
    > -{
    > - struct file *file = iocb->ki_filp;
    > - ssize_t ret = -EINVAL;
    > -
    > - if (file->f_op->aio_fsync)
    > - ret = file->f_op->aio_fsync(iocb, 1);
    > - return ret;
    > -}
    > -
    > static ssize_t aio_fsync(struct kiocb *iocb)
    > {
    > struct file *file = iocb->ki_filp;
    > - ssize_t ret = -EINVAL;
    > + ssize_t ret = -EOPNOTSUPP;
    >
    > if (file->f_op->aio_fsync)
    > ret = file->f_op->aio_fsync(iocb, 0);

    > case IOCB_CMD_FDSYNC:
    > - ret = -EINVAL;
    > + ret = -EOPNOTSUPP;
    > if (file->f_op->aio_fsync)
    > - kiocb->ki_retry = aio_fdsync;
    > + kiocb->ki_retry = aio_fsync;

    Hmm, your most recent patch didn't mention this aio_f{d,}sync() change
    though the earlier one did. Please make sure all patch submissions have
    complete descriptions.

    These calls are not the same, notice that they differ in the second
    argument to their ->aio_fsync() calls. Cleaning up the ->aio_fsync()
    interface might well be reasonable. Missing that subtle difference
    suggests that it should be more clear and there are precisely zero
    merged ->aio_fsync() users. But that kind of cleanup belongs in a
    separate patch with its own justification.


Thank your care, it is my mistake and I'm so sorry for this, Your suggest
is good, I'll send a small claenup patch for this.

    Are you working with an ->aio_fsync() user that might be merged? 


No, It just is noticed by me while I trace io_submit for FSYNC/FDSYNC.

- z
