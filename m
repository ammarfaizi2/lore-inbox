Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbTKVWkY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 17:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTKVWkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 17:40:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:38886 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262789AbTKVWkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 17:40:23 -0500
Date: Sat, 22 Nov 2003 14:40:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86: SIGTRAP handling differences from 2.4 to 2.6
In-Reply-To: <16319.57610.204577.206796@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0311221435090.2379-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Nov 2003, Paul Mackerras wrote:
>
> In this case the signal would not actually be set to be blocked or
> ignored but would end up being ignored because of the rule that "init
> gets no signals it doesn't want".  I would prefer to see
> thread-synchronous signals kill init if they are not handled, so that
> at least we get a panic with a message that says what went wrong
> rather than the system just spinning its wheels uselessly.

Hmm.. Right now the init special case is in the signal _delivery_ path, 
which makes it hard to do something like that, since by then we no longer 
know/care who sent the signal.

We could move the special case into the send path instead (and then only
do it for "external signals" and not special case init at all for internal
signals).

Hmm.. Looking at the signal sending code, we actually do special-case 
"init" there already - but only for the "kill -1" case. If the test for 
"pid > 1" was moved into "group_send_sig_info()" instead, that would 
pretty much do it, I think.

Feel free to try something like that out. I'm not going to apply it right 
now, though ;)

		Linus

