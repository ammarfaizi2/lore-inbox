Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265922AbSIRKPp>; Wed, 18 Sep 2002 06:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266012AbSIRKPp>; Wed, 18 Sep 2002 06:15:45 -0400
Received: from jalon.able.es ([212.97.163.2]:35020 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S265922AbSIRKPo>;
	Wed, 18 Sep 2002 06:15:44 -0400
Date: Wed, 18 Sep 2002 12:20:29 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: BUG() triggered on SMP shutdown, cpu!=0
Message-ID: <20020918102029.GA1536@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I am getting oopses on shutdown, 'cause this bug is popping:

static void apm_power_off(void)
{
    unsigned char   po_bios_call[] = {
        0xb8, 0x00, 0x10,   /* movw  $0x1000,ax  */
        0x8e, 0xd0,     /* movw  ax,ss       */
        0xbc, 0x00, 0xf0,   /* movw  $0xf000,sp  */
        0xb8, 0x07, 0x53,   /* movw  $0x5307,ax  */
        0xbb, 0x01, 0x00,   /* movw  $0x0001,bx  */
        0xb9, 0x03, 0x00,   /* movw  $0x0003,cx  */
        0xcd, 0x15      /* int   $0x15       */
    };

    /*
     * This may be called on an SMP machine.
     */
#ifdef CONFIG_SMP
    /* Some bioses don't like being called from CPU != 0 */
    if (cpu_number_map(smp_processor_id()) != 0) {
        current->cpus_allowed = 1;
        schedule();
        if (unlikely(cpu_number_map(smp_processor_id()) != 0))
            BUG();
    }
#endif
    if (apm_info.realmode_power_off)
        machine_real_restart(po_bios_call, sizeof(po_bios_call));
    else
        (void) set_system_power_state(APM_STATE_OFF);
}

Does this mean that after the schedule() kernel is still in CPU1 ???
Will add a couple ptintks....
This is 2.4.19-pre7+aa patches.

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre7-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
