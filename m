Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbUD3JE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUD3JE3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 05:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUD3JE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 05:04:29 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:33450 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262963AbUD3JE1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 05:04:27 -0400
From: Duncan Sands <baldrick@free.fr>
To: Oliver Neukum <oliver@neukum.org>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [PATCH 1/9] USB usbfs: take a reference to the usb device
Date: Fri, 30 Apr 2004 11:04:24 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141229.26677.baldrick@free.fr> <20040426221407.GB22719@kroah.com> <200404271058.21778.oliver@neukum.org>
In-Reply-To: <200404271058.21778.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404301104.24555.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 April 2004 10:58, Oliver Neukum wrote:
> Am Dienstag, 27. April 2004 00:14 schrieb Greg KH:
> > On Mon, Apr 26, 2004 at 04:05:17PM +0200, Duncan Sands wrote:
> > > diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> > > --- a/drivers/usb/core/devio.c	Mon Apr 26 13:48:28 2004
> > > +++ b/drivers/usb/core/devio.c	Mon Apr 26 13:48:28 2004
> > > @@ -350,8 +350,8 @@
> > >  	 * all pending I/O requests; 2.6 does that.
> > >  	 */
> > >
> > > -	if (ifnum < 8*sizeof(ps->ifclaimed))
> > > -		clear_bit(ifnum, &ps->ifclaimed);
> > > +	BUG_ON(ifnum >= 8*sizeof(ps->ifclaimed));
> >
> > I've changed that to a WARN_ON().  Yeah, writing over memory is bad, but
> > oopsing is worse.  Let's be a bit nicer than that.
>
> You aren't nice that way. An oops has localised consequences. Scribbling
> over memory can cause anything.

Hi Greg, if won't accept a BUG_ON, how about the following?

--- usb-2.6/drivers/usb/core/devio.c.orig	2004-04-30 11:36:17.000000000 +0200
+++ usb-2.6/drivers/usb/core/devio.c	2004-04-30 12:01:37.000000000 +0200
@@ -350,8 +350,11 @@
 	 * all pending I/O requests; 2.6 does that.
 	 */
 
-	WARN_ON(ifnum >= 8*sizeof(ps->ifclaimed));
-	clear_bit(ifnum, &ps->ifclaimed);
+	if (likely(ifnum < 8*sizeof(ps->ifclaimed)))
+		clear_bit(ifnum, &ps->ifclaimed);
+	else
+		warn("interface number %u out of range", ifnum);
+
 	usb_set_intfdata (intf, NULL);
 
 	/* force async requests to complete */
