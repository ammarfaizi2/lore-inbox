Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbUJaAGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbUJaAGo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 20:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbUJaAGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 20:06:44 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:22413 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261434AbUJaAGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 20:06:38 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: No PS2 with ACPI [was Re: 2.6.10-rc1-mm2]
Date: Sat, 30 Oct 2004 19:06:32 -0500
User-Agent: KMail/1.6.2
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20041029014930.21ed5b9a.akpm@osdl.org> <1099149503l.23066l.0l@werewolf.able.es> <20041030143132.5f20d048.akpm@osdl.org>
In-Reply-To: <20041030143132.5f20d048.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410301906.35335.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 October 2004 04:31 pm, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > 
> > On 2004.10.29, Andrew Morton wrote:
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm2/
> > > 
> > > 
> > 
> > Here we go again...
> 
> Perhaps Dmitry and Vojtech can help.
> 
> > With normal boot, I have no kbd nor mouse (both PS2).
> > 2.6.9-mm1 detects them correctly:
> > 
> > mice: PS/2 mouse device common for all mice
> > input: AT Translated Set 2 keyboard on isa0060/serio0
> > input: PS2++ Logitech <NULL> on isa0060/serio1
> > 
> > 2.6.10-rc1-mm2 misses the two 'input' lines, I just get the 'mice:' one.
> > 
> > Booting with i8042.noacpi makes them work again.
> >

Is that AMD64? Could you try this patch:

http://dtor.bkbits.net:8080/input/cset%404174f35cnyVl7byWwdxca2m6bK_odg

If it does not help could you send me contents of your dsdt table
(cat /proc/acpi/dsdt > dsdt.hex)
 
> > BTW, what is that <NULL> ? 
> > I don't have the full logs, but 2.6.9-rc2-mm2 told 'Mouse',and
> > the next I have is -rc3-mm3 that says '<NULL>'.
> > 

Please try the patch below, I think it will cure the "NULL" problem - 
I messed up when rearranged protocols init routines.

Thanks!

-- 
Dmitry


===================================================================


ChangeSet@1.1959, 2004-10-30 19:02:16-05:00, dtor_core@ameritech.net
  Input: psmouse - set mouse name to "Mouse" when using PS2++ and
         don't have any other information about the mouse.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 logips2pp.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
--- a/drivers/input/mouse/logips2pp.c	2004-10-30 19:03:37 -05:00
+++ b/drivers/input/mouse/logips2pp.c	2004-10-30 19:03:37 -05:00
@@ -245,7 +245,8 @@
  * Set up input device's properties based on the detected mouse model.
  */
 
-static void ps2pp_set_model_properties(struct psmouse *psmouse, struct ps2pp_info *model_info)
+static void ps2pp_set_model_properties(struct psmouse *psmouse, struct ps2pp_info *model_info,
+				       int using_ps2pp)
 {
 	if (model_info->features & PS2PP_SIDE_BTN)
 		set_bit(BTN_SIDE, psmouse->dev.keybit);
@@ -279,6 +280,16 @@
 		case PS2PP_KIND_TP3:
 			psmouse->name = "TouchPad 3";
 			break;
+
+		default:
+			/*
+			 * Set name to "Mouse" only when using PS2++,
+			 * otherwise let other protocols define suitable
+			 * name
+			 */
+			if (using_ps2pp)
+				psmouse->name = "Mouse";
+			break;
 	}
 }
 
@@ -371,7 +382,7 @@
 			clear_bit(BTN_RIGHT, psmouse->dev.keybit);
 
 		if (model_info)
-			ps2pp_set_model_properties(psmouse, model_info);
+			ps2pp_set_model_properties(psmouse, model_info, use_ps2pp);
 	}
 
 	return use_ps2pp ? 0 : -1;
