Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTKJG4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 01:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTKJG4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 01:56:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:5293 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262960AbTKJGxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 01:53:18 -0500
Date: Sun, 9 Nov 2003 22:56:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: arief_m_utama@telkomsel.co.id, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH?] psmouse-base.c
Message-Id: <20031109225643.2a0383ef.akpm@osdl.org>
In-Reply-To: <200311100143.58955.dtor_core@ameritech.net>
References: <3FAEF7BC.8060503@telkomsel.co.id>
	<20031109201211.2ce2edce.akpm@osdl.org>
	<200311100143.58955.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> On Sunday 09 November 2003 11:12 pm, Andrew Morton wrote:
> > arief_mulya <arief_m_utama@telkomsel.co.id> wrote:
> > > static int psmouse_pm_callback(struct pm_dev *dev, pm_request_t
> > > request, void *data)
> > >  {
> > >          struct psmouse *psmouse = dev->data;
> > >          struct serio_dev *ser_dev = psmouse->serio->dev;
> > >
> > >
> > >          switch (request) {
> > >          case PM_RESUME:
> > >                  psmouse->state = PSMOUSE_IGNORE;
> > >                  serio_rescan(psmouse->serio);
> > >          default:
> > >                  return 0;
> > >          }
> > >  }
> >
> > What does the driver do without this change?  ie: what problem is this
> > fixing?
> >
> > Why is it calling serio_rescan() rather than serio_reconnect()?
> >
> 
> serio_reconnect() is only in your tree (-mm), it has not been pushed to
> Linus yet... Unfortunately using rescan can cause input devices be shifted
> if some program has them open while suspending.

Ah, I see.  So would you say that reconnect is the correct thing to use
here?

That would mean that the appropriate patch against -mm is

--- 25/drivers/input/mouse/psmouse-base.c~serio-pm-fix	2003-11-09 20:12:27.000000000 -0800
+++ 25-akpm/drivers/input/mouse/psmouse-base.c	2003-11-09 20:12:27.000000000 -0800
@@ -533,9 +533,10 @@ static int psmouse_pm_callback(struct pm
 {
 	struct psmouse *psmouse = dev->data;
 
-	psmouse->state = PSMOUSE_IGNORE;
-	serio_reconnect(psmouse->serio);
-
+	if (request == PM_RESUME) {
+		psmouse->state = PSMOUSE_IGNORE;
+		serio_reconnect(psmouse->serio);
+	}
 	return 0;
 }
 

_


Those serio patches have been in -mm for six weeks btw.  Was there some
problem with them?

