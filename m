Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbTCHSHo>; Sat, 8 Mar 2003 13:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262122AbTCHSHo>; Sat, 8 Mar 2003 13:07:44 -0500
Received: from mail.ithnet.com ([217.64.64.8]:19464 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S262120AbTCHSHm>;
	Sat, 8 Mar 2003 13:07:42 -0500
Date: Sat, 8 Mar 2003 19:18:08 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hm, page 000f0000 reserved twice ?
Message-Id: <20030308191808.796a9f54.skraw@ithnet.com>
In-Reply-To: <1047149182.26644.0.camel@irongate.swansea.linux.org.uk>
References: <20030308181817.31247f93.skraw@ithnet.com>
	<1047149182.26644.0.camel@irongate.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Mar 2003 18:46:22 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Sat, 2003-03-08 at 17:18, Stephan von Krawczynski wrote:
> > Hello all,
> > 
> > Can any kind soul please tell me what "hm, page xxxx reserved twice" means?
> > And additionally: is there any magic involved in getting a serial console
> > working? There seems no way to make it work on below system. All "echo
> > >/dev/ttyS0 test"
> > do work, but no console output whatsoever visible...
> 
> The page reserved twice is just a warning, in this case its harmless and
> really its code that wants tidying up

Hm, from looking at the code (mm/bootmem.c), I would say, that:

static void __init reserve_bootmem_core(bootmem_data_t *bdata, unsigned long
addr, unsigned long size)
{
        unsigned long i;
        /*
         * round up, partially reserved pages are considered
         * fully reserved.
         */
        unsigned long sidx = (addr - bdata->node_boot_start)/PAGE_SIZE;
        unsigned long eidx = (addr + size - bdata->node_boot_start + 
                                                        PAGE_SIZE-1)/PAGE_SIZE;
        unsigned long end = (addr + size + PAGE_SIZE-1)/PAGE_SIZE;





        if (!size) BUG();

        if (sidx < 0)    
                BUG();   

Can sidx < 0 happen? sidx is unsigned long... Shouldn't "(addr <
bdata->node_boot_start)" be checked instead which would implicitely check eidx,
too. Or not?


        if (eidx < 0)    
                BUG();   

s.a. ...

        if (sidx >= eidx)
                BUG();
        if ((addr >> PAGE_SHIFT) >= bdata->node_low_pfn)
                BUG();
        if (end > bdata->node_low_pfn)
                BUG();
        for (i = sidx; i < eidx; i++)
                if (test_and_set_bit(i, bdata->node_bootmem_map))
                        printk("hm, page %08lx reserved twice.\n",
i*PAGE_SIZE);
}


Just as a note ... not really important, though.

Regards,
Stephan



