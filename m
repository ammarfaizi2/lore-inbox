Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269613AbTGJS6i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 14:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269618AbTGJS6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 14:58:38 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:42474 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269613AbTGJS4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 14:56:55 -0400
Message-ID: <3F0DB9A5.23723BE1@us.ibm.com>
Date: Thu, 10 Jul 2003 12:08:21 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: James Morris <jmorris@intercode.com.au>
CC: LKML <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Randy Dunlap <rddunlap@osdl.org>
Subject: Re: [PATCH - RFC] [1/2] 2.6 must-fix list - kernel error reporting
References: <Mutt.LNX.4.44.0307101419080.15602-100000@excalibur.intercode.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> 
> On Tue, 8 Jul 2003, Jim Keniston wrote:
> 
> +       kerror_nl = netlink_kernel_create(NETLINK_KERROR, kerror_netlink_rcv);
> +       if (kerror_nl == NULL)
> +               panic("kerror_init: cannot initialize kerror_nl\n");
> 
> You can simply use NULL instead of passing the dummy kerror_netlink_rcv
> function.

That begs the question: do we trust that nobody but the kernel will send
packets to a NETLINK_KERROR socket?  Ordinary users can't, but any root
application can.  Without kerror_netlink_rcv(), such packets don't get
dequeued.

> 
> +struct kern_log_entry {
> +       __u16   log_kmagic;     /* always LOGREC_KMAGIC */
> +       __u16   log_kversion;   /* which version of this struct? */
> +       char    log_facility[FACILITY_MAXLEN];  /* e.g., driver name */
> 
> These fields should generally be specified in ascending order to help with
> alignment.

We include log_kmagic and log_kversion so the receiving app (e.g. the evlog
daemon) can figure out which version of the kernel header it's getting.  Note
that we're up to #3 (going on #4, with the changes you and others have
suggested).  As long as we have to include log_kmagic and log_kversion, they
need to be first.

That said, I get the impression that people would be more comfortable if
log_facility[] were moved to the end.  Other than that, can anybody point
out a specific area where there's likely to be an alignment problem?  The
various members' offsets are the same on i386, ppc32, and ppc64.  This should
also be true for s390 and s390x.  I'd think it'd really matter only when kernel
and user on the same system are different architectures.  ppc64K/ppc32U,
at least, works.

> 
> It may also be worth looking at how the ULOG code batches messages to
> improve peformance.

Thanks for the pointer.  Looks nice.  If performance turns out to be an issue
(e.g., if for some reason people want to cc all printk messages through this
interface), I'll keep that in mind.

> 
> - James
> --
> James Morris
> <jmorris@intercode.com.au>

Jim K.
