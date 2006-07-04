Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWGDJPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWGDJPp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 05:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWGDJPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 05:15:45 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:12194 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751238AbWGDJPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 05:15:44 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-kernel@vger.kernel.org
Subject: possible irq lock inversion at cs46xx_dsp_remove_scb
Date: Tue, 4 Jul 2006 11:15:35 +0200
User-Agent: KMail/1.9.1
Cc: alsa-devel@alsa-project.org, Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607041115.35997.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux version 2.6.17-git22 (duncan@baldrick) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #20 PREEMPT Tue Jul 4 10:35:04 CEST 2006


[  612.924372] =========================================================
[  612.948112] [ INFO: possible irq lock inversion dependency detected ]
[  612.967383] ---------------------------------------------------------
[  612.986657] aplay/5128 just changed the state of lock:
[  613.002034]  (&ins->scbs[index].lock){-...}, at: [<e099f95e>] cs46xx_dsp_remove_scb+0x1e/0xca [snd_cs46xx]
[  613.031150] but this lock was taken by another, hard-irq-safe lock in the past:
[  613.053019]  (&substream->self_group.lock){+...}
[  613.066369]
[  613.066371] and interrupts could create inverse lock ordering between them.
[  613.066374]
[  613.096680]
[  613.096682] other info that might help us debug this:
[  613.116266] 3 locks held by aplay/5128:
[  613.127745]  #0:  (&mm->mmap_sem){----}, at: [<c014209d>] sys_munmap+0x26/0x42
[  613.149615]  #1:  (&pcm->open_mutex){--..}, at: [<c028f814>] mutex_lock+0x1c/0x1f
[  613.172263]  #2:  (&chip->spos_mutex){--..}, at: [<c028f814>] mutex_lock+0x1c/0x1f
[  613.195173]
[  613.195174] the first lock's dependencies:
[  613.211900] -> (&ins->scbs[index].lock){-...} ops: 3 {
[  613.227484]    initial-use  at:
[  613.236939]                                        [<c012a38a>] lock_acquire+0x5e/0x80
[  613.262574]                                        [<c029075f>] _spin_lock+0x23/0x32
[  613.287743]                                        [<e099f6b9>] cs46xx_dsp_pcm_link+0x1f/0xf7 [snd_cs46xx]
[  613.318625]                                        [<e099a302>] snd_cs46xx_playback_trigger+0x7a/0xc9 [snd_cs46xx]
[  613.351559]                                        [<e094f45d>] snd_pcm_do_start+0x19/0x20 [snd_pcm]
[  613.380883]                                        [<e094f3c1>] snd_pcm_action_single+0x23/0x49 [snd_pcm]
[  613.411455]                                        [<e09503a7>] snd_pcm_action+0x66/0x72 [snd_pcm]
[  613.440234]                                        [<e095049a>] snd_pcm_start+0x14/0x16 [snd_pcm]
[  613.468727]                                        [<e095534e>] snd_pcm_lib_write1+0x38c/0x3fd [snd_pcm]
[  613.499065]                                        [<e095545d>] snd_pcm_lib_write+0x4b/0x59 [snd_pcm]
[  613.528624]                                        [<e0952b85>] snd_pcm_playback_ioctl1+0x91/0x3b3 [snd_pcm]
[  613.560025]                                        [<e0952ece>] snd_pcm_playback_ioctl+0x27/0x34 [snd_pcm]
[  613.590882]                                        [<c015ddec>] do_ioctl+0x20/0x65
[  613.615505]                                        [<c015e089>] vfs_ioctl+0x258/0x26b
[  613.640908]                                        [<c015e0c6>] sys_ioctl+0x2a/0x44
[  613.665817]                                        [<c0102791>] sysenter_past_esp+0x56/0x8d
[  613.692778]    hardirq-on-W at:
[  613.702232]                                        [<c012a38a>] lock_acquire+0x5e/0x80
[  613.727920]                                        [<c029075f>] _spin_lock+0x23/0x32
[  613.753036]                                        [<e099f95e>] cs46xx_dsp_remove_scb+0x1e/0xca [snd_cs46xx]
[  613.784411]                                        [<e099fbc6>] cs46xx_dsp_destroy_pcm_channel+0x52/0x7a [snd_cs46xx]
[  613.818100]                                        [<e0999466>] snd_cs46xx_playback_close+0x36/0x64 [snd_cs46xx]
[  613.850515]                                        [<e0950681>] snd_pcm_release_substream+0x3d/0x66 [snd_pcm]
[  613.882151]                                        [<e09506e5>] snd_pcm_release+0x3b/0xc3 [snd_pcm]
[  613.911190]                                        [<c014f7d4>] __fput+0xb1/0x1a4
[  613.935554]                                        [<c014f8dd>] fput+0x16/0x18
[  613.959163]                                        [<c0141058>] remove_vma+0x37/0x49
[  613.984281]                                        [<c014205d>] do_munmap+0x193/0x1ad
[  614.009707]                                        [<c01420aa>] sys_munmap+0x33/0x42
[  614.034824]                                        [<c0102791>] sysenter_past_esp+0x56/0x8d
[  614.061787]  }
[  614.066772]  ... key      at: [<e09ac2a0>] __key.19769+0x0/0xffff3e4f [snd_cs46xx]
[  614.089526]   -> (&chip->reg_lock#2){....} ops: 22 {
[  614.104694]      initial-use  at:
[  614.114720]                       [<c012a38a>] lock_acquire+0x5e/0x80
[  614.135135]                       [<c0290abe>] _spin_lock_irqsave+0x2c/0x3c
[  614.157083]                       [<e099eb50>] _dsp_create_generic_scb+0x89/0xdd [snd_cs46xx]
[  614.183733]                       [<e099ebec>] cs46xx_dsp_create_generic_scb+0x48/0x53 [snd_cs46xx]
[  614.211913]                       [<e099f255>] cs46xx_dsp_create_codec_out_scb+0x54/0x5c [snd_cs46xx]
[  614.240641]                       [<e099dea3>] cs46xx_dsp_scb_and_task_init+0x1d8/0x876 [snd_cs46xx]
[  614.269108]                       [<e099ac6b>] snd_cs46xx_start_dsp+0x94/0x182 [snd_cs46xx]
[  614.295238]                       [<e0999163>] snd_card_cs46xx_probe+0x144/0x1c1 [snd_cs46xx]
[  614.321886]                       [<c01e17f6>] pci_device_probe+0x39/0x59
[  614.343341]                       [<c02208a8>] driver_probe_device+0x45/0x98
[  614.365574]                       [<c02209c8>] __driver_attach+0x5c/0x85
[  614.386770]                       [<c021fed9>] bus_for_each_dev+0x3a/0x5f
[  614.408248]                       [<c0220784>] driver_attach+0x14/0x17
[  614.428897]                       [<c02201b8>] bus_add_driver+0x69/0xf6
[  614.449806]                       [<c0220dd3>] driver_register+0x9d/0xa2
[  614.470975]                       [<c01e1471>] __pci_register_driver+0x4f/0x6c
[  614.493703]                       [<e08d0012>] ipt_hook+0x12/0x1e [iptable_filter]
[  614.517495]                       [<c013017c>] sys_init_module+0x1345/0x14a6
[  614.539728]                       [<c0102791>] sysenter_past_esp+0x56/0x8d
[  614.561442]    }
[  614.567000]    ... key      at: [<e09ac288>] __key.21446+0x0/0xffff3e67 [snd_cs46xx]
[  614.590325]  ... acquired at:
[  614.599208]    [<c012a38a>] lock_acquire+0x5e/0x80
[  614.613754]    [<c0290abe>] _spin_lock_irqsave+0x2c/0x3c
[  614.629857]    [<e099f707>] cs46xx_dsp_pcm_link+0x6d/0xf7 [snd_cs46xx]
[  614.649598]    [<e099a302>] snd_cs46xx_playback_trigger+0x7a/0xc9 [snd_cs46xx]
[  614.671414]    [<e094f45d>] snd_pcm_do_start+0x19/0x20 [snd_pcm]
[  614.689596]    [<e094f3c1>] snd_pcm_action_single+0x23/0x49 [snd_pcm]
[  614.709051]    [<e09503a7>] snd_pcm_action+0x66/0x72 [snd_pcm]
[  614.726714]    [<e095049a>] snd_pcm_start+0x14/0x16 [snd_pcm]
[  614.744089]    [<e095534e>] snd_pcm_lib_write1+0x38c/0x3fd [snd_pcm]
[  614.763285]    [<e095545d>] snd_pcm_lib_write+0x4b/0x59 [snd_pcm]
[  614.781727]    [<e0952b85>] snd_pcm_playback_ioctl1+0x91/0x3b3 [snd_pcm]
[  614.801959]    [<e0952ece>] snd_pcm_playback_ioctl+0x27/0x34 [snd_pcm]
[  614.821700]    [<c015ddec>] do_ioctl+0x20/0x65
[  614.835205]    [<c015e089>] vfs_ioctl+0x258/0x26b
[  614.849464]    [<c015e0c6>] sys_ioctl+0x2a/0x44
[  614.863231]    [<c0102791>] sysenter_past_esp+0x56/0x8d
[  614.879075]
[  614.883543]
[  614.883544] the second lock's dependencies:
[  614.900529] -> (&substream->self_group.lock){+...} ops: 124 {
[  614.917932]    initial-use  at:
[  614.927361]                                        [<c012a38a>] lock_acquire+0x5e/0x80
[  614.953074]                                        [<c029075f>] _spin_lock+0x23/0x32
[  614.978217]                                        [<e09515f8>] snd_pcm_hw_params+0x29/0x26f [snd_pcm]
[  615.008087]                                        [<e0951b79>] snd_pcm_common_ioctl1+0x1f9/0xdc1 [snd_pcm]
[  615.039229]                                        [<e0952e90>] snd_pcm_playback_ioctl1+0x39c/0x3b3 [snd_pcm]
[  615.070892]                                        [<e0952ece>] snd_pcm_playback_ioctl+0x27/0x34 [snd_pcm]
[  615.101773]                                        [<c015ddec>] do_ioctl+0x20/0x65
[  615.126424]                                        [<c015e089>] vfs_ioctl+0x258/0x26b
[  615.151852]                                        [<c015e0c6>] sys_ioctl+0x2a/0x44
[  615.176785]                                        [<c0102791>] sysenter_past_esp+0x56/0x8d
[  615.203720]    in-hardirq-W at:
[  615.213174]                                        [<c012a38a>] lock_acquire+0x5e/0x80
[  615.238863]                                        [<c029075f>] _spin_lock+0x23/0x32
[  615.264006]                                        [<e09540bb>] snd_pcm_period_elapsed+0x37/0x200 [snd_pcm]
[  615.295175]                                        [<e099b47d>] snd_cs46xx_interrupt+0xa6/0x165 [snd_cs46xx]
[  615.326576]                                        [<c01336d2>] handle_IRQ_event+0x1f/0x4c
[  615.353330]                                        [<c0133782>] __do_IRQ+0x83/0xde
[  615.377979]                                        [<c0104e26>] do_IRQ+0x95/0xa7
[  615.402135]                                        [<c01031fd>] common_interrupt+0x25/0x2c
[  615.428862]                                        [<c01015cc>] cpu_idle+0x46/0x72
[  615.453510]                                        [<c0100257>] rest_init+0x37/0x39
[  615.478393]                                        [<c03b6691>] start_kernel+0x2c1/0x2c3
[  615.504626]                                        [<c0100199>] 0xc0100199
[  615.527172]  }
[  615.532160]  ... key      at: [<e095ed90>] __key.15635+0x0/0xffff7bee [snd_pcm]
[  615.554131]   -> (&ins->scbs[index].lock){-...} ops: 3 {
[  615.570287]      initial-use  at:
[  615.580315]                       [<c012a38a>] lock_acquire+0x5e/0x80
[  615.600755]                       [<c029075f>] _spin_lock+0x23/0x32
[  615.620651]                       [<e099f6b9>] cs46xx_dsp_pcm_link+0x1f/0xf7 [snd_cs46xx]
[  615.646288]                       [<e099a302>] snd_cs46xx_playback_trigger+0x7a/0xc9 [snd_cs46xx]
[  615.673950]                       [<e094f45d>] snd_pcm_do_start+0x19/0x20 [snd_pcm]
[  615.698054]                       [<e094f3c1>] snd_pcm_action_single+0x23/0x49 [snd_pcm]
[  615.723428]                       [<e09503a7>] snd_pcm_action+0x66/0x72 [snd_pcm]
[  615.746960]                       [<e095049a>] snd_pcm_start+0x14/0x16 [snd_pcm]
[  615.770207]                       [<e095534e>] snd_pcm_lib_write1+0x38c/0x3fd [snd_pcm]
[  615.795299]                       [<e095545d>] snd_pcm_lib_write+0x4b/0x59 [snd_pcm]
[  615.819635]                       [<e0952b85>] snd_pcm_playback_ioctl1+0x91/0x3b3 [snd_pcm]
[  615.845766]                       [<e0952ece>] snd_pcm_playback_ioctl+0x27/0x34 [snd_pcm]
[  615.871401]                       [<c015ddec>] do_ioctl+0x20/0x65
[  615.890804]                       [<c015e089>] vfs_ioctl+0x258/0x26b
[  615.910958]                       [<c015e0c6>] sys_ioctl+0x2a/0x44
[  615.930596]                       [<c0102791>] sysenter_past_esp+0x56/0x8d
[  615.952283]      hardirq-on-W at:
[  615.962308]                       [<c012a38a>] lock_acquire+0x5e/0x80
[  615.982778]                       [<c029075f>] _spin_lock+0x23/0x32
[  616.002647]                       [<e099f95e>] cs46xx_dsp_remove_scb+0x1e/0xca [snd_cs46xx]
[  616.028801]                       [<e099fbc6>] cs46xx_dsp_destroy_pcm_channel+0x52/0x7a [snd_cs46xx]
[  616.057243]                       [<e0999466>] snd_cs46xx_playback_close+0x36/0x64 [snd_cs46xx]
[  616.084437]                       [<e0950681>] snd_pcm_release_substream+0x3d/0x66 [snd_pcm]
[  616.110827]                       [<e09506e5>] snd_pcm_release+0x3b/0xc3 [snd_pcm]
[  616.134645]                       [<c014f7d4>] __fput+0xb1/0x1a4
[  616.153761]                       [<c014f8dd>] fput+0x16/0x18
[  616.172099]                       [<c0141058>] remove_vma+0x37/0x49
[  616.191995]                       [<c014205d>] do_munmap+0x193/0x1ad
[  616.212151]                       [<c01420aa>] sys_munmap+0x33/0x42
[  616.232046]                       [<c0102791>] sysenter_past_esp+0x56/0x8d
[  616.253760]    }
[  616.259319]    ... key      at: [<e09ac2a0>] __key.19769+0x0/0xffff3e4f [snd_cs46xx]
[  616.282643]     -> (&chip->reg_lock#2){....} ops: 22 {
[  616.298383]        initial-use  at:
[  616.308955]                        [<c012a38a>] lock_acquire+0x5e/0x80
[  616.329681]                        [<c0290abe>] _spin_lock_irqsave+0x2c/0x3c
[  616.351940]                        [<e099eb50>] _dsp_create_generic_scb+0x89/0xdd [snd_cs46xx]
[  616.378875]                        [<e099ebec>] cs46xx_dsp_create_generic_scb+0x48/0x53 [snd_cs46xx]
[  616.407369]                        [<e099f255>] cs46xx_dsp_create_codec_out_scb+0x54/0x5c [snd_cs46xx]
[  616.436407]                        [<e099dea3>] cs46xx_dsp_scb_and_task_init+0x1d8/0x876 [snd_cs46xx]
[  616.465160]                        [<e099ac6b>] snd_cs46xx_start_dsp+0x94/0x182 [snd_cs46xx]
[  616.491577]                        [<e0999163>] snd_card_cs46xx_probe+0x144/0x1c1 [snd_cs46xx]
[  616.518537]                        [<c01e17f6>] pci_device_probe+0x39/0x59
[  616.540302]                        [<c02208a8>] driver_probe_device+0x45/0x98
[  616.562822]                        [<c02209c8>] __driver_attach+0x5c/0x85
[  616.584329]                        [<c021fed9>] bus_for_each_dev+0x3a/0x5f
[  616.606067]                        [<c0220784>] driver_attach+0x14/0x17
[  616.627030]                        [<c02201b8>] bus_add_driver+0x69/0xf6
[  616.648275]                        [<c0220dd3>] driver_register+0x9d/0xa2
[  616.669755]                        [<c01e1471>] __pci_register_driver+0x4f/0x6c
[  616.692794]                        [<e08d0012>] ipt_hook+0x12/0x1e [iptable_filter]
[  616.716898]                        [<c013017c>] sys_init_module+0x1345/0x14a6
[  616.739443]                        [<c0102791>] sysenter_past_esp+0x56/0x8d
[  616.761443]      }
[  616.767573]      ... key      at: [<e09ac288>] __key.21446+0x0/0xffff3e67 [snd_cs46xx]
[  616.791469]    ... acquired at:
[  616.800923]    [<c012a38a>] lock_acquire+0x5e/0x80
[  616.815470]    [<c0290abe>] _spin_lock_irqsave+0x2c/0x3c
[  616.831545]    [<e099f707>] cs46xx_dsp_pcm_link+0x6d/0xf7 [snd_cs46xx]
[  616.851259]    [<e099a302>] snd_cs46xx_playback_trigger+0x7a/0xc9 [snd_cs46xx]
[  616.873053]    [<e094f45d>] snd_pcm_do_start+0x19/0x20 [snd_pcm]
[  616.891234]    [<e094f3c1>] snd_pcm_action_single+0x23/0x49 [snd_pcm]
[  616.910714]    [<e09503a7>] snd_pcm_action+0x66/0x72 [snd_pcm]
[  616.928377]    [<e095049a>] snd_pcm_start+0x14/0x16 [snd_pcm]
[  616.945752]    [<e095534e>] snd_pcm_lib_write1+0x38c/0x3fd [snd_pcm]
[  616.964948]    [<e095545d>] snd_pcm_lib_write+0x4b/0x59 [snd_pcm]
[  616.983389]    [<e0952b85>] snd_pcm_playback_ioctl1+0x91/0x3b3 [snd_pcm]
[  617.003649]    [<e0952ece>] snd_pcm_playback_ioctl+0x27/0x34 [snd_pcm]
[  617.023389]    [<c015ddec>] do_ioctl+0x20/0x65
[  617.036894]    [<c015e089>] vfs_ioctl+0x258/0x26b
[  617.051181]    [<c015e0c6>] sys_ioctl+0x2a/0x44
[  617.064946]    [<c0102791>] sysenter_past_esp+0x56/0x8d
[  617.080791]
[  617.085259]  ... acquired at:
[  617.094141]    [<c012a38a>] lock_acquire+0x5e/0x80
[  617.108685]    [<c029075f>] _spin_lock+0x23/0x32
[  617.122711]    [<e099f6b9>] cs46xx_dsp_pcm_link+0x1f/0xf7 [snd_cs46xx]
[  617.142453]    [<e099a302>] snd_cs46xx_playback_trigger+0x7a/0xc9 [snd_cs46xx]
[  617.164269]    [<e094f45d>] snd_pcm_do_start+0x19/0x20 [snd_pcm]
[  617.182452]    [<e094f3c1>] snd_pcm_action_single+0x23/0x49 [snd_pcm]
[  617.201905]    [<e09503a7>] snd_pcm_action+0x66/0x72 [snd_pcm]
[  617.219569]    [<e095049a>] snd_pcm_start+0x14/0x16 [snd_pcm]
[  617.236970]    [<e095534e>] snd_pcm_lib_write1+0x38c/0x3fd [snd_pcm]
[  617.256191]    [<e095545d>] snd_pcm_lib_write+0x4b/0x59 [snd_pcm]
[  617.274633]    [<e0952b85>] snd_pcm_playback_ioctl1+0x91/0x3b3 [snd_pcm]
[  617.294891]    [<e0952ece>] snd_pcm_playback_ioctl+0x27/0x34 [snd_pcm]
[  617.314631]    [<c015ddec>] do_ioctl+0x20/0x65
[  617.328139]    [<c015e089>] vfs_ioctl+0x258/0x26b
[  617.342423]    [<c015e0c6>] sys_ioctl+0x2a/0x44
[  617.356190]    [<c0102791>] sysenter_past_esp+0x56/0x8d
[  617.372034]
[  617.376501]   -> (&timer->lock){....} ops: 2 {
[  617.390034]      initial-use  at:
[  617.400060]                       [<c012a38a>] lock_acquire+0x5e/0x80
[  617.420500]                       [<c0290abe>] _spin_lock_irqsave+0x2c/0x3c
[  617.442475]                       [<e08645f0>] snd_timer_notify+0x2c/0xf2 [snd_timer]
[  617.467098]                       [<e094f4cf>] snd_pcm_post_start+0x51/0x56 [snd_pcm]
[  617.491669]                       [<e094f3cf>] snd_pcm_action_single+0x31/0x49 [snd_pcm]
[  617.517044]                       [<e09503a7>] snd_pcm_action+0x66/0x72 [snd_pcm]
[  617.540551]                       [<e095049a>] snd_pcm_start+0x14/0x16 [snd_pcm]
[  617.563823]                       [<e095534e>] snd_pcm_lib_write1+0x38c/0x3fd [snd_pcm]
[  617.588915]                       [<e095545d>] snd_pcm_lib_write+0x4b/0x59 [snd_pcm]
[  617.613252]                       [<e0952b85>] snd_pcm_playback_ioctl1+0x91/0x3b3 [snd_pcm]
[  617.639382]                       [<e0952ece>] snd_pcm_playback_ioctl+0x27/0x34 [snd_pcm]
[  617.665018]                       [<c015ddec>] do_ioctl+0x20/0x65
[  617.684420]                       [<c015e089>] vfs_ioctl+0x258/0x26b
[  617.704601]                       [<c015e0c6>] sys_ioctl+0x2a/0x44
[  617.724238]                       [<c0102791>] sysenter_past_esp+0x56/0x8d
[  617.745977]    }
[  617.751536]    ... key      at: [<e0868c98>] __key.15468+0x0/0xffffd7f8 [snd_timer]
[  617.774601]  ... acquired at:
[  617.783484]    [<c012a38a>] lock_acquire+0x5e/0x80
[  617.798028]    [<c0290abe>] _spin_lock_irqsave+0x2c/0x3c
[  617.814133]    [<e08645f0>] snd_timer_notify+0x2c/0xf2 [snd_timer]
[  617.832834]    [<e094f4cf>] snd_pcm_post_start+0x51/0x56 [snd_pcm]
[  617.851534]    [<e094f3cf>] snd_pcm_action_single+0x31/0x49 [snd_pcm]
[  617.871014]    [<e09503a7>] snd_pcm_action+0x66/0x72 [snd_pcm]
[  617.888651]    [<e095049a>] snd_pcm_start+0x14/0x16 [snd_pcm]
[  617.906053]    [<e095534e>] snd_pcm_lib_write1+0x38c/0x3fd [snd_pcm]
[  617.925249]    [<e095545d>] snd_pcm_lib_write+0x4b/0x59 [snd_pcm]
[  617.943664]    [<e0952b85>] snd_pcm_playback_ioctl1+0x91/0x3b3 [snd_pcm]
[  617.963924]    [<e0952ece>] snd_pcm_playback_ioctl+0x27/0x34 [snd_pcm]
[  617.983664]    [<c015ddec>] do_ioctl+0x20/0x65
[  617.997142]    [<c015e089>] vfs_ioctl+0x258/0x26b
[  618.011402]    [<c015e0c6>] sys_ioctl+0x2a/0x44
[  618.025169]    [<c0102791>] sysenter_past_esp+0x56/0x8d
[  618.041013]
[  618.045480]   -> (&waitqueue_lock_key){++..} ops: 108332 {
[  618.062156]      initial-use  at:
[  618.072181]                       [<c012a38a>] lock_acquire+0x5e/0x80
[  618.092596]                       [<c0290a0f>] _spin_lock_irq+0x29/0x38
[  618.113531]                       [<c028ed84>] wait_for_completion+0x24/0xaf
[  618.135740]                       [<c012424b>] keventd_create_kthread+0x2b/0x57
[  618.158803]                       [<c0124450>] kthread_create+0xdb/0x121
[  618.179999]                       [<c0118363>] cpu_callback+0x49/0x8e
[  618.200440]                       [<c03c1a9a>] spawn_ksoftirqd+0x1c/0x32
[  618.221661]                       [<c01002bb>] init+0x26/0x213
[  618.240284]                       [<c0100add>] kernel_thread_helper+0x5/0xb
[  618.262256]      in-hardirq-W at:
[  618.272282]                       [<c012a38a>] lock_acquire+0x5e/0x80
[  618.292698]                       [<c0290abe>] _spin_lock_irqsave+0x2c/0x3c
[  618.314671]                       [<c010ff63>] complete+0x12/0x3e
[  618.334049]                       [<c01c4ab1>] blk_end_sync_rq+0x1f/0x22
[  618.355270]                       [<c01c4a81>] end_that_request_last+0x7f/0x90
[  618.378073]                       [<c0229e6b>] ide_end_drive_cmd+0x2ba/0x2ce
[  618.400282]                       [<c022e68a>] task_no_data_intr+0x60/0x68
[  618.422021]                       [<c022aaf6>] ide_intr+0x147/0x1a7
[  618.441891]                       [<c01336d2>] handle_IRQ_event+0x1f/0x4c
[  618.463346]                       [<c0133782>] __do_IRQ+0x83/0xde
[  618.482723]                       [<c0104e26>] do_IRQ+0x95/0xa7
[  618.501631]                       [<c01031fd>] common_interrupt+0x25/0x2c
[  618.523085]                       [<c01015cc>] cpu_idle+0x46/0x72
[  618.542488]                       [<c0100257>] rest_init+0x37/0x39
[  618.562124]                       [<c03b6691>] start_kernel+0x2c1/0x2c3
[  618.583084]                       [<c0100199>] 0xc0100199
[  618.600358]      in-softirq-W at:
[  618.610384]                       [<c012a38a>] lock_acquire+0x5e/0x80
[  618.630772]                       [<c0290abe>] _spin_lock_irqsave+0x2c/0x3c
[  618.652773]                       [<c010ff63>] complete+0x12/0x3e
[  618.672122]                       [<c0122728>] wakeme_after_rcu+0xb/0xd
[  618.693057]                       [<c012260c>] __rcu_process_callbacks+0xff/0x153
[  618.716590]                       [<c0122672>] rcu_process_callbacks+0x12/0x23
[  618.739369]                       [<c01183ed>] tasklet_action+0x45/0x76
[  618.760303]                       [<c0118a4c>] __do_softirq+0x55/0xae
[  618.780746]                       [<c0104d2c>] do_softirq+0x58/0xbd
[  618.800614]    }
[  618.806173]    ... key      at: [<c03efd98>] waitqueue_lock_key+0x0/0x8
[  618.826122]     -> (&rq->rq_lock_key){++..} ops: 422511 {
[  618.842589]        initial-use  at:
[  618.853159]                        [<c012a38a>] lock_acquire+0x5e/0x80
[  618.873888]                        [<c0290abe>] _spin_lock_irqsave+0x2c/0x3c
[  618.896171]                        [<c011018f>] init_idle+0x4c/0x72
[  618.916093]                        [<c03c154c>] sched_init+0xba/0xbd
[  618.936302]                        [<c03b642e>] start_kernel+0x5e/0x2c3
[  618.957288]                        [<c0100199>] 0xc0100199
[  618.974899]        in-hardirq-W at:
[  618.985470]                        [<c012a38a>] lock_acquire+0x5e/0x80
[  619.006222]                        [<c029075f>] _spin_lock+0x23/0x32
[  619.026405]                        [<c011120b>] scheduler_tick+0xa8/0x2ab
[  619.047938]                        [<c011b642>] update_process_times+0x59/0x65
[  619.070715]                        [<c0105891>] timer_interrupt+0x5e/0x96
[  619.092247]                        [<c01336d2>] handle_IRQ_event+0x1f/0x4c
[  619.113988]                        [<c0133782>] __do_IRQ+0x83/0xde
[  619.133702]                        [<c0104e26>] do_IRQ+0x95/0xa7
[  619.152872]                        [<c01031fd>] common_interrupt+0x25/0x2c
[  619.174635]                        [<c010ca23>] clear_IO_APIC_pin+0x83/0x11f
[  619.196896]                        [<c010cad2>] clear_IO_APIC+0x13/0x2d
[  619.217908]                        [<c03bfe8b>] setup_IO_APIC+0x217/0xb62
[  619.239388]                        [<c03becc8>] APIC_init_uniprocessor+0xd2/0xe0
[  619.262713]                        [<c01002c5>] init+0x30/0x213
[  619.281622]                        [<c0100add>] kernel_thread_helper+0x5/0xb
[  619.303907]        in-softirq-W at:
[  619.314480]                        [<c012a38a>] lock_acquire+0x5e/0x80
[  619.335206]                        [<c029075f>] _spin_lock+0x23/0x32
[  619.355439]                        [<c011120b>] scheduler_tick+0xa8/0x2ab
[  619.376947]                        [<c011b642>] update_process_times+0x59/0x65
[  619.399776]                        [<c0105891>] timer_interrupt+0x5e/0x96
[  619.421282]                        [<c01336d2>] handle_IRQ_event+0x1f/0x4c
[  619.443049]                        [<c0133782>] __do_IRQ+0x83/0xde
[  619.462738]                        [<c0104e26>] do_IRQ+0x95/0xa7
[  619.481933]                        [<c01031fd>] common_interrupt+0x25/0x2c
[  619.503671]                        [<c014f4af>] file_free_rcu+0xf/0x11
[  619.524398]                        [<c012260c>] __rcu_process_callbacks+0xff/0x153
[  619.548217]                        [<c0122672>] rcu_process_callbacks+0x12/0x23
[  619.571308]                        [<c01183ed>] tasklet_action+0x45/0x76
[  619.592553]                        [<c0118a4c>] __do_softirq+0x55/0xae
[  619.613280]                        [<c0104d2c>] do_softirq+0x58/0xbd
[  619.633462]      }
[  619.639592]      ... key      at: [<c03e938c>] per_cpu__runqueues+0x98c/0x994
[  619.661150]    ... acquired at:
[  619.670604]    [<c012a38a>] lock_acquire+0x5e/0x80
[  619.685124]    [<c029075f>] _spin_lock+0x23/0x32
[  619.699150]    [<c01106e0>] task_rq_lock+0x17/0x1e
[  619.713696]    [<c0110bb5>] try_to_wake_up+0x18/0x108
[  619.729020]    [<c0110cb0>] default_wake_function+0xb/0xd
[  619.745382]    [<c010fe9d>] __wake_up_common+0x2f/0x53
[  619.760942]    [<c010ff7c>] complete+0x2b/0x3e
[  619.774447]    [<c0124526>] kthread+0x90/0xdb
[  619.787694]    [<c0100add>] kernel_thread_helper+0x5/0xb
[  619.803799]
[  619.808265]  ... acquired at:
[  619.817149]    [<c012a38a>] lock_acquire+0x5e/0x80
[  619.831694]    [<c0290abe>] _spin_lock_irqsave+0x2c/0x3c
[  619.847797]    [<c010fed4>] __wake_up+0x13/0x39
[  619.861537]    [<e0954218>] snd_pcm_period_elapsed+0x194/0x200 [snd_pcm]
[  619.881797]    [<e099b47d>] snd_cs46xx_interrupt+0xa6/0x165 [snd_cs46xx]
[  619.902057]    [<c01336d2>] handle_IRQ_event+0x1f/0x4c
[  619.917641]    [<c0133782>] __do_IRQ+0x83/0xde
[  619.931147]    [<c0104e26>] do_IRQ+0x95/0xa7
[  619.944107]    [<c01031fd>] common_interrupt+0x25/0x2c
[  619.959666]    [<c01015cc>] cpu_idle+0x46/0x72
[  619.973173]    [<c0100257>] rest_init+0x37/0x39
[  619.986939]    [<c03b6691>] start_kernel+0x2c1/0x2c3
[  620.002003]    [<c0100199>] 0xc0100199
[  620.013432]
[  620.017900]
[  620.017901] stack backtrace:
[  620.031230]  [<c010398b>] show_trace_log_lvl+0x54/0xfd
[  620.046673]  [<c0104aaa>] show_trace+0xd/0x10
[  620.059765]  [<c0104ac4>] dump_stack+0x17/0x1b
[  620.073115]  [<c012895b>] print_irq_inversion_bug+0xe1/0xee
[  620.089971]  [<c01289d5>] check_usage_backwards+0x32/0x3b
[  620.106306]  [<c0129262>] mark_lock+0x1ff/0x349
[  620.120048]  [<c0129af7>] __lock_acquire+0x41d/0x9d3
[  620.135087]  [<c012a38a>] lock_acquire+0x5e/0x80
[  620.149086]  [<c029075f>] _spin_lock+0x23/0x32
[  620.162573]  [<e099f95e>] cs46xx_dsp_remove_scb+0x1e/0xca [snd_cs46xx]
[  620.182194]  [<e099fbc6>] cs46xx_dsp_destroy_pcm_channel+0x52/0x7a [snd_cs46xx]
[  620.204122]  [<e0999466>] snd_cs46xx_playback_close+0x36/0x64 [snd_cs46xx]
[  620.224733]  [<e0950681>] snd_pcm_release_substream+0x3d/0x66 [snd_pcm]
[  620.244585]  [<e09506e5>] snd_pcm_release+0x3b/0xc3 [snd_pcm]
[  620.261830]  [<c014f7d4>] __fput+0xb1/0x1a4
[  620.274657]  [<c014f8dd>] fput+0x16/0x18
[  620.286687]  [<c0141058>] remove_vma+0x37/0x49
[  620.300239]  [<c014205d>] do_munmap+0x193/0x1ad
[  620.314059]  [<c01420aa>] sys_munmap+0x33/0x42
[  620.327616]  [<c0102791>] sysenter_past_esp+0x56/0x8d
