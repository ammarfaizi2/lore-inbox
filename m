Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWJNM2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWJNM2m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWJNM2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:28:42 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41121 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932197AbWJNM2l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:28:41 -0400
Subject: Re: [PATCH]: disassociate tty locking fixups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20061014112218.30218.93267.sendpatchset@prarit.boston.redhat.com>
References: <20061014112218.30218.93267.sendpatchset@prarit.boston.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Oct 2006 13:55:09 +0100
Message-Id: <1160830509.5732.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-10-14 am 07:22 -0400, ysgrifennodd Prarit Bhargava:
> Additional tty_mutex locking in do_tty_hangup and disassociate_ctty.  It is
> possible that do_tty_hangup sets current->signal->tty = NULL.  If that
> happens then disassociate_ctty can corrupt memory.

Ugly but I don't think the patches are sufficient. Firstly you need to
hold the task lock if you are poking around some other users ->signal,
or that may itself change. (disassociate_ctty seems to have this wrong)

Secondly you appear to have lock ordering issues (you lock tty_mutex in
both orders relative to the task list lock) (you take tty_mutex first,
then the task lock which is correct, but then you drop and retake the
tty_mutex while holding the task lock, which may deadlock)

Can you also explain why the ctty change proposed is neccessary ?

NAK the actual code, provisionally agree with the basic diagnosis of
insufficient locking.

