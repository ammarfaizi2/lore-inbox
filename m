Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287731AbSAFFdp>; Sun, 6 Jan 2002 00:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287726AbSAFFdf>; Sun, 6 Jan 2002 00:33:35 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:14609 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287724AbSAFFdZ>;
	Sun, 6 Jan 2002 00:33:25 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15415.57685.984456.586108@argo.ozlabs.ibm.com>
Date: Sun, 6 Jan 2002 16:32:05 +1100 (EST)
To: dewar@gnat.com
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020106042617.E64B0F28BD@nile.gnat.com>
In-Reply-To: <20020106042617.E64B0F28BD@nile.gnat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dewar@gnat.com writes:

> What is important is for these users to *clearly* and at least 
> semi-formally, state their needs. Saying general things about the need
> to be useful is hardly helpful!

Sure, here we go:

* Given an address as an int (of the appropriate size), I need a way
  to construct a pointer, which when dereferenced, will result in the
  CPU presenting that address to the MMU.

* I need a way to tell the compiler not to make any assumptions about
  what objects that such a pointer might or might not point to, so
  that the effect of dereferencing the pointer is simply to access the
  memory at the address I gave, and is not considered "undefined"
  regardless of how I might have constructed the address.

* Given a pointer, I need a way to determine the address (as an int of
  the appropriate size) that the CPU will present to the MMU when I
  dereference that pointer.

GCC already does the first and third, but there doesn't seem to be a
clean and reliable way to do the second.

> I don't think anyone seriously objects to trying to formulate solutions
> to what is indeed a very important problem.

There have been a variety of points of view expressed, and some of
them (not yours) seemed to be saying that it was invalid for a C
program to be trying to manipulate machine addresses at all.

> But it is hardly helpful for people to take the attitude "we wrote this
> kernel, and it worked, and any change to the compiler that stops it from
> working is unacceptable".

No-one has taken that attitude that I have seen.  You may be
interested to know that I am now using -mrelocatable instead of the
RELOC macro.  That solves most of the problems (and cleans up the code
as well) but there are still some instances where I need to relocate a
pointer: specifically, I generate a pointer when running at the
initial address that I need to use when running at the final address.
So I still need to be able to do the type of address arithmetic that,
according to the caveat in the gcc doco, produces an undefined result,
namely taking the address of an object, adding an offset, and storing
the result in a pointer variable that I will dereference later (after
moving the kernel and its data to its final location).

I find it hardly helpful to be told that doing that is invalid without
anyone offering me a valid way to achieve the effect I want - and
no-one has, other than to say that as long as I dereference the
pointer some time later, in a different procedure, it should be fine.
Which is fine from a pragmatic point of view but it doesn't alter the
validity or invalidity of the operation.

Paul.
