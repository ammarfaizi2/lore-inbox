Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWEQSbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWEQSbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 14:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWEQSbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 14:31:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:46079 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750868AbWEQSbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 14:31:25 -0400
Message-ID: <446B6BF8.5050208@am-anger-1.de>
Date: Wed, 17 May 2006 20:31:20 +0200
From: Heiko Gerstung <heiko@am-anger-1.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060509)
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org
Subject: USB net driver hacker wanted (was Re: Bug related to bonding)
References: <44684B60.1070705@am-anger-1.de> <20060516045332.GN11191@w.ods.org> <44695D2A.9080705@am-anger-1.de> <20060516123351.GA22040@w.ods.org> <4469EB32.80806@am-anger-1.de> <20060516182324.GA23413@w.ods.org>
In-Reply-To: <20060516182324.GA23413@w.ods.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:25672344472c4ac2bbe53bd9833f99fb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List!

I am still having problems with rtl8150.c on Linux 2.4.32 ...

Willy Tarreau wrote:
>> Please find below the complete async_get_registers function I set up, I
>> hope it's OK to post it here. A kernel hacker will immediately spot the
>> error, no? :-)
>>     
> Just a guess : I suspect that dev->ctrl_urb is NULL. I don't know how you
> are supposed to initialize it though.
>   
You were right :-) It was a question of how things get initialized.
My current state is that I am able to load the module but using my
async_get_register function does not succeed due to timeouts. I am no
kernel hacker and therefore it is like running through the darkest night
with my sunglasses on :-) ... I sincerely hope, the maintainer of the
driver helps me out...

It is interesting to see that with a 2.4.20 kernel I have no problems
with loading the driver, it only crashes when I run net-snmp on it and
then fire up an snmpwalk (which, I guess, queries the driver for some
interface statistics or something like that).

Deadline is coming and still no hope, yet. We'll see...


Kind regards,
Heiko


>   
>> Kind regards,
>> Heiko
>>     
>
> Regards,
> Willy
>
>   
>> static int get_registers(rtl8150_t * dev, u16 indx, u16 size, void *data)
>> {
>> int ret;
>> char *buffer;
>>
>> printk("get_registers dev=%08X dev->dr=%08X indx=%d size=%d\n",(unsigned
>> long) dev, (unsigned long) &dev->dr, indx,size);
>> buffer = kmalloc(size, GFP_DMA);
>> if (!buffer) {
>> warn("%s: looks like we're out of memory", __FUNCTION__);
>> return -ENOMEM;
>> }
>>
>>
>> if (test_bit(RX_REG_SET, &dev->flags))
>> return -EAGAIN;
>>
>> dev->dr.bRequestType = RTL8150_REQT_READ;
>> dev->dr.bRequest = RTL8150_REQ_GET_REGS;
>> dev->dr.wValue = cpu_to_le16(indx);
>> dev->dr.wIndex = cpu_to_le16p(&indx);
>> dev->dr.wLength = cpu_to_le16p(&size);
>>
>> dev->ctrl_urb->transfer_buffer_length = size;
>>
>> FILL_CONTROL_URB(dev->ctrl_urb, dev->udev,
>> usb_rcvctrlpipe(dev->udev, 0), (char *) &dev->dr,
>> buffer, size, ctrl_callback, dev);
>>
>> if ((ret = usb_submit_urb(dev->ctrl_urb)))
>> err("control request submission failed: %d", ret);
>>
>> return ret;
>> }
>>
>>     
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>   

