Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266731AbTBGWKi>; Fri, 7 Feb 2003 17:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbTBGWKi>; Fri, 7 Feb 2003 17:10:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24581 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266731AbTBGWKg>; Fri, 7 Feb 2003 17:10:36 -0500
Date: Fri, 7 Feb 2003 22:20:12 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: root@chaos.analogic.com, John Bradford <john@grabjohn.com>,
       fdavis@si.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59 : sound/oss/vidc.c
Message-ID: <20030207222012.G30927@flint.arm.linux.org.uk>
Mail-Followup-To: "J.A. Magallon" <jamagallon@able.es>,
	root@chaos.analogic.com, John Bradford <john@grabjohn.com>,
	fdavis@si.rr.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.3.95.1030207152853.31273A-100000@chaos.analogic.com> <20030207215817.GA2092@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030207215817.GA2092@werewolf.able.es>; from jamagallon@able.es on Fri, Feb 07, 2003 at 10:58:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 10:58:17PM +0100, J.A. Magallon wrote:
> 
> On 2003.02.07 Richard B. Johnson wrote:
> > The code seems to want to make the value of new2size a power of
> > 2 and, greater than 128, but less than newsize. It ignores the
> > fact that newsize might be less than 128, maybe this is okay.

Maybe if you looked at the source, you'd have a better idea:

	if (newsize < 208)
		newsize = 208;

So, newsize will always be greater than 208, and therefore greater
than 128.  Also:

	if (newsize > 4096)
		newsize = 4096;

So it can't be larger than 4096.  Then we do this:

	for (new2size = 128; new2size < newsize; new2size <<= 1)
		;

to find a value of new2size which is a power of two.

	if (new2size - newsize > newsize - (new2size >> 1))
		new2size >>= 1;

ie, find the power of two value of new2size which is numerically
closest to newsize.  There probably is a better algorithm for
finding this.

> > But, the code goes on, eventually settling on new2size being
> > less than 4096... hmmm. I'll bet this could be greatly
> > simplified. I think 'new2size' is really something that will
> > fit inside 128-byte groups. Maybe an & or a % will greatly
> > simplify?

You're welcome to provide a solution.  Take into account that shifts
take either 1 (or 0 cycles when combined with another instruction) on
ARM, and modulus is fairly expensive, and this driver is solely for
use on ARM.

Also note that this is an OSS driver for oldish hardware, and the
above has been working fine since 2.2 days.

To be honest, I don't remember too many of the requirements of this
driver at present, (ie, why 208) so since it's known to be working,
I'd suggest leaving it be (adding a comment / reformatting that bit
of code to look less suspicious of course is acceptable.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

