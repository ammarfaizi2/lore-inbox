Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266688AbUAWUCj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 15:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266694AbUAWUCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 15:02:39 -0500
Received: from mail4.edisontel.com ([62.94.0.37]:65488 "EHLO
	mail4.edisontel.com") by vger.kernel.org with ESMTP id S266688AbUAWUCh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 15:02:37 -0500
From: Eduard Roccatello <lilo@roccatello.it>
Organization: SPINE
To: Willy Tarreau <willy@w.ods.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] net/ipv4/tcp.c little cleanup
Date: Fri, 23 Jan 2004 21:03:05 +0100
User-Agent: KMail/1.5.4
References: <200401222253.37426.lilo@roccatello.it> <20040122234833.GL545@alpha.home.local>
In-Reply-To: <20040122234833.GL545@alpha.home.local>
Cc: linux-kernel@vger.kernel.org
X-IRC: #hardware@azzurra.org #rolug@freenode
X-Jabber: eduardroccatello@jabber.linux.it
X-GPG-Keyserver: keyserver.linux.it
X-GPG-FingerPrint: F7B3 3844 038C D582 2C04 4488 8D46 368B 474D 6DB0
X-GPG-KeyID: 474D6DB0
X-Website: http://www.pcimprover.it
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401232103.05618.lilo@roccatello.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 January 2004 00:48, Willy Tarreau wrote:
> Hi !
>
> On Thu, Jan 22, 2004 at 10:53:37PM +0100, Eduard Roccatello wrote:
> > Hello,
> > i've done a little cleanup to net/ipv4/tcp.c
> >
> > I hope it is ok :-)
>
> I haven't looked at sysctl_max_syn_backlog type, but if it's unsigned,
> there's a risk of infinite loop for values above 2^31 on 32 bits
> machines, or 2^63 on 64 bits machine.
sysctl_max_syn_backlog is an int and max_qlen_log is a u8 (uint8_t).
i think there is no problem with them.
sysctl_max_syn_backlog max value is 1024 so max_qlen_log is just 9.

is it ok for you?

> > --- net/ipv4/tcp.c.orig	2004-01-22 22:49:38.000000000 +0100
> > +++ net/ipv4/tcp.c	2004-01-22 22:42:38.000000000 +0100
> > @@ -549,9 +549,9 @@ int tcp_listen_start(struct sock *sk)
> >  	 	return -ENOMEM;
> >
> > 	memset(lopt, 0, sizeof(struct tcp_listen_opt));
> > -	for (lopt->max_qlen_log = 6; ; lopt->max_qlen_log++)
> > -		if ((1 << lopt->max_qlen_log) >= sysctl_max_syn_backlog)
> > -			break;
> > +	lopt->max_qlen_log = 6;
> > +	while (sysctl_max_syn_backlog > (1 << lopt->max_qlen_log))
> > +		lopt->max_qlen_log++;
> >  	get_random_bytes(&lopt->hash_rnd, 4);
> >
> >  	write_lock_bh(&tp->syn_wait_lock);

