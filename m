Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263979AbSJ3Faz>; Wed, 30 Oct 2002 00:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263986AbSJ3Faz>; Wed, 30 Oct 2002 00:30:55 -0500
Received: from [203.167.79.9] ([203.167.79.9]:782 "EHLO willow.compass.com.ph")
	by vger.kernel.org with ESMTP id <S263979AbSJ3Fay>;
	Wed, 30 Oct 2002 00:30:54 -0500
Subject: Re: [BK updates] fbdev changes updates.
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0210291437050.1363-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0210291437050.1363-100000@maxwell.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1035955910.575.42.camel@daplas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 
Date: 30 Oct 2002 13:32:49 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-30 at 06:38, James Simmons wrote:
> 
> > On Tue, Oct 29, 2002 at 12:45:10PM -0800, James Simmons wrote:
> >  > The reason for this is we will see in the future embedded ix86
> >  > boards with things like i810 framebuffers with NO vga core. In this case
> >  > we will need a fbdev driver for a graphical console. Thus the agp code
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



