Return-Path: <linux-kernel-owner+w=401wt.eu-S965270AbXAKBPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965270AbXAKBPW (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 20:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965292AbXAKBPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 20:15:22 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55246
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965270AbXAKBPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 20:15:22 -0500
Date: Wed, 10 Jan 2007 17:15:20 -0800 (PST)
Message-Id: <20070110.171520.23015257.davem@davemloft.net>
To: jafo@tummy.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: select() setting ERESTARTNOHAND (514).
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070111010429.GN7121@tummy.com>
References: <20070110234238.GB10791@tummy.com>
	<20070110.162747.28789587.davem@davemloft.net>
	<20070111010429.GN7121@tummy.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Reifschneider <jafo@tummy.com>
Date: Wed, 10 Jan 2007 18:04:29 -0700

> On Wed, Jan 10, 2007 at 04:27:47PM -0800, David Miller wrote:
> >It gets caught by the return into userspace code.
> 
> Ok, so somehow it is leaking.  I have a system in the lab that is the same
> hardware as production, but it currently has no, you know, hard drives in
> it, so some assembly is required.  I'll see if I can reproduce it in a test
> environment and then see if I can get more information on when/where it is
> leaking.

If you're only seeing it in strace, that's expected due to some
unfortunate things in the way that x86 and x86_64 handle signal
return events via ptrace().

On sparc and sparc64 I fixed this long ago such that ptrace() will
update the user registers before ptrace parents are notified, and
therefore you'll never see those kernel internal error codes.

The upside of this is that you'll really need to see what value is
making it to the application.  What the kernel is probably
doing is looping trying to restart the system call and sending
the signal.  If it's doing that the application is being rewound
to call the system call again once the signal handler returns
(if that is even being run at all).
