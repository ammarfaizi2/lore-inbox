Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVEZGJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVEZGJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 02:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVEZGJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 02:09:49 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:14549 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261193AbVEZGJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 02:09:44 -0400
Message-ID: <42956821.6080003@ens-lyon.org>
Date: Thu, 26 May 2005 08:09:37 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: alexandre.buisse@ens-lyon.fr, linux-kernel@vger.kernel.org,
       pcaulfie@redhat.com, teigland@redhat.com
Subject: Re: dlm-lockspaces-callbacks-directory-fix.patch added to -mm tree
References: <200505252249.j4PMnN4q021004@shell0.pdx.osdl.net>	<4294F718.8040107@ens-lyon.fr>	<20050525162318.511cdc9b.akpm@osdl.org>	<42951138.1090404@ens-lyon.fr> <20050525172500.0d8458f1.akpm@osdl.org>
In-Reply-To: <20050525172500.0d8458f1.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one looks good.

Regards,
Brice



Andrew Morton a écrit :
> Brice Goglin <Brice.Goglin@ens-lyon.fr> wrote:
> 
>>Looks like Alexandre's patch was damaged by mistake.
>>An 'extern' appeared in the removed part of lvb_table.h
>>I guess the patch didn't actually apply to your tree.
>>This would explain why the lvb_table.h part of the version
>>you commited to -mm is different.
>>
>>The attached patch should be good.
>>
>>Note that dlm_lvb_operations is kept exported in lvb_table.h
>>so that drivers/dlm/device.c uses it. That was the point of
>>Alexandre's initial bug report: dlm_lvm_operations was defined
>>twice when both DLM and DLM_DEVICE are set.
> 
> 
> OK, thanks.  Here's what I currently have:
> 
> --- 25/drivers/dlm/lock.c~dlm-lockspaces-callbacks-directory-fix	Wed May 25 16:23:04 2005
> +++ 25-akpm/drivers/dlm/lock.c	Wed May 25 17:24:08 2005
> @@ -104,6 +104,26 @@ const int __dlm_compat_matrix[8][8] = {
>          {0, 0, 0, 0, 0, 0, 0, 0}        /* PD */
>  };
>  
> +/*
> + * This defines the direction of transfer of LVB data.
> + * Granted mode is the row; requested mode is the column.
> + * Usage: matrix[grmode+1][rqmode+1]
> + * 1 = LVB is returned to the caller
> + * 0 = LVB is written to the resource
> + * -1 = nothing happens to the LVB
> + */
> +const int dlm_lvb_operations[8][8] = {
> +        /* UN   NL  CR  CW  PR  PW  EX  PD*/
> +        {  -1,  1,  1,  1,  1,  1,  1, -1 }, /* UN */
> +        {  -1,  1,  1,  1,  1,  1,  1,  0 }, /* NL */
> +        {  -1, -1,  1,  1,  1,  1,  1,  0 }, /* CR */
> +        {  -1, -1, -1,  1,  1,  1,  1,  0 }, /* CW */
> +        {  -1, -1, -1, -1,  1,  1,  1,  0 }, /* PR */
> +        {  -1,  0,  0,  0,  0,  0,  1,  0 }, /* PW */
> +        {  -1,  0,  0,  0,  0,  0,  0,  0 }, /* EX */
> +        {  -1,  0,  0,  0,  0,  0,  0,  0 }  /* PD */
> +};
> +
>  #define modes_compat(gr, rq) \
>  	__dlm_compat_matrix[(gr)->lkb_grmode + 1][(rq)->lkb_rqmode + 1]
>  
> diff -puN drivers/dlm/lvb_table.h~dlm-lockspaces-callbacks-directory-fix drivers/dlm/lvb_table.h
> --- 25/drivers/dlm/lvb_table.h~dlm-lockspaces-callbacks-directory-fix	Wed May 25 16:23:04 2005
> +++ 25-akpm/drivers/dlm/lvb_table.h	Wed May 25 17:24:17 2005
> @@ -13,26 +13,6 @@
>  #ifndef __LVB_TABLE_DOT_H__
>  #define __LVB_TABLE_DOT_H__
>  
> -/*
> - * This defines the direction of transfer of LVB data.
> - * Granted mode is the row; requested mode is the column.
> - * Usage: matrix[grmode+1][rqmode+1]
> - * 1 = LVB is returned to the caller
> - * 0 = LVB is written to the resource
> - * -1 = nothing happens to the LVB
> - */
> -
> -const int dlm_lvb_operations[8][8] = {
> -        /* UN   NL  CR  CW  PR  PW  EX  PD*/
> -        {  -1,  1,  1,  1,  1,  1,  1, -1 }, /* UN */
> -        {  -1,  1,  1,  1,  1,  1,  1,  0 }, /* NL */
> -        {  -1, -1,  1,  1,  1,  1,  1,  0 }, /* CR */
> -        {  -1, -1, -1,  1,  1,  1,  1,  0 }, /* CW */
> -        {  -1, -1, -1, -1,  1,  1,  1,  0 }, /* PR */
> -        {  -1,  0,  0,  0,  0,  0,  1,  0 }, /* PW */
> -        {  -1,  0,  0,  0,  0,  0,  0,  0 }, /* EX */
> -        {  -1,  0,  0,  0,  0,  0,  0,  0 }  /* PD */
> -};
> +extern const int dlm_lvb_operations[8][8];
>  
>  #endif
> -
> _
> 

