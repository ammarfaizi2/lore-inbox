Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271642AbRHQMvM>; Fri, 17 Aug 2001 08:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271643AbRHQMvC>; Fri, 17 Aug 2001 08:51:02 -0400
Received: from camus.xss.co.at ([194.152.162.19]:30213 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S271642AbRHQMuu>;
	Fri, 17 Aug 2001 08:50:50 -0400
Message-ID: <3B7D1330.6E2B4B46@xss.co.at>
Date: Fri, 17 Aug 2001 14:50:57 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S - *x Software + Systeme
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Daniel Wagner <daniel.wagner@xss.co.at>, linux-kernel@vger.kernel.org,
        okir@monad.swb.de
Subject: Re: initrd: couldn't umount
In-Reply-To: <E15Xgr3-000775-00@the-village.bc.nu> <3B7CF68D.9694DD53@xss.co.at> <3B7CFCF8.87A3968E@xss.co.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(added okir@monad.swb.de to CC: list, as he is listed in the 
header of linux/net/sunrpc/sched.c as author of this file)

To answer my own question... ;-)

Andreas Haumer wrote:
> 
> Hi!
> 
> Daniel Wagner wrote:
> >
> > Alan Cox wrote:
[...]
> > > It shouldnt be keeping a reference. daemonize() should have dropped its
> > > resources
> >
> > hmm, i've now created a /initrd directory to let the the change_root of
> > the
> > initrd work correctly.
> >
> > and then i looked with fuser, what processes reference the initrd:
> >
> > ---
> > root@ws4:~ $ fuser -mv /initrd/
> >
> >                      USER        PID ACCESS COMMAND
> > /initrd/             root         67 .rc..
> > rpciod
> > ---
> >
> > only the rpciod references the initrd, none of the other
> > kernel-threads.
> >
> Could it be because, when executed, rpciod() calls
> exit_files(current) and exit_mm(current), but doesn't
> call exit_fs(current) (as, for instance, md_thread() does)?
> (we are talking 2.2.19 here)
> 
Yes, an additional call to exit_fs(current) when initializing
the rpciod thread solves this problem without creating other 
(obvious) problems (as it seems after a short test).

The inital ramdisk can now be unmounted cleanly even in case
of NFS root

The suggested patch is:

andreas@ws1:~/cvsdir {625} % cvs diff -C5 -rR_2-2-19~11 -rR_2-2-19~12
linux/net/sunrpc/sched.c
Index: linux/net/sunrpc/sched.c
===================================================================
RCS file:
/raid5/cvs/repository/distribution/Base/linux/net/sunrpc/sched.c,v
retrieving revision 1.1.1.6
retrieving revision 1.12
diff -C5 -r1.1.1.6 -r1.12
*** linux/net/sunrpc/sched.c    2001/03/25 16:37:42     1.1.1.6
--- linux/net/sunrpc/sched.c    2001/08/17 11:53:48     1.12
***************
*** 1066,1075 ****
--- 1066,1076 ----
        rpciod_pid = current->pid;
        up(&rpciod_running);
 
        exit_files(current);
        exit_mm(current);
+       exit_fs(current);
 
        spin_lock_irq(&current->sigmask_lock);
        siginitsetinv(&current->blocked, sigmask(SIGKILL));
        recalc_sigpending(current);
        spin_unlock_irq(&current->sigmask_lock); 


Alan, would you consider adding this patch to 2.2.20?

Thanks!

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
