Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTKKHEf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 02:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbTKKHEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 02:04:35 -0500
Received: from cache2.telkomsel.co.id ([202.155.14.253]:32776 "EHLO
	cache2.telkomsel.co.id") by vger.kernel.org with ESMTP
	id S263375AbTKKHEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 02:04:31 -0500
Message-ID: <3FB08798.7050805@telkomsel.co.id>
Date: Tue, 11 Nov 2003 13:54:16 +0700
From: arief_mulya <arief_m_utama@telkomsel.co.id>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.4-4 StumbleUpon/1.8
X-Accept-Language: en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Andrew Morton <akpm@osdl.org>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH?] psmouse-base.c
References: <3FAEF7BC.8060503@telkomsel.co.id> <200311100143.58955.dtor_core@ameritech.net> <20031109225643.2a0383ef.akpm@osdl.org> <200311110020.07251.dtor_core@ameritech.net>
In-Reply-To: <200311110020.07251.dtor_core@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>On Monday 10 November 2003 01:56 am, Andrew Morton wrote:
>  
>
>>Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>>    
>>
>
>  
>
>>>serio_reconnect() is only in your tree (-mm), it has not been pushed
>>>to Linus yet... Unfortunately using rescan can cause input devices be
>>>shifted if some program has them open while suspending.
>>>      
>>>
>>Ah, I see.  So would you say that reconnect is the correct thing to use
>>here?
>>
>>That would mean that the appropriate patch against -mm is
>>
>>--- 25/drivers/input/mouse/psmouse-base.c~serio-pm-fix	2003-11-09
>>20:12:27.000000000 -0800 +++
>>25-akpm/drivers/input/mouse/psmouse-base.c	2003-11-09
>>20:12:27.000000000 -0800 @@ -533,9 +533,10 @@ static int
>>psmouse_pm_callback(struct pm
>> {
>> 	struct psmouse *psmouse = dev->data;
>>
>>-	psmouse->state = PSMOUSE_IGNORE;
>>-	serio_reconnect(psmouse->serio);
>>-
>>+	if (request == PM_RESUME) {
>>+		psmouse->state = PSMOUSE_IGNORE;
>>+		serio_reconnect(psmouse->serio);
>>+	}
>> 	return 0;
>> }
>>
>>    
>>
>
>Yes, I believe this will work. And for vanilla 2.6 the patch below should 
>do the trick. As you can see vanilla 2.6 has custom reconnect logic in PM 
>handler but it does not work very well for devices connected to Synaptics
>pass-through port - it will unregister it and register again potentially 
>creating a new input device like serio does. The "main" mouse device will 
>retain its device though.
>
>===================================================================
>ChangeSet@1.1423, 2003-11-11 00:06:11-05:00, dtor_core@ameritech.net
>  Re-initialize mouse hardware on resume only.
>
>
> psmouse-base.c |   20 +++++++++++---------
> 1 files changed, 11 insertions(+), 9 deletions(-)
>
>
>diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
>--- a/drivers/input/mouse/psmouse-base.c	Tue Nov 11 00:07:50 2003
>+++ b/drivers/input/mouse/psmouse-base.c	Tue Nov 11 00:07:50 2003
>@@ -528,17 +528,19 @@
> 	struct psmouse *psmouse = dev->data;
> 	struct serio_dev *ser_dev = psmouse->serio->dev;
> 
>-	synaptics_disconnect(psmouse);
>+	if (request == PM_RESUME) {
>+		synaptics_disconnect(psmouse);
> 
>-	/* We need to reopen the serio port to reinitialize the i8042 controller */
>-	serio_close(psmouse->serio);
>-	serio_open(psmouse->serio, ser_dev);
>+		/* We need to reopen the serio port to reinitialize the i8042 controller */
>+		serio_close(psmouse->serio);
>+		serio_open(psmouse->serio, ser_dev);
> 
>-	/* Probe and re-initialize the mouse */
>-	psmouse_probe(psmouse);
>-	psmouse_initialize(psmouse);
>-	synaptics_pt_init(psmouse);
>-	psmouse_activate(psmouse);
>+		/* Probe and re-initialize the mouse */
>+		psmouse_probe(psmouse);
>+		psmouse_initialize(psmouse);
>+		synaptics_pt_init(psmouse);
>+		psmouse_activate(psmouse);
>+	}
> 
> 	return 0;
> }
>
>===================================================================
>
>Unfortunately I do not suspend my laptop so I did not run it, just
>made sure it compiles. Arief? could you give this patch a try?
>
>
>  
>
I have tested it before.
My first attempts looked quite just like that.

It didn't work quite nicely.
Especially with gpm, after resume, you cannot do Tap-to-Click behaviour 
with that patch. You can still move it, use left and right button, but 
no tap-to-click. I don't know why. That's why, finally, I use 
serio_rescan().

I haven't tested it with X, though, as I use gpm as a repeater, I 
thought this was unnecessary.

But I have try Andrew's tree. And it works flawlessly with the patch 
(case PM_RESUME: serio_reconnect()). I think I'm going to stick with mm 
tree, and dump my vanilla kernel.

One more think, I also sets "psmouse_resetafter" to 1 at the 
declaration. Without that, I get too many ugly message saying "Synaptics 
lost sync at 1 byte..." or something like that. As it is a module 
parameter, but on menuconfig synaptics does not available as module, so 
I set it directly on the source. I don't know if I can set it on boot 
time, can it?

Best Regards
-- 
arief_mulya
Peace is Beautiful.

