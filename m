Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbUKEUKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbUKEUKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 15:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbUKEUKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 15:10:49 -0500
Received: from soundwarez.org ([217.160.171.123]:43467 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261199AbUKEUKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 15:10:12 -0500
Date: Fri, 5 Nov 2004 21:10:12 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       rml@novell.com, linux-kernel@vger.kernel.org, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.10-rc1-mm3: ACPI problem due to un-exported hotplug_path
Message-ID: <20041105201012.GA24063@vrfy.org>
References: <20041105001328.3ba97e08.akpm@osdl.org> <20041105164523.GC1295@stusta.de> <20041105180513.GA32007@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105180513.GA32007@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 10:05:13AM -0800, Greg KH wrote:
> On Fri, Nov 05, 2004 at 05:45:23PM +0100, Adrian Bunk wrote:
> > The following error (compin from Linus' tree) is caused by the fact that 
> > hotplug_path is no longer EXPORT_SYMBOL'ed:
> > 
> > 
> > <--  snip  -->
> > 
> > if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.10-rc1-mm3; fi
> > WARNING: /lib/modules/2.6.10-rc1-mm3/kernel/drivers/acpi/container.ko needs unknown symbol hotplug_path
> > 
> > <--  snip  -->
> 
> Hm, must be an -mm specific change that is causing this.  I don't see
> this in the current tree.
> 
> Len, why would any ACPI code be wanting to get access to hotplug_path
> directly?


I've found it. This wants to introduce a new direct /sbin/hotplug call,
with "add" and "remove" events, without sysfs support.

It should use class support or kobject_hotplug() instead.  Nobody should
fake hotplug events anymore, cause every other notification transport
will not get called (currently uevent over netlink).
  http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/broken-out/bk-acpi.patch

+static int
+container_run_sbin_hotplug(struct acpi_device *device, char *action)
+{
...
+	argv[i++] = hotplug_path;
+	argv[i++] = "container";
+	argv[i] = NULL;
...
+	i = 0;
+	envp[i++] = "HOME=/";
+	envp[i++] = "PATH=/sbin;/bin;/usr/sbin;/usr/bin";
+	envp[i++] = action_str;
+	envp[i++] = container_str;
+	envp[i++] = "PLATFORM=ACPI";
+	envp[i] = NULL;
...


Thanks,
Kay
