Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWDCVsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWDCVsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 17:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWDCVsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 17:48:17 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:2448 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932376AbWDCVsQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 17:48:16 -0400
Date: Mon, 3 Apr 2006 14:47:25 -0700
From: Greg KH <greg@kroah.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>,
       Marcel Selhorst <selhorst@crypto.rub.de>
Subject: Re: PATCH 6/7] tpm: new 1.2 sysfs files
Message-ID: <20060403214725.GA29414@kroah.com>
References: <1143823501.2992.170.camel@localhost.localdomain> <20060331202714.GC22987@sergelap.austin.ibm.com> <1144082562.29910.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144082562.29910.12.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 11:42:41AM -0500, Kylene Jo Hall wrote:
> +ssize_t tpm_show_state(struct device * dev, struct device_attribute * attr,
> +		       char *buf)
> +{
> +	u8 data[35];
> +	ssize_t len;
> +	char *str = buf;
> +
> +	struct tpm_chip *chip = dev_get_drvdata(dev);
> +	if (chip == NULL)
> +		return -ENODEV;
> +
> +	memcpy(data, tpm_cap, sizeof(tpm_cap));
> +	data[TPM_CAP_IDX] = TPM_CAP_FLAG;
> +	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_FLAG_PERM;
> +
> +	if ((len = tpm_transmit(chip, data, sizeof(data)))
> +	    <= TPM_ERROR_SIZE)
> +		dev_dbg(chip->dev, "A TPM error (%d) occurred "
> +			"attempting to determine the permanent state\n",
> +			be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));
> +	else {
> +		str +=
> +		    sprintf(str, "%s\n",
> +			    (data[TPM_GET_CAP_PERM_DISABLE_IDX] ==
> +			     1) ? "Disabled" : "Enabled");
> +		str +=
> +		    sprintf(str, "%s\n",
> +			    (data[TPM_GET_CAP_PERM_INACTIVE_IDX] ==
> +			     1) ? "Inactive" : "Active");
> +	}
> +	memcpy(data, tpm_cap, sizeof(tpm_cap));
> +	data[TPM_CAP_IDX] = TPM_CAP_PROP;
> +	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_PROP_OWNER;
> +
> +	if ((len = tpm_transmit(chip, data, sizeof(data)))
> +	    <= TPM_ERROR_SIZE)
> +		dev_dbg(chip->dev, "A TPM error (%d) occurred "
> +			"attempting to determine the owner state\n",
> +			be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));
> +	else
> +		str +=
> +		    sprintf(str, "%s\n",
> +			    (data[TPM_GET_CAP_RET_BOOL_1_IDX] ==
> +			     1) ? "Owned" : "Unowned");
> +
> +	memcpy(data, tpm_cap, sizeof(tpm_cap));
> +	data[TPM_CAP_IDX] = TPM_CAP_FLAG;
> +	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_FLAG_VOL;
> +
> +	if ((len = tpm_transmit(chip, data, sizeof(data)))
> +	    <= TPM_ERROR_SIZE) {
> +		dev_dbg(chip->dev, "A TPM error (%d) occurred "
> +			"attempting to determine the temporary state\n",
> +			be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));
> +		goto out;
> +	}
> +
> +	if (data[TPM_GET_CAP_TEMP_INACTIVE_IDX] != 0)
> +		str += sprintf(str, "Deactivated for this boot\n");
> +out:
> +	return str - buf;
> +}
> +EXPORT_SYMBOL_GPL(tpm_show_state);

That is more than one value per file.  Please make unique files for the
different capabilities.  As it stands the file doesn't make too much
sense for someone reading it and not understanding that each line is a
different portion of the state.

thanks,

greg k-h
