Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287552AbSA3AyN>; Tue, 29 Jan 2002 19:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287633AbSA3AyE>; Tue, 29 Jan 2002 19:54:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47624 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287552AbSA3Axr>; Tue, 29 Jan 2002 19:53:47 -0500
Date: Tue, 29 Jan 2002 16:52:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5: push BKL out of llseek
In-Reply-To: <1012351309.813.56.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0201291647310.1747-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29 Jan 2002, Robert Love wrote:
>
> Another gain from pushing the locks into each method is that we can pick
> and choose as-needed.  If it turns out inode semaphore is a global
> solution, the following patch is sufficient.  Otherwise, we could
> replace the lock_kernel in each caller with the inode semaphore, as
> appropriate.  Oh Al ??

Doing it in the low-level filesystem would match how we now do it inside
generic_file_write() - ie the locking is done by the low-level filesystem,
but most low-level filesystems choose to use a generic helper function.

And I think your patch is slightly wrong:

> +	down(&file->f_dentry->d_inode->i_sem);

That should really be:

	file->f_dentry->d_inode->i_mapping->host->i_sem

to get the hosted filesystem case right (ie coda).

		Linus

