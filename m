Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263706AbUDMT0p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 15:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUDMT0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 15:26:30 -0400
Received: from [195.23.16.24] ([195.23.16.24]:64972 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S263698AbUDMT0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 15:26:21 -0400
Message-ID: <407C3E1D.1080609@grupopie.com>
Date: Tue, 13 Apr 2004 20:23:09 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Chris Lalancette <chris.lalancette@gd-ais.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory image save/restore
References: <407C18D0.9010302@gd-ais.com> <407C1D4F.4060706@grupopie.com> <407C2FF7.4010500@gd-ais.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.25.0.2; VDF: 6.25.0.12; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Lalancette wrote:

> Paulo,
>    Thanks for responding.  You are right in that the state of memory 
> isn't the state of the entire machine; however, for instance, the 
> swsusp2 project can save the contents of memory out to disk, go to 
> sleep, and then resume to it later.  Basically, what I am trying to do 
> is something like swsusp2, with less restrictions; I know I have another 
> region the size of physical memory to work with, I know I am executing 
> from an interrupt handler, and at the end I don't want to go to sleep, 
> just continue on.  Then I might want to use that memory image later.


That is not *all* the swsusp2 project does. Probably the biggest challenge in 
the software suspend project is to get all the devices to acknowledge that they 
are being "suspended" and to have them resume properly.

Just as an example, imagine that the usb host controller is currently 
dispatching an urb to a device. The kernel in-memory structures reflect this 
occurrence. The kernel is ready for the interrupt the controller will generate 
to update these structures.

You now interrupt, and save the memory contents. You let everything proceed, and 
after a while try to recover the previous memory contents.

Now the kernel is expecting the interrupt from the controller, regarding an urb 
that the controller has dispatched a long time ago. The state of the controller 
and the kernel in-memory structures is out of sync.

This is just a small example. I could think of this sort of examples for disk 
reads/writes and IDE/SCSI controllers, accelerated graphics adapters, etc., etc. 
Even much simpler examples, like keyboard state (a scancode was just received to 
press a key, and the corresponding release is lost), internal timer/clock, etc. 
will cause you problems just the same.

However, I'm not an expert in this area. Maybe someone like Nigel Cunningham or 
Pavel Machek can explain better the problems that arise from trying to save the 
complete *state* of the system. I just wrote this to try to save these guys the 
trouble, since they can occupy their time better in developing the damn thing :)

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

