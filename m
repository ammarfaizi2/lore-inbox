Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279060AbRJ2HrT>; Mon, 29 Oct 2001 02:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279064AbRJ2HrI>; Mon, 29 Oct 2001 02:47:08 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:64521 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S279060AbRJ2HrC>; Mon, 29 Oct 2001 02:47:02 -0500
Date: Mon, 29 Oct 2001 08:47:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.13-ac4
Message-ID: <20011029084736.A3152@suse.cz>
In-Reply-To: <20011028204003.A1640@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011028204003.A1640@lightning.swansea.linux.org.uk>; from laughing@shared-source.org on Sun, Oct 28, 2001 at 08:40:03PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2001 at 08:40:03PM +0000, Alan Cox wrote:

> o	Handle chipsets that dont get 8254 latches	(Roberto Biancardi)
> 	right and trigger the VIA warning in error

This looks good. I've done some investigation myself, and it looks like
on non-VIA chipsets that trigger the problem sometimes the two counter
bytes read from the 8254 get swapped. I've got some indirect evidence
that this also could happen with the original i8254. 

This is a problem per se, because it also does nasty things to the
system clock then. And this is not always detected by the

if (count > LATCH) {}

test. I'd see two solutions for this:

1) Have a better heuristic about what the value read should be and
discard it if it doesn't look good, re-reading, and if it still doesn't
look good, re-programming the chip.

2) Always read the chip at least two times.

By the way, if we made the 8254 accesses (spinlock?) protected (which
should be done anyway, right now definitely more than one CPU can access
the registers at once), I think we could remove the outb(0, 0x43);,
saving some cycles.

-- 
Vojtech Pavlik
SuSE Labs
