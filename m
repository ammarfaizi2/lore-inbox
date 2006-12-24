Return-Path: <linux-kernel-owner+w=401wt.eu-S1754074AbWLXFdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074AbWLXFdd (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 00:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079AbWLXFdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 00:33:33 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:43530 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbWLXFdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 00:33:32 -0500
Date: Sat, 23 Dec 2006 21:34:26 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Keiichi KII <k-keiichi@bx.jp.nec.com>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH -mm 3/5] add interface for netconsole using sysfs
Message-Id: <20061223213426.aa80907e.randy.dunlap@oracle.com>
In-Reply-To: <458BCC2C.9070802@bx.jp.nec.com>
References: <458BC905.7050003@bx.jp.nec.com>
	<458BCC2C.9070802@bx.jp.nec.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006 21:14:36 +0900 Keiichi KII wrote:

> From: Keiichi KII <k-keiichi@bx.jp.nec.com>
> 
> ---
> [changes]
> 1. expand macro code as far as possible.
> 2. follow kernel coding style.
> 3. print proper output messeage.
> 4. attach proper label for printk.
> 5. integrate netpoll_lock and netcon_target_list_lock into common spinlock.
> 6. return proper error value.
> 
> --- linux-mm/drivers/net/netconsole.c	2006-12-22 20:54:54.431673500 +0900
> +++ enhanced-netconsole/drivers/net/netconsole.c.sysfs	2006-12-22 16:12:47.925833000 +0900
> @@ -56,18 +58,234 @@ MODULE_PARM_DESC(netconsole, " netconsol
>  
>  struct netconsole_target {
>  	struct list_head list;
> +	struct kobject obj;
>  	int id;
>  	struct netpoll np;
>  };
>  
> +#define MAX_PRINT_CHUNK 1000
> +#define CONFIG_SEPARATOR ":"
> +#define MAC_ADDR_DIGIT 6

Can you use ETH_ALEN from if_ether.h instead of MAC_ADDR_DIGIT ?

> +
> +struct target_attr {
> +	struct attribute attr;
> +	ssize_t (*show)(struct netconsole_target*, char*);
> +	ssize_t (*store)(struct netconsole_target*, const char*,
> +			 size_t count);
> +};
> +
>  static int add_target(char* target_config);
> +static void setup_target_sysfs(struct netconsole_target *nt);
>  static void cleanup_netconsole(void);
>  static void delete_target(struct netconsole_target *nt);
>  
> +static int miscdev_configured = 0;

Don't init static data to 0 or NULL.
It's done for us.

>  static LIST_HEAD(target_list);
>  
>  static DEFINE_SPINLOCK(target_list_lock);
>  
> +static ssize_t show_local_ip(struct netconsole_target *nt, char *buf)
> +{
> +	return sprintf(buf, "%d.%d.%d.%d\n", HIPQUAD(nt->np.local_ip));

I don't understand the use of HIPQUAD() here instead of
NIPQUAD().  Explain?

Also, NIPQUAD_FMT (in kernel.h) uses "%u.%u.%u.%u".
This should probably be the same.
Or just use:	NIPQUAD_FMT "\n"

> +}
> +
> +static ssize_t show_remote_ip(struct netconsole_target *nt, char *buf)
> +{
> +	return sprintf(buf, "%d.%d.%d.%d\n", HIPQUAD(nt->np.remote_ip));
> +}
> +
> +
> +static ssize_t store_remote_mac(struct netconsole_target *nt, const char *buf,
> +			       size_t count)
> +{
> +	unsigned char input_mac[MAC_ADDR_DIGIT] =
> +		{0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
> +	const char *cur = buf;
> +	char *delim;
> +	int i = 0;
> +
> +	for(i=0; i < MAC_ADDR_DIGIT; i++) {

	for (i = 0; i < MAC_ADDR_DIGIT; i++) {

> +		input_mac[i] = simple_strtol(cur, NULL, 16);
> +		if (i != MAC_ADDR_DIGIT - 1 &&
> +		    (delim = strchr(cur, ':')) == NULL) {
> +			return -EINVAL;

No braces on one-line "blocks", please.

> +		}
> +		cur = delim + 1;
> +	}
> +	spin_lock(&target_list_lock);
> +	memcpy(nt->np.remote_mac, input_mac, MAC_ADDR_DIGIT);
> +	spin_unlock(&target_list_lock);
> +
> +	return count;
> +}
> +
> +

---
~Randy
