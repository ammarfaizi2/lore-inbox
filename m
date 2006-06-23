Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWFWN5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWFWN5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWFWN5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:57:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:27324 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750740AbWFWNra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:47:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=dxILeR0ueLUQi6WrsOnsm0GJX9rGb5rJw2qVZnRoWHxYJbmgxKorgpA7xJW6/sivs2Rcp131+uvNQXcp0uim75JnkOVixsvdCLZ/IUP5cTatxQza8j0WTZUBg3m97z8dBK1D+1agAV5K5YwJHgcgQiXx+kRYivrk8WqZlwL9A+w=
Date: Fri, 23 Jun 2006 15:47:26 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pm@osdl.org,
       stern@rowland.harvard.edu
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Message-ID: <20060623134726.GD2234@slug>
References: <4499BE99.6010508@gmail.com> <20060621221445.GB3798@inferi.kami.home> <20060622061905.GD15834@kroah.com> <20060622004648.f1912e34.akpm@osdl.org> <20060622160403.GB2539@slug> <20060622092506.da2a8bf4.akpm@osdl.org> <20060623090206.GA2234@slug> <20060623091016.GE4940@elf.ucw.cz> <20060623121210.GB2234@slug> <20060623125658.GB8048@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623125658.GB8048@elf.ucw.cz>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 02:57:01PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > 2.6.17 wasn't supposed to oops.  Do you have details on this?
> > > > > 
> > > > For some reason, unknown to me, the oops won't display on the serial
> > > > link :(.
> > > 
> > > Serial console is currently broken by suspend, resume. _But_ I have a
> > > patch I'd like you to try.... pretty please?
> > > 
> > Sure :)... I applied it but the output went to the laptop's screen anyway...
> 
> Do you need some kernel command line options? This is s2ram, do I
> recall it correctly?
I think the options are ok: I'm passing console=tty0 console=ttyS0,9600 and
everything works fine in cu(1). Until the 'echo mem > /sys/power/state', that is :)
> > esi: 00000003  edit: 00000000 ebp: f6cb9eb8  esp: f6cb9ea4
> > ds: 007b  es: 007b  ss: 0068
> > Process bash (pid: 9402, threadinfo=f6cb8000 task=f7a5c570)
> 
> This stack lines are not really interesting (can you comment them from
> sources?) and they make interesting info scroll away :-(. 
I'll comment them out and send you the trace, but I won't get the time to
do it today, I'll try to get it done by monday.
> Or maybe vga=1 can help?
I've tried it. But somehow, the suspend process resets the resolution to the
lowest one.
> 
> > Stack: c0229b71 00000046 00000000 00000286 c0383ca7 f6cb9ecc c013b242 00000003
> >         00000000 00000003 f6cb9ee0 c013b2e8 00000003 c0436890 f6c9a003 f6cb9f08
> >         c013b481 00000003 00000003 00000246 c1788b00 00000003 c04368a0 c043692c
c0229b71 is in acpi_pm_enter:
        case PM_SUSPEND_MEM:
-->             do_suspend_lowlevel();
                break;

c013b242 is in suspend_enter:
	}
-->     error = pm_ops->enter(state);
	device_power_up();


c013b2e8 is in enter_state
        pr_debug("PM: Entering %s sleep\n", pm_states[state]);
-->     error = suspend_enter(state);


c013b481 is in state_store
        if (state < PM_SUSPEND_MAX && *s)
-->            error = enter_state(state);
        else


> > Call Trace:
> >  <c0103eea> show_stack_log_lvl+0x92/0xb7  <c0104100> show_registers+0x1a3/0x21b
> >  <c0104319> die+0x117/0x230  <c03627a6> do_page_fault+0x39c/0x72a
> >  <c0103b2f> error_code+0x4f/0x54  <c013b242> suspend_enter+0x2f/0x52
> >  <c013b2e8> enter_state+0x4b/0x8d  <c013b481> state_store+0xa0/0xa2
> >  <c01a5151> subsys_attr_store+0x37/0x41  <c01a53d2> flush_write_buffer+0x3c/0x46
> >  <c01a5443> sysfs_write_file+0x67/0x8b  <c0166bb6> vfs_write+0x1b9/0x1be
> >  <c0166c7b> sys_write+0x4b/0x75  <c010300f> sysenter_past_esp+0x54/0x75
> > 
> > Code: 05 c4 42 43 c0 31 43 43 c0 c3 8b 2d 68 6e 54 c0 8b 1d 60 6e 54 c0 8b 35 6c 6e 54 c0 8b 3d 70 6d 54 c0 ff 35 74 6e 54 c0 9d c3 90 <e8> 6d 38 ea ff e8 a2 ff ff ff 6a 03 e8 ec b6 de ff 83 c4 04 c3
> > EIP: [c043431c>] do_suspend_lowlevel+0x0/0x15 SS:ESP 0068:f6cb6ea4
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Ha, wait a moment, this is interesting line. Can you trace down which
> instruction causes this?
This disassembles as follows:
c043431c <do_suspend_lowlevel>:
c043431c:       e8 6d 38 ea ff          call   c02d7b8e <save_processor_state>
c0434321:       e8 a2 ff ff ff          call   c04342c8 <save_registers>
c0434326:       6a 03                   push   $0x3
c0434328:       e8 ec b6 de ff          call   c021fa19 <acpi_enter_sleep_state>
c043432d:       83 c4 04                add    $0x4,%esp
c0434330:       c3                      ret
So it looks like where crashing when calling save_processor_state. 
> We recently changed pagetable handling during swsusp, perhaps thats
> it? It went to Linus few minutes ago...
Sorry, I don't understand what you mean: do you want me to try the latest git?

Regards,
Frederik
