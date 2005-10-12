Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbVJLEAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVJLEAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 00:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbVJLEAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 00:00:09 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:10772 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S932410AbVJLEAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 00:00:07 -0400
Date: Tue, 11 Oct 2005 21:00:06 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Grzegorz Nosek <grzegorz.nosek@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sys_sendfile oops in 2.6.13?
Message-ID: <20051012040006.GA31099@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <121a28810510110156q1369b9dg@mail.gmail.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 10:56:43AM +0200, Grzegorz Nosek wrote:
> I found an (IMHO) silly bug in do_sendfile in 2.6.13.x kernels (at
> least in 2.6.13.3 and .4, didn't backtrack to find where it
> originated). Without the patch all I apparently get from sys_sendfile
> is an oops due to a call in sys_sendfile with ppos being NULL. With the
> patch it works OK. Noticed in vsftpd.
>
> @@ -719,7 +719,7 @@
>        current->syscr++;
>        current->syscw++;
> 
> -       if (*ppos > max)
> +       if (ppos && *ppos > max)

That change can't fix a bug in 2.6.13, because ppos is forced to be
non-null further up the file:

    622 static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
...
    647         if (!ppos)
    648                 ppos = &in_file->f_pos;
...
    684         pos = *ppos;
...
    701         current->syscr++;
    702         current->syscw++;
    703 
    704         if (*ppos > max)
    705                 retval = -EOVERFLOW;

(line numbers from 2.6.13.)

So there must be something else at work.  Perhaps your patches?

On Tue, Oct 11, 2005 at 04:53:47PM +0200, Jiri Slaby wrote:
> I don't know the code surrounding this, but shouldn't be this
> (!ppos || *ppos > max)?

That would be wrong, too; if it were valid to call in with ppos==0, you
wouldn't want to return EOVERFLOW; and if ppos==0 were not valid and you
wanted to return an error, EOVERFLOW would be the wrong error to return.

-andy
