Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262738AbREOLKk>; Tue, 15 May 2001 07:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262736AbREOLKa>; Tue, 15 May 2001 07:10:30 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:8109 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S262734AbREOLKS>; Tue, 15 May 2001 07:10:18 -0400
Message-ID: <3B010C64.556758D8@uow.edu.au>
Date: Tue, 15 May 2001 21:00:52 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: jgarzik@mandrakesoft.com, davem@redhat.COM, linux-kernel@vger.kernel.org
Subject: Re: NETDEV_CHANGE events when __LINK_STATE_NOCARRIER is modified
In-Reply-To: <3B006F84.C1427EB3@uow.edu.au> from "Andrew Morton" at May 15, 1 09:51:32 am <200105150902.NAA29079@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > It protects the as-yet-unchanged PCI and Cardbus drivers from a
> > fatal race.
> 
> Fatal race remained.

Don't think so.  We have exclusion against all netdevice ioctls
across probe.  Still.  It doesn't matter.

> Andrew, you start again the story about white bull. 8)
> We have already discussed this. Device cannot stay in device list
> uninitialzied. Period.
> 
> I am sorry, but no compromise is possible. With Jeff's approach all
> the references to init_etherdev and dev_probe_lock must be eliminated
> in 2.4.

Once init_etherdev() has gone, yes, dev_probe_lock() can go.

> > and sys_ioctl() both do lock_kernel().  If xxx_probe() drops the BKL,
> 
> Again, BKL has nothing to do with this (and ioctl does not hold it)

asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
{       
        struct file * filp;
        unsigned int flag;
        int on, error = -EBADF;

        filp = fget(fd);
        if (!filp)
                goto out;
        error = 0;
        lock_kernel();

The CPU running ifconfig spins here.

> It looks like you forgot all the discussion around your own patch. 8)
> 
> If you want I can retransmit the mails which resulted in your patch?

It doesn't matter...  I think we agree that init_etherdev() must
die, and dev_probe_lock() with it, and that Jeff's alloc_etherdev()
is an appropriate way of doing it?

Actually, yes.  Please tell me what problem you think we
still have in current kernels, which dev_probe_lock()
does not prevent?

-
