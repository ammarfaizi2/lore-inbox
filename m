Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTHWHZT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 03:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTHWHZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 03:25:19 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:37280 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263376AbTHWHZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 03:25:12 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6] 2/3 Serio: possible race in handle_events
Date: Sat, 23 Aug 2003 02:25:10 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
References: <200308230131.45474.dtor_core@ameritech.net> <200308230206.25142.dtor_core@ameritech.net> <20030823001922.487f83f5.akpm@osdl.org>
In-Reply-To: <20030823001922.487f83f5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308230225.10308.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 August 2003 02:19 am, Andrew Morton wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > On Saturday 23 August 2003 02:00 am, Andrew Morton wrote:
> > > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > > +static int is_known_serio(struct serio *serio)
> > > >  +{
> > > >  +	struct serio *s;
> > > >  +
> > > >  +	list_for_each_entry(s, &serio_list, node)
> > > >  +		if (s == serio)
> > > >  +			return 1;
> > > >  +	return 0;
> > > >  +}
> > >
> > > Could this just be
> > >
> > > 	return !list_empty(&serio->node);
> > >
> > > ?
> >
> > The serio could be free()d, I dont think we want to call list_empty with
> > a dangling pointer. Or am I missing something?
>
> Well if we're playing around with a freed pointer then something is
> seriously wrong.  Like, someone could have allocated a new one and got the
> same address.
>
> If event->serio can point at freed memory and there's any doubt over it
> then we should be nulling out event->serio to indicate that.

Right now we can't as events are queued in an event list and are processed by 
other thread; serio does not know that it's queued and even existence of the
event list is not known outside of serio.c module.

Do you think we should introduce allocate_serio/free_serio pair for dynamically 
allocated serios; free_serio would scan event_list and invalidate events that 
refer to freed serio?
