Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265050AbUD3DeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265050AbUD3DeS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 23:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265052AbUD3DeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 23:34:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50080 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265050AbUD3DeJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 23:34:09 -0400
Date: Fri, 30 Apr 2004 04:34:08 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Michael Brown <mebrown@michaels-house.net>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com,
       michael_e_brown@dell.com
Subject: Re: [PATCH 2.4] add SMBIOS information to /proc/smbios -- UPDATED
Message-ID: <20040430033408.GR17014@parcelfarce.linux.theplanet.co.uk>
References: <1083291712.1203.2914.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083291712.1203.2914.camel@debian>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 09:21:52PM -0500, Michael Brown wrote:
> +	u32 fp = 0xF0000;
> +	while (fp < 0xFFFFF) {
> +		isa_memcpy_fromio(table_eps, fp, sizeof(*table_eps));
> +		if (memcmp(table_eps->anchor, "_SM_", 4)==0 &&
> +					checksum_eps(table_eps)) {
> +			return 0;
> +		}
> +		fp += 16;
> +	}

Stilistic note:
	for (fp = 0xf0000; fp < 0xfffff; fp += 16) {
		isa_memcpy_fromio(table_eps, fp, sizeof(*table_eps));
		if (memcmp(table_eps->anchor, "_SM_", 4) != 0)
			continue;
		if (checksum_eps(table_eps))
			return 0;
	}

> +	while(keep_going && ((ptr - buf) <= max_length) && count < max_count){
> +		if (ptr[0] == 0x7F)   /* ptr[0] is type */
> +			keep_going = 0;
> +
> +		ptr += ptr[1]; /* ptr[1] is length, skip structure */
> +		/* skip strings at end of structure */
> +		while((ptr-buf) < max_length && (ptr[0] || ptr[1]))
> +			++ptr;

It looks like an off-by-one - if ptr reaches buf + max_length - 1, ptr[1]
appears to be beyond the area it's OK to dereference.

> +                size_t count, loff_t *ppos)
> +{
> +	unsigned long origppos = *ppos;
> +	unsigned long max_off = the_smbios_device.smbios_table_real_length;
> +	u8 *ptr;
> +
> +	if(*ppos >= max_off)
> +		return 0;

Note that *ppos is signed here.  llseek() to negative and you've got a problem.

> +	while (*ppos < max_off) {
> +		put_user(readb(ptr + *ppos), buf);
> +		++(*ppos); ++buf;
> +	}

Eeek...

	a) that's called copy_to_user()
	b) you'd better check the return value (either of put_user() or
copy_to_user()).
