Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSGYRTQ>; Thu, 25 Jul 2002 13:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSGYRTQ>; Thu, 25 Jul 2002 13:19:16 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:34567 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S315431AbSGYRTP>;
	Thu, 25 Jul 2002 13:19:15 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: dalecki@evision.ag
Date: Thu, 25 Jul 2002 19:22:14 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: IDE lockups with 2.5.28...
CC: lkml <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <218BBF1744@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,
   can you explain what local_irq_disable() in do_request in
drivers/ide/ide.c should guard against? There is dozen (all unless I 
missed something) of paths which do not local_irq_enable(), and neither 
does the caller...

And what you meant with (endless) loop in ide_do_request?

And where do_request() callers obtain channel lock so that do_request()
can release and reacquire it?

My problem is that fsck reliable dies between 79.6 and 81% of its
run - on UP machine with SMP kernel:

NMI detected lockup on CPU0 ...

Stack trace: do_request + 315/924
             do_ide_request
             generic_unplug_device
             blk_run_queues
             do_page_cache_readahead
             page_cache_readahead
             do_generic_file_read
             generic_file_read
             file_read_actor
             vfs_read
             sys_read

do_request+315 is clear_bit(IDE_BUSY, channel->active) at line 606.

The do_ide_request()'s loop

while (!test_and_set_bit(IDE_BUSY, ch->active)) {
  do_request(ch)
}

looks very suspicious to me - it will loop here until the end of world,
as there is nothing in queue, so do_request() will always exit
with IDE_BUSY cleared.

Next question is: with this stack trace, where you obtained ch->lock,
so that do_request() can do call to spin_unlock(ch->lock) ? It looks
to me like that I should get 'unlocking unlocked spinlock' with
appropriate debug.

What (probably) happened is that hardware finished request before 
spin_lock_irq(ch->lock) (at line 749) was executed, we quit with
IDE_BUSY cleared, and it was last thing we did... Maybe I should
go back to IDE-98?
                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
