Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbULENUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbULENUH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 08:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbULENUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 08:20:07 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:12695 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261236AbULENTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 08:19:50 -0500
Message-ID: <41B30AF2.6060505@dgreaves.com>
Date: Sun, 05 Dec 2004 13:19:46 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Rob Landley <rob@landley.net>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com, Mariusz Mazur <mmazur@kernel.pl>,
       Arjan van de Ven <arjanv@redhat.com>, andersen@codepoet.org
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <41AAA746.5000003@pobox.com> <200412041949.57466.rob@landley.net> <20041205022613.GA13494@pclin040.win.tue.nl>
In-Reply-To: <20041205022613.GA13494@pclin040.win.tue.nl>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Err,

Isn't this WRONG.

Why is losetup considering the kernel at compile time?

Should it not be determining the kernel version at runtime and using the 
right structures then?
In which case it should have obtained a conceptual .../user/loop.h from 
a 2.4.x release and include a private copy
If 2.6.x is nice enough to provide an explicit .../user/loop.h then take 
a private copy of that into the losetup tree.

(Agreed that busybox may want to shrink as much as possible so allow 
build flags to say --with-24x-abi --with-26x-abi)

David

Andries Brouwer wrote:

>On Sat, Dec 04, 2004 at 07:49:57PM -0500, Rob Landley wrote:
>
>  
>
>>How the heck do you implement losetup without including linux/loop.h?
>>    
>>
>
>Copy the util-linux sources.
>
>  
>
>>The way both busybox and util-linux do it is the to block copy out lots of 
>>ugly crap, include linux/version.h, and have #ifdefs to fix up differences 
>>between known kernel versions.  I'm serious.
>>    
>>
>
>Yes, a well-known problem. Util-linux has roughly
>
>#include <linux/posix_types.h>
>#include <linux/version.h>
>
>#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,68)
>#define my_dev_t __kernel_dev_t
>#else
>#define my_dev_t __kernel_old_dev_t
>#endif
>
>Here the struct has not changed, but the names for the types have changed.
>Thus, instead of looking at <linux/version.h> and <linux/posix_types.h>
>one could have a completely kernel-independent source with different defines
>for each architecture.
>
>But, all that nonsense is needed only for the obsolete struct loop_info.
>Any new program should use struct loop_info64, and it has a clean definition:
>
>struct loop_info64 {
>        __u64              lo_device;                   /* ioctl r/o */
>        __u64              lo_inode;                    /* ioctl r/o */
>        __u64              lo_rdevice;                  /* ioctl r/o */
>        __u64              lo_offset;
>        __u64              lo_sizelimit;/* bytes, 0 == max available */
>        __u32              lo_number;                   /* ioctl r/o */
>        __u32              lo_encrypt_type;
>        __u32              lo_encrypt_key_size;         /* ioctl w/o */
>        __u32              lo_flags;                    /* ioctl r/o */
>        __u8               lo_file_name[LO_NAME_SIZE];
>        __u8               lo_crypt_name[LO_NAME_SIZE];
>        __u8               lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
>        __u64              lo_init[2];
>};
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

