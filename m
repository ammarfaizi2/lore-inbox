Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTEBUsV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 16:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbTEBUsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 16:48:21 -0400
Received: from adedition.com ([216.209.85.42]:45584 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S263173AbTEBUsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 16:48:17 -0400
Date: Fri, 2 May 2003 17:06:48 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: =?iso-8859-1?B?UOVs?= Halvorsen <paalh@ifi.uio.no>,
       bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: sendfile
Message-ID: <20030502210648.GA5322@mark.mielke.cc>
References: <Pine.SOL.4.51.0304302102300.12387@ellifu.ifi.uio.no> <20030430192809.GA8961@outpost.ds9a.nl> <Pine.SOL.4.51.0304302317590.13406@thrir.ifi.uio.no> <20030430221834.GA23109@mark.mielke.cc> <Pine.SOL.4.51.0305010024180.334@niu.ifi.uio.no> <20030501042831.GA26735@mark.mielke.cc> <Pine.SOL.4.51.0305012303540.17001@fjorir.ifi.uio.no> <3EB1A029.7080708@nortelnetworks.com> <20030502024147.GA523@mark.mielke.cc> <3EB1F1CD.4060702@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB1F1CD.4060702@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 12:19:25AM -0400, Chris Friesen wrote:
> According to this:
>   http://asia.cnet.com/builder/program/dev/0,39009360,39062783,00.htm
> using sendfile() is easier on the CPU due to less trashing of the TLB.

Thanks for the link. It looks quite accurate.

One question it raises in my mind, is whether there would be value in
improving write()/send() such that they detect that the userspace
pointer refers entirely to mmap()'d file pages, and therefore no copy
of data from userspace -> kernelspace should be performed. The pages
could be loaded and accessed directly (as they are with sendfile())
rather than generating a page fault to load the pages. The TLB trashing
does not need to occur.

I guess the first response to this question would be 'why not use
sendfile()?  it already exists, and people have already begun to use
it...'

My answer is that I don't like sendfile(). It is not-yet-standard, and
is fairly limited. I could just be naive, but I think that:

     write(fd, mmapped_file_pages, length);

Could be transparently mapped to the sendfile() code in the kernel,
minimizing the benefit of sendfile() having its own system call. It all
comes down to optimization. The current implementation of mmap() is not
optimal where mmap()'d file pages are passed as data to system calls.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

