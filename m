Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbUASWSU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 17:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUASWSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 17:18:20 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:53676 "EHLO
	omta08.mta.everyone.net") by vger.kernel.org with ESMTP
	id S264339AbUASWSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 17:18:16 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Mon, 19 Jan 2004 14:17:57 -0800 (PST)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: struct task_struct -> task_t
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.187.247]
Message-Id: <20040119221757.411BB3958@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It has come to my attention that in some places in the kernel, 'struct task_struct'
is used; and in others, 'task_t' is used.  Also, 'task_t' is
'typedef struct task_struct task_t;'.

I made a small script to change around as much as I could so that everything uses
task_t, but all the forward declarations make it difficult.  The script doesn't
work as-is, so it will take you a few tries to compile and remove duplicate
declarations of task_t.  If anyone's interested in changing all of these to be
consistent, this is your starting point.

running this in the top level of the source tree should get you started:

for i in `find . -type f`; do echo $i; cat $i | \
sed -e "s/struct task_struct/task_t/g" | \
sed -e "s/^\s*task_t;/struct task_struct;\ntypedef struct task_struct task_t;/g" \
> /tmp/tmpkernel; \
cat /tmp/tmpkernel > $i; rm /tmp/tmpkernel; done; \
cat include/linux/sched.h | \
sed -e "s/typedef task_t task_t/typedef struct task_struct task_t/g" | \
sed -e "s/task_t {/struct task_struct {/g" > /tmp/tmpkernel; \
cat /tmp/tmpkernel > include/linux/sched.h; rm /tmp/tmpkernel


That should also switch the forward declarations of struct task_struct over to
'struct task_struct; typedef struct task_struct task_t;' pairs.  This leaves a few
holes, as there are some places where the typedef occurs after one has already
occured, and so these need to be fixed.

I am only able to deal with i386, and there's a lot of stuff in the asm includes
that needs to be adjusted by hand after running the above script.

_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
