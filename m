Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWGHFlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWGHFlA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 01:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWGHFlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 01:41:00 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:24990 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932514AbWGHFlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 01:41:00 -0400
Date: Sat, 8 Jul 2006 01:33:30 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: splice/tee bugs?
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: vendor-sec <vendor-sec@lst.de>, Michael Kerrisk <mtk-manpages@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Message-ID: <200607080137_MC3-1-C46B-3D48@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060707131310.0e382585@doriath.conectiva>

On Fri, 7 Jul 2006 13:13:10 -0300, Luiz Fernando N. Capitulino wrote:

> | > c) Occasionally the command line just hangs, producing no output.
> | >    In this case I can't kill it with ^C or ^\.  This is a 
> | >    hard-to-reproduce behaviour on my (x86) system, but I have 
> | >    seen it several times by now.
> | 
> | aka local DoS.  Please capture sysrq-T output next time.
> 
>  If I run lots of them in parallel, I get the following OOPs in a few
> seconds:
> 
> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000018
>  printing eip:
> c01790c7
> *pde = 00000000
> Oops: 0000 [#1]
> Modules linked in: ipv6 capability commoncap snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq via_rhine mii snd_pcm_oss snd_mixer_oss af_packet snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart sn
> CPU:    0
> EIP:    0060:[sys_tee+371/924]    Not tainted VLI
> EIP:    0060:[<c01790c7>]    Not tainted VLI
> EFLAGS: 00010293   (2.6.18-rc1 #8) 
> EIP is at sys_tee+0x173/0x39c
> eax: d62bfa00   ebx: 00000000   ecx: 00000000   edx: d62bfa98
> esi: d7434800   edi: d62bfa98   ebp: d5d5cfb4   esp: d5d5cf84
> ds: 007b   es: 007b   ss: 0068
> Process ktee (pid: 12605, ti=d5d5c000 task=d9cce0b0 task.ti=d5d5c000)
> Stack: d5eede40 00000000 d827ac00 00000002 00000000 d62bfa00 00000000 00000000 
>        00000000 00000000 00000000 b7f72920 d5d5c000 c0102b7d 00000000 00000001 
>        7fffffff 00000000 b7f72920 bf8f37b8 0000013b 0000007b 0000007b 0000013b 
> Call Trace:
>  [<c010422c>] show_stack_log_lvl+0x8c/0x97
>  [<c0104397>] show_registers+0x124/0x191
>  [<c0104550>] die+0x14c/0x269
>  [<c02a6521>] do_page_fault+0x443/0x51e
>  [<c0103d49>] error_code+0x39/0x40
>  [<c0102b7d>] sysenter_past_esp+0x56/0x79
> Code: 00 00 00 89 d0 8b 55 e4 03 42 6c 83 e0 0f 6b c0 14 8d 7c 10 70 8b 46 68 89 45 e0 83 f8 0f 77 5c 8b 4f 0c 8b 5e 6c 89 fa 8b 45 e4 <ff> 51 18 03 5d e0 83 e3 0f 89 fa 6b db 14 b9 14 00 00 00 8d 5c 


ibuf->ops is NULL in the below code (fs/splice.c line 1355 in 2.6.18-rc1)


static int link_pipe(struct pipe_inode_info *ipipe,
                     struct pipe_inode_info *opipe,
                     size_t len, unsigned int flags)
{
        struct pipe_buffer *ibuf, *obuf;
        int ret, do_wakeup, i, ipipe_first;

        ret = do_wakeup = ipipe_first = 0;

        /*
         * Potential ABBA deadlock, work around it by ordering lock
         * grabbing by inode address. Otherwise two different processes
         * could deadlock (one doing tee from A -> B, the other from B -> A).
         */
        if (ipipe->inode < opipe->inode) {
                ipipe_first = 1;
                mutex_lock(&ipipe->inode->i_mutex);
                mutex_lock(&opipe->inode->i_mutex);
        } else {
                mutex_lock(&opipe->inode->i_mutex);
                mutex_lock(&ipipe->inode->i_mutex);
        }

        for (i = 0;; i++) {
                if (!opipe->readers) {
                        send_sig(SIGPIPE, current, 0);
                        if (!ret)
                                ret = -EPIPE;
                        break;
                }
                if (ipipe->nrbufs - i) {
                        ibuf = ipipe->bufs + ((ipipe->curbuf + i) & (PIPE_BUFFERS - 1));

                        /*
                         * If we have room, fill this buffer
                         */
                        if (opipe->nrbufs < PIPE_BUFFERS) {
                                int nbuf = (opipe->curbuf + opipe->nrbufs) & (PIPE_BUFFERS - 1);

                                /*
                                 * Get a reference to this pipe buffer,
                                 * so we can copy the contents over.
                                 */
========>                       ibuf->ops->get(ipipe, ibuf);

                                obuf = opipe->bufs + nbuf;
                                *obuf = *ibuf;

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
