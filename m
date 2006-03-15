Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWCOAJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWCOAJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 19:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWCOAJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 19:09:56 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:30640
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932117AbWCOAJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 19:09:56 -0500
Date: Tue, 14 Mar 2006 16:09:51 -0800
From: Greg KH <gregkh@suse.de>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject_uevent CONFIG_SYSFS=n build fix
Message-ID: <20060315000951.GA6608@suse.de>
References: <4416EB14.50306@ce.jp.nec.com> <20060314220130.GB12257@suse.de> <44175911.1010400@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44175911.1010400@ce.jp.nec.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 07:00:17PM -0500, Jun'ichi Nomura wrote:
> --- linux-2.6.16-rc6-mm1.orig/lib/kobject_uevent.c	2006-03-14 22:57:23.000000000 +0900
> +++ linux-2.6.16-rc6-mm1/lib/kobject_uevent.c	2006-03-15 08:39:33.000000000 +0900
> @@ -25,6 +25,11 @@
>  #define BUFFER_SIZE	2048	/* buffer for the variables */
>  #define NUM_ENVP	32	/* number of env pointers */
>  
> +#ifdef CONFIG_HOTPLUG
> +u64 uevent_seqnum;
> +char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
> +#endif
> +
>  #if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)
>  static DEFINE_SPINLOCK(sequence_lock);
>  static struct sock *uevent_sock;
> --- linux-2.6.16-rc6-mm1.orig/kernel/ksysfs.c	2006-03-14 22:57:31.000000000 +0900
> +++ linux-2.6.16-rc6-mm1/kernel/ksysfs.c	2006-03-15 08:41:11.000000000 +0900
> @@ -15,9 +15,6 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  
> -u64 uevent_seqnum;
> -char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
> -
>  #define KERNEL_ATTR_RO(_name) \
>  static struct subsys_attribute _name##_attr = __ATTR_RO(_name)
>  

Those two changes look correct.  But why did you modify kobject.h below?

> --- linux-2.6.16-rc6-mm1.orig/include/linux/kobject.h	2006-03-15 00:00:20.000000000 +0900
> +++ linux-2.6.16-rc6-mm1/include/linux/kobject.h	2006-03-15 08:38:45.000000000 +0900
> @@ -27,6 +27,8 @@
>  #include <asm/atomic.h>
>  
>  #define KOBJ_NAME_LEN			20
> +
> +#ifdef CONFIG_HOTPLUG
>  #define UEVENT_HELPER_PATH_LEN		256
>  
>  /* path to the userspace helper executed on an event */
> @@ -34,6 +36,7 @@ extern char uevent_helper[];
>  
>  /* counter to tag the uevent, read only except for the kobject core */
>  extern u64 uevent_seqnum;
> +#endif
>  
>  /* the actions here must match the proper string in lib/kobject_uevent.c */
>  typedef int __bitwise kobject_action_t;

That shouldn't be needed, right?

thanks,

greg k-h
