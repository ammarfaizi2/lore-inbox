Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129563AbQK1BTW>; Mon, 27 Nov 2000 20:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129725AbQK1BTL>; Mon, 27 Nov 2000 20:19:11 -0500
Received: from [203.126.247.144] ([203.126.247.144]:44179 "EHLO
        esngs144.nortelnetworks.com") by vger.kernel.org with ESMTP
        id <S129563AbQK1BTB>; Mon, 27 Nov 2000 20:19:01 -0500
Message-ID: <3A2300A9.42D40D68@asiapacificm01.nt.com>
Date: Tue, 28 Nov 2000 00:47:37 +0000
From: "Andrew Morton" <morton@nortelnetworks.com>
Organization: Nortel Networks, Wollongong Australia
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.0-test11-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org, andrewm@uow.edu.au
Subject: Re: OOps in exec_usermodehelper
In-Reply-To: <E0CA73F3362@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <morton@asiapacificm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> 
> Hi,
>   I have one small problem with 2.4.0-test11 and exec_usermodehelper.
> When vmware modules shutdown (specifically vmnet-netifup), kernel tries
> to load some module through call_usermodehelper, but unfortunately
> from task which has current->files == NULL.
> 
>   So it prints message:
> 
> waitpid(19457) failed, -512
> 
>   and then it oopses in
> 
> for (i = 0; i < current->files->max_fds; i++) {
>   if (current->files->fd[i]) close(i);
> }
> 
> (In log, there is first waitpid, and then oopses from current->files == NULL,
> which I do not quite understand).
> 
> Should I look into this more deeply, or is correct fix just add
> 
> if (current->files) {
>   for (i = 0; ..... ) ...
> }
> 
> into exec_usermodehelper?

No.  Then it just blows up somewhere else.

The root cause here is that we're starting a kernel thread
from within a half-exitted parent.  I'll be coding a fix 
later today.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
