Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282235AbRK2AnN>; Wed, 28 Nov 2001 19:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282238AbRK2AnG>; Wed, 28 Nov 2001 19:43:06 -0500
Received: from [212.18.232.186] ([212.18.232.186]:46093 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282235AbRK2Alb>; Wed, 28 Nov 2001 19:41:31 -0500
Date: Thu, 29 Nov 2001 00:41:13 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "David C. Hansen" <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions
Message-ID: <20011129004113.D2561@flint.arm.linux.org.uk>
In-Reply-To: <E169EFX-0006TA-00@the-village.bc.nu> <3C057410.3090201@us.ibm.com> <20011128234505.C2561@flint.arm.linux.org.uk> <3C0580A8.5030706@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0580A8.5030706@us.ibm.com>; from haveblue@us.ibm.com on Wed, Nov 28, 2001 at 04:26:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 04:26:16PM -0800, David C. Hansen wrote:
> I wrote a quick and dirty char device driver to see if this happened. 
>  If I run two tasks doing a bunch of opens and closes, the -EBUSY 
> condition in the open function does happen.  Is my driver doing 
> something wrong?

What's happening is:

task 1				task 2
-> sys_open
 -> lock_kernel
  -> testdev_open
   -> test_and_set_bit
     return success
    unlock kernel
				-> sys_open
				 -> lock_kernel (blocks on it)
				  -> testdev_open
				   -> test_and_set_bit
				     return -EBUSY
				    unlock kernel
				   return
   return

The BKL is only held for the duration of the open, not until you close the
device.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

