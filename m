Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSGYNwz>; Thu, 25 Jul 2002 09:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315278AbSGYNvu>; Thu, 25 Jul 2002 09:51:50 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:49930
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315277AbSGYNvG>; Thu, 25 Jul 2002 09:51:06 -0400
Date: Thu, 25 Jul 2002 06:48:58 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Reinhard Moosauer <rm@moosauer.de>
cc: linux-kernel@vger.kernel.org, tspinillo@linuxmail.org
Subject: Re: Intel 845 Boards / 82801DB IDE Chipset / resource collisions
In-Reply-To: <200207251524.15920.rm@moosauer.de>
Message-ID: <Pine.LNX.4.10.10207250632460.4719-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You opinion is wrong.

It is designed that way to conform to the requirements of WHQL and WinXP.
Doing a generic bitchslap of the resources is dangerous and foolish.
This kind of correction needs to be handled discretely at the device
driver and not at setup, well not as deranged as you have presented.

What you are missing is the following.

If you have more than one pci device in the system reporting with the 
PCI_CLASS_STORAGE_IDE in the class, you end up blowing away the settings.
Cause the only resources it can now about are isa_legacy rules.



On Thu, 25 Jul 2002, Reinhard Moosauer wrote:

> (Please answer to directly to my email too. Thanks!)
> 
> Hello List,
> 
> some people had problems with
> Intel IDE Chips on 845E Boards. ( "resource collisions" )
> 
> Yesterday I had the same problem.
> 
> Alan Cox said:
> > If you look with lspci -v you will find your BIOS has mismapped or
> > forgotten to map some of the control register space for that device.
> >
> > Alan
> 
> IMHO there must be a bios bug (latest rev.), because the io resources are left 
> unassigned. But why does the kernel not fix it?
> After reading many questions and no answers, I looked into the kernel source. 
>  
> I found this block in arch/i386/kernel/pci-i386.c:
> 
> ==================
>      /*
>      *  Don't touch IDE controllers and I/O ports of video cards!
>      */
>       if ((class == PCI_CLASS_STORAGE_IDE && idx < 4) ||
>            (class == PCI_CLASS_DISPLAY_VGA && (r->flags & IORESOURCE_IO)))
>                   continue;
> ====================
> 
> lspci shows indeed the first 4 resources unassigned.
> 
> To work around the problem I inserted these lines:
> (just before the above block)
> 
> ========================
>                         /* HACK
>                          * Reinhard Moosauer, 2002-07-25
>                          */
>                         if ((class == PCI_CLASS_STORAGE_IDE && idx < 4) &&
>                                 (!r->start && r->end)) {
>                           printk(KERN_ERR "HACK: INTEL IDE Workaround for"
>                                " %s Resource %d\n",  dev->slot_name, idx);
> 
> 			/* I ACCEPT NO RESPOSIBILITY FOR ANY DAMAGE */
>                           pci_assign_resource(dev, idx);
>                         }
> ==========================
> 
> 
> It really works. 
> As I saw on the list, many other people had the same problem
> so I thought, the gurus should take a look at this.
> 
> Note1: Please do not use this before anybody gave an OK to it!
> I am just playing sorcerer's apprentice.
> 
> Note2: You need a patch for kernels before 2.4.19 or so to use the new Intel 
> Chipsets (when he says "unknown device 0x24cb" or so) . I have one for 
> 2.4.18.
> 
> I hope, this helps someone.
> 
> Kind regards,
> 
> Reinhard
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

