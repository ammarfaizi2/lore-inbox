Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbUK3Hai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUK3Hai (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 02:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbUK3Hae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 02:30:34 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:61099 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261798AbUK3Ha0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 02:30:26 -0500
In-Reply-To: <Pine.LNX.4.61.0411292007080.18143@hibernia.jakma.org>
Subject: Re: [patch 4/10] s390: network driver.
To: Paul Jakma <paul@clubi.ie>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFAF17275D.316533A1-ONC1256F5C.0026AFAD-C1256F5C.002877C1@de.ibm.com>
From: Thomas Spatzier <thomas.spatzier@de.ibm.com>
Date: Tue, 30 Nov 2004 08:22:01 +0100
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.0.2CF2HF259 | March 11, 2004) at
 30/11/2004 08:30:31
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Paul Jakma <paul@clubi.ie> wrote on 29.11.2004 21:27:57:
> We do get notified. We get a netlink interface update with
> unset IFF_RUNNING from the interface flags.
>
> However, it can take time before zebra gets to read it, and further
> time before zebra sends its own interface update to protocol daemons,
> and further time before they might get to read and update their own
> interface state. By which time those daemons may have sent packets
> down those interfaces (which packets may become invalid before link
> becomes back, but which still will be sent and hence which
> potentially could disrupt routing).

Ok, then some logic could be implemented in userland to take
appropriate actions. It must be ensured that zebra handles the
netlink notification fast enough.

>
> Ideally, we should be notified synchronously (EBUFS?) or if thats not
> possible, packet should be dropped (see my below presumption though).

In the manpages for send/sendto/sendmsg it says that there is a -ENOBUFS
return value, if a sockets write queue is full. It also says:
"Normally, this does not occur in Linux. Packets are just silently dropped
when a device queue overflows."
So, if packets are 'silently dropped' anyway, the fact that we drop them in
our driver (and increment the error count in the net_device_stats
accordingly)
should not be a problem.

> Surely TCP already was able to take care of retransmits? I'm not
> familiar with Linux internals, but how did TCP cope with the previous
> driver behaviour?

I think that both behaviours are similar for TCP. TCP waits for ACKs for
each packet. If they do not arrive, a retransmit is done. Sooner or later
the connection will be reset, if no responses from the other side arrive.
So the result for both driver behaviours should be the same.

Regards,
Thomas

