Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWCRUAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWCRUAK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWCRUAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:00:10 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:6876 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750857AbWCRUAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:00:07 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: -mm: PM=y, VT=n doesn't compile
Date: Sat, 18 Mar 2006 20:58:57 +0100
User-Agent: KMail/1.9.1
Cc: bunk@stusta.de, pavel@suse.cz, linux-kernel@vger.kernel.org
References: <20060317171814.GO3914@stusta.de> <200603181704.44873.rjw@sisk.pl> <20060318114825.75dba55a.akpm@osdl.org>
In-Reply-To: <20060318114825.75dba55a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603182058.58389.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 20:48, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > --- linux-2.6.16-rc6-mm2.orig/drivers/base/power/suspend.c
> >  +++ linux-2.6.16-rc6-mm2/drivers/base/power/suspend.c
> >  @@ -8,6 +8,9 @@
> >    *
> >    */
> >   
> >  +#include <linux/vt_kern.h>
> >  +#include <linux/kbd_kern.h>
> >  +#include <linux/console.h>
> >   #include <linux/device.h>
> >   #include <linux/kallsyms.h>
> >   #include <linux/pm.h>
> >  @@ -65,6 +68,17 @@ int suspend_device(struct device * dev, 
> >   	return error;
> >   }
> >   
> >  +#ifdef CONFIG_VT
> >  +static inline int is_suspend_console_safe(void)
> >  +{
> >  +	/* It is unsafe to suspend devices while X has control of the
> >  +	 * hardware. Make sure we are running on a kernel-controlled console.
> >  +	 */
> >  +	return vc_cons[fg_console].d->vc_mode == KD_TEXT;
> >  +}
> 
> Please implement this inside the vt subsystem, not the pm subsystem.  That way
> 
> a) It gets to be called "console_is_in_text_mode()", or
>    "vt_not_running_X()" or something, which is something someone else might
>    want to know.  
> 
> b) People who work on vt code don't need to keep an eye on a hunk of pm
>    code at the same time.
> 
> c) You won't need all those includes.

I'm working on this now.  [For some obscure reason I received your reply to
Adrian only a couple of minutes ago.]

Still I'd like to separate it from the console-related changes in
kernel/power/user.c that are needed for the userland suspend, so I'd like
to split the dropped patch in two.

I've already sent the kernel/power/user.c changes in a separate patch,
and I'll send the drivers/base/power/suspend.c changes when I test them
(in a while).
