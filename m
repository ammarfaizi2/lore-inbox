Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVHBN3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVHBN3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 09:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVHBN3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 09:29:02 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:58759 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261511AbVHBN2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 09:28:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:x-message-flag:x-operating-system:x-editor:x-disclaimer:user-agent;
        b=JS37F2LLuB1k91qVw2hDds/pt14lO/pZQqZD43NWSksNdaQiWpKwOF8YuIZibzAuKviCLwmTPFep5PiW5cj/4WViq2N1gtiICXM8dUzqA03qszQyOJ5lZ8a/zFdPLVnnEb8o3U8m98n6vAWETk+3ilVLInsKx4f61sCRBtGdwlc=
Date: Tue, 2 Aug 2005 15:29:22 +0200
From: Mattia Dongili <malattia@gmail.com>
To: Patrick McHardy <kaber@trash.net>
Cc: Harald Welte <laforge@netfilter.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: atomic counter underflow at ip_conntrack_event_cache_init+0x91/0xb0 (with patch)
Message-ID: <20050802132922.GA3834@inferi.kami.home>
Mail-Followup-To: Patrick McHardy <kaber@trash.net>,
	Harald Welte <laforge@netfilter.org>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050801141327.GA3909@inferi.kami.home> <42EE3169.6070604@trash.net> <20050801160537.GA3850@inferi.kami.home> <42EE5721.1090509@trash.net> <42EEC2BB.3020105@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EEC2BB.3020105@trash.net>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.13-rc4-mm1-3 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 02:47:55AM +0200, Patrick McHardy wrote:
> Patrick McHardy wrote:
> > Mattia Dongili wrote:
[...]
> This should be a fist step towards fixing it. It's probably incomplete
> (I'm too tired to check it now), but it should fix the problem you're
> seeing. Could you give it a spin?

Done, also this patch fixes the uderflow problem.

> BTW, ip_ct_iterate_cleanup can only be called from ipt_MASQUERADE when
> a device goes down. It seems a bit odd that this is happending on boot,
> is there anything special about your setup?

So I played a little more with the BUGgy kernel and I traked some simple
actions to trigger the underflow:

0- boot at init 1

1- modprobe ipt_MASQUERADE
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.3 (2044 buckets, 16352 max) - 252 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team

2- ifup eth0
e100: eth0: e100_watchdog: link up, 10Mbps, half-duplex
BUG: atomic counter underflow at:
 [<d0c6738a>] ip_ct_iterate_cleanup+0xfa/0x100 [ip_conntrack]
 [<d0c441d3>] masq_inet_event+0x33/0x40 [ipt_MASQUERADE]
 [<d0c441e0>] device_cmp+0x0/0x40 [ipt_MASQUERADE]
 [<c012733d>] notifier_call_chain+0x2d/0x50
 [<c02bea43>] inet_del_ifa+0x93/0x1d0
 [<c02bf6af>] devinet_ioctl+0x4af/0x5a0
 [<c02c1946>] inet_ioctl+0x66/0xb0
 [<c0278be9>] sock_ioctl+0xc9/0x230
 [<c016df2e>] do_ioctl+0x8e/0xa0
 [<c02d5e08>] do_page_fault+0x188/0x613
 [<c016e0f5>] vfs_ioctl+0x65/0x1f0
 [<c016e2c5>] sys_ioctl+0x45/0x70
 [<c0103185>] syscall_call+0x7/0xb

3- ifdown eth0 && ifup eth0
e100: eth0: e100_watchdog: link up, 10Mbps, half-duplex
BUG: atomic counter underflow at:
 [<d0c6738a>] ip_ct_iterate_cleanup+0xfa/0x100 [ip_conntrack]
 [<d0c441d3>] masq_inet_event+0x33/0x40 [ipt_MASQUERADE]
 [<d0c441e0>] device_cmp+0x0/0x40 [ipt_MASQUERADE]
 [<c012733d>] notifier_call_chain+0x2d/0x50
 [<c02bea43>] inet_del_ifa+0x93/0x1d0
 [<c02bf6af>] devinet_ioctl+0x4af/0x5a0
 [<c02c1946>] inet_ioctl+0x66/0xb0
 [<c0278be9>] sock_ioctl+0xc9/0x230
 [<c016df2e>] do_ioctl+0x8e/0xa0
 [<c02d5e08>] do_page_fault+0x188/0x613
 [<c016e0f5>] vfs_ioctl+0x65/0x1f0
 [<c016e2c5>] sys_ioctl+0x45/0x70
 [<c0103185>] syscall_call+0x7/0xb

and that's all. So iflugd has not any influence here.
-- 
mattia
:wq!
