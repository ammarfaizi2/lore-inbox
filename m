Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264156AbRFDJNq>; Mon, 4 Jun 2001 05:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264157AbRFDJNf>; Mon, 4 Jun 2001 05:13:35 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:640 "EHLO twilight.suse.cz")
	by vger.kernel.org with ESMTP id <S264156AbRFDJN3>;
	Mon, 4 Jun 2001 05:13:29 -0400
Date: Fri, 1 Jun 2001 16:31:10 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel@vger.kernel.org, Alan Cox <laughing@shared-source.org>
Subject: Re: USB mouse wheel breakage was Re: Linux 2.4.5-ac5
Message-ID: <20010601163110.A2525@suse.cz>
In-Reply-To: <20010530213039.A25251@lightning.swansea.linux.org.uk> <20010601105717.A2468@debian>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010601105717.A2468@debian>; from leahcim@ntlworld.com on Fri, Jun 01, 2001 at 10:57:17AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 01, 2001 at 10:57:17AM +0100, Michael wrote:

> On Wed, May 30, 2001 at 09:30:39PM +0100, Alan Cox wrote:
> > 2.4.5-ac4
> > o	Update USB hid drivers				(Vojtech Pavlik)
> 
> I think these changes have broken my USB wheel mouse.
> 
> Events seems to be getting lost (/dev/input/mice)
> 
> It only scrolls when either the scroll direction has changed or if other
> mouse events occur (e.g. you need to wiggle mouse from side to side to
> scroll down a long page in mozilla)
> 
> problems seems to be in drivers/usb/hid-core.c hid_input_field line 772
> 
> 	for (n = 0; n < count; n++) {
> 
> 		if (HID_MAIN_ITEM_VARIABLE & field->flags) {
> 
> 			if ((field->flags & HID_MAIN_ITEM_RELATIVE) && !value[n])
> 				continue;
> The next 2 lines are dropping the scroll wheel events (which appear in the
> input code as type:2, code: 8, value -1 or 1 depending on direction)
> 
> 			if (value[n] == field->value[n])
> 				continue;
> 			hid_process_event(hid, field, &field->usage[n], value[n]);
> 			continue;
> 		}

Thanks for the detailed report.
Here is the fix.

Alan, please apply this to -ac5.

-- 
Vojtech Pavlik
SuSE Labs

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hid.fix.diff"

diff -urN linux-2.4.5-ac4/drivers/usb/hid-core.c linux/drivers/usb/hid-core.c
--- linux-2.4.5-ac4/drivers/usb/hid-core.c	Tue May 29 19:48:15 2001
+++ linux/drivers/usb/hid-core.c	Fri Jun  1 16:30:33 2001
@@ -775,7 +775,7 @@
 
 			if ((field->flags & HID_MAIN_ITEM_RELATIVE) && !value[n])
 				continue;
-			if (value[n] == field->value[n])
+			if ((~field->flags & HID_MAIN_ITEM_RELATIVE) && value[n] == field->value[n])
 				continue;
 			hid_process_event(hid, field, &field->usage[n], value[n]);
 			continue;

--Kj7319i9nmIyA2yE--
