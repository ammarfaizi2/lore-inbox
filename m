Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272119AbRIJXGI>; Mon, 10 Sep 2001 19:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272116AbRIJXF7>; Mon, 10 Sep 2001 19:05:59 -0400
Received: from hermes.domdv.de ([193.102.202.1]:20740 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S272108AbRIJXFl>;
	Mon, 10 Sep 2001 19:05:41 -0400
Message-ID: <XFMail.20010911010531.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200109102242.f8AMgpY21341@aslan.scsiguy.com>
Date: Tue, 11 Sep 2001 01:05:31 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors)
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <SPATZ1@t-online.de (Frank Schneider)>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The new driver registers a "reboot notifier" with the system.  If MD
> continues to perform I/O after the aic7xxx driver's notification routine
> is called, the result is undefined.  The aic7xxx driver has already
> shutdown the hardware.  Perhaps I should use a different event to indicate
> it is safe for me to clean up the hardware?
> 

Gotcha!

Actually the problem seems to be the raid code and the scsi code do register
reboot notifiers with the same priority (0, see below).

include/linux/notifier.h:
 
struct notifier_block
{
        int (*notifier_call)(struct notifier_block *self, unsigned long, void
*);
        struct notifier_block *next;
        int priority;
};
 
drivers/md/md.c:
 
struct notifier_block md_notifier = {
        md_notify_reboot,
        NULL,
        0
};
 
drivers/scsi/aic7xxx/aic7xxx_linux.c:
 
static struct notifier_block ahc_linux_notifier = {
        ahc_linux_halt, NULL, 0
};

When registering the notifiers it depends on who's registering first at the
same priority level.

kernel/sys.c:
 
int notifier_chain_register(struct notifier_block **list, struct notifier_block
*n)
{
        write_lock(&notifier_lock);
        while(*list)
        {
                if(n->priority > (*list)->priority)
                        break;
                list= &((*list)->next);
        }
        n->next = *list;
        *list=n;
        write_unlock(&notifier_lock);
        return 0;
}

The notifier chin is then processed sequentially.

kernel/sys.c:

int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
{
        int ret=NOTIFY_DONE;
        struct notifier_block *nb = *n;
 
        while(nb)
        {
                ret=nb->notifier_call(nb,val,v);
                if(ret&NOTIFY_STOP_MASK)
                {
                        return ret;
                }
                nb=nb->next;
        }
        return ret;
}

So what's actually required is to set the raid notifier to a higher priority
than the scsi notifier to assert that raid is stopped before scsi.
Unfortunately I can't test this right now as I'm doing work@home and I do need
physical access to the systems (reset button) if it doesn't work out.

Could you please straighten the priority issue out with the raid maintainer?


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
