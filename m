Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbTEBCXa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 22:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbTEBCXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 22:23:30 -0400
Received: from adedition.com ([216.209.85.42]:1036 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S262869AbTEBCX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 22:23:29 -0400
Date: Thu, 1 May 2003 22:41:47 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: =?iso-8859-1?B?UOVs?= Halvorsen <paalh@ifi.uio.no>,
       bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: sendfile
Message-ID: <20030502024147.GA523@mark.mielke.cc>
References: <Pine.LNX.4.51.0304301604330.12087@sondrio.ifi.uio.no> <20030430165103.GA3060@outpost.ds9a.nl> <Pine.SOL.4.51.0304302102300.12387@ellifu.ifi.uio.no> <20030430192809.GA8961@outpost.ds9a.nl> <Pine.SOL.4.51.0304302317590.13406@thrir.ifi.uio.no> <20030430221834.GA23109@mark.mielke.cc> <Pine.SOL.4.51.0305010024180.334@niu.ifi.uio.no> <20030501042831.GA26735@mark.mielke.cc> <Pine.SOL.4.51.0305012303540.17001@fjorir.ifi.uio.no> <3EB1A029.7080708@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EB1A029.7080708@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 06:31:05PM -0400, Chris Friesen wrote:
> Pål Halvorsen wrote:
> >As far as i understand mmap/send, you'll have a copy operation in the
> >kernel here. mmap shares the kernel and user buffer, but when sending the
> >packet data is copied to the socket buffer!!??
> Yes, there is a copy there.

As far as I understand, sendfile() still requires the data to get from the
disk to a page in memory, similar to how send() referencing an mmap()'d page
may cause a page fault, reading the data from disk to a page in memory. One
copy each. I don't know of a kernel interface that lets data be copied from
disk to ethernet card without involving a temporary copy to be in paged
memory at some point in time... perhaps the iSCSI stuff can do this? I dunno.

Somebody else pointed out that mmap() may not yet be implemented completely
optimally. I will have to look at the code before I continue to make my
'in theory' comments, however the following 'NOTE' in the manpage for sendfile
makes me suspect that sendfile() is very similar to mmap()/write():

       -- CUT --
       Presently the descriptor from which data is read cannot correspond to a
       socket, it must correspond to a file which supports mmap()-like  opera-
       tions.
       -- CUT --

> >OK, but I understand that my streaming scenario is not the target
> >application for sendfile.
> What stops you from using sendfile (with TCP) to each destination 
> separately, with the client only reading from the pipe as needed 
> (presumably with a number of frames worth of buffer on the client side)?

TCP isn't very well suited for video feeds. First, it is streamed, which
makes it a little annoying to ensure that only whole frames get through.
Second, its acknowledgement scheme prefers reliability over low latency.

I'm hoping for good things from SCTP. From what I've read, it looks as
if it should provide a compromise between TCP and UDP that is quite
optimal.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

