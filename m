Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288551AbSAHXGs>; Tue, 8 Jan 2002 18:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288550AbSAHXGe>; Tue, 8 Jan 2002 18:06:34 -0500
Received: from relay11.Austria.eu.net ([193.154.160.115]:34522 "EHLO
	relay11.austria.eu.net") by vger.kernel.org with ESMTP
	id <S288541AbSAHXGT>; Tue, 8 Jan 2002 18:06:19 -0500
Subject: RE: i686 SMP systems with more then 12 GB ram with 2.4.x kernel,
	cache buffer bug ?
From: Harald Holzer <harald.holzer@eunet.at>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "M. Edward (Ed) Borasky" <znmeb@aracnet.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Timothy D. Witham" <wookie@osdl.org>
Content-Type: multipart/mixed; boundary="=-DCgOBRVkVj0bGOrFoRXd"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 09 Jan 2002 00:03:13 +0100
Message-Id: <1010530993.11323.3.camel@hh2.hhhome.at>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DCgOBRVkVj0bGOrFoRXd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

low memory problem:

A Server with 32 GB ram, RH 7.2 and kernel 2.4.17rc2aa2.
After doing a lot of disc access the system slows down and the system
dies. Because the system is running out of low memory.

The last kernel logs lines are:
"kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/0)"

On other kernels then 2.4.17rc2aa2 the oom killer kicks in, or the
system simply stop responding without any messages.

It looks like that the buffer_heads would fill up the low memory,
whether there is sufficient memory available or not, as long as
there is sufficient high memory for caching.
It seems that the kernel does a good job of releasing dcache or icache,
but the buffer_heads are filling up the released mem.

(With 16GB Ram the system runs.:-)

This problem is not related to such big systems. But it seems that only
there it hits you immediately.

I rechecked this on a system with 4GB. After allocating 784 MB of 856 MB
low memory with kmalloc, i started a copy of some files.
And the system dies with the same problem.


Can someone help me, fixing this problem.


If someone want to check this problem, i attached a file wastemem.c.
With this module you can allocate low memory.
Compile it with "gcc -c wastemem.c", and load it with
"insmod -f wastemem.o count=49000".
Count are the number of 16k blocks to allocate.(49000 = 784 MB).
(Be warned dont kill your working system ;-)

Make sure with a reboot that there only some buffers are used.
Allocate enough low mem, so that the 104 byte blocks from buffer_head
fills up your low mem, before the 4k cache blocks the high mem does.
Now do some disk access to get the system out of memory.


Harald Holzer


--=-DCgOBRVkVj0bGOrFoRXd
Content-Disposition: attachment; filename=wastemem.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; charset=ANSI_X3.4-1968

#define MODULE

#include <linux/module.h>
#include <linux/slab.h>

#define __GFP_DMA       0x01
#define __GFP_HIGHMEM   0x02

/* Action modifiers - doesn't change the zoning */
#define __GFP_WAIT      0x10    /* Can wait and reschedule? */
#define __GFP_HIGH      0x20    /* Should access emergency pools? */
#define __GFP_IO        0x40    /* Can start low memory physical IO? */
#define __GFP_HIGHIO    0x80    /* Can start high mem physical IO? */
#define __GFP_FS        0x100   /* Can call down to low-level FS? */

#define GFP_NOHIGHIO    (__GFP_HIGH | __GFP_WAIT | __GFP_IO)
#define GFP_NOIO        (__GFP_HIGH | __GFP_WAIT)
#define GFP_NOFS        (__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO)
#define GFP_ATOMIC      (__GFP_HIGH)
#define GFP_USER        (             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO =
| __GFP_FS)
#define GFP_HIGHUSER    (             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO =
| __GFP_FS | __GFP_HIGHMEM)
#define GFP_KERNEL      (__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO =
| __GFP_FS)
#define GFP_NFS         (__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO =
| __GFP_FS)
#define GFP_KSWAPD      (             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO =
| __GFP_FS)

/* Flag - indicates that the buffer will be suitable for DMA.  Ignored on s=
ome
   platforms, used as appropriate on others */
  =20
#define GFP_DMA         __GFP_DMA
  =20
struct testblock {
    struct testblock	*next;
};

struct testblock	*testblocks =3D 0;
int		n;
struct testblock	*iblock;
long		count =3D 4000;

MODULE_PARM (count,"l");

int init_module(void) {
	printk("Wastemem loaded.\n");
	for(n=3D0; n < count; n++) {
	    iblock =3D (struct testblock *) kmalloc(1UL << 14 ,GFP_KERNEL);
	    iblock->next =3D testblocks;
	    testblocks =3D iblock;
	}
	return 0;
}

void cleanup_module(void) {
	for(n=3D0; n < count; n++) {
	    iblock =3D testblocks;
	    testblocks =3D testblocks->next;
	    kfree(iblock);
	}
	printk("Wastemem unloaded\n");
}

--=-DCgOBRVkVj0bGOrFoRXd--
