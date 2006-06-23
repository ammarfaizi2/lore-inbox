Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933064AbWFWMMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933064AbWFWMMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933080AbWFWMMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:12:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:20683 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S933064AbWFWMMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:12:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=lTWnrozfRQ10H3rqAwoNtp8lC0aY4Rtbv+RwEbnkkEtXXdMZREDoJrPQRpCEngS3gEGB8txNJK6gbCboPlIgajuyhCEnViIqLPTk3zq9AE4zPrAmjql6tBkd2ZaLcDT3JeXT1xXP+ecXvRsRr5j2RzfURhrWFFtMnrdwhYlVdWA=
Date: Fri, 23 Jun 2006 14:12:11 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pm@osdl.org,
       stern@rowland.harvard.edu
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Message-ID: <20060623121210.GB2234@slug>
References: <20060621034857.35cfe36f.akpm@osdl.org> <4499BE99.6010508@gmail.com> <20060621221445.GB3798@inferi.kami.home> <20060622061905.GD15834@kroah.com> <20060622004648.f1912e34.akpm@osdl.org> <20060622160403.GB2539@slug> <20060622092506.da2a8bf4.akpm@osdl.org> <20060623090206.GA2234@slug> <20060623091016.GE4940@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623091016.GE4940@elf.ucw.cz>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 11:10:21AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Frederik Deweerdt <deweerdt@free.fr> wrote:
> > > 
> > > > Thu, Jun 22, 2006 at 12:46:48AM -0700, Andrew Morton wrote:
> > > > > I can bisect it if we're stuck, but that'll require beer or something.
> > > > 
> > > > FWIW, my laptop (Dell D610) gave the following results:
> > > > 2.6.17-mm1: suspend_device(): usb_generic_suspend+0x0/0x135 [usbcore]() returns -16
> > > > 2.6.17+origin.patch: suspend_device(): usb_generic_suspend+0x0/0x135 [usbcore]() returns -16
> > > 
> > > So it's in mainline already - hence it's some recently-written thing which
> > > was not tested in rc6-mm2.
> > > 
> > > > 2.6.17: oops
> > > > 2.6.17.1: oops
> > > 
> > > 2.6.17 wasn't supposed to oops.  Do you have details on this?
> > > 
> > For some reason, unknown to me, the oops won't display on the serial
> > link :(.
> 
> Serial console is currently broken by suspend, resume. _But_ I have a
> patch I'd like you to try.... pretty please?
> 
Sure :)... I applied it but the output went to the laptop's screen anyway...
 
> That is not an oops, rather a kernel BUG(). Can you just remove
> might_sleep line and see what happens?
> 
> Unfortunately, backtrace does not tell me which notifier chain did
> that :-(. Are you using audit or something like that?
> 
> /*
>  * lock for reading
>  */
> static inline void down_read(struct rw_semaphore *sem)
> {
>         might_sleep();
> ~~~~~~~~~~~~~~~~~~~~~~
>         rwsemtrace(sem,"Entering down_read");
>         __down_read(sem);
>         rwsemtrace(sem,"Leaving down_read");
> }
> 
Here's the (hand copied) dump when the might_sleep is removed:

esi: 00000003  edit: 00000000 ebp: f6cb9eb8  esp: f6cb9ea4
ds: 007b  es: 007b  ss: 0068
Process bash (pid: 9402, threadinfo=f6cb8000 task=f7a5c570)
Stack: c0229b71 00000046 00000000 00000286 c0383ca7 f6cb9ecc c013b242 00000003
        00000000 00000003 f6cb9ee0 c013b2e8 00000003 c0436890 f6c9a003 f6cb9f08
        c013b481 00000003 00000003 00000246 c1788b00 00000003 c04368a0 c043692c
Call Trace:
 <c0103eea> show_stack_log_lvl+0x92/0xb7  <c0104100> show_registers+0x1a3/0x21b
 <c0104319> die+0x117/0x230  <c03627a6> do_page_fault+0x39c/0x72a
 <c0103b2f> error_code+0x4f/0x54  <c013b242> suspend_enter+0x2f/0x52
 <c013b2e8> enter_state+0x4b/0x8d  <c013b481> state_store+0xa0/0xa2
 <c01a5151> subsys_attr_store+0x37/0x41  <c01a53d2> flush_write_buffer+0x3c/0x46
 <c01a5443> sysfs_write_file+0x67/0x8b  <c0166bb6> vfs_write+0x1b9/0x1be
 <c0166c7b> sys_write+0x4b/0x75  <c010300f> sysenter_past_esp+0x54/0x75

Code: 05 c4 42 43 c0 31 43 43 c0 c3 8b 2d 68 6e 54 c0 8b 1d 60 6e 54 c0 8b 35 6c 6e 54 c0 8b 3d 70 6d 54 c0 ff 35 74 6e 54 c0 9d c3 90 <e8> 6d 38 ea ff e8 a2 ff ff ff 6a 03 e8 ec b6 de ff 83 c4 04 c3
EIP: [c043431c>] do_suspend_lowlevel+0x0/0x15 SS:ESP 0068:f6cb6ea4

Regards,
Frederik
