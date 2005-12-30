Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbVL3UEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVL3UEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 15:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVL3UEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 15:04:47 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:62391 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932264AbVL3UEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 15:04:47 -0500
Subject: [Question] race condition with remove_proc_entry
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 15:04:35 -0500
Message-Id: <1135973075.6039.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm just curious if it is know that remove_proc_entry has an inherit
race condition?  I have a modified kernel that would add and remove
stuff from the proc system and it would every so often crash.  I traced
the bug to remove_proc_entry.

	for (p = &parent->subdir; *p; p=&(*p)->next ) {
		if (!proc_match(len, fn, *p))
			continue;

Looking at proc_match

int proc_match(int len, const char *name, struct proc_dir_entry *de)
{
	if (de->namelen != len)
		return 0;
	return !memcmp(name, de->name, len);
}


The bug would happen either at de->namelen in proc_match or in the loop
of p=&(*p)->next.


The race is if two threads remove two entries that are siblings.  Since
p = &(*p)->next,  and this is then dereferenced, the race is with *p
becoming NULL.

The way I'm fixing this is to put a lock around the call to
remove_proc_entry.  But is this race already known and the solution is
to have the callers perform their own locking?  Or is this an actual
bug?  If it is not a bug, where's the documentation on having callers
protect it?

Thanks,

-- Steve

