Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTDSNJQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 09:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTDSNJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 09:09:16 -0400
Received: from [203.197.168.150] ([203.197.168.150]:33811 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S263388AbTDSNJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 09:09:12 -0400
Message-ID: <3EA14DD6.4B5983EA@tataelxsi.co.in>
Date: Sat, 19 Apr 2003 18:53:34 +0530
From: "Prasanta Sadhukhan" <prasanta@tataelxsi.co.in>
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: calling context of unregister_netdev
Content-Type: text/plain; charset=x-user-defined
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    We are using David Hinds standalone pcmcia package 3.2.4 for
compiling with our driver because we need "cb_enabler" file which is not
there in inbuilt kernel pcmcia source starting from 2.4.18-3 kernel
version.

Now, when we are plugging out the Cardbus card, our driver deatch
function is getting called from cb_detach function.
But our driver detach function is getting called in "interrupt
context"(verified by calling in_interrupt()). From our detach function,
we are calling cleanup which in turn is calling unregister_netdev()
function which is giving
"Aiee, kernel panic: killing interrupt handler." problem.

Now when we try to spawn a task by calling schedule_task() in detach
function and then try to call our cleanup function from the task,
everything is fine.

So my question is whether we can call unregister_netdev() function from
interrupt context(i.e, in ISR process context)

In kernel -version 2.4.2, "cb_enabler" was there in kernel inbuilt
pcmcia source tree and there hotplug was working which means that our
cleanup function was working. That means our deatch function was not
getting called in "interrupt context" when we were using inbuilt pcmcia
cardbus handler.

I am submitting the dump also which we got after running ksymoops.


kernel BUG at sched.c:809!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0116138>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000001   ebx: c02de000   ecx: c02dfce0   edx: c02de000
esi: c02dfcdc   edi: 00000001   ebp: c02dfc60   esp: c02dfc50
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02df000)
Stack: c02dfce0 c02de000 c02dfcdc c044e050 c02dfc90 c0116273 00000000
c02de000
       00000000 00000000 00000001 c02de000 c02dfce0 c02dfce0 c02dfcbc
c02dfcdc
       c02dfe2c c012527f c02dfc9c c02aa970 c02aa970 00000001 c01251b0
c02dfcbc
Call Trace: [<c0116273>] wait_for_completion [kernel] 0x63 (0xc02dfc64))

[<c012527f>] call_usermodehelper [kernel] 0x9f (0xc02dfc94))
[<c01251b0>] __call_usermodehelper [kernel] 0x0 (0xc02dfca8))
[<c01bccdf>] net_run_sbin_hotplug [kernel] 0x7f (0xc02dfcf4))
[<c018ac98>] rs_interrupt_single [kernel] 0x98 (0xc02dfd78))
[<c01bcc15>] unregister_netdevice [kernel] 0x1d5 (0xc02dfd94))
[<c019b780>] unregister_netdev [kernel] 0x10 (0xc02dfdb
[<c28af971>] mtok_cleanup [mtok] 0x85 (0xc02dfdc0))
[<c28ad3c0>] bus_table [cb_enabler] 0x0 (0xc02dfdd8))
[<c28ad300>] driver [cb_enabler] 0x0 (0xc02dfddc))
[<c28c1275>] mtokcb_detach [mtok_cb] 0x2d (0xc02dfde0))
[<c28ad3c0>] bus_table [cb_enabler] 0x0 (0xc02dfdf8))
[<c28ac24e>] cb_release [cb_enabler] 0x112 (0xc02dfe00))
[<c0119160>] printk [kernel] 0xf0 (0xc02dfe10))
[<c0118f55>] call_console_drivers [kernel] 0x55 (0xc02dfe14))
[<c28ad3c0>] bus_table [cb_enabler] 0x0 (0xc02dfe28))
[<c28ac2e5>] cb_event [cb_enabler] 0x89 (0xc02dfe30))
[<c0119160>] printk [kernel] 0xf0 (0xc02dfe40))
[<c28ad300>] driver [cb_enabler] 0x0 (0xc02dfe4c))
[<c288d78e>] send_event [pcmcia_core] 0x46 (0xc02dfe60))
[<c0116198>] __wake_up [kernel] 0x48 (0xc02dfe7c))
[<c288d8b7>] parse_events [pcmcia_core] 0x11f (0xc02dfe90))
[<c28a2560>] socket [i82365] 0x0 (0xc02dfeb0))
[<c2899225>] pcic_interrupt [i82365] 0x191 (0xc02dfec0))
[<c0109d5d>] handle_IRQ_event [kernel] 0x3d (0xc02dff00))
[<c28a2560>] socket [i82365] 0x0 (0xc02dff08))
[<c0109ee8>] do_IRQ [kernel] 0x78 (0xc02dff20))
[<c010c378>] call_do_IRQ [kernel] 0x5 (0xc02dff40))
[<c011330d>] apm_bios_call_simple [kernel] 0x3d (0xc02dff88))
[<c011330d>] apm_bios_call_simple [kernel] 0x3d (0xc02dffa0))
[<c0113422>] apm_do_idle [kernel] 0x12 (0xc02dffbc))
[<c0113543>] apm_cpu_idle [kernel] 0xb3 (0xc02dffd4))
[<c0105000>] stext [kernel] 0x0 (0xc02dffe4))
[<c0106e8b>] cpu_idle [kernel] 0x1b (0xc02dffec))
Code: 0f 0b 29 03 a5 ec 20 c0 e9 8b fd ff ff 90 8d 76 00 8d bc 27


>>EIP; c0116138 <schedule+288/2a0>   <=====

>>ebx; c02de000 <init_task_union+0/17420>
>>ecx; c02dfce0 <init_task_union+1ce0/17420>
>>edx; c02de000 <init_task_union+0/17420>
>>esi; c02dfcdc <init_task_union+1cdc/17420>
>>ebp; c02dfc60 <init_task_union+1c60/17420>
>>esp; c02dfc50 <init_task_union+1c50/17420>

Trace; c0116273 <wait_for_completion+63/90>
Trace; c012527f <call_usermodehelper+9f/3b0>
Trace; c01251b0 <request_module+210/240>
Trace; c01bccdf <unregister_netdevice+29f/670>
Trace; c018ac98 <paste_selection+a68/4b00>
Trace; c01bcc15 <unregister_netdevice+1d5/670>
Trace; c019b780 <unregister_netdev+10/20>
Trace; c28af971 <[mtok]knossos_issue_command+d/24>
Trace; c28ad3c0 <[mtok]mtok_close+24/a4>
Trace; c28ad300 <[mtok]mtok_open+40/dc>
Trace; c28c1275 <[fat]parse_options+225/830>
Trace; c28ad3c0 <[mtok]mtok_close+24/a4>
Trace; c28ac24e <[mtok]mtok_display_details+2e/bc>
Trace; c0119160 <printk+f0/130>
Trace; c0118f55 <__out_of_line_bug+465/580>
Trace; c28ad3c0 <[mtok]mtok_close+24/a4>
Trace; c28ac2e5 <[mtok]mtok_pci_to_udt_type+9/94>
Trace; c0119160 <printk+f0/130>
Trace; c28ad300 <[mtok]mtok_open+40/dc>
Trace; c288d78e <[pcmcia_core]send_event+46/50>
Trace; c0116198 <__wake_up+48/60>
Trace; c288d8b7 <[pcmcia_core]parse_events+11f/184>
Trace; c28a2560 <[i82365]socket+0/2a0>
Trace; c2899225 <[i82365]pcic_interrupt+191/1f8>
Trace; c0109d5d <show_stack+ddd/e10>
Trace; c28a2560 <[i82365]socket+0/2a0>
Trace; c0109ee8 <enable_irq+f8/160>
Trace; c010c378 <sys_ptrace+658/ee0>
Trace; c011330d <mtrr_del+fbd/2480>
Trace; c011330d <mtrr_del+fbd/2480>
Trace; c0113422 <mtrr_del+10d2/2480>
Trace; c0113543 <mtrr_del+11f3/2480>
Trace; c0105000 <empty_zero_page+1000/2df0>
Trace; c0106e8b <default_idle+7b/90>

Code;  c0116138 <schedule+288/2a0>
00000000 <_EIP>:
Code;  c0116138 <schedule+288/2a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011613a <schedule+28a/2a0>
   2:   29 03                     sub    %eax,(%ebx)
Code;  c011613c <schedule+28c/2a0>
   4:   a5                        movsl  %ds:(%esi),%es:(%edi)
Code;  c011613d <schedule+28d/2a0>
   5:   ec                        in     (%dx),%al
Code;  c011613e <schedule+28e/2a0>
   6:   20 c0                     and    %al,%al
Code;  c0116140 <schedule+290/2a0>
   8:   e9 8b fd ff ff            jmp    fffffd98 <_EIP+0xfffffd98>
Code;  c0116145 <schedule+295/2a0>
   d:   90                        nop
Code;  c0116146 <schedule+296/2a0>
   e:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0116149 <schedule+299/2a0>
  11:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi

 <0>Kernel panic: Aiee, killing interrupt handler!


Any suggestion is highly appreciated.

Thanks & Regards
Prasanta


