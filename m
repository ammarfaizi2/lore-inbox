Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWDJWrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWDJWrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 18:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWDJWrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 18:47:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4060 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932151AbWDJWrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 18:47:09 -0400
Date: Mon, 10 Apr 2006 14:46:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/7] tpm: reorganize sysfs files - Updated patch
Message-Id: <20060410144623.110895d0.akpm@osdl.org>
In-Reply-To: <1144679825.4917.10.camel@localhost.localdomain>
References: <1144679825.4917.10.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kylene Jo Hall <kjhall@us.ibm.com> wrote:
>
>  ssize_t tpm_show_pcrs(struct device *dev, struct device_attribute *attr,
>   		      char *buf)
>   {
>  -	u8 data[READ_PCR_RESULT_SIZE];
>  -	ssize_t len;
>  +	u8 data[30];
>  +	ssize_t rc;
>   	int i, j, num_pcrs;
>   	__be32 index;
>   	char *str = buf;
>  @@ -150,29 +190,24 @@ ssize_t tpm_show_pcrs(struct device *dev
>   	if (chip == NULL)
>   		return -ENODEV;
>   
>  -	memcpy(data, cap_pcr, sizeof(cap_pcr));
>  -	if ((len = tpm_transmit(chip, data, sizeof(data)))
>  -	    < CAP_PCR_RESULT_SIZE) {
>  -		dev_dbg(chip->dev, "A TPM error (%d) occurred "
>  -				"attempting to determine the number of PCRS\n",
>  -			be32_to_cpu(*((__be32 *) (data + 6))));
>  +	memcpy(data, tpm_cap, sizeof(tpm_cap));

I'd be a bit worried about potential for array overruns here.  If someone
later were to increase the size of tpm_cap[] we'll silently overrun data[].

One approach would be to do:

--- devel/drivers/char/tpm/tpm.c~tpm-reorganize-sysfs-files-fix	2006-04-10 14:43:16.000000000 -0700
+++ devel-akpm/drivers/char/tpm/tpm.c	2006-04-10 14:45:19.000000000 -0700
@@ -180,7 +180,7 @@ static const u8 pcrread[] = {
 ssize_t tpm_show_pcrs(struct device *dev, struct device_attribute *attr,
 		      char *buf)
 {
-	u8 data[30];
+	u8 data[ARRAY_SIZE(tpm_cap)];
 	ssize_t rc;
 	int i, j, num_pcrs;
 	__be32 index;
@@ -296,7 +296,7 @@ static const u8 cap_version[] = {
 ssize_t tpm_show_caps(struct device *dev, struct device_attribute *attr,
 		      char *buf)
 {
-	u8 data[30];
+	u8 data[max(ARRAY_SIZE(tpm_cap), ARRAY_SIZE(cap_version))];
 	ssize_t rc;
 	char *str = buf;
 
_


Does that look OK?
