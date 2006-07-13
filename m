Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWGMSSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWGMSSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWGMSSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:18:49 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:59564 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030264AbWGMSSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:18:48 -0400
Date: Thu, 13 Jul 2006 20:18:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Matthew Wilcox <matthew@wil.cx>, wookey@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support DOS line endings
Message-ID: <20060713181825.GA22895@mars.ravnborg.org>
References: <20060707173458.GB1605@parisc-linux.org> <Pine.LNX.4.64.0607080513280.17704@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607080513280.17704@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 05:23:17AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Fri, 7 Jul 2006, Matthew Wilcox wrote:
> 
> > Kconfig doesn't currently handle config files with DOS line endings.
> > While these are, of course, an abomination, etc, etc, it can be handy
> > to not have to convert them first.  It's also a tiny patch and even adds
> > support for lines ending in just \r or even \n\r.
> 
> Did you try the latter? Unless you told fgets() about it I don't see how 
> it should work.
> 
> >  			if (p2)
> >  				*p2 = 0;
> > +			p2 = strchr(p, '\r');
> > +			if (p2)
> > +				*p2 = 0;
> 
> I think something like this would be simpler:
> 
> 	if (p2[-1] == '\r')
> 		p2[-1] = 0;
Negative index'es always make me supsicious.
I've applied followign patch.
The fgets thing I have not looked at.

	Sam

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 2ee48c3..a30b1bb 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -192,9 +192,14 @@ load:
 			if (!p)
 				continue;
 			*p++ = 0;
-			p2 = strchr(p, '\n');
-			if (p2)
-				*p2 = 0;
+			p2 = p;
+		        while (*p2) {
+				if (*p2 == '\r' || *p2 == '\n') {
+					*p2 = 0;
+					break;
+				}
+				p2++;
+			}
 			if (def == S_DEF_USER) {
 				sym = sym_find(line + 7);
 				if (!sym) {
