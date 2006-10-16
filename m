Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161056AbWJPUdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbWJPUdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 16:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbWJPUdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 16:33:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:61631 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161056AbWJPUdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 16:33:15 -0400
Date: Mon, 16 Oct 2006 13:32:56 -0700
From: Paul Jackson <pj@sgi.com>
To: sekharan@us.ibm.com
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, menage@google.com,
       matthltc@us.ibm.com, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
 configfs
Message-Id: <20061016133256.e09e76ac.pj@sgi.com>
In-Reply-To: <1161025825.6389.119.camel@linuxchandra>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	<20061010203511.GF7911@ca-server1.us.oracle.com>
	<6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	<20061010215808.GK7911@ca-server1.us.oracle.com>
	<1160527799.1674.91.camel@localhost.localdomain>
	<20061011012851.GR7911@ca-server1.us.oracle.com>
	<20061011223927.GA29943@kroah.com>
	<1160609160.6389.80.camel@linuxchandra>
	<20061012235127.GA15767@kroah.com>
	<1161025825.6389.119.camel@linuxchandra>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra wrote:
> As Andrew pointed in one of the email, my patch set reduces the number
> of lines of code in configfs also.

I think Andrew has mentioned this a couple of times ;)

Actually, I've never been particularly happy with the implicit
PAGESIZE limit on these writes.  It's dangerous coding practice to
pass someone a buffer pointer in which they are to write, without
passing a corresponding length.

If it is appropriate for configfs to have some such fixed limit on
file lengths, then that should be a formal part of the API or imposed
in a safer manner than hoping the callback routine doesn't overwrite
a buffer.

Whether or not it should use homebrew code as it does now, or Chandra's
patch to make use of existing infrastructure should be a separate
question.  I think Andrew's observations apply here.

And whether or not we add support for a vector of scalars of the same
type and meaning should be yet another separate question.  No doubt
reasonable minds will differ on this question, though so far that
discussion has been clouded by these other issues.

Greg seems to be suggesting that if we use Chandra's patch, we cannot
impose any length limit, and that this opens the cover to Pandora's
box of all manner of changing and complex output per file.

Well, I could code some pretty ugly output in a single page, if I
set my mind to it.  But it would be rejected, because we've learned
that hurts.

>From that I conclude that it is not the PAGESIZE limit that is saving
us from more unparseable file formats, but the discipline we have
gained from learning the hard way.

Chandra - I haven't looked at seq file lately - could a user of it
such as configfs impose a length limit of its choosing, building on
your patch, without pushing the number of lines of code back above
where it started?

Perhaps, say, we would let the callback routines could push stuff into
a seq file without small limits, but then the configfs code could
truncate that output to a limit of its choosing.  This would impose a
length limit, safely.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
