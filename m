Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVFJILO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVFJILO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 04:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVFJILO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 04:11:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:48021 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262515AbVFJIKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 04:10:36 -0400
Date: Fri, 10 Jun 2005 10:10:32 +0200 (MEST)
From: "Manfred Schwarb" <manfred99@gmx.ch>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, netdev@oss.sgi.com,
       herbert@gondor.apana.org.au
MIME-Version: 1.0
References: <20050609150026.GA7900@logos.cnet>
Subject: Re: 2.4.30-hf1 do_IRQ stack overflows
X-Priority: 3 (Normal)
X-Authenticated: #17170890
Message-ID: <8387.1118391032@www33.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi, 
> 
> On Tue, Jun 07, 2005 at 02:38:01PM +0200, Manfred Schwarb wrote:
> > 
> > 
> > > 
> > > Hi Manfred,
> > > 
> > > On Wed, May 11, 2005 at 10:15:02AM +0200, Manfred Schwarb wrote:
> > > > Hi,
> > > > with recent versions of the 2.4 kernel (Vanilla), I get an
> increasing
> > > amount of do_IRQ stack overflows.
> > > > This night, I got 3 of them.
> > > > With 2.4.28 I got an overflow about twice a year, with 2.4.29 nearly
> > > once a month and with
> > > > 2.4.30 nearly every day 8-((
> > > 
> > > The system is getting dangerously close to an actual stack overflow,
> which
> > > would 
> > > crash the system. 
> > > 
> > > "do_IRQ: stack overflow: " indicates how many bytes are still
> available. 
> > > 
> > > The traces show huge networking execution paths.
> > > 
> > > It seems you are using some packet scheduler (CONFIG_NET_SCHED)?
> Pretty
> > > much all 
> > > traces show functions from sch_generic.c. Can you disable that for a
> test?
> > > 
> > 
> > Sorry to bother you again, but the problem didn't vanish completely.
> > This morning, I caught another one. I built a new kernel with 
> > CONFIG_NET_SCHED=n as suggested, uptime is now 25 days, and the
> following
> > is the first do_IRQ since then (ksymoops -i):
> > 
> > Jun  7 03:55:01 tp-meteodat7 kernel: f3238830 00000280 f49e7b80 00000000
<---------snip-------->
> > [<c01594d4>] [<c01598d9>] [<c0159bb4>] [<c0158905>]
> > Warning (Oops_read): Code line not seen, dumping what data is available
> 
> Do you have the "do_IRQ stack overflow" output and the amount of bytes
> left it informs? 
> 

Yes, it was a close one, 640. I append the original output to the end of
this email. Thanks for looking at this.


> > Trace; c010d948 <call_do_IRQ+5/d>
> > Trace; c023a039 <skb_copy_and_csum_dev+49/100>
<---------snip-------->
> > Trace; c010d948 <call_do_IRQ+5/d>
> 
> I dont see any huge stack consumers on this callchain.
> 
> David, Herbert, any clues what might be going on here? 
> 
> 



Jun  7 03:55:01 tp-meteodat7 kernel: do_IRQ: stack overflow: 640
Jun  7 03:55:01 tp-meteodat7 kernel: f3238830 00000280 f49e7b80 00000000
00000042 cca1388e f4116980 f17aa000
Jun  7 03:55:01 tp-meteodat7 kernel:        c010d948 00000042 f4116980
00000000 cca1388e f4116980 f17aa000 00000042
Jun  7 03:55:01 tp-meteodat7 kernel:        00000018 f61d0018 ffffff14
c023a039 00000010 00000246 ee5ea480 00000000
Jun  7 03:55:01 tp-meteodat7 kernel: Call Trace:    [call_do_IRQ+5/13]
[skb_copy_and_csum_dev+73/256]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4256445916/96]
[qdisc_restart+114/432] [dev_queue_xmit+383/880]
Jun  7 03:55:01 tp-meteodat7 kernel: Call Trace:    [<c010d948>]
[<c023a039>] [<f90df5dc>] [<c0248402>] [<c023cc7f>]
Jun  7 03:55:01 tp-meteodat7 kernel:   [ip_finish_output2+184/336]
[ip_finish_output2+0/336] [ip_finish_output2+0/336] [nf_hook_slow+478/528]
[ip_finish_output2+0/336] [ip_output+334/480]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<c02561a8>] [<c02560f0>]
[<c02560f0>] [<c024760e>] [<c02560f0>] [<c025492e>]
Jun  7 03:55:01 tp-meteodat7 kernel:   [ip_finish_output2+0/336]
[ip_queue_xmit2+213/671] [ip_queue_xmit2+0/671] [ip_queue_xmit2+0/671]
[nf_hook_slow+478/528] [ip_queue_xmit2+0/671]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<c02560f0>] [<c0256315>]
[<c0256240>] [<c0256240>] [<c024760e>] [<c0256240>]
Jun  7 03:55:01 tp-meteodat7 kernel:   [ip_queue_xmit+845/1536]
[ip_queue_xmit2+0/671] [tcp_v4_send_check+160/240]
[tcp_transmit_skb+1001/1792] [tcp_send_ack+132/208] [tcp_rfree+0/32]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<c0254d0d>] [<c0256240>]
[<c026daf0>] [<c0267c99>] [<c026a6f4>] [<c0259370>]
Jun  7 03:55:01 tp-meteodat7 kernel:   [tcp_rfree+0/32]
[tcp_rcv_established+2042/2640] [tcp_v4_do_rcv+314/352]
[tcp_v4_rcv+1726/1952] [ip_local_deliver_finish+351/416]
[ip_local_deliver_finish+0/416]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<c0259370>] [<c02661ca>]
[<c026edaa>] [<c026f48e>] [<c025174f>] [<c02515f0>]
Jun  7 03:55:01 tp-meteodat7 kernel:   [nf_hook_slow+478/528]
[ip_local_deliver_finish+0/416] [ip_rcv_finish+0/616]
[ip_local_deliver+399/576] [ip_local_deliver_finish+0/416]
[ip_rcv_finish+0/616]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<c024760e>] [<c02515f0>]
[<c0251790>] [<c02510df>] [<c02515f0>] [<c0251790>]
Jun  7 03:55:01 tp-meteodat7 kernel:   [ip_rcv_finish+473/616]
[ip_rcv_finish+0/616] [nf_hook_slow+478/528] [ip_rcv_finish+0/616]
[ip_rcv+808/1120] [ip_rcv_finish+0/616]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<c0251969>] [<c0251790>]
[<c024760e>] [<c0251790>] [<c02514b8>] [<c0251790>]
Jun  7 03:55:01 tp-meteodat7 kernel:   [netif_receive_skb+485/544]
[process_backlog+147/304] [net_rx_action+250/368] [do_softirq+118/224]
[do_IRQ+244/304] [call_do_IRQ+5/13]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<c023d4d5>] [<c023d5a3>]
[<c023d73a>] [<c01254c6>] [<c010b094>] [<c010d948>]
Jun  7 03:55:01 tp-meteodat7 kernel:   [set_ldt_desc+5/59]
[schedule+650/1344] [schedule_timeout+84/160] [process_timeout+0/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4256523927/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4256524281/96]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<c010a625>] [<c011ce8a>]
[<c011cb14>] [<c011ca60>] [<f90f2697>] [<f90f27f9>]
Jun  7 03:55:01 tp-meteodat7 kernel:  
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4256524459/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4256530630/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4256904584/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4256908606/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4256911957/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4250526660/96]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<f90f28ab>] [<f90f40c6>]
[<f914f588>] [<f915053e>] [<f9151255>] [<f8b3a3c4>]
Jun  7 03:55:01 tp-meteodat7 kernel:  
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4250598640/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4250526660/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4250605583/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4250526660/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4250526660/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4250602612/96]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<f8b4bcf0>] [<f8b3a3c4>]
[<f8b4d80f>] [<f8b3a3c4>] [<f8b3a3c4>] [<f8b4cc74>]
Jun  7 03:55:01 tp-meteodat7 kernel:  
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4250526660/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4250525224/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4250568899/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4250613955/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4250576507/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4250526472/96]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<f8b3a3c4>] [<f8b39e28>]
[<f8b448c3>] [<f8b4f8c3>] [<f8b4667b>] [<f8b3a308>]
Jun  7 03:55:01 tp-meteodat7 kernel:  
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4250576301/96]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4250628604/96]
[__kfree_skb+246/336]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4256445940/96]
[qdisc_restart+31/432] [dev_queue_xmit+383/880]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<f8b465ad>] [<f8b531fc>]
[<c02387b6>] [<f90df5f4>] [<c02483af>] [<c023cc7f>]
Jun  7 03:55:01 tp-meteodat7 kernel:   [ip_finish_output2+184/336]
[__kfree_skb+246/336]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4256445940/96]
[__kfree_skb+246/336]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4256445940/96]
[qdisc_restart+31/432]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<c02561a8>] [<c02387b6>]
[<f90df5f4>] [<c02387b6>] [<f90df5f4>] [<c02483af>]
Jun  7 03:55:01 tp-meteodat7 kernel:   [dev_queue_xmit+383/880]
[__kfree_skb+246/336]
[nfsd:__insmod_nfsd_O/lib/modules/2.4.30-hf1/kernel/fs/nfsd/nfsd.+4256445940/96]
[qdisc_restart+31/432] [dev_queue_xmit+383/880] [ip_finish_output2+184/336]
Jun  7 03:55:01 tp-meteodat7 kernel:   [ip_finish_output2+0/336]
[ip_finish_output2+0/336] [nf_hook_slow+478/528] [ip_finish_output2+0/336]
[ip_output+334/480] [ip_finish_output2+0/336]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<c02560f0>] [<c02560f0>]
[<c024760e>] [<c02560f0>] [<c025492e>] [<c02560f0>]
Jun  7 03:55:01 tp-meteodat7 kernel:   [ip_queue_xmit2+213/671]
[sock_def_readable+99/128] [tcp_rfree+0/32] [tcp_rfree+0/32]
[tcp_rcv_established+1981/2640] [tcp_v4_do_rcv+314/352]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<c0256315>] [<c0237f63>]
[<c0259370>] [<c0259370>] [<c026618d>] [<c026edaa>]
Jun  7 03:55:01 tp-meteodat7 kernel:   [tcp_v4_rcv+1726/1952]
[ip_local_deliver_finish+351/416] [ip_local_deliver_finish+0/416]
[nf_hook_slow+478/528] [ip_local_deliver_finish+0/416] [ip_rcv_finish+0/616]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<c026f48e>] [<c025174f>]
[<c02515f0>] [<c024760e>] [<c02515f0>] [<c0251790>]
Jun  7 03:55:01 tp-meteodat7 kernel:   [ip_local_deliver+399/576]
[ip_local_deliver_finish+0/416] [ip_rcv_finish+0/616]
[ip_rcv_finish+473/616] [ip_rcv_finish+0/616] [nf_hook_slow+478/528]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<c02510df>] [<c02515f0>]
[<c0251790>] [<c0251969>] [<c0251790>] [<c024760e>]
Jun  7 03:55:01 tp-meteodat7 kernel:   [ip_rcv_finish+0/616]
[__alloc_pages+100/640] [poll_freewait+68/80] [do_select+569/592]
[sys_select+660/1248] [sys_ioctl+677/785]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<c0251790>] [<c013e624>]
[<c01594d4>] [<c01598d9>] [<c0159bb4>] [<c0158905>]
Jun  7 03:55:01 tp-meteodat7 kernel:   [sys_time+21/80] [system_call+51/56]
Jun  7 03:55:01 tp-meteodat7 kernel:   [<c0124bb5>] [<c0108fa7>]



In my previous posting, I snipped /var/log/messages at the wrong place, 
and zapped the last line. This line results in two additional 
lines of the ksymoops output:
Trace; c0124bb5 <sys_time+15/50>
Trace; c0108fa7 <system_call+33/38>



-- 
Geschenkt: 3 Monate GMX ProMail gratis + 3 Ausgaben stern gratis
++ Jetzt anmelden & testen ++ http://www.gmx.net/de/go/promail ++
