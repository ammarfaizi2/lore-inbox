Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbUKNJod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbUKNJod (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 04:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbUKNJod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 04:44:33 -0500
Received: from verein.lst.de ([213.95.11.210]:33460 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261274AbUKNJo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 04:44:26 -0500
Date: Sun, 14 Nov 2004 10:44:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Werner <werner@sgi.com>, davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][AGPGART] Allow multiple backends to be initialized
Message-ID: <20041114094418.GA31154@lst.de>
References: <200411131826.31770.werner@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411131826.31770.werner@sgi.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last time I checked Dave Jones (davej@codemonkey.org.uk) was agpgart
maintainer, not Rusty or me.  So please resend to Dave and the
linux-kernel list so other people (like me can comment).

Comments on the patch format:  Please don't send output of bk export
over multiple changesets - while you can use that to generate the
patch please strip the bk checkin comments and write a single patch
description that explains your overall changes, aka what you did
and if it's not obvious why.

If you patch does multiple things at once split it into one patch per
problem or feature.


> -struct agp_bridge_data agp_bridge_dummy = { .type = NOT_SUPPORTED };
> -struct agp_bridge_data *agp_bridge = &agp_bridge_dummy;
> +struct agp_bridge_data *agp_bridge = NULL;

there's no need to initialize global variables to NULL - the C standard
guarantees that gets done implicitly - and letting the compile do that
decreases the size of the kernel image.

> -/* XXX Kludge alert: agpgart isn't ready for multiple bridges yet */
>  struct agp_bridge_data *agp_alloc_bridge(void)
>  {
> -	return agp_bridge;
> +	struct  agp_bridge_data *bridge = kmalloc(sizeof(struct agp_bridge_data), 
> GFP_KERNEL);
> +	if(!agp_count) agp_bridge = bridge;
> +	return bridge;
>  }

Some style problems here - never create lines longer than 80
charactersm, and follow Documentation/CodingStyle indentation (or just
look at the other agpgart code).

Also you should check the kmalloc return value;

It should look like:

struct agp_bridge_data *agp_alloc_bridge(void)
{
	struct agp_bridge_data *bridge;

	bridge = kmalloc(sizeof(*bridge), GFP_KERNEL);
	if (!bridge)
		return NULL;

	/* cludge for the transition to passing the agp_bridge around */
	if (!agp_count)
		agp_bridge = bridge;

	return bridge;
}

Also where do you free the kmalloced bridges again?

> +	if(!agp_count) {

	if (!agp_count) {

> +	if(!agp_count) {

Dito.

>  	memset(info, 0, sizeof(struct agp_kern_info));
> -	if (!agp_bridge || agp_bridge->type == NOT_SUPPORTED ||
> -	    !agp_bridge->version) {
> +	if ((agp_bridge == NULL) || (agp_bridge->type == NOT_SUPPORTED)) {

Why do you drop the version check here?

