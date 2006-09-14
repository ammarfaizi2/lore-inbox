Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWINWb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWINWb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 18:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWINWb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 18:31:26 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:41130 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750715AbWINWbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 18:31:25 -0400
Date: Fri, 15 Sep 2006 00:23:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: Martin Bligh <mbligh@mbligh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, fche@redhat.com
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914222318.GA25004@elte.hu>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <450971CB.6030601@mbligh.org> <20060914174306.GA18890@elte.hu> <4509B5A4.2070508@mbligh.org> <20060914201448.GA7357@elte.hu> <1158267906.5068.49.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158267906.5068.49.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michel Dagenais <michel.dagenais@polymtl.ca> wrote:

> > the question is: what is more maintainance, hundreds of static 
> > tracepoints (with long parameter lists) all around the (core) kernel, or 
> > hundreds of detached dynamic rules that need an update every now and 
> > then? [but of which most would still be usable even if some of them 
> > "broke"] To me the answer is clear: having hundreds of tracepoints 
> > _within_ the source code is higher cost. But please prove me wrong :-)
> 
> Actually I rarely find that any of the 70 000 printk is such a huge 
> nuisance to code readability. They may even help understand what is 
> going on in a code area you are less familiar with.

i disagree. Consider the following example from LTT:

 int sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
         struct kiocb iocb;
         struct sock_iocb siocb;
         int ret;

         trace_socket_sendmsg(sock, sock->sk->sk_family,
                 sock->sk->sk_type,
                 sock->sk->sk_protocol,
                 size);

         init_sync_kiocb(&iocb, NULL);
         iocb.private = &siocb;
         ret = __sock_sendmsg(&iocb, sock, msg, size);
         if (-EIOCBQUEUED == ret)
                 ret = wait_on_sync_kiocb(&iocb);
         return ret;
 }

what do the 5 extra lines introduced by trace_socket_sendmsg() tell us? 
Nothing. They mostly just duplicate the information i already have from 
the function declaration. They obscure the clear view of the function:

 int sock_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
         struct kiocb iocb;
         struct sock_iocb siocb;
         int ret;

         init_sync_kiocb(&iocb, NULL);
         iocb.private = &siocb;
         ret = __sock_sendmsg(&iocb, sock, msg, size);
         if (-EIOCBQUEUED == ret)
                 ret = wait_on_sync_kiocb(&iocb);
         return ret;
 }

the resulting visual and structural redundancy hurts.

	Ingo
