Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWJFHbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWJFHbp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 03:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWJFHbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 03:31:45 -0400
Received: from mo30.po.2iij.net ([210.128.50.53]:42529 "EHLO mo30.po.2iij.net")
	by vger.kernel.org with ESMTP id S1750711AbWJFHbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 03:31:44 -0400
Message-Id: <200610060731.k967Vaes094416@mbox33.po.2iij.net>
Date: Fri, 6 Oct 2006 16:31:36 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: "Om Narasimhan" <om.turyx@gmail.com>
Cc: yoichi_yuasa@tripeaks.co.jp, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH] fixed PCMCIA au1000_generic.c
In-Reply-To: <6b4e42d10610052318h53102e73h64766a7cb677be1b@mail.gmail.com>
References: <20061003001115.e898b8cb.akpm@osdl.org>
	<20061004224406.46a9d05c.yoichi_yuasa@tripeaks.co.jp>
	<6b4e42d10610052318h53102e73h64766a7cb677be1b@mail.gmail.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006 23:18:44 -0700
"Om Narasimhan" <om.turyx@gmail.com> wrote:

> On 10/4/06, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > Hi,
> >
> Sorry for the late reply.
> > pcmcia-au1000_generic-fix.patch has a problem.
> > It needs more fix.
> > ops->shutdown(skt), skt is out of definition scope.
> 
> Is it so?
> After applying the patch, the code would look like,
> -----
> 
> 		skt->status = au1x00_pcmcia_skt_state(skt);
> 
> 		ret = pcmcia_register_socket(&skt->socket);
> 		if (ret)
> 			goto out_err;
> <snip>
> 
> out_err:
> 	flush_scheduled_work();
> 	ops->hw_shutdown(skt);
> 	while (i-- > 0) {
> 		struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
> 		del_timer_sync(&skt->poll_timer);
> 		pcmcia_unregister_socket(&skt->socket);
> 		flush_scheduled_work();
> 		ops->hw_shutdown(skt);
> 		i--;
> 	}
> 	kfree(sinfo);
> -----
> The  first call to ops->shutdown(skt) would free the skt (of the
> function scope). The internal skt to the loop is a placeholder to call
> shutdown().
> Or did I miss any point?


	for (i = 0; i < nr; i++) {
		struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i); <-- 1st skt definition
<snip>
		ret = pcmcia_register_socket(&skt->socket);
		if (ret)
			goto out_err;

		WARN_ON(skt->socket.sock != i);

		add_timer(&skt->poll_timer);
	}
<snip>

out_err:
	flush_scheduled_work();
	ops->hw_shutdown(skt); <-- skt undeclared
	while (i-- > 0) {
		struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i); <-- 2nd skt definition
		del_timer_sync(&skt->poll_timer);
		pcmcia_unregister_socket(&skt->socket);
		flush_scheduled_work();
		ops->hw_shutdown(skt);
	}

Yoichi
