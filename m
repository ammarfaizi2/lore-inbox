Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274211AbRITCAg>; Wed, 19 Sep 2001 22:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272793AbRITB7r>; Wed, 19 Sep 2001 21:59:47 -0400
Received: from colorfullife.com ([216.156.138.34]:4115 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S272651AbRITB71>;
	Wed, 19 Sep 2001 21:59:27 -0400
Message-ID: <3BA8A6DB.F84C3CB3@colorfullife.com>
Date: Wed, 19 Sep 2001 16:08:27 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac9 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: David Howells <dhowells@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
        Ulrich.Weigand@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem
In-Reply-To: <Pine.LNX.4.33.0109180948260.2077-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------EC47045DDDDB1F75C906F158"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EC47045DDDDB1F75C906F158
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> If the choice is between a hack to do strange and incomprehensible things
> for a special case, and just making the semaphores do the same thing
> rw-spinlocks do and make the problem go away naturally, Ill take #2 any
> day. The patches already exist, after all.
>

I've attached a recursive semaphore patch against 2.4.10-pre11 - but it
makes mmap io unusable:

Testcase:
* file, mmaped, 300 MB, 128 MB Ram
* 2 threads: touch random pages 
* third thread: calls mprotect(0xFFFF00000,0x1000, PAGE_READ)

Result:
mprotect hangs forever (minutes) with recursive semaphores.

With fair semaphores, mprotect returns after ~80 milliseconds with 5
worker threads, after ~380 milliseconds with 20 worker threads (slow IDE
disk).

One alternative to David's patch would be moving the locking into the
coredump handlers - would you prefer that?

--
	Manfred
--------------EC47045DDDDB1F75C906F158
Content-Type: text/plain; charset=us-ascii;
 name="patch-recursive"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-recursive"

--- 2.4/lib/rwsem-spinlock.c	Sat Apr 28 10:37:27 2001
+++ build-2.4/lib/rwsem-spinlock.c	Wed Sep 19 15:03:28 2001
@@ -115,7 +115,7 @@
 
 	spin_lock(&sem->wait_lock);
 
-	if (sem->activity>=0 && list_empty(&sem->wait_list)) {
+	if (sem->activity>=0) {
 		/* granted */
 		sem->activity++;
 		spin_unlock(&sem->wait_lock);
--- 2.4/arch/i386/config.in	Wed Sep 19 14:36:35 2001
+++ build-2.4/arch/i386/config.in	Wed Sep 19 14:48:06 2001
@@ -59,8 +59,8 @@
    define_bool CONFIG_X86_XADD y
    define_bool CONFIG_X86_BSWAP y
    define_bool CONFIG_X86_POPAD_OK y
-   define_bool CONFIG_RWSEM_GENERIC_SPINLOCK n
-   define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
+   define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
+   define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
 fi
 if [ "$CONFIG_M486" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 4

--------------EC47045DDDDB1F75C906F158--

