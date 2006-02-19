Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWBSR4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWBSR4z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 12:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWBSR4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 12:56:55 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:55924 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932184AbWBSR4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 12:56:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=kHjrmdgVxOuJe+8363EggX3uLfBA3vJ8v5MwHSDTLxqIxjJ+iVFXlpIIQXpG6NIh5Vig9878BgYryxa+fzsKoIbAg5Itx/NtLP3/1/M38vsV20kyMo7ipCATNs+VS2vua4xozvmAFKR37uNSF15703eCxFGgrgkqK8rhQJCKNlE=
Date: Sun, 19 Feb 2006 20:56:46 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Juergen Kreileder <jk@blackdown.de>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] Fix snd-usb-audio in 32-bit compat environemt
Message-ID: <20060219175646.GB7797@mipter.zuzino.mipt.ru>
References: <878xs85wn6.fsf@blackdown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878xs85wn6.fsf@blackdown.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 07:50:37PM +0100, Juergen Kreileder wrote:
> I'm getting oopses with snd-usb-audio in 32-bit compat environments:
> control_compat.c:get_ctl_type() doesn't initialize 'info', so
> 'itemlist[uinfo->value.enumerated.item]' in
> usbmixer.c:mixer_ctl_selector_info() might access random memory
> (The 'if ((int)uinfo->value.enumerated.item >= cval->max)' doesn't fix
> all problems because of the unsigned -> signed conversion.)

IMO, what you did is an overkill. Does this patch fixes your problem?

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -176,6 +176,7 @@ static int get_ctl_type(struct snd_card
 		up_read(&card->controls_rwsem);
 		return -ENXIO;
 	}
+	memset(info, 0, sizeof(struct snd_ctl_elem_info));
 	info.id = *id;
 	err = kctl->info(kctl, &info);
 	up_read(&card->controls_rwsem);

> --- linux-mm-vanilla/sound/core/control_compat.c
> +++ linux-mm/sound/core/control_compat.c
> @@ -167,7 +167,7 @@ static int get_ctl_type(struct snd_card
>  			int *countp)
>  {
>  	struct snd_kcontrol *kctl;
> -	struct snd_ctl_elem_info info;
> +	struct snd_ctl_elem_info *info;
>  	int err;
>
>  	down_read(&card->controls_rwsem);
> @@ -176,13 +176,19 @@ static int get_ctl_type(struct snd_card
>  		up_read(&card->controls_rwsem);
>  		return -ENXIO;
>  	}
> -	info.id = *id;
> -	err = kctl->info(kctl, &info);
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (info == NULL) {
> +		up_read(&card->controls_rwsem);
> +		return -ENOMEM;
> +	}
> +	info->id = *id;
> +	err = kctl->info(kctl, info);
>  	up_read(&card->controls_rwsem);
>  	if (err >= 0) {
> -		err = info.type;
> -		*countp = info.count;
> +		err = info->type;
> +		*countp = info->count;
>  	}
> +	kfree(info);
>  	return err;
>  }

