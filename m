Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTEBLkg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 07:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbTEBLkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 07:40:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:27025 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262018AbTEBLkf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 07:40:35 -0400
Date: Fri, 2 May 2003 07:53:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Lee, Shuyu" <SLee@cognex.com>
cc: linux-kernel@vger.kernel.org, "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: How to notify a user process from within a driver
In-Reply-To: <6AF24836F3EB074BA5C922466F9E92E10791B532@prince.pc.cognex.com>
Message-ID: <Pine.LNX.4.53.0305020740180.6384@chaos>
References: <6AF24836F3EB074BA5C922466F9E92E10791B532@prince.pc.cognex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 May 2003, Lee, Shuyu wrote:

> Richard and Alan,
>
> Thank you for the info. Given the prototype for poll() is
> "int poll(struct pollfd *ufds, unsigned int nfds, int timeout);", and pollfd
> is struct pollfd {int fd; short events; short revents};, how do I
> communicate complex info to the driver?
>
> For example, assuming there are 8 input lines on my hardware, and the user
> wants to be notified in the following three cases:
> 1) input on Line 1 only,
> 2) input on either Line 2 or Line 3,
> 3) input on both Line 4 and Line 5,
> how do I pass that info to the driver? Also, other than POLLERR and POLLHUP,
> can I pass back to the user more descriptive error messages?
>
> Thanks,
> Shuyu
>

poll() tells you something happened, ioctl() tells you what. Poll
has some bits (POLLIN, POLLOUT, etc.) that can be used to tell
the user-mode task what information to actually request in the
ioctl() call. Your ioctl() can receive and send anything if you
use the third variable as a pointer to your stuff.

	struct info {
		int a;
		int b;
		...
		...
		} info;
        int fd;
        struct pollfd pfd;
        fd = open("/dev/device", O_RDWR);

        pfd.fd = fd;
        pfd.events = POLLIN;
        pfd.revents = 0;
        if(poll(&pfd, 1, 0) <= 0)
            handle_problem();
        else if (pfd.revents & POLLIN)
            ret = ioctl(fd, GET_MY_INFORMATION, &foo);
        else if (pfd.revents & POLLOUT)
            ret = ioctl(fd, CHANGE_CONFIGURATION, &how);


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

