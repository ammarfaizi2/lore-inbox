Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268767AbTBZPEb>; Wed, 26 Feb 2003 10:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268766AbTBZPEb>; Wed, 26 Feb 2003 10:04:31 -0500
Received: from [203.239.133.219] ([203.239.133.219]:5393 "HELO jchyun.com")
	by vger.kernel.org with SMTP id <S268765AbTBZPE3>;
	Wed, 26 Feb 2003 10:04:29 -0500
Date: Thu, 27 Feb 2003 00:14:35 +0900
From: "Q-ha Park" <qhpark@mail.jchyun.com>
To: linux-kernel@vger.kernel.org
X-Mailer: iMate Web Mail System v5.0.0
Subject: PROBLEMO: Kernel Oops when writing from ..uhm.. writing to disk(harddrive and nfs-mounted drive)
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
Message-ID: <dz2r06qs/linux-kernel@vger.kernel.org/qhpark@mail.jchyun.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=euc-kr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Kernel oops when writing data read from the device to disk(hdd or nfs-mounted filesystem).
 
2. It occurs somewhat randomly but whenever it happens, NIP is always 0x00000040. i don't think it's related to 
just "writing" to disk cuz cat /dev/full > temp doesn't make the kernel oops. the device driver simply "put_user
(data)", and the program reads that and write to a file. It writes something and sometimes it writes quite a lot 
(more than 30 megs), and it ooops. the ksymoops trace generates almost the similar output(the NIP and the last trace 
before NIP are the same). it's at __run_task_queue.
 
3. ppc405, run_task_queue
 
4. cat /proc/version
Linux version 2.4.17_mvl21-redwood5 (root@qha-p3) (gcc version 2.95.3 20010315 (release/MontaVista)) 2. 3. 10:54:16 
KST 2003
 
5. oops
Oops: kernel access of bad area, sig: 11
NIP: 00000040 XER: 20000000 LR: C0016DC8 SP: C03F1BA0 REGS: c03f1ae0 TRAP: 0400    Not tad
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c03f0000[8] 'rpciod' Last syscall: -1 
last math 00000000 last altivec 00000000
GPR00: 00000040 C03F1BA0 C03F0000 00000002 C03F1B78 00004000 00844000 00000001 
GPR08: C19B8DE0 C01C504C 3E64A000 C19B6000 42002029 10019BEC 00004000 C03F1D88 
GPR16: 00004040 00002000 000005C8 00000003 000005DC 00000010 0000667D 00000000 
GPR24: 00000014 000005DC C01C9060 00000000 C03F1BA8 C341BD50 00000000 00000000 
Call backtrace: 
C0016DC8 C001A918 C0016C84 C0016B3C C0016774 C0110A54 C01156A4 
C0122B30 C01234F0 C0123650 C0141074 C0148190 C0108D64 C0156798 
C015662C C0154130 C015843C C01588C0 C0159454 C0004F68
Warning (Oops_read): Code line not seen, dumping what data is available
 
>>NIP; 00000040 Before first symbol   <=====
Trace; c0016dc8 <__run_task_queue+88/14c>
Trace; c001a918 <del_timer+c8/10e8>
Trace; c0016c84 <tasklet_kill+ec/140>
Trace; c0016b3c <__tasklet_hi_schedule+21c/25c>
Trace; c0016774 <do_softirq+88/100>
Trace; c0110a54 <dev_queue_xmit+1a8/3c8>
Trace; c01156a4 <neigh_resolve_output+1a0/218>
Trace; c0122b30 <ip_options_undo+bb8/1a2c>
Trace; c01234f0 <ip_options_undo+1578/1a2c>
Trace; c0123650 <ip_options_undo+16d8/1a2c>
Trace; c0141074 <ip_cmsg_recv+1cda8/1e348>
Trace; c0148190 <unregister_inetaddr_notifier+1d00/215c>
Trace; c0108d64 <sock_sendmsg+9c/cc>
Trace; c0156798 <rpc_restart_call+2d18/33f8>
Trace; c015662c <rpc_restart_call+2bac/33f8>
Trace; c0154130 <rpc_restart_call+6b0/33f8>
Trace; c015843c <rpc_delay+144/3a4>
Trace; c01588c0 <rpc_execute+224/278>
Trace; c0159454 <rpc_killall_tasks+1b4/43c>
Trace; c0004f68 <kernel_thread+2c/1c4>

the code:
0xc0016d40 <__run_task_queue>:  stwu    r1,-64(r1)
0xc0016d44 <__run_task_queue+4>:        mflr    r0
0xc0016d48 <__run_task_queue+8>:        stmw    r28,48(r1)
0xc0016d4c <__run_task_queue+12>:       stw     r0,68(r1)
0xc0016d50 <__run_task_queue+16>:       mr      r29,r3
0xc0016d54 <__run_task_queue+20>:       addi    r3,r1,24
0xc0016d58 <__run_task_queue+24>:       bl      0xc000492c <__save_flags_ptr>
0xc0016d5c <__run_task_queue+28>:       bl      0xc00049e0 <__cli>
0xc0016d60 <__run_task_queue+32>:       addi    r28,r1,8
0xc0016d64 <__run_task_queue+36>:       lwz     r9,0(r29)
0xc0016d68 <__run_task_queue+40>:       stw     r28,4(r9)
0xc0016d6c <__run_task_queue+44>:       lwz     r11,4(r29)
0xc0016d70 <__run_task_queue+48>:       stw     r9,8(r1)
0xc0016d74 <__run_task_queue+52>:       stw     r11,4(r28)
0xc0016d78 <__run_task_queue+56>:       stw     r28,0(r29)
0xc0016d7c <__run_task_queue+60>:       stw     r28,0(r11)
0xc0016d80 <__run_task_queue+64>:       stw     r29,0(r29)
0xc0016d84 <__run_task_queue+68>:       stw     r29,4(r29)
0xc0016d88 <__run_task_queue+72>:       lwz     r3,24(r1)
0xc0016d8c <__run_task_queue+76>:       bl      0xc000497c <__restore_flags>
0xc0016d90 <__run_task_queue+80>:       lwz     r29,8(r1)
0xc0016d94 <__run_task_queue+84>:       cmpw    r29,r28
---Type <return> to continue, or q <return> to quit---
0xc0016d98 <__run_task_queue+88>:
    beq 0xc0016dd0 <__run_task_queue+144>
0xc0016d9c <__run_task_queue+92>:       li      r31,0
0xc0016da0 <__run_task_queue+96>:       mr      r9,r29
0xc0016da4 <__run_task_queue+100>:      lwz     r0,12(r9)
0xc0016da8 <__run_task_queue+104>:      lwz     r3,16(r9)
0xc0016dac <__run_task_queue+108>:      lwz     r29,0(r29)
0xc0016db0 <__run_task_queue+112>:      eieio
0xc0016db4 <__run_task_queue+116>:      cmpwi   r0,0
0xc0016db8 <__run_task_queue+120>:      stw     r31,8(r9)
0xc0016dbc <__run_task_queue+124>:
    beq 0xc0016dc8 <__run_task_queue+136>
0xc0016dc0 <__run_task_queue+128>:      mtlr    r0
0xc0016dc4 <__run_task_queue+132>:      blrl
0xc0016dc8 <__run_task_queue+136>:      cmpw    r29,r28      <================ HERE! just before the NIP.
0xc0016dcc <__run_task_queue+140>:
    bne 0xc0016da0 <__run_task_queue+96>
0xc0016dd0 <__run_task_queue+144>:      lwz     r0,68(r1)
0xc0016dd4 <__run_task_queue+148>:      mtlr    r0
0xc0016dd8 <__run_task_queue+152>:      lmw     r28,48(r1)
0xc0016ddc <__run_task_queue+156>:      addi    r1,r1,64
0xc0016de0 <__run_task_queue+160>:      blr

 
in c:
void __run_task_queue(task_queue *list)
{   
    struct list_head head, *next;
    unsigned long flags;
    
    spin_lock_irqsave(&tqueue_lock, flags);
    list_add(&head, list);
    list_del_init(list);
    spin_unlock_irqrestore(&tqueue_lock, flags);
 
    next = head.next;
    while (next != &head) {
        void (*f) (void *);
        struct tq_struct *p;
        void *data;
    
        p = list_entry(next, struct tq_struct, list);
        next = next->next;
        f = p->routine;
        data = p->data;
        wmb();
        p->sync = 0;
        if (f)
            f(data);
    }
}

7. running kernel-2.4.17 (monta vista hard hat) on STB04xx chip. 
 
if i'm correct, it's trying access the invalid p->routine? what are the things i can try to debug this problem? 
whenever the oops occurs, NIP is always 0x0000040. i'm really stuck with this, and any help will be GREATLY 
appreciated!
 
thanks in advance!!
 
 
---------------
Q-ha Park (*)
Office: +82-2-2105-9167
Mobile: +82-16-372-0474
---------------




