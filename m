Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTKPH11 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 02:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbTKPH11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 02:27:27 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:28296 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S262111AbTKPH1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 02:27:25 -0500
Date: Sun, 16 Nov 2003 07:27:23 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Harald Welte <laforge@netfilter.org>, <linux-kernel@vger.kernel.org>
Subject: Re: seq_file and exporting dynamically allocated data
In-Reply-To: <Pine.LNX.4.44.0311152135370.743-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.44.0311160717250.765-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

I remembered the other two areas where, maybe, seq API can be slightly 
improved:

a) no "THIS_MODULE" style module refcounting, so I had to do manual 
MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT in ->open/release. I am aware of the 
deficiencies of this approach, of course (it's been discussed too many 
times in the last several years).

b) no way to reset the 'offset' to 0 when the ->next() detects that it is
back at the head of linked list, i.e. when it should return NULL. It's OK
for a user app to detect that (e.g. check proc->pid == 0 thus it's a
"swapper"  and so the beginning of the next chunk of processes) but it
also has to issue lseek(fd, 0, SEEK_SET), otherwise the offsets will keep
growing larger and larger and the kernel has to loop around that list (in
->start() when it tries to walk a set distance from the head) many times
unnecessarily and so the performance goes down. I tried doing something
like this:

  m->index = m->count = m->from = *ppos = 0;

in the ->next() function whenever it detects that the 'next' element is 
'init_task' but it didn't help. And I understand why, i.e. read(2) really 
is supposed to increment the offset correctly, so what I require would 
break the normal Unix read(2) semantics. So, maybe forcing user app to 
issue lseek(fd, 0, SEEK_SET) is the only sensible solution... If you have 
better ideas, please let me know.

Kind regards
Tigran

