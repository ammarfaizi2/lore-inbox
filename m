Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVAEPMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVAEPMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVAEPLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:11:44 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:55759 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262462AbVAEPJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:09:32 -0500
Date: Wed, 5 Jan 2005 10:09:30 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Bryan Fulton <bryan@coverity.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Coverity] Untrusted user data in kernel
Message-ID: <20050105150930.GK28521@delft.aura.cs.cmu.edu>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Bryan Fulton <bryan@coverity.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <1103247211.3071.74.camel@localhost.localdomain> <20050105120423.GA13662@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105120423.GA13662@logos.cnet>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 10:04:23AM -0200, Marcelo Tosatti wrote:
> On Thu, Dec 16, 2004 at 05:33:32PM -0800, Bryan Fulton wrote:
> Correct, fix for both v2.4 and v2.6 attached. Adds bound checking:
> 
> Jan Harkes, please check correctness so we can apply it.

I was looking at this and actually think that both in_size and out_size
should just be changed to unsigned short instead of signed short (the
values should never be negative, period).

That fixes the bounds checking on the in_size, but the out_size one is
still questionable. I'm not even sure the code is actually testing the
right thing there.

> --- linux-2.6.10-rc3/fs/coda/upcall.c.orig	2005-01-05 10:30:24.575445152 -0200
> +++ linux-2.6.10-rc3/fs/coda/upcall.c	2005-01-05 10:30:26.623133856 -0200
> @@ -550,10 +550,15 @@
>  	UPARG(CODA_IOCTL);
>  
>          /* build packet for Venus */
> -        if (data->vi.in_size > VC_MAXDATASIZE) {
> +        if (data->vi.in_size > VC_MAXDATASIZE || data->vi.in_size < 0) {
>  		error = -EINVAL;
>  		goto exit;
> -        }
> +        } 

This part would work, but changing to the variable to unsigned short
in include/linux/coda.h works just as well.

> +	if (data->vi.out_size > VC_MAXDATASIZE || data->vi.out_size < 0) {
> +		error = -EINVAL;
> +		goto exit;
> +	}

We might be overwriting out_size when making the upcall to venus, so
checking out_size here probably doesn't help all that much. I'm still
looking at what exactly is going on with that. I should have a patch by
the end of the week.

Jan

