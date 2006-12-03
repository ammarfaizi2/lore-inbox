Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760129AbWLCV0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760129AbWLCV0u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 16:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760110AbWLCV0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 16:26:46 -0500
Received: from smtp.osdl.org ([65.172.181.25]:14996 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1760128AbWLCV0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 16:26:24 -0500
Date: Sun, 3 Dec 2006 13:26:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: minyard@acm.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: Re: [PATCH 8/12] IPMI: system interface hotplug
Message-Id: <20061203132615.3cda55c7.akpm@osdl.org>
In-Reply-To: <20061202043655.GD30531@localdomain>
References: <20061202043655.GD30531@localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006 22:36:55 -0600
Corey Minyard <minyard@acm.org> wrote:

> 
> Add the ability to hot add and remove interfaces in the ipmi_si
> driver.  Any users who have the device open will get errors if they
> try to send a message.
> 
> ...
>
> +static int ipmi_strcasecmp(const char *s1, const char *s2)
> +{
> +	while (*s1 || *s2) {
> +		if (!*s1)
> +			return -1;
> +		if (!*s2)
> +			return 1;
> +		if (*s1 != *s2)
> +			return *s1 - *s2;
> +		s1++;
> +		s2++;
> +	}
> +	return 0;
> +}

Please put a newline between functions.

> +static int parse_str(struct hotmod_vals *v, int *val, char *name, char **curr)
> +{
> +	char *s;
> +	int  i;
> +
> +	s = strchr(*curr, ',');
> +	if (!s) {
> +		printk(KERN_WARNING PFX "No hotmod %s given.\n", name);
> +		return -EINVAL;
> +	}
> +	*s = '\0';
> +	s++;
> +	for (i = 0; hotmod_ops[i].name; i++) {
> +		if (ipmi_strcasecmp(*curr, v[i].name) == 0) {
> +			*val = v[i].val;
> +			*curr = s;
> +			return 0;
> +		}
> +	}
> +
> +	printk(KERN_WARNING PFX "Invalid hotmod %s '%s'\n", name, *curr);
> +	return -EINVAL;
> +}

Does this driver really need case-insensitive string comparision?

<greps the tree for casecmp, sighs>

That doesn't look like a case-insensitive string compare to me.  What's up?

> ...
>
> +		while (s) {
> +			curr = s;
> +			s = strchr(curr, ',');
> +			if (s) {
> +				*s = '\0';
> +				s++;
> +			}
> +			o = strchr(curr, '=');
> +			if (o) {
> +				*o = '\0';
> +				o++;
> +			}
> +#define HOTMOD_INT_OPT(name, val) \
> +			if (ipmi_strcasecmp(curr, name) == 0) {		\
> +				if (!o) {				\
> +					printk(KERN_WARNING PFX		\
> +					       "No option given for '%s'\n", \
> +						curr);			\
> +					goto out;			\
> +				}					\
> +				val = simple_strtoul(o, &n, 0);		\
> +				if ((*n != '\0') || (*o == '\0')) {	\
> +					printk(KERN_WARNING PFX		\
> +					       "Bad option given for '%s'\n", \
> +					       curr);			\
> +					goto out;			\
> +				}					\
> +			}
> +
> +			HOTMOD_INT_OPT("rsp", regspacing)
> +			else HOTMOD_INT_OPT("rsi", regsize)
> +			else HOTMOD_INT_OPT("rsh", regshift)
> +			else HOTMOD_INT_OPT("irq", irq)
> +			else HOTMOD_INT_OPT("ipmb", ipmb)

oh yuk.  Can't this be done via a function or something?


