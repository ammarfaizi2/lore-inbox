Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264269AbUEXMYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbUEXMYf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 08:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUEXMYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 08:24:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15236 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264269AbUEXMYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 08:24:32 -0400
Date: Mon, 24 May 2004 08:24:31 -0400
From: Aldy Hernandez <aldyh@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: partial oops on 2.6.6-bk9 (netconsole + tulip dmfe ethernet)
Message-ID: <20040524122431.GA3732@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks.

I'm trying to track down a kernel lockup on my box.  What looked like
a FC2 issue, seems like an actual kernel problem.  My box is dying
after 2 days of uptime.

I've enabled nmi_watchdog and netconsole to track the problem.  What I
get looks like a partial Oops, or something quite unusable:

    Unable to handle kernel paging request at virtual address 8cffffe8
     printing eip:
    c017bff0
    *pde = 00000000
    Oops: 0000 [#1]
    SMP 

No stack trace.  No register dump.  Nothing.

I have compiled the kernel with debugging, and the offended code is
here:

(gdb) l *0xc017bff0
0xc017bff0 is in sys_poll (fs/select.c:517).
512             err = -EFAULT;
513             while(walk != NULL) {
514                     struct pollfd *fds = walk->entries;
515                     int j;
516
517                     for (j=0; j < walk->len; j++, ufds++) {
518                             if(__put_user(fds[j].revents, &ufds->revents))
519                                     goto out_fds;
520                     }
521                     walk = walk->next;

My box is a P4 with a Tulip/Davicom (dmfe.o) network card.  I have
noticed that the CONFIG_NET_POLL_CONTROLLER code was recently added to
the dmfe.c driver, so I'm wondering if this particular Oops is due to
the driver, and not the actual problem I'm chasing down.

My kernel parameters are:

        kernel /bzImage ro root=LABEL=/ rhgb quiet vdso=0 netconsole=6665@172.31.1.50/eth0,6666@172.31.1.137/00:30:65:02:c4:c3 nmi_watchdog=1

I'm not very kernel savvy, so any pointers would be greatly
appreciated.  Perhaps I should try configuring a serial console?

How can I be of use in helping to track down this problem?  BTW, 2.4.x
worked fine with my box.

Cheers.
Aldy
