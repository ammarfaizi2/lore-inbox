Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWEZOpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWEZOpb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWEZOpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:45:31 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:15760 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750834AbWEZOpa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:45:30 -0400
Subject: Re: [PATCH 1/2] tpm: bios log parsing fixes
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Seiji Munetoh <seiji.munetoh@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <1148654605.20195.39.camel@localhost.localdomain>
References: <1148654605.20195.39.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 26 May 2006 09:43:38 -0500
Message-Id: <1148654618.5317.204.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACK'ed-by: Kylene Hall <kjhall@us.ibm.com>

On Fri, 2006-05-26 at 23:43 +0900, Seiji Munetoh wrote:
> This patch fixes "tcpa_pc_event" misalignment between enum, strings and
> TCG PC spec and output of the event which contains a hash data.
> 
> Signed-off-by: Seiji Munetoh <seiji.munetoh@gmail.com>
> ---
> 
> --- linux-2.6.17-rc4/drivers/char/tpm/tpm_bios.c	2006-05-16
> 09:33:06.000000000 +0900
> +++ linux-2.6.17-rc4-tpm/drivers/char/tpm/tpm_bios.c	2006-05-24
> 07:11:44.000000000 +0900
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
> @@ -114,14 +120,15 @@ enum tcpa_pc_event_ids {
>  	NVRAM,
>  	OPTION_ROM_EXEC,
>  	OPTION_ROM_CONFIG,
> -	OPTION_ROM_MICROCODE,
> +	OPTION_ROM_MICROCODE = 10,
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
> @@ -130,11 +137,12 @@ static const char* tcpa_pc_event_id_stri
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
> +	"Table of Devices",
>  };
>  
>  /* returns pointer to start of pos. entry of tcg log */
> @@ -206,7 +214,7 @@ static int get_event_name(char *dest, st
>  	const char *name = "";
>  	char data[40] = "";
>  	int i, n_len = 0, d_len = 0;
> -	u32 event_id;
> +	struct tcpa_pc_event *pc_event;
>  
>  	switch(event->event_type) {
>  	case PREBOOT:
> @@ -235,31 +243,32 @@ static int get_event_name(char *dest, st
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
> 
> 

