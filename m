Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWJHLRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWJHLRk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 07:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWJHLRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 07:17:39 -0400
Received: from drugphish.ch ([69.55.226.176]:28305 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S1751087AbWJHLRj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 07:17:39 -0400
Message-ID: <4528DE50.5020807@drugphish.ch>
Date: Sun, 08 Oct 2006 13:17:36 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: possible recursive locking detected: kseriod on 2.6.19-rc1-gb0eb0838
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know if this has been reported before, but here goes:

[   75.580449] Synaptics Touchpad, model: 1, fw: 5.9, id: 0x9b4cb1, 
caps: 0x884793/0x0
[   75.580461] serio: Synaptics pass-through port at isa0060/serio1/input0
[   75.723306] input: SynPS/2 Synaptics TouchPad as /class/input/input2
[   75.742032]
[   75.742036] =============================================
[   75.742107] [ INFO: possible recursive locking detected ]
[   75.742145] 2.6.19-rc1-gb0eb0838 #4
[   75.742179] ---------------------------------------------
[   75.742216] kseriod/130 is trying to acquire lock:
[   75.742253]  (&ps2dev->cmd_mutex/1){--..}, at: [<c0250876>] 
ps2_command+0x46/0x390
[   75.742439]
[   75.742441] but task is already holding lock:
[   75.742504]  (&ps2dev->cmd_mutex/1){--..}, at: [<c0250876>] 
ps2_command+0x46/0x390
[   75.742682]
[   75.742683] other info that might help us debug this:
[   75.742747] 4 locks held by kseriod/130:
[   75.742781]  #0:  (serio_mutex){--..}, at: [<c02c61b9>] 
mutex_lock+0x29/0x30
[   75.742970]  #1:  (&serio->drv_mutex){--..}, at: [<c02c61b9>] 
mutex_lock+0x29/0x30
[   75.743164]  #2:  (psmouse_mutex){--..}, at: [<c02c61b9>] 
mutex_lock+0x29/0x30
[   75.743357]  #3:  (&ps2dev->cmd_mutex/1){--..}, at: [<c0250876>] 
ps2_command+0x46/0x390
[   75.743579]
[   75.743580] stack backtrace:
[   75.743776]  [<c01048ea>] dump_trace+0x1ea/0x210
[   75.743867]  [<c0104936>] show_trace_log_lvl+0x26/0x40
[   75.743954]  [<c01050eb>] show_trace+0x1b/0x20
[   75.744040]  [<c0105266>] dump_stack+0x26/0x30
[   75.744126]  [<c0139927>] __lock_acquire+0xa17/0xd30
[   75.744295]  [<c0139f91>] lock_acquire+0x61/0x80
[   75.744463]  [<c02c625c>] mutex_lock_nested+0x9c/0x2a0
[   75.744624]  [<c0250876>] ps2_command+0x46/0x390
[   75.745130]  [<e0906931>] psmouse_sliced_command+0x31/0x90 [psmouse]
[   75.745224]  [<e090ad17>] synaptics_pt_write+0x27/0x60 [psmouse]
[   75.745309]  [<c0250797>] ps2_sendbyte+0x47/0xe0
[   75.745759]  [<c0250907>] ps2_command+0xd7/0x390
[   75.746206]  [<e0906415>] psmouse_probe+0x25/0xa0 [psmouse]
[   75.746289]  [<e09077c7>] psmouse_connect+0x147/0x250 [psmouse]
[   75.746374]  [<c024dd4a>] serio_connect_driver+0x2a/0x50
[   75.746822]  [<c024dd89>] serio_driver_probe+0x19/0x20
[   75.747267]  [<c0230219>] really_probe+0x39/0xe0
[   75.747682]  [<c0230360>] driver_probe_device+0xa0/0xb0
[   75.748097]  [<c0230388>] __device_attach+0x18/0x20
[   75.748511]  [<c022f4fe>] bus_for_each_drv+0x5e/0x80
[   75.748926]  [<c0230428>] device_attach+0x98/0xa0
[   75.749341]  [<c022f45a>] bus_attach_device+0x2a/0x70
[   75.749754]  [<c022e382>] device_add+0x472/0x560
[   75.750168]  [<c024ebec>] serio_thread+0x1ac/0x320
[   75.750614]  [<c01319c6>] kthread+0x106/0x110
[   75.750766]  [<c0104467>] kernel_thread_helper+0x7/0x10
[   75.750853]  =======================

Following debugging settings are enabled:

CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_PRINTK_TIME=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_TRACE_IRQFLAGS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_STACKTRACE=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_FS=y
CONFIG_FRAME_POINTER=y
CONFIG_UNWIND_INFO=y
CONFIG_STACK_UNWIND=y
CONFIG_FORCED_INLINING=y
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y

(gdb) list *0xc0250876
0xc0250876 is in ps2_command (include/linux/serio.h:141).
136      * Use the following functions to protect critical sections in
137      * driver code from port's interrupt handler
138      */
139     static inline void serio_pause_rx(struct serio *serio)
140     {
141             spin_lock_irq(&serio->lock);
142     }
143
144     static inline void serio_continue_rx(struct serio *serio)
145     {
(gdb) list *0xc02c61b9
0xc02c61b9 is in mutex_lock (kernel/mutex.c:92).
87              /*
88               * The locking fastpath is the 1->0 transition from
89               * 'unlocked' into 'locked' state.
90               */
91              __mutex_fastpath_lock(&lock->count, __mutex_lock_slowpath);
92      }
93
94      EXPORT_SYMBOL(mutex_lock);
95
96      static void fastcall noinline __sched
(gdb) l *ps2_command+0x46/0x390
0xc0250830 is in ps2_command (drivers/input/serio/libps2.c:175).
170      *
171      * ps2_command() can only be called from a process context
172      */
173
174     int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int 
command)
175     {
176             int timeout;
177             int send = (command >> 12) & 0xf;
178             int receive = (command >> 8) & 0xf;
179             int rc = -1;
(gdb) l *mutex_lock+0x29/0x30
0xc02c6190 is in mutex_lock (kernel/mutex.c:85).
80       *   deadlock debugging. )
81       *
82       * This function is similar to (but not equivalent to) down().
83       */
84      void inline fastcall __sched mutex_lock(struct mutex *lock)
85      {
86              might_sleep();
87              /*
88               * The locking fastpath is the 1->0 transition from
89               * 'unlocked' into 'locked' state.

The laptop boots and works otherwise so far, including PS2 input. More 
info available on request.

Best regards,
Roberto Nibali, ratz
-- 
echo 
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
