Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbUKDHxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbUKDHxS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbUKDHxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:53:18 -0500
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:41448 "EHLO
	imf16aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262137AbUKDHvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 02:51:25 -0500
Date: Thu, 4 Nov 2004 02:44:11 -0500
From: David Meybohm <frumplestillskins@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Subject: do_execve calls destroy_context when init_new_context has failed
Message-ID: <20041104074411.GA30985@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a discrepancy with fork vs. exec and what to do when
init_new_context() fails.

In do_execve(), there's a call to mmdrop() which calls destroy_context()
unconditionally if init_new_context() fails:

        bprm->mm = mm_alloc();
        if (!bprm->mm)
                goto out_file;

        retval = init_new_context(current, bprm->mm);
        if (retval < 0)
                goto out_mm;
	[omitted]

out_mm:
        if (bprm->mm)
                mmdrop(bprm->mm);

...and then __mmdrop, which gets called by mmdrop(), does this:

void fastcall __mmdrop(struct mm_struct *mm)
{
        BUG_ON(mm == &init_mm);
        mm_free_pgd(mm);
        destroy_context(mm);
        free_mm(mm);
}

But there's a comment in kernel/fork.c in copy_mm(), where
init_new_context() is also called, that thinks calling destroy_context()
shouldn't be called:

        if (init_new_context(tsk,mm))
                goto fail_nocontext;
	[omitted]

fail_nocontext:
        /*
         * If init_new_context() failed, we cannot use mmput() to free the mm
         * because it calls destroy_context()
         */
        mm_free_pgd(mm);
        free_mm(mm);
        return retval;

Who's right here?  fork or exec?
-- 
