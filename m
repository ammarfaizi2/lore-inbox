Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267841AbUJGURg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267841AbUJGURg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 16:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268049AbUJGUPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 16:15:48 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:52413 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267976AbUJGUNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:13:50 -0400
Message-ID: <4165A379.7030706@nortelnetworks.com>
Date: Thu, 07 Oct 2004 14:13:45 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: question on update_wall_time_one_tick()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If we call update_wall_time_one_tick(), with a mode of ADJ_OFFSET_SINGLESHOT, 
the offset can be up to +/-512000 usec.

However, in update_wall_time_one_tick(), the offset adjustment each tick is 
limited to the range of -tickadj < x < tickadj.  On many current systems, 
tickadj is 1.  Thus, a large adjustment takes a *long* time.

While we are doing this offset change, if someone else requests another offset, 
it will totally overwrite any unapplied portion of the offset from the previous 
call:

	/* Changes by adjtime() do not take effect till next tick. */
	if (time_next_adjust != 0) {
		time_adjust = time_next_adjust;
		time_next_adjust = 0;
	}

Thus, doing an offset of +512000, immediately followed by an offset of -512000, 
will leave you with a significant negative offset.

Is this the desired behaviour?

Chris
