Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131010AbRAQMmH>; Wed, 17 Jan 2001 07:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131552AbRAQMl6>; Wed, 17 Jan 2001 07:41:58 -0500
Received: from fungus.teststation.com ([212.32.186.211]:11680 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S131234AbRAQMls>; Wed, 17 Jan 2001 07:41:48 -0500
Date: Wed, 17 Jan 2001 13:41:39 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: <linux-kernel@vger.kernel.org>, <marteen.deboer@iua.upf.es>
Subject: Re: Killing process with SIGKILL and ncpfs
In-Reply-To: <12D4186E13AE@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.30.0101171315590.16284-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2001, Petr Vandrovec wrote:

> Hi,
>   Maarten de Boer pointed to me, that if you load some simple program,
> such as 'void main(void) {}', trace into main (break main; run)
> and then quit from gdb (Really exit? yes), child process is then
> killed due to INT3 (probably). Then exit_mmap releases executable
> mapping - and ncp_do_request is entered with SIGKILL pending!

smbfs has a signal problem in it's fs/smbfs/sock.c, possibly related.

SIGKILL or SIGSTOP can be already pending, or perhaps received while
waiting in socket->ops->recvmsg(). recvmsg will then return -ERESTARTSYS
because signal_pending() is true and the smbfs code treats that as a
network problem (causing unnecessary reconnects and sometimes complete
failures requiring umount/mount).

I don't know what happens with ncpfs, I don't think you wrote that, but I
am interested in how it handles this. (Again, I have looked at the ncpfs
code for useful bits to copy :)


Running strace on a multithreaded program causes problems for smbfs.
Someone was nice enough to post a small testprogram for this (you may want
to try it on ncpfs, if you want it I'll find it for you).

These problems go away if all signals are blocked. Of course the smbfs
code would need to be changed to not block on recv, else you may end up
with a program waiting for network input that can't be killed ... (?)

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
