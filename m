Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbTAYVte>; Sat, 25 Jan 2003 16:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbTAYVte>; Sat, 25 Jan 2003 16:49:34 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:9702 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id <S262384AbTAYVtc>;
	Sat, 25 Jan 2003 16:49:32 -0500
Date: Sat, 25 Jan 2003 22:58:44 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Janet Morgan <janetmor@us.ibm.com>
Subject: Re: [patch] epoll for 2.4.20 updated ...
Message-ID: <20030125215844.GA3750@werewolf.able.es>
References: <Pine.LNX.4.50.0301242004010.2858-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.50.0301242004010.2858-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Sat, Jan 25, 2003 at 05:06:30 +0100
X-Mailer: Balsa 2.0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.01.25 Davide Libenzi wrote:
> 
> I updated the 2.4.20 patch with the changes posted today and I fixed a
> little error about the wait queue function prototype :
> 
> http://www.xmailserver.org/linux-patches/sys_epoll-2.4.20-0.61.diff
> 

Mixing epoll ontop of current aa, I found this:

#define add_wait_queue_cond(q, wait, cond) \
    ({                          \
        unsigned long flags;                \
        int _raced = 0;                 \
        wq_write_lock_irqsave(&(q)->lock, flags);   \
        (wait)->flags = 0;              \
        __add_wait_queue((q), (wait));          \
        mb();                       \
        if (!(cond)) {                  \
            _raced = 1;             \
            __remove_wait_queue((q), (wait));   \
        }                       \
        wq_write_unlock_irqrestore(&(q)->lock, flags);  \
        _raced;                     \
    })

this is the -aa version. Version from epoll uses just a rmb() barrier
(afaik, just a _read_ barrier). In -aa they are just the same, but I also
use a patch that does this:


+#ifdef CONFIG_X86_MFENCE
+#define mb()   __asm__ __volatile__ ("mfence": : :"memory")
+#else
 #define mb()   __asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
+#endif
+
+#ifdef CONFIG_X86_LFENCE
+#define rmb()  __asm__ __volatile__ ("lfence": : :"memory")
+#else
 #define rmb()  mb()
+#endif

so for modern processors they are different, and can affect performance and
correctness. So  which one it the correct one for the above code snipet ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre3-jam3 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-3mdk))
