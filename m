Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbTC0A6M>; Wed, 26 Mar 2003 19:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262734AbTC0A6M>; Wed, 26 Mar 2003 19:58:12 -0500
Received: from hera.cwi.nl ([192.16.191.8]:31922 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262730AbTC0A6K>;
	Wed, 26 Mar 2003 19:58:10 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 27 Mar 2003 02:09:22 +0100 (MET)
Message-Id: <UTC200303270109.h2R19ME28410.aeb@smtp.cwi.nl>
To: Joel.Becker@oracle.com
Subject: 64-bit kdev_t - just for playing
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Maybe I should send another patch tonight, just for playing.

> Please, I'd like that.

Below a random version of kdev_t.h.
(The file is smaller than the patch.)

kdev_t is the kernel-internal representation
dev_t is the kernel idea of the user space representation
(of course glibc uses 64 bits, split up as 8+8 :-)

kdev_t can be equal to dev_t.

The file below completely randomly makes kdev_t
64 bits, split up 32+32, and dev_t 32 bits, split up 12+20.

Andries

------------------------------------------------------------
#ifndef _LINUX_KDEV_T_H
#define _LINUX_KDEV_T_H
#ifdef __KERNEL__

typedef struct {
	unsigned long long value;
} kdev_t;

#define KDEV_MINOR_BITS		32
#define KDEV_MAJOR_BITS		32
#define KDEV_MINOR_MASK		((1ULL << KDEV_MINOR_BITS) - 1)

#define __mkdev(major, minor)	(((unsigned long long)(major) << KDEV_MINOR_BITS) + (minor))

#define mk_kdev(major, minor)	((kdev_t) { __mkdev(major,minor) } )

/*
 * The "values" are just _cookies_, usable for 
 * internal equality comparisons and for things
 * like NFS filehandle conversion.
 */
static inline unsigned long long kdev_val(kdev_t dev)
{
	return dev.value;
}

static inline kdev_t val_to_kdev(unsigned long long val)
{
	kdev_t dev;
	dev.value = val;
	return dev;
}

#define HASHDEV(dev)	(kdev_val(dev))
#define NODEV		(mk_kdev(0,0))

extern const char * kdevname(kdev_t);	/* note: returns pointer to static data! */

static inline int kdev_same(kdev_t dev1, kdev_t dev2)
{
	return dev1.value == dev2.value;
}

#define kdev_none(d1)	(!kdev_val(d1))

#define minor(dev)	(unsigned int)((dev).value & KDEV_MINOR_MASK)
#define major(dev)	(unsigned int)((dev).value >> KDEV_MINOR_BITS)

/* These are for user-level "dev_t" */
#define MINORBITS	8
#define MINORMASK	((1U << MINORBITS) - 1)
#define DEV_MINOR_BITS	20
#define	DEV_MAJOR_BITS	12
#define	DEV_MINOR_MASK	((1U << DEV_MINOR_BITS) - 1)
#define DEV_MAJOR_MASK	((1U << DEV_MAJOR_BITS) - 1)

#include <linux/types.h>	/* dev_t */

#define MAJOR(dev)	((unsigned int)(((dev) & 0xffff0000) ? ((dev) >> DEV_MINOR_BITS) & DEV_MAJOR_MASK : ((dev) >> 8) & 0xff))
#define MINOR(dev)	((unsigned int)(((dev) & 0xffff0000) ? ((dev) & DEV_MINOR_MASK) : ((dev) & 0xff)))
#define MKDEV(ma,mi)	((dev_t)((((ma) & ~0xff) == 0 && ((mi) & ~0xff) == 0) ? (((ma) << 8) | (mi)) : (((ma) << DEV_MINOR_BITS) | (mi))))

/*
 * Conversion functions
 */

static inline int kdev_t_to_nr(kdev_t dev)
{
	unsigned int ma = major(dev);
	unsigned int mi = minor(dev);
	return MKDEV(ma, mi);
}

static inline kdev_t to_kdev_t(dev_t dev)
{
	unsigned int ma = MAJOR(dev);
	unsigned int mi = MINOR(dev);
	return mk_kdev(ma, mi);
}

#else /* __KERNEL__ */

/*
Some programs want their definitions of MAJOR and MINOR and MKDEV
from the kernel sources. These must be the externally visible ones.
Of course such programs should be updated.
*/
#define MAJOR(dev)	((dev)>>8)
#define MINOR(dev)	((dev) & 0xff)
#define MKDEV(ma,mi)	((ma)<<8 | (mi))
#endif /* __KERNEL__ */
#endif
