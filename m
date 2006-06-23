Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932948AbWFWJLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932948AbWFWJLS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932950AbWFWJLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:11:18 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10712 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932948AbWFWJLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:11:18 -0400
Date: Fri, 23 Jun 2006 11:10:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pm@osdl.org,
       stern@rowland.harvard.edu
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Message-ID: <20060623091016.GE4940@elf.ucw.cz>
References: <20060621034857.35cfe36f.akpm@osdl.org> <4499BE99.6010508@gmail.com> <20060621221445.GB3798@inferi.kami.home> <20060622061905.GD15834@kroah.com> <20060622004648.f1912e34.akpm@osdl.org> <20060622160403.GB2539@slug> <20060622092506.da2a8bf4.akpm@osdl.org> <20060623090206.GA2234@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623090206.GA2234@slug>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Frederik Deweerdt <deweerdt@free.fr> wrote:
> > 
> > > Thu, Jun 22, 2006 at 12:46:48AM -0700, Andrew Morton wrote:
> > > > I can bisect it if we're stuck, but that'll require beer or something.
> > > 
> > > FWIW, my laptop (Dell D610) gave the following results:
> > > 2.6.17-mm1: suspend_device(): usb_generic_suspend+0x0/0x135 [usbcore]() returns -16
> > > 2.6.17+origin.patch: suspend_device(): usb_generic_suspend+0x0/0x135 [usbcore]() returns -16
> > 
> > So it's in mainline already - hence it's some recently-written thing which
> > was not tested in rc6-mm2.
> > 
> > > 2.6.17: oops
> > > 2.6.17.1: oops
> > 
> > 2.6.17 wasn't supposed to oops.  Do you have details on this?
> > 
> For some reason, unknown to me, the oops won't display on the serial
> link :(.

Serial console is currently broken by suspend, resume. _But_ I have a
patch I'd like you to try.... pretty please?

> Here's what I could hand copy (I've suppressed printk timing information):
> x1b9/0x1be
> <c0166e6b> sys_write+0x4b/0x75  <c010300f> sysenter_past_esp+0x54/0x75
> Code: 05 c4 52 43 c0 31 53 43 c0 c3 8b 2d 68 6e 54 c0 8b 1d 60
> 6e 54 c0 8b 35 6c 6e 54 c0 8b 3d 70 6e 54 c0 ff 35 74 6e 54 c0 9d c3 90 <e8>
> 9d 2c ea ff e8 a2 ff ff ff 6a 03 e8 4c ab de ff 83 c4 04 c3
> EIP: [<c043531c>] do_suspend_lowlevel+0x0/0x15 SS:ESP 0068:f7a0fea4
> <3>BUG: sleeping function called from invalid context at include/linux/rwsem.h:43
> in_atomic():0, irqs_disabled():1
>  <c0103e56> show_trace+0x20/0x22  <c0103f5b> dump_stack+0x1e/0x20
>  <c011aec7> __might_sleep+0x9e/0xa6  <c012b0cf> blocking_notifier_call_chain+0x1e/0x5b
>  <c011f091> profile_task_exit+0x21/0x23  <c0120946> do_exit+0x1d/0x483
>  <c0104432> do_divide_error+0x0/0xbf  <c0362c76> do_page_fault+0x3c4/0x752
>  <c0103b2f> error_code+0x4f/0x54  <c013b33a> suspend_enter+0x2f/0x52
>  <c013b3e0> enter_state+0x4b/0x8d  <c013b579> state_store+0xa0/0xa2
>  <c01a54f1> subsys_attr_store+0x37/0x41  <c01a5772> flush_write_buffer+0x3c/046
>  <c01a57e3> sysfs_write_file+0x67/0x8b  <c0166da6> vfs_write+0x1b9/0x1be
>  <c0166e6b> sys_write+0x4b/0x75  <c010300f> sysenter_past_esp+0x54/0x75

That is not an oops, rather a kernel BUG(). Can you just remove
might_sleep line and see what happens?

Unfortunately, backtrace does not tell me which notifier chain did
that :-(. Are you using audit or something like that?

/*
 * lock for reading
 */
static inline void down_read(struct rw_semaphore *sem)
{
        might_sleep();
~~~~~~~~~~~~~~~~~~~~~~
        rwsemtrace(sem,"Entering down_read");
        __down_read(sem);
        rwsemtrace(sem,"Leaving down_read");
}

										Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
