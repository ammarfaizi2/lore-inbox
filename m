Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268908AbRHLBkg>; Sat, 11 Aug 2001 21:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268909AbRHLBk0>; Sat, 11 Aug 2001 21:40:26 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:21004 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268908AbRHLBkS>; Sat, 11 Aug 2001 21:40:18 -0400
Message-ID: <3B75DE86.EEDFAFFB@zip.com.au>
Date: Sat, 11 Aug 2001 18:40:22 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "ext3-users@redhat.com" <ext3-users@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: ext3-2.4-0.9.6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch against linux-2.4.8 is at

	http://www.uow.edu.au/~andrewm/linux/ext3/

The only changes here are merging up to 2.4.8 and the bigendian
fix.

linux-2.4.8-ac1 currently has ext3-0.9.3 which has no known
crash-worthy bugs, but is old.  I'm about to send Alan a diff
which takes -ac up to 0.9.6.  The changes between 0.9.3 and
0.9.6 may be summarised as:

- Simplify the handling of synchronous operations (O_SYNC, fsync(),
  chattr +S, etc).

- Fix a couple of places where we're not syncing writes when we should.

- Implement batching of synchronous operations: when multiple threads
  want to perform synchronous writes we allow the threads to block together
  and all their writes happen in the same transaction.   Speeds things up
  muchly.

- Implement support for external journal devices.  This is experimental
  at this stage.  It works fine, but the operational interfaces will change.
  At present the external journal device is not "mounted" when we're using
  it and it really should be.

- ext3 has for a long time had developer code which allows the target device
  to be turned read-only at the disk device driver level a certain number
  of jiffies after the fs was mounted.  This is to allow scripted testing
  of crash recovery.  This facility has been extended to support two devices;
  one for the filesystem and one for the external journal device.

- Accelerate an O(N^2) algorithm in log_do_checkpoint().

- Accelerate an O(N^2) algorithm in journal_commit_transaction().

- Rate-limit some error messages which can come out when we're
  hopelessly out of memory.

- Honour __GFP_WAIT in journal_try_to_free_buffers().  The fs is supposed
  to perform synchronous writeout on the second pass of page_launder() and
  we weren't doing that - we were starting all IO async.  The net effect of
  this change is to decrease throughout with dbench by 10-20%, but system
  CPU time goes from 60% to 30%.  It's the right thing to do...
