Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313554AbSDQLPZ>; Wed, 17 Apr 2002 07:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313555AbSDQLPY>; Wed, 17 Apr 2002 07:15:24 -0400
Received: from glade.nmd.msu.ru ([193.232.112.67]:36878 "HELO glade.nmd.msu.ru")
	by vger.kernel.org with SMTP id <S313554AbSDQLPX>;
	Wed, 17 Apr 2002 07:15:23 -0400
Date: Wed, 17 Apr 2002 15:15:15 +0400
From: Andrey Slepuhin <pooh@msu.ru>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx driver v6.2.5 freezes the kernel
Message-ID: <20020417111515.GE7342@glade.nmd.msu.ru>
In-Reply-To: <20020319144126.E8849@glade.nmd.msu.ru> <200203192133.g2JLXlI19100@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 02:33:47PM -0700, Justin T. Gibbs wrote:
> >lspci output attached. BTW, I tried new driver on another computer with
> >the same hardware configuration - effect is repeatable, so the problem is
> >unlikely a hardware bug.
> 
> No, but it is certainly hardware dependent.  As soon as I get a break here
> at work, I'll see what I can dig out from your lspci output.

Hi Justin,
I tracked the problem down and I find that the following change between
versions 6.2.4 and 6.2.5 causes system freeze:

--- aic7xxx/aic7xxx_core.c      Wed Apr 17 14:36:21 2002
+++ aic7xxx.new/aic7xxx_core.c  Mon Mar 18 12:54:23 2002
@@ -3770,9 +3770,8 @@
         * Ensure that the reset has finished
         */
        wait = 1000;
-       do {
+       while (--wait && !(ahc_inb(ahc, HCNTRL) & CHIPRSTACK))
                ahc_delay(1000);
-       } while (--wait && !(ahc_inb(ahc, HCNTRL) & CHIPRSTACK));
 
        if (wait == 0) {
                printf("%s: WARNING - Failed chip reset!  "

All other changes were successfully merged without any problems.
BTW, version 6.2.6 of the driver from 2.4.19-pre7 freezes the system too.

Regards,
Andrey.

-- 
A right thing should be simple (tm)
