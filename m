Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbUFQUrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUFQUrB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 16:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUFQUrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 16:47:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:20117 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262972AbUFQUqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 16:46:49 -0400
Date: Thu, 17 Jun 2004 13:46:36 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Zwane Mwaikambo <zwane@fsmlabs.com>, "David S. Miller" <davem@redhat.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] fix bridge sysfs improperly initialised knobject
Message-Id: <20040617134636.216f430e@dell_ss3.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.58.0406161247140.1944@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0406161247140.1944@montezuma.fsmlabs.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The bridge sysfs interface introduced around 2.6.7-rc1 created a bad
> entry in /sys because it didn't initialise the name member of the kobject.
> 
> zwane@montezuma /sys {0:0} ls -l
> total 0
> ?---------   ? ?    ?    ?            ?
> drwxr-xr-x  17 root root 0 Jun 15 15:47 block
> drwxr-xr-x   7 root root 0 Jun 15 15:47 bus
> drwxr-xr-x  16 root root 0 Jun 15 15:47 class
> drwxr-xr-x   5 root root 0 Jun 15 15:47 devices
> drwxr-xr-x   3 root root 0 Jun 15 15:47 firmware
> drwxr-xr-x   8 root root 0 Jun 15 19:55 module
> 
> Index: linux-2.6.7-rc3-mm2/net/bridge/br_sysfs_br.c
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.7-rc3-mm2/net/bridge/br_sysfs_br.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 br_sysfs_br.c
> --- linux-2.6.7-rc3-mm2/net/bridge/br_sysfs_br.c	14 Jun 2004 12:49:12 -0000	1.1.1.1
> +++ linux-2.6.7-rc3-mm2/net/bridge/br_sysfs_br.c	16 Jun 2004 16:45:20 -0000
> @@ -305,9 +305,7 @@ static struct bin_attribute bridge_forwa
>   * This is a dummy kset so bridge objects don't cause
>   * hotplug events
>   */
> -struct subsystem bridge_subsys = {
> -	.kset = { .hotplug_ops = NULL },
> -};
> +decl_subsys_name(bridge, net_bridge, NULL, NULL);
> 
>  void br_sysfs_init(void)
>  {


Yes, this would get rid of the name, but then wouldn't bridge show up
as top level subsystem /sys/bridge. 

Is there no way to register without causing bogus hotplug events?

I am getting a bad taste about the whole sysfs programming model, since
it seems like programming by side effect. it would be better for sysfs
to handle the case of hidden subsystems, or provide an alternate way
not to generate hotplug events.
