Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130022AbQLNLd5>; Thu, 14 Dec 2000 06:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130270AbQLNLdr>; Thu, 14 Dec 2000 06:33:47 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:45326 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S130022AbQLNLdd>; Thu, 14 Dec 2000 06:33:33 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200012141102.eBEB2wb07000@wellhouse.underworld>
Subject: Re: /dev/cpu/*/(cpuid, msr) unhappy as modules - OOPS!
To: hpa@zytor.com (H. Peter Anvin)
Date: Thu, 14 Dec 2000 22:02:57 +1100 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1193.195.67.189.85.976703444.squirrel@www.zytor.com> from "H. Peter Anvin" at Dec 13, 2000 02:30:44 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like a devfs problem; complain to the appropriate people.  I refuse 
> to touch that particular devfs code.

I've had a quick look at both the 2.2.18 and 2.4.0-test12 drivers for
msr and cpuid, and I've noticed something curious.

This is the comment from 2.4.0-test12, cpuid.c:

/*
 * cpuid.c
 *
 * x86 CPUID access device
 *
 * This device is accessed by lseek() to the appropriate CPUID level
 * and then read in chunks of 16 bytes.  A larger size means multiple
 * reads of consecutive levels.
 *
 * This driver uses /dev/cpu/%d/cpuid where %d is the minor number, and on
 * an SMP box will direct the access to CPU %d.
 */

And this is the initialisation function:

int __init cpuid_init(void)
{
  if (register_chrdev(CPUID_MAJOR, "cpu/cpuid", &cpuid_fops)) {
    printk(KERN_ERR "cpuid: unable to get major %d for cpuid\n",
     CPUID_MAJOR);
    return -EBUSY;
  }

  return 0;
}

These two are inconsistent! I had dutifully created a /dev/cpu/0
directory on my 2.2.18 and 2.4.0-test12 boxes, and had placed cpuid
device nodes inside them. (The 2.4.0-test12 box is SMP, and so I also
created a /dev/cpu/1 directory there too.) However, the driver expects
the device node to be /dev/cpu/cpuid. The msr driver has the same
problem.

Both the cpuid and the msr modules successfully loaded on 2.2.18 when
I tried to cat /dev/cpu/cpuid and /dev/cpu/msr. (Although they both
remained flagged as (unused), which I found strange considering the
amount of output I got.)

Cheers,
Chris



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
