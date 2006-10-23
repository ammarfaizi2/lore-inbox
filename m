Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751602AbWJWGfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbWJWGfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWJWGfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:35:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:57796 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751597AbWJWGfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:35:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=NHR8tpB3XO/bXuAW42ccC2VHSkap3QnEOrb9RVkbSKK2aRYmVTX3AY+5Y7YookDd/JvDgHUkFIAJqyZ7w2Ip8cnH1n0B8N76NA6xDi3vAQ7SSneaPXxY1gQ9N/CA2G+dQFcQma1yLW5uUG1fuxxssqBflDHzloecdacVV0hQMdY=
Message-ID: <84144f020610222335l783322e8q56716adbf935b9ef@mail.gmail.com>
Date: Mon, 23 Oct 2006 09:35:51 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Amit Choudhary" <amit2030@gmail.com>
Subject: Re: [PATCH 2.6.19-rc2] sound/oss/i810_audio.c: check kmalloc() return value.
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20061022221700.0e33ce71.amit2030@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061022221700.0e33ce71.amit2030@gmail.com>
X-Google-Sender-Auth: 9b2e0db002a7491c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Amit Choudhary <amit2030@gmail.com> wrote:
> @@ -2580,8 +2580,13 @@ static int i810_open(struct inode *inode
>                         if (card->states[i] == NULL) {
>                                 state = card->states[i] = (struct i810_state *)
>                                         kmalloc(sizeof(struct i810_state), GFP_KERNEL);
> -                               if (state == NULL)
> +                               if (state == NULL) {
> +                                       for (--i; i >= 0; i--) {
> +                                               kfree(card->states[i]);
> +                                               card->states[i] = NULL;
> +                                       }
>                                         return -ENOMEM;
> +                               }
>                                 memset(state, 0, sizeof(struct i810_state));
>                                 dmabuf = &state->dmabuf;
>                                 goto found_virt;

Looks wrong to me. We only allocate memory once in the loop (hint:
goto found_virt at the bottom here).
