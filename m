Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVBUIFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVBUIFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 03:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVBUIFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 03:05:40 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:47253 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261857AbVBUIFc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 03:05:32 -0500
Subject: Re: [Elsa-devel] Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork
	connector
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Erich Focht <efocht@hpce.nec.com>
In-Reply-To: <1108655454.14089.105.camel@uganda>
References: <1108652114.21392.144.camel@frecb000711.frec.bull.fr>
	 <1108655454.14089.105.camel@uganda>
Date: Mon, 21 Feb 2005 09:05:30 +0100
Message-Id: <1108973130.8418.76.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/02/2005 09:14:22,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/02/2005 09:14:24,
	Serialize complete at 21/02/2005 09:14:24
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-17 at 18:50 +0300, Evgeniy Polyakov wrote:
> >  
> > +#if defined(CONFIG_CONNECTOR) && defined(CONFIG_FORK_CONNECTOR)
> 
> I suspect CONFIG_FORK_CONNECTOR is enough.

The problem here is that if connector is compiled as a module and
fork_connector as builtin there will be undefined reference to symbol
like 'cn_already_initialized' or 'cn_netlink_send'. That's why the
fork_connector() must be enable if CONFIG_CONNECTOR and
CONFIG_FORK_CONNECTOR are selected as builtin and not as a module. I
agree that it's not very elegant...

> > +			cn_netlink_send(msg, 1);
> 
> "1" here means that this message will be delivered to any group
> which has it's first bit set(1, 3, and so on) in given socket queue.
> I suspect it is not what you want.
> By design connector's users should send messages to the group it was
> registered with
> (which is obtained from idx field of the struct cb_id), in your case it
> is CN_IDX_FORK,
> and connector userspace consumers should bind to the same group (idx
> value).
> It is of course not requirement, but a fair path(hmm, I can add more
> strict checks into connector).
> By setting 0 as second parameter for cn_netlink_send() you will force
> connector's core
> to select proper group for you.

Yes but cn_netlink_send() is looking for a callback with the same idx.
As I don't use any callback, found == 0 and I have an error "Failed to
find multicast netlink group for callback[0xfeed.0xbeef]". So the good
call is: cn_netlink_send(msg, CN_IDX_FORK);

Thanks for your help,
Guillaume

