Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVKKJe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVKKJe7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 04:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVKKJe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 04:34:58 -0500
Received: from relay4.usu.ru ([194.226.235.39]:49096 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S932316AbVKKJe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 04:34:57 -0500
Message-ID: <4374651A.7000605@ums.usu.ru>
Date: Fri, 11 Nov 2005 14:32:10 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, sfrench@us.ibm.com,
       castet.matthieu@free.fr, greg@kroah.com, vojtech@suse.cz,
       dtor_core@ameritech.net
Subject: Re: 2.6.14-mm1
References: <20051106182447.5f571a46.akpm@osdl.org>	<436F7DAA.8070803@ums.usu.ru>	<20051107115210.33e4f0bf.akpm@osdl.org>	<200511072021.jA7KL4kA030734@turing-police.cc.vt.edu> <20051107124647.212a670d.akpm@osdl.org>
In-Reply-To: <20051107124647.212a670d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.32.0.58; VDF: 6.32.0.170; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Valdis.Kletnieks@vt.edu wrote:
>  
>
>>On Mon, 07 Nov 2005 11:52:10 PST, Andrew Morton said:
>>
>>    
>>
>>>>2) The PS/2 keyboard death on ppp traffic is still not fixed. 
>>>>Reproducible even on slow GPRS if there's something else (e.g. glxgears) 
>>>>that eats some CPU time. When keyboard is dead, events/0 consomes 100% 
>>>>of CPU. Nothing in dmesg. If you outline some suspicious pieces of code, 
>>>>I will insert printks there in order to debug this.
>>>>        
>>>>
>>>input guys cc'ed.
>>>      
>>>
>>Getting myself on the cc: list, as I've seen this one on 2.6.14-rc5-mm1 (haven't
>>nailed it on 14-mm1 *yet*, but only been up for 12 hours).  Also, some
>>additional info:
>>
>>The keyboard is dead, but other stuff still works - I've been able to issue
>>commands by laborious cut-n-paste into an xterm window.  X is still up and
>>responding, as are all the clients, so it's *not* a hard loop in events/0.
>>
>>Also, I've had gkrellm running when it hits, and it will show incoming data
>>rates on the modem of 3.5Mbytes/sec (as opposed to the 5K/sec you'd expect from
>>a 56k modem).  A few times, I've had it go into auto-ambush on an iptables rule,
>>with the same rule tripping several tens of thousands of times in a row,
>>which makes me think it's got to do with a short packet (such as an inbound
>>SYN packet) going into replicator mode and just being handed up from the
>>device driver over and over, thousands of times....
>>
>>alt-sysrq still works - I can sysrq-T to get traces, -S to sync, -B to reboot
>>and so on, and the output gets through klogd and syslogd and into /var/adm/messages.
>>    
>>
>
>That sounds like softirq starvation.
>
>Or maybe the input layer uses keventd services and keventd is stuck.
>
>  
>
>>I'm able to often trigger the bug by opening a new tab in Firefox, as that (a)
>>involves small SYN+ACK packets coming back and (b) a Firefox bug causes it to
>>chew CPU when displaying a page in a tab....
>>
>>I'm willing to test-drive any debugging/patches needed, as this is probably the
>>single biggest stability hit I have in -mm at the moment.
>>
>>    
>>
>
>I'd try hitting sysrq-p ten times, then take a look at the logs.
>  
>
Here are the relevant parts of the log:

[  568.588189] Pid: 4, comm:             events/0
[  568.588193] EIP: 0060:[<e0a054d0>] CPU: 0
[  568.588213] EIP is at ppp_asynctty_receive+0x50/0xe0 [ppp_async]
[  568.588219]  EFLAGS: 00000286    Not tainted  (2.6.14-mm1-home)
[  568.588225] EAX: 00020000 EBX: 00000286 ECX: d85c0c00 EDX: 00000038
[  568.588230] ESI: d85c0c00 EDI: d859d000 EBP: dff8df04 DS: 007b ES: 007b
[  568.588238] CR0: 8005003b CR2: b72a0000 CR3: 18776000 CR4: 000006d0
[  568.588243]  [<c01013f0>] show_regs+0x150/0x178
[  568.588253]  [<c0234a34>] sysrq_handle_showregs+0x24/0x40
[  568.588268]  [<c0234c7e>] __handle_sysrq+0x8e/0x150
[  568.588275]  [<c0234d75>] handle_sysrq+0x35/0x40
[  568.588281]  [<c022f1b7>] kbd_keycode+0x297/0x340
[  568.588302]  [<c022f2fd>] kbd_event+0x9d/0x100
[  568.588308]  [<c0240f6b>] input_event+0xdb/0x420
[  568.588321]  [<c024349e>] atkbd_report_key+0x3e/0xc0
[  568.588331]  [<c024375d>] atkbd_interrupt+0x23d/0x640
[  568.588338]  [<c02378f5>] serio_interrupt+0x45/0x92
[  568.588348]  [<c02385e7>] i8042_interrupt+0x197/0x2b0
[  568.588357]  [<c013e75c>] handle_IRQ_event+0x4c/0xd0
[  568.588374]  [<c013e874>] __do_IRQ+0x94/0x130
[  568.588381]  [<c0105613>] do_IRQ+0x33/0x70
[  568.588393]  [<c0103cca>] common_interrupt+0x1a/0x20
[  568.588399]  [<c022549c>] flush_to_ldisc+0x8c/0x110
[  568.588406]  [<c012e08e>] worker_thread+0x1ce/0x2a0
[  568.588415]  [<c013220d>] kthread+0xad/0xc0
[  568.588428]  [<c010141d>] kernel_thread_helper+0x5/0x18
[  568.588435] ---------------------------
[  568.588438] | preempt count: 00010003 ]
[  568.588442] | 3 level deep critical section nesting:
[  568.588445] ----------------------------------------
[  568.588449] .. [<e0a054b1>] .... ppp_asynctty_receive+0x31/0xe0 
[ppp_async]
[  568.588458] .....[<c022549c>] ..   ( <= flush_to_ldisc+0x8c/0x110)
[  568.588464] .. [<c02378d2>] .... serio_interrupt+0x22/0x92
[  568.588471] .....[<c02385e7>] ..   ( <= i8042_interrupt+0x197/0x2b0)
[  568.588478] .. [<c0234c09>] .... __handle_sysrq+0x19/0x150
[  568.588484] .....[<c0234d75>] ..   ( <= handle_sysrq+0x35/0x40)
[  568.588490]
[  568.588493]  <6>SysRq : Show Regs

Note that the top-most critical section is sometimes released, and this 
results in somethong like this:

[  575.429471]
[  575.429478] Pid: 1370, comm:              XFree86
[  575.429482] EIP: 0073:[<086458b0>] CPU: 0
[  575.429502] EIP is at 0x86458b0
[  575.429506]  ESP: 007b:bfe6e1e0 EFLAGS: 00003206    Not tainted  
(2.6.14-mm1-home)
[  575.429515] EAX: 30000000 EBX: b0346f38 ECX: 00000000 EDX: 00ffffff
[  575.429520] ESI: 08c8bcd5 EDI: 0000001a EBP: bfe6e238 DS: 007b ES: 007b
[  575.429528] CR0: 8005003b CR2: b72a0000 CR3: 1e069000 CR4: 000006d0
[  575.429533]  [<c01013f0>] show_regs+0x150/0x178
[  575.429544]  [<c0234a34>] sysrq_handle_showregs+0x24/0x40
[  575.429557]  [<c0234c7e>] __handle_sysrq+0x8e/0x150
[  575.429564]  [<c0234d75>] handle_sysrq+0x35/0x40
[  575.429570]  [<c022f1b7>] kbd_keycode+0x297/0x340
[  575.429590]  [<c022f2fd>] kbd_event+0x9d/0x100
[  575.429597]  [<c0240f6b>] input_event+0xdb/0x420
[  575.429610]  [<c024349e>] atkbd_report_key+0x3e/0xc0
[  575.429620]  [<c024375d>] atkbd_interrupt+0x23d/0x640
[  575.429627]  [<c02378f5>] serio_interrupt+0x45/0x92
[  575.429637]  [<c02385e7>] i8042_interrupt+0x197/0x2b0
[  575.429645]  [<c013e75c>] handle_IRQ_event+0x4c/0xd0
[  575.429662]  [<c013e874>] __do_IRQ+0x94/0x130
[  575.429668]  [<c0105613>] do_IRQ+0x33/0x70
[  575.429680]  [<c0103cca>] common_interrupt+0x1a/0x20
[  575.429687] ---------------------------
[  575.429690] | preempt count: 00010002 ]
[  575.429694] | 2 level deep critical section nesting:
[  575.429697] ----------------------------------------
[  575.429701] .. [<c02378d2>] .... serio_interrupt+0x22/0x92
[  575.429708] .....[<c02385e7>] ..   ( <= i8042_interrupt+0x197/0x2b0)
[  575.429715] .. [<c0234c09>] .... __handle_sysrq+0x19/0x150
[  575.429721] .....[<c0234d75>] ..   ( <= handle_sysrq+0x35/0x40)
[  575.429726]
[  575.429730]  <6>SysRq : Show Regs

or this:

[  580.460364] Pid: 1483, comm:      mozilla-thunder
[  580.460369] EIP: 0073:[<b79ab806>] CPU: 0
[  580.460388] EIP is at 0xb79ab806
[  580.460392]  ESP: 007b:bfee3bd0 EFLAGS: 00000246    Not tainted  
(2.6.14-mm1-home)
[  580.460401] EAX: 00000000 EBX: b79b1b7c ECX: 00000001 EDX: 0808c65c
[  580.460406] ESI: 000005cb EDI: b7b29100 EBP: bfee3be8 DS: 007b ES: 007b
[  580.460413] CR0: 8005003b CR2: b72a0000 CR3: 18776000 CR4: 000006d0
[  580.460418]  [<c01013f0>] show_regs+0x150/0x178
[  580.460429]  [<c0234a34>] sysrq_handle_showregs+0x24/0x40
[  580.460442]  [<c0234c7e>] __handle_sysrq+0x8e/0x150
[  580.460449]  [<c0234d75>] handle_sysrq+0x35/0x40
[  580.460456]  [<c022f1b7>] kbd_keycode+0x297/0x340
[  580.460475]  [<c022f2fd>] kbd_event+0x9d/0x100
[  580.460481]  [<c0240f6b>] input_event+0xdb/0x420
[  580.460494]  [<c024349e>] atkbd_report_key+0x3e/0xc0
[  580.460504]  [<c024375d>] atkbd_interrupt+0x23d/0x640
[  580.460511]  [<c02378f5>] serio_interrupt+0x45/0x92
[  580.460521]  [<c02385e7>] i8042_interrupt+0x197/0x2b0
[  580.460529]  [<c013e75c>] handle_IRQ_event+0x4c/0xd0
[  580.460546]  [<c013e874>] __do_IRQ+0x94/0x130
[  580.460552]  [<c0105613>] do_IRQ+0x33/0x70
[  580.460564]  [<c0103cca>] common_interrupt+0x1a/0x20
[  580.460571] ---------------------------
[  580.460574] | preempt count: 00010002 ]
[  580.460577] | 2 level deep critical section nesting:
[  580.460581] ----------------------------------------
[  580.460585] .. [<c02378d2>] .... serio_interrupt+0x22/0x92
[  580.460591] .....[<c02385e7>] ..   ( <= i8042_interrupt+0x197/0x2b0)
[  580.460598] .. [<c0234c09>] .... __handle_sysrq+0x19/0x150
[  580.460605] .....[<c0234d75>] ..   ( <= handle_sysrq+0x35/0x40)
[  580.460610]
[  580.460614]  <6>SysRq : Show Regs

The pppd is in "unkillable" D state. When I paste the characters to form 
a "killall -9 pppd", traces become looking like this (why does this long 
trace occupy less than a millisecond?):

[ 1180.933391] Call Trace:
[ 1180.933394]  [<c02d0e13>] schedule_timeout+0xa3/0xb0
[ 1180.933401]  [<c0176ca9>] do_poll+0xa9/0xd0
[ 1180.933408]  [<c0176e3b>] sys_poll+0x16b/0x250
[ 1180.933414]  [<c0103285>] syscall_call+0x7/0xb
[ 1180.933420] ---------------------------
[ 1180.933423] | preempt count: 00000002 ]
[ 1180.933427] | 2 level deep critical section nesting:
[ 1180.933430] ----------------------------------------
[ 1180.933434] .. [<c02cfc06>] .... schedule+0x46/0x690
[ 1180.933440] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.933447] .. [<c02cfc9a>] .... schedule+0xda/0x690
[ 1180.933454] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.933460]
[ 1180.933463] xftaskbar4    S C01324B1     0  1415      1          
1417  1413 (NOTLB)
[ 1180.933474] da7ddf00 c16700d0 c03cf920 c01324b1 d43ad000 da9a53a0 
da7ddf98 da7ddeec
[ 1180.933485]        c1665830 00000d1c 660b453e 0000010f c16700d0 
c16701f8 7fffffff da7ddf58
[ 1180.933496]        da7ddf5c da7ddf3c c02d0e13 c0279133 da9a53a0 
dba993c0 da7ddf98 00000000
[ 1180.933508] Call Trace:
[ 1180.933511]  [<c02d0e13>] schedule_timeout+0xa3/0xb0
[ 1180.933518]  [<c0176ca9>] do_poll+0xa9/0xd0
[ 1180.933525]  [<c0176e3b>] sys_poll+0x16b/0x250
[ 1180.933531]  [<c0103285>] syscall_call+0x7/0xb
[ 1180.933537] ---------------------------
[ 1180.933540] | preempt count: 00000002 ]
[ 1180.933543] | 2 level deep critical section nesting:
[ 1180.933547] ----------------------------------------
[ 1180.933551] .. [<c02cfc06>] .... schedule+0x46/0x690
[ 1180.933557] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.933564] .. [<c02cfc9a>] .... schedule+0xda/0x690
[ 1180.933571] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.933577]
[ 1180.933580] xfdesktop     S DA09E000     0  1417      1          
1419  1415 (NOTLB)
[ 1180.933591] da09ff00 c1665830 c03cf920 da09e000 da09fee0 c0126133 
da09ff14 da09ff14
[ 1180.933601]        c1665250 00000712 660ccf3d 0000010f c1665830 
c1665958 da09ff14 000d754d
[ 1180.933613]        da09ff5c da09ff3c c02d0dc4 da09ff14 000d754d 
da0dece0 c03d5ab0 c03e5774
[ 1180.933625] Call Trace:
[ 1180.933628]  [<c02d0dc4>] schedule_timeout+0x54/0xb0
[ 1180.933635]  [<c0176ca9>] do_poll+0xa9/0xd0
[ 1180.933641]  [<c0176e3b>] sys_poll+0x16b/0x250
[ 1180.933648]  [<c0103285>] syscall_call+0x7/0xb
[ 1180.933654] ---------------------------
[ 1180.933657] | preempt count: 00000002 ]
[ 1180.933660] | 2 level deep critical section nesting:
[ 1180.933664] ----------------------------------------
[ 1180.933668] .. [<c02cfc06>] .... schedule+0x46/0x690
[ 1180.933674] .....[<c02d0dc4>] ..   ( <= schedule_timeout+0x54/0xb0)
[ 1180.933681] .. [<c02cfc9a>] .... schedule+0xda/0x690
[ 1180.933688] .....[<c02d0dc4>] ..   ( <= schedule_timeout+0x54/0xb0)
[ 1180.933694]
[ 1180.933697] xfce4-panel   S DA1B6000     0  1419      1          
1421  1417 (NOTLB)
[ 1180.933708] da1b7f00 c1664690 c03cf920 da1b6000 da1b7ee0 c0126133 
da1b7f14 da1b7f14
[ 1180.933719]        dff80610 0000143a f217a561 00000112 c1664690 
c16647b8 da1b7f14 000d3c65
[ 1180.933730]        da1b7f5c da1b7f3c c02d0dc4 da1b7f14 000d3c65 
da0de3e0 c03d5230 c03d5230
[ 1180.933742] Call Trace:
[ 1180.933745]  [<c02d0dc4>] schedule_timeout+0x54/0xb0
[ 1180.933752]  [<c0176ca9>] do_poll+0xa9/0xd0
[ 1180.933759]  [<c0176e3b>] sys_poll+0x16b/0x250
[ 1180.933765]  [<c0103285>] syscall_call+0x7/0xb
[ 1180.933771] ---------------------------
[ 1180.933774] | preempt count: 00000002 ]
[ 1180.933778] | 2 level deep critical section nesting:
[ 1180.933781] ----------------------------------------
[ 1180.933785] .. [<c02cfc06>] .... schedule+0x46/0x690
[ 1180.933791] .....[<c02d0dc4>] ..   ( <= schedule_timeout+0x54/0xb0)
[ 1180.933798] .. [<c02cfc9a>] .... schedule+0xda/0x690
[ 1180.933804] .....[<c02d0dc4>] ..   ( <= schedule_timeout+0x54/0xb0)
[ 1180.933811]
[ 1180.933814] gaim          S C01324B1     0  1421      1          
1423  1419 (NOTLB)
[ 1180.933825] d9907f00 c1665250 c03cf920 c01324b1 d3cb8000 d9690a40 
d9907f98 d9907eec
[ 1180.933836]        dff80610 000005df 660e1a46 0000010f c1665250 
c1665378 7fffffff d9907f58
[ 1180.933847]        d9907f5c d9907f3c c02d0e13 c0279133 d9690a40 
d9932c60 d9907f98 00000000
[ 1180.933859] Call Trace:
[ 1180.933862]  [<c02d0e13>] schedule_timeout+0xa3/0xb0
[ 1180.933869]  [<c0176ca9>] do_poll+0xa9/0xd0
[ 1180.933876]  [<c0176e3b>] sys_poll+0x16b/0x250
[ 1180.933882]  [<c0103285>] syscall_call+0x7/0xb
[ 1180.933888] ---------------------------
[ 1180.933891] | preempt count: 00000002 ]
[ 1180.933894] | 2 level deep critical section nesting:
[ 1180.933898] ----------------------------------------
[ 1180.933902] .. [<c02cfc06>] .... schedule+0x46/0x690
[ 1180.933908] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.933915] .. [<c02cfc9a>] .... schedule+0xda/0x690
[ 1180.933922] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.933928]
[ 1180.933931] Terminal      S D9EC4000     0  1423      1  1424    
1488  1421 (NOTLB)
[ 1180.933942] d9ec5f00 c1658c50 c03cf920 d9ec4000 d9ec5ee0 c0126133 
d9ec5f14 d9ec5f14
[ 1180.933953]        dff80610 00002788 eb5d335c 00000112 c1658c50 
c1658d78 d9ec5f14 000d3c41
[ 1180.933964]        d9ec5f5c d9ec5f3c c02d0dc4 d9ec5f14 000d3c41 
00000145 c03d5110 c03d5110
[ 1180.933976] Call Trace:
[ 1180.933979]  [<c02d0dc4>] schedule_timeout+0x54/0xb0
[ 1180.933987]  [<c0176ca9>] do_poll+0xa9/0xd0
[ 1180.933993]  [<c0176e3b>] sys_poll+0x16b/0x250
[ 1180.933999]  [<c0103285>] syscall_call+0x7/0xb
[ 1180.934005] ---------------------------
[ 1180.934008] | preempt count: 00000002 ]
[ 1180.934012] | 2 level deep critical section nesting:
[ 1180.934015] ----------------------------------------
[ 1180.934019] .. [<c02cfc06>] .... schedule+0x46/0x690
[ 1180.934025] .....[<c02d0dc4>] ..   ( <= schedule_timeout+0x54/0xb0)
[ 1180.934033] .. [<c02cfc9a>] .... schedule+0xda/0x690
[ 1180.934039] .....[<c02d0dc4>] ..   ( <= schedule_timeout+0x54/0xb0)
[ 1180.934045]
[ 1180.934048] gnome-pty-hel S C15D9560     0  1424   1423          
1425       (NOTLB)
[ 1180.934059] dc277d3c c1659810 c03cf920 c15d9560 c13bf0a0 c1658c50 
00000f80 dc277d30
[ 1180.934070]        d6309410 00000265 ebb1d543 00000033 c1659810 
c1659938 7fffffff 7fffffff
[ 1180.934081]        dc276000 dc277d78 c02d0e13 0070ff80 00000000 
00000000 00000180 dc277e7c
[ 1180.934092] Call Trace:
[ 1180.934095]  [<c02d0e13>] schedule_timeout+0xa3/0xb0
[ 1180.934103]  [<c02ce2b2>] unix_stream_data_wait+0xc2/0x120
[ 1180.934110]  [<c02ce6e3>] unix_stream_recvmsg+0x3d3/0x420
[ 1180.934118]  [<c0278b58>] sock_aio_read+0xe8/0x100
[ 1180.934125]  [<c0160dd2>] do_sync_read+0xb2/0x100
[ 1180.934132]  [<c0160f9b>] vfs_read+0x17b/0x190
[ 1180.934138]  [<c016128b>] sys_read+0x4b/0x80
[ 1180.934144]  [<c0103285>] syscall_call+0x7/0xb
[ 1180.934150] ---------------------------
[ 1180.934154] | preempt count: 00000002 ]
[ 1180.934157] | 2 level deep critical section nesting:
[ 1180.934160] ----------------------------------------
[ 1180.934164] .. [<c02cfc06>] .... schedule+0x46/0x690
[ 1180.934171] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.934178] .. [<c02cfc9a>] .... schedule+0xda/0x690
[ 1180.934184] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.934191]
[ 1180.934193] bash          S C1658C50     0  1425   1423          
1439  1424 (NOTLB)
[ 1180.934205] d862be78 c1659230 c03cf920 c1658c50 c1658c50 0a1d1b8e 
d862be6c c011829b
[ 1180.934215]        c1658c50 000004f9 0a1d4319 00000019 c1659230 
c1659358 7fffffff dbaa200c
[ 1180.934227]        bfc0c7ff d862beb4 c02d0e13 00000001 c032bfc8 
00000001 d862bea0 c0118db2
[ 1180.934238] Call Trace:
[ 1180.934241]  [<c02d0e13>] schedule_timeout+0xa3/0xb0
[ 1180.934249]  [<c02282be>] read_chan+0x52e/0x620
[ 1180.934256]  [<c0222c1f>] tty_read+0xcf/0xe0
[ 1180.934262]  [<c0160ed8>] vfs_read+0xb8/0x190
[ 1180.934268]  [<c016128b>] sys_read+0x4b/0x80
[ 1180.934275]  [<c0103285>] syscall_call+0x7/0xb
[ 1180.934280] ---------------------------
[ 1180.934284] | preempt count: 00000002 ]
[ 1180.934287] | 2 level deep critical section nesting:
[ 1180.934290] ----------------------------------------
[ 1180.934294] .. [<c02cfc06>] .... schedule+0x46/0x690
[ 1180.934301] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.934308] .. [<c02cfc9a>] .... schedule+0xda/0x690
[ 1180.934314] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.934320]
[ 1180.934323] bash          S 00000027     0  1439   1423          
1531  1425 (NOTLB)
[ 1180.934334] d8753e78 c1658c50 c03cf950 00000027 00000286 d8753e5c 
d78ef27c 00000027
[ 1180.934345]        c1658c50 0000477b d78f1f54 00000027 dfc58050 
dfc58178 7fffffff d85b500c
[ 1180.934356]        bf92963f d8753eb4 c02d0e13 d86dc42b 00000000 
00000000 d85b5000 d8753eb0
[ 1180.934367] Call Trace:
[ 1180.934370]  [<c02d0e13>] schedule_timeout+0xa3/0xb0
[ 1180.934378]  [<c02282be>] read_chan+0x52e/0x620
[ 1180.934385]  [<c0222c1f>] tty_read+0xcf/0xe0
[ 1180.934391]  [<c0160ed8>] vfs_read+0xb8/0x190
[ 1180.934398]  [<c016128b>] sys_read+0x4b/0x80
[ 1180.934404]  [<c0103285>] syscall_call+0x7/0xb
[ 1180.934409] ---------------------------
[ 1180.934413] | preempt count: 00000002 ]
[ 1180.934416] | 2 level deep critical section nesting:
[ 1180.934420] ----------------------------------------
[ 1180.934423] .. [<c02cfc06>] .... schedule+0x46/0x690
[ 1180.934430] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.934437] .. [<c02cfc9a>] .... schedule+0xda/0x690
[ 1180.934443] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.934450]
[ 1180.934453] gconfd-2      S D874C000     0  1488      1          
1509  1423 (NOTLB)
[ 1180.934464] d874df00 dfc58630 c03cf920 d874c000 d874dee0 c0126133 
d874df14 d874df14
[ 1180.934475]        dff80610 00014f32 cb986e53 00000112 dfc58630 
dfc58758 d874df14 000daeac
[ 1180.934486]        d874df5c d874df3c c02d0dc4 d874df14 000daeac 
d85ea500 c03d5ab8 c033995c
[ 1180.934498] Call Trace:
[ 1180.934501]  [<c02d0dc4>] schedule_timeout+0x54/0xb0
[ 1180.934509]  [<c0176ca9>] do_poll+0xa9/0xd0
[ 1180.934515]  [<c0176e3b>] sys_poll+0x16b/0x250
[ 1180.934521]  [<c0103285>] syscall_call+0x7/0xb
[ 1180.934527] ---------------------------
[ 1180.934530] | preempt count: 00000002 ]
[ 1180.934534] | 2 level deep critical section nesting:
[ 1180.934537] ----------------------------------------
[ 1180.934541] .. [<c02cfc06>] .... schedule+0x46/0x690
[ 1180.934548] .....[<c02d0dc4>] ..   ( <= schedule_timeout+0x54/0xb0)
[ 1180.934555] .. [<c02cfc9a>] .... schedule+0xda/0x690
[ 1180.934561] .....[<c02d0dc4>] ..   ( <= schedule_timeout+0x54/0xb0)
[ 1180.934567]
[ 1180.934570] pppd          D 000000AC     0  1509      
1                1488 (NOTLB)
[ 1180.934581] d5eb1df0 c1670c90 c03cfdc8 000000ac df5374a0 dc05b2e0 
68da709f 000000ac
[ 1180.934591]        c1670c90 000054aa 68db22f0 000000ac d6308850 
d6308978 d5eb0000 dffe54b8
[ 1180.934603]        000015d1 d5eb1e64 c012e206 00000001 d5eb1e28 
c0118e7f d859d128 00000001
[ 1180.934614] Call Trace:
[ 1180.934617]  [<c012e206>] flush_cpu_workqueue+0xa6/0x210
[ 1180.934624]  [<c012e380>] flush_workqueue+0x10/0x20
[ 1180.934630]  [<c012e78d>] flush_scheduled_work+0xd/0x10
[ 1180.934637]  [<c0223c18>] release_dev+0x4c8/0x7d0
[ 1180.934644]  [<c0224406>] tty_release+0x16/0x30
[ 1180.934650]  [<c016212a>] __fput+0x1ca/0x1e0
[ 1180.934658]  [<c0161f3a>] fput+0x2a/0x50
[ 1180.934664]  [<c016055b>] filp_close+0x4b/0x80
[ 1180.934670]  [<c016060a>] sys_close+0x7a/0xb0
[ 1180.934676]  [<c0103285>] syscall_call+0x7/0xb
[ 1180.934682] ---------------------------
[ 1180.934685] | preempt count: 00000002 ]
[ 1180.934689] | 2 level deep critical section nesting:
[ 1180.934692] ----------------------------------------
[ 1180.934696] .. [<c02cfc06>] .... schedule+0x46/0x690
[ 1180.934702] .....[<c012e206>] ..   ( <= flush_cpu_workqueue+0xa6/0x210)
[ 1180.934709] .. [<c02cfc9a>] .... schedule+0xda/0x690
[ 1180.934715] .....[<c012e206>] ..   ( <= flush_cpu_workqueue+0xa6/0x210)
[ 1180.934721]
[ 1180.934724] bash          S C1658C50     0  1531   1423          
1536  1439 (NOTLB)
[ 1180.934735] d630be78 d729d9d0 c03cf920 c1658c50 c1658c50 69eadae9 
d630be6c c011829b
[ 1180.934746]        c1658c50 0000044e 69eafc1d 000000ee d729d9d0 
d729daf8 7fffffff d59d200c
[ 1180.934757]        bfb2847f d630beb4 c02d0e13 00000001 c032bfc8 
00000001 d630bea0 c0118db2
[ 1180.934769] Call Trace:
[ 1180.934772]  [<c02d0e13>] schedule_timeout+0xa3/0xb0
[ 1180.934779]  [<c02282be>] read_chan+0x52e/0x620
[ 1180.934786]  [<c0222c1f>] tty_read+0xcf/0xe0
[ 1180.934793]  [<c0160ed8>] vfs_read+0xb8/0x190
[ 1180.934799]  [<c016128b>] sys_read+0x4b/0x80
[ 1180.934805]  [<c0103285>] syscall_call+0x7/0xb
[ 1180.934811] ---------------------------
[ 1180.934814] | preempt count: 00000002 ]
[ 1180.934818] | 2 level deep critical section nesting:
[ 1180.934821] ----------------------------------------
[ 1180.934825] .. [<c02cfc06>] .... schedule+0x46/0x690
[ 1180.934832] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.934839] .. [<c02cfc9a>] .... schedule+0xda/0x690
[ 1180.934845] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.934851]
[ 1180.934854] bash          S 00000001     0  1536   1423          
1544  1531 (NOTLB)
[ 1180.934865] d5271e78 c17107b0 c03cf920 00000001 00000000 00000000 
00200286 00000001
[ 1180.934875]        c167d290 000028fd 96c139ab 00000074 c17107b0 
c17108d8 7fffffff d525d00c
[ 1180.934886]        bf8fdb2f d5271eb4 c02d0e13 d5271ed0 d5271f0c 
d5270000 d5271ea4 c0121dd7
[ 1180.934898] Call Trace:
[ 1180.934901]  [<c02d0e13>] schedule_timeout+0xa3/0xb0
[ 1180.934909]  [<c02282be>] read_chan+0x52e/0x620
[ 1180.934916]  [<c0222c1f>] tty_read+0xcf/0xe0
[ 1180.934922]  [<c0160ed8>] vfs_read+0xb8/0x190
[ 1180.934928]  [<c016128b>] sys_read+0x4b/0x80
[ 1180.934935]  [<c0103285>] syscall_call+0x7/0xb
[ 1180.934940] ---------------------------
[ 1180.934944] | preempt count: 00000002 ]
[ 1180.934947] | 2 level deep critical section nesting:
[ 1180.934950] ----------------------------------------
[ 1180.934954] .. [<c02cfc06>] .... schedule+0x46/0x690
[ 1180.934961] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.934968] .. [<c02cfc9a>] .... schedule+0xda/0x690
[ 1180.934974] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.934981]
[ 1180.934983] bash          S C1658C50     0  1544   
1423                1536 (NOTLB)
[ 1180.934994] d8751e78 d729c830 c03cf920 c1658c50 c1658c50 46d83f2e 
d8751e6c c011829b
[ 1180.935005]        c1658c50 000004aa 46d86386 000000fb d729c830 
d729c958 7fffffff d53b600c
[ 1180.935016]        bfead0cf d8751eb4 c02d0e13 00000001 c032bfc8 
00000001 d8751ea0 c0118db2
[ 1180.935028] Call Trace:
[ 1180.935031]  [<c02d0e13>] schedule_timeout+0xa3/0xb0
[ 1180.935038]  [<c02282be>] read_chan+0x52e/0x620
[ 1180.935045]  [<c0222c1f>] tty_read+0xcf/0xe0
[ 1180.935051]  [<c0160ed8>] vfs_read+0xb8/0x190
[ 1180.935058]  [<c016128b>] sys_read+0x4b/0x80
[ 1180.935064]  [<c0103285>] syscall_call+0x7/0xb
[ 1180.935070] ---------------------------
[ 1180.935073] | preempt count: 00000002 ]
[ 1180.935077] | 2 level deep critical section nesting:
[ 1180.935080] ----------------------------------------
[ 1180.935084] .. [<c02cfc06>] .... schedule+0x46/0x690
[ 1180.935090] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)
[ 1180.935098] .. [<c02cfc9a>] .... schedule+0xda/0x690
[ 1180.935104] .....[<c02d0e13>] ..   ( <= schedule_timeout+0xa3/0xb0)

Note that unlike with the previous kernels, the huge traffic is not 
reported on the ppp0 interface. I think that some patch related to 
zero-size packets is relevant here, but that's just a guess.

-- 
Alexander E. Patrakov
