Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277187AbRJDROm>; Thu, 4 Oct 2001 13:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277185AbRJDROd>; Thu, 4 Oct 2001 13:14:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:33155 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S277187AbRJDROP>;
	Thu, 4 Oct 2001 13:14:15 -0400
Message-ID: <3BBC98F7.F23A2D26@us.ibm.com>
Date: Thu, 04 Oct 2001 10:14:31 -0700
From: "David C. Hansen" <haveblue@us.ibm.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Big kernel lock in release functions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I've been looking at use of the big kernel lock in a lot of different
places in the kernel.  I've noticed that there are quite a few uses in
devices' release functions, with no obvious purpose.  Take a look at
arch/m68k/atari/joystick.c:

    lock_kernel();
    joystick[minor].active = 0;
    joystick[minor].ready = 0;

    if ((joystick[0].active == 0) && (joystick[1].active == 0))
        ikbd_joystick_disable();
    unlock_kernel();

  But, there are other places in the same file where the same operations
are performed with no locking at all (except for
ikbd_joystick_disable()). Is there a reason to have locking in the
release function but not in the read or open functions?  
  This is a quite common practice in release functions throughout the
kernel.  In 2.4.10, I counted 108 different places where the BKL is used
in a release function.  I'm not claiming that all of these are
unnecessary, but I believe a big chunk of them are.  

--
David C. Hansen
haveblue@us.ibm.com
IBM LTC Base/OS Group
(503)578-4080
