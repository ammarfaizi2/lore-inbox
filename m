Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbUKRDnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbUKRDnA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 22:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUKRDm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 22:42:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31189 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262387AbUKRDmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 22:42:54 -0500
Date: Wed, 17 Nov 2004 22:42:37 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Ross Kendall Axe <ross.axe@blueyonder.co.uk>
cc: netdev@oss.sgi.com, Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
 using SELinux and SOCK_SEQPACKET
In-Reply-To: <419BE847.90307@blueyonder.co.uk>
Message-ID: <Xine.LNX.4.44.0411172222160.2531-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Ross Kendall Axe wrote:

> Ross Kendall Axe wrote:
> > 
> > A possibility that hadn't occurred to me was using sendto to send packets
> > without connecting. Is this supposed to work? If so, then my patch is
> > indeed inappropriate. If not, then that needs fixing also.
> > 
> 
> Well, my reading of socket(2) suggests that it's _not_ supposed to work.

sendto() on a non connected socket should fail with ENOTCONN.

> This patch causes sendmsg on SOCK_SEQPACKET unix domain sockets to return
> EISCONN or ENOTSUPP as appropriate if the 'to' address is specified.

For sendto():

The address must be ignored on a connected mode socket (i.e. in this 
case).

According to the send(2) man page, we may return EISCONN if the address
and addr length are not NULL and zero.  I think that the man page is
incorrect.  Posix says that EISCONN means "A destination address was
specified and the socket is already connected", not "A destination address
was specified and the socket is connected mode".  i.e. we should only 
return EISCONN if the socket is in a connected state.

I'm not sure if we should return any error at all if an address is 
supplied to sendto() on SOCK_SEQPACKET.  We're only required to ignore it.

I would say that we should return an error as it is likely a progamming 
mistake in the application and we should let them know.

However, as mentioned above, I don't think EISCONN is appropriate in this 
case.  EINVAL might be better.

> It also causes recvmsg to return EINVAL on unconnected sockets. This
> behaviour is consistent with SOCK_STREAM sockets.

This seems incorrect too, Posix says to use ENOTCONN.

There is a non SELinux-related bug lurking in this code.  I got this oops
when trying to kill a modified version of seqpacket-crash which keeps
sending in a loop and uses sendto() and an address with SOCK_SEQPACKET.

------------[ cut here ]------------
kernel BUG at include/asm/spinlock.h:133!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in: ipv6 binfmt_misc video ac e1000 3c59x
CPU:    0
EIP:    0060:[<c03393b2>]    Not tainted VLI
EFLAGS: 00010282   (2.6.10-rc2)
EIP is at _spin_lock_bh+0x4b/0x55
eax: 0000000e   ebx: f757b04c   ecx: c038c60c   edx: 00000292
esi: f757b04c   edi: f73f096c   ebp: c1bf8ed4   esp: c1bf8ec8
ds: 007b   es: 007b   ss: 0068
Process seqpacket-crash (pid: 4989, threadinfo=c1bf8000 task=f75fd530)
Stack: c034c39c c02c171e f757b02c c1bf8ee4 c02c171e f79448d4 f73f098c c1bf8f0c
       c02be9d4 f73f0960 f757b02c 00000000 00000000 ffffffff f73f098c 00000000
       dfff3b20 c1bf8f1c c02be96b 00000000 f79448d4 c1bf8f38 c0151b2c f73f098c
Call Trace:
 [<c010336d>] show_stack+0x7a/0x90
 [<c01034ee>] show_registers+0x152/0x1ca
 [<c01036f5>] die+0x100/0x184
 [<c0103b53>] do_invalid_op+0xd2/0xea
 [<c010301b>] error_code+0x2b/0x30
 [<c02c171e>] lock_sock+0x20/0x50
 [<c02be9d4>] sock_fasync+0x45/0x147
 [<c02be96b>] sock_close+0x19/0x3d
 [<c0151b2c>] __fput+0x11d/0x15b
 [<c015052a>] filp_close+0x42/0x74
 [<c011a699>] put_files_struct+0x87/0xfc
 [<c011b440>] do_exit+0x17b/0x48d
 [<c011b7f9>] do_group_exit+0x32/0x9e
 [<c0102525>] sysenter_past_esp+0x52/0x

--------------------

i.e.:

static inline void _raw_spin_lock(spinlock_t *lock)
{
#ifdef CONFIG_DEBUG_SPINLOCK
        if (unlikely(lock->magic != SPINLOCK_MAGIC)) {
                printk("eip: %p\n", __builtin_return_address(0));
                BUG();
        }
#endif




- James
-- 
James Morris
<jmorris@redhat.com>



