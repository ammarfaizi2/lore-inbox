Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTKKFUW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 00:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbTKKFUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 00:20:22 -0500
Received: from smtp800.mail.ukl.yahoo.com ([217.12.12.142]:50311 "HELO
	smtp800.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263343AbTKKFUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 00:20:18 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH?] psmouse-base.c
Date: Tue, 11 Nov 2003 00:20:07 -0500
User-Agent: KMail/1.5.4
Cc: arief_m_utama@telkomsel.co.id, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
References: <3FAEF7BC.8060503@telkomsel.co.id> <200311100143.58955.dtor_core@ameritech.net> <20031109225643.2a0383ef.akpm@osdl.org>
In-Reply-To: <20031109225643.2a0383ef.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311110020.07251.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 November 2003 01:56 am, Andrew Morton wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> >
> > serio_reconnect() is only in your tree (-mm), it has not been pushed
> > to Linus yet... Unfortunately using rescan can cause input devices be
> > shifted if some program has them open while suspending.
>
> Ah, I see.  So would you say that reconnect is the correct thing to use
> here?
>
> That would mean that the appropriate patch against -mm is
>
> --- 25/drivers/input/mouse/psmouse-base.c~serio-pm-fix	2003-11-09
> 20:12:27.000000000 -0800 +++
> 25-akpm/drivers/input/mouse/psmouse-base.c	2003-11-09
> 20:12:27.000000000 -0800 @@ -533,9 +533,10 @@ static int
> psmouse_pm_callback(struct pm
>  {
>  	struct psmouse *psmouse = dev->data;
>
> -	psmouse->state = PSMOUSE_IGNORE;
> -	serio_reconnect(psmouse->serio);
> -
> +	if (request == PM_RESUME) {
> +		psmouse->state = PSMOUSE_IGNORE;
> +		serio_reconnect(psmouse->serio);
> +	}
>  	return 0;
>  }
>

Yes, I believe this will work. And for vanilla 2.6 the patch below should 
do the trick. As you can see vanilla 2.6 has custom reconnect logic in PM 
handler but it does not work very well for devices connected to Synaptics
pass-through port - it will unregister it and register again potentially 
creating a new input device like serio does. The "main" mouse device will 
retain its device though.

===================================================================
ChangeSet@1.1423, 2003-11-11 00:06:11-05:00, dtor_core@ameritech.net
  Re-initialize mouse hardware on resume only.


 psmouse-base.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)


diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Tue Nov 11 00:07:50 2003
+++ b/drivers/input/mouse/psmouse-base.c	Tue Nov 11 00:07:50 2003
@@ -528,17 +528,19 @@
 	struct psmouse *psmouse = dev->data;
 	struct serio_dev *ser_dev = psmouse->serio->dev;
 
-	synaptics_disconnect(psmouse);
+	if (request == PM_RESUME) {
+		synaptics_disconnect(psmouse);
 
-	/* We need to reopen the serio port to reinitialize the i8042 controller */
-	serio_close(psmouse->serio);
-	serio_open(psmouse->serio, ser_dev);
+		/* We need to reopen the serio port to reinitialize the i8042 controller */
+		serio_close(psmouse->serio);
+		serio_open(psmouse->serio, ser_dev);
 
-	/* Probe and re-initialize the mouse */
-	psmouse_probe(psmouse);
-	psmouse_initialize(psmouse);
-	synaptics_pt_init(psmouse);
-	psmouse_activate(psmouse);
+		/* Probe and re-initialize the mouse */
+		psmouse_probe(psmouse);
+		psmouse_initialize(psmouse);
+		synaptics_pt_init(psmouse);
+		psmouse_activate(psmouse);
+	}
 
 	return 0;
 }

===================================================================

Unfortunately I do not suspend my laptop so I did not run it, just
made sure it compiles. Arief? could you give this patch a try?


Dmitry
