Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267773AbUG3Slb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267773AbUG3Slb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 14:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUG3Slb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 14:41:31 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:6092 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S267773AbUG3SlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 14:41:08 -0400
Date: Fri, 30 Jul 2004 21:40:28 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: Robert Olsson <Robert.Olsson@data.slu.se>
cc: Francois Romieu <romieu@fr.zoreil.com>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <16650.21955.869485.332365@robur.slu.se>
Message-ID: <Pine.LNX.4.44.0407302116010.23238-101000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-360562684-1274709044-1091212828=:23238"
X-Spam-Checked: by miltrassassin
	at posti6.jyu.fi; Fri, 30 Jul 2004 21:40:33 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---360562684-1274709044-1091212828=:23238
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

>> I don't remember if I have said this but when the ksoftirqd has started to 
>> take all the cpu-time there is no way to stop it excluding booting 
>> computer. You can kill or stop all the processes which are taking your 
>> cpu-time (ie. source compiling) but network wont start to work or neither 
>> there is no free cpu-time for use because ksoftirqd won't stop eating it.
>  No you didn't then it seems you are hit by some bug. Have the bug happen.
>  Kill userland processes like as you did. Try find out what's running. I would 
>  look in /proc/interrupt /proc/net/softnet_stat /proc/net/dev or maybe best to 
>  take a profile if possible or Magic SysRq to find out what's looping. Also try
>  ifconfig down.

Ok, now I know how to go back in the normal state of kernel operation. I 
just have to do "ifconfig eth0 down" and ksoftirqd stop taking all the 
cpu-time, after that I can do "ifconfig eth0 up" and everything is working 
fine.

So I guess it is 8139too-driver which has a bug.

First "SysRq : Show Regs" when the kernel is ok:

--
Pid: 0, comm:              swapper
EIP: 0060:[<c0101ed3>] CPU: 0
EIP is at default_idle+0x23/0x30
 EFLAGS: 00000246    Not tainted  (2.6.7-mm7)
EAX: 00000000 EBX: c03cc000 ECX: 00000000 EDX: 0006a546
ESI: 00099100 EDI: c0427120 EBP: 0046e007 DS: 007b ES: 007b
CR0: 8005003b CR2: 08101000 CR3: 1e9b7000 CR4: 000006d0
 [<c0101f3c>] cpu_idle+0x2c/0x40
 [<c03ce832>] start_kernel+0x162/0x180
 [<c03ce460>] unknown_bootoption+0x0/0x160
--

Second "SysRq : Show Regs" when the ksoftirqd has started to take all the 
cpu-time:

--
Pid: 2, comm:          ksoftirqd/0
EIP: 0060:[<e0871224>] CPU: 0
EIP is at rtl8139_poll+0xb4/0x100 [8139too]
 EFLAGS: 00000247    Not tainted  (2.6.7-mm7)
EAX: ffffe000 EBX: 00000040 ECX: dfa654f8 EDX: c0441978
ESI: dfa65400 EDI: e0868000 EBP: dff85f84 DS: 007b ES: 007b
CR0: 8005003b CR2: 080e9024 CR3: 1e9b7000 CR4: 000006d0
 [<c01194b0>] ksoftirqd+0x0/0xc0
 [<c02c5e3a>] net_rx_action+0x6a/0x110
 [<c011917d>] __do_softirq+0x7d/0x80
 [<c01191a6>] do_softirq+0x26/0x30
 [<c0119518>] ksoftirqd+0x68/0xc0
 [<c01276e5>] kthread+0xa5/0xb0
 [<c0127640>] kthread+0x0/0xb0
 [<c0102111>] kernel_thread_helper+0x5/0x14
--

Third one after I have done ifconfig eth0 down/up.

--
Pid: 0, comm:              swapper
EIP: 0060:[<c0101ed3>] CPU: 0
EIP is at default_idle+0x23/0x30
 EFLAGS: 00000246    Not tainted  (2.6.7-mm7)
EAX: 00000000 EBX: c03cc000 ECX: 00000000 EDX: 000cf65e
ESI: 00099100 EDI: c0427120 EBP: 0046e007 DS: 007b ES: 007b
CR0: 8005003b CR2: b7c5a000 CR3: 1e9b7000 CR4: 000006d0
 [<c0101f3c>] cpu_idle+0x2c/0x40
 [<c03ce832>] start_kernel+0x162/0x180
 [<c03ce460>] unknown_bootoption+0x0/0x160
--

I also compiled 8139too-driver with debub-options on and the logfile is 
included as attachment. 

Everything is going ok until end of the 20:41:29, then it happens:

--
20:41:29  kernel: rtl8139_rx: eth0: In rtl8139_rx(), current 004c BufAddr 
0c80, free to 003c, Cmd 0c.
20:41:29  kernel: rtl8139_interrupt: eth0: exiting interrupt, intr_status=0x0001.
20:41:29  kernel: rtl8139_rx: eth0: In rtl8139_rx(), current 11bc BufAddr 
22e0, free to 11ac, Cmd 0c.
20:41:29  kernel: rtl8139_interrupt: eth0: exiting interrupt, intr_status=0x0000.
20:41:29  last message repeated 4 times
20:41:29  kernel: rtl8139_rx: eth0: In rtl8139_rx(), current 2438 BufAddr 
242c, free to 2428, Cmd 0d.
20:41:29  kernel: rtl8139_interrupt: eth0: exiting interrupt, intr_status=0x0010.
20:41:29  kernel: rtl8139_rx: eth0: In rtl8139_rx(), current 2438 BufAddr 
242c, free to 2428, Cmd 0d.
20:41:29  kernel: rtl8139_interrupt: eth0: exiting interrupt, intr_status=0x0010.
20:41:29  kernel: rtl8139_rx: eth0: In rtl8139_rx(), current 2438 BufAddr 
242c, free to 2428, Cmd 0d.
20:41:29  kernel: rtl8139_interrupt: eth0: exiting interrupt, intr_status=0x0010.
20:41:29  kernel: rtl8139_rx: eth0: In rtl8139_rx(), current 2438 BufAddr 
242c, free to 2428, Cmd 0d.
--

The hardest part is to tell where the problem is but I think that 
rtl8139_poll-function would be good place to start looking for the bug?

readprofile didn't tell much.. Where to go next? I'm not so good 
programmer that I could find the right place to fix..

--
Pasi Sjöholm

---360562684-1274709044-1091212828=:23238
Content-Type: APPLICATION/x-gzip; name="rtl8139-debug.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0407302140280.23238@silmu.st.jyu.fi>
Content-Description: 
Content-Disposition: attachment; filename="rtl8139-debug.gz"

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
dq+647ONny7MEKY+3qU+dRvOEN4g78PN59Oq/8/Uu/n8FzGL+fwQK6un3foE
5RKLIdRqT8MqTx/2qtU+29tiiDOER+w2MA17zRCyiMWMWu7oSXGu9Hzuderp
Q3/J53Ausa3iHklKx+6R9Hl+M+cghbvS4q5Aqo6qPvzzb1Hc+wzfojs3Nzc3
Nzc3Nzc3Nzc3N3e+7t1Wxc664vT+tbfz3iqxXsOq4umBTdewMlxbrsN51VTH
irZUq2h7GbFQz5aaeE421RvWs33b3YSzqqmJtWepObb2LNdPugmVZ6mNJ1pT
s2Hl2bfdbThVmtpYJZbao+6H2GrsZLr/PYd9+Qy6eJo1tRtWnWW4w9aFM6qp
j/ll6o6tOct17PQxs+1jZpu6z9nv/fMcP973sd/O97l+s1K47ePr7CLjW22/
ZOTxZo79MvJzfdJVuJfj6z58UfdyZDyHyfUX5qA5TIZjZ53jx54Bm+b4Jx47
begY8GV20WTcMeBLRh7vnjsuI/+t/Dnc/5a62NUpdXvd//Z6hNaZjtAudvPs
Y9aYuqN6On3K+zKHjDzTvyh33zd3f28GXa16n35QBn1QbEN3sS85eXVUd7EM
cu06duUoLdeuQ6+N1NSrWceGvTaK+O1oQgfXr/OYDTu4ZhiJ9fykS6eZn3Rx
1+a62rVpfTu+uSMW535TWu2IFfXt+PHwS6fw6rbajRnPtDf43UhUVegiU11S
WA+oqg27yOQ3JuaHD5Howm9HNTw/7ERSpqtqc9iXPubNJX4Gl9Yu6b8jNgcp
RCx2Lq2bId/f+bq9hS7tfRU71rfXM33bvhuJZnqEPs6XKoz5ZrofOuZzrb09
aPXtvStbU+xVn/XKVhVXMerV3L3achXjLbvSv/UuapZ3Ud3GGXn9szvPNme/
q//Mgbi5ubm5ubm5ubm5ubm5S3E3aQ/3q//CzZ2PW4S4ubm5ubm5ubm5ubm5
ubm5uct0ixA3Nzc3Nzc3Nzc3Nzc3Nzc3d5luEeLm5ubm5ubm5ubm5ubm5ubm
LtP9f/9Td9IIcXNzc3Nzc3Nzc3Nzc3Nzc3NzWxnj5ubm5ubm5ubm5ubm5ubm
5i7ZLULc3Nzc3Nzc3Nzc3Nzc3Nzc3GW6RYibm5ubm5ubm5ubm5ubm5ubu0y3
CHFzc3Nzc3Nzc3Nzc3Nzc3Nzl+kWIW5ubm5ubm5ubm5ubm5ubm7uMt0ixM3N
zc3Nzc3Nzc3Nzc3Nzc1dpluEuLm5ubm5ubm5ubm5ubm5ubnLdIsQNzc3Nzc3
Nzc3Nzc3Nzc3N3eZbhHi5ubm5ubm5ubm5ubm5ubm5i7TLULc3Nzc3Nzc3Nzc
3Nzc3Nzc3GW6RYibm5ubm5ubm5ubm5ubm5ubu0y3CHFzc3Nzc3Nzc3Nzc3Nz
c3Nzl+kWIW5ubm5ubm5ubm5ubm5ubm7uMt0ixM3Nzc3Nzc3Nzc3Nzc3Nzc1d
pluEuLm5ubm5ubm5ubm5ubm5ubnLdIsQNzc3Nzc3Nzc3Nzc3Nzc3N3eZbhHi
5uYuy93+lS7vdb/+i9zcp3UX9Kjc3Nzc3Nzc3Nzc3Nzc3Nzc3Nxv3DT7/Ahx
c3Nzc3Nzc3Nzc3Nzc3Nzc3+mW4S4ubm5ubm5ubm5ubm5ubm5uct0ixA3Nzc3
Nzc3Nzc3Nzc3Nzc3d5luEeLm5ubm5ubm5ubm5ubm5ubmLtMtQtzc3Nzc3Nzc
3Nzc3Nzc3NzcZbpFiJubm5ubm5ubm5ubm5ubm5u7TLcIcXNzc3Nzc3Nzc3Nz
c3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nz
c3Nzc3Nzc3Nzc3Nzc3Nzc3N/pvtv0llo08WjBAA=
---360562684-1274709044-1091212828=:23238--
