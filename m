Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263040AbSJGORr>; Mon, 7 Oct 2002 10:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263051AbSJGORr>; Mon, 7 Oct 2002 10:17:47 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:34945 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263040AbSJGORp>;
	Mon, 7 Oct 2002 10:17:45 -0400
Date: Mon, 7 Oct 2002 16:23:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: jbradford@dial.pipex.com
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.X breaks PS/2 mouse
Message-ID: <20021007162318.A758@ucw.cz>
References: <20021007144250.A626@ucw.cz> <200210071417.g97EHDjG006197@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210071417.g97EHDjG006197@darkstar.example.net>; from jbradford@dial.pipex.com on Mon, Oct 07, 2002 at 03:17:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 03:17:13PM +0100, jbradford@dial.pipex.com wrote:

> I didn't, but I've compiled a new kernel with it in.  Unfortunately, it doesn't seem to do anything useful :-(.
> 
> cat /dev/input/eventX | hexdump
> 
> returns nothing, not even for keyboard events, which makes me think I've gone wrong somewhere :-/

Have you tried all of them (0, 1, 2 ...)? Btw, you can compile evbug in
also.

> > If it was different, then definitely!
> 
> Sorry, I was wrong, I think I pressed a mouse button whilst connecting it and mis-read the info.  The init is exactly the same.
> 
> However, the data sent from each one seems to be very different, (I've re-formatted this a bit to save space, but it's from the dmesg output):
> 
> mouse
> 
>  Left button - 09 00 00 08 00 00
> Right button - 0a 00 00 08 00 00
> 
> trackball
> 
>  Left button - 01 00 00 00 00 00
> Right button - 02 00 00 00 00 00

Hmm, interesting ... let's see what that means ...

Indeed the 0x08 byte indicates the beginning of a packet. The driver
synchronizes on that, and when it's missing, it ignores the packets.
Thus, it ignores all the packets from the trackball.

This patch should fix that:

===================================================================

diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Mon Oct  7 16:22:53 2002
+++ b/drivers/input/mouse/psmouse.c	Mon Oct  7 16:22:53 2002
@@ -201,7 +201,7 @@
 	psmouse->packet[psmouse->pktcnt++] = data;
 
 	if (psmouse->pktcnt == 3 + (psmouse->type >= PSMOUSE_GENPS)) {
-		if ((psmouse->packet[0] & 0x08) == 0x08) psmouse_process_packet(psmouse);
+		psmouse_process_packet(psmouse);
 		psmouse->pktcnt = 0;
 		return;
 	}

===================================================================

-- 
Vojtech Pavlik
SuSE Labs
