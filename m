Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVCTWpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVCTWpv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 17:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVCTWpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 17:45:51 -0500
Received: from mail.dif.dk ([193.138.115.101]:18913 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261322AbVCTWnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 17:43:42 -0500
Date: Sun, 20 Mar 2005 23:45:19 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Antonino Daplas <adaplas@pol.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net, Alex Kern <alex.kern@gmx.de>,
       "Ben. Herrenschmidt" <benh@kernel.crashing.org>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
       Helge Deller <deller@gmx.de>, Philipp Rumpf <prumpf@tux.org>,
       James Simmons <jsimmons@users.sf.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       "Eddie C. Dost" <ecd@skynet.be>, Nicolas Pitre <nico@cam.org>,
       linux-arm-kernel@lists.arm.linux.org.uk, Andrew Morton <akpm@osdl.org>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: [new patch] Re: [PATCH] remove redundant NULL checks before kfree()
 in drivers/video/w100fb.c and add if()+comment back in drivers/video/console/bitblit.c
In-Reply-To: <Pine.LNX.4.62.0503202325360.2508@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.62.0503202332140.2508@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503192339190.5507@dragon.hyggekrogen.localhost>
 <200503210453.47487.adaplas@hotpop.com> <Pine.LNX.4.62.0503202255060.2508@dragon.hyggekrogen.localhost>
 <200503210617.53272.adaplas@hotpop.com> <Pine.LNX.4.62.0503202325360.2508@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Mar 2005, Jesper Juhl wrote:

> 
> On Mon, 21 Mar 2005, Antonino A. Daplas wrote:
> > On Monday 21 March 2005 06:02, Jesper Juhl wrote:
> > > On Mon, 21 Mar 2005, Antonino A. Daplas wrote:
> > > > On Sunday 20 March 2005 06:59, Jesper Juhl wrote:
> > > > > Checking a pointer for NULL before calling kfree() on it is redundant,
> > > > > kfree() deals with NULL pointers just fine.
> > > > > This patch removes such checks from files in drivers/video/
> > > > >
> > > > [snip]
> > > >
> > > > > --- linux-2.6.11-mm4-orig/drivers/video/console/bitblit.c	2005-03-16
> > > > > 15:45:26.000000000 +0100 +++
> > > > > linux-2.6.11-mm4/drivers/video/console/bitblit.c	2005-03-19
> > > > > 22:27:39.000000000 +0100 @@ -199,8 +199,7 @@ static void
> > > > > bit_putcs(struct vc_data *vc
> > > > >  		count -= cnt;
> > > > >  	}
> > > > >
> > > > > -	if (buf)
> > > > > -		kfree(buf);
> > > > > +	kfree(buf);
> > > > >  }
> > > >
> > > > This is performance critical, so I would like the check to remain. A
> > > > comment may be added in this section.
> > >
> > > Ok, I believe Andrew already merged the patch into -mm, if you really want
> > > that check back then I'll send him a patch to put it back and add a
> > > comment once he puts out the next -mm.
> > > But, at the risk of exposing my ignorance, I have to ask if it wouldn't
> > > actually perform better /without/ the if(buf) bit?  The reason I say that
> > > is that the generated code shrinks quite a bit when it's removed, and also
> > > kfree() itself does the same NULL check as the very first thing, so it
> > > comes down to the bennefit of shorter generated code, one less branch,
> > > against the overhead of a function call - and how often will 'buf' be
> > > NULL? if buff is != NULL the majority of the time, then it should be a
> > > gain to remove the if().
> > 
> > You said it, buf is almost always NULL, except when the driver is in
> > monochrome mode.  So a kfree is rarely done.
> > 
> I see, then my change in this exact spot woul probably be a loss in the 
> general case. Thank you for explaining.
> 
> > Anyway, if the patch is already in the tree, let's leave it at that.  I would
> > surmise that the performance loss is negligible.
> > 
> Well, I just spotted two cases I missed in drivers/video/ , so when I send 
> that patch I might as well include a hunk that puts this one check back 
> including a comment as to why it should stay.
> 
One case turned out not to be one when I took a closer look, so I actually 
only missed one. Here's a patch to fix that last one and also put the 
check in bitblit.c back.
(Andrew: this should apply on top of what you already merged)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-mm4/drivers/video/console/bitblit.c~	2005-03-20 23:40:58.000000000 +0100
+++ linux-2.6.11-mm4/drivers/video/console/bitblit.c	2005-03-20 23:40:58.000000000 +0100
@@ -199,7 +199,11 @@ static void bit_putcs(struct vc_data *vc
 		count -= cnt;
 	}
 
-	kfree(buf);
+	/* buf is always NULL except when in monochrome mode, so in this case
+	   it's a gain to check buf against NULL even though kfree() handles
+	   NULL pointers just fine */
+	if (buf)	
+		kfree(buf);
 }
 
 static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
--- linux-2.6.11-mm4-orig/drivers/video/w100fb.c	2005-03-16 15:45:26.000000000 +0100
+++ linux-2.6.11-mm4/drivers/video/w100fb.c	2005-03-20 23:33:58.000000000 +0100
@@ -537,10 +537,8 @@ static void w100fb_clear_buffer(void)
 {
 	int i;
 	for (i = 0; i < W100_BUF_NUM; i++) {
-		if (gSaveImagePtr[i] != NULL) {
-			kfree(gSaveImagePtr[i]);
-			gSaveImagePtr[i] = NULL;
-		}
+		kfree(gSaveImagePtr[i]);
+		gSaveImagePtr[i] = NULL;
 	}
 }
 
