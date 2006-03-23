Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWCWVeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWCWVeq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWCWVeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:34:46 -0500
Received: from zrtps0kp.nortelnetworks.com ([47.140.192.56]:39908 "EHLO
	zrtps0kp.nortel.com") by vger.kernel.org with ESMTP id S932131AbWCWVeq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:34:46 -0500
Message-ID: <44231473.8070709@nortel.com>
Date: Thu, 23 Mar 2006 15:34:43 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: either bug or unnecessary code in exit_mm()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Mar 2006 21:34:43.0121 (UTC) FILETIME=[991E9210:01C64EC1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the last few kernels (at least as far back as 2.6.10), exit_mm() 
looks like this:


static void exit_mm(struct task_struct * tsk)
{
	struct mm_struct *mm = tsk->mm;

	mm_release(tsk, mm);
	if (!mm)
		return;




while mm_release() looks like this:




void mm_release(struct task_struct *tsk, struct mm_struct *mm)
{
	<snip>
	if (tsk->clear_child_tid && atomic_read(&mm->mm_users) > 1) {





If it's valid to call exit_mm() with tsk->mm being NULL, then it seems 
like we'll get problems when we dereference it unconditionally in 
mm_release().

If mm_release() is valid, then the check for !mm in exit_mm() is 
unnecessary but there should probably be a comment.

Can someone tell me which one it is?

Thanks,

Chris
