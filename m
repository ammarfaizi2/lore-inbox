Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284950AbRLFCzA>; Wed, 5 Dec 2001 21:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284951AbRLFCyu>; Wed, 5 Dec 2001 21:54:50 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:18563 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S284950AbRLFCyp>; Wed, 5 Dec 2001 21:54:45 -0500
Message-ID: <3C0EDDC2.608@optonline.net>
Date: Wed, 05 Dec 2001 21:53:54 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Mario Mikocevic <mozgy@hinet.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net> <3C0C5CB2.6000602@optonline.net> <3C0C61CC.1060703@redhat.com> <20011204153507.A842@danielle.hinet.hr> <3C0D1DD2.4040609@optonline.net> <3C0D223E.3020904@redhat.com> <3C0D350F.9010408@optonline.net> <3C0D3CF7.6030805@redhat.com> <3C0D4E62.4010904@optonline.net> <3C0D52F1.5020800@optonline.net> <3C0D5796.6080202@redhat.com> <3C0D5CB6.1080600@optonline.net> <3C0D5FC7.3040408@redhat.com> <3C0D77D9.70205@optonline.net> <3C0D8B00.2040603@optonline.net> <3C0D8F02.8010408@redhat.com> <3C0D9456.6090106@optonline.net> <3C0DA1CC.1070408@redhat.com> <3C0DAD26.1020906@optonline.net> <3C0DAF35.50008@redhat.com> <3C0E7DCB.6050600@optonline.net> <3C0E7DFB.2030400@optonline.net> <3C0E7F1C.4060603@redhat.com> <3C0E8DBF.5010000@optonline.net> <3C0E90B2.1030601@redhat.com> <3C0EB1F2.7050007@optonline.net> <3C0EB46C.4010806@optonline.net> <3C0EBAEF.5090402@redhat.com> <3C0EC219.8010107@redhat!
 .com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

as evidenced by,


        /* if we are currently stopped, then our CIV is actually set to our
         * *last* sg segment and we are ready to wrap to the next.  However,
         * if we set our LVI to the last sg segment, then it won't wrap to
         * the next sg segment, it won't even get a start.  So, instead, 
when
         * we are stopped, we set both the LVI value and also we increment
         * the CIV value to the next sg segment to be played so that when
         * we call start_{dac,adc}, things will operate properly
         */
        if (!dmabuf->enable) {
#ifdef DEBUG_MMAP
                printk("fnord? %d\n", inb(port+OFF_CIV));
#endif
                /* maybe we have to increment LVI to make room before 
incrementing CIV,
                   (databook says CELV isn't cleared until new val written
                    to LVI.)
                   we'll set LVI where we really want it down below. */
                //outb((inb(port+OFF_LVI)+1)&31, port+OFF_LVI);
                newciv = (inb(port+OFF_CIV)+1)&31;
                outb(newciv, port+OFF_CIV);
                for (x = 0; inb(port+OFF_CIV) != newciv && x< 5000000; x++);
                if (x==5000000) printk("foo! civ != %d\n", newciv);
        }

and

Dec  5 21:34:32 lasn-001 kernel: foo! civ != 1

CIV doesn't seem to respond to writes on my chipset, at least not in 
this situation. you'll note that nowhere in the driver are we 
initializing CIV to anything other than 0 anyway.

two alternatives I can think of:

first fix:
set LVI to desired value minus one SG
start_dac (which should have side effect of incrementing CIV by one)
increment LVI to desired value

2nd fix:
back off and perform DMA reset.

3rd fix (really fix 1a ;)
just don't allow use of the last SG when restarting

