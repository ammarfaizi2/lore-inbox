Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269613AbUICJp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269613AbUICJp1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269592AbUICJos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:44:48 -0400
Received: from holomorphy.com ([207.189.100.168]:40067 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269586AbUICJmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:42:53 -0400
Date: Fri, 3 Sep 2004 02:42:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [1/4] standardize bit waiting data type
Message-ID: <20040903094247.GP3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Martin Wilck <martin.wilck@fujitsu-siemens.com>,
	linux-kernel@vger.kernel.org
References: <2xoKb-2Pa-27@gated-at.bofh.it> <2y3X5-73V-37@gated-at.bofh.it> <2y46A-798-17@gated-at.bofh.it> <2y4T1-7GM-17@gated-at.bofh.it> <2y52E-7Li-11@gated-at.bofh.it> <2y5ci-7Qz-7@gated-at.bofh.it> <2y5m3-7VH-5@gated-at.bofh.it> <2y7Hd-1aP-21@gated-at.bofh.it> <41383F33.4050503@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41383F33.4050503@fujitsu-siemens.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>>+	prepare_to_wait(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
>>+	if (buffer_locked(bh)) {
>>+		sync_buffer(bh);
>>+		io_schedule();
>>+	}
>> 	finish_wait(wqh, &wait.wait);
>> }

On Fri, Sep 03, 2004 at 11:53:55AM +0200, Martin Wilck wrote:
> Why don't you need a do..while loop any more ?
> There is also no loop in __wait_on_bit() in the completed patch series.

Part of the point of filtered waitqueues is to reestablish wake-one
semantics. This means two things:
(a) those waiting merely for a bit to clear with no need to set it,
	i.e. all they want is to know a transition from set to
	clear occurred, are only woken once and don't need to loop
	waking and sleeping
(b) Of those tasks waiting for a bit to clear so they can set it
	exclusively, only one needs to be woken, and after the first
	is woken, it promises to clear the bit again, so there is no
	need to wake more tasks.

These two aspects of wake-one semantics give it highly attractive
performance characteristics.


-- wli
