Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbWILBNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbWILBNo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 21:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbWILBNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 21:13:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:15491 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965231AbWILBNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 21:13:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=sbPaE/dlRHYM+pbGF9cnRh1Obn/81ex3oXVzW9Koete/unBa1zIAJSLSD0IMQHyD3mQLQNLewFGu/5ajvgnWZxmkhocov/O6SV94qMEmSqRSh6oMCbpZpwNC+UPdWfto7/qmwVctgt2YcTOAfCTyjK61stbijbLPoe50FbhPNKk=
Date: Tue, 12 Sep 2006 05:13:46 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Miguel Ojeda <maxextreme@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] display: Driver ks0108 and cfag12864b
Message-ID: <20060912011346.GB5192@martell.zuzino.mipt.ru>
References: <653402b90609111627q661cded8l757129311fbe92d4@mail.gmail.com> <653402b90609111657r1fa861e0gf4d71508df60a5ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653402b90609111657r1fa861e0gf4d71508df60a5ec@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 01:57:23AM +0200, Miguel Ojeda wrote:
> +int cfag12864b_init(void)

arrrrggg....  I'm in the middle of reading every module_init and every
module_exit func, and this starts getting really annoying....

	1. module_init function SHOULD be written as

		static int __init FOO_init_module(void)
		{
			...
		}

	2. module_exit function SHOULD be written as

		static void __exit FOO_exit_module(void)
		{
			..
		}

	3. If one of function during module initialization returns an
	   error, everything done so far MUST be backed out to not cause
	   leaks.

	4. module_init and module_exit functions SHOULD NOT spit useless
	   messages upon which system administrator can't act meaningfully.

	5. In case of error during initialization, error code SHOULD be
	   propagated as is to upper layers, either via direct
	   assignment/return or via decoding from pointer.

	6. Error messages SHOULD start with short unique prefix specific to
	   driver. Module name without .o and .ko is fine.

	7. StupidCapitalization MUST NOT be used.

	8. Function args SHOULD NOT be prefixed with underscore without
	   reason.

	9. Various sorts of operations and methods driver provides to
	   upper layers SHOULD start with short, common to driver
	   prefix and SHOULD be made static where possible:

		static struct foobar_operations rtl8139_fops = {
			...
		};

> +{
> +       unsigned int i;
> +       int Result;
> +
> +       printk(PRINTK_PREFIX "Init... ");
> +
> +       Result = alloc_chrdev_region(&FirstDevice, FirstMinor, nDevices, 
> Name);
> +       if(Result < 0) {
> +               printk("ERROR - alloc_chrdev_region\n");
> +               return Result;
> +       }
> +       Major = MAJOR(FirstDevice);
> +
> +       Devices = kmalloc(nDevices * sizeof(struct cfag12864b), GFP_KERNEL);
> +       if(Devices == NULL) {
> +               printk("ERROR - kmalloc\n");
> +               return -ENOMEM;
> +       }
> +       memset(Devices, 0, nDevices * sizeof(struct cfag12864b));
> +
> +       for(i=0; i<nDevices; ++i) {
> +               Devices[i].Minor = FirstMinor+i;
> +               Devices[i].Device = MKDEV(Major,Devices[i].Minor);
> +
> +               cdev_init(&(Devices[i].CharDevice), &Fops);
> +               Devices[i].CharDevice.owner = THIS_MODULE;
> +               Devices[i].CharDevice.ops = &Fops;
> +               Result = cdev_add(&(Devices[i].CharDevice),
> +                       Devices[i].Device, 1);
> +               if(Result < 0) {
> +                       printk("ERROR - cdev_add\n");
> +                       kfree(Devices);
> +                       return Result;
> +               }
> +
> +               class_device_create(
> +                       display_class,NULL,MKDEV(Major,Devices[i].Minor),
> +                       NULL,"cfag12864b%d",Devices[i].Minor);
> +       }
> +
> +
> +       cfag12864b_Clear();
> +       cfag12864b_On();

	->open, ->write could be called as soon as cdev_add succeeds.
	Is hardware functional at that point?

