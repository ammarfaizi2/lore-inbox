Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136444AbREDQAk>; Fri, 4 May 2001 12:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136437AbREDQAU>; Fri, 4 May 2001 12:00:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42352 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S136442AbREDQAQ>; Fri, 4 May 2001 12:00:16 -0400
To: "Matt D. Robinson" <yakker@alacritech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smp_send_stop() and disable_local_APIC()
In-Reply-To: <3AF19A17.19C2741F@alacritech.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 May 2001 09:58:04 -0600
In-Reply-To: "Matt D. Robinson"'s message of "Thu, 03 May 2001 10:49:11 -0700"
Message-ID: <m1d79pnm2b.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Matt D. Robinson" <yakker@alacritech.com> writes:

> It looks like around 2.3.30 or so, someone added the call
> disable_local_APIC() to smp_send_stop().  I'm not sure what the
> intention was, but I'm getting some strange behavior as a result
> based on some code I'm writing.
> 
> Basically, I'm doing the following ...
> 
>     panic()
>     {
>         /* do whatever you want, notifier list, etc. */
>         smp_send_stop();
>         write_system_memory();
>         /* then do whatever */
>     }
> 
> write_system_memory() does a write of all system memory pages to some
> block device.  It uses kiobufs as the way to get the pages to disk,
> doing brw_kiovec() on those pages (using either the IDE or SCSI
> driver to write the data).

IDE being less likely to hang than SCSI as it tends to use legacy isa
interrupt lines.
 
> The wierd behavior I see is that sometimes, smp_send_stop()
> being called causes the system to hang up (not every time). 

Doing event driver i/o after disabling the interrupt controller
hmm, I wonder why...

> If we don't call smp_send_stop() on those systems, everything works fine.
> This looks to be directly caused by the disabling of the APIC, which
> we may need to dump pages to local disk.  This only applies to some
> people's systems -- not everyone displays the same behavior.
> 
> I'm sure it's good to disable the APIC, but there's no clean way to
> wait on disabling the APIC until after I'm done writing pages out.
> 
> My questions are:
> 
> 1) Why was disable_local_APIC() added to stop_this_cpu()
>    and smp_send_stop()?  Completeness?
> 
> 2) Is there a better way around this to disable all the
>    other CPUs without disabling the APIC?
> 

I don't know what a good way is, since there is a kernel panic it
should only be something truly fatal.  Given that reusing anything
that hasn't been designed to run in that situation is playing with
fire.

Eric
