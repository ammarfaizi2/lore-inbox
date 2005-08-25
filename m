Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbVHYR0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVHYR0n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 13:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVHYR0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 13:26:43 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:24880 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751344AbVHYR0m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 13:26:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FJMSvDUPjXWueY2sBkmNianSA5Nc/NQa3st0hUu4kvI5HoD1aweE1ygR/GUFxlsIjACXH0rrcaBnDdH7oFysK8f5TNfPlI9+XmrHn59RvOpROMTBpmmWZgUwJ9HDIQVHurtcX1mDJBJdlyZoDzkd7IfySw7dBmktF5Uwvf6DZyE=
Message-ID: <5a4c581d050825102678c27b4e@mail.gmail.com>
Date: Thu, 25 Aug 2005 19:26:41 +0200
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Harald Welte <laforge@netfilter.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netfilter-devel@lists.netfilter.org
Subject: Re: oops in 2.6.13-rc6-git12 in tcp/netfilter routines
In-Reply-To: <20050825165550.GC4442@rama.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d05082506395fa984ae@mail.gmail.com>
	 <20050825165550.GC4442@rama.de.gnumonks.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/05, Harald Welte <laforge@netfilter.org> wrote:
> On Thu, Aug 25, 2005 at 03:39:02PM +0200, Alessandro Suardi wrote:
> > Howdy, and excuse me for crossposting - feel free to zap CC to
> >  unrelated, if any, mailing lists.
> >
> >   just gave PeerGuardian a spin on my eDonkey home box and
> >   said box didn't last half a day before oopsing in netlink/nf/tcp
> >   related routines (or so it seems to my untrained eye).
> 
> Yes, it indeed could be that there is some fishy interaction between the
> tcp stack and ip_queue causing the oops.
> 
> > K7800, 256MB RAM, uptodate FC3 running 2.6.13-rc6-git12,
> >  doing nothing but running MetaMachine's eDonkey 1.4.3 QT gui.
> > PeerGuardian is the 1.5 beta version available from methlabs.org.
> 
> Is it true that PeerGuardian is a proprietary application?  I'm not
> going to debug this problem using a proprietary ip_queue program, sorry.

I'm not sure I understand the issue; I built PG from these sources:

http://prdownloads.sourceforge.net/peerguardian/pglinux-1.5beta.tar.gz?download

 and I had to install the iptables-devel FC3 rpm to build. The PG
 sources seem to be licensed under GPLv2. But maybe you're
 referring to the fact that whatever PG does, it doesn't show up
 as output from 'iptables -L' ?

> If you can produce a testcase with open source userspace ip_queue code,
> I could look into reproducing the problem locally and debugging the
> problem more thoroughly.

So far the box has been running for over four hours, I'll configure
 my laptop as a netdump server hoping it might capture something
 if the ed2k box crashes again later. I'm afraid I won't be able to set
 up a real testcase (and btw, edonkey v1.4.3 from MetaMachine is
 actually a proprietary program, though entirely in userspace).

> While it definitely is a kernel bug (whatever userspace sends should not
> crash the kernel), it might be something that specifically [only]
> PeerGuardian does to the packet.  Something that ip_queue doesn't check
> (but should check) on packet reinjection and therefore upsets the TCP stack.
> 
> Also helpful would be the output of an "strace -f -x -s65535 -e
> trace=sendmsg" on the PeerGuardian (daemon?) process.
> 
> 
> > [<c0103714>] die+0xe4/0x170
> > [<c010381f>] do_trap+0x7f/0xc0
> > [<c0103b33>] do_invalid_op+0xa3/0xb0
> > [<c0102faf>] error_code+0x4f/0x54
> > [<c02eb05b>] kfree_skbmem+0xb/0x20
> > [<c02eb0cf>] __kfree_skb+0x5f/0xf0
> 
> ok, so something down the chain from kfree_skb() results in an invalid
> operation? looks more like some compiler problem, bad memory or memory
> corruption to me.  Try to reproduce the problem without PG.

compiler is fc3's latest - gcc-3.4.4-2.fc3. I might have a go at
 memtest86 in the next weeks if more symptoms point at
 possible bad RAM.

> > [<c031304a>] tcp_clean_rtx_queue+0x16a/0x470
> > [<c0313746>] tcp_ack+0xf6/0x360
> > [<c0315d57>] tcp_rcv_established+0x277/0x7a0
> > [<c031eba0>] tcp_v4_do_rcv+0xf0/0x110
> > [<c031f2a0>] tcp_v4_rcv+0x6e0/0x820
> > [<c0305594>] ip_local_deliver_finish+0x84/0x160
> 
> so something in the tcp stack ends up doing tcp_clean_rtx_queue()
> 
> > [<c02fbe4a>] nf_reinject+0x13a/0x1c0
> > [<c033f0d8>] ipq_issue_verdict+0x28/0x40
> > [<c033f968>] ipq_set_verdict+0x48/0x70
> 
> ip_queue reinjects a packet via nf_reinject()
> 
> > [<c033fa79>] ipq_receive_peer+0x39/0x50
> > [<c033fc72>] ipq_receive_sk+0x172/0x190
> 
> ip_queue receives and ipq verdict msg packet from netlink
> 
> > [<c02fffa5>] netlink_data_ready+0x35/0x60
> > [<c02ff4a4>] netlink_sendskb+0x24/0x60
> > [<c02ff657>] netlink_unicast+0x127/0x160
> > [<c02ffcc4>] netlink_sendmsg+0x204/0x2b0
> > [<c02e6dc0>] sock_sendmsg+0xb0/0xe0
> > [<c02e83f4>] sys_sendmsg+0x134/0x240
> > [<c02e88e4>] sys_socketcall+0x224/0x230
> > [<c0102d3b>] sysenter_past_esp+0x54/0x75
> 
> process sendmsg()s on the netlink socket.

Thanks,

--alessandro

 "Not every smile means I'm laughing inside"

    (Wallflowers - "From The Bottom Of My Heart")
