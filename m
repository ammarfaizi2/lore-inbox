Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161316AbWHEMi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161316AbWHEMi2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 08:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161313AbWHEMi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 08:38:28 -0400
Received: from dea.vocord.ru ([217.67.177.50]:42476 "EHLO
	uganda.factory.vocord.ru") by vger.kernel.org with ESMTP
	id S1161242AbWHEMi2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 08:38:28 -0400
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: [take4 0/4] kevent: Generic event handling mechanism.
In-Reply-To: <20060731103322.GA1898@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Sat, 5 Aug 2006 17:02:35 +0400
Message-Id: <11547829553148@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Generic event handling mechanism.

I send this patchset for comments and review, it still contains AIO and 
aio_sendfile() implementation on top of get_block() abstraction, which was
decided to postpone for a while (it is simpler right now to generate patchset as a whole,
when kevent will be ready for merge, I will generate patchset without AIO stuff).
It does not contain mapped buffer implementation, since it's design is not 100% 
completed, I will present that implementation in the third patchset.

Changes from 'take3' patchset:
 * removed serializing mutex from kevent_user_wait()
 * moved storage list processing to RCU
 * removed lockdep screaming - all storage locks are initialized in the same function, so it was learned
	to differentiate between various cases
 * remove kevent from storage if is marked as broken after callback
 * fixed a typo in mmaped buffer implementation which would end up in wrong index calcualtion

Changes from 'take2' patchset:
 * split kevent_finish_user() to locked and unlocked variants
 * do not use KEVENT_STAT ifdefs, use inline functions instead
 * use array of callbacks of each type instead of each kevent callback initialization
 * changed name of ukevent guarding lock
 * use only one kevent lock in kevent_user for all hash buckets instead of per-bucket locks
 * do not use kevent_user_ctl structure instead provide needed arguments as syscall parameters
 * various indent cleanups
 * added optimisation, which is aimed to help when a lot of kevents are being copied from userspace
 * mapped buffer (initial) implementation (no userspace yet)

Changes from 'take1' patchset:
 - rebased against 2.6.18-git tree
 - removed ioctl controlling
 - added new syscall kevent_get_events(int fd, unsigned int min_nr, unsigned int max_nr,
			unsigned int timeout, void __user *buf, unsigned flags)
 - use old syscall kevent_ctl for creation/removing, modification and initial kevent 
	initialization
 - use mutuxes instead of semaphores
 - added file descriptor check and return error if provided descriptor does not match
	kevent file operations
 - various indent fixes
 - removed aio_sendfile() declarations.

Thank you.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>


