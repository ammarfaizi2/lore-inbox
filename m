Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLRQGI>; Mon, 18 Dec 2000 11:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbQLRQF7>; Mon, 18 Dec 2000 11:05:59 -0500
Received: from [62.172.234.2] ([62.172.234.2]:32652 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129391AbQLRQFy>;
	Mon, 18 Dec 2000 11:05:54 -0500
Date: Mon, 18 Dec 2000 15:36:22 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test13-pre3] rootfs boot param. support
In-Reply-To: <20001218092219.H3199@cadcamlab.org>
Message-ID: <Pine.LNX.4.21.0012181530100.830-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, the version below doesn't look too bad, except a couple things, see
below:

On Mon, 18 Dec 2000, Peter Samuelson wrote:
> -__setup("rootfs=", rootfs_setup);
> +__setup("rootfstype=", rootfs_setup);

this is wrong. If the parameter is "rootfstype" then the function is
rootfstype_setup(). Too long. No, "rootfs" was a good idea to beging with
(ask any kernel hacker who wrote UW7 BCP support -- they knew what they
were calling their variables :)

>  {
> -	struct file_system_type * fs_type;
> +	struct file_system_type * fs_type = NULL;

this is not needed. Why did you put it there? 

> +	if (*rootfstype) {
> +		fs_type = get_fs_type(rootfstype);
> +		if (fs_type) {
> +  			sb = read_super(ROOT_DEV,bdev,fs_type,root_mountflags,NULL,1);
> +			if (sb)
> +				goto mount_it;
> +		}
> +		/* do NOT try all filesystems - user explicitly wanted this one */
> +		goto fail;
> ...
> +fail:
>  	panic("VFS: Unable to mount root fs on %s", kdevname(ROOT_DEV));

we should also print out the filesystem type, so instead of having a fail
label I would put the panic() inside the code above.

I will redo the patch with your and Andries' comments in place and re-send
to Linus. Namely, the useful things, imho, from your suggestions are:

a) the space allocated for it should be 32 bytes and not 128

b) we should check if user passed any value and only then activate the
code

c) default value "" is ok (ok, fine, the extra line of code to check for
it is not too bad).

d) but the variable should still be called "rootfs" and not
"rootfstype". rootfstype is too long, too confusing and not
obvious. Whilst "rootfs" immediately tells you "it's the name of the
filesystem in the namespace defined by file_system_type->name"

Oh, btw you changed one place from 128 to 32 but forgot another -- never
mind :)

Regards,
Tigran


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
