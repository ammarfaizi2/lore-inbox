Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVBXGlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVBXGlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 01:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVBXGlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 01:41:21 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:45269 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261835AbVBXGlG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 01:41:06 -0500
Subject: Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Erich Focht <efocht@hpce.nec.com>
In-Reply-To: <20050223144144.35d8985f@zanzibar.2ka.mipt.ru>
References: <1108649153.8379.137.camel@frecb000711.frec.bull.fr>
	 <1109148752.1738.105.camel@frecb000711.frec.bull.fr>
	 <20050223010747.0a572422.akpm@osdl.org>
	 <20050223140818.4261c4d0@zanzibar.2ka.mipt.ru>
	 <20050223025806.5a39f8fb.akpm@osdl.org>
	 <20050223144144.35d8985f@zanzibar.2ka.mipt.ru>
Date: Thu, 24 Feb 2005 07:41:05 +0100
Message-Id: <1109227265.16029.154.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/02/2005 07:49:59,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/02/2005 07:50:02,
	Serialize complete at 24/02/2005 07:50:02
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-23 at 14:41 +0300, Evgeniy Polyakov wrote:
> > Please assume that <whatever secret application the connector stuff was
> > originally written for> will always be listening.
> >
> > > > What happened to the idea of sending an on/off message down the netlink
> > > > socket?
> > ...
> > Arrange for the userspace daemon to send a message to the fork_connector
> > subsystem turning it on or off.  So we can bypass all this code in the
> > common case where <secret application> is listening, but your daemon is
> > not.
> 
> Ok, now I see(I'm not a fork connector author, so I did not receive them).
> That will require to add real fork connector with callback routing.
> Guillaume?

Yes the connector's callback is a good solution. I will add a fork
enable/disable callback in drivers/connector/connector.c that will
switch a global variable when called from user space. It will be
something like:

void cn_fork_callback(void)
{
	if (cn_already_initialized) 
		cn_fork_enable = cn_fork_enable ? 0 : 1 ;
} 

With cn_fork_enable set to 0 by default. In the do_fork() I will replace
the statement "if (cn_already_initialized)" by "if (cn_fork_enable)"

> > Without a lock you can have two messages with the same sequence number. 
> > Even if the daemon which you're planning on implementing can handle that,
> > we shouldn't allow it.
> 
> Yes, they can have the same number, but does it cost atomic/lock overhead?
> Anyway, simple spin_lock() should be enough in do_fork() context.
> Guillaume?

I will protect the incrementation by a spin_lock(&fork_cn_lock).

Guillaume

