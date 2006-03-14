Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWCNWBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWCNWBd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWCNWBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:01:32 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:20885
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S964784AbWCNWBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:01:31 -0500
Date: Tue, 14 Mar 2006 14:01:30 -0800
From: Greg KH <gregkh@suse.de>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject_uevent CONFIG_SYSFS=n build fix
Message-ID: <20060314220130.GB12257@suse.de>
References: <4416EB14.50306@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4416EB14.50306@ce.jp.nec.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 11:11:00AM -0500, Jun'ichi Nomura wrote:
> Hello,
> 
> In 2.6.16-rc6 (probably in earlier rc as well),
> following build error occurs with CONFIG_SYSFS=n.
> 
> kernel/built-in.o(.data+0x1d40): undefined reference to `uevent_helper'
> lib/lib.a(kobject_uevent.o)(.text+0x5c1): In function `kobject_uevent':
> /build/rc6/source/lib/kobject_uevent.c:152: undefined reference to `uevent_seqnum'
> lib/lib.a(kobject_uevent.o)(.text+0x5d0):/build/rc6/source/lib/kobject_uevent.c:152: undefined reference to `uevent_seqnum'
> lib/lib.a(kobject_uevent.o)(.text+0x901):/build/rc6/source/lib/kobject_uevent.c:182: undefined reference to `uevent_helper'
> lib/lib.a(kobject_uevent.o)(.text+0x910):/build/rc6/source/lib/kobject_uevent.c:182: undefined reference to `uevent_helper'
> 
> This seems to be caused by mismatch of build condition.
> uevent_seqnum and uevent_helper are conditional to CONFIG_SYSFS.
> While they are referenced if CONFIG_HOTPLUG (and CONFIG_NET) is enabled.
> 
> Attached patch consolidates them to CONFIG_HOTPLUG && CONFIG_NET.
> 
> I tried with (!CONFIG_NET && CONFIG_SYSFS) and
> (CONFIG_NET && !CONFIG_SYSFS).
> Both built ok.
> So I think it doesn't conflict with "[PATCH] kobject_uevent CONFIG_NET=n
> fix" which is in 2.6.16-rc6.
> 
> Thanks,
> -- 
> Jun'ichi Nomura, NEC Solutions (America), Inc.

> CONFIG_SYSFS=n fails to build due to mismatch of conditions
> for uevent_seqnum and uevent_helper.
> 
> kernel/built-in.o(.data+0x1d40): undefined reference to `uevent_helper'
> lib/lib.a(kobject_uevent.o)(.text+0x5c1): In function `kobject_uevent':
> /build/rc6/source/lib/kobject_uevent.c:152: undefined reference to `uevent_seqnum'
> lib/lib.a(kobject_uevent.o)(.text+0x5d0):/build/rc6/source/lib/kobject_uevent.c:152: undefined reference to `uevent_seqnum'
> lib/lib.a(kobject_uevent.o)(.text+0x901):/build/rc6/source/lib/kobject_uevent.c:182: undefined reference to `uevent_helper'
> lib/lib.a(kobject_uevent.o)(.text+0x910):/build/rc6/source/lib/kobject_uevent.c:182: undefined reference to `uevent_helper'
> 
> Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
> 
> 
> --- linux-2.6.16-rc6.orig/lib/kobject_uevent.c	2006-03-14 08:57:23.000000000 -0500
> +++ linux-2.6.16-rc6/lib/kobject_uevent.c	2006-03-14 08:52:57.000000000 -0500
> @@ -26,6 +26,9 @@
>  #define NUM_ENVP	32	/* number of env pointers */
>  
>  #if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
> +u64 uevent_seqnum;
> +char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";

No, the seqnum and helper can be called even if we have not defined
CONFIG_NET.  Please redo the patch based on this.

thanks,

greg k-h
