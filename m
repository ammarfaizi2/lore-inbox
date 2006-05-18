Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWERX7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWERX7Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWERX7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:59:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:51933 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751253AbWERX7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:59:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=r2803Lqdo44KkQRrvqgSAKsbo8i2jAtMawN3nZ3rQlaRdmGo1pCGE7JLS/h8gCu6jARJDHw5FUe+sOL83PhY30WSK0WJqG7k647FkkzQQ7CuKyCa/PA3LHg5Ch1olfalTc1q7mN8O85ic5V2i3roSUzXX4jF5J/LPhyfswggb3E=
Date: Fri, 19 May 2006 03:57:45 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Seiji Munetoh <seiji.munetoh@gmail.com>
Cc: linux-kernel@vger.kernel.org, kjhall@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/2] tpm: bios log parsing fixes
Message-ID: <20060518235744.GB5566@mipter.zuzino.mipt.ru>
References: <1147994947.14102.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147994947.14102.68.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 08:29:07AM +0900, Seiji Munetoh wrote:
> This patch fixes the BINARY output format to actual ACPI TCPA log
> structure for any userland tool easily parse the binary data with
> reference to TCG PC specification.

Do you realize that you break backward compatibility? What was wrong
with old format?

> --- linux-2.6.17-rc4/drivers/char/tpm/tpm_bios.c
> +++ linux-2.6.17-rc4-tpm/drivers/char/tpm/tpm_bios.c
> @@ -275,53 +285,13 @@ static int get_event_name(char *dest, st
>  
>  static int tpm_binary_bios_measurements_show(struct seq_file *m, void
> *v)
>  {
> -
> -	char *eventname;
> -	char data[4];
> -	u32 help;
> -	int i, len;
>  	struct tcpa_event *event = (struct tcpa_event *) v;
> -	unsigned char *event_entry =
> -	    (unsigned char *) (v + sizeof(struct tcpa_event));
> -
> -	eventname = kmalloc(MAX_TEXT_EVENT, GFP_KERNEL);
> -	if (!eventname) {
> -		printk(KERN_ERR "%s: ERROR - No Memory for event name\n ",
> -		       __func__);
> -		return -ENOMEM;
> -	}
> -
> -	/* 1st: PCR used is in little-endian format (4 bytes) */
> -	help = le32_to_cpu(event->pcr_index);
> -	memcpy(data, &help, 4);
> -	for (i = 0; i < 4; i++)
> -		seq_putc(m, data[i]);
> -
> -	/* 2nd: SHA1 (20 bytes) */
> -	for (i = 0; i < 20; i++)
> -		seq_putc(m, event->pcr_value[i]);
> +	char *data = (char *) v;
> +	int i;
>  
> -	/* 3rd: event type identifier (4 bytes) */
> -	help = le32_to_cpu(event->event_type);
> -	memcpy(data, &help, 4);
> -	for (i = 0; i < 4; i++)
> +	for (i = 0;i < sizeof(struct tcpa_event) + event->event_size; i++)
>  		seq_putc(m, data[i]);
>  
> -	len = 0;
> -
> -	len += get_event_name(eventname, event, event_entry);
> -
> -	/* 4th:  filename <= 255 + \'0' delimiter */
> -	if (len > TCG_EVENT_NAME_LEN_MAX)
> -		len = TCG_EVENT_NAME_LEN_MAX;
> -
> -	for (i = 0; i < len; i++)
> -		seq_putc(m, eventname[i]);
> -
> -	/* 5th: delimiter */
> -	seq_putc(m, '\0');
> -
> -	kfree(eventname);
>  	return 0;
>  }

