Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261447AbSJCPRE>; Thu, 3 Oct 2002 11:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSJCPQt>; Thu, 3 Oct 2002 11:16:49 -0400
Received: from ns.suse.de ([213.95.15.193]:17678 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261509AbSJCPQi>;
	Thu, 3 Oct 2002 11:16:38 -0400
To: Kevin Corry <corryk@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EVMS core 3/4: evms_ioctl.h
References: <02100307370503.05904@boiler.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Oct 2002 17:22:03 +0200
In-Reply-To: Kevin Corry's message of "3 Oct 2002 15:22:49 +0200"
Message-ID: <p73vg4jr1ic.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Corry <corryk@us.ibm.com> writes:


> +struct evms_plugin_ioctl_pkt {
> +	ulong feature_id;
> +	s32 feature_command;
> +	s32 status;
> +	void *feature_ioctl_data;
> +};

This is passed between user space and kernel space right? 

For 32bit emulation on 64bit purposes you should always use explicitely
sized types (u32/u64 not ulong). The pointer will still need to be 
converted. Best is to avoid pointers if possible (e.g. couldn't the data
just be tacked on here?) 


> +#define EVMS_EVENT_END_OF_DISCOVERY     0
> +
> +/**
> + * struct evms_notify_pkt - evms event notification ioctl packet definition
> + * @command:	0 = unregister, 1 = register
> + * @eventry:	event structure
> + * @status:	returned operation status
> + *
> + * ioctl packet definition for EVMS_PROCESS_NOTIFY_EVENT ioctl
> + **/
> +struct evms_notify_pkt {
> +	s32 command;
> +	struct evms_event eventry;

If eventry contains any potential 64bit stuff it would be best to align it 
to 64bit explicitely
> + **/
> +struct evms_user_disk_info_pkt {
> +	u32 status;
> +	u32 flags;
> +	u64 disk_handle;
> +	u32 disk_dev;
> +	u32 geo_sectors;
> +	u32 geo_heads;
> +	u64 geo_cylinders;

emulation trap: on x86-64/ia64 u64 have different alignment on 32bit vs
64bit (4 bytes vs natural). Please make sure that u64 is always explicitely
64bit aligned. It isn't here.


> +	u64 disk_handle;
> +	s32 io_flag;
> +	u64 starting_sector;

Same issue


It would be best to clean the ABI up now when you can still change it.
Otherwise the emulation functions later will be very ugly
(take a look at the LVM horror in arch/x86_64/ia32/ia32_ioctl.c for a 
bad example - LVM1 wasn't cleaned up in time)

-Andi
