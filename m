Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWERX4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWERX4A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWERX4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:56:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:39384 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751227AbWERX4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:56:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=bqb3lkaSb0R0ow1EFUpER1/14uKBhNr9FLEu+If/B1Wbh92T8O9XHCDgCR28vZ9sXNyFhQ81QWUbmRrWAj4wbp3XtaCIDdZDHHQHZIXM1NwJQ6gVebT1UHKF9Xt4rO/d9PHIidfvjapgExFV9laBpHFcoUPF4NvWWLsirvQWThE=
Date: Fri, 19 May 2006 03:54:23 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Seiji Munetoh <seiji.munetoh@gmail.com>
Cc: linux-kernel@vger.kernel.org, kjhall@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2] tpm: bios log parsing fixes
Message-ID: <20060518235423.GA5566@mipter.zuzino.mipt.ru>
References: <1147994863.14102.65.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147994863.14102.65.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 08:27:43AM +0900, Seiji Munetoh wrote:
> This patch fixes "tcpa_pc_event" misalignment between enum, strings and
> TCG PC spec and output of the event contains a hash data.

> --- linux-2.6.17-rc4/drivers/char/tpm/tpm_bios.c
> +++ linux-2.6.17-rc4-tpm/drivers/char/tpm/tpm_bios.c
> @@ -105,6 +105,12 @@ static const char* tcpa_event_type_strin
>  	"Non-Host Info"
>  };
>  
> +struct tcpa_pc_event {
> +	u32 event_id;
> +	u32 event_size;
> +	u8 event_data[0];
> +};
> +
>  enum tcpa_pc_event_ids {
>  	SMBIOS = 1,
>  	BIS_CERT,
> @@ -114,14 +120,16 @@ enum tcpa_pc_event_ids {
>  	NVRAM,
>  	OPTION_ROM_EXEC,
>  	OPTION_ROM_CONFIG,
> +	UNUSED2,

Damn true. Comment, that it corresponds to "" before "Option ROM
microcode", should not harm.

Why aren't event_id's of proper type asking for removal every time
someone greps for tcpa_pc_event_ids?

>  	OPTION_ROM_MICROCODE,
>  	S_CRTM_VERSION,
>  	S_CRTM_CONTENTS,
>  	POST_CONTENTS,
> +	HOST_TABLE_OF_DEVICES,
>  };
>  
>  static const char* tcpa_pc_event_id_strings[] = {
> -	""
> +	"",
>  	"SMBIOS",
>  	"BIS Certificate",
>  	"POST BIOS ",
> @@ -130,11 +138,12 @@ static const char* tcpa_pc_event_id_stri
>  	"NVRAM",
>  	"Option ROM",
>  	"Option ROM config",
> -	"Option ROM microcode",
> +	"",
> +	"Option ROM microcode ",
>  	"S-CRTM Version",
> -	"S-CRTM Contents",
> -	"S-CRTM POST Contents",
> -	"POST Contents",
> +	"S-CRTM Contents ",
> +	"POST Contents ",
		      ^
Seems gratious, really needed?

> +	"Table of Devices",
>  };
>  
>  /* returns pointer to start of pos. entry of tcg log */
> @@ -206,7 +215,7 @@ static int get_event_name(char *dest, st
>  	const char *name = "";
>  	char data[40] = "";
>  	int i, n_len = 0, d_len = 0;
> -	u32 event_id;
> +	struct tcpa_pc_event *pc_event;
>  
>  	switch(event->event_type) {
>  	case PREBOOT:
> @@ -235,31 +244,32 @@ static int get_event_name(char *dest, st
>  		}
>  		break;
>  	case EVENT_TAG:
> -		event_id = be32_to_cpu(*((u32 *)event_entry));
> +		pc_event = (struct tcpa_pc_event *)event_entry;
>  
>  		/* ToDo Row data -> Base64 */
>  
> -		switch (event_id) {
> +		switch (pc_event->event_id) {
>  		case SMBIOS:
>  		case BIS_CERT:
>  		case CMOS:
>  		case NVRAM:
>  		case OPTION_ROM_EXEC:
>  		case OPTION_ROM_CONFIG:
> -		case OPTION_ROM_MICROCODE:
>  		case S_CRTM_VERSION:
> -		case S_CRTM_CONTENTS:
> -		case POST_CONTENTS:
> -			name = tcpa_pc_event_id_strings[event_id];
> +			name = tcpa_pc_event_id_strings[pc_event->event_id];
>  			n_len = strlen(name);
>  			break;
> +		/* hash data */
>  		case POST_BIOS_ROM:
>  		case ESCD:
> -			name = tcpa_pc_event_id_strings[event_id];
> +		case OPTION_ROM_MICROCODE:
> +		case S_CRTM_CONTENTS:
> +		case POST_CONTENTS:
> +			name = tcpa_pc_event_id_strings[pc_event->event_id];
>  			n_len = strlen(name);
>  			for (i = 0; i < 20; i++)
> -				d_len += sprintf(data, "%02x",
> -						event_entry[8 + i]);
> +				d_len += sprintf(&data[2*i], "%02x",
> +						pc_event->event_data[i]);
>  			break;
>  		default:
>  			break;

