Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283003AbSAFWBr>; Sun, 6 Jan 2002 17:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbSAFWBh>; Sun, 6 Jan 2002 17:01:37 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:47369 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S283003AbSAFWB1>;
	Sun, 6 Jan 2002 17:01:27 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15416.51411.874019.838220@argo.ozlabs.ibm.com>
Date: Mon, 7 Jan 2002 08:59:47 +1100 (EST)
To: Gabriel Dos Reis <gdr@codesourcery.com>
Cc: mike stump <mrs@windriver.com>, dewar@gnat.com, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <flg05jb4go.fsf@riz.cmla.ens-cachan.fr>
In-Reply-To: <200201061824.KAA19536@kankakee.wrs.com>
	<flg05jb4go.fsf@riz.cmla.ens-cachan.fr>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Dos Reis writes:

> Personnally, I don't have any sentiment against the assembler
> solution.  Dewar said it was unnecessarily un-portable, but that the
> construct by itself *is* already unportable. 

I assume that what we're talking about is using an asm statement like:

	asm("" : "=r" (x) : "0" (y));

to make the compiler treat x as a pointer that it knows nothing about,
given a pointer y that the compiler does know something about.  For
example, y might be (char *)((unsigned long)"foo" + offset).

My main problem with this is that it doesn't actually solve the
problem AFAICS.  Dereferencing x is still undefined according to the
rules in the gcc manual.

Thus, although this would make the problems go away at the moment,
they will come back at some time in the future, e.g. when gcc learns
to analyse asm statements and realises that the asm is just doing
x = y.  I would prefer a solution that will last, rather than one
which relies on details of the current gcc implementation.

Other objections that I have to this solution are:

- it is hard to read; it wouldn't be obvious to someone who doesn't
  know the details of gcc asm syntax what it is doing or why

- it is a statement, which makes it less convenient to use than an
  expression

- it requires an extra dummy variable declaration.

But my main objection is that I don't have any assurance that it
actually solves the problem in a lasting way.

Paul.
