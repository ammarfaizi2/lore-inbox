Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVGOKOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVGOKOS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVGOKOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:14:18 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:2462 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261401AbVGOKOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:14:16 -0400
Message-ID: <42D78C8D.4040009@t-online.de>
Date: Fri, 15 Jul 2005 12:14:37 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: framebuffer blitting performance loss  2.6.12 -> 2.6.13-rc3
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: bNeEgwZJoeOjl+2evlg23gCoF7um-9OwzKQ940WfT5YuzdyNDZETkD@t-dialin.net
X-TOI-MSGID: 7768efae-da78-46b4-aedd-c436c4c164b3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody!

There is a serious performance loss between 2.6.12 and 2.6.13-rc3
affecting _all_ framebuffer devices, especially those with fast
bitblit functions.

System: Via Epia 5000
CPU: Via Samuel 2, 533MHz
Graphics core: Cyberblade/i1 (Blade 3D core integrated in 8601A)
Framebuffer driver: Not yet released fully accelerated framebuffer
                    driver cyblafb


Test setup
==========

video mode: 1280x1024, vyres=2662, bpp=8, 8x16 font, ypan scrollmode
kernel 2.6.13-rc3 is compiled with HZ==1000

Measurement 1: Compile framebuffer modules
       Result: 2.6.13-rc3 is slightly slower, but this is an almost
               invisible performance loss of about 1%

Measurement 2: time cat of file consisting of 2000 empty lines
       Result:
                                          |  2.6.12 / 2.6.13-rc3
------------------------------------------+----------------------
total time                                |  0.182s / 0.220s


Measurement 3: time cat of file consisting of 2000 full lines of
               160 characters each. Result:

       Result:
                                          |  2.6.12 / 2.6.13-rc3
------------------------------------------+----------------------
total time                                |  0.853s / 1.062s
time spent in framebuffer bitblit routine |  0.256s / 0.257s
time spent for kernel bitblit overhead    |  0,426s / 0.623s !!!
other time (scrolling, disk io etc)       |  0,171s / 0,182s


Discussion of measurements
==========================

Framebuffer compiling shows that the general kernel performance is
more or less unchanged between 2.6.12 and 2.6.13-rc3.

Cat-ing of the file consisting of 2000 empty lines takes about 20.9%
more time, cat-ing of the file consisting of 2000 full lines takes about
24% more time.

As the time spent in the bitblit function of the framebuffer driver
does not change I do assume that the data sent to the framebuffer
driver has not changed. But the new routines take about 46% longer.

All framebuffer drivers should be affected by this performance loss,
but the faster the bitblit of the used framebuffer driver is, the
more it will affect the general performance. You will not see such
a great difference if e.g. vesafb is used.

Please have a serious look at the changed code of fbcon/fbmem etc
or switch back to the old routines.

cu,
 Knut
