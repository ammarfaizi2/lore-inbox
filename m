Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVBHOsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVBHOsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 09:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVBHOsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 09:48:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42189 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261537AbVBHOsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 09:48:23 -0500
Date: Tue, 8 Feb 2005 09:48:13 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <michal@logix.cz>, "David S. Miller" <davem@davemloft.net>,
       "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
In-Reply-To: <20050205092336.GA15382@ghanima.endorphin.org>
Message-ID: <Xine.LNX.4.44.0502080926380.32035-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Feb 2005, Fruhwirth Clemens wrote:

> Fixed formating and white-spaces. The biggest change is, that I stripped
> a redundant check from scatterwalk.c. This omission seems justified and
> shows no regression on my system. ( http://lkml.org/lkml/2005/2/3/87 )
> Can you give it a quick test with ipsec anyhow? Just to make sure.

Not tested yet, still reviewing the code.

> + * The generic scatterwalker applies a certain function, pf, utilising
> + * an arbitrary number of scatterlist data as it's arguments. These
> + * arguments are supplied as an array of pointers to buffers. These
> + * buffers are prepared and processed block-wise by the function
> + * (stepsize) and might be input or output buffers.

This is not going to work generically, as there number of atomic kmaps
available is limited.  You have four: one for input and one for output,
each in user in softirq context (hence the list in crypto_km_types).  A
thread of execution can only use two at once (input & output).  The crypto
code is written around this: processing a cleartext and ciphertext block
simultaneously.

> +
> +int scatterwalk_walk(sw_proc_func_t pf, void *priv, int steps,
> +		     struct walk_info *walk_infos) 
> +{
> +	int r = -EINVAL;
> +	
> +	int i;

Looks like this i is left over from something no longer use.

> +				scatterwalk_copychunks(*cbuf,&csg->sw,csg->stepsize,1);

There are several places such as this where you use literal 1 & 0 instead 
of the new macros, SCATTERWALK_IO_OUTPUT & INPUT.

> +static inline int scatterwalk_needscratch(struct scatter_walk *walk, int nbytes) 
> +{
> +       return (nbytes <= walk->len_this_page);
> +}

The logic of this is inverted given the function name.  While the calling 
code is using it correctly, it's going to cause confusion.

Also confusing is the remaining clamping of the page offset:

static inline void scatterwalk_start(struct scatter_walk *walk, struct scatterlist *sg)
{
	...

	rest_of_page = PAGE_CACHE_SIZE - (sg->offset & (PAGE_CACHE_SIZE - 1));
        walk->len_this_page = min(sg->length, rest_of_page);
}

rest_of_page should be just PAGE_SIZE - sg->offset (sg->offset should
never extend beyond the page).
  
And then how would walk->len_this_page be greater than rest_of_page?


- James
-- 
James Morris
<jmorris@redhat.com>





