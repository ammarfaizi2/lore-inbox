Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288954AbSAUB0O>; Sun, 20 Jan 2002 20:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288957AbSAUB0E>; Sun, 20 Jan 2002 20:26:04 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:1158 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S288954AbSAUBZ6>;
	Sun, 20 Jan 2002 20:25:58 -0500
Message-Id: <5.1.0.14.2.20020121010950.02672870@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 21 Jan 2002 01:28:09 +0000
To: Hans Reiser <reiser@namesys.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Possible Idea with filesystem buffering.
Cc: Matt <matt@progsoc.uts.edu.au>, Rik van Riel <riel@conectiva.com.br>,
        Shawn <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>
In-Reply-To: <3C4B6778.7040509@namesys.com>
In-Reply-To: <Pine.LNX.4.33L.0201201936340.32617-100000@imladris.surriel.com>
 <3C4B3B67.60505@namesys.com>
 <20020121111005.F12258@ftoomsh.progsoc.uts.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
At 00:57 21/01/02, Hans Reiser wrote:
[snip]
 > Would be best if VM told us if we really must write that page.

In theory the VM should never call writepage unless the page must be writen 
out...

But I agree with you that it would be good to be able to distinguish the 
two cases. I have been thinking about this a bit in the context of NTFS TNG 
but I think that it would be better to have a generic solution rather than 
every fs does their own copy of the same thing. I envisage that there is a 
flush daemon which just walks around writing pages to disk in the 
background (there could be one per fs, or a generic one which fs register 
with, at their option they could have their own of course) in order to keep 
the number of dirty pages low and in order to minimize data loss on the 
event of system/power failure.

This demon requires several interfaces though, with regards to journalling 
fs. The daemon should have an interface where the fs can say "commit pages 
in this list NOW and do not return before done", also a barrier operation 
would be required in journalling context. A transactions interface would be 
ideal, where the fs can submit whole transactions consisting of writing out 
a list of pages and optional write barriers; e.g. write journal pages x, y, 
z, barrier, write metadata, perhaps barrier, finally write data pages a, b, 
c. Simple file systems could just not bother at all and rely on the flush 
daemon calling the fs to write the pages.

Obviously when this daemon writes pages the pages will continue being 
there. OTOH, if the VM calls write page because it needs to free memory 
then writepage must write and clean the page.

So, yes, a parameter to write page would be great in this context. 
Alternatively we could have ->writepage and ->flushpage (or pick your 
favourite two names) one being an optional writeout and one a forced 
writeout... I like the parameter to writepage idea better but in the end it 
doesn't really matter that much I would suspect...

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

