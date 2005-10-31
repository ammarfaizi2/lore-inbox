Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVJaKlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVJaKlQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 05:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVJaKlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 05:41:16 -0500
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:3025 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id S932109AbVJaKlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 05:41:16 -0500
Message-ID: <20051031104110.18938.qmail@thales.mathematik.uni-ulm.de>
Date: Mon, 31 Oct 2005 11:41:09 +0100
From: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
To: linux-kernel@vger.kernel.org
Subject: BUG?: request_irq can apparently sleep
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

the basic question is: Is request_irq allowed to sleep?

A lot of code suggest that sleeping is not allowed, including a
call to kmalloc(..., GFP_ATOMIC) in request_irq itself.

However, we have the following at least theoretically possible call chain:

request_irq->setup_irq->register_handler_proc->proc_mkdir->
->proc_mkdir_mode->proc_create->kmalloc (..., GFP_KERNEL)->BOOM

The code in kernel/fs/proc/generic.c looks like this:

        ent = kmalloc(sizeof(struct proc_dir_entry) + len + 1, GFP_KERNEL);
	if (!ent) goto out;

Given that check for ent != NULL this should probably be changed to an
GFP_ATOMIC allocation. Am I missing something?

   regards   Christian

-- 
THAT'S ALL FOLKS!
