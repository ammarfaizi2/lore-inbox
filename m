Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbTESHHU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 03:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTESHHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 03:07:20 -0400
Received: from zok.SGI.COM ([204.94.215.101]:17072 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261846AbTESHHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 03:07:19 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: garbled oopsen 
In-reply-to: Your message of "Wed, 07 May 2003 18:05:30 MST."
             <20030507180530.23d0e780.rddunlap@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 19 May 2003 17:20:06 +1000
Message-ID: <20628.1053328806@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003 18:05:30 -0700, 
"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>I have several oopses that are garbled.  Part of the problem is that
>page fault code (x86: arch/i386/mm/fault.c) does not attempt to
>serialize the "Unable to handle kernel ... at virtual address ..."
>messages, since it's considered better to get _some_ messages out
>than no messages.  (and serialize it with what?)
>
>However, after untwisting these, I can tell you that unraveling
>them is not fun.
>
>Can these be cleaned up in any reasonable way?
>Any suggestions?

kdb_printf() has this:

        /* Serialize kdb_printf if multiple cpus try to write at once.
         * But if any cpu goes recursive in kdb, just print the output,
         * even if it is interleaved with any other text.
         */
        if (!KDB_STATE(PRINTF_LOCK)) {
                KDB_STATE_SET(PRINTF_LOCK);
                spin_lock(&kdb_printf_lock);
        }
	....
        if (KDB_STATE(PRINTF_LOCK)) {
                spin_unlock(&kdb_printf_lock);
                KDB_STATE_CLEAR(PRINTF_LOCK);
        }

KDB_STATE() is a per-cpu set of flags, PRINTF_LOCK indicates if this
cpu has got or is trying to get the kdb_printf_lock.  I get no
interleave problems, except when somebody prints a line in multiple
calls to kdb_printf(), the fragments are printed as one chunk but the
individual fragments can be interleaved.

