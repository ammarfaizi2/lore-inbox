Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932937AbWFWJCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932937AbWFWJCN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWFWJCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:02:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:51528 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751248AbWFWJCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:02:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=jDDdqk5yS+KHicBWFlMLQuXCE6kJXYad+TkYjJx+Vt+RfV5F5rZmutwED+c/Ij+cGQ5w9X+i6EqFraHz3iqkdVXc31b9t87shzc8XIINBDJJSEfM2fRYwuIeF+2YqBM6/tD+TCv7jVC6HEhsF7Ny3szSo28UqwLphRcTYMXwpcA=
Date: Fri, 23 Jun 2006 11:02:06 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       linux-pm@osdl.org, stern@rowland.harvard.edu
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Message-ID: <20060623090206.GA2234@slug>
References: <20060621034857.35cfe36f.akpm@osdl.org> <4499BE99.6010508@gmail.com> <20060621221445.GB3798@inferi.kami.home> <20060622061905.GD15834@kroah.com> <20060622004648.f1912e34.akpm@osdl.org> <20060622160403.GB2539@slug> <20060622092506.da2a8bf4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622092506.da2a8bf4.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 09:25:06AM -0700, Andrew Morton wrote:
> On Thu, 22 Jun 2006 18:04:03 +0200
> Frederik Deweerdt <deweerdt@free.fr> wrote:
> 
> > Thu, Jun 22, 2006 at 12:46:48AM -0700, Andrew Morton wrote:
> > > I can bisect it if we're stuck, but that'll require beer or something.
> > 
> > FWIW, my laptop (Dell D610) gave the following results:
> > 2.6.17-mm1: suspend_device(): usb_generic_suspend+0x0/0x135 [usbcore]() returns -16
> > 2.6.17+origin.patch: suspend_device(): usb_generic_suspend+0x0/0x135 [usbcore]() returns -16
> 
> So it's in mainline already - hence it's some recently-written thing which
> was not tested in rc6-mm2.
> 
> > 2.6.17: oops
> > 2.6.17.1: oops
> 
> 2.6.17 wasn't supposed to oops.  Do you have details on this?
> 
For some reason, unknown to me, the oops won't display on the serial link :(.

Here's what I could hand copy (I've suppressed printk timing information):
x1b9/0x1be
<c0166e6b> sys_write+0x4b/0x75  <c010300f> sysenter_past_esp+0x54/0x75
Code: 05 c4 52 43 c0 31 53 43 c0 c3 8b 2d 68 6e 54 c0 8b 1d 60
6e 54 c0 8b 35 6c 6e 54 c0 8b 3d 70 6e 54 c0 ff 35 74 6e 54 c0 9d c3 90 <e8>
9d 2c ea ff e8 a2 ff ff ff 6a 03 e8 4c ab de ff 83 c4 04 c3
EIP: [<c043531c>] do_suspend_lowlevel+0x0/0x15 SS:ESP 0068:f7a0fea4
<3>BUG: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():0, irqs_disabled():1
 <c0103e56> show_trace+0x20/0x22  <c0103f5b> dump_stack+0x1e/0x20
 <c011aec7> __might_sleep+0x9e/0xa6  <c012b0cf> blocking_notifier_call_chain+0x1e/0x5b
 <c011f091> profile_task_exit+0x21/0x23  <c0120946> do_exit+0x1d/0x483
 <c0104432> do_divide_error+0x0/0xbf  <c0362c76> do_page_fault+0x3c4/0x752
 <c0103b2f> error_code+0x4f/0x54  <c013b33a> suspend_enter+0x2f/0x52
 <c013b3e0> enter_state+0x4b/0x8d  <c013b579> state_store+0xa0/0xa2
 <c01a54f1> subsys_attr_store+0x37/0x41  <c01a5772> flush_write_buffer+0x3c/046
 <c01a57e3> sysfs_write_file+0x67/0x8b  <c0166da6> vfs_write+0x1b9/0x1be
 <c0166e6b> sys_write+0x4b/0x75  <c010300f> sysenter_past_esp+0x54/0x75

This is triggered on a 2.6.17.1 kernel by:
echo mem > /sys/power/state

.config and dmesg are here:
http://fdeweerdt.free.fr/suspend_oops/

Regards,
Frederik
