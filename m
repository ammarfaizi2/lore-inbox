Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWDKOYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWDKOYG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 10:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWDKOYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 10:24:06 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:27882 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750853AbWDKOYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 10:24:05 -0400
Subject: Re: [PATCH 2/7] tpm: reorganize sysfs files - Updated patch
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
In-Reply-To: <20060410144623.110895d0.akpm@osdl.org>
References: <1144679825.4917.10.camel@localhost.localdomain>
	 <20060410144623.110895d0.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 09:24:54 -0500
Message-Id: <1144765495.4917.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-10 at 14:46 -0700, Andrew Morton wrote:
> Kylene Jo Hall <kjhall@us.ibm.com> wrote:
> >
> >  ssize_t tpm_show_pcrs(struct device *dev, struct device_attribute *attr,
> >   		      char *buf)
> >   {
> >  -	u8 data[READ_PCR_RESULT_SIZE];
> >  -	ssize_t len;
> >  +	u8 data[30];
> >  +	ssize_t rc;
> >   	int i, j, num_pcrs;
> >   	__be32 index;
> >   	char *str = buf;
> >  @@ -150,29 +190,24 @@ ssize_t tpm_show_pcrs(struct device *dev
> >   	if (chip == NULL)
> >   		return -ENODEV;
> >   
> >  -	memcpy(data, cap_pcr, sizeof(cap_pcr));
> >  -	if ((len = tpm_transmit(chip, data, sizeof(data)))
> >  -	    < CAP_PCR_RESULT_SIZE) {
> >  -		dev_dbg(chip->dev, "A TPM error (%d) occurred "
> >  -				"attempting to determine the number of PCRS\n",
> >  -			be32_to_cpu(*((__be32 *) (data + 6))));
> >  +	memcpy(data, tpm_cap, sizeof(tpm_cap));
> 
> I'd be a bit worried about potential for array overruns here.  If someone
> later were to increase the size of tpm_cap[] we'll silently overrun data[].
> 
> One approach would be to do:
> 
> --- devel/drivers/char/tpm/tpm.c~tpm-reorganize-sysfs-files-fix	2006-04-10 14:43:16.000000000 -0700
> +++ devel-akpm/drivers/char/tpm/tpm.c	2006-04-10 14:45:19.000000000 -0700
> @@ -180,7 +180,7 @@ static const u8 pcrread[] = {
>  ssize_t tpm_show_pcrs(struct device *dev, struct device_attribute *attr,
>  		      char *buf)
>  {
> -	u8 data[30];
> +	u8 data[ARRAY_SIZE(tpm_cap)];
>  	ssize_t rc;
>  	int i, j, num_pcrs;
>  	__be32 index;
> @@ -296,7 +296,7 @@ static const u8 cap_version[] = {
>  ssize_t tpm_show_caps(struct device *dev, struct device_attribute *attr,
>  		      char *buf)
>  {
> -	u8 data[30];
> +	u8 data[max(ARRAY_SIZE(tpm_cap), ARRAY_SIZE(cap_version))];
>  	ssize_t rc;
>  	char *str = buf;
>  
> _
> 
> 
> Does that look OK?

No this is not ok because in several of these cases the response to the
command is longer than tpm_cap thus the reason for the hardcoded size.
I can put in a max function though that compares the size of the
response and the tpm_cap.  The read functions will make sure the
response does not overflow the buffer should that length ever change in
the future.

Thanks,
Kylie

