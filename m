Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTFXVMd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 17:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTFXVMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 17:12:33 -0400
Received: from mail.ithnet.com ([217.64.64.8]:45586 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263185AbTFXVMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 17:12:31 -0400
Date: Tue, 24 Jun 2003 23:26:09 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, willy@w.ods.org, marcelo@conectiva.com.br,
       kpfleming@cox.net, stoffel@lucent.com, gibbs@scsiguy.com,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030624232609.5887c159.skraw@ithnet.com>
In-Reply-To: <20030624174331.GA31650@alpha.home.local>
References: <20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
	<20030611222346.0a26729e.skraw@ithnet.com>
	<16103.39056.810025.975744@gargle.gargle.HOWL>
	<20030613114531.2b7235e7.skraw@ithnet.com>
	<20030624174331.GA31650@alpha.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jun 2003 19:43:31 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> Hi Stephan,
> 
> > Is it possible that the verification errors do not occur because of a read
> > problem, but because of a page cached block getting trashed somehow between
> > "tar to tape" and "read from tape". I would suspect that some blocks
> > survive in memory and are re-used during verification. If for some reason
> > this data is invalid or corrupted the verification fails although the read
> > was correct.
> 
> That seems strange to me, I don't see how we could cache data from a char
> device.

Hello Willy,

sorry, you probably misunderstood my flaky explanation. What I meant was not a
cached block from the _tape_ (obviously indeed a char-type device) but from the
3ware disk (i.e. the other side of the verification). Consider the tape
completely working, but the disk data corrupt (possibly not from real reading
but from corrupted cache).

> It is possible that chkblk and tar don't use same block size and that
> your problem only occurs on larger transfers, or particularly aligned ones.

Very likely not the same block size, with tar I use -b64.
 
> You could try to increase the block size in chkblk to something bigger than a
> page for example. I don't know if tar reads your tape at full speed,

It does. There's no head repositioning.

> but it's
> possible that if it doesn't cope with the tape speed, an overrun occurs and
> something finally gets dropped :-/

Very unlikely, how do you create an overrun in a synchronuos single read
operation?
 
> > I know that this sounds weird, but nevertheless possible, or not?
> > It may even be worse, the data may have also been left from the original
> > nfs action, correct?
> > Is there a way to completely invalidate/flush all cached blocks concerning
> > this fs (besides umount)?
> 
> I don't believe in this. But as Justin says, this card can get very high
> performances and hassle the hardware. Perhaps you have a rare weakness in
> your hardware that only occurs under these conditions, although I don't know
> how this could be checked.

I doubt that. Reason is that though the tape is pretty fast for a tape it is
still pretty slow compared to a disk. Since I use the box for months now I
would have expected such a hardware problem to show up for disk access, too.
And there was none.

> IIRC, you said that it works flawlessly in UP and you need SMP to hit the
> bug. Perhaps your second CPU is sometimes flaky (bad cache, etc...) :-/

Hm, interestingly the former freeze bug (solved by marcelo through backout of
some patch in rc8) did not show up in UP. Since then I did not test UP any
more. The problem itself does not necessarily point to flaky hardware, as I
would have no idea how bad cache can only show up during a tape verification,
that does not sound all that reasonable.
More likely could be a SMP race anywhere from nfs-server, 3ware disk driver to
page cache, or not?

Regards,
Stephan


