Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbWD1FLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbWD1FLX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 01:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbWD1FLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 01:11:23 -0400
Received: from smtpout.mac.com ([17.250.248.176]:29902 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965167AbWD1FLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 01:11:22 -0400
In-Reply-To: <4450A183.6030405@de.ibm.com>
References: <4450A183.6030405@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <12A9A218-DC60-4944-892D-150DF2D88F0C@mac.com>
Cc: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 06/16] ehca: common include files
Date: Fri, 28 Apr 2006 01:11:11 -0400
To: Heiko J Schick <schihei@de.ibm.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 27, 2006, at 06:48:35, Heiko J Schick wrote:
> +#define EHCA_EDEB_TRACE_MASK_SIZE 32
> +extern u8 ehca_edeb_mask[EHCA_EDEB_TRACE_MASK_SIZE];
> +#define EDEB_ID_TO_U32(str4) (str4[3] | (str4[2] << 8) | (str4[1]  
> << 16) | \
> +			      (str4[0] << 24))
> +
> +inline static u64 ehca_edeb_filter(const u32 level,
> +				   const u32 id, const u32 line)
> +{
> +	u64 ret = 0;
> +	u32 filenr = 0;
> +	u32 filter_level = 9;
> +	u32 dynamic_level = 0;
> +
> +	/* This is code written for the gcc -O2 optimizer which should  
> colapse
> +	 * to two single ints filter_level is the first level kicked out by
> +	 * compiler means trace everythin below 6. */
> +	if (id == EDEB_ID_TO_U32("ehav")) {
> +		filenr = 0x01;
> +		filter_level = 8;
> +	}
> [...]

This whole mess should be a simpler with a table and a loop

struct edeb_filter_entry {
	u32 filenr;
	u32 filter_level;
};

# define EDEB_FILTER_ENTRY(name,nr,level) { .id = name, .filenr =  
nr, .filter_level = level }
static const struct edeb_filter_entry edeb_filter_table[] = {
	EDEB_FILTER_ENTRY("clas", 0x02, 8),
	[...]
};

Then just iterate over that table in a loop.  The end result is much  
smaller code and data, and much clearer as to intent as well.

Cheers,
Kyle Moffett

