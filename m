Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261439AbSJCW6P>; Thu, 3 Oct 2002 18:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261444AbSJCW6P>; Thu, 3 Oct 2002 18:58:15 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:53953 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261439AbSJCW6L>; Thu, 3 Oct 2002 18:58:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] EVMS core 3/4: evms_ioctl.h
Date: Thu, 3 Oct 2002 17:30:46 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02100307370503.05904@boiler.suse.lists.linux.kernel> <p73vg4jr1ic.fsf@oldwotan.suse.de>
In-Reply-To: <p73vg4jr1ic.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Message-Id: <0210031730460A.05904@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 October 2002 10:22, Andi Kleen wrote:
> Kevin Corry <corryk@us.ibm.com> writes:
> > +struct evms_plugin_ioctl_pkt {
> > +	ulong feature_id;
> > +	s32 feature_command;
> > +	s32 status;
> > +	void *feature_ioctl_data;
> > +};
>
> This is passed between user space and kernel space right?
>
> For 32bit emulation on 64bit purposes you should always use explicitely
> sized types (u32/u64 not ulong). The pointer will still need to be
> converted. Best is to avoid pointers if possible (e.g. couldn't the data
> just be tacked on here?)

The ulong is definitely wrong. Should be u32.

In general, we are aware of the issues with using 32-bit user-space on top of 
64-bit kernel. If you take a look at evms.c you will find several functions 
that get registered at init-time with the 32-to-64-bit ioctl conversion code. 
These take care of translating pointers from user-space to kernel-space in 
this situation. EVMS has been tested on ppc64 with success, and we have 
someone currently running tests on sparc64 to make sure it works there as 
well.

> > +#define EVMS_EVENT_END_OF_DISCOVERY     0
> > +
> > +/**
> > + * struct evms_notify_pkt - evms event notification ioctl packet
> > definition + * @command:	0 = unregister, 1 = register
> > + * @eventry:	event structure
> > + * @status:	returned operation status
> > + *
> > + * ioctl packet definition for EVMS_PROCESS_NOTIFY_EVENT ioctl
> > + **/
> > +struct evms_notify_pkt {
> > +	s32 command;
> > +	struct evms_event eventry;
>
> If eventry contains any potential 64bit stuff it would be best to align it
> to 64bit explicitely

Correct. In this particular case we are safe, since struct evms_event only 
contains 32bit fields. But we may switch this around anyway just to be even 
safer.

> > + **/
> > +struct evms_user_disk_info_pkt {
> > +	u32 status;
> > +	u32 flags;
> > +	u64 disk_handle;
> > +	u32 disk_dev;
> > +	u32 geo_sectors;
> > +	u32 geo_heads;
> > +	u64 geo_cylinders;
>
> emulation trap: on x86-64/ia64 u64 have different alignment on 32bit vs
> 64bit (4 bytes vs natural). Please make sure that u64 is always explicitely
> 64bit aligned. It isn't here.
>
> > +	u64 disk_handle;
> > +	s32 io_flag;
> > +	u64 starting_sector;
>
> Same issue

Yep. We'll get those fixed. Thanks for pointing these out.

>
> It would be best to clean the ABI up now when you can still change it.
> Otherwise the emulation functions later will be very ugly
> (take a look at the LVM horror in arch/x86_64/ia32/ia32_ioctl.c for a
> bad example - LVM1 wasn't cleaned up in time)
>
> -Andi

Thanks for the suggestions!

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
