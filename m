Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265172AbSJWTo4>; Wed, 23 Oct 2002 15:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265175AbSJWTox>; Wed, 23 Oct 2002 15:44:53 -0400
Received: from almesberger.net ([63.105.73.239]:51206 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265172AbSJWTou>; Wed, 23 Oct 2002 15:44:50 -0400
Date: Wed, 23 Oct 2002 16:50:09 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Cc: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>
Subject: Re: 2.4 Ready list - Kernel Hooks
Message-ID: <20021023165009.I1421@almesberger.net>
References: <OF4A3346AB.B9CBFE3E-ON80256C5B.005B118D@portsmouth.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF4A3346AB.B9CBFE3E-ON80256C5B.005B118D@portsmouth.uk.ibm.com>; from richardj_moore@uk.ibm.com on Wed, Oct 23, 2002 at 05:47:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard J Moore wrote:
>>EXPORT_SYMBOL_GPL.
> 
> We already do that.

Oops, missed that one, sorry ! I was looking at the interface
functions, but making the hooks themselves GPL-only is even
better.

> I don't envisage having an arbitrary set of hook points scattered
> throughout the kernel.

Let's hope you're right :-)

But wouldn't a small extension of kprobes get you pretty much
the same functionality/performance:

- at busy attachment points, add a "kprobe anchor", which
  translates to five NOPs [1,2], preceded by a global symbol
- when setting a kprobe, check if the five bytes starting
  at p->addr are NOPs [3]
- if yes, insert a call to kprobes_fastpath. if not, use
  the current double breakpoint mechanism
- kprobes_fastpath can just return to the caller, no code
  modification or single-stepping required

[1] Assuming i386.
[2] Or any sufficiently unlikely sequence of instructions that
    executes faster than NOPs.
[3] Or some other pattern - but a quick look at the kernel binary
    suggests that all strings of five or more NOPs are used for
    padding between function, so it would be safe to assume that
    any such sequence is a basic block.

The advantage over hooks would be that users of this mechanism
wouldn't have to choose between fast but intrusive (hooks) and
slow but flexible (probes).

Now, it's non-trivial to do a "return from caller" with
[kd]probes. I haven't looked at that part yet. Do you have the
infrastructure for this ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
