Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288677AbSAIBLQ>; Tue, 8 Jan 2002 20:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288678AbSAIBLH>; Tue, 8 Jan 2002 20:11:07 -0500
Received: from gear.torque.net ([204.138.244.1]:6670 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S288673AbSAIBK7>;
	Tue, 8 Jan 2002 20:10:59 -0500
Message-ID: <3C3B9853.740E71DA@torque.net>
Date: Tue, 08 Jan 2002 20:09:39 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: admin@nextframe.net
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] drivers/scsi/psi240i.c - io_request_lock fix
In-Reply-To: <20020108150738.B6168@sexything>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morten Helgesen wrote:
> 
> Hey Linus and the rest of you.
> 
> A simple fix for the io_request_lock issue leftovers in drivers/scsi/psi240i.c.
> Not tested, but compiles. Diffed against 2.5.2-pre10. Please apply.
> 

Morten,
There is a bit more involved than just switching
io_request_lock to host_lock. The former is global
so it could be called from anywhere.

>From the look of this line in the patch:
> +       struct Scsi_Host *host = PsiHost[irq - 10];

It will work if the first controller is allocated irq 10,
the second one irq 11, etc.   Unlikely ...

Looking at that driver it seems that it will need a
bit of surgery to pass perhaps a Scsi_Cmnd pointer
through the request_irq() function so you can
follow a pointer chain in do_Irq_Handler() to get
hold of the appropriate host_lock.

In the lk 2.5 series host_lock should indeed be held
when the callback "scsi_done" is invoked and that
most likely occurs in Irq_Handler(). So that is right.

BTW To get a better idea of what is involved, diff the
sym53c8xx driver in lk 2.4.15 and the one in the
lk 2.5 series now [kudos to Gerard Roudier].


Having been burnt by a well meaning advansys patch that
converted a kernel compile time error into a kernel
boot time freeze, it is a bit worrying the number
of "untested" patches of this nature appearing on lkml.

Doug Gilbert


> --- vanilla-linux-2.5.2-pre10/drivers/scsi/psi240i.c    Tue Jan  8 10:57:31 2002
> +++ patched-linux-2.5.2-pre10/drivers/scsi/psi240i.c    Tue Jan  8 14:48:56 2002
> @@ -370,10 +370,11 @@
>  static void do_Irq_Handler (int irq, void *dev_id, struct pt_regs *regs)
>         {
>         unsigned long flags;
> +       struct Scsi_Host *host = PsiHost[irq - 10];
> 
> -       spin_lock_irqsave(&io_request_lock, flags);
> +       spin_lock_irqsave(&host->host_lock, flags);
>         Irq_Handler(irq, dev_id, regs);
> -       spin_unlock_irqrestore(&io_request_lock, flags);
> +       spin_unlock_irqrestore(&host->host_lock, flags);
>         }
>  /****************************************************************
>   *     Name:   Psi240i_QueueCommand
