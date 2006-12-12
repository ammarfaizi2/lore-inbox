Return-Path: <linux-kernel-owner+w=401wt.eu-S932341AbWLLTZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWLLTZE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 14:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWLLTZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 14:25:04 -0500
Received: from waste.org ([66.93.16.53]:51243 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932341AbWLLTZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 14:25:01 -0500
Date: Tue, 12 Dec 2006 13:15:18 -0600
From: Matt Mackall <mpm@selenic.com>
To: Keiichi KII <k-keiichi@bx.jp.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.19 4/6] switch function of netpoll
Message-ID: <20061212191518.GL13687@waste.org>
References: <457E498C.1050806@bx.jp.nec.com> <457E4DD0.4050204@bx.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457E4DD0.4050204@bx.jp.nec.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 03:36:00PM +0900, Keiichi KII wrote:
> From: Keiichi KII <k-keiichi@bx.jp.nec.com>
> 
> This patch contains switch function of netpoll.
> 
> if "enable" attribute of certain port is '1', this port is used.
> if "enable" attribute of certain port is '0', this port isn't used.
> 
> active_netconsole_dev list manages a list of active ports.
> inactive_netconsole_dev list manages a list of inactive ports.
> 
> If you write '0' to "enable" attribute of a port included in
> active_netconsole_dev_list, This port moves from active_netconsole_dev to
> inactive_netconsole_dev and won't used to send kernel message.
> 
> -+- /sys/class/misc/
>  |-+- netconsole/
>    |-+- port1/
>    | |--- id          [r--r--r--]  id
>    | |--- enable      [rw-r--r--]  0: disable, 1: enable, writable
>    | ...
>    |--- port2/
>    ...
> 
> Signed-off-by: Keiichi KII <k-keiichi@bx.jp.nec.com>
> ---
> --- linux-2.6.19/drivers/net/netconsole.c	2006-12-06 14:37:26.858826500 +0900
> +++ enhanced-netconsole/drivers/net/netconsole.c.switch	2006-12-06
> 13:32:56.744959500 +0900
> @@ -86,9 +86,25 @@ static void netcon_dev_cleanup(struct ne
>  static int netcon_miscdev_configured = 0;
> 
>  static LIST_HEAD(active_netconsole_dev);
> +static LIST_HEAD(inactive_netconsole_dev);
> 
>  static DEFINE_SPINLOCK(netconsole_dev_list_lock);
> 
> +static ssize_t show_enable(struct netconsole_device *nd, char *buf) {
> +	struct netconsole_device *dev;
> +
> +	spin_lock(&netconsole_dev_list_lock);
> +	list_for_each_entry(dev, &active_netconsole_dev, list) {
> +		if (dev->id == nd->id) {
> +			spin_unlock(&netconsole_dev_list_lock);
> +			return sprintf(buf, "1\n");
> +		}
> +	}
> +	spin_unlock(&netconsole_dev_list_lock);
> +
> +	return sprintf(buf, "0\n");
> +}

If we intend to have no more than a couple dozen of these, having a
separate list makes things too complicated. Simply add an enabled
field in the struct and skip disabled targets on netconsole writes.
This function becomes 3 lines.

> +static ssize_t store_enable(struct netconsole_device *nd, const char *buf,
> +			    size_t count)
> +{
> +	struct netconsole_device *dev, *tmp;
> +	struct list_head *src, *dst;
> +
> +	if (strncmp(buf, "1", 1) == 0) {
> +		src = &inactive_netconsole_dev;
> +		dst = &active_netconsole_dev;
> +	} else if(strncmp(buf, "0", 1) == 0) {
> +		src = &active_netconsole_dev;
> +		dst = &inactive_netconsole_dev;
> +	} else {
> +		printk(KERN_INFO "netconsole: invalid argument: %s\n", buf);
> +		return -EINVAL;
> +	}
> +	
> +	spin_lock(&netconsole_dev_list_lock);
> +	list_for_each_entry_safe(dev, tmp, src, list) {
> +		if (dev->id == nd->id) {
> +			list_del(&nd->list);
> +			list_add(&nd->list, dst);
> +			break;
> +		}
> +	}
> +	spin_unlock(&netconsole_dev_list_lock);
> +
> +	return count;
> +}

As does this one.

-- 
Mathematics is the supreme nostalgia of our time.
