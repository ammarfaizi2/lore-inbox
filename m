Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271348AbRHZRX0>; Sun, 26 Aug 2001 13:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271347AbRHZRXR>; Sun, 26 Aug 2001 13:23:17 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:25358 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271348AbRHZRXB>; Sun, 26 Aug 2001 13:23:01 -0400
Content-Type: text/plain;
  charset="utf-8"
From: Daniel Phillips <phillips@bonn-fries.net>
To: pcg@goof.com
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sun, 26 Aug 2001 19:29:43 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0108251752010.5646-100000@imladris.rielhome.conectiva> <20010826013155Z16205-32383+1383@humbolt.nl.linux.org> <20010826044942.G29129@cerebro.laendle>
In-Reply-To: <20010826044942.G29129@cerebro.laendle>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010826172310Z16216-32383+1477@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 26, 2001 04:49 am, pcg@goof.com ( Marc) (A.) (Lehmann ) wrote:
> On Sun, Aug 26, 2001 at 03:38:34AM +0200, Daniel Phillips 
<phillips@bonn-fries.net> wrote:
> > Let's test the idea that readahead is the problem.  If it is, then 
disabling 
> > readahead should make the lowlevel disk throughput match the highlevel 
> > throughput.  Marc, could you please try it with this patch:
> 
> No, I rebooted the machine before your mail and sinc wehtis is a production
> server.. ;)
> 
> Anyway, I compiled and bootet into linux-2.4.8-ac9. I jused ac8 on my
> desktop machines and was not pleased with absolute performance but, unlike
> the linus' series, I can listen to mp3's while working which was the
> killer feature for me ;)

Yes, this probably points at a bug in linus's tree.  This needs more digging.
You're streaming the mp3's over the net or from your disk?

> anyway, AFAIU, one can tune raedahead dynamically under the ac9 series by
> changing:
> 
> isldoom:/proc/sys/vm# cat max-readahead 
> 31
> 
> If this is equivalent to your patch, then fine.

My patch would be equivalent to:

    echo 0 >/proc/sys/vm/max-readahead 

This was just to see if that makes the highlevel throughput match the 
lowlevel throughput, eliminating one variable from the equation.  In -ac you 
have a much more convenient way of doing that.

> if not I will test it at a later time. Now, a question: how does the
> per-block-device read-ahead fit into this picture?  Is it being ignored? I 
> fiddled with it (under 2.4.8pre4) but couldn't see any difference.

It should not be being ignored.  This needs to be looked into.  In any event, 
the max-readahead proc setting is clearly good and needs to be in Linus's 
tree, otherwise changing the default MAX_READAHEAD requires a recompile.  
Worse, there is no way at all to specify the kernel's max-readahead for scsi 
disks - regardless of the fact that scsi disks do their own readahead, the 
kernel will do its own as well, with no way for the user to turn it off.

> [...]
> Now the interesting part. setting read-ahead to 31 again, I increased the
> number of reader threads from one to 64 and got 3.8MB (@450 connections, I
> had to restart the server).
> 
> So the ac9 kernel seems to work much better (than the linus' series),
> although the number of connections was below the critical limit. I'll
> check this when I get higher loads again.

The reason for that is still unclear.  I realize you're testing this under 
live load (you're a brave man) but let's try a bringing the -ac max-readahead 
patch across and try it in 2.4.9.

--
Daniel
