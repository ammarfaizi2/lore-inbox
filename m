Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292272AbSBOX1P>; Fri, 15 Feb 2002 18:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292273AbSBOX1H>; Fri, 15 Feb 2002 18:27:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:54923 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292272AbSBOX0t>;
	Fri, 15 Feb 2002 18:26:49 -0500
Date: Fri, 15 Feb 2002 15:24:55 -0800 (PST)
Message-Id: <20020215.152455.85412802.davem@redhat.com>
To: greearb@candelatech.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: copy_from_user returns a positive value?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C6C6E0C.6000309@candelatech.com>
In-Reply-To: <3C6C6E0C.6000309@candelatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Thu, 14 Feb 2002 19:10:20 -0700

   When I make the copy from user call:
   
          if ((ret = copy_from_user(&reqconf, arg, sizeof(reqconf)))) {
             printk("ERROR: copy_from_user returned: %i, sizeof(reqconf): %i\n",
                    ret, sizeof(reqconf));
             return ret;
          }
   
   I see this printed out:
   
   ERROR: copy_from_user returned: 696, sizeof(reqconf): 696

Either:

1) 'arg' is a bogus userland pointer

or

2) 'arg'  is a valid userland pointer, but someone has done a
   set_fs(KERNEL_DS) so only kernel pointers are valid for user
   copies.

A lot of the "32-bit userland on 64-bit kernel" compatability laters
work by doing #2.  They munge the 32-bit user structures into kernel
side copies, and do set_fs(KERNEL_DS) and pass in the pointers to the
kernel copies to the real syscall then finally restore things back to
USER_DS.

copy_{to,from}_user always return, as you correctly noted, the amount
of data that could not be copied or "0" for success.  That is why all
code does something like this:

	err = 0;
	if (copy_{to,from}_user(...))
		err = -EFAULT;

I don't know where some people get the idea that copy_{to,from}_user
should return -EFAULT on failure.  Maybe some port is buggy :-)
