Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280153AbRKXVOe>; Sat, 24 Nov 2001 16:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280186AbRKXVOS>; Sat, 24 Nov 2001 16:14:18 -0500
Received: from smtp6.mindspring.com ([207.69.200.110]:30010 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S280153AbRKXVOA>; Sat, 24 Nov 2001 16:14:00 -0500
Message-ID: <3C000EE7.D69C1482@mindspring.com>
Date: Sat, 24 Nov 2001 13:19:35 -0800
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.14/2.4.15 cpia driver IS broke.. no its parport
In-Reply-To: <Pine.LNX.4.33.0111230950580.24427-100000@netfinity.realnet.co.sz> <3BFF16F0.C331F0E4@mindspring.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay I have done some more research and found out what is happening!
After further testing I have found out that the problem with the parport driver
is actually in the ieee1294 code.   One of the changes in the file
drivers/parport/ieee1294_ops.c is causing problems.  (for me atleast)

The code has changed from calls to parport_frob_control() to calls to
parport_write_control ().(Fine)

The problem is that in the call to acknowledge the handshake (Event 44? about
line592) the call to parport_frob_control or parport_pc_frob_control as it is
#defined to is called with a 0 which I think causes the code to call
parport_pc_data_forward and the new code just calls parport_pc_data_reverse.
I think that we may need to call the parport_pc_data_forward still.

-               parport_write_control (port, ctl);   // new code
+               parport_frob_control (port, PARPORT_CONTROL_AUTOFD, 0);  //old
working code

Joe

> I have been doing some testing and debugging and found out that something in
> the 2.4.14 parport driver is breaking my webcam II.  I have a patch that
> reverts out all the changes in 2.4.14 parport driver back to 2.4.13 and the
> driver now works.  I am going to do some more testing and see if I can narrow
> the code down.  Right now the patch is  about 700+ lines, but reverts out
> ALL the parport changes.
>
> My hardward is a VIA chipset (686). It is the ABiT KT7A MB.
>
> What's happening is that the cpia is being recgonized, but the video device
> is not accessable. This is in both 2.4.15 and 2.4.14, with the creative
> WebCam II.
>
> In the /proc/cpia/video0 file it shows the CPIA version as 0.00 instead of
> 1.20.

