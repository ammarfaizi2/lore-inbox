Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVBAI75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVBAI75 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 03:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVBAI5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 03:57:41 -0500
Received: from smtp06.web.de ([217.72.192.224]:46010 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S261879AbVBAIxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 03:53:06 -0500
Message-ID: <41FF43CD.7080901@web.de>
Date: Tue, 01 Feb 2005 09:54:37 +0100
From: Victor Hahn <victorhahn@web.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Really annoying bug in the mouse driver
References: <41E91795.9060609@web.de> <200501280206.06747.dtor_core@ameritech.net>
In-Reply-To: <200501280206.06747.dtor_core@ameritech.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

thank you for the patch! Unfortunately, I wasn't able to apply it 
correctly, neither to kernel 2.6.10 nor to kernel 2.6.4. Here's the 
error message I got:

root@vic:/mnt/hdb3/Installationsdateien/SOURCES/linux-2.6.10# patch -p1 
< /home/victor/patch-mouse.diff
patching file drivers/input/mouse/psmouse-base.c
Hunk #1 FAILED at 154.
Hunk #2 succeeded at 220 (offset 37 lines).
1 out of 2 hunks FAILED -- saving rejects to file 
drivers/input/mouse/psmouse-base.c.rej
patching file drivers/input/mouse/psmouse.h
Hunk #1 succeeded at 11 (offset -2 lines).
Hunk #2 succeeded at 50 with fuzz 1 (offset 4 lines).

And here's the contents of drivers/input/mouse/psmouse-base.c.rej (same 
in both kernel versions):

***************
*** 154,162 ****
                                flags & SERIO_TIMEOUT ? " timeout" : "",
                                flags & SERIO_PARITY ? " bad parity" : "");
                ps2_cmd_aborted(&psmouse->ps2dev);
                goto out;
        }

        if (unlikely(psmouse->ps2dev.flags & PS2_FLAG_ACK))
                if  (ps2_handle_ack(&psmouse->ps2dev, data))
                        goto out;
--- 154,172 ----
                                flags & SERIO_TIMEOUT ? " timeout" : "",
                                flags & SERIO_PARITY ? " bad parity" : "");
                ps2_cmd_aborted(&psmouse->ps2dev);
+               if (psmouse->resend || serio_write(serio, 
PSMOUSE_CMD_RESEND)) {
+                       psmouse->resend = 0;
+                       psmouse->state = PSMOUSE_IGNORE;
+                       serio_reconnect(serio);
+               } else {
+                       psmouse->pktcnt = 0;
+                       psmouse->resend = 1;
+               }
                goto out;
        }

+       psmouse->resend = 0;
+
        if (unlikely(psmouse->ps2dev.flags & PS2_FLAG_ACK))
                if  (ps2_handle_ack(&psmouse->ps2dev, data))
                        goto out;

I compiled the kernel (2.6.10) like this anyway but this made it even 
worse: The problem still did occur, but it didn't go away any more, 
neither by waiting nor by moving the mouse nor by switching to a 
console. I still get the same error message as before, but this is now 
additionally printed to tty1.

It would be great if you could help me with this.

Regards,
Victor



Dmitry Torokhov wrote:

>On Saturday 15 January 2005 08:16, Victor Hahn wrote:
>  
>
>>Jan 15 13:33:36 vic kernel: psmouse.c: bad data from KBC - bad parity
>>Jan 15 13:33:38 vic kernel: psmouse.c: Wheel Mouse at 
>>isa0060/serio1/input0 lost
>> synchronization, throwing 3 bytes away.
>>
>>Sometimes, only one of these messages appears; the number of bytes in 
>>the second message varies, but mostly it is 3.
>>
>>    
>>
>
>Hi,
>
>Could you please try the patch below?
>
>Thanks!
>
>  
>

