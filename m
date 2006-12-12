Return-Path: <linux-kernel-owner+w=401wt.eu-S932384AbWLLTTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWLLTTK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 14:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWLLTTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 14:19:09 -0500
Received: from waste.org ([66.93.16.53]:54385 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932384AbWLLTTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 14:19:08 -0500
Date: Tue, 12 Dec 2006 13:09:23 -0600
From: Matt Mackall <mpm@selenic.com>
To: Keiichi KII <k-keiichi@bx.jp.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.19 3/6] add interface for netconsole using sysfs
Message-ID: <20061212190922.GK13687@waste.org>
References: <457E498C.1050806@bx.jp.nec.com> <457E4D8E.6020903@bx.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457E4D8E.6020903@bx.jp.nec.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 03:34:54PM +0900, Keiichi KII wrote:
> From: Keiichi KII <k-keiichi@bx.jp.nec.com>
> 
> This patch contains the following changes.
> 
> create a sysfs entry for netconsole in /sys/class/misc.
> This entry has elements related to netconsole as follows.
> You can change configuration of netconsole(writable attributes such as IP
> address, port number and so on) and check current configuration of netconsole.
> 
> -+- /sys/class/misc/
>  |-+- netconsole/
>    |-+- port1/
>    | |--- id          [r--r--r--]  unique port id
>    | |--- remove      [-w-------]  if you write something to "remove",
>    | |                             this port is removed.
>    | |--- dev_name    [r--r--r--]  network interface name
>    | |--- local_ip    [rw-r--r--]  source IP to use, writable
>    | |--- local_port  [rw-r--r--]  source port number for UDP packets, writable
>    | |--- local_mac   [r--r--r--]  source MAC address
>    | |--- remote_ip   [rw-r--r--]  port number for logging agent, writable
>    | |--- remote_port [rw-r--r--]  IP address for logging agent, writable
>    | ---- remote_mac  [rw-r--r--]  MAC address for logging agent, writable
>    |--- port2/
>    |--- port3/
>    ...
> 
> Signed-off-by: Keiichi KII <k-keiichi@bx.jp.nec.com>
> ---
> --- linux-2.6.19/drivers/net/netconsole.c	2006-12-06 14:37:26.842825500 +0900
> +++ enhanced-netconsole/drivers/net/netconsole.c.sysfs	2006-12-06
> 13:32:47.488381000 +0900
> @@ -45,6 +45,8 @@
>  #include <linux/sysrq.h>
>  #include <linux/smp.h>
>  #include <linux/netpoll.h>
> +#include <linux/miscdevice.h>
> +#include <linux/inet.h>
> 
>  MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
>  MODULE_DESCRIPTION("Console driver for network interfaces");
> @@ -53,6 +55,7 @@ MODULE_LICENSE("GPL");
>  enum {
>  	MAX_PRINT_CHUNK = 1000,
>  	MAX_CONFIG_LENGTH = 256,
> +	MAC_ADDR_DIGIT = 6,
>  };
> 
>  static char config[MAX_CONFIG_LENGTH];
> @@ -62,19 +65,214 @@ MODULE_PARM_DESC(netconsole, " netconsol
> 
>  struct netconsole_device {
>  	struct list_head list;
> +	struct kobject obj;
>  	spinlock_t netpoll_lock;
>  	int id;
>  	struct netpoll np;
>  };
> 
> +struct netcon_dev_attr {
> +	struct attribute attr;
> +	ssize_t (*show)(struct netconsole_device*, char*);
> +	ssize_t (*store)(struct netconsole_device*, const char*,
> +			 size_t count);
> +};
> +
>  static int add_netcon_dev(const char*);
> +static void setup_netcon_dev_sysfs(struct netconsole_device*);
>  static void cleanup_netconsole(void);
>  static void netcon_dev_cleanup(struct netconsole_device *nd);
> 
> +static int netcon_miscdev_configured = 0;
> +
>  static LIST_HEAD(active_netconsole_dev);
> 
>  static DEFINE_SPINLOCK(netconsole_dev_list_lock);
> 
> +#define SHOW_CLASS_ATTR(field, type, format, ...) \
> +static ssize_t show_##field(type, char *buf) \
> +{ \
> +     return sprintf(buf, format, __VA_ARGS__); \
> +} \

I see this sort of thing is pretty common with sysfs stuff.. but yuck.

> +static ssize_t show_netcon_dev_attr(struct kobject *kobj,
> +				    struct attribute *attr,
> +				    char *buffer)
> +{
> +	struct netcon_dev_attr *na = container_of(attr, struct netcon_dev_attr,
> +						  attr);
> +	struct netconsole_device * nd =
> +		container_of(kobj, struct netconsole_device, obj);
> +	if (na->show) {
> +		return na->show(nd, buffer);
> +	} else {
> +		return -EACCES;
> +	}

Kernel style is to skip the braces for single statement clauses.

> +	if (misc_register(&netcon_miscdev)) {
> +		printk(KERN_INFO
> +		       "netconsole: unable netconsole misc device\n");

This error message seems to be missing a word or two.

-- 
Mathematics is the supreme nostalgia of our time.
