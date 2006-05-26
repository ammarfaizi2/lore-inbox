Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWEZOpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWEZOpw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWEZOpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:45:52 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:6095 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750853AbWEZOpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:45:51 -0400
Subject: Re: [PATCH 2/2] tpm: bios log parsing fixes
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Seiji Munetoh <seiji.munetoh@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <1148654638.20195.41.camel@localhost.localdomain>
References: <1148654638.20195.41.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 26 May 2006 09:43:59 -0500
Message-Id: <1148654639.5317.205.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ack'ed-by: Kylene Hall <kjhall@us.ibm.com>

On Fri, 2006-05-26 at 23:43 +0900, Seiji Munetoh wrote:
> This patch changes the binary output format to actual ACPI TCPA log
> structure since the current format does not contain all event-data
> information that need to verify the PCRs in TPM. 
> tpm_binary_bios_measurements_show() uses get_event_name() to convert the
> binary event-data to ascii format, and puts them as binary. However, to
> verify the PCRs, the event-data must be a actual binary event-data used
> by SHA1 calc. in BIOS. 
> 
> So, I think actual ACPI TCPA log is good for this binary output format. 
> That way, any userland tools easily parse this data with reference to
> TCG PC specification.
> 
> Signed-off-by: Seiji Munetoh <seiji.munetoh@gmail.com>
> ---
> 
> --- linux-2.6.17-rc4/drivers/char/tpm/tpm_bios.c	2006-05-16
> 09:33:06.000000000 +0900
> +++ linux-2.6.17-rc4-tpm/drivers/char/tpm/tpm_bios.c	2006-05-24
> 07:11:44.000000000 +0900
> @@ -275,53 +284,13 @@ static int get_event_name(char *dest, st
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
>  
> 
> 
> 

