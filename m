Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWAYM2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWAYM2i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 07:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWAYM2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 07:28:38 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:32204 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751142AbWAYM2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 07:28:37 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Date: Wed, 25 Jan 2006 13:29:55 +0100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200601240929.37676.rjw@sisk.pl> <200601250035.39383.rjw@sisk.pl> <20060125121848.GA1900@elf.ucw.cz>
In-Reply-To: <20060125121848.GA1900@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601251329.55366.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 25 January 2006 13:18, Pavel Machek wrote:
> > > > +	case SNAPSHOT_ATOMIC_RESTORE:
> > > > +		if (data->mode != O_WRONLY || !data->frozen ||
> > > > +		    !snapshot_image_loaded(&data->handle)) {
> > > > +			error = -EPERM;
> > > > +			break;
> > > > +		}
> > > > +		down(&pm_sem);
> > > > +		pm_prepare_console();
> > > > +		error = device_suspend(PMSG_FREEZE);
> > > > +		if (!error) {
> > > > +			mb();
> > > > +			error = swsusp_resume();
> > > > +			device_resume();
> > > > +		}
> > > 
> > > whee, what does the mystery barrier do?  It'd be nice to comment this
> > > (please always comment open-coded barriers).
> > 
> > Pavel should know. ;-)
> 
> Pavel does not known. That memory barrier should be part of assembly
> parts, anyway, and AFAIK it is. Should be safe to kill.

OK

> > > > +	case SNAPSHOT_GET_SWAP_PAGE:
> > > > +		if (!access_ok(VERIFY_WRITE, (unsigned long __user *)arg, _IOC_SIZE(cmd))) {
> > > > +			error = -EINVAL;
> > > > +			break;
> > > > +		}
> > > 
> > > Why do we need an access_ok() here?
> > 
> > Because we use __put_user() down the road?
> > 
> > The problem is if the address is wrong we should not try to call
> > alloc_swap_page() at all.  If we did, we wouldn't be able to return the result
> > and we would leak a swap page.
> 
> I think you need to watch for failing put_user and free the page at
> that point. Anything else is racy as __put_user() may fail.

The page will be freed anyway when the device is closed (I was wrong
saying it would be "leaked"), so I think I'll just use put_user().

Greetings,
Rafael
