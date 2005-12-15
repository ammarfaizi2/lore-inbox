Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVLOVoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVLOVoc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVLOVoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:44:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751089AbVLOVoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:44:32 -0500
Date: Thu, 15 Dec 2005 13:45:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jordan Crouse" <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       info-linux@ldcmail.amd.com
Subject: Re: [PATCH 3/3] APM Screen Blanking fix
Message-Id: <20051215134508.21487ccf.akpm@osdl.org>
In-Reply-To: <20051215211601.GG11054@cosmic.amd.com>
References: <20051215211248.GE11054@cosmic.amd.com>
	<20051215211423.GF11054@cosmic.amd.com>
	<20051215211601.GG11054@cosmic.amd.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jordan Crouse" <jordan.crouse@amd.com> wrote:
>
> A simple patch to fix APM assisted screen blanking (this at least fixes
> a issue with the Geode LX BIOS).  Reposted from before with no changes.
> 
> APM screen blanking fix.
> 
> This patch fixes screen blanking on BIOSes that return
> APM_NOT_ENGAGED when APM enabled screen blanking is not
> turned on.

Well actually it does a whole bunch of cleanup, no?

> Signed off by: Jordan Crouse <jordan.crouse@amd.com>
> ---
> 
>  arch/i386/kernel/apm.c |   27 ++++++++++++++-------------
>  1 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
> index 1e60acb..03e9d84 100644
> --- a/arch/i386/kernel/apm.c
> +++ b/arch/i386/kernel/apm.c
> @@ -1075,22 +1075,23 @@ static int apm_engage_power_management(u
>   
>  static int apm_console_blank(int blank)
>  {
> -	int	error;
> -	u_short	state;
> +	int error, i;
> +	u_short state;
> +	u_short dev[3] = { 0x100, 0x1FF, 0x101 };

I'll make dev[] `static const'.  That'll save a scrap of kernel text.

>  	state = blank ? APM_STATE_STANDBY : APM_STATE_READY;
> -	/* Blank the first display device */
> -	error = set_power_state(0x100, state);
> -	if ((error != APM_SUCCESS) && (error != APM_NO_ERROR)) {
> -		/* try to blank them all instead */
> -		error = set_power_state(0x1ff, state);
> -		if ((error != APM_SUCCESS) && (error != APM_NO_ERROR))
> -			/* try to blank device one instead */
> -			error = set_power_state(0x101, state);
> +
> +	for (i = 0; i < 3; i++) {
> +		error = set_power_state(dev[i], state);
> +
> +		if ((error == APM_SUCCESS) || (error == APM_NO_ERROR))
> +			return 1;
> +
> +		if (error == APM_NOT_ENGAGED)
> +			break;
>  	}
> -	if ((error == APM_SUCCESS) || (error == APM_NO_ERROR))
> -		return 1;

All the above doesn't actually have any functional changes does it?

It's a decent-looking cleanup, but it should have been separately
changelogged.

> -	if (error == APM_NOT_ENGAGED) {
> +	if (error == APM_NOT_ENGAGED && state != APM_STATE_READY) {

And this is the actual fix/workaround?

