Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132216AbRCVWM7>; Thu, 22 Mar 2001 17:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132217AbRCVWMx>; Thu, 22 Mar 2001 17:12:53 -0500
Received: from Xenon.Stanford.EDU ([171.64.66.201]:26816 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S132216AbRCVWLr>; Thu, 22 Mar 2001 17:11:47 -0500
Date: Thu, 22 Mar 2001 14:10:59 -0800
From: Andy Chou <acc@CS.Stanford.EDU>
To: linux-kernel@vger.kernel.org
Cc: mc@CS.Stanford.EDU
Subject: [CHECKER] 8 more potential locking problems
Message-ID: <20010322141059.A21490@Xenon.Stanford.EDU>
Reply-To: acc@CS.Stanford.EDU
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.1.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We modified our compiler extension for checking lock consistency and
found 8 more potential errors.

-Andy Chou

Index:

drivers/char/pcwd.c:468:pcwd_close
drivers/sound/es1370.c:1775:es1370_release
drivers/sound/es1370.c:2442:es1370_midi_release
drivers/sound/es1371.c:2611:es1371_midi_release
drivers/sound/esssolo1.c:1936:solo1_midi_release
drivers/sound/sonicvibes.c:2215:sv_midi_release
drivers/video/fbmem.c:545:fb_mmap
fs/ufs/balloc.c:274:ufs_new_fragments

Errors:

---------------------------------------------------------
[BUG] GEM
/home/acc/oses/linux/2.4.1/drivers/char/pcwd.c:468:pcwd_close: ERROR:ALOCK:455:468: Inconsistent
lock using `lock_kernel':455

Start --->
		lock_kernel();
	        is_open = 0;
#ifndef CONFIG_WATCHDOG_NOWAYOUT
		/*  Disable the board  */
		if (revision == PCWD_REVISION_C) {

	... DELETED 5 lines ...

		}
		unlock_kernel();
#endif
	}
Error --->
	return 0;
}
---------------------------------------------------------
[BUG] 
/home/acc/oses/linux/2.4.1/drivers/sound/es1370.c:2442:es1370_midi_release: ERROR:ALOCK:2427:2442: Inconsistent
lock using `lock_kernel':2427

Start --->
	lock_kernel();
	if (file->f_mode & FMODE_WRITE) {
		add_wait_queue(&s->midi.owait, &wait);
		for (;;) {
			__set_current_state(TASK_INTERRUPTIBLE);

	... DELETED 7 lines ...

				break;
			if (file->f_flags & O_NONBLOCK) {
				remove_wait_queue(&s->midi.owait, &wait);
				set_current_state(TASK_RUNNING);
Error --->
				return -EBUSY;
			}
---------------------------------------------------------
[BUG] GEM
/home/acc/oses/linux/2.4.1/drivers/sound/es1370.c:1775:es1370_release: ERROR:ALOCK:1759:1775: Inconsistent
lock using `lock_kernel':1759

Start --->
	lock_kernel();
	if (file->f_mode & FMODE_WRITE)
		drain_dac2(s, file->f_flags & O_NONBLOCK);
	down(&s->open_sem);
	if (file->f_mode & FMODE_WRITE) {

	... DELETED 8 lines ...

	}
	s->open_mode &= (~file->f_mode) & (FMODE_READ|FMODE_WRITE);
	wake_up(&s->open_wait);
	up(&s->open_sem);
Error --->
	return 0;
	unlock_kernel();
---------------------------------------------------------
[BUG]
/home/acc/oses/linux/2.4.1/drivers/sound/es1371.c:2611:es1371_midi_release: ERROR:ALOCK:2596:2611: Inconsistent
lock using `lock_kernel':2596

Start --->
	lock_kernel();
	if (file->f_mode & FMODE_WRITE) {
		add_wait_queue(&s->midi.owait, &wait);
		for (;;) {
			__set_current_state(TASK_INTERRUPTIBLE);

	... DELETED 7 lines ...

				break;
			if (file->f_flags & O_NONBLOCK) {
				remove_wait_queue(&s->midi.owait, &wait);
				set_current_state(TASK_RUNNING);
Error --->
				return -EBUSY;
			}
---------------------------------------------------------
[BUG]
/home/acc/oses/linux/2.4.1/drivers/sound/esssolo1.c:1936:solo1_midi_release: ERROR:ALOCK:1921:1936: Inconsistent
lock using `lock_kernel':1921

Start --->
	lock_kernel();
	if (file->f_mode & FMODE_WRITE) {
		add_wait_queue(&s->midi.owait, &wait);
		for (;;) {
			__set_current_state(TASK_INTERRUPTIBLE);

	... DELETED 7 lines ...

				break;
			if (file->f_flags & O_NONBLOCK) {
				remove_wait_queue(&s->midi.owait, &wait);
				set_current_state(TASK_RUNNING);
Error --->
				return -EBUSY;
			}
---------------------------------------------------------
[BUG]
/home/acc/oses/linux/2.4.1/drivers/sound/sonicvibes.c:2215:sv_midi_release: ERROR:ALOCK:2200:2215: Inconsistent
lock using `lock_kernel':2200

Start --->
	lock_kernel();
	if (file->f_mode & FMODE_WRITE) {
		add_wait_queue(&s->midi.owait, &wait);
		for (;;) {
			__set_current_state(TASK_INTERRUPTIBLE);

	... DELETED 7 lines ...

				break;
			if (file->f_flags & O_NONBLOCK) {
				remove_wait_queue(&s->midi.owait, &wait);
				set_current_state(TASK_RUNNING);
Error --->
				return -EBUSY;
			}
---------------------------------------------------------
[BUG]
/home/acc/oses/linux/2.4.1/drivers/video/fbmem.c:545:fb_mmap: ERROR:ALOCK:521:545: Inconsistent
lock using `lock_kernel':521

Start --->
		lock_kernel();
		res = fb->fb_mmap(info, file, vma);
		unlock_kernel();
		return res;
	}

	... DELETED 16 lines ...

		/* memory mapped io */
		off -= len;
		fb->fb_get_var(&var, PROC_CONSOLE(info), info);
		if (var.accel_flags)
Error --->
			return -EINVAL;
		start = fix.mmio_start;
---------------------------------------------------------
[BUG]
/home/acc/oses/linux/2.4.1/fs/ufs/balloc.c:274:ufs_new_fragments: ERROR:ALOCK:256:274: Inconsistent
lock using `lock_super':256

Start --->
	lock_super (sb);
	
	tmp = SWAB32(*p);
	if (count + ufs_fragnum(fragment) > uspi->s_fpb) {
		ufs_warning (sb, "ufs_new_fragments", "internal warning"

	... DELETED 10 lines ...

	if (oldcount) {
		if (!tmp) {
			ufs_error (sb, "ufs_new_fragments", "internal
error, "
				"fragment %u, tmp %u\n", fragment, tmp);
Error --->
			return (unsigned)-1;
		}

