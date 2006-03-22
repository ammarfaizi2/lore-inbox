Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWCVIkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWCVIkk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWCVIkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:40:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41154 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751104AbWCVIkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:40:39 -0500
Subject: Re: [RFC PATCH 26/35] Add Xen subarch reboot support
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060322063801.949835000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
	 <20060322063801.949835000@sorel.sous-sol.org>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 09:40:37 +0100
Message-Id: <1143016837.2955.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 22:31 -0800, Chris Wright wrote:
> +
> +#ifdef CONFIG_XEN_XENBUS
> +/* Ignore multiple shutdown requests. */
> +static int shutting_down = SHUTDOWN_INVALID;
> +static void __shutdown_handler(void *unused);
> +static DECLARE_WORK(shutdown_work, __shutdown_handler, NULL);
> +#endif
> +
> +#ifdef CONFIG_XEN_XENBUS

eh why the re-ifdef


> +static int shutdown_process(void *__unused)
> +{
> +	static char *envp[] = { "HOME=/", "TERM=linux",
> +				"PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
> +	static char *restart_argv[]  = { "/sbin/reboot", NULL };
> +	static char *poweroff_argv[] = { "/sbin/poweroff", NULL };
> +
> +	extern asmlinkage long sys_reboot(int magic1, int magic2,
> +					  unsigned int cmd, void *arg);
> +
> +	daemonize("shutdown");
> +
> +	switch (shutting_down) {
> +	case SHUTDOWN_POWEROFF:
> +	case SHUTDOWN_HALT:
> +		if (execve("/sbin/poweroff", poweroff_argv, envp) < 0) {
> +			sys_reboot(LINUX_REBOOT_MAGIC1,
> +				   LINUX_REBOOT_MAGIC2,
> +				   LINUX_REBOOT_CMD_POWER_OFF,
> +				   NULL);
> +		}
> +		break;
> +
> +	case SHUTDOWN_REBOOT:
> +		if (execve("/sbin/reboot", restart_argv, envp) < 0) {
> +			sys_reboot(LINUX_REBOOT_MAGIC1,
> +				   LINUX_REBOOT_MAGIC2,
> +				   LINUX_REBOOT_CMD_RESTART,
> +				   NULL);
> +		}
> +		break;
> +	}
> +
> +	shutting_down = SHUTDOWN_INVALID; /* could try again */
> +
> +	return 0;
> +}

how is this function different from the generic one? If not, why aren't
you using the generic one?


> +static struct notifier_block xenstore_notifier;

what is this for? It's not exported and hardly used...


