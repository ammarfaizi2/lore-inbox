Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTHWHRO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 03:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbTHWHRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 03:17:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:692 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261629AbTHWHRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 03:17:11 -0400
Date: Sat, 23 Aug 2003 00:19:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH 2.6] 2/3 Serio: possible race in handle_events
Message-Id: <20030823001922.487f83f5.akpm@osdl.org>
In-Reply-To: <200308230206.25142.dtor_core@ameritech.net>
References: <200308230131.45474.dtor_core@ameritech.net>
	<20030823000008.07050a75.akpm@osdl.org>
	<200308230206.25142.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> On Saturday 23 August 2003 02:00 am, Andrew Morton wrote:
> > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > +static int is_known_serio(struct serio *serio)
> > >  +{
> > >  +	struct serio *s;
> > >  +
> > >  +	list_for_each_entry(s, &serio_list, node)
> > >  +		if (s == serio)
> > >  +			return 1;
> > >  +	return 0;
> > >  +}
> >
> > Could this just be
> >
> > 	return !list_empty(&serio->node);
> >
> > ?
> 
> The serio could be free()d, I dont think we want to call list_empty with 
> a dangling pointer. Or am I missing something?
> 

Well if we're playing around with a freed pointer then something is
seriously wrong.  Like, someone could have allocated a new one and got the
same address.

If event->serio can point at freed memory and there's any doubt over it
then we should be nulling out event->serio to indicate that.

