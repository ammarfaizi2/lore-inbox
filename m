Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbUKEUnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbUKEUnu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 15:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUKEUnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 15:43:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:50394 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261198AbUKEUne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 15:43:34 -0500
Date: Fri, 5 Nov 2004 12:42:09 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>, anil.s.keshavamurthy@intel.com,
       tokunaga.keiich@jp.fujitsu.com, motoyuki@soft.fujitsu.com
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       rml@novell.com, linux-kernel@vger.kernel.org, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.10-rc1-mm3: ACPI problem due to un-exported hotplug_path
Message-ID: <20041105204209.GA1204@kroah.com>
References: <20041105001328.3ba97e08.akpm@osdl.org> <20041105164523.GC1295@stusta.de> <20041105180513.GA32007@kroah.com> <20041105201012.GA24063@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105201012.GA24063@vrfy.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 09:10:12PM +0100, Kay Sievers wrote:
> On Fri, Nov 05, 2004 at 10:05:13AM -0800, Greg KH wrote:
> > On Fri, Nov 05, 2004 at 05:45:23PM +0100, Adrian Bunk wrote:
> > > The following error (compin from Linus' tree) is caused by the fact that 
> > > hotplug_path is no longer EXPORT_SYMBOL'ed:
> > > 
> > > 
> > > <--  snip  -->
> > > 
> > > if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.10-rc1-mm3; fi
> > > WARNING: /lib/modules/2.6.10-rc1-mm3/kernel/drivers/acpi/container.ko needs unknown symbol hotplug_path
> > > 
> > > <--  snip  -->
> > 
> > Hm, must be an -mm specific change that is causing this.  I don't see
> > this in the current tree.
> > 
> > Len, why would any ACPI code be wanting to get access to hotplug_path
> > directly?
> 
> 
> I've found it. This wants to introduce a new direct /sbin/hotplug call,
> with "add" and "remove" events, without sysfs support.
> 
> It should use class support or kobject_hotplug() instead.  Nobody should
> fake hotplug events anymore, cause every other notification transport
> will not get called (currently uevent over netlink).
>   http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/broken-out/bk-acpi.patch
> 
> +static int
> +container_run_sbin_hotplug(struct acpi_device *device, char *action)
> +{
> ...
> +	argv[i++] = hotplug_path;
> +	argv[i++] = "container";
> +	argv[i] = NULL;
> ...
> +	i = 0;
> +	envp[i++] = "HOME=/";
> +	envp[i++] = "PATH=/sbin;/bin;/usr/sbin;/usr/bin";
> +	envp[i++] = action_str;
> +	envp[i++] = container_str;
> +	envp[i++] = "PLATFORM=ACPI";
> +	envp[i] = NULL;
> ...

Good catch.  Yeah, that code is just wrong.

Anil, your name is on this file.  Care to fix it up to use the proper
driver core hotplug functionality instead of rolling your own?

Or is there some reason you are wanting to do this kind of notification
that the driver core is not providing for you?

thanks,

greg k-h
