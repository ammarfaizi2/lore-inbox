Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311271AbSCWUvm>; Sat, 23 Mar 2002 15:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311272AbSCWUvc>; Sat, 23 Mar 2002 15:51:32 -0500
Received: from mailhost.cs.clemson.edu ([130.127.48.6]:7342 "EHLO
	cs.clemson.edu") by vger.kernel.org with ESMTP id <S311271AbSCWUvX>;
	Sat, 23 Mar 2002 15:51:23 -0500
Message-ID: <3C9CEAC6.7315C86@cs.clemson.edu>
Date: Sat, 23 Mar 2002 15:51:18 -0500
From: Mike Westall <westall@cs.clemson.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: murble <murble-atmbits@yuri.org.uk>, westall@cs.clemson.edu,
        linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
Subject: Re: [Linux-ATM-General] Oops: Linux ATM Interphase card.
In-Reply-To: <20020323010130.GA20579@yuri.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since you did such a fine job of describing the problem,
I can actually tell what the trouble is and how to fix 
it even though I'm not currently using that driver.  

The problem begins with the fact that <all> ioctls are
vectored to the ioctl entry point of the atmdev that is registered
on the interface in question.  In this case, all 
are vectored to ia_ioctl().  Right near the
beginning of that ia_ioctl() you will see: 
   
   if (!dev->phy->ioctl) return(-EINVAL);

In "theory" the dev->phy pointer was set in suni_init()
to point to the suni ioctl handler. 

However, in reality, if you look around line 2528 in iphase.c
you will see that suni_init is NOT called if the phy is
25mbps, DS3, or E3 (as yours is).  

Thus phy = 0 at the time of the call and the attempt to
evaluate dev->phy->ioctl causes the seg fault shown below.
(eax is holding what should be phy). 


> Code;  c8842bee <[iphase]ia_ioctl+2a/52c>   <=====
>    0:   83 78 04 00               cmpl   $0x0,0x4(%eax)   <=====

The obvious simple solution is to insert

   if (!dev->phy) return(-EINVAL)

(or I suppose you could also add a phy driver for your interface)

Mike
