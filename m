Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751761AbWHASUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWHASUd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 14:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWHASUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 14:20:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:60786 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751761AbWHASUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 14:20:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tqBtRDZzCl9VzqKLfr0d+WBlrRhCYz4/Y/W3FYgZZZtTY4M+vHgqc3SSAsDx8FAW9djCzu8GhbVUBYrsW4JAuHXS9yieI/jB+mYjT+zIyN4c1L5h0zTORfolDBZG8mqM18YgQWrqWXw2P7dLrbJmS/xWtbC7I6aGzENzK4AaLCg=
Message-ID: <29495f1d0608011120j8103c5bwd169367ee2d67bc0@mail.gmail.com>
Date: Tue, 1 Aug 2006 13:20:28 -0500
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: "Dave Jones" <davej@redhat.com>, arjan@infradead.org,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
Subject: Re: deprecate and convert some sleep_on variants.
In-Reply-To: <20060801180643.GD22240@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060801180643.GD22240@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/06, Dave Jones <davej@redhat.com> wrote:
> We've been carrying this for a dogs age in Fedora. It'd be good to get
> this in -mm, so that it stands some chance of getting upstreamed at some point.
>
> Signed-off-by: Arjan van de Ven <arjan@infradead.org>
> Signed-off-by: Dave Jones <davej@redhat.com>
>
> diff -urNp --exclude-from=/home/davej/.exclude linux-1060/drivers/block/DAC960.c linux-1070/drivers/block/DAC960.c
> --- linux-1060/drivers/block/DAC960.c
> +++ linux-1070/drivers/block/DAC960.c
> @@ -6132,6 +6132,9 @@ static boolean DAC960_V2_ExecuteUserComm
>    unsigned long flags;
>    unsigned char Channel, TargetID, LogicalDriveNumber;
>    unsigned short LogicalDeviceNumber;
> +  wait_queue_t __wait;
> +
> +  init_waitqueue_entry(&__wait, current);
>
>    spin_lock_irqsave(&Controller->queue_lock, flags);
>    while ((Command = DAC960_AllocateCommand(Controller)) == NULL)
> @@ -6314,11 +6317,18 @@ static boolean DAC960_V2_ExecuteUserComm
>                                         .SegmentByteCount =
>             CommandMailbox->ControllerInfo.DataTransferSize;
>           DAC960_ExecuteCommand(Command);
> +         add_wait_queue(&Controller->CommandWaitQueue, &__wait);
> +         set_current_state(TASK_UNINTERRUPTIBLE);

Could this use prepare_to_wait()

> +
>           while (Controller->V2.NewControllerInformation->PhysicalScanActive)
>             {
>               DAC960_ExecuteCommand(Command);
> -             sleep_on_timeout(&Controller->CommandWaitQueue, HZ);
> +             schedule_timeout(HZ);
> +             set_current_state(TASK_UNINTERRUPTIBLE);

and schedule_timeout_uninterruptible() (which is redundant for the
first invocation, I suppose)

>             }
> +         current->state = TASK_RUNNING;
> +         remove_wait_queue(&Controller->CommandWaitQueue, &__wait);

and finish_wait()?

Same for ibmtr.c ?

Also, would these changes:

> diff -urNp --exclude-from=/home/davej/.exclude linux-1060/include/linux/wait.h linux-1070/include/linux/wait.h
> --- linux-1060/include/linux/wait.h
> +++ linux-1070/include/linux/wait.h

Be better in a separate patch?

Thanks,
Nish
