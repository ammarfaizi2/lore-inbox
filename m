Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbTIYQKT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 12:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTIYQKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 12:10:19 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:26117 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261336AbTIYQKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 12:10:13 -0400
Date: Thu, 25 Sep 2003 17:10:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: Pauline Middelink <middelink@polyware.nl>, linux-kernel@vger.kernel.org,
       kraxel@bytesex.org
Subject: Re: zr36120 2.6.x port (was: Re: [Mjpeg-users] DC30+ can't capture size greater than 224x168)
Message-ID: <20030925171010.A17271@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ronald Bultje <rbultje@ronald.bitfreak.net>,
	Pauline Middelink <middelink@polyware.nl>,
	linux-kernel@vger.kernel.org, kraxel@bytesex.org
References: <BAY7-F62oStVwgTlLlJ0001924a@hotmail.com> <1064478814.2220.326.camel@shrek.bitfreak.net> <20030925084932.GA22441@polyware.nl> <1064484678.2227.465.camel@shrek.bitfreak.net> <20030925102635.GA25634@polyware.nl> <1064505583.2228.716.camel@shrek.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1064505583.2228.716.camel@shrek.bitfreak.net>; from rbultje@ronald.bitfreak.net on Thu, Sep 25, 2003 at 05:59:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 05:59:44PM +0200, Ronald Bultje wrote:
> +	if (!try_module_get(THIS_MODULE)) {
> +		printk(KERN_ERR "failed to acquire lock on myself\n");
> +		return -EIO;
> +	}

This is broken, you need an owner outside the open routine.

> +
> +	/* find the device */
> +	for (i = 0; i < zoran_cards; i++) {
> +		if (zorans[i].video_dev->minor == minor) {
> +			ztv = &zorans[i];
> +			break;
> +		}
> +	}

What serializes this?

> +	if (ztv->have_decoder &&
> +	    !try_module_get(ztv->decoder->driver->owner)) {
> +		printk(KERN_ERR "Failed to acquire lock on TV decoder\n");
> +		module_put(THIS_MODULE);
> +		return -EIO;
> +	} 
> +	if (ztv->have_tuner &&
> +	    !try_module_get(ztv->tuner->driver->owner)) {
> +		printk(KERN_ERR "Failed to acquire lock on TV tuner\n");
> +		if (ztv->have_decoder)
> +			module_put(ztv->decoder->driver->owner);
> +		module_put(THIS_MODULE);
> +		return -EIO;
> +	}

You probably want to add a few gotos to unwind at the end of the
function with less code deuplication..

