Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135298AbRAQQId>; Wed, 17 Jan 2001 11:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135311AbRAQQIY>; Wed, 17 Jan 2001 11:08:24 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:16138 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S135298AbRAQQIG>;
	Wed, 17 Jan 2001 11:08:06 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Urban Widmark <urban@teststation.com>
Date: Wed, 17 Jan 2001 17:07:08 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Killing process with SIGKILL and ncpfs
CC: <linux-kernel@vger.kernel.org>, <marteen.deboer@iua.upf.es>
X-mailer: Pegasus Mail v3.40
Message-ID: <12D8176C233E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jan 01 at 13:41, Urban Widmark wrote:
> SIGKILL or SIGSTOP can be already pending, or perhaps received while
> waiting in socket->ops->recvmsg(). recvmsg will then return -ERESTARTSYS
> because signal_pending() is true and the smbfs code treats that as a
> network problem (causing unnecessary reconnects and sometimes complete
> failures requiring umount/mount).

Yes. I was going to rewrite this code sometime around 2.3.40, when
I wrote independent NCP socket layer for some other project. Unfortunately,
I found that returning -ERESTARTSYS from some procedures (read_inode)
is converted to bad_inode, instead of just dropping/reverting all
changes which were done :-( So I left it as is.

> Running strace on a multithreaded program causes problems for smbfs.
> Someone was nice enough to post a small testprogram for this (you may want
> to try it on ncpfs, if you want it I'll find it for you).
> 
> These problems go away if all signals are blocked. Of course the smbfs
> code would need to be changed to not block on recv, else you may end up
> with a program waiting for network input that can't be killed ... (?)

I'm going to use:

if (current->flags & PF_EXITING)
  mask = 0;
else
  mask = sigmask(SIGKILL);

It causes following:
(1) you can still kill bad task locked in ncpfs with SIGKILL
(2) except when connectivity problem happens during exit(). In that
    case timeout should take a care. No way around, except more
    complicated code:
    
       if (current->flags & PF_EXITING) {
         lock(...)
         rm_sig_from_queue(SIGKILL, &current->pending);
         unlock(...)
       }
       mask = sigmask(SIGKILL);
       
    which allows you to 'kill -9' exiting task again...
    But I cannot convice myself that SIGKILL is correctly delivered
    to PF_EXITING tasks... And rm_sig_from_queue is signal.c internal
    function.
(3) attaching/detaching debugger causes no longer problems, as SIGSTOP 
    is ignored by ncpfs - I have no idea why original code included
    SIGSTOP... Now it just stops task after NCP request is done, so
    only problem is that you cannot immediately stop program which
    waits for server reply. But I think that waiting few milliseconds
    is better than killing connection for whole server
(4) so you can happilly debug programs from ncpfs volumes

If it will not cause too much troubles for you, can you find multithreaded
test program for me? Current solution, which uses only SIGKILL, and only
when task does not exit, looks good for me, and works for my testcases.
There are some corner cases, such as when SIGKILL is already pending when 
ncpfs is entered, but I'm not sure whether it is worth of adding check 
of signal_pending() before call to do_ncp_*rpc_call(), as it is not four 
line patch then.
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
