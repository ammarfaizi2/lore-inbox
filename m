Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVDJLej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVDJLej (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 07:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVDJLef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 07:34:35 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36542 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261474AbVDJLeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 07:34:24 -0400
Date: Sun, 10 Apr 2005 13:33:36 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@osdl.org>, andrea@suse.de, mbp@sourcefrog.net,
       linux-kernel@vger.kernel.org, dlang@digitalinsight.com,
       Paul Jackson <pj@engr.sgi.com>
Subject: Re: Kernel SCM saga..
Message-ID: <20050410113336.GA8103@elte.hu>
References: <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz> <1112852302.29544.75.camel@hope> <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org> <1112939769.29544.161.camel@hope> <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org> <20050408083839.GC3957@opteron.random> <Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org> <20050409022701.GA14085@opteron.random> <Pine.LNX.4.58.0504082240460.28951@ppc970.osdl.org> <20050409155511.7432d5c7.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050409155511.7432d5c7.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David S. Miller <davem@davemloft.net> wrote:

> On Fri, 8 Apr 2005 22:45:18 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > Also, I don't want people editing repostitory files by hand. Sure, the 
> > sha1 catches it, but still... I'd rather force the low-level ops to use 
> > the proper helper routines. Which is why it's a raw zlib compressed blob, 
> > not a gzipped file.
> 
> I understand the arguments for compression, but I hate it for one
> simple reason: recovery is more difficult when you corrupt some
> file in your repository.
> 
> It's happened to me more than once and I did lose data.
> 
> Without compression, I might be able to recover if something
> causes a block of zeros to be written to the middle of some
> repository file.  With compression, you pretty much just lose.

that depends on how you compress. You are perfectly right that with 
default zlib compression, where you start the compression stream and 
stop it at the end of the file, recovery in case of damage is very hard 
for the portion that comes _after_ the damaged section. You'd have to 
reconstruct the compression state which is akin to breaking a key.

But with zlib you can 'flush' the compression state every couple of 
blocks and basically get the same recovery properties, at some very 
minimal extra space cost (because when you flush out compression state 
you get some extra padding bytes).

Flushing has another advantage as well: a small delta (even if it 
increases/decreases the file size!) in the middle of a larger file will 
still be compressed to the same output both before and after the change 
area (modulo flush block size), which rsync can pick up just fine. (IIRC 
that is one of the reasons why Debian, when compressing .deb's, does 
zlib-flushes every couple of blocks, so that rsync/apt-get can pick up 
partial .deb's as well.)

the zlib option is i think Z_PARTIAL_FLUSH, i'm using it in Tux to do 
chunks of compression. The flushing cost ismax 12 bytes or so, so if 
it's done every 4K we maximize the cost to 0.2%.

so flushing is both rsync-friendly and recovery-friendly.

(recovery isnt as simple as with plaintext, as you have to find the next 
'block' and the block length will be inevitably variable. But it should 
be pretty predictable, and tools might even exist.)

	Ingo
