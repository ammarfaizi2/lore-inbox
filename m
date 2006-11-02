Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWKBUxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWKBUxJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 15:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWKBUxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 15:53:09 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:18305
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750838AbWKBUxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 15:53:06 -0500
From: Rob Landley <rob@landley.net>
To: Ian Kent <raven@themaw.net>
Subject: Re: Problems with /proc/mounts and statvfs (implementing df).
Date: Thu, 2 Nov 2006 15:53:01 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200610281537.07145.rob@landley.net> <Pine.LNX.4.64.0611021804290.15477@raven.themaw.net>
In-Reply-To: <Pine.LNX.4.64.0611021804290.15477@raven.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611021553.01463.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 November 2006 5:07 am, Ian Kent wrote:
> On Sat, 28 Oct 2006, Rob Landley wrote:
> 
> > I'm trying to implement a df command that works based on /proc/mounts and 
> > statvfs.  To make this work, I need to be able to detect duplicate mounts 
> > (including --bind mounts), and I need to be able to detect overmounted 
> > filesystems.
> 
> I need to do quite a bit with mount tables in autofs.
> You may wish to look at lib/mounts.c in autofs version 5.

I've fiddled with this area before (I wrote the current BusyBox mount 
command), and after a day or so of banging on it I did eventually get it to 
work.

It turns out that statvfs.f_fsid is completely useless.  What you need to do 
is a normal stat() on each path from /proc/mounts and look at the st_dev 
member, which turns out to be unique for each mounted filesystem (including 
tmpfs and /proc and /sys).  So this lets you identify unique filesystems, and 
then detecting --bind mounts and overmounts is just a question or matching up 
the st_dev values.

The remaining question was, when there are multiple mount points statting to 
the same st_dev, which one's path should df display for that filesystem when 
you do a normal "df"?  What I did is for each unique st_dev, look at the last 
entry in /proc/mounts, find its block device string (returned by getmntent() 
as mnt_fsname), and then back up to find the first entry with both the same 
st_dev and the same block device string.  Display that one, dump the rest.  
(If it had a different block device it was an overmounted filesystem.  If it 
had the same block device but wasn't the first occurence, it was either a 
duplicate mount or a --bind mounts.)

> Current state of play can be found in files located at
> http://www.kernel.org/pub/linux/daemons/autofs/v5.

In my case "http://landley.net/code/toybox/download/toybox-0.0.1.tar.bz2", 
which is at best "embryonic" but if you do "make && mv toybox df && ./df" 
that one command should work.  (It's got a loooooooong way to go, I know...)

Rob
-- 
"Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away." - Antoine de Saint-Exupery
