Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267696AbSLFUzo>; Fri, 6 Dec 2002 15:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267702AbSLFUzo>; Fri, 6 Dec 2002 15:55:44 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:62476 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S267696AbSLFUzl>; Fri, 6 Dec 2002 15:55:41 -0500
Subject: Re: [STATUS] fbdev api.
From: Antonino Daplas <adaplas@pol.net>
To: Tobias Rittweiler <inkognito.anonym@uni.de>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
In-Reply-To: <6723376646.20021206204207@uni.de>
References: <6723376646.20021206204207@uni.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1039218931.989.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Dec 2002 04:55:34 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-07 at 00:42, Tobias Rittweiler wrote:
> Hello James,
> 
> Monday, December 2, 2002, 10:07:33 PM, you wrote:
> 
> JS> Hi!
> 
> JS> I have a new patch avaiable. It is against 2.5.50. The patch is at
> JS> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> Besides the hunks posted recently, I encountered three problems/bugs:
> 
> a) Although your patch fixes the FB oddness for me, it makes booting
>    without using framebuffer fail, IOW the kernel hangs:
> 
>    Video mode to be used for restore is f00
>    BIOS-provided physical RAM map:
>     BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
> 
Do you have framebuffer console enabled but with no framebuffer device
enabled at boot time?  This will always fail with James' current patch.

The diff I submitted in one of my replies in this thread (fbcon.diff)
might fix that (not sure).

> b) After returning from blanking mode (via APM) to normal mode, no
>    character is drawn. Let's assume I'm using VIM when that happens:
>    After putting any character to return from blank mode, the screen stays
>    blanked apart from the cursor that _is_ shown. Now I'm able to move
>    the cursor, and when the cursor encounters a character, this char
>    is drawn (and keeps drawn). Though when I press Ctrl-L or when I go one line
>    above to the current top-line (i.e. by forcing a redrawn), the
>    whole screen is drawn properly.
> 
Can you try this?

diff -Naur linux-2.5.50-js/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux-2.5.50-js/drivers/video/console/fbcon.c	2002-12-06 23:33:56.000000000 +0000
+++ linux/drivers/video/console/fbcon.c	2002-12-06 23:33:18.000000000 +0000
@@ -1986,6 +1986,8 @@
 						 vc->vc_cols);
 			vc->vc_video_erase_char = oldc;
 		}
+		else
+			update_screen(vc->vc_num);
 		return 0;
 	} else {
 		/* Tell console.c that it has to restore the screen itself */

> c) instruction:          | produces:
>    ======================|==================
>    1. typing abc def     | $ abc def
>                          |          ^ (<- cursor)
>    2. going three chars  | $ abc def
>       ro the left        |       ^
>    3. pressing backspace | $ abcddef
>                          |      ^
>    4. pressing enter     | -bash: abcdef: command not found
>                          |

I get this also. Seems to occur only with colored terms.  When I do 

set TERM=vt100

the problem disappears, so I thought this was an isolated case with my
setup :-). Similar glitches happen also in emacs with syntax
highlighting turned on.

Tony



