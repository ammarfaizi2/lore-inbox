Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbUCBSVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 13:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbUCBSVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 13:21:11 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6784 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261629AbUCBSVG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 13:21:06 -0500
Date: Tue, 2 Mar 2004 13:21:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: poll() in 2.6 and beyond
Message-ID: <Pine.LNX.4.53.0403021318580.796@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Poll in 2.6.0; when a driver routine calls poll_wait()
it returns <<immediately>> to somewhere in the
kernel, then waits for my wake_up_interuptible(), before
returning control to a user sleeping in poll(). This means
that the user gets the wrong poll return value! It
doesn't get the value it was given as a result of the
interrupt, but the value that existed (0) before the
interrupt occurred.

Poll should not return from poll_wait() until it gets
a wake_up_interruptible() call. The wait variable,
info->pwait, below, has been initialized by executing
init_waitqueue_head(&info->pwait) in the initialization
code. This code works in 2.4.24.

What do I do to make it work in 2.6.0 and beyond? There
are no hints in the 2.6 drivers as they all seem to be
written like this and they presumably work.


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
/*
 *   The interrupt service routine.
 */
static void pci_isr(int irq, void *p, struct pt_regs *regs)
{
    spin_lock(&info->lock);
    DEB(printk(KERN_INFO"%s : Interrupt!\n", devname));
    info->poll_flag |= POLLIN|DEF_POLL;
    wake_up_interruptible(&info->pwait);
    spin_unlock(&info->lock);
}
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
/*
 *  Device poll routine.
 */
static size_t poll(struct file *fp, struct poll_table_struct *wait)
{
    size_t poll_flag;
    size_t flags;
    DEB(printk(KERN_INFO"%s : poll called\n", devname));
    poll_wait(fp, &info->pwait, wait);
    lockit(TRUE, &flags);
    poll_flag = info->poll_flag;
    info->poll_flag = 0;
    lockit(FALSE, &flags);
    DEB(printk(KERN_INFO"%s : poll returns\n", devname));
    return poll_flag;
}

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


