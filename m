Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268134AbTBMSRS>; Thu, 13 Feb 2003 13:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268136AbTBMSRS>; Thu, 13 Feb 2003 13:17:18 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:15542 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S268134AbTBMSRG>;
	Thu, 13 Feb 2003 13:17:06 -0500
Subject: [BUG]: smbfs bug in 2.5.58-mm1
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045160816.23312.41.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 13 Feb 2003 19:26:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Urban,

You seem to be the one to mail this stuff to.

Just came across an smbfs bug in 2.5.58-mm1 compiled with slab-debugging
but without preempt which I've been running for a while.

I was playing an mp3 from a samba server and suddenly the music stopped,
I tried pinging the server and it responded, then I tried stopping the
playback in xmms and then pressing play again. At first nothing happened
but after a few seconds xmms died and I got this in my kernel-log (the
machine appears to still be stable, writing this mail on it):

I'm not sure when these two messages appeared, but they seem related to
the crash and they weren't there when I ran dmesg a few hours earlier.


smb_get_length: Invalid NBT packet, code=96
smb_add_request: request [d023664c, mid=1802201963] timed out!
------------[ cut here ]------------
kernel BUG at mm/slab.c:1632!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c01332d3>]    Not tainted
EFLAGS: 00010202
EIP is at cache_alloc_debugcheck_after+0xc3/0xe0
eax: 00000001   ebx: d0236648   ecx: 00000000   edx: 000000f4
esi: ebd8d9c4   edi: 000001d0   ebp: 00000000   esp: c4e77c00
ds: 007b   es: 007b   ss: 0068
Process xmms (pid: 15113, threadinfo=c4e76000 task=c4c28100)
Stack: ebd8d9c4 d0236648 00000058 ebd8d9c4 00000246 c01323a6 ebd8d9c4 000001d0 
       d0236648 e81b7bdc 00000000 00001000 eeadbeaa ebd8d9c4 000001d0 6b6b6b6b 
       d0236658 00000000 00000000 c4c28100 e81b7bdc fffffff4 00000042 eeadbf60 
Call Trace:
 [<c01323a6>] kmem_cache_alloc+0x56/0x80
 [<eeadbeaa>] smb_do_alloc_request+0x2a/0x11524180 [smbfs]
 [<eeadbf60>] smb_alloc_request+0x30/0x115240d0 [smbfs]
 [<eead445f>] smb_proc_open+0x3f/0x1152bbe0 [smbfs]
 [<eead3e73>] smb_request_ok+0x33/0x1152c1c0 [smbfs]
 [<eead4650>] smb_open+0xf0/0x1152baa0 [smbfs]
 [<eeadadbb>] smb_readpage_sync+0x8b/0x115252d0 [smbfs]
 [<eeadaed5>] smb_readpage+0x25/0x11525150 [smbfs]
 [<c0130c91>] read_pages+0xe1/0x130
 [<c013112c>] __do_page_cache_readahead+0xbc/0x110
 [<c0130d23>] do_page_cache_readahead+0x43/0x50
 [<c0130e7e>] page_cache_readahead+0x14e/0x190
 [<c012beeb>] do_generic_mapping_read+0xbb/0x3c0
 [<c012c230>] file_read_actor+0x0/0xf0
 [<c012c4f4>] __generic_file_aio_read+0x1d4/0x210
 [<c012c230>] file_read_actor+0x0/0xf0
 [<c012c63e>] generic_file_read+0x8e/0xb0
 [<c010abe5>] do_IRQ+0xc5/0xd0
 [<c0109570>] common_interrupt+0x18/0x20
 [<c01159ab>] do_schedule+0x17b/0x2b0
 [<eeadb240>] smb_file_read+0x80/0x11524e40 [smbfs]
 [<c014525e>] vfs_read+0xbe/0x130
 [<c01454fe>] sys_read+0x3e/0x60
 [<c0109403>] syscall_call+0x7/0xb

Code: 0f 0b 60 06 8f b6 25 c0 8b 46 34 e9 54 ff ff ff 8d b6 00 00 



mm/slab.c :
(line 1632 marked with ^^^^^^)
(slab-debugging is enabled)

static inline void *
cache_alloc_debugcheck_after(kmem_cache_t *cachep,
                        unsigned long flags, void *objp)
{
#if DEBUG
        if (!objp)
                return objp;
        if (cachep->flags & SLAB_POISON)
                if (check_poison_obj(cachep, objp))
                        BUG();
                        ^^^^^^ 
        if (cachep->flags & SLAB_RED_ZONE) {
                /* Set alloc red-zone, and check old one. */
                if (xchg((unsigned long *)objp, RED_ACTIVE) !=
RED_INACTIVE)
                        slab_error(cachep, "memory before object was "
                                                "overwritten");
                if (xchg((unsigned long *)(objp+cachep->objsize -
                          BYTES_PER_WORD), RED_ACTIVE) != RED_INACTIVE)
                        slab_error(cachep, "memory after object was "
                                                "overwritten");
                objp += BYTES_PER_WORD;
        }
        if (cachep->ctor && cachep->flags & SLAB_POISON) {
                unsigned long   ctor_flags = SLAB_CTOR_CONSTRUCTOR;

                if (!flags & __GFP_WAIT)
                        ctor_flags |= SLAB_CTOR_ATOMIC;

                cachep->ctor(objp, cachep, ctor_flags);
        }
#endif
        return objp;
}


I'm not sure how to reproduce this so I hope you know what might be
going on :)

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
