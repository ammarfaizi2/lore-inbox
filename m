Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUD3MSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUD3MSP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 08:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265167AbUD3MSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 08:18:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38808 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262418AbUD3MSM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 08:18:12 -0400
Date: Fri, 30 Apr 2004 09:19:25 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Henrik Persson <nix@syndicalist.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA VT82C686 AC97 hickup
Message-ID: <20040430121925.GA21667@logos.cnet>
References: <1079969375.1042.6.camel@vega>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079969375.1042.6.camel@vega>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 04:29:36PM +0100, Henrik Persson wrote:
> Hi.
> 
> For a month or two I've been experiencing some trouble with the VIA AC97
> sound card attached to my motherboard.. The machine in question is
> running smoothly and playing mp3s and movies and then all of a sudden
> (usually when it has been on for about 10 days or so) this will flood
> dmesg and /var/log/messages:
> 
> Mar 22 16:22:43 eurisco kernel: Assertion failed! chan->is_active ==
> sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1388
> 
> Any ideas?

I'm always seeing this too in my box (which is running 2.6.0).

Jeff, Alan, the assert seem erroneous?

/**
 *      via_chan_maybe_start - Initiate audio hardware DMA operation
 *      @chan: Channel whose DMA is to be started
 *
 *      Initiate DMA operation, if the DMA engine for the given
 *      channel @chan is not already active.
 */
                                                                                      
static inline void via_chan_maybe_start (struct via_channel *chan)
{
        assert (chan->is_active == sg_active(chan->iobase));

and

static int sg_active (long iobase)
{
        u8 tmp = inb (iobase + VIA_PCM_STATUS);
        if ((tmp & VIA_SGD_STOPPED) || (tmp & VIA_SGD_PAUSED)) {
                printk(KERN_WARNING "via82cxxx warning: SG stopped or paused\n");
                return 0;
        }
        if (tmp & VIA_SGD_ACTIVE)
                return 1;
        return 0;
}

The driver works normally, even with the assert happening:

via_audio: ignoring drain playback error -11
via_audio: ignoring drain playback error -11
via_audio: ignoring drain playback error -11
Assertion failed! chan->is_active == sg_active(chan->iobase),sound/oss/via82cxxx _audio.c,via_chan_maybe_start,line=1388
Assertion failed! chan->is_active == sg_active(chan->iobase),sound/oss/via82cxxx _audio.c,via_chan_maybe_start,line=1388
Assertion failed! chan->is_active == sg_active(chan->iobase),sound/oss/via82cxxx _audio.c,via_chan_maybe_start,line=1388
Assertion failed! chan->is_active == sg_active(chan->iobase),sound/oss/via82cxxx _audio.c,via_chan_maybe_start,line=1388
Assertion failed! chan->is_active == sg_active(chan->iobase),sound/oss/via82cxxx _audio.c,via_chan_maybe_start,line=1388
Assertion failed! chan->is_active == sg_active(chan->iobase),sound/oss/via82cxxx _audio.c,via_chan_maybe_start,line=1388
via_audio: ignoring drain playback error -11
via_audio: ignoring drain playback error -11



