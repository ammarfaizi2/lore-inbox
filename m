Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWFBQxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWFBQxo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 12:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWFBQxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 12:53:44 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:4460 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932506AbWFBQxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 12:53:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EigDw/h6s8rkeD+zjQk/FaYFV7PBajcFm4iIeSrAM/udcG34R33WON3XxhygzehQRugvlSHV/+Na88s7cDEc6eqtSxgmvfpMoLMIbOUqlsr3NgwWFdUr2CDTfYGRORSz/thXcnnqx4aHe5btGcLjYRxyET4RLp2SaS5bRidrmvE=
Message-ID: <ceccffee0606020953q545d1f3aw211da426e5cfc768@mail.gmail.com>
Date: Fri, 2 Jun 2006 18:53:42 +0200
From: "Linux Portal" <linportal@gmail.com>
To: arjanv@redhat.com, mingo@redhat.com
Subject: Kernel lock bug detected (kseriod)
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it was observed on 2.6.17-rc5-mm2. Of specific stuff I have
synaptics driver compiled in (together with psmouse - bug was observed
on a laptop - during the boot sequence!). If you need more info about
the machine or its configuration, feel free to ask. For the time being
I'm sending just what the kernel lock validator left in my kernel
log. And keep up the good work, the lock validator is definitely some
fine piece of art!


Synaptics Touchpad, model: 1, fw: 5.9, id: 0x1b6eb1, caps: 0xa84793/0x100000
serio: Synaptics pass-through port at isa0060/serio4/input0
input: SynPS/2 Synaptics TouchPad as /class/input/input2
====================================
[ BUG: possible deadlock detected! ]
------------------------------------
kseriod/133 is trying to acquire lock:
 (&ps2dev->cmd_mutex){--..}, at: [<7846b4e8>] mutex_lock+0x8/0x10

but task is already holding lock:
 (&ps2dev->cmd_mutex){--..}, at: [<7846b4e8>] mutex_lock+0x8/0x10

which could potentially lead to deadlocks!

other info that might help us debug this:
4 locks held by kseriod/133:
 #0:  (serio_mutex){--..}, at: [<7846b4e8>] mutex_lock+0x8/0x10
 #1:  (&serio->drv_mutex){--..}, at: [<7846b4e8>] mutex_lock+0x8/0x10
 #2:  (psmouse_mutex){--..}, at: [<7846b4e8>] mutex_lock+0x8/0x10
 #3:  (&ps2dev->cmd_mutex){--..}, at: [<7846b4e8>] mutex_lock+0x8/0x10

stack backtrace:
 <78105572> show_trace+0x12/0x20  <78105599> dump_stack+0x19/0x20
 <7813920e> __lockdep_acquire+0x54e/0xe00  <78139f2a> lockdep_acquire+0x7a/0xa0
 <7846b3c9> __mutex_lock_slowpath+0x49/0x160  <7846b4e8> mutex_lock+0x8/0x10
 <7834497b> ps2_command+0x3b/0x3c0  <7834ad22> psmouse_sliced_command+0x22/0x70
 <7834f471> synaptics_pt_write+0x21/0x50  <78344736> ps2_sendbyte+0x46/0x120
 <78344a29> ps2_command+0xe9/0x3c0  <7834ae8d> psmouse_probe+0x1d/0xa0
 <7834c537> psmouse_connect+0x137/0x200  <78341649>
serio_connect_driver+0x29/0x50
 <783419b6> serio_driver_probe+0x16/0x20  <782a8fb4>
driver_probe_device+0x44/0xd0
 <782a9048> __device_attach+0x8/0x10  <782a8563> bus_for_each_drv+0x63/0x90
 <782a90a6> device_attach+0x56/0x60  <782a868e> bus_attach_device+0x1e/0x40
 <782a7763> device_add+0x113/0x180  <7834299d> serio_thread+0x1cd/0x2bb
 <781322c6> kthread+0xc6/0xca  <78101005> kernel_thread_helper+0x5/0xb

-- 
http://linux.inet.hr/
