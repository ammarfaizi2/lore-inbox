Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbSJ3UtW>; Wed, 30 Oct 2002 15:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264896AbSJ3UtW>; Wed, 30 Oct 2002 15:49:22 -0500
Received: from fmr05.intel.com ([134.134.136.6]:18901 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S264886AbSJ3UtU>; Wed, 30 Oct 2002 15:49:20 -0500
Message-ID: <2B4461BF89BAD511A86100508B66D53804E4FA66@fmsmsx112.fm.intel.com>
From: "Sottek, Matthew J" <matthew.j.sottek@intel.com>
To: "'Antonino Daplas'" <adaplas@pol.net>,
       James Simmons <jsimmons@infradead.org>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: RE: [Linux-fbdev-devel] Re: [BK updates] fbdev changes updates.
Date: Wed, 30 Oct 2002 12:55:32 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I made quite a large effort to work out a mechanism for enabling the i810
before the AGP but I was just never happy with any of the solutions. As
Tony et all mentioned, the cleanest way is to just let the gart driver come
up before the Framebuffer.

 -Matt


-----Original Message-----
From: Antonino Daplas [mailto:adaplas@pol.net]
Sent: Tuesday, October 29, 2002 9:33 PM
To: James Simmons
Cc: Dave Jones; Linux Kernel Mailing List; Linux Fbdev development list
Subject: [Linux-fbdev-devel] Re: [BK updates] fbdev changes updates.


On Wed, 2002-10-30 at 06:38, James Simmons wrote:
> 
> > On Tue, Oct 29, 2002 at 12:45:10PM -0800, James Simmons wrote:
> >  > The reason for this is we will see in the future embedded ix86
> >  > boards with things like i810 framebuffers with NO vga core. In this
case
> >  > we will need a fbdev driver for a graphical console. Thus the agp
code
> >  > must be started before the fbdev layer.
> >
> > Can you explain exactly what the agpgart code is doing that needs
> > to be done earlier than framebuffer ? I don't see any reason for this
> > change. There should be no GART mappings until we've booted userspace
> > (except for the case of IOMMU)
> 
> Best to ask the author of the i810 framebuffer driver. He can tell you his
> need for AGP stuff. I CC.
> 
> 

Hi,

James is right, I have been tackling with this for ages.  I have an
i810  driver (http://i810fb.sourceforge.net) that's been "ready" for
some time now, but never submitted it for kernel inclusion precisely
because of this issue.  

The i810/1815 has no video memory of it's own, except for memory stolen
from system RAM (512 to 1024K).  Unfortunately, entire memory is
accessible only through bank switching and is primarily used for legacy
VGA.  Linear memory is availably only through GART mappings.

I've seen/done/been thinking of the following approaches:

1.  Do custom GART mappings only - abandoned

2.  Fake a linear framebuffer by bank switching the 'stolen memory' -
this idea is by Matt Sottek, but he might have some problems with this

3.  Force loading of agpgart before the console/framebuffer - my current
approach in 2.4

4.  Do custom GART mappings, wait for agpgart to be available, then use
kernel GART mapping routines - my current approach for 2.5

5.  Create a fake framebuffer from System RAM, wait for agpgart to be
loaded, then map the GART - been toying with this idea

The easiest solution for me is to initialize the agpgart ahead of the
framebuffer.  Since I'm not a kernel hacker, I don't really get a clear
picture of the issues involved and I'll be grateful for any input.

Thanks

Tony 





-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
