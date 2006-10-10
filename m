Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWJJS5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWJJS5I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWJJS5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:57:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60111 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751082AbWJJS5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:57:05 -0400
Date: Tue, 10 Oct 2006 11:56:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch 1/2] round_jiffies infrastructure
Message-Id: <20061010115652.4ef068bd.akpm@osdl.org>
In-Reply-To: <1160496210.3000.310.camel@laptopd505.fenrus.org>
References: <1160496165.3000.308.camel@laptopd505.fenrus.org>
	<1160496210.3000.310.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 18:03:30 +0200
Arjan van de Ven <arjan@linux.intel.com> wrote:

> @@ -80,6 +80,56 @@ tvec_base_t boot_tvec_bases;
>  EXPORT_SYMBOL(boot_tvec_bases);
>  static DEFINE_PER_CPU(tvec_base_t *, tvec_bases) = &boot_tvec_bases;
>  
> +unsigned long __round_jiffies(unsigned long T, int CPU)
> +{
> +	int rem;
> +	int original  = T;
> +	rem = T % HZ;
> +	if (rem < HZ/4)
> +		T = T - rem;
> +	else
> +		T = T - rem + HZ;
> +	/* we don't want all cpus firing at once hitting the same lock/memory */
> +	T += CPU * 3;
> +	if (T <= jiffies) /* rounding ate our timeout entirely */
> +		return original;
> +	return T;
> +}
> +EXPORT_SYMBOL_GPL(__round_jiffies);
> +

c'mon Arjan.  If we're going to create new, kernel-wide,
exported-to-modules infrastructure then it deserves slightly more than zero
documentation.

Some commentary explaining/justifying the magic numbers in there would be
useful too.  The HZ/4, the cpu*3.

And coding style too, please: consistent spacing around arithmetic
operators, variables are lower case, constants are upper case.
