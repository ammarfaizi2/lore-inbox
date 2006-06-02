Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWFBXLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWFBXLN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 19:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWFBXLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 19:11:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030342AbWFBXLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 19:11:12 -0400
Date: Fri, 2 Jun 2006 16:13:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Linux Portal" <linportal@gmail.com>
Cc: arjanv@redhat.com, mingo@redhat.com, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Kernel lock bug detected (kseriod)
Message-Id: <20060602161354.687168de.akpm@osdl.org>
In-Reply-To: <ceccffee0606020953q545d1f3aw211da426e5cfc768@mail.gmail.com>
References: <ceccffee0606020953q545d1f3aw211da426e5cfc768@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Linux Portal" <linportal@gmail.com> wrote:
>
> Yes, it was observed on 2.6.17-rc5-mm2. Of specific stuff I have
> synaptics driver compiled in (together with psmouse - bug was observed
> on a laptop - during the boot sequence!). If you need more info about
> the machine or its configuration, feel free to ask. For the time being
> I'm sending just what the kernel lock validator left in my kernel
> log. And keep up the good work, the lock validator is definitely some
> fine piece of art!
> 
> 
> Synaptics Touchpad, model: 1, fw: 5.9, id: 0x1b6eb1, caps: 0xa84793/0x100000
> serio: Synaptics pass-through port at isa0060/serio4/input0
> input: SynPS/2 Synaptics TouchPad as /class/input/input2
> ====================================
> [ BUG: possible deadlock detected! ]
> ------------------------------------
> kseriod/133 is trying to acquire lock:
>  (&ps2dev->cmd_mutex){--..}, at: [<7846b4e8>] mutex_lock+0x8/0x10
> 
> but task is already holding lock:
>  (&ps2dev->cmd_mutex){--..}, at: [<7846b4e8>] mutex_lock+0x8/0x10
> 
> which could potentially lead to deadlocks!
> 
> other info that might help us debug this:
> 4 locks held by kseriod/133:
>  #0:  (serio_mutex){--..}, at: [<7846b4e8>] mutex_lock+0x8/0x10
>  #1:  (&serio->drv_mutex){--..}, at: [<7846b4e8>] mutex_lock+0x8/0x10
>  #2:  (psmouse_mutex){--..}, at: [<7846b4e8>] mutex_lock+0x8/0x10
>  #3:  (&ps2dev->cmd_mutex){--..}, at: [<7846b4e8>] mutex_lock+0x8/0x10
> 
> stack backtrace:
>  <78105572> show_trace+0x12/0x20  <78105599> dump_stack+0x19/0x20
>  <7813920e> __lockdep_acquire+0x54e/0xe00  <78139f2a> lockdep_acquire+0x7a/0xa0
>  <7846b3c9> __mutex_lock_slowpath+0x49/0x160  <7846b4e8> mutex_lock+0x8/0x10
>  <7834497b> ps2_command+0x3b/0x3c0  <7834ad22> psmouse_sliced_command+0x22/0x70
>  <7834f471> synaptics_pt_write+0x21/0x50  <78344736> ps2_sendbyte+0x46/0x120
>  <78344a29> ps2_command+0xe9/0x3c0  <7834ae8d> psmouse_probe+0x1d/0xa0
>  <7834c537> psmouse_connect+0x137/0x200  <78341649>
> serio_connect_driver+0x29/0x50
>  <783419b6> serio_driver_probe+0x16/0x20  <782a8fb4>
> driver_probe_device+0x44/0xd0
>  <782a9048> __device_attach+0x8/0x10  <782a8563> bus_for_each_drv+0x63/0x90
>  <782a90a6> device_attach+0x56/0x60  <782a868e> bus_attach_device+0x1e/0x40
>  <782a7763> device_add+0x113/0x180  <7834299d> serio_thread+0x1cd/0x2bb
>  <781322c6> kthread+0xc6/0xca  <78101005> kernel_thread_helper+0x5/0xb
> 

Thanks.

So we're taking ps2->cmd_mutex and then we're recurring back into
ps2_command() and then taking ps2->serio->cmd_mutex.

I suspect that's all correct/natural/expected and needs another
make-lockdep-shut-up patch.

