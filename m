Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbVJRSsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVJRSsr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 14:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVJRSsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 14:48:47 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:461 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750896AbVJRSsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 14:48:46 -0400
Message-ID: <435542F6.7050301@comcast.net>
Date: Tue, 18 Oct 2005 14:46:14 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Petrovic, Boban" <Boban.Petrovic@windriver.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOM killer code in 2.6 kernel
References: <1129656173.10335.51.camel@localhost.localdomain>
In-Reply-To: <1129656173.10335.51.camel@localhost.localdomain>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

So basically you discovered:

 - OOM activated due to say 512K free RAM (OOM happens before this IIRC
but eh)
 - OOM kills process to give 127M free RAM
 - Other CPU wants 4M RAM, so far 3M are free from killed process
 - ANOTHER OOM kill happens to free up another 35M of RAM

Looks like a race condition?

Petrovic, Boban wrote:
>   I have stumbled upon very interesting and in other hand very hard
> problem. I am trying to integrate code which introduces process
> protection from OOM killer action in cases when there is not enough RAM
> in the system. The code works fine on architectures like ppc32, ppc64
> and arm XScale. On Intel Xeon and Pentium M architectures with disabled
> SMP and HighMem support in the kernel the code also works fine. Problem
> begins if I turn on SMP and HighMem. I am using a test case which work
> following way:  when child is forked both parent and child malloc amount
> of memory which when summed together exceed amount of memory available
> on system; parent is than protected. On the Intel architectures with SMP
> and HighMem on I experience that OOM kills many processes in addition to
> child process like sshd, portmap, bash, xinetd, etc.  Number of killed
> processes vary from one test execution to other. As, I pointed out
> earlier, the code works fine only when SMP and HighMem are off. Any
> other combination of these options still causes the problem. I am using
> heavily patched Linux 2.6.10 kernel, with Kernel preempt turned off (the
> problem occurs with vanilla 2.6.14rc2 kernel also). The targets I have
> tested so far don't use swap device, and they have RAM in amounts
> starting from 1Gb.
>   What I discovered so far is that when OOM sends SIGKILL to process,
> memory owned by process is not released as quickly as system would like.
> Processes running on other processors jump into OOM and eventually more
> processes get killed. I introduced changes to mm/page_alloc.c ->
> __alloc_pages() function which suppress more than one processor to enter
> the OOM code, and also I reduced number of OOM calls to one call per
> second for allowed processor. The idea is to give enough time to process
> marked to be killed to release pages. The change works fine for one of
> the targets but isn't working for other Intel boards.
>   I need more insight on what might cause slow releasing of pages, when
> this release occurs and which part of kernel is in charge of that.
> Please CC me with your replies.
> 
>   Thanks,
>   Boban
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDVUL1hDd4aOud5P8RAoGvAJ9jSA5XF+WS625Ha0WJQEI49oey+QCdHj78
XL5rgwxIfmh9MyfJR8hrSlE=
=b8pR
-----END PGP SIGNATURE-----
