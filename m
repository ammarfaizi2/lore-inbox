Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130690AbQKIU2d>; Thu, 9 Nov 2000 15:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131143AbQKIU2X>; Thu, 9 Nov 2000 15:28:23 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:38930 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130690AbQKIU2L>;
	Thu, 9 Nov 2000 15:28:11 -0500
Message-ID: <3A0B08A4.38A37F1F@mandrakesoft.com>
Date: Thu, 09 Nov 2000 15:27:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Brian Gerst <bgerst@didntduck.org>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Module open() problems, Linux 2.4.0
In-Reply-To: <Pine.LNX.3.95.1001109150621.15404A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Thu, 9 Nov 2000, Brian Gerst wrote:
> 
> > "Richard B. Johnson" wrote:
> > >
> > > `lsmod` shows that a device is open twice when using Linux-2.4.0-test9
> > > when, in fact, it has been opened only once.
> > >
> 
> > >
> > > When the module is closed, the use-count goes to zero as expected.
> > > However, a single open() causes the use-count to be 2.
> >
> > This is harmless.  It is caused by a try_inc_mod_count(module) in the
> > function calling device_open(), which is the proper way for module
> > locking to be handled when not holding the BKL.  You can keep the
> > MOD_INC_USE_COUNT in the device driver for compatability with 2.2.
> >
> >                               Brian Gerst
> 
> This may be, as you say, "harmless". It is, however, a bug. The
> reporting must be correct or large complex systems can't be
> developed or maintained.
> 
> I had two persons, working nearly a week, trying to find out
> what one of over 200 processes had a device open when only
> one was supposed to have it opened. --Err we have to check
> our work here. The fact that something "works" is not
> sufficient.

There is NO guarantee that module use count == device open count.  Never
has been, AFAIK.  It just happens to work out that way on a lot of
pre-2.4 code.

The kernel is free to bump the module reference count up and down as it
pleases.  For example, if a driver creates a kernel thread, that will
increase its module usage count by one, for the duration of the kernel
thread's lifetime.

The only rule is that you cannot unload a module until its use count it
zero.  

	Jeff


-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
