Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312986AbSDGHcQ>; Sun, 7 Apr 2002 03:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312987AbSDGHcP>; Sun, 7 Apr 2002 03:32:15 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:55046 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312986AbSDGHcO>; Sun, 7 Apr 2002 03:32:14 -0400
Date: Sun, 7 Apr 2002 08:32:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Rob Radez <rob@osinvestor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WatchDog Driver Updates
Message-ID: <20020407083207.A28922@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0204062139010.3791-100000@pita.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2002 at 09:49:57PM -0500, Rob Radez wrote:
> I've put up a patch on http://osinvestor.com/bigwatchdog.diff against
> 2.4.19-pre5-ac3.  The diff is 33k, and it affects 19 files in drivers/char/,

And the purpose of this patch is...

1. copy_to_user is like memcpy() - it takes two pointers and an integer
   size.  You're passing it two integers and a pointer:

   static int wdt977_ioctl(... unsigned long arg)
   ...
            case WDIOC_GETSTATUS:
                   if(copy_to_user(arg, &timer_alive, sizeof(timer_alive)))
                              return -EFAULT;
                   return 0;

2. sizeof(int) != sizeof(unsigned long).  You've changed the ABI in an
   unsafe manner on 64-bit machines.  The ABI is defined by the ioctl
   numbers, which specify an 'int' type.

3. copy_to_user of an int or unsigned long is a bit inefficient.  Why
   not use put_user to write an int or unsigned long?

4. Unless I'm missing something, WDIOC_GETSTATUS can only ever return
   an indication that the timer is open/alive - it's set when the driver
   is opened, and cleared when it is closed.  Since you can't perform
   an ioctl on a closed device, the times that you can perform the ioctl,
   it'll always give you a non-zero result.

5. WDIOC_GETSTATUS is supposed to return the WDIOF_* flags.  Returning
   "watchdog active" as bit 0 causes it to indicate WDIOF_OVERHEAT.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

