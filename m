Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318290AbSHEDLv>; Sun, 4 Aug 2002 23:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318291AbSHEDLv>; Sun, 4 Aug 2002 23:11:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10430 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318290AbSHEDLv>;
	Sun, 4 Aug 2002 23:11:51 -0400
Date: Sun, 04 Aug 2002 20:02:46 -0700 (PDT)
Message-Id: <20020804.200246.26945647.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: khc@pm.waw.pl, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] 2.4.19 warnings cleanup
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1028470583.14196.29.camel@irongate.swansea.linux.org.uk>
References: <m3znw3k8qq.fsf@defiant.pm.waw.pl>
	<1028470583.14196.29.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   > --- linux/drivers/net/ppp_generic.c.orig	Sat Aug  3 17:13:58 2002
   > +++ linux/drivers/net/ppp_generic.c	Sat Aug  3 19:11:54 2002
   > @@ -378,7 +378,7 @@
   >  {
   >  	struct ppp_file *pf = file->private_data;
   >  	DECLARE_WAITQUEUE(wait, current);
   > -	ssize_t ret;
   > +	ssize_t ret = 0; /* suppress compiler warning */

   Please don't do this. I'm regularly having to fix drivers where people
   hid bugs this way rather than working out if it was a real problem. If
   it is genuinely a compiler corner case then let the gcc folks know and
   comment it but leave the warning.

A compiler isn't able to work out the control flow which
makes sure ret is indeed initialized on every path to
a use.  Solving such a problem is traveling salesman'ish :-)

	for (;;) {
		...
		if (skb)
			break;
		...
		set 'ret' to something
		more break statements
	}

	if (skb == 0)
		goto out; /* where 'ret' is used' */

	set 'ret' to something

See? :-)
