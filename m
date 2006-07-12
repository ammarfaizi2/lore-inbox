Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWGLPeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWGLPeQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 11:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWGLPeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 11:34:16 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:27861 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S1751417AbWGLPeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 11:34:14 -0400
Date: Wed, 12 Jul 2006 11:33:38 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: resource_size_t and printk()
Message-ID: <20060712153338.GD7421@athena.road.mcmartin.ca>
References: <44AAD59E.7010206@drzeus.cx> <20060704214508.GA23607@kroah.com> <44AB3DF7.8080107@drzeus.cx> <20060711231537.GC18973@kroah.com> <44B4B041.9050808@drzeus.cx> <20060712081535.296ea579.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712081535.296ea579.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 08:15:35AM -0700, Randy.Dunlap wrote:
> I know it's more wordy, but we usually use
> (unsigned long long), not just (long long).
> 
> Wish we had an abbreviation for that.

We have a specific qualifier for ptrdiff_t... Why not add one (untested!)
for resource_size_t, and get rid of all these bloody annoying casts?

I'm more than slightly irritated to have to go and add ugly
(unsigned long long) casts to squelch compiler whining on parisc.

This patch will probably cause even more compiler warnings thought because
gcc will try to be too smart with the use of formats...

Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index bed7229..2d71ff6 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -343,7 +343,8 @@ int vsnprintf(char *buf, size_t size, co
 		/* get the conversion qualifier */
 		qualifier = -1;
 		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' ||
-		    *fmt =='Z' || *fmt == 'z' || *fmt == 't') {
+		    *fmt == 'Z' || *fmt == 'z' || *fmt == 't' ||
+		    *fmt == 'r') {
 			qualifier = *fmt;
 			++fmt;
 			if (qualifier == 'l' && *fmt == 'l') {
@@ -477,6 +478,8 @@ int vsnprintf(char *buf, size_t size, co
 			num = (unsigned short) va_arg(args, int);
 			if (flags & SIGN)
 				num = (signed short) num;
+		} else if (qualifier == 'r') {
+			num = va_arg(args, resource_size_t);
 		} else {
 			num = va_arg(args, unsigned int);
 			if (flags & SIGN)
