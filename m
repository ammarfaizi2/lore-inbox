Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281129AbRKGXyD>; Wed, 7 Nov 2001 18:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281142AbRKGXxn>; Wed, 7 Nov 2001 18:53:43 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:45830 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S281129AbRKGXxl>;
	Wed, 7 Nov 2001 18:53:41 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111072353.fA7Nrd271036@saturn.cs.uml.edu>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
To: r.post@sara.nl (Remco Post)
Date: Wed, 7 Nov 2001 18:53:39 -0500 (EST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mail List)
In-Reply-To: <200111071235.NAA24809@zhadum.sara.nl> from "Remco Post" at Nov 07, 2001 01:35:14 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remco Post writes:

> the nice thing about text interface as opposed to a struct is that
> the userland can parse a "CPU_FAMILY=6" as good as 0x6, but if you
> decide to change the format of the /proc entry, with a binary
> interface, this means you MUST update the userland as well, while
> with a text interface and some trivial error processing, adding a
> field would in the worst case mean that the userland app will not
> profit from the new info, but it will NOT BREAK.

Add something to /proc/*/status between SigIgn and SigCgt.
Stuff breaks because apps that use SigCgt must simply assume
that it comes after SigIgn due to somebody changing the
way SigCgt gets spelled. (it was SigCat maybe)

I'd expect many apps to have stack overflows if you add stuff.
Sure, you could say that's bad user code, but it happens.

For a binary format, you DO NOT need to update user apps any
more than you would for text. I don't see why people think
this is so hard. Let's design a /proc/*/foo file.

#define FOO_PID 0
#define FOO_PPID 1
#define FOO_PGID 2
#define FOO_SIG_IGN 3
#define FOO_FILENAME 4
#define FOO_STATE 5
#define FOO_VM_LOCKED 6

__u64 foo[7];

Now you want to expand things. Fine. If anything goes from 16 bits
to 32 bits, well, we already have padding for it. Suppose Linus
finally sees the light about signals, adding an extra 64. In that
case, we just add FOO_SIG_IGN_HIGH for the top bits and increase
the array size by one. Old apps don't read that and don't care.
The same goes for FOO_FILENAME, with old apps getting truncation
at 8 bytes and new apps getting truncation at 16 bytes. Now maybe
we decide that FOO_STATE is obsolete -- we all have hyperthreaded
processors that handle thousands of threads and nothing ever blocks.
No problem, just have the kernel supply a dummy value to keep the
old apps happy.
