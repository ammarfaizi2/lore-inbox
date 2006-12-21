Return-Path: <linux-kernel-owner+w=401wt.eu-S1423047AbWLUTWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423047AbWLUTWK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423046AbWLUTWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:22:10 -0500
Received: from gw.goop.org ([64.81.55.164]:56991 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423047AbWLUTWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:22:09 -0500
Message-ID: <458ADEDD.8010903@goop.org>
Date: Thu, 21 Dec 2006 11:22:05 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Frederik Deweerdt <deweerdt@free.fr>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] ptrace: make {put,get}reg work again for gs and fs
References: <20061214225913.3338f677.akpm@osdl.org> <20061221183518.GA18827@slug>
In-Reply-To: <20061221183518.GA18827@slug>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt wrote:
> Following the i386 pda patches, it's not possible to set gs or fs value
> from gdb anymore. The following patch restores the old behaviour of
> getting and setting thread.gs of thread.fs respectively.
> Here's a gdb session *before* the patch:
> (gdb) info reg
> [...]
> fs             0x33     51
> gs             0x33     51
> (gdb) set $fs=0xffff
> (gdb) info reg
> [...]
> fs             0x33     51
> gs             0x33     51
> (gdb) set $gs=0xffffffff
> (gdb) info reg
> [...]
> fs             0xffff   65535
> gs             0x33     51
>
> Another one *after* the patch:
> (gdb) info reg
> [...]
> fs             0xd8     216
>   

This doesn't look right.  This is the kernel's %fs, not usermode's
(which should be 0).

> gs             0x33     51
> (gdb) set $fs=0xffff
> (gdb) info reg
> [...]
> fs             0xffff   65535
> gs             0x33     51
> (gdb) set $gs=0xffff
> (gdb) info reg
> [...]
> fs             0xffff   65535
> gs             0xffff   65535
>   
Hm.  This shouldn't be possible since this is a bad selector, but I
guess ptrace/gdb doesn't really know that.  If you run the target (even
single step it), these should revert to 0.

> Andrew, this goes on top of ptrace-fix-efl_offset-value-according-to-i386-pda-changes.patch
> sent by Jeremy yesterday.
>   

Don't think this is quite right yet.  Assuming the %gs->%fs patch has
been applied, then the target %fs should be on its stack, and target %gs
will be in thread.gs.  I'm not sure that thread.fs has any use, but I'd
want to double check vm86 to be sure.

    J
