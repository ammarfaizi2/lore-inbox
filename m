Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265204AbTLFPwh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 10:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbTLFPwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 10:52:37 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:9477 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265204AbTLFPwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 10:52:35 -0500
To: Michal Rokos <m.rokos@sh.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0-test11] VFAT fix for UTF-8 and trailing dots
References: <20031206085539.GA3134@nightmare.sh.cvut.cz>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 07 Dec 2003 00:52:07 +0900
In-Reply-To: <20031206085539.GA3134@nightmare.sh.cvut.cz>
Message-ID: <87d6b2vt94.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Rokos <m.rokos@sh.cvut.cz> writes:

> The problem is: even if vfat_striptail_len() counts len of name without
> trailing dots and sets len to the correct value, utf8_mbstowcs() doesn't
> care about len and takes whole name.
> So dirs and files with dots can be created on vfat fs and that will
> cause some problems as you know :)

[...]

>  	if (utf8) {
> +		int name_len = strlen(name);
> +
>  		*outlen = utf8_mbstowcs((wchar_t *)outname, name, PAGE_SIZE);
> -		if (name[len-1] == '.')
> -			*outlen-=2;
> +
> +		/* 
> +		 * We stripped '.'s before and set len appropriately,
> +		 * but utf8_mbstowcs doesn't care about len
> +		 */
> +		*outlen -= (name_len-len);
> +
>  		op = &outname[*outlen * sizeof(wchar_t)];

Indeed. However, this looks not right fix. I think utf8_mbstowcs()
should take the length of both outname and name, so we should fix the
utf8_mbstowcs().

For example, utf8_mbstowcs(outbuf, outlen, inbuf, inlen);

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
