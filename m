Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVBPVub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVBPVub (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 16:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVBPVub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 16:50:31 -0500
Received: from hera.cwi.nl ([192.16.191.8]:52470 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262082AbVBPVuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 16:50:22 -0500
Date: Wed, 16 Feb 2005 22:49:58 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Jirka Bohac <jbohac@suse.cz>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, vojtech@suse.cz,
       roman@augan.com, hch@nl.linux.org
Subject: Re: [rfc] keytables - the new keycode->keysym mapping
Message-ID: <20050216214958.GA7682@apps.cwi.nl>
References: <20050209132654.GB8343@dwarf.suse.cz> <20050209152740.GD12100@apps.cwi.nl> <20050209171921.GB11359@dwarf.suse.cz> <20050209200330.GB15005@apps.cwi.nl> <20050210125344.GA5196@dwarf.suse.cz> <20050216182035.GA7094@dwarf.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050216182035.GA7094@dwarf.suse.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 07:20:35PM +0100, Jirka Bohac wrote:

> Now ... are there any more suggestions for any of the patches?

For the time being I look only at the diacr for unicode part.
The fragment below looks like a strange kludge.

> -	if (diacr)
> -		value = handle_diacr(vc, value);
> +	if (diacr) {
> +		v = handle_diacr(vc, value);
> +
> +		if (kbd->kbdmode == VC_UNICODE) {
> +			to_utf8(vc, v & 0xFFFF);
> +			return;
> +		}
> +
> +		/* 
> +		 * this makes at least latin-1 compose chars work 
> +		 * even when using unicode keymap in non-unicode mode
> +		 */
> +		value = v & 0xFF; 
> +	}
>  
>  	if (dead_key_next) {
>  		dead_key_next = 0;
> @@ -637,7 +652,7 @@
>  {
>  	if (up_flag)
>  		return;
> -	diacr = (diacr ? handle_diacr(vc, value) : value);
> +	diacr = (diacr ? handle_diacr(vc, value) & 0xff : value);

I see twice "& 0xff" but why?
I think this is broken.

Maybe the above "return" is broken as well. The original code
was good, so the only change should be to transport more than 8 bits.

Andries
