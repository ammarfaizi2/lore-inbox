Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVCVTS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVCVTS4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVCVTSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:18:55 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:26759 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261675AbVCVTSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:18:13 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Ram <linuxram@us.ibm.com>
To: johnpol@2ka.mipt.ru
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <20050322222201.0fa25d34@zanzibar.2ka.mipt.ru>
References: <1111050243.306.107.camel@frecb000711.frec.bull.fr>
	 <200503170856.57893.jbarnes@engr.sgi.com>
	 <20050318003857.4600af78@zanzibar.2ka.mipt.ru>
	 <200503171405.55095.jbarnes@engr.sgi.com>
	 <1111409303.8329.16.camel@frecb000711.frec.bull.fr>
	 <1111438349.5860.27.camel@localhost>
	 <1111475252.8465.23.camel@frecb000711.frec.bull.fr>
	 <1111515979.5860.57.camel@localhost>
	 <20050322222201.0fa25d34@zanzibar.2ka.mipt.ru>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1111519086.5860.80.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Mar 2005 11:18:07 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-22 at 11:22, Evgeniy Polyakov wrote:
> On Tue, 22 Mar 2005 10:26:19 -0800
> Ram <linuxram@us.ibm.com> wrote:
> 
> > On Mon, 2005-03-21 at 23:07, Guillaume Thouvenin wrote:
> > > On Mon, 2005-03-21 at 12:52 -0800, Ram wrote:
> > > >      If a bunch of applications are listening for fork events, 
> > > >      your patch allows any application to turn off the 
> > > >      fork event notification?  Is this the right behavior?
> > > 
> > > Yes it is. The main management is done by application so, if several
> > > applications are listening for fork events you need to choose which one
> > > will turn off the fork connector. 
> > > 
> > > I want to keep this turn on/off mechanism simple but if it's needed I
> > > can manage the variable "cn_fork_enable" as a counter. Thus the callback
> > > could be something like:
> > > 
> > > static void cn_fork_callback(void *data)
> > > {
> > >   int start; 
> > >   struct cn_msg *msg = (struct cn_msg *)data;
> > > 
> > >   if (cn_already_initialized && (msg->len == sizeof(cn_fork_enable))) {
> > >     memcpy(&start, msg->data, sizeof(cn_fork_enable));
> > >     if (start)
> > >       cn_fork_enable++;
> > >     else
> > >       cn_fork_enable > 0 ? cn_fork_enable-- : 0;
> > >   }
> > > }
> > 
> > I think a better way is:
> > 
> >    Providing a different connector channel called the administrator 
> >    channel which can be used only by a super-user, and gives you
> >    the ability to switch on or off any connector channel including the
> >    fork-connector channel.
> 
> Only super-user can bind netlink socket to multicast group.

ok. I did not realize that.

> 
> >    For lack of better term I am using the word 'channel' to mean
> >    something that carries events of particular type through the
> >    connector-infrastructure.
> 
> I still do not see why it is needed.
> Super-user can run ip command and turn network interface off
> not waiting while apache or named exits or unbind.
> 
> In theory I can create some kind of userspace registration mechanism,
> when userspace application reports it's pid to the connector, 
> and then it sends data to the specified pids, but does not 
> allow controlling from userspace.
> But I really do not think it is a good idea to permit
> non-priviledged userspace processes to know about deep
> kernel internals through connector's messages.

Yes. non-priviledged userspace processes should not know
any deep kernel internals through connector events.

I think what I am driving at is, an application that is critically
dependent on the fork-notification, suddenly stops receiving such
notification because some other application has switched off the 
service without its notice. 

the reason I am concerned is I am planning to feed this fork-events
to my in-kernel module. Side note: I would really like support for
in-kernel listners through connector infrastructure.

RP

> 
> > RP
> > 
> > 
> > > 
> > > 
> > > What do you think about this implementation? 
> > > 
> > > Guillaume
> > > 
> 
> 
> 	Evgeniy Polyakov
> 
> Only failure makes us experts. -- Theo de Raadt

