Return-Path: <linux-kernel-owner+w=401wt.eu-S932343AbWLLSwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWLLSwk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWLLSwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:52:40 -0500
Received: from waste.org ([66.93.16.53]:42029 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932343AbWLLSwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:52:39 -0500
Date: Tue, 12 Dec 2006 12:42:50 -0600
From: Matt Mackall <mpm@selenic.com>
To: Keiichi KII <k-keiichi@bx.jp.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.19 2/6] support multiple logging agents
Message-ID: <20061212184250.GJ13687@waste.org>
References: <457E498C.1050806@bx.jp.nec.com> <457E4C65.6030802@bx.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457E4C65.6030802@bx.jp.nec.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 03:29:57PM +0900, Keiichi KII wrote:
> From: Keiichi KII <k-keiichi@bx.jp.nec.com>
> 
> This patch contains the following changes for supporting multiple logging agents.
> 
> 1. extend netconsole to multiple netpolls
>    To send kernel messages to multiple logging agents, extend netcosnole
>     to be able to use multiple netpolls. Each netpoll sends kernel messages
>     to its own logging agent.
> 
> 2. change config parameter format
>    I change config parameter format as follows.
> 
>    [BNF - netconsole config parameter format - ]
>    -before
>     netconsole  ::= "netconsole=" netcon_port
>    -after
>     netconsole  ::= "netconsole=" netcon_port ( ":" netcon_port )*
> 
>     netcon_port ::= src-conf "," dst-conf
>     src-conf    ::= src-port? "@" src-ip? "/" src-dev?
>     dst-conf    ::= dst-port? "@" dst-ip "/" dst-macaddr?
> 
>     src-port    ::= source port number for UDP packets
>     src-ip      ::= source IP to use
>     src-dev     ::= source network interface
>     dst-port    ::= port number for logging agent
>     dst-ip      ::= IP address for logging agent
>     dst-macaddr ::= MAC address for logging agent
> 
>    ex?$B!Ksending kernel messages to 192.168.0.1 and 192.168.1.1.
>     modprobe netconsole netconsole=@/eth0,@192.168.0.1/:@/eth0,@192.168.1.1/
> 
> Signed-off-by: Keiichi KII <k-keiichi@bx.jp.nec.com>
> ---
> --- linux-2.6.19/drivers/net/netconsole.c	2006-12-06 14:37:26.806823250 +0900
> +++ enhanced-netconsole/drivers/net/netconsole.c.multiplex	2006-12-06
> 14:35:34.431800250 +0900
> @@ -60,6 +60,21 @@ static char config[MAX_CONFIG_LENGTH];
>  module_param_string(netconsole, config, MAX_CONFIG_LENGTH, 0);
>  MODULE_PARM_DESC(netconsole, "
> netconsole=[src-port]@[src-ip]/[dev],[tgt-port]@<tgt-ip>/[tgt-macaddr]\n");
> 
> +struct netconsole_device {
> +	struct list_head list;
> +	spinlock_t netpoll_lock;

The structure name here is not quite right - there's no real
correspondence between this struct and a device. 'netconsole_target'
or simply 'netconsole' might be a better name.

> +	int id;
> +	struct netpoll np;
> +};
> +
> +static int add_netcon_dev(const char*);
> +static void cleanup_netconsole(void);
> +static void netcon_dev_cleanup(struct netconsole_device *nd);

Please keep function naming consistent. I'd prefer netconsole_add/del
here. Also, please keep all the argument names in your function prototypes.

>  static struct netpoll np = {
>  	.name = "netconsole",
>  	.dev_name = "eth0",
> @@ -69,23 +84,91 @@ static struct netpoll np = {
>  	.drop = netpoll_queue,
>  };

Shouldn't this piece get dropped in this patch?

> -static int configured = 0;
> +static int add_netcon_dev(const char* target_opt)
> +{
> +	static atomic_t netcon_dev_count = ATOMIC_INIT(0);

Hiding this inside a function seems wrong. Why do we need a count? If
we've already got a spinlock, why does it need to be atomic?

> +	struct netconsole_device *new_dev;
> +	char *netcon_dev_config;
> +
> +	netcon_dev_config = (char*)kmalloc(MAX_CONFIG_LENGTH+1, GFP_ATOMIC);
> +	if (!netcon_dev_config) {
> +		printk(KERN_INFO "netconsole: kmalloc() failed!\n");
> +		return -ENOMEM;
> +	}
> +	strncpy(netcon_dev_config, target_opt, MAX_CONFIG_LENGTH);

Why do we need to copy this string?

> +	
> +	new_dev = (struct netconsole_device*)kmalloc(
> +		sizeof(struct netconsole_device), GFP_ATOMIC);

Cast of void * is unnecessary.

> +	if (!new_dev) {
> +		printk(KERN_INFO "netconsole: kmalloc() failed!\n");
> +		kfree(netcon_dev_config);
> +		return -ENOMEM;
> +	}
> +	
> +	memset(new_dev, 0, sizeof(struct netconsole_device));
> +	spin_lock_init(&new_dev->netpoll_lock);
> +
> +	new_dev->np = np;
> +	if (netpoll_parse_options(&new_dev->np, netcon_dev_config)) {
> +		printk(KERN_INFO
> +		       "netconsole: can't parse config at %d\n",new_dev->id);
> +		goto setup_fail;
> +	}

I think we should print the config string we couldn't parse here instead.

> +	if (netpoll_setup(&new_dev->np)) {
> +		printk(KERN_INFO "netconsole: id:%d can't setup netpoll\n",
> +		       new_dev->id);
> +		goto setup_fail;
> +	}
> +	
> +	atomic_inc(&netcon_dev_count);
> +	new_dev->id = atomic_read(&netcon_dev_count);
> +
> +	printk(KERN_INFO "netconsole: add target id:%d\n", new_dev->id);

And perhaps the target IP address/port here.

> +
> +	spin_lock(&netconsole_dev_list_lock);
> +	list_add(&new_dev->list, &active_netconsole_dev);
> +	spin_unlock(&netconsole_dev_list_lock);
> +
> +	kfree(netcon_dev_config);
> +	return 0;
> +
> + setup_fail:
> +	kfree(netcon_dev_config);
> +	kfree(new_dev);
> +	return -EINVAL;
> +}
> +


>  static void write_msg(struct console *con, const char *msg, unsigned int len)
>  {
>  	int frag, left;
>  	unsigned long flags;
> +	struct netconsole_device *dev;
> 
> -	if (!np.dev)
> +	if (list_empty(&active_netconsole_dev))
>  		return;
> 
>  	local_irq_save(flags);
> +	spin_lock(&netconsole_dev_list_lock);
>  	for(left = len; left; ) {
>  		frag = min(left, MAX_PRINT_CHUNK);
> -		netpoll_send_udp(&np, msg, frag);
> +		list_for_each_entry(dev, &active_netconsole_dev, list) {
> +			spin_lock(&dev->netpoll_lock);
> +			netpoll_send_udp(&dev->np, msg, frag);
> +			spin_unlock(&dev->netpoll_lock);

Why do we need a lock here? Why isn't the list lock sufficient? What
happens if either lock is held when we get here?

> +		}
>  		msg += frag;
>  		left -= frag;
>  	}
> +	spin_unlock(&netconsole_dev_list_lock);
>  	local_irq_restore(flags);
>  }
> 
> @@ -95,9 +178,9 @@ static struct console netconsole = {
>  	.write = write_msg
>  };
> 
> -static int __init option_setup(char *opt)
> +static int __init __attribute_used__ option_setup(char *opt)

Why do we need __attribute_used__ here?

>  {
> -	configured = !netpoll_parse_options(&np, opt);
> +	strncpy(config, opt, MAX_CONFIG_LENGTH);
>  	return 1;
>  }
> 
> @@ -105,26 +188,36 @@ __setup("netconsole=", option_setup);
> 
>  static int __init init_netconsole(void)
>  {
> -	if(strlen(config))
> -		option_setup(config);
> +	char *p;
> +	char *tmp = config;
> 
> -	if(!configured) {
> -		printk("netconsole: not configured, aborting\n");
> +	register_console(&netconsole);
> +
> +	if(!strlen(config)) {
> +		printk(KERN_INFO "netconsole: not configured\n");
>  		return 0;
>  	}
> +	while ((p = strsep(&tmp, ":")) != NULL) {
> +		if (add_netcon_dev(p)) {
> +			printk(KERN_INFO
> +			       "netconsole: can't add target to netconsole\n");
> +			cleanup_netconsole();
> +			return -EINVAL;
> +		}
> +	}
> 
> -	if(netpoll_setup(&np))
> -		return -EINVAL;
> -
> -	register_console(&netconsole);
>  	printk(KERN_INFO "netconsole: network logging started\n");
>  	return 0;
>  }
> 
>  static void cleanup_netconsole(void)
>  {
> +	struct netconsole_device *dev, *tmp;
> +
>  	unregister_console(&netconsole);
> -	netpoll_cleanup(&np);
> +	list_for_each_entry_safe(dev, tmp, &active_netconsole_dev, list) {
> +		netcon_dev_cleanup(dev);
> +	}
>  }
> 
>  module_init(init_netconsole);
> 
> -- 
> Keiichi KII
> NEC Corporation OSS Promotion Center
> E-mail: k-keiichi@bx.jp.nec.com

-- 
Mathematics is the supreme nostalgia of our time.
