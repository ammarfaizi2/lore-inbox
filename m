Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVAWGoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVAWGoF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 01:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVAWGoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 01:44:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:60324 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261235AbVAWGn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 01:43:58 -0500
Date: Sat, 22 Jan 2005 22:43:50 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: ierdnah <ierdnah@go.ro>, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel oops!
In-Reply-To: <1106437010.32072.0.camel@ierdnac>
Message-ID: <Pine.LNX.4.58.0501222223090.4191@ppc970.osdl.org>
References: <1106437010.32072.0.camel@ierdnac>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Interesting. That last call trace entry is the call in 
pty_chars_in_buffer() to

        /* The ldisc must report 0 if no characters available to be read */
        count = to->ldisc.chars_in_buffer(to);

and it looks like it has jumped to address zero.

However, we _just_ compared the fn pointer to zero immediately before, and 
while there could certainly have been a race that cleared it in between 
the test and the call, normally we wouldn't even have re-loaded the value 
at all, but kept it in a register instead.

That said, it does act like a race. Somebody clearing the ldisc and racing 
with somebody using it?

Can you do a 

	gdb vmlinux

	disassemble pty_chars_in_buffer

to show what it looks like (whether it reloads the value, and what the 
registers are - it looks like either %eax or %edi is all zeroes, but I'd 
like to verify that it matches your code generation).

Alan? Any ideas? The tty_select() path seems to take a ldisc reference, 
but does that guarantee that the ldisc won't _change_? What happens if the 
line discipline is reset from ppp to regular (or set to ppp) 
asymchronously? You've been deep in this area lately..

			Linus

On Sun, 23 Jan 2005, ierdnah wrote:
> 
> Jan 22 13:27:59 warsheep Unable to handle kernel NULL pointer dereference at virtual address 00000000
> Jan 22 13:27:59 warsheep printing eip:
> Jan 22 13:27:59 warsheep 00000000
> Jan 22 13:27:59 warsheep *pgd = cde9ddb400000000
> Jan 22 13:27:59 warsheep *pmd = cde9ddb400000000
> Jan 22 13:27:59 warsheep Oops: 0000 [#1]
> Jan 22 13:27:59 warsheep SMP
> Jan 22 13:27:59 warsheep CPU:    0
> Jan 22 13:27:59 warsheep EIP:    0060:[<00000000>]    Not tainted VLI
> Jan 22 13:27:59 warsheep EFLAGS: 00010282   (2.6.10-hardened-r2-warsheep62)
> Jan 22 13:27:59 warsheep EIP is at 0x0
> Jan 22 13:27:59 warsheep eax: 00000000   ebx: de455000   ecx: c02c60e0   edx: c6b41000
> Jan 22 13:27:59 warsheep esi: de455000   edi: 00000000   ebp: dd0a2680   esp: cde9de9c
> Jan 22 13:27:59 warsheep ds: 007b   es: 007b   ss: 0068
> Jan 22 13:27:59 warsheep Process pptpctrl (pid: 16689, threadinfo=cde9c000 task=d112ca20)
> Jan 22 13:27:59 warsheep Stack: c02c97bc c6b41000 00000000 c02c895c de455000 04949168 c03d0106 de455000
> Jan 22 13:27:59 warsheep de45500c dd0a2680 00000000 c02c4141 de455000 dd0a2680 00000000 c01c7d49
> Jan 22 13:27:59 warsheep dd0a2680 00000020 00000005 00000005 c01da72f dd0a2680 00000000 00000000
> Jan 22 13:27:59 warsheep Call Trace:
> Jan 22 13:27:59 warsheep [<c02c97bc>] pty_chars_in_buffer+0x2c/0x50
> Jan 22 13:27:59 warsheep [<c02c895c>] normal_poll+0xfc/0x16b
> Jan 22 13:27:59 warsheep [<c03d0106>] schedule_timeout+0x76/0xc0
> Jan 22 13:27:59 warsheep [<c02c4141>] tty_poll+0xa1/0xc0
> Jan 22 13:27:59 warsheep [<c01c7d49>] fget+0x49/0x60
> Jan 22 13:27:59 warsheep [<c01da72f>] do_select+0x26f/0x2e0
> Jan 22 13:27:59 warsheep [<c01da2f0>] __pollwait+0x0/0xd0
> Jan 22 13:27:59 warsheep [<c01daabb>] sys_select+0x2db/0x4f0
> Jan 22 13:27:59 warsheep [<c0173049>] sysenter_past_esp+0x52/0x79
> Jan 22 13:27:59 warsheep Code:  Bad EIP value.
> 
> The oops ocures only when the kernel is build with SMP and HT support, in UP mode the oops doesn't occur!
> I have a 2.6.10 kernel with SMP and HT compiled kernel, I have a P4 3GHz with HT
> a have a VPN server with pppd and pptpd(poptop) and and average of 130
> simultanious connections, the oops doesn't occur at a particular number
> of simulationus VPN connection.I can build a kernel with debugging enabled or something to help to track th
> source of the problem. Please CC as I am not subscribed to this mailing list.
> 
> -- 
> ierdnah <ierdnah@go.ro>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
