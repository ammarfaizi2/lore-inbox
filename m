Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTDSUZM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 16:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbTDSUZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 16:25:12 -0400
Received: from mail.ithnet.com ([217.64.64.8]:43530 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263452AbTDSUZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 16:25:10 -0400
Date: Sat, 19 Apr 2003 22:23:48 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Christian Vogel <vogel@skunk.physik.uni-erlangen.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ISDN massive packet drops while DVD burn/verify
Message-Id: <20030419222348.0d899998.skraw@ithnet.com>
In-Reply-To: <20030419205000.A3541@skunk.physik.uni-erlangen.de>
References: <20030416151221.71d099ba.skraw@ithnet.com>
	<Pine.LNX.4.44.0304161056430.5477-100000@chaos.physics.uiowa.edu>
	<20030419193848.0811bd90.skraw@ithnet.com>
	<20030419205000.A3541@skunk.physik.uni-erlangen.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Apr 2003 20:50:00 +0200
Christian Vogel <vogel@skunk.physik.uni-erlangen.de> wrote:

> Hi Stephan,
> 
> On Sat, Apr 19, 2003 at 07:38:48PM +0200, Stephan von Krawczynski wrote:
> > > My best guess would be that IDE blocks IRQs for too long and hisax 
> > > interrupts get lost. You could try whether hdparm -u1 helps, and a 
> > > debugging log from the hisax driver may confirm over/underruns.
> 
> > I don't buy that explanation. Reason is simple: during this all network
> > connections work flawlessly, and they do have quite a lot of interrupts
> > compared to ISDN. ISDN is so slow and has so few interrupts that it is
> > quite unlikely in a SMP-beyond-GHz-limit box that you loose some. The
> > ancient hardware days are long gone ...
> 
> I would. At least try it. Network connections are not subject to smaller
> delays, ISDN on the other hand depends on a synchronous processing of the
> data (it's like a sync serial port after all...). It's not important how
> fast your CPU is if it's just doing nothing while waiting for your
> harddisk...

First: we are not talking about harddisks by any means.

Second: if it is doing _nothing_ while waiting for ide-whatever, then it is
presumably also not updating my mouse position or performing anything else
useful. This is _not_ the case here.

Third: a full-blown (1 channel) ISDN-download has around 8kBytes/sec of data.
The worst chipsets ever will create around 250 interrupts/sec for this (32 byte
fifo per hdlc-chunk). Don't count on the exact number, it may be some few more
than 250, but not a lot. This may have been a problem on very old boxes from
some years back, but for sure not on todays GHz monsters. You can only kill it
by completely braindead interrupt programming, which - I honor Alans' IDE stuff
quite a lot - I do not presume existing somewhere inside the current kernel.

Forth: There are parts in the ISDN code like:

static int
isdn_writebuf_stub(int drvidx, int chan, const u_char * buf, int len,
                   int user)
{
        int ret;
        int hl = dev->drv[drvidx]->interface->hl_hdrlen;
        struct sk_buff *skb = alloc_skb(hl + len, GFP_ATOMIC);

        if (!skb)
                return 0;


Used here:
		lock_kernel();
		...

                while (isdn_writebuf_stub(drvidx, chidx, buf, count, 1) != count)
                        interruptible_sleep_on(&dev->drv[drvidx]->snd_waitq[chidx]);


Which basically means we are looping around for some mem without telling anybody... or not?
This is probably not a very good example of what I mean, but nevertheless ...

> I would recommend doing /sbin/hdparm -u1 -c1 -d1 /dev/hda which makes
> all systems I know more performant and better responding.

You cannot issue that command to a DVD-writer used with ide-scsi.

> 
> 	Chris
> 
> -- 
> The code was willing,
> It considered your request,
> But the chips were weak.
> -- Barry L. Brumitt
> 

Regards,
Stephan


