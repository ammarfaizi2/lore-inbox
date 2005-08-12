Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVHLQxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVHLQxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 12:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbVHLQxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 12:53:33 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:59291 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750701AbVHLQxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 12:53:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=uVrV3jhygppEBJkLnx/vpquv796fRdy7+Sly5J0X25AdqXNGY0nAeCcmsfLHBFSVqJY9hJp0UDu0KBKvh/ZPZ72F5EI4CTxTgkgN0/Ae+qotDUX2EQNt2YWxn3R6yUS4L+7o5hK9UZVRHvHmPWGeW8huhkU4Ev1I8vFGDUDLgj8=
Message-ID: <42FCF00F.2040709@gmail.com>
Date: Fri, 12 Aug 2005 18:53:03 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: rddunlap@osdl.org, fastboot@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kexec and frame buffer
References: <42F219B3.6090502@gmail.com>	<m17jf1zgnz.fsf@ebiederm.dsl.xmission.com>	<42F4C6E8.1050605@gmail.com> <m13bpnyppq.fsf@ebiederm.dsl.xmission.com> <42F6266B.8000704@gmail.com>
In-Reply-To: <42F6266B.8000704@gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Luca Falavigna ha scritto:
> Eric W. Biederman ha scritto:
> 
>>>Anyway I believe you also want to look at include/linux/tty.h
>>>at the screen_info structure.  I believe that is where
>>>all of that information is passed.
> 
> I noticed. Maybe if we fill struct x86_linux_param_header with some values
> obtained from struct screen_info, we should be able to "score that mid-court
> prayer" ;)
> 
I tried to implement a new ioctl command in fb_ioctl() in order to retrieve and
store screen_info variables into struct x86_linux_param_header, but I got the
same result: no messages shown in console, as I supposed.
After that I looked at video.S, especially an interesting label called "video":

# This is the main entry point called by setup.S
# %ds *must* be pointing to the bootsector
video:	pushw	%ds		# We use different segments
	pushw	%ds		# FS contains original DS
	popw	%fs
[...]
#ifdef CONFIG_VIDEO_SELECT
	movw	%fs:(0x01fa), %ax		# User selected video mode
	cmpw	$ASK_VGA, %ax			# Bring up the menu
	jz	vid2
[...]

Video mode is stored (by bootloader, actually) at offset 0x01fa from a given
boot sector, which should be located at physical address DEF_SETUPSEG (0x9020).
Feel free to correct me if I'm wrong.
If we could store current video mode before executing reboot_code_buffer,
probably setup() function would take care of anything else. So we could
implement a function (or an assembly stub) in machine_kexec which does this job.
I think this is the best (and safest) solution.

Regards,
- --
					Luca

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQvzwDczkDT3RfMB6AQJlQAf+INkCMjhmm18RPCMHXij7WmOL/4TCKTc8
fZCf+IzhsSUxwkfYmUbTfXtJ/xCxIyRh5gBGirB9n/s9NzOiYwmcQWMrn7DbWpWu
YBVkTdz3W3Y0dA08baIYQ8u51gJvnVMuGJEFqsLxPx+gzHJOETEGkzhuyUuPk+J+
N4OkSyTGYt5zXZmyVzV7KZ8XLrfX3XvRLV3m2aey0Hz4jcf8sIozANokDRdG3MpN
7F0Z4yL1EnMI4oijHSDLeqbycAg8iYa49P45EO6+jzuRH2i2bnq8hOvBHa0+B01Q
Gr0Ljd+DJ2jNVO4ecqbWC9oFxBFXsRN+ThAxsYEbWDGIrJdAa32mfA==
=BztK
-----END PGP SIGNATURE-----

