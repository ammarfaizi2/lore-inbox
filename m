Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUBYSLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbUBYSLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:11:19 -0500
Received: from uranus.md1.de ([217.160.177.133]:21378 "EHLO uranus.md1.de")
	by vger.kernel.org with ESMTP id S261500AbUBYSLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:11:09 -0500
Date: Wed, 25 Feb 2004 19:10:41 +0100
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, kraxel@bytesex.org
Subject: Re: [ANNOUNCE] new driver for teletext decoder SAA5246A
Message-ID: <20040225181041.GA2446@t-online.de>
References: <20040225113437.GA1824@t-online.de> <20040225041330.51961b28.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225041330.51961b28.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
From: linux@MichaelGeng.de (Michael Geng)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 04:13:30AM -0800, Andrew Morton wrote:
> linux@MichaelGeng.de (Michael Geng) wrote:
> >
> > http://www.michaelgeng.de/linux/saa5246a-2.6.3.patch

Location of the updated patch:

http://www.michaelgeng.de/linux/saa5246a-rev1-2.6.3.patch

> jdelay() is odd - it's a shame it has to fiddle with signals in that
> manner.  Are you sure it's really needed?

I copied this jdelay() stuff from the existing saa5249.c 
without much reflecting about it. 

In my opinion it is up to the user space program to request the 
driver status in reasonable time intervals in order to see if a
requested videotext page has been received. The kernel driver 
should answer without delay. It can't be the task of the kernel
driver to prevent a user space program from querying the status 
10000 times a second.

Conclusion: You are right, the jdelay() stuff is not necessary
at all. I removed it completely from the code. After that I 
tested the newly compiled driver using Martin Buck's vtxget 
program. The command 

time vtxget 100

consumed about 0.4secs sys time before and about 0.5secs after
removing jdelay(). I think this is ok, the driver still works 
fine.

> Also, I suggest you try removing all those `inline' statements.  Then see
> if /usr/bin/size claims that the code shrunk.  Often it does.

No, it doesn't shrink. I already tested that when I developed 
the driver with saa5249.c as a template. Now I made a completely
inline-free version, but /usr/bin/size shows exactly the same
size. By the way, this shows that gcc does a good job. Of course
this could also depend on the architecture, but on my Pentium 4
box gcc really puts the inline parts inline.

There are 2 reason why I used these inline functions:

1. A huge ioctl() function would be more difficult to understand
   than those individual inline functions. Don't you agree?

2. Some of those inline functions are not only specific to the
   SAA5246A. They could also be used for the existing driver to
   the SAA5249 or other drivers of that series. Maybe this could 
   be useful if someone wants to write another driver or even
   in order to merge the SAA5246A and SAA5249 drivers into 1 
   driver. Maybe this is possible, I'm not sure. I would
   like to try, but unfortunately I don't have a SAA5249. Does
   anybody want to sell his sample to me?

Conclusion: I would prefer to keep all those inline functions.
The inline functions are not changed in the updated patch.
			 
> Apart from that, looks fine.  Please send me a copy via email along with a
> suitable changelog for checking into Bitkeeper and copy Gerd Knorr
> <kraxel@bytesex.org>, thanks.

If you want to add the patch, how about the following changelog:

[V4L]: Added new driver for Teletext decoder SAA5246A from Philips

Thank you very much for your help,
Michael

