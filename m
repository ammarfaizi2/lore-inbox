Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265875AbUAEDuC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 22:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265874AbUAEDt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 22:49:58 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:35975 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265875AbUAEDtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 22:49:53 -0500
Date: Mon, 5 Jan 2004 09:25:18 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: daniel@osdl.org, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.1-rc1-mm1] aiodio_fallback_bio_count.patch
Message-ID: <20040105035518.GA3302@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20031231021042.5975de04.akpm@osdl.org> <20031231104801.GB4099@in.ibm.com> <20031231025309.6bc8ca20.akpm@osdl.org> <20031231025410.699a3317.akpm@osdl.org> <20031231031736.0416808f.akpm@osdl.org> <1072910061.712.67.camel@ibm-c.pdx.osdl.net> <1072910475.712.74.camel@ibm-c.pdx.osdl.net> <20031231154648.2af81331.akpm@osdl.org> <20040102051422.GB3311@in.ibm.com> <20040101234634.53b69a3b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040101234634.53b69a3b.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 11:46:34PM -0800, Andrew Morton wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >
> >  Does the following sound better as complete description ?
> 
> It does, thanks.  But it does not shed a lot of light on the filemap.c
> changes - what's going on there?
> 
> What is the significance of `written > count' in there, and of `dio->result
> > dio->size' in finished_one_bio()?  How can these states come about?
> 

Both of these are checks to determine whether all or only a part of
the request was serviced by DIO, leaving the rest to be serviced by
falling back to buffered I/O.

Earlier, we would decide this based on whether dio->result == -ENOTBLK
and written == -ENOTBLK respectively. However, now that we also need the 
result to indicate how much actually got written even in -ENOTBLK case, 
so that we can issue buffered i/o only for the remaining part of the request,
dio->result and written had to be modified to reflect the number of bytes 
transferred by DIO even for the fallback to buffered i/o case. 
So we need checks like this to find out whether there is some i/o left
to be issued via buffered i/o.

If dio->result == dio->size, then the entire request has been handled
by DIO and we don't have to bother about falling back to buffered i/o.
Otherwise, even for AIO, need to force a wait for the part of the
request already issued.

If written == count, then the entire request has been handled by DIO;
otherwise, if written < count, it means that we need to fallthrough to
buffered i/o for the remaining bytes.

What about short writes ? Most real errors during DIO write are 
reflected in the return value directly, so we should be OK (Worst case 
we'd end up with an additional but harmless attempt via buffered i/o,  
however, I didn't spot a case where that would actually occur).

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

