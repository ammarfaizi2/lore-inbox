Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbUAEFXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 00:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbUAEFXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 00:23:22 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:23498 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264488AbUAEFXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 00:23:20 -0500
Date: Mon, 5 Jan 2004 10:58:46 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: daniel@osdl.org, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.1-rc1-mm1] aiodio_fallback_bio_count.patch
Message-ID: <20040105052846.GA3810@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20031231025309.6bc8ca20.akpm@osdl.org> <20031231025410.699a3317.akpm@osdl.org> <20031231031736.0416808f.akpm@osdl.org> <1072910061.712.67.camel@ibm-c.pdx.osdl.net> <1072910475.712.74.camel@ibm-c.pdx.osdl.net> <20031231154648.2af81331.akpm@osdl.org> <20040102051422.GB3311@in.ibm.com> <20040101234634.53b69a3b.akpm@osdl.org> <20040105035518.GA3302@in.ibm.com> <20040104210642.2b94038f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104210642.2b94038f.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 09:06:42PM -0800, Andrew Morton wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >
> > > What is the significance of `written > count' in there, and of `dio->result
> >  > > dio->size' in finished_one_bio()?  How can these states come about?
> >  > 
> > 
> >  Both of these are checks to determine whether all or only a part of
> >  the request was serviced by DIO, leaving the rest to be serviced by
> >  falling back to buffered I/O.
> > 
> >  Earlier, we would decide this based on whether dio->result == -ENOTBLK
> >  and written == -ENOTBLK respectively. However, now that we also need the 
> >  result to indicate how much actually got written even in -ENOTBLK case, 
> >  so that we can issue buffered i/o only for the remaining part of the request,
> >  dio->result and written had to be modified to reflect the number of bytes 
> >  transferred by DIO even for the fallback to buffered i/o case. 
> >  So we need checks like this to find out whether there is some i/o left
> >  to be issued via buffered i/o.
> 
> Sure.  But the generic_file_aio_write_nolock() code is doing this:
> 
> 		if (written >= count && !is_sync_kiocb(iocb))
> 			written = -EIOCBQUEUED;
> 		if (written < 0 || written >= count)
> 			goto out_status;
> 
> 
> Under what circumstances can `written' (the amount which was written) be
> greater than `count' (the amount to write)?

None. The '>' situation should never occur.

This is just being explicit about covering the "not less than" case
as a whole, and making sure we do not fall through to buffered i/o in
that case, i.e its the same as:
if (!(written < count) && !is_sync_kiocb(iocb))

Is that any less confusing ? Or would you rather just replace the '>=" by
"=='.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

