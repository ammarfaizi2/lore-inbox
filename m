Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265647AbRFWGBw>; Sat, 23 Jun 2001 02:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265649AbRFWGBm>; Sat, 23 Jun 2001 02:01:42 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:42244 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S265647AbRFWGBa>; Sat, 23 Jun 2001 02:01:30 -0400
Date: Sat, 23 Jun 2001 18:01:26 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Dag Wieers <dag@wieers.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Should __FD_SETSIZE still be set to 1024 ?
Message-ID: <20010623180126.A4755@metastasis.f00f.org>
In-Reply-To: <20010623034849.A3728@metastasis.f00f.org> <Pine.LNX.4.33.0106221811020.27761-100000@horsea.3ti.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0106221811020.27761-100000@horsea.3ti.be>; from dag@wieers.com on Fri, Jun 22, 2001 at 06:25:41PM +0200
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2001 at 06:25:41PM +0200, Dag Wieers wrote:

    So if someone wants to increase it for an application he needs to
    be sure that everything that it is linked with is compiled with a
    similar __FD_SETSIZE ?

Well... only things that care about __FD_SETSIZE :)
    
    Why can you safely increase the value in Squid then ?

Because it has been tested and works. I assume libc doesn't care is
this value is increased, not sure about other libraries.

Using libc5 and linux 2.1.9x + scts large-fd patch (which got merged
in later kernels), I manged to work with 100K FDs without too many
problems.

The defintion of 'fd_set' changes with __FD_SETSIZE, so anything
makes these kind of assumptions might break.

For example, if you have some code which assumes this is 1024 and you
try to copy a value into a preallocated array of structure it
defined, then it will break.

So will precompiled code such as:

struct cookie {
	int	type;
	fd_set	chocolate_feeds;
	int	cc_count;
}monster;

sort of thing; because fd_set's size will be wrong.

    Yes, but still, why 1024 ?

Because thats what is has been for a very long time, a safe default.

If your application knows better, it can change it.

    No, squid takes the lowest of both (FD_SETSIZE and SQUID_MAXFD)
    in main.c.  And the Squid configure gets the FD_SETSIZE value
    from linux/posix_types.h ;(

Really? I though for the last couple of years squid would use poll
over select anyhow?
    
    I'm still not convinced that something might break, since everybody
    advices to increase __FD_SETSIZE before compiling Squid.

So do it then.
    
    And if linux/posix_types.h defines the limit of open file
    descriptors of the system, 1024 is (IMO) a wrong number. But then
    again, nobody bothered to change it...

Because 1024 works everywhere, a large or smaller value might not.



  --cw
