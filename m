Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWFPXni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWFPXni (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbWFPXni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:43:38 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:16587 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751553AbWFPXnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:43:37 -0400
Subject: Re: [RFC][PATCH 00/20] Mount writer count and read-only bind
	mounts (v2)
From: Dave Hansen <haveblue@us.ibm.com>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       herbert@13thfloor.at, viro@ftp.linux.org.uk
In-Reply-To: <Pine.LNX.4.63.0606170125110.14464@alpha.polcom.net>
References: <20060616231213.D4C5D6AF@localhost.localdomain>
	 <Pine.LNX.4.63.0606170125110.14464@alpha.polcom.net>
Content-Type: text/plain
Date: Fri, 16 Jun 2006 16:41:58 -0700
Message-Id: <1150501318.7926.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-17 at 01:29 +0200, Grzegorz Kulewski wrote:
> Isn't this some kind of security risk (at least in my planned use)? I mean 
> - for a small fraction of second somebody seeing /dest can write 
> /source... No? 

I assume you're talking about this kind of situation:

mount --bind /local/writable/dir /chroot/untrusted/area/
mount --o remount,ro /chroot/untrusted/area/

Where there is a window where someone in the chroot can write into the
local directory.  Yes.  There would be a race there.

However, you can also do the following, which will have no window.  It
has a few more steps, but it is a much simpler thing to deal with in the
kernel.  Believe me, it starts to get ugly when you try to handle
permission and flag changes at mount time.  Keeping --bind'ing as *just*
a simple "copy the source mount" operation makes the implementation very
much simpler.

This has no r/w window in the chroot area:

mount --bind /local/writable/dir /tmp/area/
mount --o remount,ro /tmp/area/
mount --bind /tmp/area/ /chroot/untrusted/area/
umount /tmp/area/

-- Dave

