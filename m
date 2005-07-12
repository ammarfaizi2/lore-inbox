Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVGLOLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVGLOLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVGLOLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:11:48 -0400
Received: from [24.24.2.56] ([24.24.2.56]:55474 "EHLO ms-smtp-02.nyroc.rr.com")
	by vger.kernel.org with ESMTP id S261556AbVGLOL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:11:27 -0400
Subject: Re: "scheduling while atomic" ?
From: Steven Rostedt <rostedt@goodmis.org>
To: Mateusz Berezecki <mateuszb@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <42D3CEEC.90603@gmail.com>
References: <42D3C37C.6040401@gmail.com>
	 <1121175049.6917.19.camel@localhost.localdomain> <42D3CEEC.90603@gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 12 Jul 2005 10:11:11 -0400
Message-Id: <1121177471.6917.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 16:08 +0200, Mateusz Berezecki wrote:

> Sorry for not being too precise. Yes, your assumptions were correct ;-)
> I grab a lock using
> 
> spin_lock(&ieee->lock);
> 
> and release it using
> 
> spin_unlock(&ieee->lock);
> 
> there is quite a lot of debugging printk's inbetween. Can this be a cause ?
> 

No.

You previous showed the following output:

scheduling while atomic: insmod/0x00000001/12692
 [<c03e7352>] schedule+0x632/0x640
 [<c0119bb1>] __wake_up_common+0x41/0x70
 [<c03e74df>] wait_for_completion+0x8f/0xf0
 [<c0119b50>] default_wake_function+0x0/0x20
 [<c0119b50>] default_wake_function+0x0/0x20
 [<c012e2dd>] queue_work+0x8d/0xa0
 [<c012e070>] __call_usermodehelper+0x0/0x70
 [<c012e1a5>] call_usermodehelper_keys+0xc5/0xd0
 [<c012e070>] __call_usermodehelper+0x0/0x70
 [<c020c028>] sprintf+0x28/0x30
 [<c020955d>] kobject_hotplug+0x29d/0x310
 [<c019fc6e>] sysfs_create_link+0x3e/0x60
 [<c028b601>] class_device_add+0x161/0x1e0
 [<c036f38e>] netdev_register_sysfs+0x3e/0x100
 [<c03650db>] netdev_run_todo+0x1eb/0x220
 [<c0364dce>] register_netdev+0x5e/0x90

I assume that you call register_netdev in your module. Since this was
running insmod, this is probably called from the module_init. So what
reason do you have a lock from beginning to end?  Looking at this, you
can't call register_netdev while holding a spin_lock since it looks like
it will schedule.  So the fix is to release whatever spin lock that you
have before calling register_netdev.

-- Steve


