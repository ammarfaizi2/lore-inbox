Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbUKTPfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbUKTPfO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 10:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbUKTPfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 10:35:14 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:5538 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262801AbUKTPfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 10:35:06 -0500
Date: Sat, 20 Nov 2004 16:35:04 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: wait_event_interruptible() seems non-atomic
Message-ID: <Pine.LNX.4.53.0411201628510.31084@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,


upon reviewing some of my code for a device driver, I've come across:


static ssize_t uif_read(struct file *filp, char __user *buf,
  size_t count, loff_t *ppos)
{
    // Nothing read, nothing done
    if(count == 0) { return 0; }

    // Must sleep as long as there is no data
    if(down_interruptible(&Buffer_lock)) { return -ERESTARTSYS; }
    while(BufRP == BufWP) {
        up(&Buffer_lock);
        if(filp->f_flags & O_NONBLOCK) { return -EAGAIN; }

        // hm, the condition is not atomic or locked...
        if(wait_event_interruptible(Pull_queue, (BufRP != BufWP))) {
            return -ERESTARTSYS;
        }
        if(down_interruptible(&Buffer_lock)) { return -ERESTARTSYS; }
    }

    // Data is available, so give it to the user
    ...
}

As you can see, I lock Buffer_lock and then check BufRP == BufWP. I do that
because in an SMP environment, either of BufRP or BufWP might have been
updated. (I.e. one CPU currently does "mov BufRP to eax; mov BufWP to ebx; cmp
eax, ebx" while another does "inc BufWP")

I would like to also lock Buffer_lock around BufRP != BufWP, but don't see a
way on how to accomplish this.

Does anybody know a way how this could be achieved?



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
