Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263867AbTFDTFA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 15:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTFDTE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 15:04:58 -0400
Received: from [212.159.46.210] ([212.159.46.210]:27731 "EHLO lion")
	by vger.kernel.org with ESMTP id S263867AbTFDTEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 15:04:52 -0400
From: "John Appleby" <john@dnsworld.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Serio keyboard issues 2.5.70
Date: Wed, 4 Jun 2003 20:23:21 +0100
Message-ID: <434747C01D5AC443809D5FC5405011315699@bobcat.unickz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <434747C01D5AC443809D5FC540501131097083@bobcat.unickz.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to write a keyboard driver using serio/input on 2.5.70; more
of a port of the existing 2.4 driver actually, but whatever.

I'm calling serio_register_device thus:

static struct serio_dev arckbd_dev = {
        .interrupt =    arckbd_interrupt,
        .connect =      arckbd_connect,
        .disconnect =   arckbd_disconnect
};

static int __init arckbd_init(void)
{
	printk("input: Registering keyboard with serio\n");
        serio_register_device(&arckbd_dev);
        return 0;
}

And that printk is coming up fine. serio_register_device seems to add
0x021c2af8 to its tail, but then never finds my entry in
list_for_each_entry and thus never calls dev->connect(). I've added some
debugging to serio_register_device thus:

void serio_register_device(struct serio_dev *dev)
{
        struct serio *serio;
        list_add_tail(&dev->node, &serio_dev_list);
	  printk("serio: add_tail %08x\n",&dev->node);
        list_for_each_entry(serio, &serio_list, node) {
                printk("serio: register_device %08x\n",serio->dev);
                if (!serio->dev && dev->connect) {
                        printk("serio: connecting...\n");
                        dev->connect(serio, dev);
                }
        }
}

and I get nothing past "add_tail". I'd expect it to recognize my dev and
attempt to connect to it.

Any ideas? I presume I'm being an idiot as per usual.

Thanks,

John


