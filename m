Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbRE3XKi>; Wed, 30 May 2001 19:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262922AbRE3XKT>; Wed, 30 May 2001 19:10:19 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:61189 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S262887AbRE3XKP>;
	Wed, 30 May 2001 19:10:15 -0400
Date: Thu, 31 May 2001 01:08:55 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU, engler@csl.stanford.edu
Subject: [PATCH] Re: [CHECKER] 2.4.5-ac4 non-init functions calling init functions
Message-ID: <20010531010855.A1765@vana.vc.cvut.cz>
In-Reply-To: <200105302008.NAA07710@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200105302008.NAA07710@csl.Stanford.EDU>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, May 30, 2001 at 01:08:40PM -0700, Dawson Engler wrote:
> /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/video/matrox/matroxfb_base.c
> :1785:initMatrox2: ERROR:INIT: non-init fn 'initMatrox2' calling init 
> fn 'fb_find_mode'

Thanks for pointing this out. Code checks for init/noninit phase, but I somehow
forgot to set hotplug variable:

#ifndef MODULE
	/* mode database is marked __init!!! */
	if (!hotplug) {
		fb_find_mode(&vesafb_defined, &ACCESS_FBINFO(fbcon), videomode[0]?videomode:NULL,
			NULL, 0, &defaultmode, vesafb_defined.bits_per_pixel);
	}
#endif /* !MODULE */

Alan, please apply following patch, it fixes this. It is for 2.4.5-ac5, 
but should apply to any 2.4.x.
						Thanks,
							Petr Vandrovec
							vandrove@vc.cvut.cz

diff -urdN linux/drivers/video/matrox/matroxfb_base.c linux/drivers/video/matrox/matroxfb_base.c
--- linux/drivers/video/matrox/matroxfb_base.c	Wed May 30 20:27:28 2001
+++ linux/drivers/video/matrox/matroxfb_base.c	Wed May 30 20:31:42 2001
@@ -2495,6 +2495,7 @@
 		initialized = 1;
 		matrox_init();
 	}
+	hotplug = 1;
 	/* never return failure, user can hotplug matrox later... */
 	return 0;
 }
