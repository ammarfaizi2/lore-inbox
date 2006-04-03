Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWDCQyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWDCQyp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWDCQyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:54:45 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:52136 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932157AbWDCQyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:54:44 -0400
Subject: Re: [PATCH 2/7] tpm: reorganize sysfs files
From: Dave Hansen <haveblue@us.ibm.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>,
       Marcel Selhorst <selhorst@crypto.rub.de>
In-Reply-To: <1144082547.29910.8.camel@localhost.localdomain>
References: <1143823488.2992.166.camel@localhost.localdomain>
	 <1144082547.29910.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 09:54:02 -0700
Message-Id: <1144083243.9731.140.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 11:42 -0500, Kylene Jo Hall wrote:
>  ssize_t tpm_show_pcrs(struct device *dev, struct device_attribute *attr,
>  		      char *buf)
>  {
> -	u8 data[READ_PCR_RESULT_SIZE];
> +	u8 data[30];

Is this correct?  Are you guaranteed that this data read will never,
ever exceed 30 bytes?  Any reason it shouldn't be a variable?

>  	ssize_t len;
>  	int i, j, num_pcrs;
>  	__be32 index;
> @@ -150,26 +659,28 @@ ssize_t tpm_show_pcrs(struct device *dev
>  	if (chip == NULL)
>  		return -ENODEV;
>  
> -	memcpy(data, cap_pcr, sizeof(cap_pcr));
> +	memcpy(data, tpm_cap, sizeof(tpm_cap));
> +	data[TPM_CAP_IDX] = TPM_CAP_PROP;
> +	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_PROP_PCR;
> +
>  	if ((len = tpm_transmit(chip, data, sizeof(data)))
> -	    < CAP_PCR_RESULT_SIZE) {
> +	    <= TPM_ERROR_SIZE) {
>  		dev_dbg(chip->dev, "A TPM error (%d) occurred "
> -				"attempting to determine the number of PCRS\n",
> -			be32_to_cpu(*((__be32 *) (data + 6))));
> +			"attempting to determine the number of PCRS\n",
> +			be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));
>  		return 0;
>  	}

I know this is old code, but I see this little 

	be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));

snippet at least twice.  It is also a bit hard to read.  Seems likt it
would be a great candidate for a little helper function.

Come to think of it, that entire if() sequence appears to be repeated
quite a few times.

>  	num_pcrs = be32_to_cpu(*((__be32 *) (data + 14)));
> -
>  	for (i = 0; i < num_pcrs; i++) {
>  		memcpy(data, pcrread, sizeof(pcrread));
>  		index = cpu_to_be32(i);
>  		memcpy(data + 10, &index, 4);
>  		if ((len = tpm_transmit(chip, data, sizeof(data)))
> -		    < READ_PCR_RESULT_SIZE){
> +		    <= TPM_ERROR_SIZE) {
>  			dev_dbg(chip->dev, "A TPM error (%d) occurred"
>  				" attempting to read PCR %d of %d\n",
> -				be32_to_cpu(*((__be32 *) (data + 6))),
> +				be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))),
>  				i, num_pcrs);
>  			goto out;
>  		}
> @@ -208,11 +724,11 @@ ssize_t tpm_show_pubek(struct device *de
>  
>  	memcpy(data, readpubek, sizeof(readpubek));
>  
> -	if ((len = tpm_transmit(chip, data, READ_PUBEK_RESULT_SIZE)) <
> -	    READ_PUBEK_RESULT_SIZE) {
> +	if ((len = tpm_transmit(chip, data, READ_PUBEK_RESULT_SIZE)) <=
> +	    TPM_ERROR_SIZE) {
>  		dev_dbg(chip->dev, "A TPM error (%d) occurred "
> -				"attempting to read the PUBEK\n",
> -			    be32_to_cpu(*((__be32 *) (data + 6))));
> +			"attempting to read the PUBEK\n",
> +			be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));
>  		rc = 0;
>  		goto out;
>  	}
> @@ -250,29 +284,20 @@ out:
>  }
>  EXPORT_SYMBOL_GPL(tpm_show_pubek);
>  
> -#define CAP_VER_RESULT_SIZE 18
> +#define CAP_VERSION_1_1 6
> +#define CAP_VERSION_IDX 13
>  static const u8 cap_version[] = {
>  	0, 193,			/* TPM_TAG_RQU_COMMAND */
>  	0, 0, 0, 18,		/* length */
>  	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
> -	0, 0, 0, 6,
> +	0, 0, 0, 0,
>  	0, 0, 0, 0
>  };
>  
> -#define CAP_MANUFACTURER_RESULT_SIZE 18
> -static const u8 cap_manufacturer[] = {
> -	0, 193,			/* TPM_TAG_RQU_COMMAND */
> -	0, 0, 0, 22,		/* length */
> -	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
> -	0, 0, 0, 5,
> -	0, 0, 0, 4,
> -	0, 0, 1, 3
> -};
> -
>  ssize_t tpm_show_caps(struct device *dev, struct device_attribute *attr,
>  		      char *buf)
>  {
> -	u8 data[sizeof(cap_manufacturer)];
> +	u8 data[30];
>  	ssize_t len;
>  	char *str = buf;
>  
> @@ -282,26 +793,37 @@ ssize_t tpm_show_caps(struct device *dev
>  	if (chip == NULL)
>  		return -ENODEV;
>  
> -	memcpy(data, cap_manufacturer, sizeof(cap_manufacturer));
> +	memcpy(data, tpm_cap, sizeof(tpm_cap));
> +	data[TPM_CAP_IDX] = TPM_CAP_PROP;
> +	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_PROP_MANUFACTURER;
>  
> -	if ((len = tpm_transmit(chip, data, sizeof(data))) <
> -	    CAP_MANUFACTURER_RESULT_SIZE)
> -		return len;
> +	if ((len = tpm_transmit(chip, data, sizeof(data))) <=
> +	    TPM_ERROR_SIZE) {
> +		dev_dbg(chip->dev, "A TPM error (%d) occurred "
> +			"attempting to determine the manufacturer\n",
> +			be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));
> +		return 0;
> +	}

Since you're going through and modifying these, it might be nice to
change them to the more normal (and readable) style of 


	len = tpm_transmit(chip, data, sizeof(data));
	if (len < CAP_MANUFACTURER_RESULT_SIZE)
		return len;

Note that that doesn't even increase the number of lines of code.

-- Dave

