Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263517AbUD2Fuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbUD2Fuc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 01:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUD2Fuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 01:50:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50053 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263517AbUD2Fua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 01:50:30 -0400
Date: Thu, 29 Apr 2004 06:50:28 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Michael Brown <mebrown@michaels-house.net>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com,
       michael_e_brown@dell.com
Subject: Re: [PATCH 2.4] add SMBIOS information to /proc/smbios/
Message-ID: <20040429055028.GH17014@parcelfarce.linux.theplanet.co.uk>
References: <1083217173.1198.2876.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083217173.1198.2876.camel@debian>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 12:39:33AM -0500, Michael Brown wrote:
> +smbios_read_table_entry_point(char *page, char **start,
> +				off_t off, int count,
> +				int *eof, void *data)
> +{
> +	unsigned int max_off = sizeof(the_smbios_device.table_eps);
> +	MOD_INC_USE_COUNT;
> +
> +	memcpy(page, &the_smbios_device.table_eps, max_off);
> +
> +	MOD_DEC_USE_COUNT;
> +	return max_off;
> +}

*LART*

Use ->owner instead of (racy) messing with MOD_{INC,DEC}_USE_COUNT.

> +/* Use the more flexible procfs style. We tell the core that we can handle
> + * >4k transactions by setting *start. When doing this we also have to handle
> + * our own *eof and make sure not to overrun the page or count given.
> + */
> +static ssize_t
> +smbios_read_table(char *page, char **start,
> +		off_t offset, int count,
> +		int *eof, void *data)
> +{
> +	u8 *buf;
> +	int i = 0;
> +	int max_off = the_smbios_device.smbios_table_real_length;
> +	MOD_INC_USE_COUNT;
> +
> +	if (offset > max_off)
> +		return 0;
> +
> +	if (count > (max_off - offset))
> +		count = max_off - offset;
> +
> +	buf = ioremap(the_smbios_device.table_eps.table_address, max_off);
> +	if (buf == NULL)
> +		return -ENXIO;
> +
> +	/* memcpy( buffer, buf+pos, count ); */
> +	for (i = 0; i < count; ++i) {
> +		page[i] = readb( buf+offset+i );
> +	}
> +
> +	iounmap(buf);
> +
> +	*start = page; /* tells procfs that we handle >1 page */
> +	MOD_DEC_USE_COUNT;
> +	return count;
> +}

... and the reason why you need to go through procfs default ->read()
instead of providing an obvious one of your own would be...?  Note that
it would be smaller and simpler than your callback above.
