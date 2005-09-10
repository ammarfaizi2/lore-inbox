Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbVIJXy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbVIJXy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVIJXy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:54:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57062 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932394AbVIJXy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:54:26 -0400
Date: Sat, 10 Sep 2005 16:53:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/2] drivers/char/isicom old api rewritten
Message-Id: <20050910165356.1ddbcc0c.akpm@osdl.org>
In-Reply-To: <43236A02.9070301@gmail.com>
References: <43236A02.9070301@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> wrote:
>
> This patch removes old api in pci probing and replaces it with new.
>  Firmware loading added.
> 
>  Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
> 
>   drivers/char/isicom.c  | 1056 
>  ++++++++++++++++++++++++-------------------------
>   include/linux/isicom.h |   54 --
>   2 files changed, 539 insertions(+), 571 deletions(-)
> 
>  Patch is here for its size (40 KiB):
>  http://www.fi.muni.cz/~xslaby/lnx/isi_main.txt

40k isn't large - please include such patches in the email.


> +sched_again:
> +	if (!re_schedule)
> +	{

coding style.

> +static void unregister_tty_driver(void)
> +static int register_isr(struct isi_board* board, const int index)

Not a great choice of function names, IMO.  Nicer to have "isicom" in the
name.  Your call.

> +
> +	for(t = jiffies + HZ/100; time_before(jiffies, t); )
> +		;

mdelay()

> +	outw(0, base + 0x8); /* Reset */
> +
> +	for(j = 1; j <= 3; j++) {
> +		for(t = jiffies + HZ; time_before(jiffies, t); )
> +			;

mdelay()

> +
> +	switch (signature) {
> +		case 0xa5:
> +			name = "isi608.bin";
> +			break;

We usually do this:

	switch (...) {
	case N:

> +		for(i = 0; i <= 0x2f; i++)	/* a wee bit of delay */
> +			;

eep.   udelay()

> +		for(i = 0; i <= 0x0f; i++)	/* another wee bit of delay */
> +			;

more eep.

> +/* XXX: should I test it by reading it back and comparing with original like
> + * in load firmware package? */
> +#if 0

hrm

> +	case	MIOCTL_READ_FIRMWARE:
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;

Is this the right place to be performing permission checks?

> +		if(copy_from_user(&frame, argp, sizeof(bin_header)))

	if (

> +			return -EFAULT;
> +

It's just as well this code if ifdefed out.  Avoid using return statements
buried deep in the logic.  It's just asking for resource leaks, now or in
the future.  Aim for a simgle return point per function, or at least keep
all the returns right at the end of the function.

> +		if ((status=inw(base+0x4))!=0) {
> +			printk(KERN_WARNING "ISILoad:Card%d rejected verify header:\nAddress:0x%x \nCount:0x%x \nStatus:0x%x \n",

80 cols

> +		for(i=0;i<=0x0f;i++);	/* another wee bit of delay */

udelay()

> +
> +	if (card >= BOARD_COUNT) {
> +		return -EPERM;
> +	}

unneeded braces.  embedded `return'

> +
> +static void __devexit isicom_remove(struct pci_dev *pdev)
> +{
> +	int idx;
> +
> +        for(idx = 0; idx < BOARD_COUNT; idx++)
> +		if (isi_card[idx].base == pci_resource_start(pdev, 3))
> +			break;
> +

whitespace weevils at work

> +			printk(KERN_ERR "ISICOM: ISA not supported yet.");

newline

> +	retval = pci_register_driver(&isicom_driver);
> +        if (retval < 0) {
> +		printk(KERN_ERR "ISICOM: Unable to register pci driver.\n");
> +		goto error;
>  	}

weevils

> +#define InterruptTheCard(base) (outw(0,(base)+0xc))
> +#define ClearInterrupt(base) (inw((base)+0x0a))

Somewhat risky identifiers for a header file..
