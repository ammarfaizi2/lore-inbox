Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbUJYF4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbUJYF4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 01:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbUJYF43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 01:56:29 -0400
Received: from ozlabs.org ([203.10.76.45]:13445 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261456AbUJYF4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 01:56:16 -0400
Subject: Re: [RFC/PATCH] Per-device parameter support (13/16)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tejun Heo <tj@home-tj.org>
Cc: mochel@osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041023043138.GN3456@home-tj.org>
References: <20041023043138.GN3456@home-tj.org>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 15:56:13 +1000
Message-Id: <1098683773.8098.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 13:31 +0900, Tejun Heo wrote:
>  dp_13_devparam.diff
> 
>  This is the 13rd patch of 16 patches for devparam.
> 
>  This patch adds needed data fields to module and device structures
> and actually implements devparam.  This patch doesn't hook devparam
> into the driver model it's done in the next patch.

> +int devparam_unknown_modparam(char *name, char *val, void *arg)
> +{
> +	struct module *mod = arg;
> +	char **param;
> +
> +	param = vector_elem(&mod->param_vec, vector_len(&mod->param_vec),
> +			    GFP_KERNEL);
> +
> +	if (param == NULL) {
> +		printk(KERN_ERR
> +		       "Device params: Insufficient memory for `%s'\n", name);
> +		return -ENOMEM;
> +	}
> +
> +	param[0] = name;
> +	param[1] = val;
> +
> +	return 0;
> +}
> +
> +void devparam_module_done(struct module *mod)
> +{
> +	struct vector *vec = &mod->param_vec;
> +	int i;
> +
> +	for (i = 0; i < vector_len(vec); i++) {
> +		char **param = vector_elem(vec, i, 0);
> +		if (param[0])
> +			printk(KERN_ERR
> +			       "Device params: Unknown parameter `%s'\n",
> +			       param[0]);
> +	}
> +	
> +	vector_destroy(vec);
> +}

That seems a strange place to warn...  Is that right?

> +
> +	/* Module parameter vector, used by deviceparam */
> +	struct vector param_vec;

I don't mind the addition of your vector type, but adding infrastructure
always results in arguments.  Can you think of another place which needs
it?

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

