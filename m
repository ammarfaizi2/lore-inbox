Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTKJHTX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 02:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbTKJHTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 02:19:23 -0500
Received: from cache1.telkomsel.co.id ([202.155.14.251]:38672 "EHLO
	cache1.telkomsel.co.id") by vger.kernel.org with ESMTP
	id S262965AbTKJHTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 02:19:21 -0500
Message-ID: <3FAF395B.8080302@telkomsel.co.id>
Date: Mon, 10 Nov 2003 14:08:11 +0700
From: arief_mulya <arief_m_utama@telkomsel.co.id>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.4-4 StumbleUpon/1.8
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dmitry Torokhov <dtor_core@ameritech.net>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH?] psmouse-base.c
References: <3FAEF7BC.8060503@telkomsel.co.id>	<20031109201211.2ce2edce.akpm@osdl.org>	<200311100143.58955.dtor_core@ameritech.net> <20031109225643.2a0383ef.akpm@osdl.org>
In-Reply-To: <20031109225643.2a0383ef.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>  
>
>>On Sunday 09 November 2003 11:12 pm, Andrew Morton wrote:
>>    
>>
>>>arief_mulya <arief_m_utama@telkomsel.co.id> wrote:
>>>      
>>>
>>>>static int psmouse_pm_callback(struct pm_dev *dev, pm_request_t
>>>>request, void *data)
>>>> {
>>>>         struct psmouse *psmouse = dev->data;
>>>>         struct serio_dev *ser_dev = psmouse->serio->dev;
>>>>
>>>>
>>>>         switch (request) {
>>>>         case PM_RESUME:
>>>>                 psmouse->state = PSMOUSE_IGNORE;
>>>>                 serio_rescan(psmouse->serio);
>>>>         default:
>>>>                 return 0;
>>>>         }
>>>> }
>>>>        
>>>>
>>>What does the driver do without this change?  ie: what problem is this
>>>fixing?
>>>
>>>Why is it calling serio_rescan() rather than serio_reconnect()?
>>>
>>>      
>>>
>>serio_reconnect() is only in your tree (-mm), it has not been pushed to
>>Linus yet... Unfortunately using rescan can cause input devices be shifted
>>if some program has them open while suspending.
>>    
>>
>
>  
>
Well, I don't know about this.
I was just trying to get my synaptics mouse working nicely through 
suspend-resume. And I haven't learn about linux kernel structure before, 
so I just spend all my sunshiny Sunday, researching everywhere with my 
lazy brain.

And finally, those (ugly?) patch come out ;-)

>Ah, I see.  So would you say that reconnect is the correct thing to use
>here?
>
>That would mean that the appropriate patch against -mm is
>
>--- 25/drivers/input/mouse/psmouse-base.c~serio-pm-fix	2003-11-09 20:12:27.000000000 -0800
>+++ 25-akpm/drivers/input/mouse/psmouse-base.c	2003-11-09 20:12:27.000000000 -0800
>@@ -533,9 +533,10 @@ static int psmouse_pm_callback(struct pm
> {
> 	struct psmouse *psmouse = dev->data;
> 
>-	psmouse->state = PSMOUSE_IGNORE;
>-	serio_reconnect(psmouse->serio);
>-
>+	if (request == PM_RESUME) {
>+		psmouse->state = PSMOUSE_IGNORE;
>+		serio_reconnect(psmouse->serio);
>+	}
> 	return 0;
> }
> 
>
>_
>
>  
>
I guess I gotta try your tree now.

>Those serio patches have been in -mm for six weeks btw.  Was there some
>problem with them?
>  
>
I don't know. Has anybody tested it using an IBM T30 with Synaptics inside?

Best Regards.
-- 
arief_mulya

