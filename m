Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbSJEL0O>; Sat, 5 Oct 2002 07:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262299AbSJEL0O>; Sat, 5 Oct 2002 07:26:14 -0400
Received: from ti200710a082-0578.bb.online.no ([148.122.10.66]:2052 "EHLO
	empire.e") by vger.kernel.org with ESMTP id <S262296AbSJEL0K>;
	Sat, 5 Oct 2002 07:26:10 -0400
Message-ID: <3D9ECD9E.8090602@freenix.no>
Date: Sat, 05 Oct 2002 13:31:42 +0200
From: "frode@freenix.no" <frode@freenix.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40 (several issues): kernel BUG! at slab.c:1292  - and what's
 with ZSH?
References: <3D9E23E2.8000400@freenix.no> <20021005011749.GN1408@ppc.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I just downloaded the linux-2.5.40 tarball.
>>FAT: Using codepage cp437
>>FAT: Using IO charset iso8859-1
>>FAT: Using codepage cp437
>>FAT: Using IO charset iso8859-1
>>FAT: Using codepage cp437
>>FAT: Using IO charset iso8859-1
>>Adding 262136k swap on /swapfile.  Priority:-2 extents:519
>>------------[ cut here ]------------
>>kernel BUG at slab.c:1292!
>>invalid operand: 0000
> 
> 
> It is probably time to send it to Linus once more...
> 						Petr Vandrovec
> 
> diff -urdN linux/fs/fat/inode.c linux/fs/fat/inode.c
> --- linux/fs/fat/inode.c	2002-10-05 00:55:46.000000000 +0200
> +++ linux/fs/fat/inode.c	2002-10-05 01:00:15.000000000 +0200
> @@ -228,8 +228,6 @@
>  	save = 0;
>  	savep = NULL;
>  	while ((this_char = strsep(&options,",")) != NULL) {
> -		if (!*this_char)
> -			continue;
>  		if ((value = strchr(this_char,'=')) != NULL) {
>  			save = *value;
>  			savep = value;
> @@ -351,7 +349,7 @@
>  			strncpy(cvf_options,value,100);
>  		}
>  
> -		if (this_char != options) *(this_char-1) = ',';
> +		if (options) *(options-1) = ',';
>  		if (value) *savep = save;
>  		if (ret == 0)
>  			break;
> diff -urdN linux/fs/vfat/namei.c linux/fs/vfat/namei.c
> --- linux/fs/vfat/namei.c	2002-10-05 00:56:02.000000000 +0200
> +++ linux/fs/vfat/namei.c	2002-10-05 01:00:15.000000000 +0200
> @@ -117,8 +117,6 @@
>  	savep = NULL;
>  	ret = 1;
>  	while ((this_char = strsep(&options,",")) != NULL) {
> -		if (!*this_char)
> -			continue;
>  		if ((value = strchr(this_char,'=')) != NULL) {
>  			save = *value;
>  			savep = value;
> @@ -154,8 +152,8 @@
>  			else
>  				ret = 0;
>  		}
> -		if (this_char != options)
> -			*(this_char-1) = ',';
> +		if (options)
> +			*(options-1) = ',';
>  		if (value) {
>  			*savep = save;
>  		}

This patch solved the problem! Thanks!


On a different matter;

While playing around with 2.5.40 a bit I noticed something really weird:
I use the ZSH shell and my prompt basically ends with the %# code which is
supposed to show a '%' if you're not root and '#' if you are root.
In 2.5.40, zsh shows # unconditionally. (In 2.4.19pre1 which I normally run,
it works as expected). Really weird..


