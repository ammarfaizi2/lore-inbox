Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbULEBva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbULEBva (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 20:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbULEBva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 20:51:30 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:39578
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261224AbULEBvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 20:51:24 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Sat, 4 Dec 2004 19:49:57 -0500
User-Agent: KMail/1.6.2
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com, Mariusz Mazur <mmazur@kernel.pl>,
       Arjan van de Ven <arjanv@redhat.com>, andersen@codepoet.org
References: <19865.1101395592@redhat.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <41AAA746.5000003@pobox.com>
In-Reply-To: <41AAA746.5000003@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412041949.57466.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 November 2004 11:36 pm, Jeff Garzik wrote:
> Linus Torvalds wrote:
> > In short: having the kernel use the same names as user space is ACTIVELY
> > BAD, exactly because those names have standards-defined visibility, which
> > means that the kernel _cannot_ use them in all places anyway. So don't
> > even _try_.
> >
> > On the bigger question of what to do with kernel headers in general,
> > let's just make one thing clear: the kernel headers are for the kernel,
> > and big and painful re-organizations that don't help _existing_ user
> > space are not going to happen.
> >
> > In particular, any re-organization that breaks _existing_ uses is totally
> > pointless. If you break existing uses, you might as well _not_ re-
> > organize, since if you consider kernel headers to be purely kernel-
> > internal (like they should be, but hey, reality trumps any wishes we
> > might have), then the current organization is perfectly fine.
>
> I don't think any drastic reorganization is even necessary.
>
> Mariusz Mazur <mmazur@kernel.pl> updates
> http://ep09.pld-linux.org/~mmazur/linux-libc-headers/ for each 2.6.x
> kernel release.  linux-libc-headers are the kernel headers, with all the
> kernel-specific stuff stripped out.  i.e. userland ABI only.  Not sure
> how many distros have started picking that up yet...  I think Arjan said
> Fedora Core had, or would.

I've got a problem that mmazur's headers come down on one side of and Eric 
Andersen of the busybox project comes down on the other side of.  How the 
heck do you implement losetup without including linux/loop.h?

The way both busybox and util-linux do it is the to block copy out lots of 
ugly crap, include linux/version.h, and have #ifdefs to fix up differences 
between known kernel versions.  I'm serious.  This is from 
busybox/libbb/loop.c, but you can get an even more obfuscated variant of it 
out of util-linux:

--------------

/* Grumble...  The 2.6.x kernel breaks asm/posix_types.h
 * so we get to try and cope as best we can... */
#include <linux/version.h>
#include <asm/posix_types.h>

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
#define __bb_kernel_dev_t   __kernel_old_dev_t
#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
#define __bb_kernel_dev_t   __kernel_dev_t
#else
#define __bb_kernel_dev_t   unsigned short
#endif

/* Stuff stolen from linux/loop.h */
#define LO_NAME_SIZE        64
#define LO_KEY_SIZE         32
#define LOOP_SET_FD         0x4C00
#define LOOP_CLR_FD         0x4C01
#define LOOP_SET_STATUS     0x4C02
#define LOOP_GET_STATUS     0x4C03
struct loop_info {
    int                lo_number;
    __bb_kernel_dev_t  lo_device;
    unsigned long      lo_inode;
    __bb_kernel_dev_t  lo_rdevice;
    int                lo_offset;
    int                lo_encrypt_type;
    int                lo_encrypt_key_size;
    int                lo_flags;
    char               lo_name[LO_NAME_SIZE];
    unsigned char      lo_encrypt_key[LO_KEY_SIZE];
    unsigned long      lo_init[2];
    char               reserved[4];
};

----------------------

When I submitted a patch to clean it up on the busybox list (fixing a real 
compile problem I had with maszur's 2.6.6.0 kernel headers):
http://www.busybox.net/lists/busybox/2004-November/013128.html

I got this response:
http://www.busybox.net/lists/busybox/2004-November/013132.html

> No no no no no no no no no!
>
> Rule #1: Never ever include kernel header files in user space.
> Rule #2: See Rule #1
> Rule #3: See Rule #2

Apparently, linux/version.h isn't considered a kernel header?

Somehow, including linux/loop.h is considered bad, but including 
linux/version.h and having version specific #ifdefs in our code to fix up a 
block copied header for the specific kernel versions we know about is LESS 
incestuous knowledge.  (After all, the above will OBVIOUSLY work on BSD, is 
guaranteed to continue to compile without modification under the 2.8 kernel, 
and is in generally much cleaner than deleting all that crap and just 
including linux/loop.h.)

I still don't understand the reasoning here.  Mazur's cleaned-up kernel 
headers include a cleaned up version of linux/loop.h because loop_info simply 
isn't defined anywhere else we can #include, and it's something you need in 
order to set up loop devices.  It's a structure userspace and the kernel use 
to pass data back and forth, both need to include it.  Any _new_ header file 
created won't exist on 2.4, but this header IS there on 2.4, and 2.2, and 
2.6.  Including linux/loop.h is the only thing that will _work_, both in 
current and in future versions.

How is this _supposed_ to be done?

Rob
