Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbTAFAuh>; Sun, 5 Jan 2003 19:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265628AbTAFAuh>; Sun, 5 Jan 2003 19:50:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19727 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265612AbTAFAug>; Sun, 5 Jan 2003 19:50:36 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
Date: 5 Jan 2003 16:58:49 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <avakc9$ct6$1@cesium.transmeta.com>
References: <m3k7hjq5ag.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0301051040020.11848-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0301051040020.11848-100000@home.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> Now, that SYSENTER_CS thing is very rare indeed, and by keeping track of 
> what the previous value was (ie just caching the SYSENTER_CS value in the 
> thread_struct), we could get rid of it with a conditional jump instead. 
> Want to try it?
> 

This seems like the first thing to do.

Dealing with the SYSENTER_ESP issue is a lot tricker.  It seems that
it can be done with a magic EIP range test in the #DB handler, the
range is the part that finds the top of the real kernel stack and
pushfl's to it; the #DB handler if it receives a trap in this region
could emulate this piece of code (including pushing the pre-exception
flags onto the stack) and then invoke the instruction immediately
after the pushf..

Yes, it's ugly, but it should be relatively straightforward, and since
this particular chunk is assembly code by necessity it shouldn't be
brittle.

The other variant (which I have suggested) is to simply state "TF set
in user space is not honoured."  This would require a system call to
set TF -> 1.  That way the kernel already has the TF state for all
processes.

Again, it's ugly.

	-hpa




-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
