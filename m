Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271679AbRHUN6G>; Tue, 21 Aug 2001 09:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271677AbRHUN57>; Tue, 21 Aug 2001 09:57:59 -0400
Received: from dialin-212-144-144-101.arcor-ip.net ([212.144.144.101]:47856
	"EHLO merv") by vger.kernel.org with ESMTP id <S271674AbRHUN5m>;
	Tue, 21 Aug 2001 09:57:42 -0400
Date: Tue, 21 Aug 2001 15:55:41 +0200
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Nicholas Knight <tegeran@home.com>, Adrian Cox <adrian@humboldt.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
Message-ID: <20010821155541.A1158@bombe.modem.informatik.tu-muenchen.de>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Nicholas Knight <tegeran@home.com>,
	Adrian Cox <adrian@humboldt.co.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1010817152158.4584B-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2001 at 03:30:47PM -0400, Richard B. Johnson wrote:
> We've established no such thing. In fact, you can't properly initialize
> SDRAM memory without writing something to it. Further, reading SDRAM
> after a power-on or a reset, will result in all 1s (0xffffffff) because
> the SDRAM controller isn't even connected to the RAM. Further, in the
> process of connecting it up (logically), the lowest 15 bits of all
> SDRAM commands will end up being written to every chip. With SDRAM,
> data are normally clocked in/out, once the precharge command is
> executed, it's not even clocked. It works like this:

You keep referring to some unspecified SDRAM controller.  The
interesting part however is the SDRAM itself.

> (1) Put a memory controller command in a controller register.

Don't you probably mean a SDRAM command to be sent out by the
controller?

> (2) Attempt to write RAM (anywhere), that makes the controller read
>     and acccept the command.

That's just controller specific then.  It seems made to be
accessed from a CPU, which has just the limited "address & read/write"
interface.

The write obviously just triggers the command sequence but does no real
write.  It can't do a real write since that's illegal with no open
banks.  There are controllers with dedicated command inputs requiring no
write trigger, but these aren't meant to be directly connected to a CPU.

> (3) Continue with all commands. The last enables refresh.

That's your controller.  The recommended SDRAM powerup sequence is:

1. Apply power and start clock. Attempt to maintain a NOP condition at
   the inputs.
2. Maintain stable power, stable clock, and NOP input conditions for a
   minimum of 200 uS.
3. Issue precharge commands for all banks of the device.
4. Issue 8 or more autorefresh commands.
5. Issue a mode register set command to initialize the mode register.

That's all.  The controller has to be configured to work with the values
written to the mode registers, of course, but that is a separate issue.

There is no intentional data erasing in the configuration sequence
outlined above.  Missing refresh may lose some data and precharge all
banks may write back wrong data to the rows in question.  Whether the
firmware then sets out to clear RAM contents or not is the question
worth looking at, AFAIR the PC BIOS may or may not, there is no
standard.

-- 
Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
