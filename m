Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTESSHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbTESSHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:07:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36528 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261798AbTESSHX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:07:23 -0400
Date: Mon, 19 May 2003 19:20:16 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix oops in namespace.c
Message-ID: <20030519182016.GG10374@parcelfarce.linux.theplanet.co.uk>
References: <UTC200305182257.h4IMvbe09239.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200305182257.h4IMvbe09239.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 12:57:37AM +0200, Andries.Brouwer@cwi.nl wrote:
> Number four in the series of namespace.c fixes:
> 
> A familar type of Oops: d_path() can return an error ENAMETOOLONG,
> and if we fail to test a segfault occurs.
> 
> So we must test. What we do is a different matter.
> Rather arbitrarily I return the string " (too long)"
> for use in /proc/mounts.

There's a better fix.  Since we are going to use seq_...() anyway,
we both have a buffer and length.  Moreover, if there's not enough
space to store the result, generic seq_file code will take care
about expanding buffer and calling us again.

IOW, we need to add seq_path(seq_file *, vfsmount *, dentry *) that would
DTRT.  That would have a benefit of avoiding extra allocation/freeing.

I'll send such patch in ~20 minutes.  BTW, it's also needed for /proc/swaps
and can be used for /proc/<pid>/maps if we switch it to seq_file (worth
doing anyway).

PS: math.psu.edu account is alive, but I'm not checking it often these
days, so Cc there is not too useful.
