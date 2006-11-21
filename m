Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031438AbWKUVb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031438AbWKUVb6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031439AbWKUVb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:31:57 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:36637 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1031438AbWKUVbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:31:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HWkN62EHJh6qPrCrzK4wkrBJn7LPtJqxPveOqxOJKZSokZp/DnEmj+ngICNIe1LRmdOD443uSwQZuevldKDkxNmkJde7IfGXgqIqNh7PME/xyvg8thbUArY9opjHZ6IOkQasPX8xgt6Bf9bNqUFirxOATAzl1jILp741OZjFK6Q=
Message-ID: <b637ec0b0611211331l22368cefv968f2b55fa1ff000@mail.gmail.com>
Date: Tue, 21 Nov 2006 22:31:52 +0100
From: "Fabio Comolli" <fabio.comolli@gmail.com>
To: "Alex Dubov" <oakad@yahoo.com>
Subject: Re: [PATCH 1/1] MMC: new version of the TI Flash Media card reader driver
Cc: "kernel list" <linux-kernel@vger.kernel.org>,
       "Pierre Ossman" <drzeus-mmc@drzeus.cx>, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <183693.25832.qm@web36707.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b637ec0b0610282352y7a6d2fdap8fbcbac5be20b48b@mail.gmail.com>
	 <183693.25832.qm@web36707.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex.

I tested two suspend/resume cycles with both a 2GB SD card and a 512MB
MMC card and I can confirm this new version works perfectly with my
FlashMedia controller (kernel is latest git).

Thank you very much!

Regards,
Fabio


On 11/21/06, Alex Dubov <oakad@yahoo.com> wrote:
> The substantial rewrite of the driver addresses following issues:
> 1. Logic error with multi-block writes fixed
> 2. Suspend/resume should now work as expected in all cases (more testing
> may be needed)
> 3. Hardware timeout setup corrected
> 4. Per-socket workqueues replaced by one kthread + tasklets
> 5. Device with pci id 104C:AC8F is now recognized as supported
> ---
>  drivers/misc/tifm_7xx1.c |  371 ++++++++++++++++++------------------
>  drivers/misc/tifm_core.c |   66 +++++-
>  drivers/mmc/tifm_sd.c    |  468
> +++++++++++++++++++++++++---------------------
>  include/linux/tifm.h     |   61 +++---
>  4 files changed, 522 insertions(+), 444 deletions(-)
>
> diff --git a/drivers/misc/tifm_7xx1.c b/drivers/misc/tifm_7xx1.c
> index 1ba8754..ddffa78 100644
> --- a/drivers/misc/tifm_7xx1.c
> +++ b/drivers/misc/tifm_7xx1.c
> @@ -13,63 +13,22 @@ #include <linux/tifm.h>
>  #include <linux/dma-mapping.h>
>
>  #define DRIVER_NAME "tifm_7xx1"
> -#define DRIVER_VERSION "0.6"
> +#define DRIVER_VERSION "0.7"
>
>  static void tifm_7xx1_eject(struct tifm_adapter *fm, struct tifm_dev *sock)
>  {
> -	int cnt;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&fm->lock, flags);
> -	if (!fm->inhibit_new_cards) {
> -		for (cnt = 0; cnt < fm->max_sockets; cnt++) {
> -			if (fm->sockets[cnt] == sock) {
> -				fm->remove_mask |= (1 << cnt);
> -				queue_work(fm->wq, &fm->media_remover);
> -				break;
> -			}
> -		}
> -	}
> -	spin_unlock_irqrestore(&fm->lock, flags);
> -}
> -
> -static void tifm_7xx1_remove_media(void *adapter)
> -{
> -	struct tifm_adapter *fm = adapter;
>  	unsigned long flags;
> -	int cnt;
> -	struct tifm_dev *sock;
>
> -	if (!class_device_get(&fm->cdev))
> -		return;
>  	spin_lock_irqsave(&fm->lock, flags);
> -	for (cnt = 0; cnt < fm->max_sockets; cnt++) {
> -		if (fm->sockets[cnt] && (fm->remove_mask & (1 << cnt))) {
> -			printk(KERN_INFO DRIVER_NAME
> -			       ": demand removing card from socket %d\n", cnt);
> -			sock = fm->sockets[cnt];
> -			fm->sockets[cnt] = NULL;
> -			fm->remove_mask &= ~(1 << cnt);
> -
> -			writel(0x0e00, sock->addr + SOCK_CONTROL);
> -
> -			writel((TIFM_IRQ_FIFOMASK | TIFM_IRQ_CARDMASK) << cnt,
> -				fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
> -			writel((TIFM_IRQ_FIFOMASK | TIFM_IRQ_CARDMASK) << cnt,
> -				fm->addr + FM_SET_INTERRUPT_ENABLE);
> -
> -			spin_unlock_irqrestore(&fm->lock, flags);
> -			device_unregister(&sock->dev);
> -			spin_lock_irqsave(&fm->lock, flags);
> -		}
> -	}
> +	fm->socket_change_set |=  1 << sock->socket_id;
> +	wake_up(&fm->change_set_notify);
>  	spin_unlock_irqrestore(&fm->lock, flags);
> -	class_device_put(&fm->cdev);
>  }
>
>  static irqreturn_t tifm_7xx1_isr(int irq, void *dev_id)
>  {
>  	struct tifm_adapter *fm = dev_id;
> +	struct tifm_dev *sock;
>  	unsigned int irq_status;
>  	unsigned int sock_irq_status, cnt;
>
> @@ -83,42 +42,31 @@ static irqreturn_t tifm_7xx1_isr(int irq
>  	if (irq_status & TIFM_IRQ_ENABLE) {
>  		writel(TIFM_IRQ_ENABLE, fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
>
> -		for (cnt = 0; cnt <  fm->max_sockets; cnt++) {
> -			sock_irq_status = (irq_status >> cnt) &
> -					(TIFM_IRQ_FIFOMASK | TIFM_IRQ_CARDMASK);
> -
> -			if (fm->sockets[cnt]) {
> -				if (sock_irq_status &&
> -						fm->sockets[cnt]->signal_irq)
> -					sock_irq_status = fm->sockets[cnt]->
> -						signal_irq(fm->sockets[cnt],
> -							sock_irq_status);
> +		for (cnt = 0; cnt < fm->num_sockets; cnt++) {
> +			sock = fm->sockets[cnt];
> +			sock_irq_status = (irq_status >> cnt)
> +					  & (TIFM_IRQ_FIFOMASK(1)
> +					     | TIFM_IRQ_CARDMASK(1));
>
> -				if (irq_status & (1 << cnt))
> -					fm->remove_mask |= 1 << cnt;
> -			} else {
> -				if (irq_status & (1 << cnt))
> -					fm->insert_mask |= 1 << cnt;
> -			}
> +			if (sock && sock_irq_status)
> +				sock->signal_irq(sock, sock_irq_status);
>  		}
> +		fm->socket_change_set |= irq_status
> +					 & ((1 << fm->num_sockets) - 1);
>  	}
>  	writel(irq_status, fm->addr + FM_INTERRUPT_STATUS);
>
> -	if (!fm->inhibit_new_cards) {
> -		if (!fm->remove_mask && !fm->insert_mask) {
> -			writel(TIFM_IRQ_ENABLE,
> -				fm->addr + FM_SET_INTERRUPT_ENABLE);
> -		} else {
> -			queue_work(fm->wq, &fm->media_remover);
> -			queue_work(fm->wq, &fm->media_inserter);
> -		}
> -	}
> +	if (!fm->socket_change_set)
> +		writel(TIFM_IRQ_ENABLE, fm->addr + FM_SET_INTERRUPT_ENABLE);
> +	else
> +		wake_up_all(&fm->change_set_notify);
>
>  	spin_unlock(&fm->lock);
>  	return IRQ_HANDLED;
>  }
>
> -static tifm_media_id tifm_7xx1_toggle_sock_power(char __iomem *sock_addr,
> int is_x2)
> +static tifm_media_id tifm_7xx1_toggle_sock_power(char __iomem *sock_addr,
> +						 int is_x2)
>  {
>  	unsigned int s_state;
>  	int cnt;
> @@ -126,8 +74,8 @@ static tifm_media_id tifm_7xx1_toggle_so
>  	writel(0x0e00, sock_addr + SOCK_CONTROL);
>
>  	for (cnt = 0; cnt < 100; cnt++) {
> -		if (!(TIFM_SOCK_STATE_POWERED &
> -				readl(sock_addr + SOCK_PRESENT_STATE)))
> +		if (!(TIFM_SOCK_STATE_POWERED
> +		      &	readl(sock_addr + SOCK_PRESENT_STATE)))
>  			break;
>  		msleep(10);
>  	}
> @@ -150,8 +98,8 @@ static tifm_media_id tifm_7xx1_toggle_so
>  	}
>
>  	for (cnt = 0; cnt < 100; cnt++) {
> -		if ((TIFM_SOCK_STATE_POWERED &
> -				readl(sock_addr + SOCK_PRESENT_STATE)))
> +		if ((TIFM_SOCK_STATE_POWERED
> +		     & readl(sock_addr + SOCK_PRESENT_STATE)))
>  			break;
>  		msleep(10);
>  	}
> @@ -169,129 +117,188 @@ tifm_7xx1_sock_addr(char __iomem *base_a
>  	return base_addr + ((sock_num + 1) << 10);
>  }
>
> -static void tifm_7xx1_insert_media(void *adapter)
> +static int tifm_7xx1_switch_media(struct tifm_adapter *fm)
>  {
> -	struct tifm_adapter *fm = adapter;
>  	unsigned long flags;
>  	tifm_media_id media_id;
>  	char *card_name = "xx";
> -	int cnt, ok_to_register;
> -	unsigned int insert_mask;
> -	struct tifm_dev *new_sock = NULL;
> +	int cnt, rc;
> +	struct tifm_dev *sock;
> +	unsigned int socket_change_set;
>
> -	if (!class_device_get(&fm->cdev))
> -		return;
> -	spin_lock_irqsave(&fm->lock, flags);
> -	insert_mask = fm->insert_mask;
> -	fm->insert_mask = 0;
> -	if (fm->inhibit_new_cards) {
> +	while (1) {
> +		rc = wait_event_interruptible(fm->change_set_notify,
> +					      fm->socket_change_set);
> +		if (rc == -ERESTARTSYS)
> +			try_to_freeze();
> +
> +		spin_lock_irqsave(&fm->lock, flags);
> +		socket_change_set = fm->socket_change_set;
> +		fm->socket_change_set = 0;
>  		spin_unlock_irqrestore(&fm->lock, flags);
> -		class_device_put(&fm->cdev);
> -		return;
> -	}
> -	spin_unlock_irqrestore(&fm->lock, flags);
>
> -	for (cnt = 0; cnt < fm->max_sockets; cnt++) {
> -		if (!(insert_mask & (1 << cnt)))
> +
> +		dev_dbg(fm->dev, "checking media set %x\n",
> +			socket_change_set);
> +
> +		if (kthread_should_stop())
> +			socket_change_set = (1 << fm->num_sockets) - 1;
> +
> +		if (!socket_change_set)
>  			continue;
>
> -		media_id = tifm_7xx1_toggle_sock_power(tifm_7xx1_sock_addr(fm->addr,
> cnt),
> -						       fm->max_sockets == 2);
> -		if (media_id) {
> -			ok_to_register = 0;
> -			new_sock = tifm_alloc_device(fm, cnt);
> -			if (new_sock) {
> -				new_sock->addr = tifm_7xx1_sock_addr(fm->addr,
> -									cnt);
> -				new_sock->media_id = media_id;
> -				switch (media_id) {
> -				case 1:
> -					card_name = "xd";
> -					break;
> -				case 2:
> -					card_name = "ms";
> -					break;
> -				case 3:
> -					card_name = "sd";
> -					break;
> -				default:
> -					break;
> -				}
> -				snprintf(new_sock->dev.bus_id, BUS_ID_SIZE,
> -					"tifm_%s%u:%u", card_name, fm->id, cnt);
> +		for (cnt = 0; cnt < fm->num_sockets; cnt++) {
> +			if (!(socket_change_set & (1 << cnt)))
> +				continue;
> +			sock = fm->sockets[cnt];
> +			if (sock) {
>  				printk(KERN_INFO DRIVER_NAME
> -					": %s card detected in socket %d\n",
> -					card_name, cnt);
> +				       ": demand removing card from socket %d\n",
> +				       cnt);
> +
>  				spin_lock_irqsave(&fm->lock, flags);
> -				if (!fm->sockets[cnt]) {
> -					fm->sockets[cnt] = new_sock;
> -					ok_to_register = 1;
> -				}
> +				fm->sockets[cnt] = NULL;
>  				spin_unlock_irqrestore(&fm->lock, flags);
> -				if (!ok_to_register ||
> -					    device_register(&new_sock->dev)) {
> -					spin_lock_irqsave(&fm->lock, flags);
> -					fm->sockets[cnt] = NULL;
> -					spin_unlock_irqrestore(&fm->lock,
> -								flags);
> -					tifm_free_device(&new_sock->dev);
> +				device_unregister(&sock->dev);
> +				writel(0x0e00,
> +				       tifm_7xx1_sock_addr(fm->addr, cnt)
> +				       + SOCK_CONTROL);
> +			}
> +
> +			if (kthread_should_stop())
> +				continue;
> +			media_id = tifm_7xx1_toggle_sock_power(
> +					tifm_7xx1_sock_addr(fm->addr, cnt),
> +					fm->num_sockets == 2);
> +			if (media_id) {
> +				sock = tifm_alloc_device(fm);
> +				if (sock) {
> +					sock->addr = tifm_7xx1_sock_addr(fm->addr, cnt);
> +					sock->media_id = media_id;
> +					sock->socket_id = cnt;
> +					switch (media_id) {
> +					case 1:
> +						card_name = "xd";
> +						break;
> +					case 2:
> +						card_name = "ms";
> +						break;
> +					case 3:
> +						card_name = "sd";
> +						break;
> +					default:
> +						tifm_free_device(&sock->dev);
> +						continue;
> +					}
> +					snprintf(sock->dev.bus_id, BUS_ID_SIZE,
> +						 "tifm_%s%u:%u", card_name,
> +						 fm->id, cnt);
> +					printk(KERN_INFO DRIVER_NAME
> +					       ": %s card detected in socket %d\n",
> +					       card_name, cnt);
> +					if (!device_register(&sock->dev))
> +						fm->sockets[cnt] = sock;
> +					else
> +						tifm_free_device(&sock->dev);
>  				}
>  			}
>  		}
> -		writel((TIFM_IRQ_FIFOMASK | TIFM_IRQ_CARDMASK) << cnt,
> -		       fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
> -		writel((TIFM_IRQ_FIFOMASK | TIFM_IRQ_CARDMASK) << cnt,
> -		       fm->addr + FM_SET_INTERRUPT_ENABLE);
> -	}
> +		if (!kthread_should_stop()) {
> +			writel(TIFM_IRQ_FIFOMASK(socket_change_set)
> +			       | TIFM_IRQ_CARDMASK(socket_change_set),
> +			       fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
> +			writel(TIFM_IRQ_FIFOMASK(socket_change_set)
> +			       | TIFM_IRQ_CARDMASK(socket_change_set),
> +			       fm->addr + FM_SET_INTERRUPT_ENABLE);
> +			writel(TIFM_IRQ_ENABLE,
> +			       fm->addr + FM_SET_INTERRUPT_ENABLE);
> +		} else {
> +			spin_lock_irqsave(&fm->lock, flags);
> +			for (cnt = 0; cnt < fm->num_sockets; cnt++) {
> +				if (fm->sockets[cnt])
> +					fm->socket_change_set |= 1 << cnt;
> +			}
>
> -	writel(TIFM_IRQ_ENABLE, fm->addr + FM_SET_INTERRUPT_ENABLE);
> -	class_device_put(&fm->cdev);
> +			if (!fm->socket_change_set) {
> +				spin_unlock_irqrestore(&fm->lock, flags);
> +				return 0;
> +			} else {
> +				spin_unlock_irqrestore(&fm->lock, flags);
> +			}
> +		}
> +	}
> +	return 0;
>  }
>
>  static int tifm_7xx1_suspend(struct pci_dev *dev, pm_message_t state)
>  {
> -	struct tifm_adapter *fm = pci_get_drvdata(dev);
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&fm->lock, flags);
> -	fm->inhibit_new_cards = 1;
> -	fm->remove_mask = 0xf;
> -	fm->insert_mask = 0;
> -	writel(TIFM_IRQ_ENABLE, fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
> -	spin_unlock_irqrestore(&fm->lock, flags);
> -	flush_workqueue(fm->wq);
> +	dev_dbg(&dev->dev, "suspending host\n");
>
> -	tifm_7xx1_remove_media(fm);
> -
> -	pci_set_power_state(dev, PCI_D3hot);
> -        pci_disable_device(dev);
> -        pci_save_state(dev);
> +	pci_save_state(dev);
> +	pci_enable_wake(dev, pci_choose_state(dev, state), 0);
> +	pci_disable_device(dev);
> +	pci_set_power_state(dev, pci_choose_state(dev, state));
>  	return 0;
>  }
>
>  static int tifm_7xx1_resume(struct pci_dev *dev)
>  {
>  	struct tifm_adapter *fm = pci_get_drvdata(dev);
> +	int cnt;
>  	unsigned long flags;
> +	tifm_media_id new_ids[fm->num_sockets];
>
> +	pci_set_power_state(dev, PCI_D0);
>  	pci_restore_state(dev);
> -        pci_enable_device(dev);
> -        pci_set_power_state(dev, PCI_D0);
> -        pci_set_master(dev);
> +	pci_enable_device(dev);
> +	pci_set_master(dev);
> +
> +	dev_dbg(&dev->dev, "resuming host\n");
>
> +	for (cnt = 0; cnt < fm->num_sockets; cnt++)
> +		new_ids[cnt] = tifm_7xx1_toggle_sock_power(
> +			tifm_7xx1_sock_addr(fm->addr, cnt),
> +			fm->num_sockets == 2);
>  	spin_lock_irqsave(&fm->lock, flags);
> -	fm->inhibit_new_cards = 0;
> -	writel(TIFM_IRQ_SETALL, fm->addr + FM_INTERRUPT_STATUS);
> -	writel(TIFM_IRQ_SETALL, fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
> -	writel(TIFM_IRQ_ENABLE | TIFM_IRQ_SETALLSOCK,
> -		fm->addr + FM_SET_INTERRUPT_ENABLE);
> -	fm->insert_mask = 0xf;
> +	fm->socket_change_set = 0;
> +	for (cnt = 0; cnt < fm->num_sockets; cnt++) {
> +		if (fm->sockets[cnt]) {
> +			if (fm->sockets[cnt]->media_id == new_ids[cnt])
> +				fm->socket_change_set |= 1 << cnt;
> +
> +			fm->sockets[cnt]->media_id = new_ids[cnt];
> +		}
> +	}
> +
> +	writel(TIFM_IRQ_ENABLE
> +	       | TIFM_IRQ_SOCKMASK((1 << fm->num_sockets) - 1),
> +	       fm->addr + FM_SET_INTERRUPT_ENABLE);
> +	if (!fm->socket_change_set) {
> +		spin_unlock_irqrestore(&fm->lock, flags);
> +		return 0;
> +	} else {
> +		fm->socket_change_set = 0;
> +		spin_unlock_irqrestore(&fm->lock, flags);
> +	}
> +
> +	wait_event_timeout(fm->change_set_notify, fm->socket_change_set, HZ);
> +
> +	spin_lock_irqsave(&fm->lock, flags);
> +	writel(TIFM_IRQ_FIFOMASK(fm->socket_change_set)
> +	       | TIFM_IRQ_CARDMASK(fm->socket_change_set),
> +	       fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
> +	writel(TIFM_IRQ_FIFOMASK(fm->socket_change_set)
> +	       | TIFM_IRQ_CARDMASK(fm->socket_change_set),
> +	       fm->addr + FM_SET_INTERRUPT_ENABLE);
> +	writel(TIFM_IRQ_ENABLE,
> +	       fm->addr + FM_SET_INTERRUPT_ENABLE);
> +	fm->socket_change_set = 0;
>  	spin_unlock_irqrestore(&fm->lock, flags);
>  	return 0;
>  }
>
>  static int tifm_7xx1_probe(struct pci_dev *dev,
> -			const struct pci_device_id *dev_id)
> +			   const struct pci_device_id *dev_id)
>  {
>  	struct tifm_adapter *fm;
>  	int pci_dev_busy = 0;
> @@ -322,19 +329,17 @@ static int tifm_7xx1_probe(struct pci_de
>  	}
>
>  	fm->dev = &dev->dev;
> -	fm->max_sockets = (dev->device == 0x803B) ? 2 : 4;
> -	fm->sockets = kzalloc(sizeof(struct tifm_dev*) * fm->max_sockets,
> -				GFP_KERNEL);
> +	fm->num_sockets = (dev->device == 0x8033) ? 4 : 2;
> +	fm->sockets = kzalloc(sizeof(struct tifm_dev*) * fm->num_sockets,
> +			      GFP_KERNEL);
>  	if (!fm->sockets)
>  		goto err_out_free;
>
> -	INIT_WORK(&fm->media_inserter, tifm_7xx1_insert_media, fm);
> -	INIT_WORK(&fm->media_remover, tifm_7xx1_remove_media, fm);
>  	fm->eject = tifm_7xx1_eject;
>  	pci_set_drvdata(dev, fm);
>
>  	fm->addr = ioremap(pci_resource_start(dev, 0),
> -				pci_resource_len(dev, 0));
> +			   pci_resource_len(dev, 0));
>  	if (!fm->addr)
>  		goto err_out_free;
>
> @@ -342,16 +347,15 @@ static int tifm_7xx1_probe(struct pci_de
>  	if (rc)
>  		goto err_out_unmap;
>
> -	rc = tifm_add_adapter(fm);
> +	init_waitqueue_head(&fm->change_set_notify);
> +	rc = tifm_add_adapter(fm, tifm_7xx1_switch_media);
>  	if (rc)
>  		goto err_out_irq;
>
>  	writel(TIFM_IRQ_SETALL, fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
> -	writel(TIFM_IRQ_ENABLE | TIFM_IRQ_SETALLSOCK,
> -		fm->addr + FM_SET_INTERRUPT_ENABLE);
> -
> -	fm->insert_mask = 0xf;
> -
> +	writel(TIFM_IRQ_ENABLE | TIFM_IRQ_SOCKMASK((1 << fm->num_sockets) - 1),
> +	       fm->addr + FM_SET_INTERRUPT_ENABLE);
> +	wake_up_process(fm->media_switcher);
>  	return 0;
>
>  err_out_irq:
> @@ -375,19 +379,14 @@ static void tifm_7xx1_remove(struct pci_
>  	struct tifm_adapter *fm = pci_get_drvdata(dev);
>  	unsigned long flags;
>
> +	free_irq(dev->irq, fm);
> +	writel(TIFM_IRQ_SETALL, fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
> +
>  	spin_lock_irqsave(&fm->lock, flags);
> -	fm->inhibit_new_cards = 1;
> -	fm->remove_mask = 0xf;
> -	fm->insert_mask = 0;
> -	writel(TIFM_IRQ_ENABLE, fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
> +	fm->socket_change_set = (1 << fm->num_sockets) - 1;
>  	spin_unlock_irqrestore(&fm->lock, flags);
>
> -	flush_workqueue(fm->wq);
> -
> -	tifm_7xx1_remove_media(fm);
> -
> -	writel(TIFM_IRQ_SETALL, fm->addr + FM_CLEAR_INTERRUPT_ENABLE);
> -	free_irq(dev->irq, fm);
> +	kthread_stop(fm->media_switcher);
>
>  	tifm_remove_adapter(fm);
>
> @@ -404,8 +403,10 @@ static void tifm_7xx1_remove(struct pci_
>  static struct pci_device_id tifm_7xx1_pci_tbl [] = {
>  	{ PCI_VENDOR_ID_TI, 0x8033, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  0 }, /* xx21 - the one I have */
> -        { PCI_VENDOR_ID_TI, 0x803B, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -	  0 }, /* xx12 - should be also supported */
> +	{ PCI_VENDOR_ID_TI, 0x803B, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  0 },
> +	{ PCI_VENDOR_ID_TI, 0xAC8F, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  0 },
>  	{ }
>  };
>
> diff --git a/drivers/misc/tifm_core.c b/drivers/misc/tifm_core.c
> index ee32613..9af252e 100644
> --- a/drivers/misc/tifm_core.c
> +++ b/drivers/misc/tifm_core.c
> @@ -14,11 +14,14 @@ #include <linux/init.h>
>  #include <linux/idr.h>
>
>  #define DRIVER_NAME "tifm_core"
> -#define DRIVER_VERSION "0.6"
> +#define DRIVER_VERSION "0.7"
>
>  static DEFINE_IDR(tifm_adapter_idr);
>  static DEFINE_SPINLOCK(tifm_adapter_lock);
>
> +static int tifm_device_suspend(struct device *dev, pm_message_t state);
> +static int tifm_device_resume(struct device *dev);
> +
>  static tifm_media_id *tifm_device_match(tifm_media_id *ids,
>  			struct tifm_dev *dev)
>  {
> @@ -64,15 +67,17 @@ static struct bus_type tifm_bus_type = {
>  	.name    = "tifm",
>  	.match   = tifm_match,
>  	.uevent  = tifm_uevent,
> +	.suspend = tifm_device_suspend,
> +	.resume  = tifm_device_resume
>  };
>
>  static void tifm_free(struct class_device *cdev)
>  {
>  	struct tifm_adapter *fm = container_of(cdev, struct tifm_adapter, cdev);
>
> -	kfree(fm->sockets);
> -	if (fm->wq)
> -		destroy_workqueue(fm->wq);
> +	/* sockets array can be NULL if adapter probe fails */
> +	if (fm->sockets)
> +		kfree(fm->sockets);
>  	kfree(fm);
>  }
>
> @@ -101,7 +106,8 @@ void tifm_free_adapter(struct tifm_adapt
>  }
>  EXPORT_SYMBOL(tifm_free_adapter);
>
> -int tifm_add_adapter(struct tifm_adapter *fm)
> +int tifm_add_adapter(struct tifm_adapter *fm,
> +		     int (*mediathreadfn)(struct tifm_adapter *fm))
>  {
>  	int rc;
>
> @@ -113,10 +119,10 @@ int tifm_add_adapter(struct tifm_adapter
>  	spin_unlock(&tifm_adapter_lock);
>  	if (!rc) {
>  		snprintf(fm->cdev.class_id, BUS_ID_SIZE, "tifm%u", fm->id);
> -		strncpy(fm->wq_name, fm->cdev.class_id, KOBJ_NAME_LEN);
> +		fm->media_switcher = kthread_create((int (*)(void *data))mediathreadfn,
> +						    fm, "tifm/%u", fm->id);
>
> -		fm->wq = create_singlethread_workqueue(fm->wq_name);
> -		if (fm->wq)
> +		if (fm->media_switcher != ERR_PTR(-ENOMEM))
>  			return class_device_add(&fm->cdev);
>
>  		spin_lock(&tifm_adapter_lock);
> @@ -141,27 +147,26 @@ EXPORT_SYMBOL(tifm_remove_adapter);
>  void tifm_free_device(struct device *dev)
>  {
>  	struct tifm_dev *fm_dev = container_of(dev, struct tifm_dev, dev);
> -	if (fm_dev->wq)
> -		destroy_workqueue(fm_dev->wq);
>  	kfree(fm_dev);
>  }
>  EXPORT_SYMBOL(tifm_free_device);
>
> -struct tifm_dev *tifm_alloc_device(struct tifm_adapter *fm, unsigned int
> id)
> +static void tifm_dummy_signal_irq(struct tifm_dev *sock,
> +				  unsigned int sock_irq_status)
> +{
> +	return;
> +}
> +
> +struct tifm_dev *tifm_alloc_device(struct tifm_adapter *fm)
>  {
>  	struct tifm_dev *dev = kzalloc(sizeof(struct tifm_dev), GFP_KERNEL);
>
>  	if (dev) {
>  		spin_lock_init(&dev->lock);
> -		snprintf(dev->wq_name, KOBJ_NAME_LEN, "tifm%u:%u", fm->id, id);
> -		dev->wq = create_singlethread_workqueue(dev->wq_name);
> -		if (!dev->wq) {
> -			kfree(dev);
> -			return NULL;
> -		}
>  		dev->dev.parent = fm->dev;
>  		dev->dev.bus = &tifm_bus_type;
>  		dev->dev.release = tifm_free_device;
> +		dev->signal_irq = tifm_dummy_signal_irq;
>  	}
>  	return dev;
>  }
> @@ -219,7 +224,10 @@ static int tifm_device_remove(struct dev
>  	struct tifm_driver *drv = fm_dev->drv;
>
>  	if (drv) {
> -		if (drv->remove) drv->remove(fm_dev);
> +		if (drv->remove) {
> +			fm_dev->signal_irq = tifm_dummy_signal_irq;
> +			drv->remove(fm_dev);
> +		}
>  		fm_dev->drv = 0;
>  	}
>
> @@ -227,11 +235,33 @@ static int tifm_device_remove(struct dev
>  	return 0;
>  }
>
> +static int tifm_device_suspend(struct device *dev, pm_message_t state)
> +{
> +	struct tifm_dev *fm_dev = container_of(dev, struct tifm_dev, dev);
> +	struct tifm_driver *drv = fm_dev->drv;
> +
> +	if (drv && drv->suspend)
> +		return drv->suspend(fm_dev, state);
> +	return 0;
> +}
> +
> +static int tifm_device_resume(struct device *dev)
> +{
> +	struct tifm_dev *fm_dev = container_of(dev, struct tifm_dev, dev);
> +	struct tifm_driver *drv = fm_dev->drv;
> +
> +	if (drv && drv->resume)
> +		return drv->resume(fm_dev);
> +	return 0;
> +}
> +
>  int tifm_register_driver(struct tifm_driver *drv)
>  {
>  	drv->driver.bus = &tifm_bus_type;
>  	drv->driver.probe = tifm_device_probe;
>  	drv->driver.remove = tifm_device_remove;
> +	drv->driver.suspend = tifm_device_suspend;
> +	drv->driver.resume = tifm_device_resume;
>
>  	return driver_register(&drv->driver);
>  }
> diff --git a/drivers/mmc/tifm_sd.c b/drivers/mmc/tifm_sd.c
> index 0fdc55b..68d1b1a 100644
> --- a/drivers/mmc/tifm_sd.c
> +++ b/drivers/mmc/tifm_sd.c
> @@ -17,7 +17,7 @@ #include <linux/highmem.h>
>  #include <asm/io.h>
>
>  #define DRIVER_NAME "tifm_sd"
> -#define DRIVER_VERSION "0.6"
> +#define DRIVER_VERSION "0.7"
>
>  static int no_dma = 0;
>  static int fixed_timeout = 0;
> @@ -79,7 +79,6 @@ typedef enum {
>
>  enum {
>  	FIFO_RDY   = 0x0001,     /* hardware dependent value */
> -	HOST_REG   = 0x0002,
>  	EJECT      = 0x0004,
>  	EJECT_DONE = 0x0008,
>  	CARD_BUSY  = 0x0010,
> @@ -95,61 +94,71 @@ struct tifm_sd {
>  	card_state_t        state;
>  	unsigned int        clk_freq;
>  	unsigned int        clk_div;
> -	unsigned long       timeout_jiffies; // software timeout - 2 sec
> +	unsigned long       timeout_jiffies;
>
> +	struct tasklet_struct finish_tasklet;
> +	struct timer_list     timer;
>  	struct mmc_request    *req;
> -	struct work_struct    cmd_handler;
> -	struct work_struct    abort_handler;
> -	wait_queue_head_t     can_eject;
> +	wait_queue_head_t     notify;
>
>  	size_t                written_blocks;
> -	char                  *buffer;
>  	size_t                buffer_size;
>  	size_t                buffer_pos;
>
>  };
>
> +static char* tifm_sd_kmap_atomic(struct mmc_data *data)
> +{
> +	return kmap_atomic(data->sg->page, KM_BIO_SRC_IRQ) + data->sg->offset;
> +}
> +
> +static void tifm_sd_kunmap_atomic(char *buffer, struct mmc_data *data)
> +{
> +	kunmap_atomic(buffer - data->sg->offset, KM_BIO_SRC_IRQ);
> +}
> +
>  static int tifm_sd_transfer_data(struct tifm_dev *sock, struct tifm_sd
> *host,
> -					unsigned int host_status)
> +				 unsigned int host_status)
>  {
>  	struct mmc_command *cmd = host->req->cmd;
>  	unsigned int t_val = 0, cnt = 0;
> +	char *buffer;
>
>  	if (host_status & TIFM_MMCSD_BRS) {
>  		/* in non-dma rx mode BRS fires when fifo is still not empty */
> -		if (host->buffer && (cmd->data->flags & MMC_DATA_READ)) {
> +		if (no_dma && (cmd->data->flags & MMC_DATA_READ)) {
> +			buffer = tifm_sd_kmap_atomic(host->req->data);
>  			while (host->buffer_size > host->buffer_pos) {
>  				t_val = readl(sock->addr + SOCK_MMCSD_DATA);
> -				host->buffer[host->buffer_pos++] = t_val & 0xff;
> -				host->buffer[host->buffer_pos++] =
> -							(t_val >> 8) & 0xff;
> +				buffer[host->buffer_pos++] = t_val & 0xff;
> +				buffer[host->buffer_pos++] = (t_val >> 8) & 0xff;
>  			}
> +			tifm_sd_kunmap_atomic(buffer, host->req->data);
>  		}
>  		return 1;
> -	} else if (host->buffer) {
> +	} else if (no_dma) {
> +		buffer = tifm_sd_kmap_atomic(host->req->data);
>  		if ((cmd->data->flags & MMC_DATA_READ) &&
>  				(host_status & TIFM_MMCSD_AF)) {
>  			for (cnt = 0; cnt < TIFM_MMCSD_FIFO_SIZE; cnt++) {
>  				t_val = readl(sock->addr + SOCK_MMCSD_DATA);
>  				if (host->buffer_size > host->buffer_pos) {
> -					host->buffer[host->buffer_pos++] =
> -							t_val & 0xff;
> -					host->buffer[host->buffer_pos++] =
> -							(t_val >> 8) & 0xff;
> +					buffer[host->buffer_pos++] = t_val & 0xff;
> +					buffer[host->buffer_pos++] = (t_val >> 8) & 0xff;
>  				}
>  			}
>  		} else if ((cmd->data->flags & MMC_DATA_WRITE)
>  			   && (host_status & TIFM_MMCSD_AE)) {
>  			for (cnt = 0; cnt < TIFM_MMCSD_FIFO_SIZE; cnt++) {
>  				if (host->buffer_size > host->buffer_pos) {
> -					t_val = host->buffer[host->buffer_pos++] & 0x00ff;
> -					t_val |= ((host->buffer[host->buffer_pos++]) << 8)
> +					t_val = buffer[host->buffer_pos++] & 0x00ff;
> +					t_val |= ((buffer[host->buffer_pos++]) << 8)
>  						 & 0xff00;
> -					writel(t_val,
> -						sock->addr + SOCK_MMCSD_DATA);
> +					writel(t_val, sock->addr + SOCK_MMCSD_DATA);
>  				}
>  			}
>  		}
> +		tifm_sd_kunmap_atomic(buffer, host->req->data);
>  	}
>  	return 0;
>  }
> @@ -209,7 +218,7 @@ static void tifm_sd_exec(struct tifm_sd
>  		cmd_mask |= TIFM_MMCSD_READ;
>
>  	dev_dbg(&sock->dev, "executing opcode 0x%x, arg: 0x%x, mask: 0x%x\n",
> -				cmd->opcode, cmd->arg, cmd_mask);
> +		cmd->opcode, cmd->arg, cmd_mask);
>
>  	writel((cmd->arg >> 16) & 0xffff, sock->addr + SOCK_MMCSD_ARG_HIGH);
>  	writel(cmd->arg & 0xffff, sock->addr + SOCK_MMCSD_ARG_LOW);
> @@ -249,58 +258,69 @@ change_state:
>  		break;
>  	case BRS:
>  		if (tifm_sd_transfer_data(sock, host, host_status)) {
> -			if (!host->req->stop) {
> -				if (cmd->data->flags & MMC_DATA_WRITE) {
> -					host->state = CARD;
> +			if (cmd->data->flags & MMC_DATA_WRITE) {
> +				host->state = CARD;
> +			} else {
> +				if (no_dma) {
> +					if (host->req->stop) {
> +						tifm_sd_exec(host, host->req->stop);
> +						host->state = SCMD;
> +					} else {
> +						host->state = READY;
> +					}
>  				} else {
> -					host->state =
> -						host->buffer ? READY : FIFO;
> +					host->state = FIFO;
>  				}
> -				goto change_state;
>  			}
> -			tifm_sd_exec(host, host->req->stop);
> -			host->state = SCMD;
> +			goto change_state;
>  		}
>  		break;
>  	case SCMD:
>  		if (host_status & TIFM_MMCSD_EOC) {
>  			tifm_sd_fetch_resp(host->req->stop, sock);
> -			if (cmd->error) {
> -				host->state = READY;
> -			} else if (cmd->data->flags & MMC_DATA_WRITE) {
> -				host->state = CARD;
> -			} else {
> -				host->state = host->buffer ? READY : FIFO;
> -			}
> +			host->state = READY;
>  			goto change_state;
>  		}
>  		break;
>  	case CARD:
> +		dev_dbg(&sock->dev, "waiting for CARD, have %ld blocks\n",
> +			host->written_blocks);
>  		if (!(host->flags & CARD_BUSY)
>  		    && (host->written_blocks == cmd->data->blocks)) {
> -			host->state = host->buffer ? READY : FIFO;
> +			if (no_dma) {
> +				if (host->req->stop) {
> +					tifm_sd_exec(host, host->req->stop);
> +					host->state = SCMD;
> +				} else {
> +					host->state = READY;
> +				}
> +			} else {
> +				host->state = FIFO;
> +			}
>  			goto change_state;
>  		}
>  		break;
>  	case FIFO:
>  		if (host->flags & FIFO_RDY) {
> -			host->state = READY;
>  			host->flags &= ~FIFO_RDY;
> +			if (host->req->stop) {
> +				tifm_sd_exec(host, host->req->stop);
> +				host->state = SCMD;
> +			} else {
> +				host->state = READY;
> +			}
>  			goto change_state;
>  		}
>  		break;
>  	case READY:
> -		queue_work(sock->wq, &host->cmd_handler);
> +		tasklet_schedule(&host->finish_tasklet);
>  		return;
>  	}
> -
> -	queue_delayed_work(sock->wq, &host->abort_handler,
> -				host->timeout_jiffies);
>  }
>
>  /* Called from interrupt handler */
> -static unsigned int tifm_sd_signal_irq(struct tifm_dev *sock,
> -					unsigned int sock_irq_status)
> +static void tifm_sd_signal_irq(struct tifm_dev *sock,
> +			       unsigned int sock_irq_status)
>  {
>  	struct tifm_sd *host;
>  	unsigned int host_status = 0, fifo_status = 0;
> @@ -308,12 +328,10 @@ static unsigned int tifm_sd_signal_irq(s
>
>  	spin_lock(&sock->lock);
>  	host = mmc_priv((struct mmc_host*)tifm_get_drvdata(sock));
> -	cancel_delayed_work(&host->abort_handler);
>
>  	if (sock_irq_status & FIFO_EVENT) {
>  		fifo_status = readl(sock->addr + SOCK_DMA_FIFO_STATUS);
>  		writel(fifo_status, sock->addr + SOCK_DMA_FIFO_STATUS);
> -
>  		host->flags |= fifo_status & FIFO_RDY;
>  	}
>
> @@ -321,19 +339,17 @@ static unsigned int tifm_sd_signal_irq(s
>  		host_status = readl(sock->addr + SOCK_MMCSD_STATUS);
>  		writel(host_status, sock->addr + SOCK_MMCSD_STATUS);
>
> -		if (!(host->flags & HOST_REG))
> -			queue_work(sock->wq, &host->cmd_handler);
>  		if (!host->req)
>  			goto done;
>
>  		if (host_status & TIFM_MMCSD_ERRMASK) {
>  			if (host_status & TIFM_MMCSD_CERR)
>  				error_code = MMC_ERR_FAILED;
> -			else if (host_status &
> -					(TIFM_MMCSD_CTO | TIFM_MMCSD_DTO))
> +			else if (host_status
> +				 & (TIFM_MMCSD_CTO | TIFM_MMCSD_DTO))
>  				error_code = MMC_ERR_TIMEOUT;
> -			else if (host_status &
> -					(TIFM_MMCSD_CCRC | TIFM_MMCSD_DCRC))
> +			else if (host_status
> +				 & (TIFM_MMCSD_CCRC | TIFM_MMCSD_DCRC))
>  				error_code = MMC_ERR_BADCRC;
>
>  			writel(TIFM_FIFO_INT_SETALL,
> @@ -343,12 +359,9 @@ static unsigned int tifm_sd_signal_irq(s
>  			if (host->req->stop) {
>  				if (host->state == SCMD) {
>  					host->req->stop->error = error_code;
> -				} else if(host->state == BRS) {
> +				} else if (host->state == BRS) {
>  					host->req->cmd->error = error_code;
>  					tifm_sd_exec(host, host->req->stop);
> -					queue_delayed_work(sock->wq,
> -						&host->abort_handler,
> -						host->timeout_jiffies);
>  					host->state = SCMD;
>  					goto done;
>  				} else {
> @@ -362,8 +375,8 @@ static unsigned int tifm_sd_signal_irq(s
>
>  		if (host_status & TIFM_MMCSD_CB)
>  			host->flags |= CARD_BUSY;
> -		if ((host_status & TIFM_MMCSD_EOFB) &&
> -				(host->flags & CARD_BUSY)) {
> +		if ((host_status & TIFM_MMCSD_EOFB)
> +		    && (host->flags & CARD_BUSY)) {
>  			host->written_blocks++;
>  			host->flags &= ~CARD_BUSY;
>  		}
> @@ -373,17 +386,43 @@ static unsigned int tifm_sd_signal_irq(s
>  		tifm_sd_process_cmd(sock, host, host_status);
>  done:
>  	dev_dbg(&sock->dev, "host_status %x, fifo_status %x\n",
> -			host_status, fifo_status);
> +		host_status, fifo_status);
>  	spin_unlock(&sock->lock);
> -	return sock_irq_status;
>  }
>
> -static void tifm_sd_prepare_data(struct tifm_sd *card, struct mmc_command
> *cmd)
> +static void tifm_sd_terminate(struct tifm_sd *host)
> +{
> +	struct tifm_dev *sock = host->dev;
> +	unsigned long flags;
> +
> +	writel(0, sock->addr + SOCK_MMCSD_INT_ENABLE);
> +	spin_lock_irqsave(&sock->lock, flags);
> +	host->flags |= EJECT;
> +	if (host->req) {
> +		writel(TIFM_FIFO_INT_SETALL,
> +		       sock->addr + SOCK_DMA_FIFO_INT_ENABLE_CLEAR);
> +		writel(0, sock->addr + SOCK_DMA_FIFO_INT_ENABLE_SET);
> +		tasklet_schedule(&host->finish_tasklet);
> +	}
> +	spin_unlock_irqrestore(&sock->lock, flags);
> +}
> +
> +static void tifm_sd_timeout(struct tifm_sd *host)
>  {
> -	struct tifm_dev *sock = card->dev;
> +	printk(KERN_ERR DRIVER_NAME
> +	       ": card failed to respond for a long period of time\n");
> +	tifm_sd_terminate(host);
> +	tifm_eject(host->dev);
> +}
> +
> +static void tifm_sd_prepare_data(struct tifm_sd *host, struct mmc_command
> *cmd)
> +{
> +	struct tifm_dev *sock = host->dev;
>  	unsigned int dest_cnt;
>
>  	/* DMA style IO */
> +	dev_dbg(&sock->dev, "setting dma for %d blocks\n",
> +		cmd->data->blocks);
>
>  	writel(TIFM_FIFO_INT_SETALL,
>  		sock->addr + SOCK_DMA_FIFO_INT_ENABLE_CLEAR);
> @@ -410,7 +449,7 @@ static void tifm_sd_prepare_data(struct
>  }
>
>  static void tifm_sd_set_data_timeout(struct tifm_sd *host,
> -					struct mmc_data *data)
> +				     struct mmc_data *data)
>  {
>  	struct tifm_dev *sock = host->dev;
>  	unsigned int data_timeout = data->timeout_clks;
> @@ -419,22 +458,21 @@ static void tifm_sd_set_data_timeout(str
>  		return;
>
>  	data_timeout += data->timeout_ns /
> -			((1000000000 / host->clk_freq) * host->clk_div);
> -	data_timeout *= 10; // call it fudge factor for now
> +			((1000000000UL / host->clk_freq) * host->clk_div);
>
>  	if (data_timeout < 0xffff) {
> -		writel((~TIFM_MMCSD_DPE) &
> -				readl(sock->addr + SOCK_MMCSD_SDIO_MODE_CONFIG),
> -		       sock->addr + SOCK_MMCSD_SDIO_MODE_CONFIG);
>  		writel(data_timeout, sock->addr + SOCK_MMCSD_DATA_TO);
> +		writel((~TIFM_MMCSD_DPE)
> +		       & readl(sock->addr + SOCK_MMCSD_SDIO_MODE_CONFIG),
> +		       sock->addr + SOCK_MMCSD_SDIO_MODE_CONFIG);
>  	} else {
> -		writel(TIFM_MMCSD_DPE |
> -				readl(sock->addr + SOCK_MMCSD_SDIO_MODE_CONFIG),
> -			sock->addr + SOCK_MMCSD_SDIO_MODE_CONFIG);
>  		data_timeout = (data_timeout >> 10) + 1;
> -		if(data_timeout > 0xffff)
> +		if (data_timeout > 0xffff)
>  			data_timeout = 0;	/* set to unlimited */
>  		writel(data_timeout, sock->addr + SOCK_MMCSD_DATA_TO);
> +		writel(TIFM_MMCSD_DPE
> +		       | readl(sock->addr + SOCK_MMCSD_SDIO_MODE_CONFIG),
> +			sock->addr + SOCK_MMCSD_SDIO_MODE_CONFIG);
>  	}
>  }
>
> @@ -477,11 +515,10 @@ static void tifm_sd_request(struct mmc_h
>  	}
>
>  	host->req = mrq;
> +	mod_timer(&host->timer, jiffies + host->timeout_jiffies);
>  	host->state = CMD;
> -	queue_delayed_work(sock->wq, &host->abort_handler,
> -				host->timeout_jiffies);
>  	writel(TIFM_CTRL_LED | readl(sock->addr + SOCK_CONTROL),
> -		sock->addr + SOCK_CONTROL);
> +	       sock->addr + SOCK_CONTROL);
>  	tifm_sd_exec(host, mrq->cmd);
>  	spin_unlock_irqrestore(&sock->lock, flags);
>  	return;
> @@ -496,9 +533,8 @@ err_out:
>  	mmc_request_done(mmc, mrq);
>  }
>
> -static void tifm_sd_end_cmd(void *data)
> +static void tifm_sd_end_cmd(struct tifm_sd *host)
>  {
> -	struct tifm_sd *host = data;
>  	struct tifm_dev *sock = host->dev;
>  	struct mmc_host *mmc = tifm_get_drvdata(sock);
>  	struct mmc_request *mrq;
> @@ -507,6 +543,7 @@ static void tifm_sd_end_cmd(void *data)
>
>  	spin_lock_irqsave(&sock->lock, flags);
>
> +	del_timer(&host->timer);
>  	mrq = host->req;
>  	host->req = NULL;
>  	host->state = IDLE;
> @@ -547,15 +584,6 @@ static void tifm_sd_request_nodma(struct
>  	struct tifm_dev *sock = host->dev;
>  	unsigned long flags;
>  	struct mmc_data *r_data = mrq->cmd->data;
> -	char *t_buffer = NULL;
> -
> -	if (r_data) {
> -		t_buffer = kmap(r_data->sg->page);
> -		if (!t_buffer) {
> -			printk(KERN_ERR DRIVER_NAME ": kmap failed\n");
> -			goto err_out;
> -		}
> -	}
>
>  	spin_lock_irqsave(&sock->lock, flags);
>  	if (host->flags & EJECT) {
> @@ -572,15 +600,14 @@ static void tifm_sd_request_nodma(struct
>  	if (r_data) {
>  		tifm_sd_set_data_timeout(host, r_data);
>
> -		host->buffer = t_buffer + r_data->sg->offset;
> -		host->buffer_size = mrq->cmd->data->blocks *
> -					mrq->cmd->data->blksz;
> +		host->buffer_size = mrq->cmd->data->blocks
> +				    * mrq->cmd->data->blksz;
>
> -		writel(TIFM_MMCSD_BUFINT |
> -				readl(sock->addr + SOCK_MMCSD_INT_ENABLE),
> +		writel(TIFM_MMCSD_BUFINT
> +		       | readl(sock->addr + SOCK_MMCSD_INT_ENABLE),
>  		       sock->addr + SOCK_MMCSD_INT_ENABLE);
> -		writel(((TIFM_MMCSD_FIFO_SIZE - 1) << 8) |
> -				(TIFM_MMCSD_FIFO_SIZE - 1),
> +		writel(((TIFM_MMCSD_FIFO_SIZE - 1) << 8)
> +		       | (TIFM_MMCSD_FIFO_SIZE - 1),
>  		       sock->addr + SOCK_MMCSD_BUFFER_CONFIG);
>
>  		host->written_blocks = 0;
> @@ -591,26 +618,21 @@ static void tifm_sd_request_nodma(struct
>  	}
>
>  	host->req = mrq;
> +	mod_timer(&host->timer, jiffies + host->timeout_jiffies);
>  	host->state = CMD;
> -	queue_delayed_work(sock->wq, &host->abort_handler,
> -				host->timeout_jiffies);
>  	writel(TIFM_CTRL_LED | readl(sock->addr + SOCK_CONTROL),
> -		sock->addr + SOCK_CONTROL);
> +	       sock->addr + SOCK_CONTROL);
>  	tifm_sd_exec(host, mrq->cmd);
>  	spin_unlock_irqrestore(&sock->lock, flags);
>  	return;
>
>  err_out:
> -	if (t_buffer)
> -		kunmap(r_data->sg->page);
> -
>  	mrq->cmd->error = MMC_ERR_TIMEOUT;
>  	mmc_request_done(mmc, mrq);
>  }
>
> -static void tifm_sd_end_cmd_nodma(void *data)
> +static void tifm_sd_end_cmd_nodma(struct tifm_sd *host)
>  {
> -	struct tifm_sd *host = (struct tifm_sd*)data;
>  	struct tifm_dev *sock = host->dev;
>  	struct mmc_host *mmc = tifm_get_drvdata(sock);
>  	struct mmc_request *mrq;
> @@ -619,6 +641,7 @@ static void tifm_sd_end_cmd_nodma(void *
>
>  	spin_lock_irqsave(&sock->lock, flags);
>
> +	del_timer(&host->timer);
>  	mrq = host->req;
>  	host->req = NULL;
>  	host->state = IDLE;
> @@ -636,8 +659,8 @@ static void tifm_sd_end_cmd_nodma(void *
>  			sock->addr + SOCK_MMCSD_INT_ENABLE);
>
>  		if (r_data->flags & MMC_DATA_WRITE) {
> -			r_data->bytes_xfered = host->written_blocks *
> -						r_data->blksz;
> +			r_data->bytes_xfered = host->written_blocks
> +					       * r_data->blksz;
>  		} else {
>  			r_data->bytes_xfered = r_data->blocks -
>  				readl(sock->addr + SOCK_MMCSD_NUM_BLOCKS) - 1;
> @@ -645,7 +668,6 @@ static void tifm_sd_end_cmd_nodma(void *
>  			r_data->bytes_xfered += r_data->blksz -
>  				readl(sock->addr + SOCK_MMCSD_BLOCK_LEN) + 1;
>  		}
> -		host->buffer = NULL;
>  		host->buffer_pos = 0;
>  		host->buffer_size = 0;
>  	}
> @@ -655,19 +677,9 @@ static void tifm_sd_end_cmd_nodma(void *
>
>  	spin_unlock_irqrestore(&sock->lock, flags);
>
> -        if (r_data)
> -		kunmap(r_data->sg->page);
> -
>  	mmc_request_done(mmc, mrq);
>  }
>
> -static void tifm_sd_abort(void *data)
> -{
> -	printk(KERN_ERR DRIVER_NAME
> -		": card failed to respond for a long period of time");
> -	tifm_eject(((struct tifm_sd*)data)->dev);
> -}
> -
>  static void tifm_sd_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct tifm_sd *host = mmc_priv(mmc);
> @@ -683,9 +695,9 @@ static void tifm_sd_ios(struct mmc_host
>  		writel(TIFM_MMCSD_4BBUS | readl(sock->addr + SOCK_MMCSD_CONFIG),
>  		       sock->addr + SOCK_MMCSD_CONFIG);
>  	} else {
> -		writel((~TIFM_MMCSD_4BBUS) &
> -				readl(sock->addr + SOCK_MMCSD_CONFIG),
> -			sock->addr + SOCK_MMCSD_CONFIG);
> +		writel((~TIFM_MMCSD_4BBUS)
> +		       & readl(sock->addr + SOCK_MMCSD_CONFIG),
> +		       sock->addr + SOCK_MMCSD_CONFIG);
>  	}
>
>  	if (ios->clock) {
> @@ -704,23 +716,24 @@ static void tifm_sd_ios(struct mmc_host
>  		if ((20000000 / clk_div1) > (24000000 / clk_div2)) {
>  			host->clk_freq = 20000000;
>  			host->clk_div = clk_div1;
> -			writel((~TIFM_CTRL_FAST_CLK) &
> -					readl(sock->addr + SOCK_CONTROL),
> -				sock->addr + SOCK_CONTROL);
> +			writel((~TIFM_CTRL_FAST_CLK)
> +			       & readl(sock->addr + SOCK_CONTROL),
> +			       sock->addr + SOCK_CONTROL);
>  		} else {
>  			host->clk_freq = 24000000;
>  			host->clk_div = clk_div2;
> -			writel(TIFM_CTRL_FAST_CLK |
> -					readl(sock->addr + SOCK_CONTROL),
> -				sock->addr + SOCK_CONTROL);
> +			writel(TIFM_CTRL_FAST_CLK
> +			       | readl(sock->addr + SOCK_CONTROL),
> +			       sock->addr + SOCK_CONTROL);
>  		}
>  	} else {
>  		host->clk_div = 0;
>  	}
>  	host->clk_div &= TIFM_MMCSD_CLKMASK;
> -	writel(host->clk_div | ((~TIFM_MMCSD_CLKMASK) &
> -			readl(sock->addr + SOCK_MMCSD_CONFIG)),
> -		sock->addr + SOCK_MMCSD_CONFIG);
> +	writel(host->clk_div
> +	       | ((~TIFM_MMCSD_CLKMASK)
> +		  & readl(sock->addr + SOCK_MMCSD_CONFIG)),
> +	       sock->addr + SOCK_MMCSD_CONFIG);
>
>  	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
>  		host->flags |= OPENDRAIN;
> @@ -734,7 +747,7 @@ static void tifm_sd_ios(struct mmc_host
>  	// allow removal.
>  	if ((host->flags & EJECT) && ios->power_mode == MMC_POWER_OFF) {
>  		host->flags |= EJECT_DONE;
> -		wake_up_all(&host->can_eject);
> +		wake_up_all(&host->notify);
>  	}
>
>  	spin_unlock_irqrestore(&sock->lock, flags);
> @@ -762,31 +775,76 @@ static struct mmc_host_ops tifm_sd_ops =
>  	.get_ro  = tifm_sd_ro
>  };
>
> -static void tifm_sd_register_host(void *data)
> +static int tifm_sd_initialize_host(struct tifm_sd *host)
>  {
> -	struct tifm_sd *host = (struct tifm_sd*)data;
> +	int rc;
> +	unsigned int host_status = 0;
>  	struct tifm_dev *sock = host->dev;
> -	struct mmc_host *mmc = tifm_get_drvdata(sock);
> -	unsigned long flags;
>
> -	spin_lock_irqsave(&sock->lock, flags);
> -	host->flags |= HOST_REG;
> -	PREPARE_WORK(&host->cmd_handler,
> -			no_dma ? tifm_sd_end_cmd_nodma : tifm_sd_end_cmd,
> -			data);
> -	spin_unlock_irqrestore(&sock->lock, flags);
> -	dev_dbg(&sock->dev, "adding host\n");
> -	mmc_add_host(mmc);
> +	writel(0, sock->addr + SOCK_MMCSD_INT_ENABLE);
> +	host->clk_div = 61;
> +	host->clk_freq = 20000000;
> +	writel(TIFM_MMCSD_RESET, sock->addr + SOCK_MMCSD_SYSTEM_CONTROL);
> +	writel(host->clk_div | TIFM_MMCSD_POWER,
> +	       sock->addr + SOCK_MMCSD_CONFIG);
> +
> +	/* wait up to 0.51 sec for reset */
> +	for (rc = 2; rc <= 256; rc <<= 1) {
> +		if (1 & readl(sock->addr + SOCK_MMCSD_SYSTEM_STATUS)) {
> +			rc = 0;
> +			break;
> +		}
> +		msleep(rc);
> +        }
> +
> +	if (rc) {
> +		printk(KERN_ERR DRIVER_NAME
> +		       ": controller failed to reset\n");
> +		return -ENODEV;
> +	}
> +
> +	writel(0, sock->addr + SOCK_MMCSD_NUM_BLOCKS);
> +	writel(host->clk_div | TIFM_MMCSD_POWER,
> +	       sock->addr + SOCK_MMCSD_CONFIG);
> +	writel(TIFM_MMCSD_RXDE, sock->addr + SOCK_MMCSD_BUFFER_CONFIG);
> +
> +	// command timeout fixed to 64 clocks for now
> +	writel(64, sock->addr + SOCK_MMCSD_COMMAND_TO);
> +	writel(TIFM_MMCSD_INAB, sock->addr + SOCK_MMCSD_COMMAND);
> +
> +	/* INAB should take much less than reset */
> +	for (rc = 1; rc <= 16; rc <<= 1) {
> +		host_status = readl(sock->addr + SOCK_MMCSD_STATUS);
> +		writel(host_status, sock->addr + SOCK_MMCSD_STATUS);
> +		if (!(host_status & TIFM_MMCSD_ERRMASK)
> +		    && (host_status & TIFM_MMCSD_EOC)) {
> +			rc = 0;
> +			break;
> +		}
> +		msleep(rc);
> +        }
> +
> +	if (rc) {
> +		printk(KERN_ERR DRIVER_NAME
> +		       ": card not ready - probe failed on initialization\n");
> +		return -ENODEV;
> +	}
> +
> +	writel(TIFM_MMCSD_DATAMASK | TIFM_MMCSD_ERRMASK,
> +	       sock->addr + SOCK_MMCSD_INT_ENABLE);
> +
> +	return 0;
>  }
>
>  static int tifm_sd_probe(struct tifm_dev *sock)
>  {
>  	struct mmc_host *mmc;
>  	struct tifm_sd *host;
> +
>  	int rc = -EIO;
>
> -	if (!(TIFM_SOCK_STATE_OCCUPIED &
> -			readl(sock->addr + SOCK_PRESENT_STATE))) {
> +	if (!(TIFM_SOCK_STATE_OCCUPIED
> +	      &	readl(sock->addr + SOCK_PRESENT_STATE))) {
>  		printk(KERN_WARNING DRIVER_NAME ": card gone, unexpectedly\n");
>  		return rc;
>  	}
> @@ -796,108 +854,88 @@ static int tifm_sd_probe(struct tifm_dev
>  		return -ENOMEM;
>
>  	host = mmc_priv(mmc);
> -	host->dev = sock;
> -	host->clk_div = 61;
> -	init_waitqueue_head(&host->can_eject);
> -	INIT_WORK(&host->cmd_handler, tifm_sd_register_host, host);
> -	INIT_WORK(&host->abort_handler, tifm_sd_abort, host);
> -
>  	tifm_set_drvdata(sock, mmc);
> -	sock->signal_irq = tifm_sd_signal_irq;
> -
> -	host->clk_freq = 20000000;
> +	host->dev = sock;
>  	host->timeout_jiffies = msecs_to_jiffies(1000);
> +	init_waitqueue_head(&host->notify);
> +
> +	tasklet_init(&host->finish_tasklet,
> +		     no_dma ? (void (*)(unsigned long))tifm_sd_end_cmd_nodma
> +			    : (void (*)(unsigned long))tifm_sd_end_cmd,
> +		     (unsigned long)host);
> +	setup_timer(&host->timer, (void (*)(unsigned long))tifm_sd_timeout,
> +		    (unsigned long)host);
>
>  	tifm_sd_ops.request = no_dma ? tifm_sd_request_nodma : tifm_sd_request;
> +
>  	mmc->ops = &tifm_sd_ops;
>  	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> -	mmc->caps = MMC_CAP_4_BIT_DATA;
> +	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_MULTIWRITE;
>  	mmc->f_min = 20000000 / 60;
>  	mmc->f_max = 24000000;
>  	mmc->max_hw_segs = 1;
>  	mmc->max_phys_segs = 1;
>  	mmc->max_sectors = 127;
>  	mmc->max_seg_size = mmc->max_sectors << 11; //2k maximum hw block length
> +	sock->signal_irq = tifm_sd_signal_irq;
> +	rc = tifm_sd_initialize_host(host);
>
> -	writel(0, sock->addr + SOCK_MMCSD_INT_ENABLE);
> -	writel(TIFM_MMCSD_RESET, sock->addr + SOCK_MMCSD_SYSTEM_CONTROL);
> -	writel(host->clk_div | TIFM_MMCSD_POWER,
> -			sock->addr + SOCK_MMCSD_CONFIG);
> +	if (!rc)
> +		rc = mmc_add_host(mmc);
> +	if (rc)
> +		goto out_free_mmc;
>
> -	for (rc = 0; rc < 50; rc++) {
> -		/* Wait for reset ack */
> -		if (1 & readl(sock->addr + SOCK_MMCSD_SYSTEM_STATUS)) {
> -			rc = 0;
> -			break;
> -		}
> -		msleep(10);
> -        }
> +	return 0;
> +out_free_mmc:
> +	mmc_free_host(mmc);
> +	return rc;
> +}
>
> -	if (rc) {
> -		printk(KERN_ERR DRIVER_NAME
> -			": card not ready - probe failed\n");
> -		mmc_free_host(mmc);
> -		return -ENODEV;
> -	}
> +static void tifm_sd_remove(struct tifm_dev *sock)
> +{
> +	struct mmc_host *mmc = tifm_get_drvdata(sock);
> +	struct tifm_sd *host = mmc_priv(mmc);
>
> -	writel(0, sock->addr + SOCK_MMCSD_NUM_BLOCKS);
> -	writel(host->clk_div | TIFM_MMCSD_POWER,
> -			sock->addr + SOCK_MMCSD_CONFIG);
> -	writel(TIFM_MMCSD_RXDE, sock->addr + SOCK_MMCSD_BUFFER_CONFIG);
> -	writel(TIFM_MMCSD_DATAMASK | TIFM_MMCSD_ERRMASK,
> -			sock->addr + SOCK_MMCSD_INT_ENABLE);
> +	del_timer_sync(&host->timer);
> +	tifm_sd_terminate(host);
> +	wait_event_timeout(host->notify, host->flags & EJECT_DONE,
> +			   host->timeout_jiffies);
> +	tasklet_kill(&host->finish_tasklet);
>
> -	writel(64, sock->addr + SOCK_MMCSD_COMMAND_TO); // command timeout 64
> clocks for now
> -	writel(TIFM_MMCSD_INAB, sock->addr + SOCK_MMCSD_COMMAND);
> -	writel(host->clk_div | TIFM_MMCSD_POWER,
> -			sock->addr + SOCK_MMCSD_CONFIG);
> +	mmc_remove_host(mmc);
>
> -	queue_delayed_work(sock->wq, &host->abort_handler,
> -			host->timeout_jiffies);
> +	/* The meaning of the bit majority in this constant is unknown. */
> +	writel(0xfff8 & readl(sock->addr + SOCK_CONTROL),
> +	       sock->addr + SOCK_CONTROL);
>
> -	return 0;
> +	tifm_set_drvdata(sock, NULL);
> +	mmc_free_host(mmc);
>  }
>
> -static int tifm_sd_host_is_down(struct tifm_dev *sock)
> +static int tifm_sd_suspend(struct tifm_dev *sock, pm_message_t state)
>  {
>  	struct mmc_host *mmc = tifm_get_drvdata(sock);
> -	struct tifm_sd *host = mmc_priv(mmc);
> -	unsigned long flags;
> -	int rc = 0;
> +	int rc;
>
> -	spin_lock_irqsave(&sock->lock, flags);
> -	rc = (host->flags & EJECT_DONE);
> -	spin_unlock_irqrestore(&sock->lock, flags);
> +	rc = mmc_suspend_host(mmc, state);
> +	/* The meaning of the bit majority in this constant is unknown. */
> +	writel(0xfff8 & readl(sock->addr + SOCK_CONTROL),
> +	       sock->addr + SOCK_CONTROL);
>  	return rc;
>  }
>
> -static void tifm_sd_remove(struct tifm_dev *sock)
> +static int tifm_sd_resume(struct tifm_dev *sock)
>  {
>  	struct mmc_host *mmc = tifm_get_drvdata(sock);
>  	struct tifm_sd *host = mmc_priv(mmc);
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&sock->lock, flags);
> -	host->flags |= EJECT;
> -	if (host->req)
> -		queue_work(sock->wq, &host->cmd_handler);
> -	spin_unlock_irqrestore(&sock->lock, flags);
> -	wait_event_timeout(host->can_eject, tifm_sd_host_is_down(sock),
> -				host->timeout_jiffies);
> -
> -	if (host->flags & HOST_REG)
> -		mmc_remove_host(mmc);
>
> -	/* The meaning of the bit majority in this constant is unknown. */
> -	writel(0xfff8 & readl(sock->addr + SOCK_CONTROL),
> -		sock->addr + SOCK_CONTROL);
> -	writel(0, sock->addr + SOCK_MMCSD_INT_ENABLE);
> -	writel(TIFM_FIFO_INT_SETALL,
> -		sock->addr + SOCK_DMA_FIFO_INT_ENABLE_CLEAR);
> -	writel(0, sock->addr + SOCK_DMA_FIFO_INT_ENABLE_SET);
> -
> -	tifm_set_drvdata(sock, NULL);
> -	mmc_free_host(mmc);
> +	if (sock->media_id != FM_SD
> +	    || tifm_sd_initialize_host(host)) {
> +		tifm_eject(sock);
> +		return 0;
> +	} else {
> +		return mmc_resume_host(mmc);
> +	}
>  }
>
>  static tifm_media_id tifm_sd_id_tbl[] = {
> @@ -911,7 +949,9 @@ static struct tifm_driver tifm_sd_driver
>  	},
>  	.id_table = tifm_sd_id_tbl,
>  	.probe    = tifm_sd_probe,
> -	.remove   = tifm_sd_remove
> +	.remove   = tifm_sd_remove,
> +	.suspend  = tifm_sd_suspend,
> +	.resume   = tifm_sd_resume
>  };
>
>  static int __init tifm_sd_init(void)
> diff --git a/include/linux/tifm.h b/include/linux/tifm.h
> index dfb8052..fb0808d 100644
> --- a/include/linux/tifm.h
> +++ b/include/linux/tifm.h
> @@ -17,7 +17,7 @@ #include <linux/interrupt.h>
>  #include <linux/wait.h>
>  #include <linux/delay.h>
>  #include <linux/pci.h>
> -#include <linux/scatterlist.h>
> +#include <linux/kthread.h>
>
>  /* Host registers (relative to pci base address): */
>  enum {
> @@ -36,6 +36,10 @@ enum {
>  	SOCK_DMA_FIFO_STATUS           = 0x020,
>  	SOCK_FIFO_CONTROL              = 0x024,
>  	SOCK_FIFO_PAGE_SIZE            = 0x028,
> +	SOCK_SM_COMMAND                = 0x094,
> +	SOCK_SM_STATUS                 = 0x098,
> +	SOCK_SM_BLOCK_ADDR             = 0x0a0,
> +	SOCM_SM_DATA                   = 0x0b0, /* 0x0b0 - 0x0bc */
>  	SOCK_MMCSD_COMMAND             = 0x104,
>  	SOCK_MMCSD_ARG_LOW             = 0x108,
>  	SOCK_MMCSD_ARG_HIGH            = 0x10c,
> @@ -50,7 +54,7 @@ enum {
>  	SOCK_MMCSD_BUFFER_CONFIG       = 0x130,
>  	SOCK_MMCSD_SPI_CONFIG          = 0x134,
>  	SOCK_MMCSD_SDIO_MODE_CONFIG    = 0x138,
> -	SOCK_MMCSD_RESPONSE            = 0x144,
> +	SOCK_MMCSD_RESPONSE            = 0x144, /* 0x144 - 0x160 */
>  	SOCK_MMCSD_SDIO_SR             = 0x164,
>  	SOCK_MMCSD_SYSTEM_CONTROL      = 0x168,
>  	SOCK_MMCSD_SYSTEM_STATUS       = 0x16c,
> @@ -62,11 +66,10 @@ enum {
>
>
>  #define TIFM_IRQ_ENABLE           0x80000000
> -#define TIFM_IRQ_SOCKMASK         0x00000001
> -#define TIFM_IRQ_CARDMASK         0x00000100
> -#define TIFM_IRQ_FIFOMASK         0x00010000
> +#define TIFM_IRQ_SOCKMASK(x)      (x)
> +#define TIFM_IRQ_CARDMASK(x)      ((x) << 8)
> +#define TIFM_IRQ_FIFOMASK(x)      ((x) << 16)
>  #define TIFM_IRQ_SETALL           0xffffffff
> -#define TIFM_IRQ_SETALLSOCK       0x0000000f
>
>  #define TIFM_CTRL_LED             0x00000040
>  #define TIFM_CTRL_FAST_CLK        0x00000100
> @@ -82,17 +85,21 @@ #define TIFM_DMA_RESET            0x0000
>  #define TIFM_DMA_TX               0x00008000 /* Meaning of this constant is
> unverified */
>  #define TIFM_DMA_EN               0x00000001 /* Meaning of this constant is
> unverified */
>
> -typedef enum {FM_NULL = 0, FM_XD = 0x01, FM_MS = 0x02, FM_SD = 0x03}
> tifm_media_id;
> +typedef enum {
> +	FM_NULL = 0,
> +	FM_XD = 0x01,
> +	FM_MS = 0x02,
> +	FM_SD = 0x03
> +} tifm_media_id;
>
>  struct tifm_driver;
>  struct tifm_dev {
>  	char __iomem            *addr;
>  	spinlock_t              lock;
>  	tifm_media_id           media_id;
> -	char                    wq_name[KOBJ_NAME_LEN];
> -	struct workqueue_struct *wq;
> +	unsigned int            socket_id;
>
> -	unsigned int            (*signal_irq)(struct tifm_dev *sock,
> +	void                    (*signal_irq)(struct tifm_dev *sock,
>  					      unsigned int sock_irq_status);
>
>  	struct tifm_driver      *drv;
> @@ -103,36 +110,37 @@ struct tifm_driver {
>  	tifm_media_id        *id_table;
>  	int                  (*probe)(struct tifm_dev *dev);
>  	void                 (*remove)(struct tifm_dev *dev);
> +	int                  (*suspend)(struct tifm_dev *dev,
> +					pm_message_t state);
> +	int                  (*resume)(struct tifm_dev *dev);
>
>  	struct device_driver driver;
>  };
>
>  struct tifm_adapter {
>  	char __iomem            *addr;
> -	unsigned int            irq_status;
> -	unsigned int            insert_mask;
> -	unsigned int            remove_mask;
>  	spinlock_t              lock;
> -	unsigned int            id;
> -	unsigned int            max_sockets;
> -	char                    wq_name[KOBJ_NAME_LEN];
> -	unsigned int            inhibit_new_cards;
> -	struct workqueue_struct *wq;
> -	struct work_struct      media_inserter;
> -	struct work_struct      media_remover;
> +	unsigned int            irq_status;
> +	unsigned int            socket_change_set;
> +	wait_queue_head_t       change_set_notify;
>  	struct tifm_dev         **sockets;
> +	unsigned int            num_sockets;
> +	unsigned int            id;
> +	struct task_struct      *media_switcher;
>  	struct class_device     cdev;
>  	struct device           *dev;
>
> -	void                    (*eject)(struct tifm_adapter *fm, struct tifm_dev
> *sock);
> +	void                    (*eject)(struct tifm_adapter *fm,
> +					 struct tifm_dev *sock);
>  };
>
> -struct tifm_adapter *tifm_alloc_adapter(void);
> +struct tifm_adapter* tifm_alloc_adapter(void);
>  void tifm_free_device(struct device *dev);
>  void tifm_free_adapter(struct tifm_adapter *fm);
> -int tifm_add_adapter(struct tifm_adapter *fm);
> +int tifm_add_adapter(struct tifm_adapter *fm,
> +		     int (*mediathreadfn)(struct tifm_adapter *fm));
>  void tifm_remove_adapter(struct tifm_adapter *fm);
> -struct tifm_dev *tifm_alloc_device(struct tifm_adapter *fm, unsigned int
> id);
> +struct tifm_dev* tifm_alloc_device(struct tifm_adapter *fm);
>  int tifm_register_driver(struct tifm_driver *drv);
>  void tifm_unregister_driver(struct tifm_driver *drv);
>  void tifm_eject(struct tifm_dev *sock);
> @@ -141,10 +149,9 @@ int tifm_map_sg(struct tifm_dev *sock, s
>  void tifm_unmap_sg(struct tifm_dev *sock, struct scatterlist *sg, int
> nents,
>  		   int direction);
>
> -
> -static inline void *tifm_get_drvdata(struct tifm_dev *dev)
> +static inline void* tifm_get_drvdata(struct tifm_dev *dev)
>  {
> -        return dev_get_drvdata(&dev->dev);
> +	return dev_get_drvdata(&dev->dev);
>  }
>
>  static inline void tifm_set_drvdata(struct tifm_dev *dev, void *data)
> --
> 1.4.2
>
>
>
>
>
> ____________________________________________________________________________________
> Sponsored Link
>
> Rates near 39yr lows. $420,000 Loan for $1399/mo.
> Calcuate new payment. www.LowerMyBills.com/lre
>
>
