Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278590AbRJ1RYh>; Sun, 28 Oct 2001 12:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278591AbRJ1RY2>; Sun, 28 Oct 2001 12:24:28 -0500
Received: from cc668399-a.ewndsr1.nj.home.com ([24.180.97.113]:41469 "EHLO
	eriador.mirkwood.net") by vger.kernel.org with ESMTP
	id <S278590AbRJ1RYL>; Sun, 28 Oct 2001 12:24:11 -0500
Date: Sun, 28 Oct 2001 12:25:14 -0500 (EST)
From: PinkFreud <pf-kernel@mirkwood.net>
To: Chris Ahna <christopher.j.ahna@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Avoid a race in complete_change_console()
Message-ID: <Pine.LNX.4.20.0110281202130.15433-100000@eriador.mirkwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris, THANK YOU!  I've been having a problem on my SMP system for months
now, where if I started X, switched to a text console, and then back to X,
the system would lock up.  Your patch actually fixed it!

Alan, could you please make sure this patch makes it into the kernel?


> Currently drivers/char/vt.c:complete_change_console() calls
> do_blank_screen() when switching from text to graphics mode after
> sending acqsig to the controlling process of the new console.
>
> On an SMP system, acqsig can wake the controlling process up and get it
> working before do_blank_screen completes.  At least on my ia64 systems,
> this causes accesses to the VGA range from the kernel and accesses to
> framebuffer from X to overlap with one another causing system lockups.
>
> Appended is a patch which ensures that do_blank_screen() is called
> before delivering acqsig instead of after.  do_blank_screen() is still
> called if signal delivery fails (as far as I could tell, handling this
> case was the reason screen blanking was done after signal delivery in
> the first place).
>
> Can someone familiar with this code comment on the correctness of this
> patch?  The patch is against vanilla 2.4.13.  Thanks,
>
> Chris
>
>
> --- linux-2.4.13-ia64-011024-pristine/drivers/char/vt.c       Mon Sep 17 22:52:35 2001
> +++ linux-2.4.13-ia64-011024-dev/drivers/char/vt.c    Thu Oct 25 20:46:08 2001
> @@ -1184,6 +1184,24 @@
>       switch_screen(new_console);
>
>       /*
> +      * This can't appear below a successful kill_proc().  If it did,
> +      * then the *blank_screen operation could occur while X, having
> +      * received acqsig, is waking up on another processor.  This
> +      * condition can lead to overlapping accesses to the VGA range
> +      * and the framebuffer (causing system lockups).
> +      *
> +      * To account for this we duplicate this code below only if the
> +      * controlling process is gone and we've called reset_vc.
> +      */
> +     if (old_vc_mode != vt_cons[new_console]->vc_mode)
> +     {
> +             if (vt_cons[new_console]->vc_mode == KD_TEXT)
> +                     unblank_screen();
> +             else
> +                     do_blank_screen(1);
> +     }
> +
> +     /*
>        * If this new console is under process control, send it a signal
>        * telling it that it has acquired. Also check if it has died and
>        * clean up (similar to logic employed in change_console())
> @@ -1209,19 +1227,15 @@
>                * to account for and tracking tty count may be undesirable.
>                */
>                       reset_vc(new_console);
> -             }
> -     }
>
> -     /*
> -      * We do this here because the controlling process above may have
> -      * gone, and so there is now a new vc_mode
> -      */
> -     if (old_vc_mode != vt_cons[new_console]->vc_mode)
> -     {
> -             if (vt_cons[new_console]->vc_mode == KD_TEXT)
> -                     unblank_screen();
> -             else
> -                     do_blank_screen(1);
> +                     if (old_vc_mode != vt_cons[new_console]->vc_mode)
> +                     {
> +                             if (vt_cons[new_console]->vc_mode == KD_TEXT)
> +                                     unblank_screen();
> +                             else
> +                                     do_blank_screen(1);
> +                     }
> +             }
>       }
>
>       /*




	Mike Edwards

Brainbench certified Master Linux Administrator
http://www.brainbench.com/transcript.jsp?pid=158188
-----------------------------------
Unsolicited advertisments to this address are not welcome.

