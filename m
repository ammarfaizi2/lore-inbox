Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbUKRRw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbUKRRw7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbUKRRut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:50:49 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:24297 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262804AbUKRRs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:48:59 -0500
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
	using SELinux and SOCK_SEQPACKET
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Morris <jmorris@redhat.com>
Cc: Ross Kendall Axe <ross.axe@blueyonder.co.uk>, netdev@oss.sgi.com,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Xine.LNX.4.44.0411172222160.2531-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0411172222160.2531-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100796294.6019.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 18 Nov 2004 16:45:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-11-18 at 03:42, James Morris wrote:
> > Well, my reading of socket(2) suggests that it's _not_ supposed to work.
> 
> sendto() on a non connected socket should fail with ENOTCONN.

Not entirely true at all. A network protocol can implement lazy binding
and
do implicit binding on the sendto. Other protocols might not actually
have
a receiving component so have no bind() functionality at all.

> According to the send(2) man page, we may return EISCONN if the address
> and addr length are not NULL and zero.  I think that the man page is
> incorrect.  Posix says that EISCONN means "A destination address was
> specified and the socket is already connected", not "A destination address
> was specified and the socket is connected mode".  i.e. we should only 
> return EISCONN if the socket is in a connected state.

POSIX 1003.1g draft 6.4 permits a user to pass a "null" address for
various things. Indeed some systems implement send() as sendto() with a
NULL, 0 address component and some user space does likewise. It also has
a lot to say on the other cases although I don't think it ever fully got
past draft state.

You also want to look at TCP/IP illustrated to see some of the
assumptions handed down from on high by BSD and which should not be
broken.

