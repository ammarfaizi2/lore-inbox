Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbULEC0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbULEC0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 21:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbULEC0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 21:26:25 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:17418 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261228AbULEC0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 21:26:19 -0500
Date: Sun, 5 Dec 2004 03:26:13 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Rob Landley <rob@landley.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com, Mariusz Mazur <mmazur@kernel.pl>,
       Arjan van de Ven <arjanv@redhat.com>, andersen@codepoet.org
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041205022613.GA13494@pclin040.win.tue.nl>
References: <19865.1101395592@redhat.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <41AAA746.5000003@pobox.com> <200412041949.57466.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412041949.57466.rob@landley.net>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: mailhost.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2004 at 07:49:57PM -0500, Rob Landley wrote:

> How the heck do you implement losetup without including linux/loop.h?

Copy the util-linux sources.

> The way both busybox and util-linux do it is the to block copy out lots of 
> ugly crap, include linux/version.h, and have #ifdefs to fix up differences 
> between known kernel versions.  I'm serious.

Yes, a well-known problem. Util-linux has roughly

#include <linux/posix_types.h>
#include <linux/version.h>

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,68)
#define my_dev_t __kernel_dev_t
#else
#define my_dev_t __kernel_old_dev_t
#endif

Here the struct has not changed, but the names for the types have changed.
Thus, instead of looking at <linux/version.h> and <linux/posix_types.h>
one could have a completely kernel-independent source with different defines
for each architecture.

But, all that nonsense is needed only for the obsolete struct loop_info.
Any new program should use struct loop_info64, and it has a clean definition:

struct loop_info64 {
        __u64              lo_device;                   /* ioctl r/o */
        __u64              lo_inode;                    /* ioctl r/o */
        __u64              lo_rdevice;                  /* ioctl r/o */
        __u64              lo_offset;
        __u64              lo_sizelimit;/* bytes, 0 == max available */
        __u32              lo_number;                   /* ioctl r/o */
        __u32              lo_encrypt_type;
        __u32              lo_encrypt_key_size;         /* ioctl w/o */
        __u32              lo_flags;                    /* ioctl r/o */
        __u8               lo_file_name[LO_NAME_SIZE];
        __u8               lo_crypt_name[LO_NAME_SIZE];
        __u8               lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
        __u64              lo_init[2];
};
