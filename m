Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWDKXFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWDKXFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 19:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWDKXFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 19:05:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:7389 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751340AbWDKXFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 19:05:05 -0400
Date: Tue, 11 Apr 2006 16:05:05 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>,
       Leendert Van Doorn <leendert@us.ibm.com>
Subject: Re: [PATCH 7/7] tpm: Driver for next generation TPM chips
Message-ID: <20060411230505.GB21210@us.ibm.com>
References: <1144679848.4917.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144679848.4917.15.camel@localhost.localdomain>
X-Operating-System: Linux 2.6.16-i386 (i686)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.04.2006 [09:37:28 -0500], Kylene Jo Hall wrote:
> This patch contains the driver for the next generation of TPM chips
> version 1.2 including support for interrupts.  The Trusted Computing
> Group has written the TPM Interface Specification (TIS) which defines a
> common interface for all manufacturer's 1.2 TPM's thus the name
> tpm_tis.
> 
> This updated version of the patch uses the new sysfs files that came
> about from the comments and changes in patch 6/7.  It replaces the 7/7
> patch from the original set.

<snip>

> +static int request_locality(struct tpm_chip *chip, int l)
> +{
> +	unsigned long stop;
> +
> +	if (check_locality(chip, l) >= 0)
> +		return l;
> +
> +	iowrite8(TPM_ACCESS_REQUEST_USE,
> +		 chip->vendor.iobase + TPM_ACCESS(l));
> +
> +	if (chip->vendor.irq) {
> +		interruptible_sleep_on_timeout(&chip->vendor.int_queue,
> +					       HZ *
> +					       chip->vendor.timeout_a /
> +					       1000);
> +		if (check_locality(chip, l) >= 0)
> +			return l;
> +
> +	} else {
> +		/* wait for burstcount */
> +		stop = jiffies + (HZ * chip->vendor.timeout_a / 1000);
> +		do {
> +			if (check_locality(chip, l) >= 0)
> +				return l;
> +			msleep(TPM_TIMEOUT);
> +		}
> +		while (time_before(jiffies, stop));
> +	}

This looks like it could take the msecs_to_jiffies() conversion as well.
Might as well cache it before the if/else, as both clauses use it?
Really, it is just wait_event*() without the wait-queue. Well, this is
at least one more consumer potentially of the poll_event*() API I had
written a while back, I'll dust it off again if I have the time.

<snip>

> +static int get_burstcount(struct tpm_chip *chip)
> +{
> +	unsigned long stop;
> +	int burstcnt;
> +
> +	/* wait for burstcount */
> +	/* which timeout value, spec has 2 answers (c & d) */
> +	stop = jiffies + (HZ * chip->vendor.timeout_d / 1000);

msecs_to_jiffies().

<snip>

With the changes you've already made, that should clean up the sleeping
code a bit, at least.

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
