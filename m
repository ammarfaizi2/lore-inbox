Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWAYMS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWAYMS5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 07:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWAYMS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 07:18:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35200 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751136AbWAYMS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 07:18:57 -0500
Date: Wed, 25 Jan 2006 13:18:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Message-ID: <20060125121848.GA1900@elf.ucw.cz>
References: <200601240929.37676.rjw@sisk.pl> <20060124131312.0545262d.akpm@osdl.org> <200601250035.39383.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601250035.39383.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +	case SNAPSHOT_ATOMIC_RESTORE:
> > > +		if (data->mode != O_WRONLY || !data->frozen ||
> > > +		    !snapshot_image_loaded(&data->handle)) {
> > > +			error = -EPERM;
> > > +			break;
> > > +		}
> > > +		down(&pm_sem);
> > > +		pm_prepare_console();
> > > +		error = device_suspend(PMSG_FREEZE);
> > > +		if (!error) {
> > > +			mb();
> > > +			error = swsusp_resume();
> > > +			device_resume();
> > > +		}
> > 
> > whee, what does the mystery barrier do?  It'd be nice to comment this
> > (please always comment open-coded barriers).
> 
> Pavel should know. ;-)

Pavel does not known. That memory barrier should be part of assembly
parts, anyway, and AFAIK it is. Should be safe to kill.

> > > +	case SNAPSHOT_GET_SWAP_PAGE:
> > > +		if (!access_ok(VERIFY_WRITE, (unsigned long __user *)arg, _IOC_SIZE(cmd))) {
> > > +			error = -EINVAL;
> > > +			break;
> > > +		}
> > 
> > Why do we need an access_ok() here?
> 
> Because we use __put_user() down the road?
> 
> The problem is if the address is wrong we should not try to call
> alloc_swap_page() at all.  If we did, we wouldn't be able to return the result
> and we would leak a swap page.

I think you need to watch for failing put_user and free the page at
that point. Anything else is racy as __put_user() may fail.

							Pavel
-- 
Thanks, Sharp!
