Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161759AbWKHX4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161759AbWKHX4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 18:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161762AbWKHX4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 18:56:33 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:46821 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1161758AbWKHX4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 18:56:31 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 8 Nov 2006 15:56:28 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take23 0/5] kevent: Generic event handling mechanism.
In-Reply-To: <45526339.3040506@cosmosbay.com>
Message-ID: <Pine.LNX.4.64.0611081526350.23154@alien.or.mcafeemobile.com>
References: <1154985aa0591036@2ka.mipt.ru> <20061107141718.f7414b31.akpm@osdl.org>
 <20061108082147.GA2447@2ka.mipt.ru> <200611081551.14671.dada1@cosmosbay.com>
 <20061108140307.da7d815f.akpm@osdl.org> <Pine.LNX.4.64.0611081442420.23154@alien.or.mcafeemobile.com>
 <45526339.3040506@cosmosbay.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1795850513-710282051-1163029622=:23154"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1795850513-710282051-1163029622=:23154
Content-Type: TEXT/PLAIN; CHARSET=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 9 Nov 2006, Eric Dumazet wrote:

> Davide Libenzi a =E9crit :
> >=20
> > I don't care about both ways, but sys_poll() does the same thing epoll =
does
> > right now, so I would not change epoll behaviour.
> >=20
>=20
> Sure poll() cannot return a partial count, since its return value is :
>=20
> On success, a positive number is returned, where the number returned is
>        the  number  of structures which have non-zero revents fields (in =
other
>        words, those descriptors with events or errors reported).
>=20
> poll() is non destructive (it doesnt change any state into kernel). Retur=
ning
> EFAULT in case of an error in the very last bit of user area is mandatory=
=2E
>=20
> On the contrary :
>=20
> epoll_wait() does return a count of transfered events, and update some st=
ate
> in kernel (it consume Edge Trigered events : They can be lost forever if =
not
> reported to user)
>=20
> So epoll_wait() is much more like read(), that also updates file state in
> kernel (current file position)

Lost forever means? If there are more processes watching some fd=20
(external events), they all get their own copy of the events in their own=
=20
private epoll fd. It's not that we "steal" things out of the kernel, is=20
not a 1:1 producer/consumer thing (one producer, 1 queue). It's one=20
producer, broadcast to all listeners (consumers) thing. The only case=20
where it'd matter is in the case of multiple threads sharing the same=20
epoll fd.
In general, I'd be more for having the userspace get his own SEGFAULT=20
instead of letting it go with broken parameters. If I'm coding userspace,=
=20
and I'm doing something wrong, I like the kernel to let me know, instead=20
of trying to fix things for me.
Also, epoll can easily be fixed (add a param to ep_reinject_items() to=20
re-inject items in case of error/EFAULT) to leave events in the ready-list=
=20
and let the EFAULT emerge.=20
Anyone else has opinions about this?




PS: Next time it'd be great if you Cc: me when posting epoll patches, so=20
    you avoid Andrew the job of doing it.



- Davide
--1795850513-710282051-1163029622=:23154--
