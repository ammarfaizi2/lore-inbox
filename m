Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbTCCKcr>; Mon, 3 Mar 2003 05:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTCCKcr>; Mon, 3 Mar 2003 05:32:47 -0500
Received: from pluvier.ens-lyon.fr ([140.77.167.5]:63400 "EHLO
	mailhost.ens-lyon.fr") by vger.kernel.org with ESMTP
	id <S262780AbTCCKcn>; Mon, 3 Mar 2003 05:32:43 -0500
Date: Sun, 03 Mar 2003 11:07:31 +0100
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Rosatti <marcelo@conectiva.com.br>, Alan Cox <alan@redhat.com>
Cc: Alastair McKinstry <mckinstry@computer.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>, linux-laptop@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4 & 2.5] Armada laptops' apm BIOS flaw
Message-ID: <20030228000731.GA721@bouh.famille.thibault.fr>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
References: <Pine.LNX.4.10.10208042353270.815-100000@unit.famille.thibault.fr> <200208051014.g75AEeg01377@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208051014.g75AEeg01377@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It's been a while since I submitted a patch to correct it, but I
couldn't see it applied, except to alan's kernels, here it is again,
still working on both current 2.4 & 2.5:

--- linux-2.4.20-orig/arch/i386/kernel/apm.c	2002-11-29 13:23:24.000000000 +0100
+++ linux-2.4.20/arch/i386/kernel/apm.c	2002-11-29 13:21:05.000000000 +0100
@@ -1074,6 +1074,19 @@
 	}
 	if ((error == APM_SUCCESS) || (error == APM_NO_ERROR))
 		return 1;
+	if (error == APM_NOT_ENGAGED) {
+		static int tried;
+		int eng_error;
+		if (tried++ == 0) {
+			eng_error = apm_engage_power_management(APM_DEVICE_ALL, 1);
+			if (eng_error) {
+				apm_error("set display", error);
+				apm_error("engage interface", eng_error);
+				return 0;
+			} else
+				return apm_console_blank(blank);
+		}
+	}
 	apm_error("set display", error);
 	return 0;
 }

(just to remember, it was intended to fix Armada's bioses which don't
engage display apm, while they claim general apm to be engaged)

But I also got further troubles, concerning drivers/char/console.c:
I could recover from the blanking done after blankinterval, but not from
vesa_powerdown_screen() after vesa_off_interval : the screen gets
powered, but nothing is displayed, I have to launch X to reset video
board's status.
I had to set vesa_off_interval to 0 or already set vesa_blank_mode to
3 (powerdown).
The problem seems to come from this:

(console.c:2703, timer_do_blank_screen())
	i = sw->con_blank(vc_cons[currcons].d, 1);
	/* which only blanks vga palette in vgacon case */
	...
	if (console_blank_hook && console_blank_hook(1))
		return;
	/* this is not reached, since apm's hook does work */
    	if (vesa_blank_mode)
		sw->con_blank(vc_cons[currcons].d, vesa_blank_mode + 1);
}
which is followed (iff vesa_off_interval != 0) by a timed call to
vesa_powerdown_screen which also does a con_blank(1) unless
vesa_blank_mode is already set to powerdown.

and this:
(console.c:2751, unblank_screen())
	if (console_blank_hook)
		console_blank_hook(0);
	set_palette(currcons);
	if (sw->con_blank(vc_cons[currcons].d, 0))

My interpretation is that when the timed call to con_blank(1) is done, it
saves vga registers of the 'apm blanked' status, so that when unblanking,
the call to con_blank(0) sets back this status, although the apm hook
correctly set back registers...

Rewriten in a more LIFO way:

--- linux-2.4.20-orig/drivers/char/console.c	2002-11-29 13:23:34.000000000 +0100
+++ linux-2.4.20/drivers/char/console.c	2003-02-28 00:38:06.000000000 +0100
@@ -2748,12 +2748,12 @@
 	}
 
 	console_blanked = 0;
-	if (console_blank_hook)
-		console_blank_hook(0);
-	set_palette(currcons);
 	if (sw->con_blank(vc_cons[currcons].d, 0))
 		/* Low-level driver cannot restore -> do it ourselves */
 		update_screen(fg_console);
+	if (console_blank_hook)
+		console_blank_hook(0);
+	set_palette(currcons);
 	set_cursor(fg_console);
 }
 

my trouble was fixed, whatever the parameters I set.
Here is the same for 2.5 kernels:

--- linux-2.5.63/drivers/char/vt.c	2003-02-18 02:29:12.000000000 +0100
+++ linux-2.5.63-work/drivers/char/vt.c	2003-02-28 00:43:43.000000000 +0100
@@ -2769,12 +2769,12 @@
 	}
 
 	console_blanked = 0;
-	if (console_blank_hook)
-		console_blank_hook(0);
-	set_palette(currcons);
 	if (sw->con_blank(vc_cons[currcons].d, 0))
 		/* Low-level driver cannot restore -> do it ourselves */
 		update_screen(fg_console);
+	if (console_blank_hook)
+		console_blank_hook(0);
+	set_palette(currcons);
 	set_cursor(fg_console);
 }
 

I'm not sure if this is the good order, but to my mind, LIFO order
should be preserved.

Regards,

Samuel Thibault
