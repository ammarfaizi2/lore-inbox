Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265639AbTFXCpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 22:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265641AbTFXCpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 22:45:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9859 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265639AbTFXCpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 22:45:52 -0400
Date: Tue, 24 Jun 2003 03:59:59 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] nbd driver for 2.5+: enhanced diagnostics support
Message-ID: <20030624025959.GO6754@parcelfarce.linux.theplanet.co.uk>
References: <3EF7B1C1.5040502@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF7B1C1.5040502@aros.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 08:04:49PM -0600, Lou Langholtz wrote:
> This third patch (for enhancing diagnostics support) applies 
> incrementally after my last LKML'd patch (for cosmetic changes). These 
> changes introduce configurable KERN_DEBUG level printk output for a 
> variety of different things that the driver does and provides the 
> framework for enhanced future debugging support as well.
> 
> As always, comments welcome!

> +	case BLKROSET: return "set-read-only";
> +	case BLKROGET: return "get-read-only";
> +	case BLKGETSIZE: return "block-get-size";
> +	case BLKFLSBUF: return "flush-buffer-cache";

The last 4 never make it to the driver (nor should they, being generic
ioctls).

> +	reply.magic = ntohl(reply.magic);
> +	if (reply.magic != NBD_REPLY_MAGIC) {
> +		printk(KERN_ERR "%s: Wrong magic (0x%lx)\n",
> +				lo->disk->disk_name,
> +				(unsigned long)reply.magic);

> +	reply.error = ntohl(reply.error);
> +	if (reply.error) {
> +		printk(KERN_ERR "%s: Other side returned error (%d)\n",
> +				lo->disk->disk_name, reply.error);

Generally a bad taste - it's harmless in this case, but such endianness
conversions in place are asking for trouble.

>  	lo->refcnt--;
> +	dprintk(DBG_RELEASE, "%s: %s refcnt=%d\n", lo->disk->disk_name,
> +			__FUNCTION__, lo->refcnt);
>  	/* N.B. Doesn't lo->file need an fput?? */
>  	return 0;

a) please, lose __FUNCTION__ - using it in macros is one thing, but
directly in a function that got a name shorter than `__FUNCTION__'?

b) no, it doesn't.

c) ->refcnt is never used.  How about losing it completely?  Along with
->open() and ->release()...

>  		sreq.flags = REQ_SPECIAL;
>  		nbd_cmd(&sreq) = NBD_CMD_DISC;

;-/

> +		sreq.sector = 0;
> +		sreq.nr_sectors = 0;

Umm... What for?

>  	if (sizeof(struct nbd_request) != 28) {
> -		printk(KERN_CRIT "Sizeof nbd_request needs to be 28 in order to work!\n" );
> +		printk(KERN_CRIT "nbd: Sizeof nbd_request needs to be 28 in order to work!\n" );
>  		return -EIO;
>  	}

FWIW, I'm less than sure that struct nbd_request is worth defining.
We use it in two places - the check above and nbd_send_req() where
it is filled and then its address is cast to char *.  It might be
better to use u32[7] directly and forget about all alignment issues.
Hell knows...  In this situation I would probably just define an
enum for offsets and be done with that.  Same goes for nbd_reply.
