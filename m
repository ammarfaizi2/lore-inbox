Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131692AbQKCUju>; Fri, 3 Nov 2000 15:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131422AbQKCUjk>; Fri, 3 Nov 2000 15:39:40 -0500
Received: from 23-ZARA-X54.libre.retevision.es ([62.82.247.23]:58638 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S131148AbQKCUj2>;
	Fri, 3 Nov 2000 15:39:28 -0500
Message-ID: <3A02F9AA.AFB2DB1B@zaralinux.com>
Date: Fri, 03 Nov 2000 18:45:14 +0100
From: Jorge Nerin <comandante@zaralinux.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: es-ES, es, en
MIME-Version: 1.0
To: Paul Gortmaker <p_gortmaker@yahoo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux SMP Mailing List <linux-smp@vger.kernel.org>
Subject: Re: [patch] NE2000
In-Reply-To: <E13pz9c-0006Jh-00@the-village.bc.nu> <39FD5433.587FF7C6@zaralinux.com> <39FFE612.2688A5AD@yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Gortmaker wrote:
> 
> Jorge Nerin wrote:
> 
> >
> > Ok, I reported it several times, but it gets ignored. I have a Realtek
> > 8029 (ne2k-pci), and with both drivers ne and ne2k-pci I can easily get
> > it stuck by doing a ping -f to a host in the local net, and sometimes it
> > happens doing copies to/from nfs shared resources.
> >
> > rmmod & insmod don't cure the problem, it seems that no interrupts are
> > delivered from the card, and there are no log messages, so a reboot is
> > needed to restore net access.
> >
> > System is dual 2x200mmx 96Mb ide discs no interrupts shared, and as far
> > as I can remember all kernel from 2.2.x, 2.3.x up to 2.4.0-testx exhibit
> > this problem.
> 
> Any messages from the driver whatsoever?   Does running a non-SMP
> kernel make the problem go away?
> 
> Paul.
> 

Well, I have tried it with 2.4.0-test10, both SMP and non-SMP, and the
result is a little confusing.

Under SMP a ping -s 50000 -f other_host takes down the network access
with no messages (ne2k-pci), and no possibility of being restored
without a reboot.

Under UP the same command works ok, but after a while the dots stop for
30sec, then ping prints an 'E' and the dots continue. strace revealed
this:

sendmsg(4, {msg_name(16)={sin_family=AF_INET, sin_port=htons(0),
sin_addr=inet_addr("192.168.1.20")}},
msg_iov(1)=[{"\10\0\305~|\23\231\0\v\317\2:\177\236\r\0\10\t\n\v\f\r"...,
50008}], msg_controllen=0, msg_flags=0}, 0x800) = 50008 <30.016855>

ping has been waiting for sendmsg to end for 30 seconds! I don't know if
this could be caused by filling the network buffers, and then waiting a
while while the nic sends it out. As the packet size increases (the -s
option) the stops are more frequent, there is still activity on the
network, but I don't know if they are my packets or the replies.

When ping is stopped it's stuck in sock_wait_for_wmem, and when it's
running it's (usually) in wait_for_packet.

So I think that it could be a little window near sock_wait_for_wmem that
could be SMP insecure wich is affecting me.

The code of sock_wait_for_wmem in 2.4.0-test10 is this:

static long sock_wait_for_wmem(struct sock * sk, long timeo)
{
	DECLARE_WAITQUEUE(wait, current);

	clear_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);
	add_wait_queue(sk->sleep, &wait);
	for (;;) {
		if (signal_pending(current))
			break;
		set_bit(SOCK_NOSPACE, &sk->socket->flags);
		set_current_state(TASK_INTERRUPTIBLE);
		if (atomic_read(&sk->wmem_alloc) < sk->sndbuf)
			break;
		if (sk->shutdown & SEND_SHUTDOWN)
			break;
		if (sk->err)
			break;
		timeo = schedule_timeout(timeo);
	}
	__set_current_state(TASK_RUNNING);
	remove_wait_queue(sk->sleep, &wait);
	return timeo;
}

Does someone see something SMP insecure? Perhaps I'm totally wrong, this
could also be somewhere in the interrupt handling, don't know.

-- 
Jorge Nerin
<comandante@zaralinux.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
