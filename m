Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVBVL2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVBVL2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 06:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVBVL2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 06:28:08 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:6848 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262270AbVBVL2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 06:28:02 -0500
Date: Tue, 22 Feb 2005 03:26:33 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, raybry@sgi.com, mort@wildopensource.com,
       linux-kernel@vger.kernel.org, hilgeman@sgi.com
Subject: Re: [PATCH/RFC] A method for clearing out page cache
Message-Id: <20050222032633.5cb38abb.pj@sgi.com>
In-Reply-To: <20050222075304.GA778@elte.hu>
References: <20050214154431.GS26705@localhost>
	<20050214193704.00d47c9f.pj@sgi.com>
	<20050221192721.GB26705@localhost>
	<20050221134220.2f5911c9.akpm@osdl.org>
	<421A607B.4050606@sgi.com>
	<20050221144108.40eba4d9.akpm@osdl.org>
	<20050222075304.GA778@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> app designers very frequently think that the VM gets its act wrong (most
> of the time for the wrong reasons),

As Martin wrote, when he submitted this patch:
> The motivation for this patch is for setting up High Performance
> Computing jobs, where initial memory placement is very important to
> overall performance.

Any left over cache is wrong, for this situation.  The only right
answer, no fault of the VM that it can't predict such, is to clear the
past cache and ensure that all allocations are satisfied with node-local
memory, and no page out delays, for all the threads in such tightly
coupled jobs.  These jobs have been sized to use every ounce of CPU and
Memory from sometimes hundreds of nodes, and for hours or days, using
tightly coupled MPI and OpenMP codes.  Any misplaced pages (off the
local node) or paging delays quickly leads to erratic and reduced
performance.

Flushing all the cache like this hurts any normal load that has any
continuity of working set, and such flushing is not cheap.  I have not
observed much interest in doing this, outside of appropriate use when
starting up a big HPC app, as described above, or the test and debug
situations that you mention.  For certain HPC apps, it can be essential
to repeatable job performance.

Granted, this might not be for most systems.  Perhaps a CONFIG option,
so that by default this worked on builds for big honkin numa boxes, but
was an -ENOSYS error on ordinary sized systems?  Though I prefer not to
create artificial distinctions between configurations, without good
reason, perhaps this is such a reason.

Making the API ugly won't reduce its use much, rather just increase code
maintenance costs a bit, and breed a few more bugs.  Those who think
they want this will find a way to do it.  If something's worth doing,
it's worth doing cleanly.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
