Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbTDVAuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 20:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbTDVAuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 20:50:05 -0400
Received: from hera.cwi.nl ([192.16.191.8]:61058 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262682AbTDVAuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 20:50:03 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 22 Apr 2003 03:02:06 +0200 (MEST)
Message-Id: <UTC200304220102.h3M126n06187.aeb@smtp.cwi.nl>
To: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new system call mknod64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[You prefer sending to l-k only. But my mailbox is aeb@cwi.nl,
and l-k is read elsewhere. What you send there I may or may not see.
If you want me to see it, please cc.]

>> u64, or, if you prefer, as struct { u32 major, minor; }.

> Any reason why we don't just *make it* a struct?

Well, I have also done that of course. Both struct and u64 work well.
Since only kdev_t.h knows about the actual structure of kdev_t
it is very easy to switch.

--------------
typedef struct {
        u32 major;
        u32 minor;
} kdev_t;

#define major(dev)      ((dev).major)
#define minor(dev)      ((dev).minor)
#define mk_kdev(major, minor)   ((kdev_t) { major, minor } )

#define HASHDEV(dev)    (major(dev) ^ minor(dev))       /* arbitrary */
#define NODEV           (mk_kdev(0,0))
#define kdev_none(dev)  (major(dev) == 0 && minor(dev) == 0)

static inline int kdev_same(kdev_t dev1, kdev_t dev2)
{
        return (dev1.major == dev2.major) && (dev1.minor == dev2.minor);
}
--------------

(there are some defines in the tty code that have to be adapted,
that is all)


>> sys_mknod takes unsigned int (instead of dev_t)
>> sys_mknod64 takes two unsigned ints.

> Why unsigned int?  If we have a legacy call it should presumably use
> the legacy __u16 format.

That would become rather ugly. The present situation is not u16,
it depends on the architecture. But unsigned int covers the
present situation on all architectures.

Andries
