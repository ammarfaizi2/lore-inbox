Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132577AbQKSQbH>; Sun, 19 Nov 2000 11:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132569AbQKSQar>; Sun, 19 Nov 2000 11:30:47 -0500
Received: from magrathea.systime-solutions.de ([212.66.133.138]:62737 "HELO
	magrathea.systime-solutions.de") by vger.kernel.org with SMTP
	id <S132556AbQKSQah>; Sun, 19 Nov 2000 11:30:37 -0500
Message-ID: <3A1807BB.FDA91DD2@evision-ventures.com>
Date: Sun, 19 Nov 2000 18:02:51 +0100
From: dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision-ventures.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] megaraid driver update for 2.4.0-test10
In-Reply-To: <3A170A06.934405FC@evision-ventures.com> <3A170254.97AFD2A3@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> dalecki wrote:
> > -#if LINUX_VERSION_CODE > 0x020024
> >  #include <asm/uaccess.h>
> > -#endif
> 
> *cheer*

I missd this point...
> 
> > -u32 RDINDOOR (mega_host_config * megaCfg)
> > +ulong RDINDOOR (mega_host_config * megaCfg)
> > -void WRINDOOR (mega_host_config * megaCfg, u32 value)
> > +void WRINDOOR (mega_host_config * megaCfg, ulong value)
> > -u32 RDOUTDOOR (mega_host_config * megaCfg)
> > +ulong RDOUTDOOR (mega_host_config * megaCfg)
> > -void WROUTDOOR (mega_host_config * megaCfg, u32 value)
> > +void WROUTDOOR (mega_host_config * megaCfg, ulong value)
> 
> [unless there is a prototype not seen in the patch...] this looks like
> namespace pollution.  Can you mark these 'static' ?

Agreed.

> > +#define IO_LOCK_T unsigned long io_flags;
> >  #define IO_LOCK spin_lock_irqsave(&io_request_lock,io_flags);
> >  #define IO_UNLOCK spin_unlock_irqrestore(&io_request_lock,io_flags);
> 
> hmmm, I'm not sure if its a good idea to hide this stuff in macros.

It certainly  isn't a good idea. Agreed. I wanted to get this puppy
up and running first before such cleanup, since I don't have access
to all the contoller variants out there.

> 
> > +#ifndef PCI_DEVICE_ID_INTEL_80960_RP
> > +#define PCI_DEVICE_ID_INTEL_80960_RP 0x1960
> > +#endif
> 
> please update include/linux/pci_ids.h too when PCI ids are missing from
> there.  PCI_DEVICE_ID_INTEL_80960_RP at least is not listed there.

Agreed.

> > -static spinlock_t serial_lock = SPIN_LOCK_UNLOCKED;
> > +volatile static spinlock_t serial_lock;
> 
> Why do you need to mark this volatile??
> 
> BUG:  You still need the SPIN_LOCK_UNLOCKED because I don't see an
> associated spin_lock_init in your path.

OK.
 
> > +static int mega_driver_ioctl (mega_host_config * megaCfg, Scsi_Cmnd * SCpnt)
> > +{
> > +  unsigned char *data = (unsigned char *)SCpnt->request_buffer;
> 
> cast not necessary.  request_buffer is a void.

Agreed.
 
> > @@ -820,7 +925,7 @@
> >    mailbox = (mega_mailbox *) & pScb->mboxData;
> >    memset (mailbox, 0, sizeof (pScb->mboxData));
> >
> > -  if (data[0] == 0x03) {       /* passthrough command */
> > + if (data[0] == 0x03) {        /* passthrough command */
> >      unsigned char cdblen = data[2];
> >      pthru = &pScb->pthru;
> >      memset (pthru, 0, sizeof (mega_passthru));
> 
> this file is beginning to look like it needs a CodingStyle reformat.
> -after- the fixes and such have been applied, you might consider running
> 'indent' on this puppy.

Agreed - it needs it really badly. Apparently it was originally written
by someone who does ts=2 or some other such mess...

> 
> > +      switch (data[0])
> > +      {
> > +       case FW_FIRE_WRITE:
> > +       case FW_FIRE_FLASH:
> > +        printk("megaraid:Write/ Flash called\n");
> > +        if ((ulong)user_area & (PAGE_SIZE - 1)) {
> > +          printk("megaraid:user address not aligned on 4K boundary.Error.\n");
> > +          SCpnt->result = (DID_ERROR << 16);
> > +          callDone (SCpnt);
> > +          return NULL;
> > +        }
> > +        break;
> > +       case DCMD_FC_CMD:
> > +        mega_build_user_sg(user_area, xfer_size, pScb, mbox);
> > +        break;
> >        }
> > -      copy_from_user(kern_area,user_area,xfer_size);
> > -      pScb->kern_area = kern_area;
> 
> What happened to copy_from_user?  mega_build_user_sg is called with
> user_area as an arg, and it never calls copy_from_user or similar
> functions.
> 
> (I understand if this is a bug fix to remove copy_from_user, but I just
> want to make sure it is intentional...)
> 
> > +      TRACE (("ISR called reentrantly!!\n"));
> > +      printk ("ISR called reentrantly!!\n");
> 
> All printks need KERN_xxx prefix

Agreed.

> 
> >        else {
> > -        printk(KERN_ERR "megaraid: wrong cmd id completed from firmware:id=%x\n",sIdx);
> > +        printk("megaraid: wrong cmd id completed from firmware:id=%x\n",sIdx);
> 
> hmmm........
> 
> >    /* Copy mailbox data into host structure */
> >    megaCfg->mbox64->xferSegment = 0;
> > -  memcpy (mbox, mboxData, 16);
> > +  memcpy ((char *)mbox, mboxData, 16);
> 
> wrong.  memcpy takes a void* as its first arg, so no need for a cast.

OK...

> > +     while (mbox->numstatus == 0xFF);
> > +     while (mbox->status == 0xFF);
> > +     while (mbox->mraid_poll != 0x77);
> 
> don't you need barriers or something here?
> 
> >    megaCfg->mbox = &megaCfg->mailbox64.mailbox;
> > -  megaCfg->mbox = (mega_mailbox *) ((((u32) megaCfg->mbox) + 16) & 0xfffffff0);
> > +#ifdef __LP64__
> > +  megaCfg->mbox = (mega_mailbox *) ((((u64) megaCfg->mbox) + 16) & ( (ulong)(-1) ^ 0x0F)  );
> >    megaCfg->mbox64 = (mega_mailbox64 *) (megaCfg->mbox - 4);
> > -  paddr = (paddr + 4 + 16) & 0xfffffff0;
> > +  paddr = (paddr + 4 + 16) & ( (u64)(-1) ^ 0x0F );
> > +#else
> > +  megaCfg->mbox = (mega_mailbox *) ((((u32) megaCfg->mbox) + 16) & 0xFFFFFFF0);
> > +  megaCfg->mbox64 = (mega_mailbox64 *) (megaCfg->mbox - 4);
> > +  paddr = (paddr + 4 + 16) & 0xFFFFFFF0;
> > +#endif
> 
> heh
> 
> > +                       pci_read_config_word (pdev,
> > +                                                PCI_SUBSYSTEM_VENDOR_ID,
> > +                                                &subsysvid);
> > +                       pci_read_config_word (pdev,
> > +                                               PCI_SUBSYSTEM_ID,
> > +                                                &subsysid);
> 
> wrong.  get these out of struct pci_dev.
> pci_dev::subsystem_{vendor,device}.

OK I will look into it.

...

Many thank's Jeff for the very helpfull comments!
I will try to look into the issues you have pointed out.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
