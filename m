Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbUKREZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbUKREZx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 23:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbUKREZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 23:25:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4839 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262526AbUKREZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 23:25:46 -0500
Date: Wed, 17 Nov 2004 23:25:39 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Ross Kendall Axe <ross.axe@blueyonder.co.uk>
cc: netdev@oss.sgi.com, Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
 using SELinux and SOCK_SEQPACKET
In-Reply-To: <Xine.LNX.4.44.0411172222160.2531-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0411172323260.2700-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004, James Morris wrote:

> There is a non SELinux-related bug lurking in this code.

I also got this when trying to kill the server (which seems to run at 100% 
during exit after receving a message sent with sendto() + address):

Badness in sk_del_node_init at include/net/sock.h:343
 [<c010339a>] dump_stack+0x17/0x19
 [<c03193bc>] __unix_remove_socket+0x64/0x66
 [<c03196e4>] unix_release_sock+0x2b/0x259
 [<c02bdf07>] sock_release+0x7a/0xda
 [<c02be973>] sock_close+0x21/0x3d
 [<c0151b2c>] __fput+0x11d/0x15b
 [<c015052a>] filp_close+0x42/0x74
 [<c0102525>] sysenter_past_esp+0x52/0x71


Which is:

static __inline__ int sk_del_node_init(struct sock *sk)
{
        int rc = __sk_del_node_init(sk);

        if (rc) {
                /* paranoid for a while -acme */
                WARN_ON(atomic_read(&sk->sk_refcnt) == 1);  <-- here




- James
-- 
James Morris
<jmorris@redhat.com>


