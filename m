Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVAGPlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVAGPlF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVAGPlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:41:04 -0500
Received: from miranda.se.axis.com ([193.13.178.2]:38540 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S261462AbVAGPjC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:39:02 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH][4/4] let's kill verify_area - convert kernel/printk.c to access_ok()
Date: Fri, 7 Jan 2005 16:38:30 +0100
Message-ID: <50BF37ECE4954A4BA18C08D0C2CF88CB010400CD@exmail1.se.axis.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][4/4] let's kill verify_area - convert kernel/printk.c to access_ok()
Thread-Index: AcT0t+m4Ch8NtmuLT82t6/dgbdw55AAFcrDA
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: "Jesper Juhl" <juhl-lkml@dif.dk>, "Vincent Hanquez" <tab@snarc.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 07 Jan 2005 15:38:31.0165 (UTC) FILETIME=[F0AEE2D0:01C4F4CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Vincent Hanquez
> Sent: Friday, January 07, 2005 13:52
> To: Jesper Juhl
> Cc: linux-kernel; Andrew Morton
> Subject: Re: [PATCH][4/4] let's kill verify_area - convert 
> kernel/printk.c to access_ok()
> 
> On Fri, Jan 07, 2005 at 02:18:55AM +0100, Jesper Juhl wrote:
> > @@ -300,8 +300,8 @@ int do_syslog(int type, char __user * bu
> >  		error = 0;
> >  		if (!len)
> >  			goto out;
> > -		error = verify_area(VERIFY_WRITE,buf,len);
> > -		if (error)
> > +		error = access_ok(VERIFY_WRITE,buf,len);
> > +		if (!error)
> 
> I would rather put the ! on access_ok
> "if (!error)" is read as "if no error"

Actually, this should be:

	error = access_ok(VERIFY_WRITE, buf, len) ? 0 : -EFAULT;
	if (error)
		goto out;

Alternatively:

	if (!access_ok(VERIFY_WRITE, buf, len)) {
		error = -EFAULT;
		goto out;
	}

Otherwise the returned value from do_syslog() is incorrect 
in case access_ok() fails (i.e., 0 instead of -EFAULT)...

//Peter
