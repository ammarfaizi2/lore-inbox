Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265743AbUGZT3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265743AbUGZT3A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 15:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUGZT3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 15:29:00 -0400
Received: from c3-1d224.neo.rr.com ([24.93.233.224]:11671 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S265872AbUGZSAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 14:00:33 -0400
Date: Mon, 26 Jul 2004 13:53:13 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Dominik Brodowski <linux@dominikbrodowski.de>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, akpm@osdl.org,
       rml@ximian.com, greg@kroah.com
Subject: Re: [RFC][PATCH] driver model and sysfs support for PCMCIA (1/3)
Message-ID: <20040726135313.GB3219@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Dominik Brodowski <linux@dominikbrodowski.de>,
	linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, akpm@osdl.org,
	rml@ximian.com, greg@kroah.com
References: <20040628200224.GE5175@neo.rr.com> <20040629190948.GA8659@dominikbrodowski.de> <20040705224704.GA4090@neo.rr.com> <20040719080237.GB9494@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040719080237.GB9494@dominikbrodowski.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2004 at 10:02:37AM +0200, Dominik Brodowski wrote:
> Hi Adam,
> 
> On Mon, Jul 05, 2004 at 10:47:04PM +0000, Adam Belay wrote:
> > > - I like many ideas in your patches -- large parts of them, though, are
> > >   "double work" as similar things have already been submitted (by me)
> > >   to Russell on the linux-pcmcia mailing list. What's missing in my current
> > >   patches [proof-of-concepts do exist and had been announced both on lkml
> > >   and on said linux-pcmcia list, though] is the exporting of product and
> > >   manufactor ID and "vers_1" strings, because that needs better resource
> > >   handling.
> > > - the resource_ready handling is "racy", at least. Resources can disappear
> > >   again.
> >
> > Could you provide an example of how resources will disappear again?
>
> /etc/pcmcia/config.opts may include
>
> include memory 0xc0000-0xfffff
> exclude memory 0xc0000-0xfffff
>
> even though it wouldn't make sense.

Hmm, ok.

> It is, but partly because used ioports and iomem are not 100% accounted in
> /proc/ioports and /proc/iomem. I'm eagerly awaiting the creation of a PNP-
> and/or ACPI-based resource core "backend", like you proposed at Kernel
> Summit last year, IIRC, which possibly allows the PCMCIA core on x86{,_64}
> to "trust" the resources not in the resource database to be available for
> PCMCIA's use.

I appreciate the interest.  It's currently under development.

>
> > It was to add minimal support for a much needed feature while introducing
> > as few potential bugs as possible to a stable kernel series.  I see 2.7 as
> > the time for rewrites.  With that in mind, I consider your patches to be a
> > great solution, but I'm worried about changing internal ds functionality
> > during 2.6.
>
> However, adding pcmcia devices at the place you suggest causes resource
> headaches and makes merging my patches in 2.7. much more difficult. So,
> could we work to a compromise patch where PCMCIA sysfs device structs are
> only registered at "bind" time [as long as Russell agrees, that is...]?
>
> Also, what do we need the "hotplug" export for? I'd like to avoid backwards
> compatibility trouble in future, and as users _need_ to run cardmgr hotplug
> seems to be without usage now.
>
> 	Dominik

I agree that the current resources_ready flag could create potential problems.
I've created another patch against the previous three that removes its usage,
and relies entirely on DS_BIND_REQUEST.  Devices are now removed but never
added during hardware events.  As for "hotplug", I was just trying to create
a complete driver model implementation.  I don't expect it to be used much now,
but it is an official driver model feature.

Thanks,
Adam


--- a/drivers/pcmcia/ds.c	2004-07-26 11:08:11.000000000 +0000
+++ b/drivers/pcmcia/ds.c	2004-07-26 13:47:40.000000000 +0000
@@ -108,9 +108,6 @@
     struct pcmcia_bus_socket *socket;
 } user_info_t;
 
-static LIST_HEAD(pcmcia_sockets);
-static DECLARE_MUTEX(pcmcia_socket_mutex);
-
 /* Socket state information */
 struct pcmcia_bus_socket {
 	atomic_t		refcount;
@@ -124,7 +121,6 @@
 	struct pcmcia_socket	*parent;
 	struct list_head	devices;
 	struct semaphore	device_mutex;
-	struct list_head	socket_list;
 };
 
 #define DS_SOCKET_PRESENT		0x01
@@ -141,8 +137,6 @@
 
 extern struct proc_dir_entry *proc_pccard;
 
-static int resources_ready;
-
 /*====================================================================*/
 
 /* code which was in cs.c before */
@@ -521,9 +515,6 @@
 	if (!(s->state & DS_SOCKET_PRESENT))
 		return CS_NO_CARD;
 
-	if (!resources_ready && !(s->parent->features & SS_CAP_STATIC_MAP))
-		return CS_NO_CARD;
-
 	down(&s->device_mutex);
 	if (!list_empty(&s->devices)) {
 		ret = -EBUSY;
@@ -639,18 +630,6 @@
 
 #endif /* CONFIG_HOTPLUG */
 
-static void pcmcia_rescan_sockets(void)
-{
-	struct pcmcia_bus_socket *s;
-
-	down(&pcmcia_socket_mutex);
-
-	list_for_each_entry(s, &pcmcia_sockets, socket_list)
-		pcmcia_bus_insert_card(s);
-
-	up(&pcmcia_socket_mutex);
-}
-
 /*======================================================================
 
     These manage a ring buffer of events pending for one user process
@@ -733,7 +712,6 @@
 	
     case CS_EVENT_CARD_INSERTION:
 	s->state |= DS_SOCKET_PRESENT;
-	pcmcia_bus_insert_card(s);
 	handle_event(s, event);
 	break;
 
@@ -1182,12 +1160,6 @@
     switch (cmd) {
     case DS_ADJUST_RESOURCE_INFO:
 	ret = pcmcia_adjust_resource_info(s->handle, &buf.adjust);
-	/*
-	 * We can't read CIS information until user space has given us the
-	 * memory resource locations.  Therefore, we wait until now.
-	 */
-	if ((ret == CS_SUCCESS) && (buf.adjust.Resource == RES_MEMORY_RANGE))
-		resources_ready = 1;
 	break;
     case DS_GET_CARD_SERVICES_INFO:
 	ret = pcmcia_get_card_services_info(&buf.servinfo);
@@ -1258,7 +1230,7 @@
 	break;
     case DS_BIND_REQUEST:
 	if (!capable(CAP_SYS_ADMIN)) return -EPERM;
-	pcmcia_rescan_sockets();
+	pcmcia_bus_insert_card(s);
 	err = bind_request(s, &buf.bind_info);
 	break;
     case DS_GET_DEVICE_INFO:
@@ -1330,10 +1302,6 @@
 	memset(s, 0, sizeof(struct pcmcia_bus_socket));
 	atomic_set(&s->refcount, 1);
 
-	down(&pcmcia_socket_mutex);
-	list_add_tail(&s->socket_list, &pcmcia_sockets);
-	up(&pcmcia_socket_mutex);
-
 	/*
 	 * Ugly. But we want to wait for the socket threads to have started up.
 	 * We really should let the drivers themselves drive some of this..
@@ -1395,10 +1363,7 @@
 
 	pcmcia_deregister_client(socket->pcmcia->handle);

-	down(&pcmcia_socket_mutex);
 	pcmcia_bus_remove_card(socket->pcmcia);
-	list_del(&socket->pcmcia->socket_list);
-	up(&pcmcia_socket_mutex);
 
 	socket->pcmcia->state |= DS_SOCKET_DEAD;
 	pcmcia_put_bus_socket(socket->pcmcia);
