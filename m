Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWENQkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWENQkV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 12:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWENQkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 12:40:21 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:55749 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751492AbWENQkU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 12:40:20 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] mtd: fix memory leaks in phram_setup
Date: Sun, 14 May 2006 18:37:15 +0200
User-Agent: KMail/1.9.1
Cc: David Woodhouse <dwmw2@infradead.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org,
       Jochen =?iso-8859-1?q?Sch=E4uble?= <psionic@psionic.de>,
       Thomas Gleixner <tglx@linutronix.de>
References: <200605140107.18293.jesper.juhl@gmail.com> <1147604629.12379.4.camel@pmac.infradead.org> <20060514132126.GA20556@wohnheim.fh-wedel.de>
In-Reply-To: <20060514132126.GA20556@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605141837.17318.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörn,

On Sunday, 14. May 2006 15:21, Jörn Engel wrote:
> On Sun, 14 May 2006 12:03:49 +0100, David Woodhouse wrote:
> > On Sun, 2006-05-14 at 08:37 +0200, Jörn Engel wrote:
> > > The only question is: does it make the code better?  The code has
> > > seven printk/return combinations.  Each of them would chew up 2 more
> > > lines without the macro.  So phram_setup would grow from 44 to 58
> > > lines, not nice either.
> > 
> > How about this then...
> 
> Moving the printk into leaf functions?  My plan still is to collect a
> bunch of those and put somewhere in lib/.  So maybe that's a bad idea.

That has been done already. One is kstrdup() from <linux/string.h>
implementation in mm/util.c . So duplication can go.

parse_num32 is implemented as memparse() from 
<linux/kernel.h> already, code is in lib/cmdline.c

It only misses the SI prefix stuff (kiBi and such).

Maybe SI units could be added to memparse() in
lib/cmdline.c and all those reimplementations ripped of drivers/mtd/*/* ?

diff --git a/lib/cmdline.c b/lib/cmdline.c
index 0331ed8..d13c580 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -108,6 +108,8 @@ unsigned long long memparse (char *ptr, 
 	case 'k':
 		ret <<= 10;
 		(*retptr)++;
+		if ((**retptr) == 'i')
+			(*retptr)++;
 	default:
 		break;
 	}

> The macro sucks. 
Agreed stronly! It is also against Documentation/CodingStyle, Chapter 11

No worries, error handling always clutters up our nice code. 

The only accepted way around this in Linux is "goto error_label", 
so we can see the algorithm and read up on error handling at the 
end of a function, after the algorithm.


Regards

Ingo Oeser
