Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135855AbRDTK11>; Fri, 20 Apr 2001 06:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135858AbRDTK1S>; Fri, 20 Apr 2001 06:27:18 -0400
Received: from nef.ens.fr ([129.199.96.32]:4103 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S135855AbRDTK1F>;
	Fri, 20 Apr 2001 06:27:05 -0400
Date: Fri, 20 Apr 2001 12:27:02 +0200
From: Thomas Pornin <Thomas.Pornin@ens.fr>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Children first in fork
Message-ID: <20010420122701.A17625@bolet.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <9bn90l$anp$1@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <9bn90l$anp$1@penguin.transmeta.com> you write:
> You're probably even better off just intercepting the fork, turning it
> into a clone, and setting the CLONE_PTRACE option.

Actually it is not that simple. The child process will be traced by its
father, not the tracing program. The father must detach from its child
in order to allow the tracing program to attach to the child, and then
you have again the race condition: the child will be untraced for some
time.

The trick is to modify the return address of the call so that the child
and the father loop on the syscall. This way, you can make the father:

-- modify the child so that the child will send itself a SIGSTOP when
released
-- detach itself from the child
(-- if the child is scheduled, it stops itself)
Then the tracing process can attach to the child and handle the
situation.

I have some code almost running, doing that. Well, it works, but with
strange bugs in some occasions. I am still sorting these out. It is
utterly tricky, anyway.


	--Thomas Pornin
