Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVAWM26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVAWM26 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 07:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVAWM26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 07:28:58 -0500
Received: from s2.home.ro ([193.231.236.41]:63693 "EHLO s2.home.ro")
	by vger.kernel.org with ESMTP id S261298AbVAWM2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 07:28:51 -0500
Subject: Re: kernel oops!
From: ierdnah <ierdnah@go.ro>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501222223090.4191@ppc970.osdl.org>
References: <1106437010.32072.0.camel@ierdnac>
	 <Pine.LNX.4.58.0501222223090.4191@ppc970.osdl.org>
Content-Type: text/plain
Date: Sun, 23 Jan 2005 14:29:00 +0200
Message-Id: <1106483340.21951.4.camel@ierdnac>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(gdb) disassemble pty_chars_in_buffer
Dump of assembler code for function pty_chars_in_buffer:
0xc02c9790 <pty_chars_in_buffer+0>:     sub    $0x8,%esp
0xc02c9793 <pty_chars_in_buffer+3>:     xor    %eax,%eax
0xc02c9795 <pty_chars_in_buffer+5>:     mov    %ebx,0x4(%esp,1)
0xc02c9799 <pty_chars_in_buffer+9>:     mov    0xc(%esp,1),%ebx
0xc02c979d <pty_chars_in_buffer+13>:    mov    0xd0(%ebx),%edx
0xc02c97a3 <pty_chars_in_buffer+19>:    test   %edx,%edx
0xc02c97a5 <pty_chars_in_buffer+21>:    je     0xc02c97ae
<pty_chars_in_buffer+30>
0xc02c97a7 <pty_chars_in_buffer+23>:    mov    0x28(%edx),%ecx
0xc02c97aa <pty_chars_in_buffer+26>:    test   %ecx,%ecx
0xc02c97ac <pty_chars_in_buffer+28>:    jne    0xc02c97b6
<pty_chars_in_buffer+38>
0xc02c97ae <pty_chars_in_buffer+30>:    mov    0x4(%esp,1),%ebx
0xc02c97b2 <pty_chars_in_buffer+34>:    add    $0x8,%esp
0xc02c97b5 <pty_chars_in_buffer+37>:    ret
0xc02c97b6 <pty_chars_in_buffer+38>:    mov    %edx,(%esp,1)
0xc02c97b9 <pty_chars_in_buffer+41>:    call   *0x28(%edx)
0xc02c97bc <pty_chars_in_buffer+44>:    mov    %eax,%edx
0xc02c97be <pty_chars_in_buffer+46>:    mov    0x4(%ebx),%eax
0xc02c97c1 <pty_chars_in_buffer+49>:    cmpw   $0x2,0x76(%eax)
0xc02c97c6 <pty_chars_in_buffer+54>:    je     0xc02c97d5
<pty_chars_in_buffer+69>
0xc02c97c8 <pty_chars_in_buffer+56>:    xor    %eax,%eax
0xc02c97ca <pty_chars_in_buffer+58>:    cmp    $0x800,%edx
0xc02c97d0 <pty_chars_in_buffer+64>:    cmovge %edx,%eax
0xc02c97d3 <pty_chars_in_buffer+67>:    jmp    0xc02c97ae
<pty_chars_in_buffer+30>
0xc02c97d5 <pty_chars_in_buffer+69>:    mov    %edx,%eax
0xc02c97d7 <pty_chars_in_buffer+71>:    jmp    0xc02c97ae
<pty_chars_in_buffer+30>
0xc02c97d9 <pty_chars_in_buffer+73>:    lea    0x0(%esi,1),%esi
End of assembler dump.

this is another compiled kernel, but is compiled with the same .config
file and same gcc version...because I only have the bzImage, how do I
convert it to vmlinux?

On Sat, 2005-01-22 at 22:43 -0800, Linus Torvalds wrote:
> Interesting. That last call trace entry is the call in 
> pty_chars_in_buffer() to
> 
>         /* The ldisc must report 0 if no characters available to be read */
>         count = to->ldisc.chars_in_buffer(to);
> 
> and it looks like it has jumped to address zero.
> 
> However, we _just_ compared the fn pointer to zero immediately before, and 
> while there could certainly have been a race that cleared it in between 
> the test and the call, normally we wouldn't even have re-loaded the value 
> at all, but kept it in a register instead.
> 
> That said, it does act like a race. Somebody clearing the ldisc and racing 
> with somebody using it?
> 
> Can you do a 
> 
> 	gdb vmlinux
> 
> 	disassemble pty_chars_in_buffer
> 
> to show what it looks like (whether it reloads the value, and what the 
> registers are - it looks like either %eax or %edi is all zeroes, but I'd 
> like to verify that it matches your code generation).
> 
> Alan? Any ideas? The tty_select() path seems to take a ldisc reference, 
> but does that guarantee that the ldisc won't _change_? What happens if the 
> line discipline is reset from ppp to regular (or set to ppp) 
> asymchronously? You've been deep in this area lately..
> 
> 			Linus
> 
> On Sun, 23 Jan 2005, ierdnah wrote:
> > 
> > Jan 22 13:27:59 warsheep Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > Jan 22 13:27:59 warsheep printing eip:
> > Jan 22 13:27:59 warsheep 00000000
> > Jan 22 13:27:59 warsheep *pgd = cde9ddb400000000
> > Jan 22 13:27:59 warsheep *pmd = cde9ddb400000000
> > Jan 22 13:27:59 warsheep Oops: 0000 [#1]
> > Jan 22 13:27:59 warsheep SMP
> > Jan 22 13:27:59 warsheep CPU:    0
> > Jan 22 13:27:59 warsheep EIP:    0060:[<00000000>]    Not tainted VLI
> > Jan 22 13:27:59 warsheep EFLAGS: 00010282   (2.6.10-hardened-r2-warsheep62)
> > Jan 22 13:27:59 warsheep EIP is at 0x0
> > Jan 22 13:27:59 warsheep eax: 00000000   ebx: de455000   ecx: c02c60e0   edx: c6b41000
> > Jan 22 13:27:59 warsheep esi: de455000   edi: 00000000   ebp: dd0a2680   esp: cde9de9c
> > Jan 22 13:27:59 warsheep ds: 007b   es: 007b   ss: 0068
> > Jan 22 13:27:59 warsheep Process pptpctrl (pid: 16689, threadinfo=cde9c000 task=d112ca20)
> > Jan 22 13:27:59 warsheep Stack: c02c97bc c6b41000 00000000 c02c895c de455000 04949168 c03d0106 de455000
> > Jan 22 13:27:59 warsheep de45500c dd0a2680 00000000 c02c4141 de455000 dd0a2680 00000000 c01c7d49
> > Jan 22 13:27:59 warsheep dd0a2680 00000020 00000005 00000005 c01da72f dd0a2680 00000000 00000000
> > Jan 22 13:27:59 warsheep Call Trace:
> > Jan 22 13:27:59 warsheep [<c02c97bc>] pty_chars_in_buffer+0x2c/0x50
> > Jan 22 13:27:59 warsheep [<c02c895c>] normal_poll+0xfc/0x16b
> > Jan 22 13:27:59 warsheep [<c03d0106>] schedule_timeout+0x76/0xc0
> > Jan 22 13:27:59 warsheep [<c02c4141>] tty_poll+0xa1/0xc0
> > Jan 22 13:27:59 warsheep [<c01c7d49>] fget+0x49/0x60
> > Jan 22 13:27:59 warsheep [<c01da72f>] do_select+0x26f/0x2e0
> > Jan 22 13:27:59 warsheep [<c01da2f0>] __pollwait+0x0/0xd0
> > Jan 22 13:27:59 warsheep [<c01daabb>] sys_select+0x2db/0x4f0
> > Jan 22 13:27:59 warsheep [<c0173049>] sysenter_past_esp+0x52/0x79
> > Jan 22 13:27:59 warsheep Code:  Bad EIP value.
> > 
> > The oops ocures only when the kernel is build with SMP and HT support, in UP mode the oops doesn't occur!
> > I have a 2.6.10 kernel with SMP and HT compiled kernel, I have a P4 3GHz with HT
> > a have a VPN server with pppd and pptpd(poptop) and and average of 130
> > simultanious connections, the oops doesn't occur at a particular number
> > of simulationus VPN connection.I can build a kernel with debugging enabled or something to help to track th
> > source of the problem. Please CC as I am not subscribed to this mailing list.
> > 
> > -- 
> > ierdnah <ierdnah@go.ro>
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
-- 
ierdnah <ierdnah@go.ro>

