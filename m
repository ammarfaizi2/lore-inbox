Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVHHNwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVHHNwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 09:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbVHHNwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 09:52:19 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:43784 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750896AbVHHNwS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 09:52:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050808.204022.30161255.kaminaga@sm.sony.co.jp>
References: <20050808.204022.30161255.kaminaga@sm.sony.co.jp>
X-OriginalArrivalTime: 08 Aug 2005 13:52:16.0655 (UTC) FILETIME=[632A99F0:01C59C20]
Content-class: urn:content-classes:message
Subject: Re: [HELP] How to get address of module
Date: Mon, 8 Aug 2005 09:51:25 -0400
Message-ID: <Pine.LNX.4.61.0508080931130.18723@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [HELP] How to get address of module
thread-index: AcWcIGM0k0IKAlsPS8+afMjq3hLtwQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Hiroki Kaminaga" <kaminaga@sm.sony.co.jp>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Aug 2005, Hiroki Kaminaga wrote:

>
> Hi!
>
> I'm looking for *nice* way to get address of loaded module in 2.6.
> I'd like to know the address from driver.
>
> In 2.4, I wrote something like this:
>
> * * *
>
> (in kernel src)
> --- kernel/module.c
> +++ kernel/module.c
>
> struct module *module_list = &kernel_module;
>
> + struct module *get_module_queue(void)
> + {
> +         return module_list;
> + }
> +
> +
>
> ... and in driver, I wrote:
>
>        mod = get_module_queue();
>        while (mod->next) {
>                if (strcmp(mod->name, name) == 0)
>                        return (unsigned long)(mod + 1);
>                mod = mod->next;
>        }
>        return 0;
>
> * * *
>
> I am now using 2.6 kernel. The choice I can think of is
>
> 1) make linux-2.6/kernel/module.c:find_module(const char *name)
>   global func, not static, and use this func.
>
> 2) use linux-2.6/kernel/module.c:module_kallsyms_lookup_name(const char *name)
>   and somehow get return value from module_get_kallsym(...)
>
> choice 1) doesn't sound nice since it changes static func -> global
> func, but cost of getting module address is low. On the other hand,
> choice 2) will not modify kernel src, which sounds nice, but costs more,
> and I'm not sure this method works.
>
> Any advice?!
>
>
> HK.


What do you want the address of in your driver? Do you want the
address of its various entry points (hint, the stuff you put
into the "struct file_operations"), or its startup code, module_init(),
exit code, module_exit(), etc.

These are can all be obtained using conventional 'C' syntax. You
don't need to search some list somehere. You driver isn't just
put somewhere en-masse. The code is in the .text segment, relocated
to exist in allocated memory. The data sections are also relocated
to different sections of allocated memory.

You get the address of a function by referencing its name:

static int ioctl(struct inode *inp, struct file *fp, size_t cmd, unsigned long
arg)
{
     unsigned long val;
     switch(cmd)
    {
     case GET_ADDRESS_OF_IOCTL:
         val = (unsigned long) ioctl;
         if(put_user(val, (unsigned long *)arg))
             return -EFAULT
         break;
     case ETC:
    }

Your driver probably has many functions, therefore it has many
addresses. It's not just a single "module" somewhere.



Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
