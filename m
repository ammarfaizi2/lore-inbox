Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129336AbRBAOlM>; Thu, 1 Feb 2001 09:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130364AbRBAOlC>; Thu, 1 Feb 2001 09:41:02 -0500
Received: from oxmail3.ox.ac.uk ([129.67.1.180]:4309 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S129336AbRBAOlA>;
	Thu, 1 Feb 2001 09:41:00 -0500
Date: Thu, 1 Feb 2001 14:40:52 +0000
From: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Serious reproducible 2.4.x kernel hang
Message-ID: <20010201144052.B27009@sable.ox.ac.uk>
In-Reply-To: <Pine.LNX.4.30.0102011406210.14706-100000@ferret.lmh.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0102011406210.14706-100000@ferret.lmh.ox.ac.uk>; from chris@scary.beasts.org on Thu, Feb 01, 2001 at 02:14:09PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Evans writes:
> I've just managed to reproduce this personally on 2.4.0. I've had a report
> that 2.4.1 is also affected. Both myself and the other person who
> reproduced this have SMP i686 machines, which may or may not be relevant.
> 
> To reproduce, all you need to do is get my vsftpd ftp server:
> ftp://ferret.lmh.ox.ac.uk/pub/linux/vsftpd-0.0.9.tar.gz

I got this just before lunch too. I was trying out 2.4.1 + zerocopy
(with netfilter configured off, see the sendfile/zerocopy thread for
more details and hardware specs) and tried running vsftpd on the
slower machine instead of the faster machine as before. I connected
to vsftpd with an ftp client and got a
    500 OOPS: chdir
    Login failed.
    421 Service not available, remote server has closed connection
(ftpd's idea of an OOPS; not the kernel's idea of an oops, of course).
That was probably because I hadn't configured the directory properly
but following that the machine hung, in the following way: userland
hung: no more logins, existent xterm processes didn't refresh their
windows on my (remote) display. The machine was still pingable, though.

I configured Magic SysRq into the kernel but hadn't played with it
before so I hadn't enabled it in /proc (D'oh. Next time I'll know.)
As in Chris' case, vzftpd was a zombie (so Foo-ScrollLock told me) and
all other processes were looking OK in R or S state.

Looking at the kernel's EIP every so often to see what was going
showed remove_wait_queue, add_wait_queue, skb_recv_datagram and
wait_for_packet mostly. Random thought: if vsftpd did a sendfile and
then exited, becoming a zombie, could there be a problem with
tearing down a sendfile mapping? I'm off to read some code.

--Malcolm

-- 
Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Unix Systems Programmer
Oxford University Computing Services
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
