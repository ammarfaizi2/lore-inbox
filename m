Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWEAU31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWEAU31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWEAU31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:29:27 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:2521 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932227AbWEAU30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:29:26 -0400
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
From: Dave Hansen <haveblue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ebiederm@xmission.com, herbert@13thfloor.at, dev@sw.ru,
       linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       clg@us.ibm.com, frankeh@us.ibm.com
In-Reply-To: <20060501203907.XF1836@sergelap.austin.ibm.com>
References: <20060501203906.XF1836@sergelap.austin.ibm.com>
	 <20060501203907.XF1836@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 01 May 2006 13:28:36 -0700
Message-Id: <1146515316.32079.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 14:53 -0500, Serge E. Hallyn wrote:
> +struct uts_namespace *clone_uts_ns(struct uts_namespace *old_ns)
> +{
> +	struct uts_namespace *ns;
> +
> +	ns = kmalloc(sizeof(struct uts_namespace), GFP_KERNEL);
> +	if (ns) {
> +		memcpy(&ns->name, &old_ns->name, sizeof(ns->name));
> +		kref_init(&ns->kref);
> +	}
> +	return ns;
> +}

Very small nit...

Would this memcpy be more appropriate as a strncpy()?

> +int unshare_utsname(unsigned long unshare_flags, struct uts_namespace **new_uts)
> +{
> +	if (unshare_flags & CLONE_NEWUTS) {
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;
> +
> +		*new_uts = clone_uts_ns(current->uts_ns);
> +		if (!*new_uts)
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}

Would it be a bit nicer to use the ERR_PTR() mechanism here instead of
the double-pointer bit?

I've always liked those a bit better because there's no hiding the fact
of what is actually a return value from a function.

-- Dave

