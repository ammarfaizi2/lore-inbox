Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280653AbRKJNjt>; Sat, 10 Nov 2001 08:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280655AbRKJNjg>; Sat, 10 Nov 2001 08:39:36 -0500
Received: from Expansa.sns.it ([192.167.206.189]:42254 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S280653AbRKJNii>;
	Sat, 10 Nov 2001 08:38:38 -0500
Date: Sat, 10 Nov 2001 14:38:34 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Thorsten Kukuk <kukuk@suse.de>
cc: <linux-kernel@vger.kernel.org>, <Heinz.Mauelshagen@t-online.de>
Subject: Re: Bug in /proc/lvm/global (garbage printed)
In-Reply-To: <20011110120619.A10459@suse.de>
Message-ID: <Pine.LNX.4.33.0111101433510.27286-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll test this patch too. In the reality on my ultrasparc64 (ultra2 dual
processor 400 Mhz sparcII) I have been unable to run LVM
at all. I have been unable to do so also on a dual processor E420 I
received for tests. vgscan simply randomly fails at boot. It fails every
time If I have une volume group on two disks, and it fails randomly if I
have two VGs, one for each disk. I tried with lvm utils coming with
suse, then the latest lvm utils, and with
2.2.12|14, but no luck at all.

Luigi

On Sat, 10 Nov 2001, Thorsten Kukuk wrote:

>
> Hi,
>
> On UltraSPARC and IA64, an "cat /proc/lvm/global" returns only
> garbage (it will print the contents of some random memory).
>
> The problem is in the _proc_read_global function. This function does
> not use the "page" parameter to return the data. Instead it allocates
> it's own buffer and change to "start" parameter to point to it.
> The "page" buffer will not be used. The culprint is now in the
> proc_file_read() function:
>
>                 /* This is a hack to allow mangling of file pos independent
>                  * of actual bytes read.  Simply place the data at page,
>                  * return the bytes, and set `start' to the desired offset
>                  * as an unsigned int. - Paul.Russell@rustcorp.com.au
>                  */
>                 n -= copy_to_user(buf, start < page ? page : start, n);
>
> In some cases (this cases seems to be always true on UltraSPARC and IA64
> and I think it works only by accident on ix32) the data from page and not
> from start is used -> page contains randam data which is printed by the
> kernel.
>
> I fixed this by the following patch (which works for me on UltraSPARC),
> but I don't know if it really correct in all cases. But I think it is.
> Don't return a pointer to the buffer, instead copy as far as possible
> data to page. This should work as before, since we never returns the
> full length of the data, but max. the length of the page buffer.
>
> --- drivers/md/lvm-fs.c	2001/11/09 19:00:38	1.1
> +++ drivers/md/lvm-fs.c	2001/11/09 20:50:16
> @@ -482,11 +480,15 @@
>  		buf = NULL;
>  		return 0;
>  	}
> -	*start = &buf[pos];
> -	if (sz - pos < count)
> +	/* *start = &buf[pos]; */
> +	if (sz - pos < count) {
> +		memcpy (page, &buf[pos], sz - pos);
>  		return sz - pos;
> -	else
> +        }
> +	else {
> +		memcpy (page, &buf[pos], count);
>  		return count;
> +	}
>
>  #undef LVM_PROC_BUF
>  }
>
>
> --
> Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
> SuSE GmbH            Deutschherrenstr. 15-19       D-90429 Nuernberg
> --------------------------------------------------------------------
> Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

