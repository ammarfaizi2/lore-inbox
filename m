Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbUKJXcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbUKJXcV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 18:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbUKJXcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 18:32:21 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:48522 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262146AbUKJXb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 18:31:58 -0500
Date: Thu, 11 Nov 2004 00:31:57 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Patrick Mau <mau@oscar.ping.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Workaround for wrapping loadaverage
Message-ID: <20041110233156.GA26502@mail.13thfloor.at>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Patrick Mau <mau@oscar.ping.de>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20041108001932.GA16641@oscar.prima.de> <20041108012707.1e141772.akpm@osdl.org> <20041108102553.GA31980@oscar.prima.de> <20041108155051.53c11fff.akpm@osdl.org> <20041109004335.GA1822@oscar.prima.de> <20041109185103.GE29661@mail.13thfloor.at> <4191BE2D.4060407@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4191BE2D.4060407@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 06:07:25PM +1100, Nick Piggin wrote:
> Herbert Poetzl wrote:
> >On Tue, Nov 09, 2004 at 01:43:35AM +0100, Patrick Mau wrote:
> >
> 
> >>We re-calculate the load every 5 seconds. I think it would be OK to
> >>use more bits/registers, it's not that frequently called.
> >
> >
> >hmm ...
> >
> >	do_timer() -> update_times() -> calc_load()
> >
> >so not exactly every 5 seconds ...
> 
> calc_load() -> messing with LOAD_FREQ -> once every 5 seconds, no?

usually yes ...

> I think doing 32/32 bit calculations would be fine.

agreed ...

> >but I agree that a higher resolution would be a good
> >idea ... also doing the calculation when the number
> >of running/uninterruptible processes has changed would
> >be a good idea ...
> >
> 
> Apart from the problem Con pointed out, you'd need a fancier algorithm
> to calculate load because your interval isn't going to be fixed, so you
> need to factor that in when calculating the area under the 'curve'
> (loadavg).

yes, something like this:

  update_loadavg(uint32_t load, int wsize, int delta, int n)
  {
	unsigned long long calc;

	if (delta >= wsize)
		return (n << FSHIFT);
	calc = (delta * n) << FSHIFT;
	calc += (wsize - delta) * load;
	do_div(calc, wsize);
	return calc;
  }

> I think the good 'ol 5 seconds should be alright.

probably sufficient, yes ...

best,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
