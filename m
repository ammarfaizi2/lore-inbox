Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270974AbUJVKQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270974AbUJVKQz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 06:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270979AbUJVKQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 06:16:55 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:56870 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S270974AbUJVKQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 06:16:48 -0400
Message-ID: <30257.195.245.190.93.1098440118.squirrel@195.245.190.93>
In-Reply-To: <21840.195.245.190.94.1098363807.squirrel@195.245.190.94>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>  
           <20041014002433.GA19399@elte.hu>
    <20041014143131.GA20258@elte.hu>         
    <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>      
       <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>   
          <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
             <20041020094508.GA29080@elte.hu>      
    <30690.195.245.190.93.1098349976.squirrel@195.245.190.93>
    <21840.195.245.190.94.1098363807.squirrel@195.245.190.94>
Date: Fri, 22 Oct 2004 11:15:18 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 22 Oct 2004 10:16:44.0270 (UTC) FILETIME=[3B11C0E0:01C4B820]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Rui Nuno Capela wrote:
>> Ingo Molnar wrote:
>>>
>>> i have released the -U8 Real-Time Preemption patch:
>>>
>>>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8
>>>
> [...]
>
> The fact is jackd -R (realtime mode; SCHED_FIFO) hosing the system, and
> thats exposed as soon as some jack audio client application enters into
> the chain.
>
> Running jackd non-realtime (SCHED_OTHER) does not expose this problem, so
> I think it's a scheduling related one.
>
> [...]


After some trial-and-error cycle, changing kernel configuration options, I
come to believe the obvious, that this jackd -R nasty behavior seems to be
present (only) if PREEMPT_REALTIME is set (Y).

When PREEMPT_REALTIME is not set (N), it just runs and I can throw any
client at 'jackd -R' without hosing the whole system. However, I'm seeing
plenty of these:

BUG: scheduling while atomic: jackd/0x00000002/3968
caller is schedule_timeout+0x5a/0xa8
 [<c0104ec8>] dump_stack+0x1e/0x20 (20)
 [<c02cd6d2>] __schedule+0x4c4/0x69e (76)
 [<c02ce45f>] schedule_timeout+0x5a/0xa8 (60)
 [<c0169c75>] do_poll+0x9b/0xb9 (48)
 [<c0169e02>] sys_poll+0x16f/0x225 (76)
 [<c010408d>] sysenter_past_esp+0x52/0x71 (-8124)
preempt count: 00000003
. 3-level deep critical section nesting:
.. entry 1: ipc_lock_writer+0x2f/0xae / (sys_shmctl+0x88/0x895)
.. entry 2: ipc_lock_writer+0xa3/0xae / (sys_shmctl+0x88/0x895)
.. entry 3: print_traces+0x16/0x4a / (dump_stack+0x1e/0x20)

BUG: sleeping function called from invalid context jackd(3968) at
mm/slab.c:2055
in_atomic():1 [00000002], irqs_disabled():0
 [<c0104ec8>] dump_stack+0x1e/0x20 (20)
 [<c011505f>] __might_sleep+0xb2/0xc5 (36)
 [<c013e7f8>] __kmalloc+0xa3/0xaa (28)
 [<c0169d60>] sys_poll+0xcd/0x225 (76)
 [<c010408d>] sysenter_past_esp+0x52/0x71 (-8124)
preempt count: 00000003
. 3-level deep critical section nesting:
.. entry 1: ipc_lock_writer+0x2f/0xae / (sys_shmctl+0x88/0x895)
.. entry 2: ipc_lock_writer+0xa3/0xae / (sys_shmctl+0x88/0x895)
.. entry 3: print_traces+0x16/0x4a / (dump_stack+0x1e/0x20)



OTOH, I do get in some trouble elsewhere, but not related to jackd. For
example, the system hangs on udev, never managed to shutdown cleanly, and
some system monitoring applications just keeps failing completely (e.g.
gkrellm).

But I found this on late init:

BUG: Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
c01cbb7d
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: realtime commoncap snd_seq_oss snd_seq_midi_event
snd_seq snd_pcm_oss snd_mixer_oss snd_usb_usx2y snd_usb_lib snd_rawmidi
snd_seq_device snd_hwdep snd_ali5451 snd_ac97_codec snd_pcm snd_timer
snd_page_alloc snd soundcore prism2_cs p80211 ds yenta_socket pcmcia_core
natsemi crc32 loop subfs evdev ohci_hcd usbcore thermal processor fan
button battery ac
CPU:    0
EIP:    0060:[<c01cbb7d>]    Not tainted VLI
EFLAGS: 00210246   (2.6.9-rc4-mm1-U9.2)
EIP is at acpi_os_signal_semaphore+0x30/0x4e
eax: df75b700   ebx: 00000001   ecx: 00000000   edx: 00000010
esi: c155c400   edi: 00000000   ebp: de48dd9c   esp: de48dd98
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process kdeinit (pid: 3862, threadinfo=de48c000 task=de5af400)
Stack: df750700 de48ddac c01d4b88 df74b160 00000001 de48ddc4 c01d67a2
df750700
       df750700 c155c400 c155c400 de48ddd8 c01d3abe df750700 c155c400
00000000
       de48ddf8 c01cd2e2 c155c400 00000000 c149c820 c155c400 c155c5ec
00000000
Call Trace:
 [<c0104e94>] show_stack+0x80/0x96 (28)
 [<c010502f>] show_registers+0x165/0x1de (56)
 [<c0105241>] die+0xf6/0x191 (64)
 [<c01123ab>] do_page_fault+0x483/0x6a4 (212)
 [<c0104af1>] error_code+0x2d/0x38 (72)
 [<c01d4b88>] acpi_ex_system_release_mutex+0x28/0x2a (16)
 [<c01d67a2>] acpi_ex_release_mutex+0x135/0x154 (24)
 [<c01d3abe>] acpi_ex_opcode_1A_0T_0R+0x2a/0x92 (20)
 [<c01cd2e2>] acpi_ds_exec_end_op+0xb4/0x28e (32)
 [<c01db23e>] acpi_ps_parse_loop+0x528/0x810 (40)
 [<c01db57d>] acpi_ps_parse_aml+0x57/0x1c2 (32)
 [<c01dbea5>] acpi_psx_execute+0x15d/0x1c4 (28)
 [<c01d914d>] acpi_ns_execute_control_method+0x41/0x51 (20)
 [<c01d90f2>] acpi_ns_evaluate_by_handle+0x74/0x8e (16)
 [<c01d8fed>] acpi_ns_evaluate_relative+0xa9/0xc5 (32)
 [<c01d88a5>] acpi_evaluate_object+0xfd/0x1ae (52)
 [<c01cbedd>] acpi_evaluate_integer+0x32/0x4f (52)
 [<e001a06c>] acpi_button_state_seq_show+0x27/0x64 [button] (32)
 [<c0175562>] seq_read+0xd3/0x2cf (60)
 [<c015461c>] vfs_read+0xc1/0x13a (44)
 [<c015490b>] sys_read+0x4b/0x75 (44)
 [<c010408d>] sysenter_past_esp+0x52/0x71 (-8124)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: die+0x3a/0x191 / (do_page_fault+0x483/0x6a4)
.. entry 2: print_traces+0x16/0x4a / (show_stack+0x80/0x96)

Code: 4d 08 8b 5d 0c 85 c9 0f 94 c2 85 db 0f 94 c0 09 d0 ba 01 10 00 00 a8
01 75 28 83 fb 01 66 ba 10 00 77 1f ff 01 0f 8e d2 00 00 00 <8b> 01 48 7e
10 68 29 7e 2e c0 e8 5a c3 f4 ff 5b e8 18 93 f3 ff


As it seemed an ACPI issue, I turned it off and the troubles went away.
Again, all this is happening with PREEMPT_REALTIME off.

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

