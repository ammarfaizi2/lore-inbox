Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVCVSzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVCVSzi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVCVSzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:55:38 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:23767 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261501AbVCVSzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 13:55:25 -0500
Date: Tue, 22 Mar 2005 22:22:01 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ram <linuxram@us.ibm.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Message-ID: <20050322222201.0fa25d34@zanzibar.2ka.mipt.ru>
In-Reply-To: <1111515979.5860.57.camel@localhost>
References: <1111050243.306.107.camel@frecb000711.frec.bull.fr>
	<200503170856.57893.jbarnes@engr.sgi.com>
	<20050318003857.4600af78@zanzibar.2ka.mipt.ru>
	<200503171405.55095.jbarnes@engr.sgi.com>
	<1111409303.8329.16.camel@frecb000711.frec.bull.fr>
	<1111438349.5860.27.camel@localhost>
	<1111475252.8465.23.camel@frecb000711.frec.bull.fr>
	<1111515979.5860.57.camel@localhost>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 22 Mar 2005 21:54:43 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 10:26:19 -0800
Ram <linuxram@us.ibm.com> wrote:

> On Mon, 2005-03-21 at 23:07, Guillaume Thouvenin wrote:
> > On Mon, 2005-03-21 at 12:52 -0800, Ram wrote:
> > >      If a bunch of applications are listening for fork events, 
> > >      your patch allows any application to turn off the 
> > >      fork event notification?  Is this the right behavior?
> > 
> > Yes it is. The main management is done by application so, if several
> > applications are listening for fork events you need to choose which one
> > will turn off the fork connector. 
> > 
> > I want to keep this turn on/off mechanism simple but if it's needed I
> > can manage the variable "cn_fork_enable" as a counter. Thus the callback
> > could be something like:
> > 
> > static void cn_fork_callback(void *data)
> > {
> >   int start; 
> >   struct cn_msg *msg = (struct cn_msg *)data;
> > 
> >   if (cn_already_initialized && (msg->len == sizeof(cn_fork_enable))) {
> >     memcpy(&start, msg->data, sizeof(cn_fork_enable));
> >     if (start)
> >       cn_fork_enable++;
> >     else
> >       cn_fork_enable > 0 ? cn_fork_enable-- : 0;
> >   }
> > }
> 
> I think a better way is:
> 
>    Providing a different connector channel called the administrator 
>    channel which can be used only by a super-user, and gives you
>    the ability to switch on or off any connector channel including the
>    fork-connector channel.

Only super-user can bind netlink socket to multicast group.

>    For lack of better term I am using the word 'channel' to mean
>    something that carries events of particular type through the
>    connector-infrastructure.

I still do not see why it is needed.
Super-user can run ip command and turn network interface off
not waiting while apache or named exits or unbind.

In theory I can create some kind of userspace registration mechanism,
when userspace application reports it's pid to the connector, 
and then it sends data to the specified pids, but does not 
allow controlling from userspace.
But I really do not think it is a good idea to permit
non-priviledged userspace processes to know about deep
kernel internals through connector's messages.

> RP
> 
> 
> > 
> > 
> > What do you think about this implementation? 
> > 
> > Guillaume
> > 


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
