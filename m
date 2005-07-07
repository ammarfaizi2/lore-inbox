Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVGGLVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVGGLVp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 07:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVGGLVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:21:45 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:59584 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261168AbVGGLVn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:21:43 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Thu, 7 Jul 2005 12:21:47 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050706204429.GA1159@elte.hu> <200507071046.41938.s0348365@sms.ed.ac.uk>
In-Reply-To: <200507071046.41938.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507071221.47946.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 Jul 2005 10:46, Alistair John Strachan wrote:
[snip]
>
> Okay, when I brought my laptop back into work today for audio work, it
> locked up again within two minutes. I realise now what the problem is, but
> I don't have a serial cable here, so I'll have to rely on capturing the
> oops from the console.
>
> The only difference between work and home is that I connect over an OpenVPN
> connection at work, which is a userspace program that creates a "tun"
> device as a virtual network adaptor.
>
> I'm convinced this is the problem, because I enabled IPMASQ on the company
> server today and bypassed the VPN, and I'm happily typing this email from
> the same computer on the same network, just with no VPN started.
>
> It's a bizarre problem, but my guess is that your user test bed don't end
> up using tap/tun very often, which means it's poorly tested.

Okay, I've managed to figure out a reproducible test for this problem. Bring 
up a normal network interface, in my case wlan (my ipw2200 wireless). Start 
an openvpn session to any nearby host.

Without X loaded, running in multi-user text mode, I switched VTs to the 
second VT and started;

sleep 10; wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.0.tar.bz2

Then I switched back to the primary VT and waited. About 15 seconds later, I 
get:

 =======================
 =======================
 =======================
 =======================
 =======================
 =======================
 =======================
 =======================
[...]

Filling my screen up, page after page. Then eventually the kernel freezes and 
I get no more output. Now, I scanned through your realtime-preempt patch and 
only found a single place where this occurs; a small hunk in 
linux/arch/i386/kernel/traps.c show_trace().

        while (1) {
                struct thread_info *context;
                context = (struct thread_info *)
                        ((unsigned long)stack & (~(THREAD_SIZE - 1)));
                ebp = print_context_stack(context, stack, ebp);
                stack = (unsigned long*)context->previous_esp;
                if (!stack)
                        break;
                printk(" =======================\n");
        }

Something's been corrupted so badly that "stack" is always true; presumably it 
never reaches the bottom stack, and printk()s forever. That, or show_trace() 
is being called from multiple contexts.

Unfortunately, since this is called when the kernel crashes, it's impossible 
for me to capture any messages prior to this spam, if there even are any.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
